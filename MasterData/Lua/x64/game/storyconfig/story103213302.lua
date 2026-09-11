return {
	Play321332001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321332001
		arg_1_1.duration_ = 8

		local var_1_0 = {
			zh = 6.8,
			ja = 8
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
				arg_1_0:Play321332002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L11f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L11f")
				var_4_0.name = "L11f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L11f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L11f

				arg_1_1.bgs_.L11f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L11f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = 2
			local var_4_16 = 0.45

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(321332001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 18 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 18)

				if (18 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 18)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332001", "story_v_out_321332.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_321332", "321332001", "story_v_out_321332.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_321332", "321332001", "story_v_out_321332.awb")

						arg_1_1:RecordAudio("321332001", var_4_23)
						arg_1_1:RecordAudio("321332001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321332", "321332001", "story_v_out_321332.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321332", "321332001", "story_v_out_321332.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play321332002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321332002
		arg_9_1.duration_ = 7

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321332003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_9000

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_0 = arg_9_1.var_.effectzhendang2

				if not arg_9_1.var_.effectzhendang2 then
					var_12_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_12_0.name = "zhendang2"
					arg_9_1.var_.effectzhendang2 = var_12_0
				else
					var_12_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_12_0.transform.localPosition = Vector3.New(-1.1, 0.69, 1.96)
				var_12_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.766666666666667 < arg_9_1.time_ and arg_9_1.time_ <= 0.766666666666667 + arg_12_0 then
				if arg_9_1.var_.effectzhendang2 then
					Object.Destroy(arg_9_1.var_.effectzhendang2)

					arg_9_1.var_.effectzhendang2 = nil
				end
			end

			if 1 < arg_9_1.time_ and arg_9_1.time_ <= 1 + arg_12_0 then
				local var_12_3 = arg_9_1.var_.effectzhendang3

				if not arg_9_1.var_.effectzhendang3 then
					var_12_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_12_3.name = "zhendang3"
					arg_9_1.var_.effectzhendang3 = var_12_3
				else
					var_12_3.transform:SetParent(var_12_9000)
				end

				var_12_3.transform.localPosition = Vector3.New(0.82, 0.69, 1.96)
				var_12_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.999999999998 < arg_9_1.time_ and arg_9_1.time_ <= 1.999999999998 + arg_12_0 then
				if arg_9_1.var_.effectzhendang3 then
					Object.Destroy(arg_9_1.var_.effectzhendang3)

					arg_9_1.var_.effectzhendang3 = nil
				end
			end

			local var_12_6 = manager.ui.mainCamera.transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_6.localPosition
			end

			local var_12_7 = 0.4

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				local var_12_8, var_12_9 = math.modf((arg_9_1.time_ - 0) / 0.066)

				var_12_6.localPosition = Vector3.New(var_12_9 * 0.13, var_12_9 * 0.13, var_12_9 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				var_12_6.localPosition = arg_9_1.var_.shakeOldPos
			end

			local var_12_10 = manager.ui.mainCamera.transform

			if 1 < arg_9_1.time_ and arg_9_1.time_ <= 1 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_10.localPosition
			end

			local var_12_11 = 0.766666666666667

			if 1 <= arg_9_1.time_ and arg_9_1.time_ < 1 + var_12_11 then
				local var_12_12, var_12_13 = math.modf((arg_9_1.time_ - 1) / 0.066)

				var_12_10.localPosition = Vector3.New(var_12_13 * 0.13, var_12_13 * 0.13, var_12_13 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= 1 + var_12_11 and arg_9_1.time_ < 1 + var_12_11 + arg_12_0 then
				var_12_10.localPosition = arg_9_1.var_.shakeOldPos
			end

			local var_12_14 = manager.ui.mainCamera.transform

			if 2 < arg_9_1.time_ and arg_9_1.time_ <= 2 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_14.localPosition
			end

			local var_12_15 = 0.266666666666667

			if 2 <= arg_9_1.time_ and arg_9_1.time_ < 2 + var_12_15 then
				local var_12_16, var_12_17 = math.modf((arg_9_1.time_ - 2) / 0.066)

				var_12_14.localPosition = Vector3.New(var_12_17 * 0.13, var_12_17 * 0.13, var_12_17 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= 2 + var_12_15 and arg_9_1.time_ < 2 + var_12_15 + arg_12_0 then
				var_12_14.localPosition = arg_9_1.var_.shakeOldPos
			end

			local var_12_18 = 0

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			if arg_9_1.time_ >= var_12_18 + 2 and arg_9_1.time_ < var_12_18 + 2 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_141", "se_story_141_hit", "")
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_20 = 1.999999999998
			local var_12_21 = 1.6

			if 1.999999999998 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_22 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_22:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(321332002).content)

				arg_9_1.text_.text = var_12_23

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 64 <= 0 and var_12_21 or var_12_21 * (utf8.len(var_12_23) / 64)

				if (64 <= 0 and var_12_21 or var_12_21 * (utf8.len(var_12_23) / 64)) > 0 and var_12_21 < var_12_25 then
					arg_9_1.talkMaxDuration = var_12_25
					var_12_20 = var_12_20 + 0.3

					if var_12_25 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_25 + var_12_20
					end
				end

				arg_9_1.text_.text = var_12_23
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_26 = var_12_20 + 0.3
			local var_12_27 = math.max(var_12_21, arg_9_1.talkMaxDuration)

			if var_12_20 + 0.3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_26 + var_12_27 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_26) / var_12_27

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_26 + var_12_27 and arg_9_1.time_ < var_12_26 + var_12_27 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play321332003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 321332003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play321332004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 1.3

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_1 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(321332003).content)

				arg_15_1.text_.text = var_18_1

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_3 = 52 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 52)

				if (52 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 52)) > 0 and var_18_0 < var_18_3 then
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
	Play321332004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 321332004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play321332005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0.233333333333333 < arg_19_1.time_ and arg_19_1.time_ <= 0.233333333333333 + arg_22_0 then
				arg_19_1:AudioAction("play", "effect", "se_story_140", "se_story_140_light", "")
			end

			local var_22_1 = 0
			local var_22_2 = 1.375

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_3 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(321332004).content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 55 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_3) / 55)

				if (55 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_3) / 55)) > 0 and var_22_2 < var_22_5 then
					arg_19_1.talkMaxDuration = var_22_5

					if var_22_5 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_5 + var_22_1
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_6 = math.max(var_22_2, arg_19_1.talkMaxDuration)

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_6 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_1) / var_22_6

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_1 + var_22_6 and arg_19_1.time_ < var_22_1 + var_22_6 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play321332005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 321332005
		arg_23_1.duration_ = 6.03

		local var_23_0 = {
			zh = 4.4,
			ja = 6.033
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
				arg_23_0:Play321332006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if arg_23_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_26_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_23_1.stage_.transform)

				var_26_0.name = "404001ui_story"
				var_26_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["404001ui_story"] = var_26_0

				local var_26_1 = var_26_0:GetComponentInChildren(typeof(CharacterEffect))

				var_26_1.enabled = true

				local var_26_2 = GameObjectTools.GetOrAddComponent(var_26_0, typeof(DynamicBoneHelper))

				if var_26_2 then
					var_26_2:EnableDynamicBone(false)
				end

				arg_23_1:ShowWeapon(var_26_1.transform, false)

				arg_23_1.var_["404001ui_story" .. "Animator"] = var_26_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_23_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_23_1.var_["404001ui_story" .. "LipSync"] = var_26_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_26_3 = arg_23_1.actors_["404001ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos404001ui_story = var_26_3.localPosition
			end

			local var_26_4 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_3.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_23_1.time_ - 0) / var_26_4)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_3.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			local var_26_5 = arg_23_1.actors_["404001ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect404001ui_story == nil then
				arg_23_1.var_.characterEffect404001ui_story = var_26_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_6 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 and not isNil(var_26_5) then
				if arg_23_1.var_.characterEffect404001ui_story and not isNil(var_26_5) then
					arg_23_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect404001ui_story then
				arg_23_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_26_8 = 0
			local var_26_9 = 0.375

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_10 = arg_23_1:GetWordFromCfg(321332005)
				local var_26_11 = arg_23_1:FormatText(var_26_10.content)

				arg_23_1.text_.text = var_26_11

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 15 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 15)

				if (15 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 15)) > 0 and var_26_9 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_11
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332005", "story_v_out_321332.awb") ~= 0 then
					local var_26_14 = manager.audio:GetVoiceLength("story_v_out_321332", "321332005", "story_v_out_321332.awb") / 1000

					if var_26_14 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_14 + var_26_8
					end

					if var_26_10.prefab_name ~= "" and arg_23_1.actors_[var_26_10.prefab_name] ~= nil then
						local var_26_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_10.prefab_name].transform, "story_v_out_321332", "321332005", "story_v_out_321332.awb")

						arg_23_1:RecordAudio("321332005", var_26_15)
						arg_23_1:RecordAudio("321332005", var_26_15)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_321332", "321332005", "story_v_out_321332.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_321332", "321332005", "story_v_out_321332.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_16 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_16 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_16

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_16 and arg_23_1.time_ < var_26_8 + var_26_16 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play321332006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 321332006
		arg_27_1.duration_ = 4.1

		local var_27_0 = {
			zh = 4.1,
			ja = 3.366
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
				arg_27_0:Play321332007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if arg_27_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_30_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_27_1.stage_.transform)

				var_30_0.name = "1211ui_story"
				var_30_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["1211ui_story"] = var_30_0

				local var_30_1 = var_30_0:GetComponentInChildren(typeof(CharacterEffect))

				var_30_1.enabled = true

				local var_30_2 = GameObjectTools.GetOrAddComponent(var_30_0, typeof(DynamicBoneHelper))

				if var_30_2 then
					var_30_2:EnableDynamicBone(false)
				end

				arg_27_1:ShowWeapon(var_30_1.transform, false)

				arg_27_1.var_["1211ui_story" .. "Animator"] = var_30_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_27_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_27_1.var_["1211ui_story" .. "LipSync"] = var_30_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_30_3 = arg_27_1.actors_["1211ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1211ui_story = var_30_3.localPosition
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_3.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_27_1.time_ - 0) / var_30_4)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_3.localPosition = Vector3.New(0.7, -0.67, -6.07)
				var_30_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_3.position).x, (manager.ui.mainCamera.transform.position - var_30_3.position).y, (manager.ui.mainCamera.transform.position - var_30_3.position).z)
				var_30_3.localEulerAngles.z = 0
				var_30_3.localEulerAngles.x = 0
				var_30_3.localEulerAngles = var_30_3.localEulerAngles
			end

			local var_30_5 = arg_27_1.actors_["1211ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1211ui_story == nil then
				arg_27_1.var_.characterEffect1211ui_story = var_30_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_6 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_6 and not isNil(var_30_5) then
				if arg_27_1.var_.characterEffect1211ui_story and not isNil(var_30_5) then
					arg_27_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_6 and arg_27_1.time_ < 0 + var_30_6 + arg_30_0 and not isNil(var_30_5) and arg_27_1.var_.characterEffect1211ui_story then
				arg_27_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_30_8 = arg_27_1.actors_["404001ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_8) and arg_27_1.var_.characterEffect404001ui_story == nil then
				arg_27_1.var_.characterEffect404001ui_story = var_30_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_9 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_9 and not isNil(var_30_8) then
				if arg_27_1.var_.characterEffect404001ui_story and not isNil(var_30_8) then
					arg_27_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_27_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_9)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_9 and arg_27_1.time_ < 0 + var_30_9 + arg_30_0 and not isNil(var_30_8) and arg_27_1.var_.characterEffect404001ui_story then
				arg_27_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_27_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_30_10 = 0
			local var_30_11 = 0.475

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_12 = arg_27_1:GetWordFromCfg(321332006)
				local var_30_13 = arg_27_1:FormatText(var_30_12.content)

				arg_27_1.text_.text = var_30_13

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_15 = 19 <= 0 and var_30_11 or var_30_11 * (utf8.len(var_30_13) / 19)

				if (19 <= 0 and var_30_11 or var_30_11 * (utf8.len(var_30_13) / 19)) > 0 and var_30_11 < var_30_15 then
					arg_27_1.talkMaxDuration = var_30_15

					if var_30_15 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_15 + var_30_10
					end
				end

				arg_27_1.text_.text = var_30_13
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332006", "story_v_out_321332.awb") ~= 0 then
					local var_30_16 = manager.audio:GetVoiceLength("story_v_out_321332", "321332006", "story_v_out_321332.awb") / 1000

					if var_30_16 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_16 + var_30_10
					end

					if var_30_12.prefab_name ~= "" and arg_27_1.actors_[var_30_12.prefab_name] ~= nil then
						local var_30_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_12.prefab_name].transform, "story_v_out_321332", "321332006", "story_v_out_321332.awb")

						arg_27_1:RecordAudio("321332006", var_30_17)
						arg_27_1:RecordAudio("321332006", var_30_17)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_321332", "321332006", "story_v_out_321332.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_321332", "321332006", "story_v_out_321332.awb")
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
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play321332007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 321332007
		arg_31_1.duration_ = 7.73

		local var_31_0 = {
			zh = 5.433,
			ja = 7.733
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
				arg_31_0:Play321332008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1211ui_story = arg_31_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1211ui_story"].transform.position).z)
				arg_31_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1211ui_story"].transform.localEulerAngles = arg_31_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1211ui_story"].transform.position).z)
				arg_31_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1211ui_story"].transform.localEulerAngles = arg_31_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["404001ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos404001ui_story = var_34_1.localPosition
			end

			local var_34_2 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 then
				var_34_1.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_2)
				var_34_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_1.position).x, (manager.ui.mainCamera.transform.position - var_34_1.position).y, (manager.ui.mainCamera.transform.position - var_34_1.position).z)
				var_34_1.localEulerAngles.z = 0
				var_34_1.localEulerAngles.x = 0
				var_34_1.localEulerAngles = var_34_1.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 then
				var_34_1.localPosition = Vector3.New(0, 100, 0)
				var_34_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_1.position).x, (manager.ui.mainCamera.transform.position - var_34_1.position).y, (manager.ui.mainCamera.transform.position - var_34_1.position).z)
				var_34_1.localEulerAngles.z = 0
				var_34_1.localEulerAngles.x = 0
				var_34_1.localEulerAngles = var_34_1.localEulerAngles
			end

			local var_34_3 = arg_31_1.actors_["1211ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_3) and arg_31_1.var_.characterEffect1211ui_story == nil then
				arg_31_1.var_.characterEffect1211ui_story = var_34_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_4 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 and not isNil(var_34_3) then
				if arg_31_1.var_.characterEffect1211ui_story and not isNil(var_34_3) then
					arg_31_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_4)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 and not isNil(var_34_3) and arg_31_1.var_.characterEffect1211ui_story then
				arg_31_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_34_5 = 0
			local var_34_6 = 0.4

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_7 = arg_31_1:GetWordFromCfg(321332007)
				local var_34_8 = arg_31_1:FormatText(var_34_7.content)

				arg_31_1.text_.text = var_34_8

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_10 = 16 <= 0 and var_34_6 or var_34_6 * (utf8.len(var_34_8) / 16)

				if (16 <= 0 and var_34_6 or var_34_6 * (utf8.len(var_34_8) / 16)) > 0 and var_34_6 < var_34_10 then
					arg_31_1.talkMaxDuration = var_34_10

					if var_34_10 + var_34_5 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_5
					end
				end

				arg_31_1.text_.text = var_34_8
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332007", "story_v_out_321332.awb") ~= 0 then
					local var_34_11 = manager.audio:GetVoiceLength("story_v_out_321332", "321332007", "story_v_out_321332.awb") / 1000

					if var_34_11 + var_34_5 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_11 + var_34_5
					end

					if var_34_7.prefab_name ~= "" and arg_31_1.actors_[var_34_7.prefab_name] ~= nil then
						local var_34_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_7.prefab_name].transform, "story_v_out_321332", "321332007", "story_v_out_321332.awb")

						arg_31_1:RecordAudio("321332007", var_34_12)
						arg_31_1:RecordAudio("321332007", var_34_12)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_321332", "321332007", "story_v_out_321332.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_321332", "321332007", "story_v_out_321332.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_13 = math.max(var_34_6, arg_31_1.talkMaxDuration)

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_13 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_5) / var_34_13

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_5 + var_34_13 and arg_31_1.time_ < var_34_5 + var_34_13 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play321332008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 321332008
		arg_35_1.duration_ = 4.47

		local var_35_0 = {
			zh = 3.4,
			ja = 4.466
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
				arg_35_0:Play321332009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if arg_35_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_38_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_35_1.stage_.transform)

				var_38_0.name = "1061ui_story"
				var_38_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["1061ui_story"] = var_38_0

				local var_38_1 = var_38_0:GetComponentInChildren(typeof(CharacterEffect))

				var_38_1.enabled = true

				local var_38_2 = GameObjectTools.GetOrAddComponent(var_38_0, typeof(DynamicBoneHelper))

				if var_38_2 then
					var_38_2:EnableDynamicBone(false)
				end

				arg_35_1:ShowWeapon(var_38_1.transform, false)

				arg_35_1.var_["1061ui_story" .. "Animator"] = var_38_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_35_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_35_1.var_["1061ui_story" .. "LipSync"] = var_38_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_38_3 = arg_35_1.actors_["1061ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1061ui_story = var_38_3.localPosition
			end

			local var_38_4 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				var_38_3.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_35_1.time_ - 0) / var_38_4)
				var_38_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_3.position).x, (manager.ui.mainCamera.transform.position - var_38_3.position).y, (manager.ui.mainCamera.transform.position - var_38_3.position).z)
				var_38_3.localEulerAngles.z = 0
				var_38_3.localEulerAngles.x = 0
				var_38_3.localEulerAngles = var_38_3.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				var_38_3.localPosition = Vector3.New(0, -1.18, -6.15)
				var_38_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_3.position).x, (manager.ui.mainCamera.transform.position - var_38_3.position).y, (manager.ui.mainCamera.transform.position - var_38_3.position).z)
				var_38_3.localEulerAngles.z = 0
				var_38_3.localEulerAngles.x = 0
				var_38_3.localEulerAngles = var_38_3.localEulerAngles
			end

			local var_38_5 = arg_35_1.actors_["1061ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.characterEffect1061ui_story == nil then
				arg_35_1.var_.characterEffect1061ui_story = var_38_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_6 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_6 and not isNil(var_38_5) then
				if arg_35_1.var_.characterEffect1061ui_story and not isNil(var_38_5) then
					arg_35_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_6 and arg_35_1.time_ < 0 + var_38_6 + arg_38_0 and not isNil(var_38_5) and arg_35_1.var_.characterEffect1061ui_story then
				arg_35_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_38_8 = 0
			local var_38_9 = 0.25

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_10 = arg_35_1:GetWordFromCfg(321332008)
				local var_38_11 = arg_35_1:FormatText(var_38_10.content)

				arg_35_1.text_.text = var_38_11

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_13 = 10 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 10)

				if (10 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 10)) > 0 and var_38_9 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_8
					end
				end

				arg_35_1.text_.text = var_38_11
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332008", "story_v_out_321332.awb") ~= 0 then
					local var_38_14 = manager.audio:GetVoiceLength("story_v_out_321332", "321332008", "story_v_out_321332.awb") / 1000

					if var_38_14 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_14 + var_38_8
					end

					if var_38_10.prefab_name ~= "" and arg_35_1.actors_[var_38_10.prefab_name] ~= nil then
						local var_38_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_10.prefab_name].transform, "story_v_out_321332", "321332008", "story_v_out_321332.awb")

						arg_35_1:RecordAudio("321332008", var_38_15)
						arg_35_1:RecordAudio("321332008", var_38_15)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_321332", "321332008", "story_v_out_321332.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_321332", "321332008", "story_v_out_321332.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_16 = math.max(var_38_9, arg_35_1.talkMaxDuration)

			if var_38_8 <= arg_35_1.time_ and arg_35_1.time_ < var_38_8 + var_38_16 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_8) / var_38_16

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_8 + var_38_16 and arg_35_1.time_ < var_38_8 + var_38_16 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play321332009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 321332009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play321332010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1061ui_story = arg_39_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1061ui_story"].transform.position).z)
				arg_39_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1061ui_story"].transform.localEulerAngles = arg_39_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1061ui_story"].transform.position).z)
				arg_39_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1061ui_story"].transform.localEulerAngles = arg_39_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1061ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1061ui_story == nil then
				arg_39_1.var_.characterEffect1061ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1061ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_2)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1061ui_story then
				arg_39_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_42_3 = 0
			local var_42_4 = 1.225

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_3 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_5 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(321332009).content)

				arg_39_1.text_.text = var_42_5

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_7 = 49 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_5) / 49)

				if (49 <= 0 and var_42_4 or var_42_4 * (utf8.len(var_42_5) / 49)) > 0 and var_42_4 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_3 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_3
					end
				end

				arg_39_1.text_.text = var_42_5
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_8 = math.max(var_42_4, arg_39_1.talkMaxDuration)

			if var_42_3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_3 + var_42_8 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_3) / var_42_8

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_3 + var_42_8 and arg_39_1.time_ < var_42_3 + var_42_8 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play321332010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 321332010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play321332011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0.1 < arg_43_1.time_ and arg_43_1.time_ <= 0.1 + arg_46_0 then
				arg_43_1:AudioAction("play", "effect", "se_story_140", "se_story_140_activate", "")
			end

			local var_46_1 = 0
			local var_46_2 = 1.1

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(321332010).content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 44 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 44)

				if (44 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 44)) > 0 and var_46_2 < var_46_5 then
					arg_43_1.talkMaxDuration = var_46_5

					if var_46_5 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_6 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_6 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_6

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_6 and arg_43_1.time_ < var_46_1 + var_46_6 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play321332011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 321332011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play321332012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0.1 < arg_47_1.time_ and arg_47_1.time_ <= 0.1 + arg_50_0 then
				arg_47_1:AudioAction("play", "effect", "se_story_140", "se_story_140_xuanji", "")
			end

			local var_50_1 = 0
			local var_50_2 = 1.225

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(321332011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 49 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 49)

				if (49 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 49)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play321332012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 321332012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play321332013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 1.2

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(321332012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 48 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 48)

				if (48 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 48)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play321332013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 321332013
		arg_55_1.duration_ = 9.6

		local var_55_0 = {
			zh = 5.9,
			ja = 9.6
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
				arg_55_0:Play321332014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.625

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:GetWordFromCfg(321332013)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 25 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 25)

				if (25 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 25)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332013", "story_v_out_321332.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332013", "story_v_out_321332.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_321332", "321332013", "story_v_out_321332.awb")

						arg_55_1:RecordAudio("321332013", var_58_6)
						arg_55_1:RecordAudio("321332013", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_321332", "321332013", "story_v_out_321332.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_321332", "321332013", "story_v_out_321332.awb")
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
	Play321332014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 321332014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play321332015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 1.2

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(321332014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 48 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 48)

				if (48 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 48)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play321332015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 321332015
		arg_63_1.duration_ = 6.8

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play321332016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				local var_66_0 = arg_63_1.var_.effectbiantui1

				if not arg_63_1.var_.effectbiantui1 then
					var_66_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_66_0.name = "biantui1"
					arg_63_1.var_.effectbiantui1 = var_66_0
				else
					var_66_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_66_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_66_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_63_1.time_ and arg_63_1.time_ <= 2 + arg_66_0 then
				if arg_63_1.var_.effectbiantui1 then
					Object.Destroy(arg_63_1.var_.effectbiantui1)

					arg_63_1.var_.effectbiantui1 = nil
				end
			end

			local var_66_3 = manager.ui.mainCamera.transform

			if 0.4 < arg_63_1.time_ and arg_63_1.time_ <= 0.4 + arg_66_0 then
				arg_63_1.var_.shakeOldPos = var_66_3.localPosition
			end

			local var_66_4 = 1

			if 0.4 <= arg_63_1.time_ and arg_63_1.time_ < 0.4 + var_66_4 then
				local var_66_5, var_66_6 = math.modf((arg_63_1.time_ - 0.4) / 0.066)

				var_66_3.localPosition = Vector3.New(var_66_6 * 0.13, var_66_6 * 0.13, var_66_6 * 0.13) + arg_63_1.var_.shakeOldPos
			end

			if arg_63_1.time_ >= 0.4 + var_66_4 and arg_63_1.time_ < 0.4 + var_66_4 + arg_66_0 then
				var_66_3.localPosition = arg_63_1.var_.shakeOldPos
			end

			local var_66_7 = 0

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_7 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			if arg_63_1.time_ >= var_66_7 + 1.8 and arg_63_1.time_ < var_66_7 + 1.8 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:AudioAction("play", "effect", "se_story_141", "se_story_141_fight", "")
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_9 = 1.8
			local var_66_10 = 1.425

			if 1.8 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_11 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_11:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_12 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(321332015).content)

				arg_63_1.text_.text = var_66_12

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_14 = 57 <= 0 and var_66_10 or var_66_10 * (utf8.len(var_66_12) / 57)

				if (57 <= 0 and var_66_10 or var_66_10 * (utf8.len(var_66_12) / 57)) > 0 and var_66_10 < var_66_14 then
					arg_63_1.talkMaxDuration = var_66_14
					var_66_9 = var_66_9 + 0.3

					if var_66_14 + var_66_9 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_9
					end
				end

				arg_63_1.text_.text = var_66_12
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_15 = var_66_9 + 0.3
			local var_66_16 = math.max(var_66_10, arg_63_1.talkMaxDuration)

			if var_66_9 + 0.3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_15 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_15) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_15 + var_66_16 and arg_63_1.time_ < var_66_15 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play321332016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 321332016
		arg_69_1.duration_ = 3.9

		local var_69_0 = {
			zh = 3.9,
			ja = 3.333
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
				arg_69_0:Play321332017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_72_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_69_1.stage_.transform)

				var_72_0.name = "1156ui_story"
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1156ui_story"] = var_72_0

				local var_72_1 = var_72_0:GetComponentInChildren(typeof(CharacterEffect))

				var_72_1.enabled = true

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_0, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_1.transform, false)

				arg_69_1.var_["1156ui_story" .. "Animator"] = var_72_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_69_1.var_["1156ui_story" .. "LipSync"] = var_72_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_3 = arg_69_1.actors_["1156ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1156ui_story = var_72_3.localPosition
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_3.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_69_1.time_ - 0) / var_72_4)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_3.localPosition = Vector3.New(0, -1.1, -6.18)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			local var_72_5 = arg_69_1.actors_["1156ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1156ui_story == nil then
				arg_69_1.var_.characterEffect1156ui_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.characterEffect1156ui_story and not isNil(var_72_5) then
					arg_69_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1156ui_story then
				arg_69_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action11_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_72_8 = 0
			local var_72_9 = 0.425

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(321332016)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 17 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 17)

				if (17 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 17)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332016", "story_v_out_321332.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_321332", "321332016", "story_v_out_321332.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_321332", "321332016", "story_v_out_321332.awb")

						arg_69_1:RecordAudio("321332016", var_72_15)
						arg_69_1:RecordAudio("321332016", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_321332", "321332016", "story_v_out_321332.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_321332", "321332016", "story_v_out_321332.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_16 and arg_69_1.time_ < var_72_8 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play321332017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 321332017
		arg_73_1.duration_ = 2

		local var_73_0 = {
			zh = 2,
			ja = 1.7
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
				arg_73_0:Play321332018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1156ui_story = arg_73_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1156ui_story"].transform.position).z)
				arg_73_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1156ui_story"].transform.localEulerAngles = arg_73_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1156ui_story"].transform.position).z)
				arg_73_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1156ui_story"].transform.localEulerAngles = arg_73_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1156ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1156ui_story == nil then
				arg_73_1.var_.characterEffect1156ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1156ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_2)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1156ui_story then
				arg_73_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_76_3 = 0
			local var_76_4 = 0.15

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_5 = arg_73_1:GetWordFromCfg(321332017)
				local var_76_6 = arg_73_1:FormatText(var_76_5.content)

				arg_73_1.text_.text = var_76_6

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_8 = 6 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_6) / 6)

				if (6 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_6) / 6)) > 0 and var_76_4 < var_76_8 then
					arg_73_1.talkMaxDuration = var_76_8

					if var_76_8 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_3
					end
				end

				arg_73_1.text_.text = var_76_6
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332017", "story_v_out_321332.awb") ~= 0 then
					local var_76_9 = manager.audio:GetVoiceLength("story_v_out_321332", "321332017", "story_v_out_321332.awb") / 1000

					if var_76_9 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_3
					end

					if var_76_5.prefab_name ~= "" and arg_73_1.actors_[var_76_5.prefab_name] ~= nil then
						local var_76_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_5.prefab_name].transform, "story_v_out_321332", "321332017", "story_v_out_321332.awb")

						arg_73_1:RecordAudio("321332017", var_76_10)
						arg_73_1:RecordAudio("321332017", var_76_10)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_321332", "321332017", "story_v_out_321332.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_321332", "321332017", "story_v_out_321332.awb")
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

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play321332018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 321332018
		arg_77_1.duration_ = 6

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play321332019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				local var_80_0 = arg_77_1.var_.effectduizhuang1

				if not arg_77_1.var_.effectduizhuang1 then
					var_80_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_80_0.name = "duizhuang1"
					arg_77_1.var_.effectduizhuang1 = var_80_0
				else
					var_80_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_80_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_80_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_80_2 = manager.ui.mainCamera.transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.shakeOldPos = var_80_2.localPosition
			end

			local var_80_3 = 1

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 then
				local var_80_4, var_80_5 = math.modf((arg_77_1.time_ - 0) / 0.066)

				var_80_2.localPosition = Vector3.New(var_80_5 * 0.13, var_80_5 * 0.13, var_80_5 * 0.13) + arg_77_1.var_.shakeOldPos
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 then
				var_80_2.localPosition = arg_77_1.var_.shakeOldPos
			end

			local var_80_6 = 0

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			if arg_77_1.time_ >= var_80_6 + 1 and arg_77_1.time_ < var_80_6 + 1 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end

			if 0.05 < arg_77_1.time_ and arg_77_1.time_ <= 0.05 + arg_80_0 then
				arg_77_1:AudioAction("play", "effect", "se_story_141", "se_story_141_hit02", "")
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_8 = 1
			local var_80_9 = 1.225

			if 1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_10 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_10:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_11 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(321332018).content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 49 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 49)

				if (49 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 49)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13
					var_80_8 = var_80_8 + 0.3

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = var_80_8 + 0.3
			local var_80_15 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_14 + var_80_15 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_14) / var_80_15

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_14 + var_80_15 and arg_77_1.time_ < var_80_14 + var_80_15 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play321332019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321332019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play321332020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0.266666666666667 < arg_83_1.time_ and arg_83_1.time_ <= 0.266666666666667 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_141", "se_story_141_ravana_attack07", "")
			end

			local var_86_1 = 0
			local var_86_2 = 1.1

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(321332019).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 44 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 44)

				if (44 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 44)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play321332020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321332020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play321332021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 1.45

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(321332020).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 58 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 58)

				if (58 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 58)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play321332021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 321332021
		arg_91_1.duration_ = 7.53

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play321332022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if arg_91_1.bgs_.MS2110 == nil then
				local var_94_0 = Object.Instantiate(arg_91_1.paintGo_)

				var_94_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2110")
				var_94_0.name = "MS2110"
				var_94_0.transform.parent = arg_91_1.stage_.transform
				var_94_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_.MS2110 = var_94_0
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				local var_94_1 = arg_91_1.bgs_.MS2110

				arg_91_1.bgs_.MS2110.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_94_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_2 = var_94_1:GetComponent("SpriteRenderer")

				if var_94_2 and var_94_2.sprite then
					local var_94_3 = 2 * (var_94_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_94_1.transform.localScale = Vector3.New(var_94_3 / var_94_2.sprite.bounds.size.y < var_94_3 * manager.ui.mainCameraCom_.aspect / var_94_2.sprite.bounds.size.x and var_94_3 * manager.ui.mainCameraCom_.aspect / var_94_2.sprite.bounds.size.x or var_94_3 / var_94_2.sprite.bounds.size.y, var_94_3 / var_94_2.sprite.bounds.size.y < var_94_3 * manager.ui.mainCameraCom_.aspect / var_94_2.sprite.bounds.size.x and var_94_3 * manager.ui.mainCameraCom_.aspect / var_94_2.sprite.bounds.size.x or var_94_3 / var_94_2.sprite.bounds.size.y, 0)
				end

				for iter_94_0, iter_94_1 in pairs(arg_91_1.bgs_) do
					if iter_94_0 ~= "MS2110" then
						iter_94_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_94_4 = 2

			if 2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.allBtn_.enabled = false
			end

			if arg_91_1.time_ >= var_94_4 + 0.3 and arg_91_1.time_ < var_94_4 + 0.3 + arg_94_0 then
				arg_91_1.allBtn_.enabled = true
			end

			local var_94_5 = 0

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_6 = 2

			if var_94_5 <= arg_91_1.time_ and arg_91_1.time_ < var_94_5 + var_94_6 then
				local var_94_7 = Color.New(1, 1, 1)

				var_94_7.a = Mathf.Lerp(1, 0, (arg_91_1.time_ - var_94_5) / var_94_6)
				arg_91_1.mask_.color = var_94_7
			end

			if arg_91_1.time_ >= var_94_5 + var_94_6 and arg_91_1.time_ < var_94_5 + var_94_6 + arg_94_0 then
				local var_94_8 = Color.New(1, 1, 1)

				arg_91_1.mask_.enabled = false
				var_94_8.a = 0
				arg_91_1.mask_.color = var_94_8
			end

			local var_94_9 = "MS2110"

			if arg_91_1.bgs_.MS2110 == nil then
				local var_94_10 = Object.Instantiate(arg_91_1.blurPaintGo_)

				var_94_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_94_9)
				var_94_10.name = var_94_9
				var_94_10.transform.parent = arg_91_1.stage_.transform
				var_94_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_[var_94_9] = var_94_10
			end

			local var_94_11 = 0
			local var_94_12 = arg_91_1.bgs_[var_94_9]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_11 + arg_94_0 then
				var_94_12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_94_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_13 = var_94_12:GetComponent("SpriteRenderer")

				if var_94_13 and var_94_13.sprite then
					local var_94_14 = 2 * (var_94_12.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_94_12.transform.localScale = Vector3.New(var_94_14 / var_94_13.sprite.bounds.size.y < var_94_14 * manager.ui.mainCameraCom_.aspect / var_94_13.sprite.bounds.size.x and var_94_14 * manager.ui.mainCameraCom_.aspect / var_94_13.sprite.bounds.size.x or var_94_14 / var_94_13.sprite.bounds.size.y, var_94_14 / var_94_13.sprite.bounds.size.y < var_94_14 * manager.ui.mainCameraCom_.aspect / var_94_13.sprite.bounds.size.x and var_94_14 * manager.ui.mainCameraCom_.aspect / var_94_13.sprite.bounds.size.x or var_94_14 / var_94_13.sprite.bounds.size.y, 0)
				end
			end

			local var_94_15 = 1.5

			if var_94_11 <= arg_91_1.time_ and arg_91_1.time_ < var_94_11 + var_94_15 then
				local var_94_16 = Color.New(1, 1, 1)

				var_94_16.a = Mathf.Lerp(1, 0, (arg_91_1.time_ - var_94_11) / var_94_15)

				var_94_12:GetComponent("SpriteRenderer").material:SetColor("_Color", var_94_16)
			end

			local var_94_17 = "MS2110"

			if arg_91_1.bgs_.MS2110 == nil then
				local var_94_18 = Object.Instantiate(arg_91_1.blurPaintGo_)

				var_94_18:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_94_17)
				var_94_18.name = var_94_17
				var_94_18.transform.parent = arg_91_1.stage_.transform
				var_94_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_[var_94_17] = var_94_18
			end

			local var_94_19 = 1.5
			local var_94_20 = arg_91_1.bgs_[var_94_17]

			if 1.5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_19 + arg_94_0 then
				var_94_20.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_94_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_21 = var_94_20:GetComponent("SpriteRenderer")

				if var_94_21 and var_94_21.sprite then
					local var_94_22 = 2 * (var_94_20.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_94_20.transform.localScale = Vector3.New(var_94_22 / var_94_21.sprite.bounds.size.y < var_94_22 * manager.ui.mainCameraCom_.aspect / var_94_21.sprite.bounds.size.x and var_94_22 * manager.ui.mainCameraCom_.aspect / var_94_21.sprite.bounds.size.x or var_94_22 / var_94_21.sprite.bounds.size.y, var_94_22 / var_94_21.sprite.bounds.size.y < var_94_22 * manager.ui.mainCameraCom_.aspect / var_94_21.sprite.bounds.size.x and var_94_22 * manager.ui.mainCameraCom_.aspect / var_94_21.sprite.bounds.size.x or var_94_22 / var_94_21.sprite.bounds.size.y, 0)
				end
			end

			local var_94_23 = 0.5

			if var_94_19 <= arg_91_1.time_ and arg_91_1.time_ < var_94_19 + var_94_23 then
				local var_94_24 = Color.New(1, 1, 1)

				var_94_24.a = Mathf.Lerp(0, 1, (arg_91_1.time_ - var_94_19) / var_94_23)

				var_94_20:GetComponent("SpriteRenderer").material:SetColor("_Color", var_94_24)
			end

			local var_94_25 = "MS2110"

			if arg_91_1.bgs_.MS2110 == nil then
				local var_94_26 = Object.Instantiate(arg_91_1.blurPaintGo_)

				var_94_26:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_94_25)
				var_94_26.name = var_94_25
				var_94_26.transform.parent = arg_91_1.stage_.transform
				var_94_26.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.bgs_[var_94_25] = var_94_26
			end

			local var_94_27 = 2
			local var_94_28 = arg_91_1.bgs_[var_94_25]

			if 2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_27 + arg_94_0 then
				var_94_28.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_94_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_29 = var_94_28:GetComponent("SpriteRenderer")

				if var_94_29 and var_94_29.sprite then
					local var_94_30 = 2 * (var_94_28.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_94_28.transform.localScale = Vector3.New(var_94_30 / var_94_29.sprite.bounds.size.y < var_94_30 * manager.ui.mainCameraCom_.aspect / var_94_29.sprite.bounds.size.x and var_94_30 * manager.ui.mainCameraCom_.aspect / var_94_29.sprite.bounds.size.x or var_94_30 / var_94_29.sprite.bounds.size.y, var_94_30 / var_94_29.sprite.bounds.size.y < var_94_30 * manager.ui.mainCameraCom_.aspect / var_94_29.sprite.bounds.size.x and var_94_30 * manager.ui.mainCameraCom_.aspect / var_94_29.sprite.bounds.size.x or var_94_30 / var_94_29.sprite.bounds.size.y, 0)
				end
			end

			local var_94_31 = 0.6

			if var_94_27 <= arg_91_1.time_ and arg_91_1.time_ < var_94_27 + var_94_31 then
				local var_94_32 = Color.New(1, 1, 1)

				var_94_32.a = Mathf.Lerp(1, 0, (arg_91_1.time_ - var_94_27) / var_94_31)

				var_94_28:GetComponent("SpriteRenderer").material:SetColor("_Color", var_94_32)
			end

			local var_94_33 = 2

			if 2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_33 + arg_94_0 then
				arg_91_1.allBtn_.enabled = false
			end

			if arg_91_1.time_ >= var_94_33 + 0.533333333333333 and arg_91_1.time_ < var_94_33 + 0.533333333333333 + arg_94_0 then
				arg_91_1.allBtn_.enabled = true
			end

			if 2.53333333333333 < arg_91_1.time_ and arg_91_1.time_ <= 2.53333333333333 + arg_94_0 then
				arg_91_1:AudioAction("play", "effect", "se_story_141", "se_story_141_ravana_footstep01", "")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:AudioAction("play", "effect", "se_story_141", "se_story_141_explosion02", "")
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_36 = 2.53333333333333
			local var_94_37 = 0.8

			if 2.53333333333333 < arg_91_1.time_ and arg_91_1.time_ <= var_94_36 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_38 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_38:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_39 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(321332021).content)

				arg_91_1.text_.text = var_94_39

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_41 = 32 <= 0 and var_94_37 or var_94_37 * (utf8.len(var_94_39) / 32)

				if (32 <= 0 and var_94_37 or var_94_37 * (utf8.len(var_94_39) / 32)) > 0 and var_94_37 < var_94_41 then
					arg_91_1.talkMaxDuration = var_94_41
					var_94_36 = var_94_36 + 0.3

					if var_94_41 + var_94_36 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_41 + var_94_36
					end
				end

				arg_91_1.text_.text = var_94_39
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_42 = var_94_36 + 0.3
			local var_94_43 = math.max(var_94_37, arg_91_1.talkMaxDuration)

			if var_94_36 + 0.3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_42 + var_94_43 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_42) / var_94_43

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_42 + var_94_43 and arg_91_1.time_ < var_94_42 + var_94_43 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play321332022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 321332022
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play321332023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.55

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(321332022).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 22 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 22)

				if (22 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 22)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play321332023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 321332023
		arg_101_1.duration_ = 7.63

		local var_101_0 = {
			zh = 4.7,
			ja = 7.633
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play321332024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.45

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_3")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(321332023)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 18 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 18)

				if (18 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 18)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332023", "story_v_out_321332.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332023", "story_v_out_321332.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_321332", "321332023", "story_v_out_321332.awb")

						arg_101_1:RecordAudio("321332023", var_104_6)
						arg_101_1:RecordAudio("321332023", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_321332", "321332023", "story_v_out_321332.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_321332", "321332023", "story_v_out_321332.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play321332024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321332024
		arg_105_1.duration_ = 7.23

		local var_105_0 = {
			zh = 5.333,
			ja = 7.233
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
				arg_105_0:Play321332025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.475

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(321332024)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 19 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 19)

				if (19 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 19)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332024", "story_v_out_321332.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332024", "story_v_out_321332.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_321332", "321332024", "story_v_out_321332.awb")

						arg_105_1:RecordAudio("321332024", var_108_6)
						arg_105_1:RecordAudio("321332024", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_321332", "321332024", "story_v_out_321332.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_321332", "321332024", "story_v_out_321332.awb")
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
	Play321332025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321332025
		arg_109_1.duration_ = 1

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321332026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.05

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:GetWordFromCfg(321332025)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 2 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 2)

				if (2 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 2)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332025", "story_v_out_321332.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332025", "story_v_out_321332.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_321332", "321332025", "story_v_out_321332.awb")

						arg_109_1:RecordAudio("321332025", var_112_6)
						arg_109_1:RecordAudio("321332025", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_321332", "321332025", "story_v_out_321332.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_321332", "321332025", "story_v_out_321332.awb")
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
	Play321332026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321332026
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play321332027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:AudioAction("play", "effect", "se_story_141", "se_story_141_xuanji03", "")
			end

			local var_116_1 = 0
			local var_116_2 = 0.925

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(321332026).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 37 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 37)

				if (37 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 37)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play321332027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321332027
		arg_117_1.duration_ = 7.1

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play321332028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_9001
			local var_120_9000

			if 0.1 < arg_117_1.time_ and arg_117_1.time_ <= 0.1 + arg_120_0 then
				local var_120_0 = arg_117_1.bgs_.MS2110

				arg_117_1.bgs_.MS2110.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_120_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_1 = var_120_0:GetComponent("SpriteRenderer")

				if var_120_1 and var_120_1.sprite then
					local var_120_2 = 2 * (var_120_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_120_0.transform.localScale = Vector3.New(var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, var_120_2 / var_120_1.sprite.bounds.size.y < var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x and var_120_2 * manager.ui.mainCameraCom_.aspect / var_120_1.sprite.bounds.size.x or var_120_2 / var_120_1.sprite.bounds.size.y, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "MS2110" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_3 = arg_117_1.bgs_.MS2110.transform

			if 0.183333333333333 < arg_117_1.time_ and arg_117_1.time_ <= 0.183333333333333 + arg_120_0 then
				arg_117_1.var_.moveOldPosMS2110 = var_120_3.localPosition
			end

			local var_120_4 = 0.001

			if 0.183333333333333 <= arg_117_1.time_ and arg_117_1.time_ < 0.183333333333333 + var_120_4 then
				var_120_3.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPosMS2110, Vector3.New(0.68, 3, 1.04), (arg_117_1.time_ - 0.183333333333333) / var_120_4)
			end

			if arg_117_1.time_ >= 0.183333333333333 + var_120_4 and arg_117_1.time_ < 0.183333333333333 + var_120_4 + arg_120_0 then
				var_120_3.localPosition = Vector3.New(0.68, 3, 1.04)
			end

			local var_120_5 = arg_117_1.bgs_.MS2110.transform

			if 0.633333333333333 < arg_117_1.time_ and arg_117_1.time_ <= 0.633333333333333 + arg_120_0 then
				arg_117_1.var_.moveOldPosMS2110 = var_120_5.localPosition
			end

			local var_120_6 = 1.9

			if 0.633333333333333 <= arg_117_1.time_ and arg_117_1.time_ < 0.633333333333333 + var_120_6 then
				var_120_5.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPosMS2110, Vector3.New(0.68, 2.5, 1.04), (arg_117_1.time_ - 0.633333333333333) / var_120_6)
			end

			if arg_117_1.time_ >= 0.633333333333333 + var_120_6 and arg_117_1.time_ < 0.633333333333333 + var_120_6 + arg_120_0 then
				var_120_5.localPosition = Vector3.New(0.68, 2.5, 1.04)
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				local var_120_7 = arg_117_1.var_.effectluobonaend1

				if not arg_117_1.var_.effectluobonaend1 then
					var_120_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_120_7.name = "luobonaend1"
					arg_117_1.var_.effectluobonaend1 = var_120_7
				else
					var_120_7.transform:SetParent(var_120_9001)
				end

				var_120_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_120_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_117_1.time_ and arg_117_1.time_ <= 1 + arg_120_0 then
				if arg_117_1.var_.effectluobonaend1 then
					Object.Destroy(arg_117_1.var_.effectluobonaend1)

					arg_117_1.var_.effectluobonaend1 = nil
				end
			end

			local var_120_10 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_11 = 0.2

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 then
				local var_120_12 = Color.New(0, 0, 0)

				var_120_12.a = Mathf.Lerp(0, 1, (arg_117_1.time_ - var_120_10) / var_120_11)
				arg_117_1.mask_.color = var_120_12
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 then
				local var_120_13 = Color.New(0, 0, 0)

				var_120_13.a = 1
				arg_117_1.mask_.color = var_120_13
			end

			local var_120_14 = 0.2

			if 0.2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_15 = 0.1

			if var_120_14 <= arg_117_1.time_ and arg_117_1.time_ < var_120_14 + var_120_15 then
				local var_120_16 = Color.New(0, 0, 0)

				var_120_16.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - var_120_14) / var_120_15)
				arg_117_1.mask_.color = var_120_16
			end

			if arg_117_1.time_ >= var_120_14 + var_120_15 and arg_117_1.time_ < var_120_14 + var_120_15 + arg_120_0 then
				local var_120_17 = Color.New(0, 0, 0)

				arg_117_1.mask_.enabled = false
				var_120_17.a = 0
				arg_117_1.mask_.color = var_120_17
			end

			if 0.2 < arg_117_1.time_ and arg_117_1.time_ <= 0.2 + arg_120_0 then
				local var_120_18 = arg_117_1.var_.effectluobonaend2

				if not arg_117_1.var_.effectluobonaend2 then
					var_120_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_120_18.name = "luobonaend2"
					arg_117_1.var_.effectluobonaend2 = var_120_18
				else
					var_120_18.transform:SetParent(var_120_9000)
				end

				var_120_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_120_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:AudioAction("play", "effect", "se_story_141", "se_story_141_ring", "")
			end

			if 1.769 < arg_117_1.time_ and arg_117_1.time_ <= 1.769 + arg_120_0 then
				arg_117_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_bass", "")
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_22 = 2.1
			local var_120_23 = 1.7

			if 2.1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_22 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_24 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_24:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_25 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(321332027).content)

				arg_117_1.text_.text = var_120_25

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_27 = 68 <= 0 and var_120_23 or var_120_23 * (utf8.len(var_120_25) / 68)

				if (68 <= 0 and var_120_23 or var_120_23 * (utf8.len(var_120_25) / 68)) > 0 and var_120_23 < var_120_27 then
					arg_117_1.talkMaxDuration = var_120_27
					var_120_22 = var_120_22 + 0.3

					if var_120_27 + var_120_22 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_27 + var_120_22
					end
				end

				arg_117_1.text_.text = var_120_25
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_28 = var_120_22 + 0.3
			local var_120_29 = math.max(var_120_23, arg_117_1.talkMaxDuration)

			if var_120_22 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_28 + var_120_29 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_28) / var_120_29

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_28 + var_120_29 and arg_117_1.time_ < var_120_28 + var_120_29 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.183333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.9,
				className = "StoryMoveNode",
				startTime = 0.633333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play321332028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321332028
		arg_123_1.duration_ = 3.2

		local var_123_0 = {
			zh = 3.2,
			ja = 1.233
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
				arg_123_0:Play321332029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.075

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:GetWordFromCfg(321332028)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 3 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 3)

				if (3 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 3)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332028", "story_v_out_321332.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332028", "story_v_out_321332.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_out_321332", "321332028", "story_v_out_321332.awb")

						arg_123_1:RecordAudio("321332028", var_126_6)
						arg_123_1:RecordAudio("321332028", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_321332", "321332028", "story_v_out_321332.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_321332", "321332028", "story_v_out_321332.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play321332029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 321332029
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play321332030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0.05 < arg_127_1.time_ and arg_127_1.time_ <= 0.05 + arg_130_0 then
				arg_127_1:AudioAction("play", "effect", "se_story_141", "se_story_141_energy02", "")
			end

			local var_130_1 = 0
			local var_130_2 = 1.6

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_3 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(321332029).content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 64 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 64)

				if (64 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 64)) > 0 and var_130_2 < var_130_5 then
					arg_127_1.talkMaxDuration = var_130_5

					if var_130_5 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_6 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_6 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_6

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_6 and arg_127_1.time_ < var_130_1 + var_130_6 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play321332030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 321332030
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play321332031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 1.5

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(321332030).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 60 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 60)

				if (60 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 60)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play321332031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 321332031
		arg_135_1.duration_ = 5.53

		local var_135_0 = {
			zh = 3.133,
			ja = 5.533
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
				arg_135_0:Play321332032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_138_0 = 1

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				local var_138_1, var_138_2 = math.modf((arg_135_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_138_2 * 0.13, var_138_2 * 0.13, var_138_2 * 0.13) + arg_135_1.var_.shakeOldPos
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				manager.ui.mainCamera.transform.localPosition = arg_135_1.var_.shakeOldPos
			end

			local var_138_3 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_3 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			if arg_135_1.time_ >= var_138_3 + 1 and arg_135_1.time_ < var_138_3 + 1 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			local var_138_4 = 0
			local var_138_5 = 0.275

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(321332031)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 11 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 11)

				if (11 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 11)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332031", "story_v_out_321332.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_321332", "321332031", "story_v_out_321332.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_321332", "321332031", "story_v_out_321332.awb")

						arg_135_1:RecordAudio("321332031", var_138_11)
						arg_135_1:RecordAudio("321332031", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_321332", "321332031", "story_v_out_321332.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_321332", "321332031", "story_v_out_321332.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play321332032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 321332032
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play321332033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 1.3

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(321332032).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 52 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 52)

				if (52 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 52)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play321332033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321332033
		arg_143_1.duration_ = 4.63

		local var_143_0 = {
			zh = 3.633,
			ja = 4.633
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play321332034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.3

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_1")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:GetWordFromCfg(321332033)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 12 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 12)

				if (12 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 12)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332033", "story_v_out_321332.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332033", "story_v_out_321332.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_321332", "321332033", "story_v_out_321332.awb")

						arg_143_1:RecordAudio("321332033", var_146_6)
						arg_143_1:RecordAudio("321332033", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_321332", "321332033", "story_v_out_321332.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_321332", "321332033", "story_v_out_321332.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play321332034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321332034
		arg_147_1.duration_ = 3.53

		local var_147_0 = {
			zh = 3.533,
			ja = 3.2
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
				arg_147_0:Play321332035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1061ui_story"]) and arg_147_1.var_.characterEffect1061ui_story == nil then
				arg_147_1.var_.characterEffect1061ui_story = arg_147_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1061ui_story"]) then
				if arg_147_1.var_.characterEffect1061ui_story and not isNil(arg_147_1.actors_["1061ui_story"]) then
					arg_147_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1061ui_story"]) and arg_147_1.var_.characterEffect1061ui_story then
				arg_147_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.15

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(321332034)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_6 = 6 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_4) / 6)

				if (6 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_4) / 6)) > 0 and var_150_2 < var_150_6 then
					arg_147_1.talkMaxDuration = var_150_6

					if var_150_6 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332034", "story_v_out_321332.awb") ~= 0 then
					local var_150_7 = manager.audio:GetVoiceLength("story_v_out_321332", "321332034", "story_v_out_321332.awb") / 1000

					if var_150_7 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_1
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_321332", "321332034", "story_v_out_321332.awb")

						arg_147_1:RecordAudio("321332034", var_150_8)
						arg_147_1:RecordAudio("321332034", var_150_8)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_321332", "321332034", "story_v_out_321332.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_321332", "321332034", "story_v_out_321332.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_9 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_9 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_9

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_9 and arg_147_1.time_ < var_150_1 + var_150_9 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play321332035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321332035
		arg_151_1.duration_ = 6.8

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play321332036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1061ui_story = arg_151_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1061ui_story"].transform.position).z)
				arg_151_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1061ui_story"].transform.localEulerAngles = arg_151_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1061ui_story"].transform.position).z)
				arg_151_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1061ui_story"].transform.localEulerAngles = arg_151_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_154_1 = 0

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_2 = 1

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = Color.New(1, 1, 1)

				var_154_3.a = Mathf.Lerp(0, 1, (arg_151_1.time_ - var_154_1) / var_154_2)
				arg_151_1.mask_.color = var_154_3
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				local var_154_4 = Color.New(1, 1, 1)

				var_154_4.a = 1
				arg_151_1.mask_.color = var_154_4
			end

			local var_154_5 = 1

			if 1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_6 = 1

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_6 then
				local var_154_7 = Color.New(1, 1, 1)

				var_154_7.a = Mathf.Lerp(1, 0, (arg_151_1.time_ - var_154_5) / var_154_6)
				arg_151_1.mask_.color = var_154_7
			end

			if arg_151_1.time_ >= var_154_5 + var_154_6 and arg_151_1.time_ < var_154_5 + var_154_6 + arg_154_0 then
				local var_154_8 = Color.New(1, 1, 1)

				arg_151_1.mask_.enabled = false
				var_154_8.a = 0
				arg_151_1.mask_.color = var_154_8
			end

			local var_154_9 = 1.8
			local var_154_10 = 1.575

			if 1.8 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_11 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(321332035).content)

				arg_151_1.text_.text = var_154_11

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 63 <= 0 and var_154_10 or var_154_10 * (utf8.len(var_154_11) / 63)

				if (63 <= 0 and var_154_10 or var_154_10 * (utf8.len(var_154_11) / 63)) > 0 and var_154_10 < var_154_13 then
					arg_151_1.talkMaxDuration = var_154_13

					if var_154_13 + var_154_9 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_13 + var_154_9
					end
				end

				arg_151_1.text_.text = var_154_11
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_14 = math.max(var_154_10, arg_151_1.talkMaxDuration)

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_14 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_9) / var_154_14

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_9 + var_154_14 and arg_151_1.time_ < var_154_9 + var_154_14 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play321332036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 321332036
		arg_155_1.duration_ = 5.97

		local var_155_0 = {
			zh = 4.833,
			ja = 5.966
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play321332037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.225

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(321332036)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 9 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 9)

				if (9 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 9)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332036", "story_v_out_321332.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332036", "story_v_out_321332.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_321332", "321332036", "story_v_out_321332.awb")

						arg_155_1:RecordAudio("321332036", var_158_6)
						arg_155_1:RecordAudio("321332036", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_321332", "321332036", "story_v_out_321332.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_321332", "321332036", "story_v_out_321332.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play321332037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 321332037
		arg_159_1.duration_ = 7.43

		local var_159_0 = {
			zh = 7.433,
			ja = 6.766
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play321332038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_162_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_159_1.bgmTxt_.text ~= var_162_2 and arg_159_1.bgmTxt_.text ~= "" then
						if arg_159_1.bgmTxt2_.text ~= "" then
							arg_159_1.bgmTxt_.text = arg_159_1.bgmTxt2_.text
						end

						arg_159_1.bgmTxt2_.text = var_162_2

						arg_159_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_159_1.bgmTxt_.text = var_162_2
						arg_159_1.bgmTxt2_.text = var_162_2
					end

					if arg_159_1.bgmTimer then
						arg_159_1.bgmTimer:Stop()

						arg_159_1.bgmTimer = nil
					end

					if arg_159_1.settingData.show_music_name == 1 then
						arg_159_1.musicController:SetSelectedState("show")
						arg_159_1.musicAnimator_:Play("open", 0, 0)

						if arg_159_1.settingData.music_time ~= 0 then
							arg_159_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_159_1.settingData.music_time), function()
								if arg_159_1 == nil or isNil(arg_159_1.bgmTxt_) then
									return
								end

								arg_159_1.musicController:SetSelectedState("hide")
								arg_159_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_162_3 = 0
			local var_162_4 = 0.375

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_3 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_5 = arg_159_1:GetWordFromCfg(321332037)
				local var_162_6 = arg_159_1:FormatText(var_162_5.content)

				arg_159_1.text_.text = var_162_6

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_8 = 15 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_6) / 15)

				if (15 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_6) / 15)) > 0 and var_162_4 < var_162_8 then
					arg_159_1.talkMaxDuration = var_162_8

					if var_162_8 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_3
					end
				end

				arg_159_1.text_.text = var_162_6
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332037", "story_v_out_321332.awb") ~= 0 then
					local var_162_9 = manager.audio:GetVoiceLength("story_v_out_321332", "321332037", "story_v_out_321332.awb") / 1000

					if var_162_9 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_3
					end

					if var_162_5.prefab_name ~= "" and arg_159_1.actors_[var_162_5.prefab_name] ~= nil then
						local var_162_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_5.prefab_name].transform, "story_v_out_321332", "321332037", "story_v_out_321332.awb")

						arg_159_1:RecordAudio("321332037", var_162_10)
						arg_159_1:RecordAudio("321332037", var_162_10)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_321332", "321332037", "story_v_out_321332.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_321332", "321332037", "story_v_out_321332.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_11 = math.max(var_162_4, arg_159_1.talkMaxDuration)

			if var_162_3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_3 + var_162_11 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_3) / var_162_11

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_3 + var_162_11 and arg_159_1.time_ < var_162_3 + var_162_11 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play321332038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 321332038
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play321332039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0.15 < arg_164_1.time_ and arg_164_1.time_ <= 0.15 + arg_167_0 then
				arg_164_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_whoosh01", "")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_bass", "")
			end

			local var_167_2 = 0
			local var_167_3 = 1.15

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_2 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_4 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(321332038).content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_6 = 46 <= 0 and var_167_3 or var_167_3 * (utf8.len(var_167_4) / 46)

				if (46 <= 0 and var_167_3 or var_167_3 * (utf8.len(var_167_4) / 46)) > 0 and var_167_3 < var_167_6 then
					arg_164_1.talkMaxDuration = var_167_6

					if var_167_6 + var_167_2 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_6 + var_167_2
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_7 = math.max(var_167_3, arg_164_1.talkMaxDuration)

			if var_167_2 <= arg_164_1.time_ and arg_164_1.time_ < var_167_2 + var_167_7 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_2) / var_167_7

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_2 + var_167_7 and arg_164_1.time_ < var_167_2 + var_167_7 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play321332039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 321332039
		arg_168_1.duration_ = 11.22

		local var_168_0 = {
			zh = 9.216,
			ja = 11.216
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
				arg_168_0:Play321332040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_9000

			if arg_168_1.bgs_.STwhite == nil then
				local var_171_0 = Object.Instantiate(arg_168_1.paintGo_)

				var_171_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_171_0.name = "STwhite"
				var_171_0.transform.parent = arg_168_1.stage_.transform
				var_171_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_168_1.bgs_.STwhite = var_171_0
			end

			if 0.5 < arg_168_1.time_ and arg_168_1.time_ <= 0.5 + arg_171_0 then
				local var_171_1 = arg_168_1.bgs_.STwhite

				arg_168_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_171_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_171_2 = var_171_1:GetComponent("SpriteRenderer")

				if var_171_2 and var_171_2.sprite then
					local var_171_3 = 2 * (var_171_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_171_1.transform.localScale = Vector3.New(var_171_3 / var_171_2.sprite.bounds.size.y < var_171_3 * manager.ui.mainCameraCom_.aspect / var_171_2.sprite.bounds.size.x and var_171_3 * manager.ui.mainCameraCom_.aspect / var_171_2.sprite.bounds.size.x or var_171_3 / var_171_2.sprite.bounds.size.y, var_171_3 / var_171_2.sprite.bounds.size.y < var_171_3 * manager.ui.mainCameraCom_.aspect / var_171_2.sprite.bounds.size.x and var_171_3 * manager.ui.mainCameraCom_.aspect / var_171_2.sprite.bounds.size.x or var_171_3 / var_171_2.sprite.bounds.size.y, 0)
				end

				for iter_171_0, iter_171_1 in pairs(arg_168_1.bgs_) do
					if iter_171_0 ~= "STwhite" then
						iter_171_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_171_4 = 0

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.mask_.enabled = true
				arg_168_1.mask_.raycastTarget = true

				arg_168_1:SetGaussion(false)
			end

			local var_171_5 = 0.5

			if var_171_4 <= arg_168_1.time_ and arg_168_1.time_ < var_171_4 + var_171_5 then
				local var_171_6 = Color.New(1, 1, 1)

				var_171_6.a = Mathf.Lerp(0, 1, (arg_168_1.time_ - var_171_4) / var_171_5)
				arg_168_1.mask_.color = var_171_6
			end

			if arg_168_1.time_ >= var_171_4 + var_171_5 and arg_168_1.time_ < var_171_4 + var_171_5 + arg_171_0 then
				local var_171_7 = Color.New(1, 1, 1)

				var_171_7.a = 1
				arg_168_1.mask_.color = var_171_7
			end

			local var_171_8 = 0.5

			if 0.5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 then
				arg_168_1.mask_.enabled = true
				arg_168_1.mask_.raycastTarget = true

				arg_168_1:SetGaussion(false)
			end

			local var_171_9 = 3

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_9 then
				local var_171_10 = Color.New(1, 1, 1)

				var_171_10.a = Mathf.Lerp(1, 0, (arg_168_1.time_ - var_171_8) / var_171_9)
				arg_168_1.mask_.color = var_171_10
			end

			if arg_168_1.time_ >= var_171_8 + var_171_9 and arg_168_1.time_ < var_171_8 + var_171_9 + arg_171_0 then
				local var_171_11 = Color.New(1, 1, 1)

				arg_168_1.mask_.enabled = false
				var_171_11.a = 0
				arg_168_1.mask_.color = var_171_11
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				local var_171_12 = arg_168_1.var_.effectluobonazhengzha1

				if not arg_168_1.var_.effectluobonazhengzha1 then
					var_171_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_171_12.name = "luobonazhengzha1"
					arg_168_1.var_.effectluobonazhengzha1 = var_171_12
				else
					var_171_12.transform:SetParent(var_171_9000)
				end

				var_171_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_171_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_168_1.time_ and arg_168_1.time_ <= 2 + arg_171_0 then
				if arg_168_1.var_.effectluobonazhengzha1 then
					Object.Destroy(arg_168_1.var_.effectluobonazhengzha1)

					arg_168_1.var_.effectluobonazhengzha1 = nil
				end
			end

			if 0.5 < arg_168_1.time_ and arg_168_1.time_ <= 0.5 + arg_171_0 then
				if arg_168_1.var_.effectluobonaend2 then
					Object.Destroy(arg_168_1.var_.effectluobonaend2)

					arg_168_1.var_.effectluobonaend2 = nil
				end
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_boxing_cheer01", "")
			end

			if 2.517 < arg_168_1.time_ and arg_168_1.time_ <= 2.517 + arg_171_0 then
				arg_168_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_amb_hit01_loop", "")
			end

			if arg_168_1.frameCnt_ <= 1 then
				arg_168_1.dialog_:SetActive(false)
			end

			local var_171_18 = 3.15
			local var_171_19 = 0.35

			if 3.15 < arg_168_1.time_ and arg_168_1.time_ <= var_171_18 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0

				arg_168_1.dialog_:SetActive(true)

				arg_168_1.dialogCg_.alpha = 0

				local var_171_20 = LeanTween.value(arg_168_1.dialog_, 0, 1, 0.3)

				var_171_20:setOnUpdate(LuaHelper.FloatAction(function(arg_172_0)
					arg_168_1.dialogCg_.alpha = arg_172_0
				end))
				var_171_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_168_1.dialog_)
					var_171_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_168_1.duration_ = arg_168_1.duration_ + 0.3

				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_21 = arg_168_1:GetWordFromCfg(321332039)
				local var_171_22 = arg_168_1:FormatText(var_171_21.content)

				arg_168_1.text_.text = var_171_22

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_24 = 14 <= 0 and var_171_19 or var_171_19 * (utf8.len(var_171_22) / 14)

				if (14 <= 0 and var_171_19 or var_171_19 * (utf8.len(var_171_22) / 14)) > 0 and var_171_19 < var_171_24 then
					arg_168_1.talkMaxDuration = var_171_24
					var_171_18 = var_171_18 + 0.3

					if var_171_24 + var_171_18 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_24 + var_171_18
					end
				end

				arg_168_1.text_.text = var_171_22
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332039", "story_v_out_321332.awb") ~= 0 then
					local var_171_25 = manager.audio:GetVoiceLength("story_v_out_321332", "321332039", "story_v_out_321332.awb") / 1000

					if var_171_25 + var_171_18 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_25 + var_171_18
					end

					if var_171_21.prefab_name ~= "" and arg_168_1.actors_[var_171_21.prefab_name] ~= nil then
						local var_171_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_21.prefab_name].transform, "story_v_out_321332", "321332039", "story_v_out_321332.awb")

						arg_168_1:RecordAudio("321332039", var_171_26)
						arg_168_1:RecordAudio("321332039", var_171_26)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_321332", "321332039", "story_v_out_321332.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_321332", "321332039", "story_v_out_321332.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_27 = var_171_18 + 0.3
			local var_171_28 = math.max(var_171_19, arg_168_1.talkMaxDuration)

			if var_171_18 + 0.3 <= arg_168_1.time_ and arg_168_1.time_ < var_171_27 + var_171_28 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_27) / var_171_28

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_27 + var_171_28 and arg_168_1.time_ < var_171_27 + var_171_28 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play321332040 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 321332040
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play321332041(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 1.55

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_1 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(321332040).content)

				arg_174_1.text_.text = var_177_1

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_3 = 62 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 62)

				if (62 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 62)) > 0 and var_177_0 < var_177_3 then
					arg_174_1.talkMaxDuration = var_177_3

					if var_177_3 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_3 + 0
					end
				end

				arg_174_1.text_.text = var_177_1
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_4 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_4

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play321332041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 321332041
		arg_178_1.duration_ = 9.3

		local var_178_0 = {
			zh = 5.2,
			ja = 9.3
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play321332042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0.375

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_1 = arg_178_1:GetWordFromCfg(321332041)
				local var_181_2 = arg_178_1:FormatText(var_181_1.content)

				arg_178_1.text_.text = var_181_2

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_4 = 15 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 15)

				if (15 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 15)) > 0 and var_181_0 < var_181_4 then
					arg_178_1.talkMaxDuration = var_181_4

					if var_181_4 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_4 + 0
					end
				end

				arg_178_1.text_.text = var_181_2
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332041", "story_v_out_321332.awb") ~= 0 then
					local var_181_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332041", "story_v_out_321332.awb") / 1000

					if var_181_5 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + 0
					end

					if var_181_1.prefab_name ~= "" and arg_178_1.actors_[var_181_1.prefab_name] ~= nil then
						local var_181_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_1.prefab_name].transform, "story_v_out_321332", "321332041", "story_v_out_321332.awb")

						arg_178_1:RecordAudio("321332041", var_181_6)
						arg_178_1:RecordAudio("321332041", var_181_6)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_321332", "321332041", "story_v_out_321332.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_321332", "321332041", "story_v_out_321332.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play321332042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 321332042
		arg_182_1.duration_ = 8.23

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play321332043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_9002
			local var_185_9001
			local var_185_9000

			if arg_182_1.bgs_.ST65 == nil then
				local var_185_0 = Object.Instantiate(arg_182_1.paintGo_)

				var_185_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST65")
				var_185_0.name = "ST65"
				var_185_0.transform.parent = arg_182_1.stage_.transform
				var_185_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_182_1.bgs_.ST65 = var_185_0
			end

			if 2.33333333333333 < arg_182_1.time_ and arg_182_1.time_ <= 2.33333333333333 + arg_185_0 then
				local var_185_1 = arg_182_1.bgs_.ST65

				arg_182_1.bgs_.ST65.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_185_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_185_2 = var_185_1:GetComponent("SpriteRenderer")

				if var_185_2 and var_185_2.sprite then
					local var_185_3 = 2 * (var_185_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_185_1.transform.localScale = Vector3.New(var_185_3 / var_185_2.sprite.bounds.size.y < var_185_3 * manager.ui.mainCameraCom_.aspect / var_185_2.sprite.bounds.size.x and var_185_3 * manager.ui.mainCameraCom_.aspect / var_185_2.sprite.bounds.size.x or var_185_3 / var_185_2.sprite.bounds.size.y, var_185_3 / var_185_2.sprite.bounds.size.y < var_185_3 * manager.ui.mainCameraCom_.aspect / var_185_2.sprite.bounds.size.x and var_185_3 * manager.ui.mainCameraCom_.aspect / var_185_2.sprite.bounds.size.x or var_185_3 / var_185_2.sprite.bounds.size.y, 0)
				end

				for iter_185_0, iter_185_1 in pairs(arg_182_1.bgs_) do
					if iter_185_0 ~= "ST65" then
						iter_185_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_185_4 = 2.83333333333333

			if 2.83333333333333 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.allBtn_.enabled = false
			end

			if arg_182_1.time_ >= var_185_4 + 0.3 and arg_182_1.time_ < var_185_4 + 0.3 + arg_185_0 then
				arg_182_1.allBtn_.enabled = true
			end

			if 0.833333333333333 < arg_182_1.time_ and arg_182_1.time_ <= 0.833333333333333 + arg_185_0 then
				local var_185_5 = arg_182_1.var_.effectluobonazhuanchang1

				if not arg_182_1.var_.effectluobonazhuanchang1 then
					var_185_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), manager.ui.mainCamera.transform)
					var_185_5.name = "luobonazhuanchang1"
					arg_182_1.var_.effectluobonazhuanchang1 = var_185_5
				else
					var_185_5.transform:SetParent(var_185_9002)
				end

				var_185_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_185_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.33333333333333 < arg_182_1.time_ and arg_182_1.time_ <= 2.33333333333333 + arg_185_0 then
				local var_185_7 = arg_182_1.var_.effectluobonazhuanchang2

				if not arg_182_1.var_.effectluobonazhuanchang2 then
					var_185_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_185_7.name = "luobonazhuanchang2"
					arg_182_1.var_.effectluobonazhuanchang2 = var_185_7
				else
					var_185_7.transform:SetParent(var_185_9001)
				end

				var_185_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_185_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.33333333333333 < arg_182_1.time_ and arg_182_1.time_ <= 2.33333333333333 + arg_185_0 then
				if arg_182_1.var_.effectluobonazhuanchang1 then
					Object.Destroy(arg_182_1.var_.effectluobonazhuanchang1)

					arg_182_1.var_.effectluobonazhuanchang1 = nil
				end
			end

			if 2.33333333333333 < arg_182_1.time_ and arg_182_1.time_ <= 2.33333333333333 + arg_185_0 then
				local var_185_10 = arg_182_1.var_.effectluobonazhuanchang3

				if not arg_182_1.var_.effectluobonazhuanchang3 then
					var_185_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), manager.ui.mainCamera.transform)
					var_185_10.name = "luobonazhuanchang3"
					arg_182_1.var_.effectluobonazhuanchang3 = var_185_10
				else
					var_185_10.transform:SetParent(var_185_9000)
				end

				var_185_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_185_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_whoosh02", "")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_boxing_amb_hit01_loop", "")
			end

			if 1.732 < arg_182_1.time_ and arg_182_1.time_ <= 1.732 + arg_185_0 then
				arg_182_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_boxing_cheer01", "")
			end

			if 2.168 < arg_182_1.time_ and arg_182_1.time_ <= 2.168 + arg_185_0 then
				arg_182_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_boxing_cheer02", "")
			end

			if 2.954 < arg_182_1.time_ and arg_182_1.time_ <= 2.954 + arg_185_0 then
				arg_182_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_amb_hit02_loop", "")
			end

			if arg_182_1.frameCnt_ <= 1 then
				arg_182_1.dialog_:SetActive(false)
			end

			local var_185_17 = 3.23333333333333
			local var_185_18 = 0.525

			if 3.23333333333333 < arg_182_1.time_ and arg_182_1.time_ <= var_185_17 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0

				arg_182_1.dialog_:SetActive(true)

				arg_182_1.dialogCg_.alpha = 0

				local var_185_19 = LeanTween.value(arg_182_1.dialog_, 0, 1, 0.3)

				var_185_19:setOnUpdate(LuaHelper.FloatAction(function(arg_186_0)
					arg_182_1.dialogCg_.alpha = arg_186_0
				end))
				var_185_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_182_1.dialog_)
					var_185_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_182_1.duration_ = arg_182_1.duration_ + 0.3

				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_20 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(321332042).content)

				arg_182_1.text_.text = var_185_20

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_22 = 21 <= 0 and var_185_18 or var_185_18 * (utf8.len(var_185_20) / 21)

				if (21 <= 0 and var_185_18 or var_185_18 * (utf8.len(var_185_20) / 21)) > 0 and var_185_18 < var_185_22 then
					arg_182_1.talkMaxDuration = var_185_22
					var_185_17 = var_185_17 + 0.3

					if var_185_22 + var_185_17 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_22 + var_185_17
					end
				end

				arg_182_1.text_.text = var_185_20
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_23 = var_185_17 + 0.3
			local var_185_24 = math.max(var_185_18, arg_182_1.talkMaxDuration)

			if var_185_17 + 0.3 <= arg_182_1.time_ and arg_182_1.time_ < var_185_23 + var_185_24 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_23) / var_185_24

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_23 + var_185_24 and arg_182_1.time_ < var_185_23 + var_185_24 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play321332043 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 321332043
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play321332044(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 1.3

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_1 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(321332043).content)

				arg_188_1.text_.text = var_191_1

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_3 = 52 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 52)

				if (52 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 52)) > 0 and var_191_0 < var_191_3 then
					arg_188_1.talkMaxDuration = var_191_3

					if var_191_3 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_3 + 0
					end
				end

				arg_188_1.text_.text = var_191_1
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_4 = math.max(var_191_0, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - 0) / var_191_4

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play321332044 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 321332044
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play321332045(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 1.05

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_1 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(321332044).content)

				arg_192_1.text_.text = var_195_1

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_3 = 42 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 42)

				if (42 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 42)) > 0 and var_195_0 < var_195_3 then
					arg_192_1.talkMaxDuration = var_195_3

					if var_195_3 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_3 + 0
					end
				end

				arg_192_1.text_.text = var_195_1
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_4 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_4

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play321332045 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 321332045
		arg_196_1.duration_ = 6.33

		local var_196_0 = {
			zh = 6.333,
			ja = 6.166
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play321332046(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0.35

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10017")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_1 = arg_196_1:GetWordFromCfg(321332045)
				local var_199_2 = arg_196_1:FormatText(var_199_1.content)

				arg_196_1.text_.text = var_199_2

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_4 = 14 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 14)

				if (14 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 14)) > 0 and var_199_0 < var_199_4 then
					arg_196_1.talkMaxDuration = var_199_4

					if var_199_4 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_4 + 0
					end
				end

				arg_196_1.text_.text = var_199_2
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332045", "story_v_out_321332.awb") ~= 0 then
					local var_199_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332045", "story_v_out_321332.awb") / 1000

					if var_199_5 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + 0
					end

					if var_199_1.prefab_name ~= "" and arg_196_1.actors_[var_199_1.prefab_name] ~= nil then
						local var_199_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_1.prefab_name].transform, "story_v_out_321332", "321332045", "story_v_out_321332.awb")

						arg_196_1:RecordAudio("321332045", var_199_6)
						arg_196_1:RecordAudio("321332045", var_199_6)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_321332", "321332045", "story_v_out_321332.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_321332", "321332045", "story_v_out_321332.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_0, arg_196_1.talkMaxDuration)

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - 0) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= 0 + var_199_7 and arg_196_1.time_ < 0 + var_199_7 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play321332046 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 321332046
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play321332047(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 1.65

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(321332046).content)

				arg_200_1.text_.text = var_203_1

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_3 = 66 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 66)

				if (66 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 66)) > 0 and var_203_0 < var_203_3 then
					arg_200_1.talkMaxDuration = var_203_3

					if var_203_3 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_3 + 0
					end
				end

				arg_200_1.text_.text = var_203_1
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_4 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_4

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play321332047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 321332047
		arg_204_1.duration_ = 9.9

		local var_204_0 = {
			zh = 6.5,
			ja = 9.9
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play321332048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.45

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1211].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10035_split_1")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_1 = arg_204_1:GetWordFromCfg(321332047)
				local var_207_2 = arg_204_1:FormatText(var_207_1.content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 18 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 18)

				if (18 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 18)) > 0 and var_207_0 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + 0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332047", "story_v_out_321332.awb") ~= 0 then
					local var_207_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332047", "story_v_out_321332.awb") / 1000

					if var_207_5 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + 0
					end

					if var_207_1.prefab_name ~= "" and arg_204_1.actors_[var_207_1.prefab_name] ~= nil then
						local var_207_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_1.prefab_name].transform, "story_v_out_321332", "321332047", "story_v_out_321332.awb")

						arg_204_1:RecordAudio("321332047", var_207_6)
						arg_204_1:RecordAudio("321332047", var_207_6)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_321332", "321332047", "story_v_out_321332.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_321332", "321332047", "story_v_out_321332.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play321332048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 321332048
		arg_208_1.duration_ = 8.8

		local var_208_0 = {
			zh = 8.4,
			ja = 8.8
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play321332049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 5.441 < arg_208_1.time_ and arg_208_1.time_ <= 5.441 + arg_211_0 then
				arg_208_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_fight01", "")
			end

			if 0.05 < arg_208_1.time_ and arg_208_1.time_ <= 0.05 + arg_211_0 then
				arg_208_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_boxing_amb_hit02_loop", "")
			end

			local var_211_2 = 0
			local var_211_3 = 0.575

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_2 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10017")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_4 = arg_208_1:GetWordFromCfg(321332048)
				local var_211_5 = arg_208_1:FormatText(var_211_4.content)

				arg_208_1.text_.text = var_211_5

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_7 = 23 <= 0 and var_211_3 or var_211_3 * (utf8.len(var_211_5) / 23)

				if (23 <= 0 and var_211_3 or var_211_3 * (utf8.len(var_211_5) / 23)) > 0 and var_211_3 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_2 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_2
					end
				end

				arg_208_1.text_.text = var_211_5
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332048", "story_v_out_321332.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332048", "story_v_out_321332.awb") / 1000

					if var_211_8 + var_211_2 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_2
					end

					if var_211_4.prefab_name ~= "" and arg_208_1.actors_[var_211_4.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_4.prefab_name].transform, "story_v_out_321332", "321332048", "story_v_out_321332.awb")

						arg_208_1:RecordAudio("321332048", var_211_9)
						arg_208_1:RecordAudio("321332048", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_321332", "321332048", "story_v_out_321332.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_321332", "321332048", "story_v_out_321332.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_10 = math.max(var_211_3, arg_208_1.talkMaxDuration)

			if var_211_2 <= arg_208_1.time_ and arg_208_1.time_ < var_211_2 + var_211_10 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_2) / var_211_10

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_2 + var_211_10 and arg_208_1.time_ < var_211_2 + var_211_10 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play321332049 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 321332049
		arg_212_1.duration_ = 6.67

		local var_212_0 = {
			zh = 4.833,
			ja = 6.666
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play321332050(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0.275

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10017")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_1 = arg_212_1:GetWordFromCfg(321332049)
				local var_215_2 = arg_212_1:FormatText(var_215_1.content)

				arg_212_1.text_.text = var_215_2

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 11 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 11)

				if (11 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 11)) > 0 and var_215_0 < var_215_4 then
					arg_212_1.talkMaxDuration = var_215_4

					if var_215_4 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_4 + 0
					end
				end

				arg_212_1.text_.text = var_215_2
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332049", "story_v_out_321332.awb") ~= 0 then
					local var_215_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332049", "story_v_out_321332.awb") / 1000

					if var_215_5 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + 0
					end

					if var_215_1.prefab_name ~= "" and arg_212_1.actors_[var_215_1.prefab_name] ~= nil then
						local var_215_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_1.prefab_name].transform, "story_v_out_321332", "321332049", "story_v_out_321332.awb")

						arg_212_1:RecordAudio("321332049", var_215_6)
						arg_212_1:RecordAudio("321332049", var_215_6)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_321332", "321332049", "story_v_out_321332.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_321332", "321332049", "story_v_out_321332.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play321332050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 321332050
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play321332051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0.05 < arg_216_1.time_ and arg_216_1.time_ <= 0.05 + arg_219_0 then
				arg_216_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_fight02", "")
			end

			local var_219_1 = 0
			local var_219_2 = 0.825

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_3 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(321332050).content)

				arg_216_1.text_.text = var_219_3

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 33 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 33)

				if (33 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 33)) > 0 and var_219_2 < var_219_5 then
					arg_216_1.talkMaxDuration = var_219_5

					if var_219_5 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + var_219_1
					end
				end

				arg_216_1.text_.text = var_219_3
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_6 = math.max(var_219_2, arg_216_1.talkMaxDuration)

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_6 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_1) / var_219_6

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_1 + var_219_6 and arg_216_1.time_ < var_219_1 + var_219_6 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play321332051 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 321332051
		arg_220_1.duration_ = 6

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play321332052(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_223_0 = 1

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 then
				local var_223_1, var_223_2 = math.modf((arg_220_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_223_2 * 0.13, var_223_2 * 0.13, var_223_2 * 0.13) + arg_220_1.var_.shakeOldPos
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 then
				manager.ui.mainCamera.transform.localPosition = arg_220_1.var_.shakeOldPos
			end

			local var_223_3 = 0

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_3 + arg_223_0 then
				arg_220_1.allBtn_.enabled = false
			end

			if arg_220_1.time_ >= var_223_3 + 1 and arg_220_1.time_ < var_223_3 + 1 + arg_223_0 then
				arg_220_1.allBtn_.enabled = true
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_fight03", "")
			end

			if arg_220_1.frameCnt_ <= 1 then
				arg_220_1.dialog_:SetActive(false)
			end

			local var_223_5 = 1
			local var_223_6 = 0.825

			if 1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0

				arg_220_1.dialog_:SetActive(true)

				arg_220_1.dialogCg_.alpha = 0

				local var_223_7 = LeanTween.value(arg_220_1.dialog_, 0, 1, 0.3)

				var_223_7:setOnUpdate(LuaHelper.FloatAction(function(arg_224_0)
					arg_220_1.dialogCg_.alpha = arg_224_0
				end))
				var_223_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_220_1.dialog_)
					var_223_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_220_1.duration_ = arg_220_1.duration_ + 0.3

				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_8 = arg_220_1:FormatText(arg_220_1:GetWordFromCfg(321332051).content)

				arg_220_1.text_.text = var_223_8

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_10 = 33 <= 0 and var_223_6 or var_223_6 * (utf8.len(var_223_8) / 33)

				if (33 <= 0 and var_223_6 or var_223_6 * (utf8.len(var_223_8) / 33)) > 0 and var_223_6 < var_223_10 then
					arg_220_1.talkMaxDuration = var_223_10
					var_223_5 = var_223_5 + 0.3

					if var_223_10 + var_223_5 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_5
					end
				end

				arg_220_1.text_.text = var_223_8
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_11 = var_223_5 + 0.3
			local var_223_12 = math.max(var_223_6, arg_220_1.talkMaxDuration)

			if var_223_5 + 0.3 <= arg_220_1.time_ and arg_220_1.time_ < var_223_11 + var_223_12 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_11) / var_223_12

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_11 + var_223_12 and arg_220_1.time_ < var_223_11 + var_223_12 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play321332052 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 321332052
		arg_226_1.duration_ = 10.23

		local var_226_0 = {
			zh = 9.933,
			ja = 10.233
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play321332053(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_9000

			if arg_226_1.bgs_.L01g == nil then
				local var_229_0 = Object.Instantiate(arg_226_1.paintGo_)

				var_229_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L01g")
				var_229_0.name = "L01g"
				var_229_0.transform.parent = arg_226_1.stage_.transform
				var_229_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_226_1.bgs_.L01g = var_229_0
			end

			if 0.5 < arg_226_1.time_ and arg_226_1.time_ <= 0.5 + arg_229_0 then
				local var_229_1 = arg_226_1.bgs_.L01g

				arg_226_1.bgs_.L01g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_229_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_229_2 = var_229_1:GetComponent("SpriteRenderer")

				if var_229_2 and var_229_2.sprite then
					local var_229_3 = 2 * (var_229_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_229_1.transform.localScale = Vector3.New(var_229_3 / var_229_2.sprite.bounds.size.y < var_229_3 * manager.ui.mainCameraCom_.aspect / var_229_2.sprite.bounds.size.x and var_229_3 * manager.ui.mainCameraCom_.aspect / var_229_2.sprite.bounds.size.x or var_229_3 / var_229_2.sprite.bounds.size.y, var_229_3 / var_229_2.sprite.bounds.size.y < var_229_3 * manager.ui.mainCameraCom_.aspect / var_229_2.sprite.bounds.size.x and var_229_3 * manager.ui.mainCameraCom_.aspect / var_229_2.sprite.bounds.size.x or var_229_3 / var_229_2.sprite.bounds.size.y, 0)
				end

				for iter_229_0, iter_229_1 in pairs(arg_226_1.bgs_) do
					if iter_229_0 ~= "L01g" then
						iter_229_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_229_4 = 2

			if 2 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1.allBtn_.enabled = false
			end

			if arg_226_1.time_ >= var_229_4 + 0.3 and arg_226_1.time_ < var_229_4 + 0.3 + arg_229_0 then
				arg_226_1.allBtn_.enabled = true
			end

			local var_229_5 = 0

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 then
				arg_226_1.mask_.enabled = true
				arg_226_1.mask_.raycastTarget = true

				arg_226_1:SetGaussion(false)
			end

			local var_229_6 = 0.5

			if var_229_5 <= arg_226_1.time_ and arg_226_1.time_ < var_229_5 + var_229_6 then
				local var_229_7 = Color.New(0, 0, 0)

				var_229_7.a = Mathf.Lerp(0, 1, (arg_226_1.time_ - var_229_5) / var_229_6)
				arg_226_1.mask_.color = var_229_7
			end

			if arg_226_1.time_ >= var_229_5 + var_229_6 and arg_226_1.time_ < var_229_5 + var_229_6 + arg_229_0 then
				local var_229_8 = Color.New(0, 0, 0)

				var_229_8.a = 1
				arg_226_1.mask_.color = var_229_8
			end

			local var_229_9 = 0.5

			if 0.5 < arg_226_1.time_ and arg_226_1.time_ <= var_229_9 + arg_229_0 then
				arg_226_1.mask_.enabled = true
				arg_226_1.mask_.raycastTarget = true

				arg_226_1:SetGaussion(false)
			end

			local var_229_10 = 1.5

			if var_229_9 <= arg_226_1.time_ and arg_226_1.time_ < var_229_9 + var_229_10 then
				local var_229_11 = Color.New(0, 0, 0)

				var_229_11.a = Mathf.Lerp(1, 0, (arg_226_1.time_ - var_229_9) / var_229_10)
				arg_226_1.mask_.color = var_229_11
			end

			if arg_226_1.time_ >= var_229_9 + var_229_10 and arg_226_1.time_ < var_229_9 + var_229_10 + arg_229_0 then
				local var_229_12 = Color.New(0, 0, 0)

				arg_226_1.mask_.enabled = false
				var_229_12.a = 0
				arg_226_1.mask_.color = var_229_12
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				local var_229_13 = arg_226_1.var_.effectluobona1

				if not arg_226_1.var_.effectluobona1 then
					var_229_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_229_13.name = "luobona1"
					arg_226_1.var_.effectluobona1 = var_229_13
				else
					var_229_13.transform:SetParent(var_229_9000)
				end

				var_229_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_229_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_226_1.time_ and arg_226_1.time_ <= 1 + arg_229_0 then
				if arg_226_1.var_.effectluobona1 then
					Object.Destroy(arg_226_1.var_.effectluobona1)

					arg_226_1.var_.effectluobona1 = nil
				end
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_whoosh03", "")
			end

			if 2.5 < arg_226_1.time_ and arg_226_1.time_ <= 2.5 + arg_229_0 then
				arg_226_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum01", "")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_boxing_cheer02", "")
			end

			if 0.613 < arg_226_1.time_ and arg_226_1.time_ <= 0.613 + arg_229_0 then
				arg_226_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_amb_cheer03_loop", "")
			end

			if arg_226_1.frameCnt_ <= 1 then
				arg_226_1.dialog_:SetActive(false)
			end

			local var_229_20 = 2
			local var_229_21 = 0.55

			if 2 < arg_226_1.time_ and arg_226_1.time_ <= var_229_20 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0

				arg_226_1.dialog_:SetActive(true)

				arg_226_1.dialogCg_.alpha = 0

				local var_229_22 = LeanTween.value(arg_226_1.dialog_, 0, 1, 0.3)

				var_229_22:setOnUpdate(LuaHelper.FloatAction(function(arg_230_0)
					arg_226_1.dialogCg_.alpha = arg_230_0
				end))
				var_229_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_226_1.dialog_)
					var_229_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_226_1.duration_ = arg_226_1.duration_ + 0.3

				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2104")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_23 = arg_226_1:GetWordFromCfg(321332052)
				local var_229_24 = arg_226_1:FormatText(var_229_23.content)

				arg_226_1.text_.text = var_229_24

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_26 = 22 <= 0 and var_229_21 or var_229_21 * (utf8.len(var_229_24) / 22)

				if (22 <= 0 and var_229_21 or var_229_21 * (utf8.len(var_229_24) / 22)) > 0 and var_229_21 < var_229_26 then
					arg_226_1.talkMaxDuration = var_229_26
					var_229_20 = var_229_20 + 0.3

					if var_229_26 + var_229_20 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_26 + var_229_20
					end
				end

				arg_226_1.text_.text = var_229_24
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332052", "story_v_out_321332.awb") ~= 0 then
					local var_229_27 = manager.audio:GetVoiceLength("story_v_out_321332", "321332052", "story_v_out_321332.awb") / 1000

					if var_229_27 + var_229_20 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_27 + var_229_20
					end

					if var_229_23.prefab_name ~= "" and arg_226_1.actors_[var_229_23.prefab_name] ~= nil then
						local var_229_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_23.prefab_name].transform, "story_v_out_321332", "321332052", "story_v_out_321332.awb")

						arg_226_1:RecordAudio("321332052", var_229_28)
						arg_226_1:RecordAudio("321332052", var_229_28)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_321332", "321332052", "story_v_out_321332.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_321332", "321332052", "story_v_out_321332.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_29 = var_229_20 + 0.3
			local var_229_30 = math.max(var_229_21, arg_226_1.talkMaxDuration)

			if var_229_20 + 0.3 <= arg_226_1.time_ and arg_226_1.time_ < var_229_29 + var_229_30 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_29) / var_229_30

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_29 + var_229_30 and arg_226_1.time_ < var_229_29 + var_229_30 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play321332053 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 321332053
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play321332054(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0.05 < arg_232_1.time_ and arg_232_1.time_ <= 0.05 + arg_235_0 then
				arg_232_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_shadow", "")
			end

			local var_235_1 = 0
			local var_235_2 = 1.275

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_3 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(321332053).content)

				arg_232_1.text_.text = var_235_3

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_5 = 51 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_3) / 51)

				if (51 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_3) / 51)) > 0 and var_235_2 < var_235_5 then
					arg_232_1.talkMaxDuration = var_235_5

					if var_235_5 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + var_235_1
					end
				end

				arg_232_1.text_.text = var_235_3
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_6 = math.max(var_235_2, arg_232_1.talkMaxDuration)

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_6 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_1) / var_235_6

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_1 + var_235_6 and arg_232_1.time_ < var_235_1 + var_235_6 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play321332054 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 321332054
		arg_236_1.duration_ = 6.23

		local var_236_0 = {
			zh = 5.3,
			ja = 6.233
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play321332055(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.325

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10017")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_1 = arg_236_1:GetWordFromCfg(321332054)
				local var_239_2 = arg_236_1:FormatText(var_239_1.content)

				arg_236_1.text_.text = var_239_2

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 13 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 13)

				if (13 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 13)) > 0 and var_239_0 < var_239_4 then
					arg_236_1.talkMaxDuration = var_239_4

					if var_239_4 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_4 + 0
					end
				end

				arg_236_1.text_.text = var_239_2
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332054", "story_v_out_321332.awb") ~= 0 then
					local var_239_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332054", "story_v_out_321332.awb") / 1000

					if var_239_5 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + 0
					end

					if var_239_1.prefab_name ~= "" and arg_236_1.actors_[var_239_1.prefab_name] ~= nil then
						local var_239_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_1.prefab_name].transform, "story_v_out_321332", "321332054", "story_v_out_321332.awb")

						arg_236_1:RecordAudio("321332054", var_239_6)
						arg_236_1:RecordAudio("321332054", var_239_6)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_321332", "321332054", "story_v_out_321332.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_321332", "321332054", "story_v_out_321332.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play321332055 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 321332055
		arg_240_1.duration_ = 8.93

		local var_240_0 = {
			zh = 7.666,
			ja = 8.933
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play321332056(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0.526 < arg_240_1.time_ and arg_240_1.time_ <= 0.526 + arg_243_0 then
				arg_240_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum01", "")
			end

			if 5.127 < arg_240_1.time_ and arg_240_1.time_ <= 5.127 + arg_243_0 then
				arg_240_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_push", "")
			end

			local var_243_2 = 0
			local var_243_3 = 0.725

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_2 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2104")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_4 = arg_240_1:GetWordFromCfg(321332055)
				local var_243_5 = arg_240_1:FormatText(var_243_4.content)

				arg_240_1.text_.text = var_243_5

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_7 = 29 <= 0 and var_243_3 or var_243_3 * (utf8.len(var_243_5) / 29)

				if (29 <= 0 and var_243_3 or var_243_3 * (utf8.len(var_243_5) / 29)) > 0 and var_243_3 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_2 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_2
					end
				end

				arg_240_1.text_.text = var_243_5
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332055", "story_v_out_321332.awb") ~= 0 then
					local var_243_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332055", "story_v_out_321332.awb") / 1000

					if var_243_8 + var_243_2 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_8 + var_243_2
					end

					if var_243_4.prefab_name ~= "" and arg_240_1.actors_[var_243_4.prefab_name] ~= nil then
						local var_243_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_4.prefab_name].transform, "story_v_out_321332", "321332055", "story_v_out_321332.awb")

						arg_240_1:RecordAudio("321332055", var_243_9)
						arg_240_1:RecordAudio("321332055", var_243_9)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_321332", "321332055", "story_v_out_321332.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_321332", "321332055", "story_v_out_321332.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_10 = math.max(var_243_3, arg_240_1.talkMaxDuration)

			if var_243_2 <= arg_240_1.time_ and arg_240_1.time_ < var_243_2 + var_243_10 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_2) / var_243_10

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_2 + var_243_10 and arg_240_1.time_ < var_243_2 + var_243_10 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play321332056 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 321332056
		arg_244_1.duration_ = 1.8

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play321332057(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0.8 < arg_244_1.time_ and arg_244_1.time_ <= 0.8 + arg_247_0 then
				arg_244_1:AudioAction("play", "effect", "se_story_141", "se_story_141_ravana_footstep02", "")
			end

			local var_247_1 = 0
			local var_247_2 = 0.925

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_3 = arg_244_1:GetWordFromCfg(321332056)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_6 = 37 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_4) / 37)

				if (37 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_4) / 37)) > 0 and var_247_2 < var_247_6 then
					arg_244_1.talkMaxDuration = var_247_6

					if var_247_6 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_6 + var_247_1
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332056", "story_v_out_321332.awb") ~= 0 then
					local var_247_7 = manager.audio:GetVoiceLength("story_v_out_321332", "321332056", "story_v_out_321332.awb") / 1000

					if var_247_7 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_1
					end

					if var_247_3.prefab_name ~= "" and arg_244_1.actors_[var_247_3.prefab_name] ~= nil then
						local var_247_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_3.prefab_name].transform, "story_v_out_321332", "321332056", "story_v_out_321332.awb")

						arg_244_1:RecordAudio("321332056", var_247_8)
						arg_244_1:RecordAudio("321332056", var_247_8)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_321332", "321332056", "story_v_out_321332.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_321332", "321332056", "story_v_out_321332.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_9 = math.max(var_247_2, arg_244_1.talkMaxDuration)

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_9 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_1) / var_247_9

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_1 + var_247_9 and arg_244_1.time_ < var_247_1 + var_247_9 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play321332057 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 321332057
		arg_248_1.duration_ = 6.7

		local var_248_0 = {
			zh = 6.7,
			ja = 6.433
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play321332058(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.425

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10017")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_1 = arg_248_1:GetWordFromCfg(321332057)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 17 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 17)

				if (17 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 17)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332057", "story_v_out_321332.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332057", "story_v_out_321332.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_321332", "321332057", "story_v_out_321332.awb")

						arg_248_1:RecordAudio("321332057", var_251_6)
						arg_248_1:RecordAudio("321332057", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_321332", "321332057", "story_v_out_321332.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_321332", "321332057", "story_v_out_321332.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play321332058 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 321332058
		arg_252_1.duration_ = 4.7

		local var_252_0 = {
			zh = 3.2,
			ja = 4.7
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play321332059(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0.225

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10017")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_1 = arg_252_1:GetWordFromCfg(321332058)
				local var_255_2 = arg_252_1:FormatText(var_255_1.content)

				arg_252_1.text_.text = var_255_2

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_4 = 9 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 9)

				if (9 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 9)) > 0 and var_255_0 < var_255_4 then
					arg_252_1.talkMaxDuration = var_255_4

					if var_255_4 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_4 + 0
					end
				end

				arg_252_1.text_.text = var_255_2
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332058", "story_v_out_321332.awb") ~= 0 then
					local var_255_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332058", "story_v_out_321332.awb") / 1000

					if var_255_5 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + 0
					end

					if var_255_1.prefab_name ~= "" and arg_252_1.actors_[var_255_1.prefab_name] ~= nil then
						local var_255_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_1.prefab_name].transform, "story_v_out_321332", "321332058", "story_v_out_321332.awb")

						arg_252_1:RecordAudio("321332058", var_255_6)
						arg_252_1:RecordAudio("321332058", var_255_6)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_321332", "321332058", "story_v_out_321332.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_321332", "321332058", "story_v_out_321332.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_7 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_7

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play321332059 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 321332059
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play321332060(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0.3 < arg_256_1.time_ and arg_256_1.time_ <= 0.3 + arg_259_0 then
				arg_256_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_organic", "")
			end

			local var_259_1 = 0
			local var_259_2 = 1.925

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_3 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(321332059).content)

				arg_256_1.text_.text = var_259_3

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 77 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 77)

				if (77 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 77)) > 0 and var_259_2 < var_259_5 then
					arg_256_1.talkMaxDuration = var_259_5

					if var_259_5 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + var_259_1
					end
				end

				arg_256_1.text_.text = var_259_3
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_6 = math.max(var_259_2, arg_256_1.talkMaxDuration)

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_6 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_1) / var_259_6

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_1 + var_259_6 and arg_256_1.time_ < var_259_1 + var_259_6 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play321332060 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 321332060
		arg_260_1.duration_ = 4.53

		local var_260_0 = {
			zh = 4.533,
			ja = 3.866
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play321332061(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_263_0 = 0.6

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 then
				local var_263_1, var_263_2 = math.modf((arg_260_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_263_2 * 0.13, var_263_2 * 0.13, var_263_2 * 0.13) + arg_260_1.var_.shakeOldPos
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 then
				manager.ui.mainCamera.transform.localPosition = arg_260_1.var_.shakeOldPos
			end

			local var_263_3 = 0

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_3 + arg_263_0 then
				arg_260_1.allBtn_.enabled = false
			end

			if arg_260_1.time_ >= var_263_3 + 0.6 and arg_260_1.time_ < var_263_3 + 0.6 + arg_263_0 then
				arg_260_1.allBtn_.enabled = true
			end

			local var_263_4 = 0
			local var_263_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332060", "") / 1000

			if var_263_5 > 0 and 1 < var_263_5 and var_263_5 + var_263_4 > arg_260_1.duration_ then
				arg_260_1.duration_ = var_263_5 + var_263_4
			end

			if var_263_4 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1:AudioAction("play", "voice", "story_v_out_321332", "321332060", "")
			end

			if 0.526 < arg_260_1.time_ and arg_260_1.time_ <= 0.526 + arg_263_0 then
				arg_260_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum03", "")
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_8 = 0.6
			local var_263_9 = 0.8

			if 0.6 < arg_260_1.time_ and arg_260_1.time_ <= var_263_8 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_10 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_10:setOnUpdate(LuaHelper.FloatAction(function(arg_264_0)
					arg_260_1.dialogCg_.alpha = arg_264_0
				end))
				var_263_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_11 = arg_260_1:GetWordFromCfg(321332060)
				local var_263_12 = arg_260_1:FormatText(var_263_11.content)

				arg_260_1.text_.text = var_263_12

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_14 = 32 <= 0 and var_263_9 or var_263_9 * (utf8.len(var_263_12) / 32)

				if (32 <= 0 and var_263_9 or var_263_9 * (utf8.len(var_263_12) / 32)) > 0 and var_263_9 < var_263_14 then
					arg_260_1.talkMaxDuration = var_263_14
					var_263_8 = var_263_8 + 0.3

					if var_263_14 + var_263_8 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_14 + var_263_8
					end
				end

				arg_260_1.text_.text = var_263_12
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332060", "story_v_out_321332.awb") ~= 0 then
					local var_263_15 = manager.audio:GetVoiceLength("story_v_out_321332", "321332060", "story_v_out_321332.awb") / 1000

					if var_263_15 + var_263_8 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_15 + var_263_8
					end

					if var_263_11.prefab_name ~= "" and arg_260_1.actors_[var_263_11.prefab_name] ~= nil then
						local var_263_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_11.prefab_name].transform, "story_v_out_321332", "321332060", "story_v_out_321332.awb")

						arg_260_1:RecordAudio("321332060", var_263_16)
						arg_260_1:RecordAudio("321332060", var_263_16)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_321332", "321332060", "story_v_out_321332.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_321332", "321332060", "story_v_out_321332.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_17 = var_263_8 + 0.3
			local var_263_18 = math.max(var_263_9, arg_260_1.talkMaxDuration)

			if var_263_8 + 0.3 <= arg_260_1.time_ and arg_260_1.time_ < var_263_17 + var_263_18 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_17) / var_263_18

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_17 + var_263_18 and arg_260_1.time_ < var_263_17 + var_263_18 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play321332061 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 321332061
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play321332062(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0.199999999999 < arg_266_1.time_ and arg_266_1.time_ <= 0.199999999999 + arg_269_0 then
				arg_266_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_fall", "")
			end

			local var_269_1 = 0
			local var_269_2 = 1.2

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_3 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(321332061).content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 48 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 48)

				if (48 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 48)) > 0 and var_269_2 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_6 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_6 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_1) / var_269_6

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_1 + var_269_6 and arg_266_1.time_ < var_269_1 + var_269_6 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play321332062 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 321332062
		arg_270_1.duration_ = 7

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play321332063(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if arg_270_1.bgs_.L09h == nil then
				local var_273_0 = Object.Instantiate(arg_270_1.paintGo_)

				var_273_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L09h")
				var_273_0.name = "L09h"
				var_273_0.transform.parent = arg_270_1.stage_.transform
				var_273_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_270_1.bgs_.L09h = var_273_0
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				local var_273_1 = arg_270_1.bgs_.L09h

				arg_270_1.bgs_.L09h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_273_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_273_2 = var_273_1:GetComponent("SpriteRenderer")

				if var_273_2 and var_273_2.sprite then
					local var_273_3 = 2 * (var_273_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_273_1.transform.localScale = Vector3.New(var_273_3 / var_273_2.sprite.bounds.size.y < var_273_3 * manager.ui.mainCameraCom_.aspect / var_273_2.sprite.bounds.size.x and var_273_3 * manager.ui.mainCameraCom_.aspect / var_273_2.sprite.bounds.size.x or var_273_3 / var_273_2.sprite.bounds.size.y, var_273_3 / var_273_2.sprite.bounds.size.y < var_273_3 * manager.ui.mainCameraCom_.aspect / var_273_2.sprite.bounds.size.x and var_273_3 * manager.ui.mainCameraCom_.aspect / var_273_2.sprite.bounds.size.x or var_273_3 / var_273_2.sprite.bounds.size.y, 0)
				end

				for iter_273_0, iter_273_1 in pairs(arg_270_1.bgs_) do
					if iter_273_0 ~= "L09h" then
						iter_273_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_273_4 = 1.999999999999

			if 1.999999999999 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1.allBtn_.enabled = false
			end

			if arg_270_1.time_ >= var_273_4 + 0.3 and arg_270_1.time_ < var_273_4 + 0.3 + arg_273_0 then
				arg_270_1.allBtn_.enabled = true
			end

			local var_273_5 = 0

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1.mask_.enabled = true
				arg_270_1.mask_.raycastTarget = true

				arg_270_1:SetGaussion(false)
			end

			local var_273_6 = 2

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_6 then
				local var_273_7 = Color.New(1, 1, 1)

				var_273_7.a = Mathf.Lerp(1, 0, (arg_270_1.time_ - var_273_5) / var_273_6)
				arg_270_1.mask_.color = var_273_7
			end

			if arg_270_1.time_ >= var_273_5 + var_273_6 and arg_270_1.time_ < var_273_5 + var_273_6 + arg_273_0 then
				local var_273_8 = Color.New(1, 1, 1)

				arg_270_1.mask_.enabled = false
				var_273_8.a = 0
				arg_270_1.mask_.color = var_273_8
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				if arg_270_1.var_.effectluobonazhuanchang3 then
					Object.Destroy(arg_270_1.var_.effectluobonazhuanchang3)

					arg_270_1.var_.effectluobonazhuanchang3 = nil
				end
			end

			if 2 < arg_270_1.time_ and arg_270_1.time_ <= 2 + arg_273_0 then
				arg_270_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_down", "")
			end

			if arg_270_1.frameCnt_ <= 1 then
				arg_270_1.dialog_:SetActive(false)
			end

			local var_273_11 = 2
			local var_273_12 = 1.6

			if 2 < arg_270_1.time_ and arg_270_1.time_ <= var_273_11 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0

				arg_270_1.dialog_:SetActive(true)

				arg_270_1.dialogCg_.alpha = 0

				local var_273_13 = LeanTween.value(arg_270_1.dialog_, 0, 1, 0.3)

				var_273_13:setOnUpdate(LuaHelper.FloatAction(function(arg_274_0)
					arg_270_1.dialogCg_.alpha = arg_274_0
				end))
				var_273_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_270_1.dialog_)
					var_273_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_270_1.duration_ = arg_270_1.duration_ + 0.3

				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_14 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(321332062).content)

				arg_270_1.text_.text = var_273_14

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_16 = 64 <= 0 and var_273_12 or var_273_12 * (utf8.len(var_273_14) / 64)

				if (64 <= 0 and var_273_12 or var_273_12 * (utf8.len(var_273_14) / 64)) > 0 and var_273_12 < var_273_16 then
					arg_270_1.talkMaxDuration = var_273_16
					var_273_11 = var_273_11 + 0.3

					if var_273_16 + var_273_11 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_16 + var_273_11
					end
				end

				arg_270_1.text_.text = var_273_14
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_17 = var_273_11 + 0.3
			local var_273_18 = math.max(var_273_12, arg_270_1.talkMaxDuration)

			if var_273_11 + 0.3 <= arg_270_1.time_ and arg_270_1.time_ < var_273_17 + var_273_18 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_17) / var_273_18

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_17 + var_273_18 and arg_270_1.time_ < var_273_17 + var_273_18 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play321332063 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 321332063
		arg_276_1.duration_ = 13.2

		local var_276_0 = {
			zh = 9.266,
			ja = 13.2
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play321332064(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0.625

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_1 = arg_276_1:GetWordFromCfg(321332063)
				local var_279_2 = arg_276_1:FormatText(var_279_1.content)

				arg_276_1.text_.text = var_279_2

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_4 = 25 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 25)

				if (25 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 25)) > 0 and var_279_0 < var_279_4 then
					arg_276_1.talkMaxDuration = var_279_4

					if var_279_4 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_4 + 0
					end
				end

				arg_276_1.text_.text = var_279_2
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332063", "story_v_out_321332.awb") ~= 0 then
					local var_279_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332063", "story_v_out_321332.awb") / 1000

					if var_279_5 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + 0
					end

					if var_279_1.prefab_name ~= "" and arg_276_1.actors_[var_279_1.prefab_name] ~= nil then
						local var_279_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_1.prefab_name].transform, "story_v_out_321332", "321332063", "story_v_out_321332.awb")

						arg_276_1:RecordAudio("321332063", var_279_6)
						arg_276_1:RecordAudio("321332063", var_279_6)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_321332", "321332063", "story_v_out_321332.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_321332", "321332063", "story_v_out_321332.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_7 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_7 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_7

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_7 and arg_276_1.time_ < 0 + var_279_7 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play321332064 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 321332064
		arg_280_1.duration_ = 15.1

		local var_280_0 = {
			zh = 9.433,
			ja = 15.1
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play321332065(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 3.078 < arg_280_1.time_ and arg_280_1.time_ <= 3.078 + arg_283_0 then
				arg_280_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum03", "")
			end

			local var_283_1 = 0
			local var_283_2 = 0.7

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_3 = arg_280_1:GetWordFromCfg(321332064)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_6 = 28 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 28)

				if (28 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 28)) > 0 and var_283_2 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6

					if var_283_6 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_1
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332064", "story_v_out_321332.awb") ~= 0 then
					local var_283_7 = manager.audio:GetVoiceLength("story_v_out_321332", "321332064", "story_v_out_321332.awb") / 1000

					if var_283_7 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_1
					end

					if var_283_3.prefab_name ~= "" and arg_280_1.actors_[var_283_3.prefab_name] ~= nil then
						local var_283_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_3.prefab_name].transform, "story_v_out_321332", "321332064", "story_v_out_321332.awb")

						arg_280_1:RecordAudio("321332064", var_283_8)
						arg_280_1:RecordAudio("321332064", var_283_8)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_321332", "321332064", "story_v_out_321332.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_321332", "321332064", "story_v_out_321332.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_9 = math.max(var_283_2, arg_280_1.talkMaxDuration)

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_9 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_1) / var_283_9

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_1 + var_283_9 and arg_280_1.time_ < var_283_1 + var_283_9 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play321332065 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 321332065
		arg_284_1.duration_ = 8.9

		local var_284_0 = {
			zh = 8.133,
			ja = 8.9
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play321332066(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.425

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_1 = arg_284_1:GetWordFromCfg(321332065)
				local var_287_2 = arg_284_1:FormatText(var_287_1.content)

				arg_284_1.text_.text = var_287_2

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 17 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 17)

				if (17 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 17)) > 0 and var_287_0 < var_287_4 then
					arg_284_1.talkMaxDuration = var_287_4

					if var_287_4 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_4 + 0
					end
				end

				arg_284_1.text_.text = var_287_2
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332065", "story_v_out_321332.awb") ~= 0 then
					local var_287_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332065", "story_v_out_321332.awb") / 1000

					if var_287_5 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + 0
					end

					if var_287_1.prefab_name ~= "" and arg_284_1.actors_[var_287_1.prefab_name] ~= nil then
						local var_287_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_1.prefab_name].transform, "story_v_out_321332", "321332065", "story_v_out_321332.awb")

						arg_284_1:RecordAudio("321332065", var_287_6)
						arg_284_1:RecordAudio("321332065", var_287_6)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_321332", "321332065", "story_v_out_321332.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_321332", "321332065", "story_v_out_321332.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_7 and arg_284_1.time_ < 0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play321332066 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 321332066
		arg_288_1.duration_ = 7.97

		local var_288_0 = {
			zh = 6.366,
			ja = 7.966
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play321332067(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0.325

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_1 = arg_288_1:GetWordFromCfg(321332066)
				local var_291_2 = arg_288_1:FormatText(var_291_1.content)

				arg_288_1.text_.text = var_291_2

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_4 = 13 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 13)

				if (13 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 13)) > 0 and var_291_0 < var_291_4 then
					arg_288_1.talkMaxDuration = var_291_4

					if var_291_4 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_4 + 0
					end
				end

				arg_288_1.text_.text = var_291_2
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332066", "story_v_out_321332.awb") ~= 0 then
					local var_291_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332066", "story_v_out_321332.awb") / 1000

					if var_291_5 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + 0
					end

					if var_291_1.prefab_name ~= "" and arg_288_1.actors_[var_291_1.prefab_name] ~= nil then
						local var_291_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_1.prefab_name].transform, "story_v_out_321332", "321332066", "story_v_out_321332.awb")

						arg_288_1:RecordAudio("321332066", var_291_6)
						arg_288_1:RecordAudio("321332066", var_291_6)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_321332", "321332066", "story_v_out_321332.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_321332", "321332066", "story_v_out_321332.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_7 and arg_288_1.time_ < 0 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play321332067 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 321332067
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play321332068(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 1.45

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_1 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(321332067).content)

				arg_292_1.text_.text = var_295_1

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_3 = 58 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 58)

				if (58 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 58)) > 0 and var_295_0 < var_295_3 then
					arg_292_1.talkMaxDuration = var_295_3

					if var_295_3 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_3 + 0
					end
				end

				arg_292_1.text_.text = var_295_1
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_4 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_4

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play321332068 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 321332068
		arg_296_1.duration_ = 3.97

		local var_296_0 = {
			zh = 3.966,
			ja = 3.4
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play321332069(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = manager.audio:GetVoiceLength("story_v_out_321332", "321332068", "") / 1000

			if var_299_0 > 0 and 1 < var_299_0 and var_299_0 + 0.15 > arg_296_1.duration_ then
				arg_296_1.duration_ = var_299_0 + 0.15
			end

			if 0.15 < arg_296_1.time_ and arg_296_1.time_ <= 0.15 + arg_299_0 then
				arg_296_1:AudioAction("play", "voice", "story_v_out_321332", "321332068", "")
			end

			if 0.704 < arg_296_1.time_ and arg_296_1.time_ <= 0.704 + arg_299_0 then
				arg_296_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum01", "")
			end

			local var_299_3 = 0
			local var_299_4 = 1.375

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_3 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_5 = arg_296_1:GetWordFromCfg(321332068)
				local var_299_6 = arg_296_1:FormatText(var_299_5.content)

				arg_296_1.text_.text = var_299_6

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_8 = 55 <= 0 and var_299_4 or var_299_4 * (utf8.len(var_299_6) / 55)

				if (55 <= 0 and var_299_4 or var_299_4 * (utf8.len(var_299_6) / 55)) > 0 and var_299_4 < var_299_8 then
					arg_296_1.talkMaxDuration = var_299_8

					if var_299_8 + var_299_3 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_8 + var_299_3
					end
				end

				arg_296_1.text_.text = var_299_6
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332068", "story_v_out_321332.awb") ~= 0 then
					local var_299_9 = manager.audio:GetVoiceLength("story_v_out_321332", "321332068", "story_v_out_321332.awb") / 1000

					if var_299_9 + var_299_3 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_9 + var_299_3
					end

					if var_299_5.prefab_name ~= "" and arg_296_1.actors_[var_299_5.prefab_name] ~= nil then
						local var_299_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_5.prefab_name].transform, "story_v_out_321332", "321332068", "story_v_out_321332.awb")

						arg_296_1:RecordAudio("321332068", var_299_10)
						arg_296_1:RecordAudio("321332068", var_299_10)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_321332", "321332068", "story_v_out_321332.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_321332", "321332068", "story_v_out_321332.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_11 = math.max(var_299_4, arg_296_1.talkMaxDuration)

			if var_299_3 <= arg_296_1.time_ and arg_296_1.time_ < var_299_3 + var_299_11 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_3) / var_299_11

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_3 + var_299_11 and arg_296_1.time_ < var_299_3 + var_299_11 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play321332069 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 321332069
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play321332070(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 1.725

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_1 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(321332069).content)

				arg_300_1.text_.text = var_303_1

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_3 = 69 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 69)

				if (69 <= 0 and var_303_0 or var_303_0 * (utf8.len(var_303_1) / 69)) > 0 and var_303_0 < var_303_3 then
					arg_300_1.talkMaxDuration = var_303_3

					if var_303_3 + 0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_3 + 0
					end
				end

				arg_300_1.text_.text = var_303_1
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_4 = math.max(var_303_0, arg_300_1.talkMaxDuration)

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - 0) / var_303_4

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play321332070 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 321332070
		arg_304_1.duration_ = 8.73

		local var_304_0 = {
			zh = 6.4,
			ja = 8.733
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play321332071(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if arg_304_1.actors_["4037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4037ui_story"))) then
				local var_307_0 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_304_1.stage_.transform)

				var_307_0.name = "4037ui_story"
				var_307_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_304_1.actors_["4037ui_story"] = var_307_0

				local var_307_1 = var_307_0:GetComponentInChildren(typeof(CharacterEffect))

				var_307_1.enabled = true

				local var_307_2 = GameObjectTools.GetOrAddComponent(var_307_0, typeof(DynamicBoneHelper))

				if var_307_2 then
					var_307_2:EnableDynamicBone(false)
				end

				arg_304_1:ShowWeapon(var_307_1.transform, false)

				arg_304_1.var_["4037ui_story" .. "Animator"] = var_307_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_304_1.var_["4037ui_story" .. "Animator"].applyRootMotion = true
				arg_304_1.var_["4037ui_story" .. "LipSync"] = var_307_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_307_3 = arg_304_1.actors_["4037ui_story"].transform

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos4037ui_story = var_307_3.localPosition
			end

			local var_307_4 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_4 then
				var_307_3.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_304_1.time_ - 0) / var_307_4)
				var_307_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_3.position).x, (manager.ui.mainCamera.transform.position - var_307_3.position).y, (manager.ui.mainCamera.transform.position - var_307_3.position).z)
				var_307_3.localEulerAngles.z = 0
				var_307_3.localEulerAngles.x = 0
				var_307_3.localEulerAngles = var_307_3.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_4 and arg_304_1.time_ < 0 + var_307_4 + arg_307_0 then
				var_307_3.localPosition = Vector3.New(0, -1.12, -6.2)
				var_307_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_3.position).x, (manager.ui.mainCamera.transform.position - var_307_3.position).y, (manager.ui.mainCamera.transform.position - var_307_3.position).z)
				var_307_3.localEulerAngles.z = 0
				var_307_3.localEulerAngles.x = 0
				var_307_3.localEulerAngles = var_307_3.localEulerAngles
			end

			local var_307_5 = arg_304_1.actors_["4037ui_story"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_5) and arg_304_1.var_.characterEffect4037ui_story == nil then
				arg_304_1.var_.characterEffect4037ui_story = var_307_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_6 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_6 and not isNil(var_307_5) then
				if arg_304_1.var_.characterEffect4037ui_story and not isNil(var_307_5) then
					arg_304_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= 0 + var_307_6 and arg_304_1.time_ < 0 + var_307_6 + arg_307_0 and not isNil(var_307_5) and arg_304_1.var_.characterEffect4037ui_story then
				arg_304_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				if arg_304_1.var_.characterEffect4037ui_story == nil then
					arg_304_1.var_.characterEffect4037ui_story = arg_304_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_307_8 = arg_304_1.var_.characterEffect4037ui_story

				arg_304_1.var_.characterEffect4037ui_story.imageEffect:turnOff()

				var_307_8.interferenceEffect.enabled = true
				var_307_8.interferenceEffect.noise = 0.001
				var_307_8.interferenceEffect.simTimeScale = 1
				var_307_8.interferenceEffect.geometryOutlineColor = Color.New(0.509434, 0.509434, 0.509434, 1)
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				if arg_304_1.var_.characterEffect4037ui_story == nil then
					arg_304_1.var_.characterEffect4037ui_story = arg_304_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_304_1.var_.characterEffect4037ui_story.imageEffect:turnOn(false)
			end

			local var_307_10 = 0
			local var_307_11 = 0.5

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_10 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_12 = arg_304_1:GetWordFromCfg(321332070)
				local var_307_13 = arg_304_1:FormatText(var_307_12.content)

				arg_304_1.text_.text = var_307_13

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_15 = 20 <= 0 and var_307_11 or var_307_11 * (utf8.len(var_307_13) / 20)

				if (20 <= 0 and var_307_11 or var_307_11 * (utf8.len(var_307_13) / 20)) > 0 and var_307_11 < var_307_15 then
					arg_304_1.talkMaxDuration = var_307_15

					if var_307_15 + var_307_10 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_15 + var_307_10
					end
				end

				arg_304_1.text_.text = var_307_13
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332070", "story_v_out_321332.awb") ~= 0 then
					local var_307_16 = manager.audio:GetVoiceLength("story_v_out_321332", "321332070", "story_v_out_321332.awb") / 1000

					if var_307_16 + var_307_10 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_16 + var_307_10
					end

					if var_307_12.prefab_name ~= "" and arg_304_1.actors_[var_307_12.prefab_name] ~= nil then
						local var_307_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_12.prefab_name].transform, "story_v_out_321332", "321332070", "story_v_out_321332.awb")

						arg_304_1:RecordAudio("321332070", var_307_17)
						arg_304_1:RecordAudio("321332070", var_307_17)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_321332", "321332070", "story_v_out_321332.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_321332", "321332070", "story_v_out_321332.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_18 = math.max(var_307_11, arg_304_1.talkMaxDuration)

			if var_307_10 <= arg_304_1.time_ and arg_304_1.time_ < var_307_10 + var_307_18 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_10) / var_307_18

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_10 + var_307_18 and arg_304_1.time_ < var_307_10 + var_307_18 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play321332071 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 321332071
		arg_308_1.duration_ = 8.37

		local var_308_0 = {
			zh = 7.4,
			ja = 8.366
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play321332072(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["4037ui_story"]) and arg_308_1.var_.characterEffect4037ui_story == nil then
				arg_308_1.var_.characterEffect4037ui_story = arg_308_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_0 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["4037ui_story"]) then
				if arg_308_1.var_.characterEffect4037ui_story and not isNil(arg_308_1.actors_["4037ui_story"]) then
					arg_308_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_308_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_0)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["4037ui_story"]) and arg_308_1.var_.characterEffect4037ui_story then
				arg_308_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_308_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_311_1 = 0
			local var_311_2 = 0.55

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_3 = arg_308_1:GetWordFromCfg(321332071)
				local var_311_4 = arg_308_1:FormatText(var_311_3.content)

				arg_308_1.text_.text = var_311_4

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_6 = 22 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_4) / 22)

				if (22 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_4) / 22)) > 0 and var_311_2 < var_311_6 then
					arg_308_1.talkMaxDuration = var_311_6

					if var_311_6 + var_311_1 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_6 + var_311_1
					end
				end

				arg_308_1.text_.text = var_311_4
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332071", "story_v_out_321332.awb") ~= 0 then
					local var_311_7 = manager.audio:GetVoiceLength("story_v_out_321332", "321332071", "story_v_out_321332.awb") / 1000

					if var_311_7 + var_311_1 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_7 + var_311_1
					end

					if var_311_3.prefab_name ~= "" and arg_308_1.actors_[var_311_3.prefab_name] ~= nil then
						local var_311_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_3.prefab_name].transform, "story_v_out_321332", "321332071", "story_v_out_321332.awb")

						arg_308_1:RecordAudio("321332071", var_311_8)
						arg_308_1:RecordAudio("321332071", var_311_8)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_321332", "321332071", "story_v_out_321332.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_321332", "321332071", "story_v_out_321332.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_9 = math.max(var_311_2, arg_308_1.talkMaxDuration)

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_9 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_1) / var_311_9

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_1 + var_311_9 and arg_308_1.time_ < var_311_1 + var_311_9 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play321332072 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 321332072
		arg_312_1.duration_ = 12.2

		local var_312_0 = {
			zh = 10.9,
			ja = 12.2
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play321332073(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 5.352 < arg_312_1.time_ and arg_312_1.time_ <= 5.352 + arg_315_0 then
				arg_312_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum02", "")
			end

			local var_315_1 = 0
			local var_315_2 = 0.8

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_3 = arg_312_1:GetWordFromCfg(321332072)
				local var_315_4 = arg_312_1:FormatText(var_315_3.content)

				arg_312_1.text_.text = var_315_4

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_6 = 32 <= 0 and var_315_2 or var_315_2 * (utf8.len(var_315_4) / 32)

				if (32 <= 0 and var_315_2 or var_315_2 * (utf8.len(var_315_4) / 32)) > 0 and var_315_2 < var_315_6 then
					arg_312_1.talkMaxDuration = var_315_6

					if var_315_6 + var_315_1 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_6 + var_315_1
					end
				end

				arg_312_1.text_.text = var_315_4
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332072", "story_v_out_321332.awb") ~= 0 then
					local var_315_7 = manager.audio:GetVoiceLength("story_v_out_321332", "321332072", "story_v_out_321332.awb") / 1000

					if var_315_7 + var_315_1 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_7 + var_315_1
					end

					if var_315_3.prefab_name ~= "" and arg_312_1.actors_[var_315_3.prefab_name] ~= nil then
						local var_315_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_3.prefab_name].transform, "story_v_out_321332", "321332072", "story_v_out_321332.awb")

						arg_312_1:RecordAudio("321332072", var_315_8)
						arg_312_1:RecordAudio("321332072", var_315_8)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_321332", "321332072", "story_v_out_321332.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_321332", "321332072", "story_v_out_321332.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_9 = math.max(var_315_2, arg_312_1.talkMaxDuration)

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_9 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_1) / var_315_9

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_1 + var_315_9 and arg_312_1.time_ < var_315_1 + var_315_9 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play321332073 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 321332073
		arg_316_1.duration_ = 4.63

		local var_316_0 = {
			zh = 4.633,
			ja = 2.833
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play321332074(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["4037ui_story"]) and arg_316_1.var_.characterEffect4037ui_story == nil then
				arg_316_1.var_.characterEffect4037ui_story = arg_316_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_0 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["4037ui_story"]) then
				if arg_316_1.var_.characterEffect4037ui_story and not isNil(arg_316_1.actors_["4037ui_story"]) then
					arg_316_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["4037ui_story"]) and arg_316_1.var_.characterEffect4037ui_story then
				arg_316_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_319_2 = 0
			local var_319_3 = 0.125

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_2 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_4 = arg_316_1:GetWordFromCfg(321332073)
				local var_319_5 = arg_316_1:FormatText(var_319_4.content)

				arg_316_1.text_.text = var_319_5

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_7 = 5 <= 0 and var_319_3 or var_319_3 * (utf8.len(var_319_5) / 5)

				if (5 <= 0 and var_319_3 or var_319_3 * (utf8.len(var_319_5) / 5)) > 0 and var_319_3 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_2 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_2
					end
				end

				arg_316_1.text_.text = var_319_5
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332073", "story_v_out_321332.awb") ~= 0 then
					local var_319_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332073", "story_v_out_321332.awb") / 1000

					if var_319_8 + var_319_2 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_8 + var_319_2
					end

					if var_319_4.prefab_name ~= "" and arg_316_1.actors_[var_319_4.prefab_name] ~= nil then
						local var_319_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_4.prefab_name].transform, "story_v_out_321332", "321332073", "story_v_out_321332.awb")

						arg_316_1:RecordAudio("321332073", var_319_9)
						arg_316_1:RecordAudio("321332073", var_319_9)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_321332", "321332073", "story_v_out_321332.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_321332", "321332073", "story_v_out_321332.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_10 = math.max(var_319_3, arg_316_1.talkMaxDuration)

			if var_319_2 <= arg_316_1.time_ and arg_316_1.time_ < var_319_2 + var_319_10 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_2) / var_319_10

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_2 + var_319_10 and arg_316_1.time_ < var_319_2 + var_319_10 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play321332074 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 321332074
		arg_320_1.duration_ = 6.93

		local var_320_0 = {
			zh = 4.266,
			ja = 6.933
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play321332075(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(arg_320_1.actors_["4037ui_story"]) and arg_320_1.var_.characterEffect4037ui_story == nil then
				arg_320_1.var_.characterEffect4037ui_story = arg_320_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_0 = 0.200000002980232

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 and not isNil(arg_320_1.actors_["4037ui_story"]) then
				if arg_320_1.var_.characterEffect4037ui_story and not isNil(arg_320_1.actors_["4037ui_story"]) then
					arg_320_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_320_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_320_1.time_ - 0) / var_323_0)
				end
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 and not isNil(arg_320_1.actors_["4037ui_story"]) and arg_320_1.var_.characterEffect4037ui_story then
				arg_320_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_320_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_323_1 = 0
			local var_323_2 = 0.325

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_3 = arg_320_1:GetWordFromCfg(321332074)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_6 = 13 <= 0 and var_323_2 or var_323_2 * (utf8.len(var_323_4) / 13)

				if (13 <= 0 and var_323_2 or var_323_2 * (utf8.len(var_323_4) / 13)) > 0 and var_323_2 < var_323_6 then
					arg_320_1.talkMaxDuration = var_323_6

					if var_323_6 + var_323_1 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_6 + var_323_1
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332074", "story_v_out_321332.awb") ~= 0 then
					local var_323_7 = manager.audio:GetVoiceLength("story_v_out_321332", "321332074", "story_v_out_321332.awb") / 1000

					if var_323_7 + var_323_1 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_1
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_out_321332", "321332074", "story_v_out_321332.awb")

						arg_320_1:RecordAudio("321332074", var_323_8)
						arg_320_1:RecordAudio("321332074", var_323_8)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_321332", "321332074", "story_v_out_321332.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_321332", "321332074", "story_v_out_321332.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_9 = math.max(var_323_2, arg_320_1.talkMaxDuration)

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_9 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_1) / var_323_9

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_1 + var_323_9 and arg_320_1.time_ < var_323_1 + var_323_9 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play321332075 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 321332075
		arg_324_1.duration_ = 13.6

		local var_324_0 = {
			zh = 9.866,
			ja = 13.6
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play321332076(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0.775

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_1 = arg_324_1:GetWordFromCfg(321332075)
				local var_327_2 = arg_324_1:FormatText(var_327_1.content)

				arg_324_1.text_.text = var_327_2

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 31 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 31)

				if (31 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 31)) > 0 and var_327_0 < var_327_4 then
					arg_324_1.talkMaxDuration = var_327_4

					if var_327_4 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_4 + 0
					end
				end

				arg_324_1.text_.text = var_327_2
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332075", "story_v_out_321332.awb") ~= 0 then
					local var_327_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332075", "story_v_out_321332.awb") / 1000

					if var_327_5 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_5 + 0
					end

					if var_327_1.prefab_name ~= "" and arg_324_1.actors_[var_327_1.prefab_name] ~= nil then
						local var_327_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_1.prefab_name].transform, "story_v_out_321332", "321332075", "story_v_out_321332.awb")

						arg_324_1:RecordAudio("321332075", var_327_6)
						arg_324_1:RecordAudio("321332075", var_327_6)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_321332", "321332075", "story_v_out_321332.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_321332", "321332075", "story_v_out_321332.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_7 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_7 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_7

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_7 and arg_324_1.time_ < 0 + var_327_7 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play321332076 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 321332076
		arg_328_1.duration_ = 13.67

		local var_328_0 = {
			zh = 9.1,
			ja = 13.666
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play321332077(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 5.087 < arg_328_1.time_ and arg_328_1.time_ <= 5.087 + arg_331_0 then
				arg_328_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum02", "")
			end

			local var_331_1 = 0
			local var_331_2 = 0.55

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_3 = arg_328_1:GetWordFromCfg(321332076)
				local var_331_4 = arg_328_1:FormatText(var_331_3.content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_6 = 22 <= 0 and var_331_2 or var_331_2 * (utf8.len(var_331_4) / 22)

				if (22 <= 0 and var_331_2 or var_331_2 * (utf8.len(var_331_4) / 22)) > 0 and var_331_2 < var_331_6 then
					arg_328_1.talkMaxDuration = var_331_6

					if var_331_6 + var_331_1 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_6 + var_331_1
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332076", "story_v_out_321332.awb") ~= 0 then
					local var_331_7 = manager.audio:GetVoiceLength("story_v_out_321332", "321332076", "story_v_out_321332.awb") / 1000

					if var_331_7 + var_331_1 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_1
					end

					if var_331_3.prefab_name ~= "" and arg_328_1.actors_[var_331_3.prefab_name] ~= nil then
						local var_331_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_3.prefab_name].transform, "story_v_out_321332", "321332076", "story_v_out_321332.awb")

						arg_328_1:RecordAudio("321332076", var_331_8)
						arg_328_1:RecordAudio("321332076", var_331_8)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_321332", "321332076", "story_v_out_321332.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_321332", "321332076", "story_v_out_321332.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_9 = math.max(var_331_2, arg_328_1.talkMaxDuration)

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_9 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_1) / var_331_9

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_1 + var_331_9 and arg_328_1.time_ < var_331_1 + var_331_9 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play321332077 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 321332077
		arg_332_1.duration_ = 5.37

		local var_332_0 = {
			zh = 5.366,
			ja = 2.766
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play321332078(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(arg_332_1.actors_["4037ui_story"]) and arg_332_1.var_.characterEffect4037ui_story == nil then
				arg_332_1.var_.characterEffect4037ui_story = arg_332_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_0 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 and not isNil(arg_332_1.actors_["4037ui_story"]) then
				if arg_332_1.var_.characterEffect4037ui_story and not isNil(arg_332_1.actors_["4037ui_story"]) then
					arg_332_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 and not isNil(arg_332_1.actors_["4037ui_story"]) and arg_332_1.var_.characterEffect4037ui_story then
				arg_332_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_2")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_335_2 = 0
			local var_335_3 = 0.325

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_2 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_4 = arg_332_1:GetWordFromCfg(321332077)
				local var_335_5 = arg_332_1:FormatText(var_335_4.content)

				arg_332_1.text_.text = var_335_5

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_7 = 13 <= 0 and var_335_3 or var_335_3 * (utf8.len(var_335_5) / 13)

				if (13 <= 0 and var_335_3 or var_335_3 * (utf8.len(var_335_5) / 13)) > 0 and var_335_3 < var_335_7 then
					arg_332_1.talkMaxDuration = var_335_7

					if var_335_7 + var_335_2 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_2
					end
				end

				arg_332_1.text_.text = var_335_5
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332077", "story_v_out_321332.awb") ~= 0 then
					local var_335_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332077", "story_v_out_321332.awb") / 1000

					if var_335_8 + var_335_2 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_8 + var_335_2
					end

					if var_335_4.prefab_name ~= "" and arg_332_1.actors_[var_335_4.prefab_name] ~= nil then
						local var_335_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_4.prefab_name].transform, "story_v_out_321332", "321332077", "story_v_out_321332.awb")

						arg_332_1:RecordAudio("321332077", var_335_9)
						arg_332_1:RecordAudio("321332077", var_335_9)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_321332", "321332077", "story_v_out_321332.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_321332", "321332077", "story_v_out_321332.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_10 = math.max(var_335_3, arg_332_1.talkMaxDuration)

			if var_335_2 <= arg_332_1.time_ and arg_332_1.time_ < var_335_2 + var_335_10 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_2) / var_335_10

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_2 + var_335_10 and arg_332_1.time_ < var_335_2 + var_335_10 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play321332078 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 321332078
		arg_336_1.duration_ = 5.1

		local var_336_0 = {
			zh = 4.266,
			ja = 5.1
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play321332079(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(arg_336_1.actors_["4037ui_story"]) and arg_336_1.var_.characterEffect4037ui_story == nil then
				arg_336_1.var_.characterEffect4037ui_story = arg_336_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_0 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 and not isNil(arg_336_1.actors_["4037ui_story"]) then
				if arg_336_1.var_.characterEffect4037ui_story and not isNil(arg_336_1.actors_["4037ui_story"]) then
					arg_336_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_336_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_336_1.time_ - 0) / var_339_0)
				end
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 and not isNil(arg_336_1.actors_["4037ui_story"]) and arg_336_1.var_.characterEffect4037ui_story then
				arg_336_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_336_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_339_1 = 0
			local var_339_2 = 0.25

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_3 = arg_336_1:GetWordFromCfg(321332078)
				local var_339_4 = arg_336_1:FormatText(var_339_3.content)

				arg_336_1.text_.text = var_339_4

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_6 = 10 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_4) / 10)

				if (10 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_4) / 10)) > 0 and var_339_2 < var_339_6 then
					arg_336_1.talkMaxDuration = var_339_6

					if var_339_6 + var_339_1 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_6 + var_339_1
					end
				end

				arg_336_1.text_.text = var_339_4
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332078", "story_v_out_321332.awb") ~= 0 then
					local var_339_7 = manager.audio:GetVoiceLength("story_v_out_321332", "321332078", "story_v_out_321332.awb") / 1000

					if var_339_7 + var_339_1 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_1
					end

					if var_339_3.prefab_name ~= "" and arg_336_1.actors_[var_339_3.prefab_name] ~= nil then
						local var_339_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_3.prefab_name].transform, "story_v_out_321332", "321332078", "story_v_out_321332.awb")

						arg_336_1:RecordAudio("321332078", var_339_8)
						arg_336_1:RecordAudio("321332078", var_339_8)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_321332", "321332078", "story_v_out_321332.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_321332", "321332078", "story_v_out_321332.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_9 = math.max(var_339_2, arg_336_1.talkMaxDuration)

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_9 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_1) / var_339_9

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_1 + var_339_9 and arg_336_1.time_ < var_339_1 + var_339_9 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play321332079 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 321332079
		arg_340_1.duration_ = 12.47

		local var_340_0 = {
			zh = 9.533,
			ja = 12.466
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play321332080(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["4037ui_story"]) and arg_340_1.var_.characterEffect4037ui_story == nil then
				arg_340_1.var_.characterEffect4037ui_story = arg_340_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_0 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["4037ui_story"]) then
				if arg_340_1.var_.characterEffect4037ui_story and not isNil(arg_340_1.actors_["4037ui_story"]) then
					arg_340_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["4037ui_story"]) and arg_340_1.var_.characterEffect4037ui_story then
				arg_340_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_1")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_343_2 = 0
			local var_343_3 = 0.775

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_2 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_4 = arg_340_1:GetWordFromCfg(321332079)
				local var_343_5 = arg_340_1:FormatText(var_343_4.content)

				arg_340_1.text_.text = var_343_5

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_7 = 31 <= 0 and var_343_3 or var_343_3 * (utf8.len(var_343_5) / 31)

				if (31 <= 0 and var_343_3 or var_343_3 * (utf8.len(var_343_5) / 31)) > 0 and var_343_3 < var_343_7 then
					arg_340_1.talkMaxDuration = var_343_7

					if var_343_7 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_2
					end
				end

				arg_340_1.text_.text = var_343_5
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332079", "story_v_out_321332.awb") ~= 0 then
					local var_343_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332079", "story_v_out_321332.awb") / 1000

					if var_343_8 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_8 + var_343_2
					end

					if var_343_4.prefab_name ~= "" and arg_340_1.actors_[var_343_4.prefab_name] ~= nil then
						local var_343_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_4.prefab_name].transform, "story_v_out_321332", "321332079", "story_v_out_321332.awb")

						arg_340_1:RecordAudio("321332079", var_343_9)
						arg_340_1:RecordAudio("321332079", var_343_9)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_321332", "321332079", "story_v_out_321332.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_321332", "321332079", "story_v_out_321332.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_10 = math.max(var_343_3, arg_340_1.talkMaxDuration)

			if var_343_2 <= arg_340_1.time_ and arg_340_1.time_ < var_343_2 + var_343_10 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_2) / var_343_10

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_2 + var_343_10 and arg_340_1.time_ < var_343_2 + var_343_10 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play321332080 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 321332080
		arg_344_1.duration_ = 7.37

		local var_344_0 = {
			zh = 5.433,
			ja = 7.366
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play321332081(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 3.917 < arg_344_1.time_ and arg_344_1.time_ <= 3.917 + arg_347_0 then
				arg_344_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum03", "")
			end

			if 3.917 < arg_344_1.time_ and arg_344_1.time_ <= 3.917 + arg_347_0 then
				arg_344_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_boxing_amb_cheer03_loop", "")
			end

			local var_347_2 = 0
			local var_347_3 = 0.325

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_2 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_4 = arg_344_1:GetWordFromCfg(321332080)
				local var_347_5 = arg_344_1:FormatText(var_347_4.content)

				arg_344_1.text_.text = var_347_5

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_7 = 13 <= 0 and var_347_3 or var_347_3 * (utf8.len(var_347_5) / 13)

				if (13 <= 0 and var_347_3 or var_347_3 * (utf8.len(var_347_5) / 13)) > 0 and var_347_3 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_2 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_2
					end
				end

				arg_344_1.text_.text = var_347_5
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332080", "story_v_out_321332.awb") ~= 0 then
					local var_347_8 = manager.audio:GetVoiceLength("story_v_out_321332", "321332080", "story_v_out_321332.awb") / 1000

					if var_347_8 + var_347_2 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_8 + var_347_2
					end

					if var_347_4.prefab_name ~= "" and arg_344_1.actors_[var_347_4.prefab_name] ~= nil then
						local var_347_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_4.prefab_name].transform, "story_v_out_321332", "321332080", "story_v_out_321332.awb")

						arg_344_1:RecordAudio("321332080", var_347_9)
						arg_344_1:RecordAudio("321332080", var_347_9)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_321332", "321332080", "story_v_out_321332.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_321332", "321332080", "story_v_out_321332.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_10 = math.max(var_347_3, arg_344_1.talkMaxDuration)

			if var_347_2 <= arg_344_1.time_ and arg_344_1.time_ < var_347_2 + var_347_10 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_2) / var_347_10

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_2 + var_347_10 and arg_344_1.time_ < var_347_2 + var_347_10 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play321332081 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 321332081
		arg_348_1.duration_ = 6.27

		local var_348_0 = {
			zh = 6.266,
			ja = 5.766
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play321332082(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_9000

			if arg_348_1.bgs_.MS2110a == nil then
				local var_351_0 = Object.Instantiate(arg_348_1.paintGo_)

				var_351_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2110a")
				var_351_0.name = "MS2110a"
				var_351_0.transform.parent = arg_348_1.stage_.transform
				var_351_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_348_1.bgs_.MS2110a = var_351_0
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				local var_351_1 = arg_348_1.bgs_.MS2110a

				arg_348_1.bgs_.MS2110a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_351_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_351_2 = var_351_1:GetComponent("SpriteRenderer")

				if var_351_2 and var_351_2.sprite then
					local var_351_3 = 2 * (var_351_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_351_1.transform.localScale = Vector3.New(var_351_3 / var_351_2.sprite.bounds.size.y < var_351_3 * manager.ui.mainCameraCom_.aspect / var_351_2.sprite.bounds.size.x and var_351_3 * manager.ui.mainCameraCom_.aspect / var_351_2.sprite.bounds.size.x or var_351_3 / var_351_2.sprite.bounds.size.y, var_351_3 / var_351_2.sprite.bounds.size.y < var_351_3 * manager.ui.mainCameraCom_.aspect / var_351_2.sprite.bounds.size.x and var_351_3 * manager.ui.mainCameraCom_.aspect / var_351_2.sprite.bounds.size.x or var_351_3 / var_351_2.sprite.bounds.size.y, 0)
				end

				for iter_351_0, iter_351_1 in pairs(arg_348_1.bgs_) do
					if iter_351_0 ~= "MS2110a" then
						iter_351_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_351_4 = 2

			if 2 < arg_348_1.time_ and arg_348_1.time_ <= var_351_4 + arg_351_0 then
				arg_348_1.allBtn_.enabled = false
			end

			if arg_348_1.time_ >= var_351_4 + 0.3 and arg_348_1.time_ < var_351_4 + 0.3 + arg_351_0 then
				arg_348_1.allBtn_.enabled = true
			end

			local var_351_5 = 0

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_5 + arg_351_0 then
				arg_348_1.mask_.enabled = true
				arg_348_1.mask_.raycastTarget = true

				arg_348_1:SetGaussion(false)
			end

			local var_351_6 = 4.03400000184774

			if var_351_5 <= arg_348_1.time_ and arg_348_1.time_ < var_351_5 + var_351_6 then
				local var_351_7 = Color.New(0, 0, 0)

				var_351_7.a = Mathf.Lerp(1, 0, (arg_348_1.time_ - var_351_5) / var_351_6)
				arg_348_1.mask_.color = var_351_7
			end

			if arg_348_1.time_ >= var_351_5 + var_351_6 and arg_348_1.time_ < var_351_5 + var_351_6 + arg_351_0 then
				local var_351_8 = Color.New(0, 0, 0)

				arg_348_1.mask_.enabled = false
				var_351_8.a = 0
				arg_348_1.mask_.color = var_351_8
			end

			local var_351_9 = arg_348_1.actors_["4037ui_story"].transform

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos4037ui_story = var_351_9.localPosition
			end

			local var_351_10 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_10 then
				var_351_9.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_348_1.time_ - 0) / var_351_10)
				var_351_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_351_9.position).x, (manager.ui.mainCamera.transform.position - var_351_9.position).y, (manager.ui.mainCamera.transform.position - var_351_9.position).z)
				var_351_9.localEulerAngles.z = 0
				var_351_9.localEulerAngles.x = 0
				var_351_9.localEulerAngles = var_351_9.localEulerAngles
			end

			if arg_348_1.time_ >= 0 + var_351_10 and arg_348_1.time_ < 0 + var_351_10 + arg_351_0 then
				var_351_9.localPosition = Vector3.New(0, 100, 0)
				var_351_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_351_9.position).x, (manager.ui.mainCamera.transform.position - var_351_9.position).y, (manager.ui.mainCamera.transform.position - var_351_9.position).z)
				var_351_9.localEulerAngles.z = 0
				var_351_9.localEulerAngles.x = 0
				var_351_9.localEulerAngles = var_351_9.localEulerAngles
			end

			local var_351_11 = arg_348_1.actors_["4037ui_story"]

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(var_351_11) and arg_348_1.var_.characterEffect4037ui_story == nil then
				arg_348_1.var_.characterEffect4037ui_story = var_351_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_12 = 0.034000001847744

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_12 and not isNil(var_351_11) then
				if arg_348_1.var_.characterEffect4037ui_story and not isNil(var_351_11) then
					arg_348_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_348_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_348_1.time_ - 0) / var_351_12)
				end
			end

			if arg_348_1.time_ >= 0 + var_351_12 and arg_348_1.time_ < 0 + var_351_12 + arg_351_0 and not isNil(var_351_11) and arg_348_1.var_.characterEffect4037ui_story then
				arg_348_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_348_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				if arg_348_1.var_.characterEffect4037ui_story == nil then
					arg_348_1.var_.characterEffect4037ui_story = arg_348_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_351_13 = arg_348_1.var_.characterEffect4037ui_story

				arg_348_1.var_.characterEffect4037ui_story.imageEffect:turnOff()

				var_351_13.interferenceEffect.enabled = false
				var_351_13.interferenceEffect.noise = 0.001
				var_351_13.interferenceEffect.simTimeScale = 1
				var_351_13.interferenceEffect.geometryOutlineColor = Color.New(0.509434, 0.509434, 0.509434, 1)
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				if arg_348_1.var_.characterEffect4037ui_story == nil then
					arg_348_1.var_.characterEffect4037ui_story = arg_348_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_348_1.var_.characterEffect4037ui_story.imageEffect:turnOff()
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				local var_351_15 = arg_348_1.var_.effectluobonazhuanchang4

				if not arg_348_1.var_.effectluobonazhuanchang4 then
					var_351_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_351_15.name = "luobonazhuanchang4"
					arg_348_1.var_.effectluobonazhuanchang4 = var_351_15
				else
					var_351_15.transform:SetParent(var_351_9000)
				end

				var_351_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_351_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_351_17 = arg_348_1.bgs_.MS2110a.transform

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPosMS2110a = var_351_17.localPosition
			end

			local var_351_18 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_18 then
				var_351_17.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPosMS2110a, Vector3.New(0, 1, 9.5), (arg_348_1.time_ - 0) / var_351_18)
			end

			if arg_348_1.time_ >= 0 + var_351_18 and arg_348_1.time_ < 0 + var_351_18 + arg_351_0 then
				var_351_17.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_351_19 = arg_348_1.bgs_.MS2110a.transform

			if 0.034000001847744 < arg_348_1.time_ and arg_348_1.time_ <= 0.034000001847744 + arg_351_0 then
				arg_348_1.var_.moveOldPosMS2110a = var_351_19.localPosition
			end

			local var_351_20 = 4

			if 0.034000001847744 <= arg_348_1.time_ and arg_348_1.time_ < 0.034000001847744 + var_351_20 then
				var_351_19.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPosMS2110a, Vector3.New(0, 1, 10), (arg_348_1.time_ - 0.034000001847744) / var_351_20)
			end

			if arg_348_1.time_ >= 0.034000001847744 + var_351_20 and arg_348_1.time_ < 0.034000001847744 + var_351_20 + arg_351_0 then
				var_351_19.localPosition = Vector3.New(0, 1, 10)
			end

			local var_351_21 = 2

			if 2 < arg_348_1.time_ and arg_348_1.time_ <= var_351_21 + arg_351_0 then
				arg_348_1.allBtn_.enabled = false
			end

			if arg_348_1.time_ >= var_351_21 + 2.03400000184774 and arg_348_1.time_ < var_351_21 + 2.03400000184774 + arg_351_0 then
				arg_348_1.allBtn_.enabled = true
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_whoosh04", "")
			end

			local var_351_23 = 2.293
			local var_351_24 = manager.audio:GetVoiceLength("story_v_out_321332", "321332081", "") / 1000

			if var_351_24 > 0 and 1 < var_351_24 and var_351_24 + var_351_23 > arg_348_1.duration_ then
				arg_348_1.duration_ = var_351_24 + var_351_23
			end

			if var_351_23 < arg_348_1.time_ and arg_348_1.time_ <= var_351_23 + arg_351_0 then
				arg_348_1:AudioAction("play", "voice", "story_v_out_321332", "321332081", "")
			end

			if 4.099 < arg_348_1.time_ and arg_348_1.time_ <= 4.099 + arg_351_0 then
				arg_348_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_amb_cheer04_loop", "")
			end

			if arg_348_1.frameCnt_ <= 1 then
				arg_348_1.dialog_:SetActive(false)
			end

			local var_351_27 = 2
			local var_351_28 = 1.5

			if 2 < arg_348_1.time_ and arg_348_1.time_ <= var_351_27 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0

				arg_348_1.dialog_:SetActive(true)

				arg_348_1.dialogCg_.alpha = 0

				local var_351_29 = LeanTween.value(arg_348_1.dialog_, 0, 1, 0.3)

				var_351_29:setOnUpdate(LuaHelper.FloatAction(function(arg_352_0)
					arg_348_1.dialogCg_.alpha = arg_352_0
				end))
				var_351_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_348_1.dialog_)
					var_351_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_348_1.duration_ = arg_348_1.duration_ + 0.3

				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_30 = arg_348_1:GetWordFromCfg(321332081)
				local var_351_31 = arg_348_1:FormatText(var_351_30.content)

				arg_348_1.text_.text = var_351_31

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_33 = 60 <= 0 and var_351_28 or var_351_28 * (utf8.len(var_351_31) / 60)

				if (60 <= 0 and var_351_28 or var_351_28 * (utf8.len(var_351_31) / 60)) > 0 and var_351_28 < var_351_33 then
					arg_348_1.talkMaxDuration = var_351_33
					var_351_27 = var_351_27 + 0.3

					if var_351_33 + var_351_27 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_33 + var_351_27
					end
				end

				arg_348_1.text_.text = var_351_31
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332081", "story_v_out_321332.awb") ~= 0 then
					local var_351_34 = manager.audio:GetVoiceLength("story_v_out_321332", "321332081", "story_v_out_321332.awb") / 1000

					if var_351_34 + var_351_27 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_34 + var_351_27
					end

					if var_351_30.prefab_name ~= "" and arg_348_1.actors_[var_351_30.prefab_name] ~= nil then
						local var_351_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_30.prefab_name].transform, "story_v_out_321332", "321332081", "story_v_out_321332.awb")

						arg_348_1:RecordAudio("321332081", var_351_35)
						arg_348_1:RecordAudio("321332081", var_351_35)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_321332", "321332081", "story_v_out_321332.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_321332", "321332081", "story_v_out_321332.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_36 = var_351_27 + 0.3
			local var_351_37 = math.max(var_351_28, arg_348_1.talkMaxDuration)

			if var_351_27 + 0.3 <= arg_348_1.time_ and arg_348_1.time_ < var_351_36 + var_351_37 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_36) / var_351_37

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_36 + var_351_37 and arg_348_1.time_ < var_351_36 + var_351_37 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "MS2110a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2110a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.034000001847744,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play321332082 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 321332082
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play321332083(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0.05 < arg_354_1.time_ and arg_354_1.time_ <= 0.05 + arg_357_0 then
				arg_354_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_blood", "")
			end

			local var_357_1 = 0
			local var_357_2 = 1.3

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_3 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(321332082).content)

				arg_354_1.text_.text = var_357_3

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 52 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 52)

				if (52 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 52)) > 0 and var_357_2 < var_357_5 then
					arg_354_1.talkMaxDuration = var_357_5

					if var_357_5 + var_357_1 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + var_357_1
					end
				end

				arg_354_1.text_.text = var_357_3
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_6 = math.max(var_357_2, arg_354_1.talkMaxDuration)

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_6 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_1) / var_357_6

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_1 + var_357_6 and arg_354_1.time_ < var_357_1 + var_357_6 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play321332083 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 321332083
		arg_358_1.duration_ = 3.7

		local var_358_0 = {
			zh = 3.7,
			ja = 3.666
		}
		local var_358_1 = manager.audio:GetLocalizationFlag()

		if var_358_0[var_358_1] ~= nil then
			arg_358_1.duration_ = var_358_0[var_358_1]
		end

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play321332084(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0.2

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_1 = arg_358_1:GetWordFromCfg(321332083)
				local var_361_2 = arg_358_1:FormatText(var_361_1.content)

				arg_358_1.text_.text = var_361_2

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_4 = 8 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 8)

				if (8 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_2) / 8)) > 0 and var_361_0 < var_361_4 then
					arg_358_1.talkMaxDuration = var_361_4

					if var_361_4 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_4 + 0
					end
				end

				arg_358_1.text_.text = var_361_2
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332083", "story_v_out_321332.awb") ~= 0 then
					local var_361_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332083", "story_v_out_321332.awb") / 1000

					if var_361_5 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_5 + 0
					end

					if var_361_1.prefab_name ~= "" and arg_358_1.actors_[var_361_1.prefab_name] ~= nil then
						local var_361_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_1.prefab_name].transform, "story_v_out_321332", "321332083", "story_v_out_321332.awb")

						arg_358_1:RecordAudio("321332083", var_361_6)
						arg_358_1:RecordAudio("321332083", var_361_6)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_321332", "321332083", "story_v_out_321332.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_321332", "321332083", "story_v_out_321332.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_7 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_7 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_7

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_7 and arg_358_1.time_ < 0 + var_361_7 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play321332084 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 321332084
		arg_362_1.duration_ = 7.13

		local var_362_0 = {
			zh = 7.133,
			ja = 6.733
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play321332085(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.3

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_1 = arg_362_1:GetWordFromCfg(321332084)
				local var_365_2 = arg_362_1:FormatText(var_365_1.content)

				arg_362_1.text_.text = var_365_2

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 12 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 12)

				if (12 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 12)) > 0 and var_365_0 < var_365_4 then
					arg_362_1.talkMaxDuration = var_365_4

					if var_365_4 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_4 + 0
					end
				end

				arg_362_1.text_.text = var_365_2
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332084", "story_v_out_321332.awb") ~= 0 then
					local var_365_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332084", "story_v_out_321332.awb") / 1000

					if var_365_5 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + 0
					end

					if var_365_1.prefab_name ~= "" and arg_362_1.actors_[var_365_1.prefab_name] ~= nil then
						local var_365_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_1.prefab_name].transform, "story_v_out_321332", "321332084", "story_v_out_321332.awb")

						arg_362_1:RecordAudio("321332084", var_365_6)
						arg_362_1:RecordAudio("321332084", var_365_6)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_321332", "321332084", "story_v_out_321332.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_321332", "321332084", "story_v_out_321332.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play321332085 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 321332085
		arg_366_1.duration_ = 7.43

		local var_366_0 = {
			zh = 6.533,
			ja = 7.433
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play321332086(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0.25

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_1 = arg_366_1:GetWordFromCfg(321332085)
				local var_369_2 = arg_366_1:FormatText(var_369_1.content)

				arg_366_1.text_.text = var_369_2

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_4 = 10 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_2) / 10)

				if (10 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_2) / 10)) > 0 and var_369_0 < var_369_4 then
					arg_366_1.talkMaxDuration = var_369_4

					if var_369_4 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_4 + 0
					end
				end

				arg_366_1.text_.text = var_369_2
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332085", "story_v_out_321332.awb") ~= 0 then
					local var_369_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332085", "story_v_out_321332.awb") / 1000

					if var_369_5 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_5 + 0
					end

					if var_369_1.prefab_name ~= "" and arg_366_1.actors_[var_369_1.prefab_name] ~= nil then
						local var_369_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_1.prefab_name].transform, "story_v_out_321332", "321332085", "story_v_out_321332.awb")

						arg_366_1:RecordAudio("321332085", var_369_6)
						arg_366_1:RecordAudio("321332085", var_369_6)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_321332", "321332085", "story_v_out_321332.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_321332", "321332085", "story_v_out_321332.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_7 = math.max(var_369_0, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_7 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - 0) / var_369_7

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play321332086 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 321332086
		arg_370_1.duration_ = 4.1

		local var_370_0 = {
			zh = 4.1,
			ja = 3.566
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play321332087(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = manager.audio:GetVoiceLength("story_v_out_321332", "321332086", "") / 1000

			if var_373_0 > 0 and 1 < var_373_0 and var_373_0 + 0 > arg_370_1.duration_ then
				arg_370_1.duration_ = var_373_0 + 0
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1:AudioAction("play", "voice", "story_v_out_321332", "321332086", "")
			end

			if 0.668 < arg_370_1.time_ and arg_370_1.time_ <= 0.668 + arg_373_0 then
				arg_370_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum02", "")
			end

			if 0.579 < arg_370_1.time_ and arg_370_1.time_ <= 0.579 + arg_373_0 then
				arg_370_1:AudioAction("play", "effect", "se_story_141", "se_story_141_ravana_footstep03", "")
			end

			if 0.415 < arg_370_1.time_ and arg_370_1.time_ <= 0.415 + arg_373_0 then
				arg_370_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_amb_cheer05_loop", "")
			end

			local var_373_5 = 0
			local var_373_6 = 1.6

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_5 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_7 = arg_370_1:GetWordFromCfg(321332086)
				local var_373_8 = arg_370_1:FormatText(var_373_7.content)

				arg_370_1.text_.text = var_373_8

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_10 = 64 <= 0 and var_373_6 or var_373_6 * (utf8.len(var_373_8) / 64)

				if (64 <= 0 and var_373_6 or var_373_6 * (utf8.len(var_373_8) / 64)) > 0 and var_373_6 < var_373_10 then
					arg_370_1.talkMaxDuration = var_373_10

					if var_373_10 + var_373_5 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_10 + var_373_5
					end
				end

				arg_370_1.text_.text = var_373_8
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332086", "story_v_out_321332.awb") ~= 0 then
					local var_373_11 = manager.audio:GetVoiceLength("story_v_out_321332", "321332086", "story_v_out_321332.awb") / 1000

					if var_373_11 + var_373_5 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_11 + var_373_5
					end

					if var_373_7.prefab_name ~= "" and arg_370_1.actors_[var_373_7.prefab_name] ~= nil then
						local var_373_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_7.prefab_name].transform, "story_v_out_321332", "321332086", "story_v_out_321332.awb")

						arg_370_1:RecordAudio("321332086", var_373_12)
						arg_370_1:RecordAudio("321332086", var_373_12)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_321332", "321332086", "story_v_out_321332.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_321332", "321332086", "story_v_out_321332.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_13 = math.max(var_373_6, arg_370_1.talkMaxDuration)

			if var_373_5 <= arg_370_1.time_ and arg_370_1.time_ < var_373_5 + var_373_13 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_5) / var_373_13

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_5 + var_373_13 and arg_370_1.time_ < var_373_5 + var_373_13 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play321332087 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 321332087
		arg_374_1.duration_ = 13.63

		local var_374_0 = {
			zh = 9.2,
			ja = 13.633
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play321332088(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.575

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:GetWordFromCfg(321332087)
				local var_377_2 = arg_374_1:FormatText(var_377_1.content)

				arg_374_1.text_.text = var_377_2

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_4 = 23 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 23)

				if (23 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_2) / 23)) > 0 and var_377_0 < var_377_4 then
					arg_374_1.talkMaxDuration = var_377_4

					if var_377_4 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_4 + 0
					end
				end

				arg_374_1.text_.text = var_377_2
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332087", "story_v_out_321332.awb") ~= 0 then
					local var_377_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332087", "story_v_out_321332.awb") / 1000

					if var_377_5 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_5 + 0
					end

					if var_377_1.prefab_name ~= "" and arg_374_1.actors_[var_377_1.prefab_name] ~= nil then
						local var_377_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_1.prefab_name].transform, "story_v_out_321332", "321332087", "story_v_out_321332.awb")

						arg_374_1:RecordAudio("321332087", var_377_6)
						arg_374_1:RecordAudio("321332087", var_377_6)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_321332", "321332087", "story_v_out_321332.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_321332", "321332087", "story_v_out_321332.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_7 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_7

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play321332088 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 321332088
		arg_378_1.duration_ = 14.97

		local var_378_0 = {
			zh = 8.666,
			ja = 14.966
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play321332089(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0.575

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_1 = arg_378_1:GetWordFromCfg(321332088)
				local var_381_2 = arg_378_1:FormatText(var_381_1.content)

				arg_378_1.text_.text = var_381_2

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 23 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 23)

				if (23 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 23)) > 0 and var_381_0 < var_381_4 then
					arg_378_1.talkMaxDuration = var_381_4

					if var_381_4 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_4 + 0
					end
				end

				arg_378_1.text_.text = var_381_2
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332088", "story_v_out_321332.awb") ~= 0 then
					local var_381_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332088", "story_v_out_321332.awb") / 1000

					if var_381_5 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + 0
					end

					if var_381_1.prefab_name ~= "" and arg_378_1.actors_[var_381_1.prefab_name] ~= nil then
						local var_381_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_1.prefab_name].transform, "story_v_out_321332", "321332088", "story_v_out_321332.awb")

						arg_378_1:RecordAudio("321332088", var_381_6)
						arg_378_1:RecordAudio("321332088", var_381_6)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_321332", "321332088", "story_v_out_321332.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_321332", "321332088", "story_v_out_321332.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_7 = math.max(var_381_0, arg_378_1.talkMaxDuration)

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_7 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - 0) / var_381_7

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= 0 + var_381_7 and arg_378_1.time_ < 0 + var_381_7 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play321332089 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 321332089
		arg_382_1.duration_ = 11.63

		local var_382_0 = {
			zh = 8.966,
			ja = 11.633
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play321332090(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0.55

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_1 = arg_382_1:GetWordFromCfg(321332089)
				local var_385_2 = arg_382_1:FormatText(var_385_1.content)

				arg_382_1.text_.text = var_385_2

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_4 = 22 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_2) / 22)

				if (22 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_2) / 22)) > 0 and var_385_0 < var_385_4 then
					arg_382_1.talkMaxDuration = var_385_4

					if var_385_4 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_4 + 0
					end
				end

				arg_382_1.text_.text = var_385_2
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332089", "story_v_out_321332.awb") ~= 0 then
					local var_385_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332089", "story_v_out_321332.awb") / 1000

					if var_385_5 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + 0
					end

					if var_385_1.prefab_name ~= "" and arg_382_1.actors_[var_385_1.prefab_name] ~= nil then
						local var_385_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_1.prefab_name].transform, "story_v_out_321332", "321332089", "story_v_out_321332.awb")

						arg_382_1:RecordAudio("321332089", var_385_6)
						arg_382_1:RecordAudio("321332089", var_385_6)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_321332", "321332089", "story_v_out_321332.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_321332", "321332089", "story_v_out_321332.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_7 = math.max(var_385_0, arg_382_1.talkMaxDuration)

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_7 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - 0) / var_385_7

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= 0 + var_385_7 and arg_382_1.time_ < 0 + var_385_7 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play321332090 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 321332090
		arg_386_1.duration_ = 4

		local var_386_0 = {
			zh = 4,
			ja = 3.5
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play321332091(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:AudioAction("play", "effect", "story_v_out_321332", "321332090", "")
			end

			if 0.84 < arg_386_1.time_ and arg_386_1.time_ <= 0.84 + arg_389_0 then
				arg_386_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum02", "")
			end

			if 0.269 < arg_386_1.time_ and arg_386_1.time_ <= 0.269 + arg_389_0 then
				arg_386_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_cheer03_begin", "")
			end

			local var_389_3 = 0
			local var_389_4 = 1.375

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_3 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_5 = arg_386_1:GetWordFromCfg(321332090)
				local var_389_6 = arg_386_1:FormatText(var_389_5.content)

				arg_386_1.text_.text = var_389_6

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_8 = 55 <= 0 and var_389_4 or var_389_4 * (utf8.len(var_389_6) / 55)

				if (55 <= 0 and var_389_4 or var_389_4 * (utf8.len(var_389_6) / 55)) > 0 and var_389_4 < var_389_8 then
					arg_386_1.talkMaxDuration = var_389_8

					if var_389_8 + var_389_3 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_8 + var_389_3
					end
				end

				arg_386_1.text_.text = var_389_6
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332090", "story_v_out_321332.awb") ~= 0 then
					local var_389_9 = manager.audio:GetVoiceLength("story_v_out_321332", "321332090", "story_v_out_321332.awb") / 1000

					if var_389_9 + var_389_3 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_9 + var_389_3
					end

					if var_389_5.prefab_name ~= "" and arg_386_1.actors_[var_389_5.prefab_name] ~= nil then
						local var_389_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_5.prefab_name].transform, "story_v_out_321332", "321332090", "story_v_out_321332.awb")

						arg_386_1:RecordAudio("321332090", var_389_10)
						arg_386_1:RecordAudio("321332090", var_389_10)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_321332", "321332090", "story_v_out_321332.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_321332", "321332090", "story_v_out_321332.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_11 = math.max(var_389_4, arg_386_1.talkMaxDuration)

			if var_389_3 <= arg_386_1.time_ and arg_386_1.time_ < var_389_3 + var_389_11 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_3) / var_389_11

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_3 + var_389_11 and arg_386_1.time_ < var_389_3 + var_389_11 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play321332091 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 321332091
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play321332092(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0.05 < arg_390_1.time_ and arg_390_1.time_ <= 0.05 + arg_393_0 then
				arg_390_1:AudioAction("play", "effect", "se_story_141", "se_story_141_ravana_footstep04", "")
			end

			local var_393_1 = 0
			local var_393_2 = 1.25

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_3 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(321332091).content)

				arg_390_1.text_.text = var_393_3

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 50 <= 0 and var_393_2 or var_393_2 * (utf8.len(var_393_3) / 50)

				if (50 <= 0 and var_393_2 or var_393_2 * (utf8.len(var_393_3) / 50)) > 0 and var_393_2 < var_393_5 then
					arg_390_1.talkMaxDuration = var_393_5

					if var_393_5 + var_393_1 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + var_393_1
					end
				end

				arg_390_1.text_.text = var_393_3
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_6 = math.max(var_393_2, arg_390_1.talkMaxDuration)

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_6 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_1) / var_393_6

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_1 + var_393_6 and arg_390_1.time_ < var_393_1 + var_393_6 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play321332092 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 321332092
		arg_394_1.duration_ = 6.5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play321332093(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				local var_397_0 = arg_394_1.bgs_.MS2110a

				arg_394_1.bgs_.MS2110a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_397_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_397_1 = var_397_0:GetComponent("SpriteRenderer")

				if var_397_1 and var_397_1.sprite then
					local var_397_2 = 2 * (var_397_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_397_0.transform.localScale = Vector3.New(var_397_2 / var_397_1.sprite.bounds.size.y < var_397_2 * manager.ui.mainCameraCom_.aspect / var_397_1.sprite.bounds.size.x and var_397_2 * manager.ui.mainCameraCom_.aspect / var_397_1.sprite.bounds.size.x or var_397_2 / var_397_1.sprite.bounds.size.y, var_397_2 / var_397_1.sprite.bounds.size.y < var_397_2 * manager.ui.mainCameraCom_.aspect / var_397_1.sprite.bounds.size.x and var_397_2 * manager.ui.mainCameraCom_.aspect / var_397_1.sprite.bounds.size.x or var_397_2 / var_397_1.sprite.bounds.size.y, 0)
				end

				for iter_397_0, iter_397_1 in pairs(arg_394_1.bgs_) do
					if iter_397_0 ~= "MS2110a" then
						iter_397_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_397_3 = manager.ui.mainCamera.transform

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.shakeOldPos = var_397_3.localPosition
			end

			local var_397_4 = 0.6

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_4 then
				local var_397_5, var_397_6 = math.modf((arg_394_1.time_ - 0) / 0.066)

				var_397_3.localPosition = Vector3.New(var_397_6 * 0.13, var_397_6 * 0.13, var_397_6 * 0.13) + arg_394_1.var_.shakeOldPos
			end

			if arg_394_1.time_ >= 0 + var_397_4 and arg_394_1.time_ < 0 + var_397_4 + arg_397_0 then
				var_397_3.localPosition = arg_394_1.var_.shakeOldPos
			end

			local var_397_7 = 0

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_7 + arg_397_0 then
				arg_394_1.mask_.enabled = true
				arg_394_1.mask_.raycastTarget = true

				arg_394_1:SetGaussion(false)
			end

			local var_397_8 = 0.6

			if var_397_7 <= arg_394_1.time_ and arg_394_1.time_ < var_397_7 + var_397_8 then
				local var_397_9 = Color.New(1, 1, 1)

				var_397_9.a = Mathf.Lerp(1, 0, (arg_394_1.time_ - var_397_7) / var_397_8)
				arg_394_1.mask_.color = var_397_9
			end

			if arg_394_1.time_ >= var_397_7 + var_397_8 and arg_394_1.time_ < var_397_7 + var_397_8 + arg_397_0 then
				local var_397_10 = Color.New(1, 1, 1)

				arg_394_1.mask_.enabled = false
				var_397_10.a = 0
				arg_394_1.mask_.color = var_397_10
			end

			local var_397_11 = arg_394_1.bgs_.MS2110a.transform

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPosMS2110a = var_397_11.localPosition
			end

			local var_397_12 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_12 then
				var_397_11.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPosMS2110a, Vector3.New(0, 1.8, 6), (arg_394_1.time_ - 0) / var_397_12)
			end

			if arg_394_1.time_ >= 0 + var_397_12 and arg_394_1.time_ < 0 + var_397_12 + arg_397_0 then
				var_397_11.localPosition = Vector3.New(0, 1.8, 6)
			end

			local var_397_13 = arg_394_1.bgs_.MS2110a.transform

			if 0.0166666666666667 < arg_394_1.time_ and arg_394_1.time_ <= 0.0166666666666667 + arg_397_0 then
				arg_394_1.var_.moveOldPosMS2110a = var_397_13.localPosition
			end

			local var_397_14 = 3.5

			if 0.0166666666666667 <= arg_394_1.time_ and arg_394_1.time_ < 0.0166666666666667 + var_397_14 then
				var_397_13.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPosMS2110a, Vector3.New(0, 2, 6), (arg_394_1.time_ - 0.0166666666666667) / var_397_14)
			end

			if arg_394_1.time_ >= 0.0166666666666667 + var_397_14 and arg_394_1.time_ < 0.0166666666666667 + var_397_14 + arg_397_0 then
				var_397_13.localPosition = Vector3.New(0, 2, 6)
			end

			local var_397_15 = 1

			if 1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_15 + arg_397_0 then
				arg_394_1.allBtn_.enabled = false
			end

			if arg_394_1.time_ >= var_397_15 + 2.51666666666667 and arg_394_1.time_ < var_397_15 + 2.51666666666667 + arg_397_0 then
				arg_394_1.allBtn_.enabled = true
			end

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_whoosh05", "")
			end

			if arg_394_1.frameCnt_ <= 1 then
				arg_394_1.dialog_:SetActive(false)
			end

			local var_397_17 = 1.5
			local var_397_18 = 0.675

			if 1.5 < arg_394_1.time_ and arg_394_1.time_ <= var_397_17 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0

				arg_394_1.dialog_:SetActive(true)

				arg_394_1.dialogCg_.alpha = 0

				local var_397_19 = LeanTween.value(arg_394_1.dialog_, 0, 1, 0.3)

				var_397_19:setOnUpdate(LuaHelper.FloatAction(function(arg_398_0)
					arg_394_1.dialogCg_.alpha = arg_398_0
				end))
				var_397_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_394_1.dialog_)
					var_397_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_394_1.duration_ = arg_394_1.duration_ + 0.3

				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_20 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(321332092).content)

				arg_394_1.text_.text = var_397_20

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_22 = 27 <= 0 and var_397_18 or var_397_18 * (utf8.len(var_397_20) / 27)

				if (27 <= 0 and var_397_18 or var_397_18 * (utf8.len(var_397_20) / 27)) > 0 and var_397_18 < var_397_22 then
					arg_394_1.talkMaxDuration = var_397_22
					var_397_17 = var_397_17 + 0.3

					if var_397_22 + var_397_17 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_22 + var_397_17
					end
				end

				arg_394_1.text_.text = var_397_20
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_23 = var_397_17 + 0.3
			local var_397_24 = math.max(var_397_18, arg_394_1.talkMaxDuration)

			if var_397_17 + 0.3 <= arg_394_1.time_ and arg_394_1.time_ < var_397_23 + var_397_24 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_23) / var_397_24

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_23 + var_397_24 and arg_394_1.time_ < var_397_23 + var_397_24 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2110a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2110a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play321332093 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 321332093
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play321332094(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 1.475

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_1 = arg_400_1:FormatText(arg_400_1:GetWordFromCfg(321332093).content)

				arg_400_1.text_.text = var_403_1

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_3 = 59 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 59)

				if (59 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 59)) > 0 and var_403_0 < var_403_3 then
					arg_400_1.talkMaxDuration = var_403_3

					if var_403_3 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_3 + 0
					end
				end

				arg_400_1.text_.text = var_403_1
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_4 = math.max(var_403_0, arg_400_1.talkMaxDuration)

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_4 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - 0) / var_403_4

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= 0 + var_403_4 and arg_400_1.time_ < 0 + var_403_4 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play321332094 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 321332094
		arg_404_1.duration_ = 7.93

		local var_404_0 = {
			zh = 7.933,
			ja = 6.133
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play321332095(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0.25

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_1 = arg_404_1:GetWordFromCfg(321332094)
				local var_407_2 = arg_404_1:FormatText(var_407_1.content)

				arg_404_1.text_.text = var_407_2

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 10 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 10)

				if (10 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 10)) > 0 and var_407_0 < var_407_4 then
					arg_404_1.talkMaxDuration = var_407_4

					if var_407_4 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_4 + 0
					end
				end

				arg_404_1.text_.text = var_407_2
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332094", "story_v_out_321332.awb") ~= 0 then
					local var_407_5 = manager.audio:GetVoiceLength("story_v_out_321332", "321332094", "story_v_out_321332.awb") / 1000

					if var_407_5 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_5 + 0
					end

					if var_407_1.prefab_name ~= "" and arg_404_1.actors_[var_407_1.prefab_name] ~= nil then
						local var_407_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_1.prefab_name].transform, "story_v_out_321332", "321332094", "story_v_out_321332.awb")

						arg_404_1:RecordAudio("321332094", var_407_6)
						arg_404_1:RecordAudio("321332094", var_407_6)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_321332", "321332094", "story_v_out_321332.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_321332", "321332094", "story_v_out_321332.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_0, arg_404_1.talkMaxDuration)

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - 0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= 0 + var_407_7 and arg_404_1.time_ < 0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play321332095 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 321332095
		arg_408_1.duration_ = 8.23

		local var_408_0 = {
			zh = 8.233,
			ja = 7.2
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play321332096(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 2 < arg_408_1.time_ and arg_408_1.time_ <= 2 + arg_411_0 then
				local var_411_0 = arg_408_1.bgs_.STwhite

				arg_408_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_411_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_411_1 = var_411_0:GetComponent("SpriteRenderer")

				if var_411_1 and var_411_1.sprite then
					local var_411_2 = 2 * (var_411_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_411_0.transform.localScale = Vector3.New(var_411_2 / var_411_1.sprite.bounds.size.y < var_411_2 * manager.ui.mainCameraCom_.aspect / var_411_1.sprite.bounds.size.x and var_411_2 * manager.ui.mainCameraCom_.aspect / var_411_1.sprite.bounds.size.x or var_411_2 / var_411_1.sprite.bounds.size.y, var_411_2 / var_411_1.sprite.bounds.size.y < var_411_2 * manager.ui.mainCameraCom_.aspect / var_411_1.sprite.bounds.size.x and var_411_2 * manager.ui.mainCameraCom_.aspect / var_411_1.sprite.bounds.size.x or var_411_2 / var_411_1.sprite.bounds.size.y, 0)
				end

				for iter_411_0, iter_411_1 in pairs(arg_408_1.bgs_) do
					if iter_411_0 ~= "STwhite" then
						iter_411_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_411_3 = 4

			if 4 < arg_408_1.time_ and arg_408_1.time_ <= var_411_3 + arg_411_0 then
				arg_408_1.allBtn_.enabled = false
			end

			if arg_408_1.time_ >= var_411_3 + 0.3 and arg_408_1.time_ < var_411_3 + 0.3 + arg_411_0 then
				arg_408_1.allBtn_.enabled = true
			end

			local var_411_4 = 0

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_4 + arg_411_0 then
				arg_408_1.mask_.enabled = true
				arg_408_1.mask_.raycastTarget = true

				arg_408_1:SetGaussion(false)
			end

			local var_411_5 = 2

			if var_411_4 <= arg_408_1.time_ and arg_408_1.time_ < var_411_4 + var_411_5 then
				local var_411_6 = Color.New(0, 0, 0)

				var_411_6.a = Mathf.Lerp(0, 1, (arg_408_1.time_ - var_411_4) / var_411_5)
				arg_408_1.mask_.color = var_411_6
			end

			if arg_408_1.time_ >= var_411_4 + var_411_5 and arg_408_1.time_ < var_411_4 + var_411_5 + arg_411_0 then
				local var_411_7 = Color.New(0, 0, 0)

				var_411_7.a = 1
				arg_408_1.mask_.color = var_411_7
			end

			local var_411_8 = 2

			if 2 < arg_408_1.time_ and arg_408_1.time_ <= var_411_8 + arg_411_0 then
				arg_408_1.mask_.enabled = true
				arg_408_1.mask_.raycastTarget = true

				arg_408_1:SetGaussion(false)
			end

			local var_411_9 = 2

			if var_411_8 <= arg_408_1.time_ and arg_408_1.time_ < var_411_8 + var_411_9 then
				local var_411_10 = Color.New(0, 0, 0)

				var_411_10.a = Mathf.Lerp(1, 0, (arg_408_1.time_ - var_411_8) / var_411_9)
				arg_408_1.mask_.color = var_411_10
			end

			if arg_408_1.time_ >= var_411_8 + var_411_9 and arg_408_1.time_ < var_411_8 + var_411_9 + arg_411_0 then
				local var_411_11 = Color.New(0, 0, 0)

				arg_408_1.mask_.enabled = false
				var_411_11.a = 0
				arg_408_1.mask_.color = var_411_11
			end

			local var_411_12 = 0
			local var_411_13 = manager.audio:GetVoiceLength("story_v_out_321332", "321332095", "") / 1000

			if var_411_13 > 0 and 1 < var_411_13 and var_411_13 + var_411_12 > arg_408_1.duration_ then
				arg_408_1.duration_ = var_411_13 + var_411_12
			end

			if var_411_12 < arg_408_1.time_ and arg_408_1.time_ <= var_411_12 + arg_411_0 then
				arg_408_1:AudioAction("play", "voice", "story_v_out_321332", "321332095", "")
			end

			if 0.764 < arg_408_1.time_ and arg_408_1.time_ <= 0.764 + arg_411_0 then
				arg_408_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_bell01", "")
			end

			if 0.764 < arg_408_1.time_ and arg_408_1.time_ <= 0.764 + arg_411_0 then
				arg_408_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_amb_cheer06_loop", "")
			end

			if 1.491 < arg_408_1.time_ and arg_408_1.time_ <= 1.491 + arg_411_0 then
				arg_408_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_boxing_amb_cheer05_loop", "")
			end

			if 1.491 < arg_408_1.time_ and arg_408_1.time_ <= 1.491 + arg_411_0 then
				arg_408_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_boxing_amb_cheer04_loop", "")
			end

			if arg_408_1.frameCnt_ <= 1 then
				arg_408_1.dialog_:SetActive(false)
			end

			local var_411_19 = 4
			local var_411_20 = 1.125

			if 4 < arg_408_1.time_ and arg_408_1.time_ <= var_411_19 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0

				arg_408_1.dialog_:SetActive(true)

				arg_408_1.dialogCg_.alpha = 0

				local var_411_21 = LeanTween.value(arg_408_1.dialog_, 0, 1, 0.3)

				var_411_21:setOnUpdate(LuaHelper.FloatAction(function(arg_412_0)
					arg_408_1.dialogCg_.alpha = arg_412_0
				end))
				var_411_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_408_1.dialog_)
					var_411_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_408_1.duration_ = arg_408_1.duration_ + 0.3

				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_22 = arg_408_1:GetWordFromCfg(321332095)
				local var_411_23 = arg_408_1:FormatText(var_411_22.content)

				arg_408_1.text_.text = var_411_23

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_25 = 45 <= 0 and var_411_20 or var_411_20 * (utf8.len(var_411_23) / 45)

				if (45 <= 0 and var_411_20 or var_411_20 * (utf8.len(var_411_23) / 45)) > 0 and var_411_20 < var_411_25 then
					arg_408_1.talkMaxDuration = var_411_25
					var_411_19 = var_411_19 + 0.3

					if var_411_25 + var_411_19 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_25 + var_411_19
					end
				end

				arg_408_1.text_.text = var_411_23
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321332", "321332095", "story_v_out_321332.awb") ~= 0 then
					local var_411_26 = manager.audio:GetVoiceLength("story_v_out_321332", "321332095", "story_v_out_321332.awb") / 1000

					if var_411_26 + var_411_19 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_26 + var_411_19
					end

					if var_411_22.prefab_name ~= "" and arg_408_1.actors_[var_411_22.prefab_name] ~= nil then
						local var_411_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_22.prefab_name].transform, "story_v_out_321332", "321332095", "story_v_out_321332.awb")

						arg_408_1:RecordAudio("321332095", var_411_27)
						arg_408_1:RecordAudio("321332095", var_411_27)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_321332", "321332095", "story_v_out_321332.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_321332", "321332095", "story_v_out_321332.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_28 = var_411_19 + 0.3
			local var_411_29 = math.max(var_411_20, arg_408_1.talkMaxDuration)

			if var_411_19 + 0.3 <= arg_408_1.time_ and arg_408_1.time_ < var_411_28 + var_411_29 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_28) / var_411_29

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_28 + var_411_29 and arg_408_1.time_ < var_411_28 + var_411_29 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play321332096 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 321332096
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
			arg_414_1.auto_ = false
		end

		function arg_414_1.playNext_(arg_416_0)
			arg_414_1.onStoryFinished_()
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_bell02", "")
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_boxing_amb_cheer06_loop", "")
			end

			local var_417_2 = 0
			local var_417_3 = 0.25

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_2 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_4 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(321332096).content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_6 = 10 <= 0 and var_417_3 or var_417_3 * (utf8.len(var_417_4) / 10)

				if (10 <= 0 and var_417_3 or var_417_3 * (utf8.len(var_417_4) / 10)) > 0 and var_417_3 < var_417_6 then
					arg_414_1.talkMaxDuration = var_417_6

					if var_417_6 + var_417_2 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_6 + var_417_2
					end
				end

				arg_414_1.text_.text = var_417_4
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_3, arg_414_1.talkMaxDuration)

			if var_417_2 <= arg_414_1.time_ and arg_414_1.time_ < var_417_2 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_2) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_2 + var_417_7 and arg_414_1.time_ < var_417_2 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L11f",
		"TextureConfig/Background/MS2110",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/ST65",
		"TextureConfig/Background/L01g",
		"TextureConfig/Background/L09h",
		"TextureConfig/Background/MS2110a"
	},
	voices = {
		"story_v_out_321332.awb"
	}
}
