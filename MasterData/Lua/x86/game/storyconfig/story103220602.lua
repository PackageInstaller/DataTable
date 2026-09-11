return {
	Play322062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322062001
		arg_1_1.duration_ = 4.57

		local var_1_0 = {
			zh = 3.533,
			ja = 4.566
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
				arg_1_0:Play322062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.L10j == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10j")
				var_4_0.name = "L10j"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L10j = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L10j

				arg_1_1.bgs_.L10j.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L10j" then
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_16 = arg_1_1.var_.effect2001

				if not arg_1_1.var_.effect2001 then
					var_4_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_wasteland_in_keep"), manager.ui.mainCamera.transform)
					var_4_16.name = "2001"
					arg_1_1.var_.effect2001 = var_4_16
				else
					var_4_16.transform:SetParent(var_4_9000)
				end

				var_4_16.transform.localPosition = Vector3.New(0, 0, -0.1)
				var_4_16.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_18 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_4_19 = var_4_16.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_4_2, iter_4_3 in ipairs((var_4_19:ToTable())) do
					iter_4_3.transform.localScale = Vector3.New(iter_4_3.transform.localScale.x / var_4_18 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_4_19 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_4_3.transform.localScale.y / var_4_18, iter_4_3.transform.localScale.z)
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_21 = 2
			local var_4_22 = 0.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_24 = arg_1_1:GetWordFromCfg(322062001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 11 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 11)

				if (11 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 11)) > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_21 = var_4_21 + 0.3

					if var_4_27 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062001", "story_v_out_322062.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_322062", "322062001", "story_v_out_322062.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_322062", "322062001", "story_v_out_322062.awb")

						arg_1_1:RecordAudio("322062001", var_4_29)
						arg_1_1:RecordAudio("322062001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322062", "322062001", "story_v_out_322062.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322062", "322062001", "story_v_out_322062.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_21 + 0.3
			local var_4_31 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play322062002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322062002
		arg_9_1.duration_ = 1.43

		local var_9_0 = {
			zh = 0.999999999999,
			ja = 1.433
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
				arg_9_0:Play322062003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(322062002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 7 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 7)

				if (7 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 7)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062002", "story_v_out_322062.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062002", "story_v_out_322062.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_322062", "322062002", "story_v_out_322062.awb")

						arg_9_1:RecordAudio("322062002", var_12_6)
						arg_9_1:RecordAudio("322062002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_322062", "322062002", "story_v_out_322062.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_322062", "322062002", "story_v_out_322062.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play322062003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322062003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play322062004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.8

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(322062003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 72 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 72)

				if (72 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 72)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play322062004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322062004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play322062005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.2

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(322062004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 48 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 48)

				if (48 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 48)) > 0 and var_20_0 < var_20_3 then
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
	Play322062005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322062005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play322062006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1.325

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(322062005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 53 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 53)

				if (53 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 53)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play322062006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322062006
		arg_25_1.duration_ = 8.5

		local var_25_0 = {
			zh = 8.499999999999,
			ja = 8.332999999999
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
				arg_25_0:Play322062007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 1 < arg_25_1.time_ and arg_25_1.time_ <= 1 + arg_28_0 then
				local var_28_0 = arg_25_1.bgs_.L10j

				arg_25_1.bgs_.L10j.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_1 = var_28_0:GetComponent("SpriteRenderer")

				if var_28_1 and var_28_1.sprite then
					local var_28_2 = 2 * (var_28_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_0.transform.localScale = Vector3.New(var_28_2 / var_28_1.sprite.bounds.size.y < var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x and var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x or var_28_2 / var_28_1.sprite.bounds.size.y, var_28_2 / var_28_1.sprite.bounds.size.y < var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x and var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x or var_28_2 / var_28_1.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "L10j" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_3 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_4 = 1

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_4 then
				local var_28_5 = Color.New(0, 0, 0)

				var_28_5.a = Mathf.Lerp(0, 1, (arg_25_1.time_ - var_28_3) / var_28_4)
				arg_25_1.mask_.color = var_28_5
			end

			if arg_25_1.time_ >= var_28_3 + var_28_4 and arg_25_1.time_ < var_28_3 + var_28_4 + arg_28_0 then
				local var_28_6 = Color.New(0, 0, 0)

				var_28_6.a = 1
				arg_25_1.mask_.color = var_28_6
			end

			local var_28_7 = 0.999999999999

			if 0.999999999999 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_8 = 1

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_8 then
				local var_28_9 = Color.New(0, 0, 0)

				var_28_9.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_7) / var_28_8)
				arg_25_1.mask_.color = var_28_9
			end

			if arg_25_1.time_ >= var_28_7 + var_28_8 and arg_25_1.time_ < var_28_7 + var_28_8 + arg_28_0 then
				local var_28_10 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_10.a = 0
				arg_25_1.mask_.color = var_28_10
			end

			local var_28_11 = "1211ui_story"

			if arg_25_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_28_12 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_25_1.stage_.transform)

				var_28_12.name = var_28_11
				var_28_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_[var_28_11] = var_28_12

				local var_28_13 = var_28_12:GetComponentInChildren(typeof(CharacterEffect))

				var_28_13.enabled = true

				local var_28_14 = GameObjectTools.GetOrAddComponent(var_28_12, typeof(DynamicBoneHelper))

				if var_28_14 then
					var_28_14:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_13.transform, false)

				arg_25_1.var_[var_28_11 .. "Animator"] = var_28_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_[var_28_11 .. "Animator"].applyRootMotion = true
				arg_25_1.var_[var_28_11 .. "LipSync"] = var_28_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_15 = arg_25_1.actors_["1211ui_story"].transform

			if 1.999999999999 < arg_25_1.time_ and arg_25_1.time_ <= 1.999999999999 + arg_28_0 then
				arg_25_1.var_.moveOldPos1211ui_story = var_28_15.localPosition

				arg_25_1:ShowWeapon(arg_25_1.var_["1211ui_story" .. "Animator"].transform, false)
			end

			local var_28_16 = 0.001

			if 1.999999999999 <= arg_25_1.time_ and arg_25_1.time_ < 1.999999999999 + var_28_16 then
				var_28_15.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_25_1.time_ - 1.999999999999) / var_28_16)
				var_28_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_15.position).x, (manager.ui.mainCamera.transform.position - var_28_15.position).y, (manager.ui.mainCamera.transform.position - var_28_15.position).z)
				var_28_15.localEulerAngles.z = 0
				var_28_15.localEulerAngles.x = 0
				var_28_15.localEulerAngles = var_28_15.localEulerAngles
			end

			if arg_25_1.time_ >= 1.999999999999 + var_28_16 and arg_25_1.time_ < 1.999999999999 + var_28_16 + arg_28_0 then
				var_28_15.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				var_28_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_15.position).x, (manager.ui.mainCamera.transform.position - var_28_15.position).y, (manager.ui.mainCamera.transform.position - var_28_15.position).z)
				var_28_15.localEulerAngles.z = 0
				var_28_15.localEulerAngles.x = 0
				var_28_15.localEulerAngles = var_28_15.localEulerAngles
			end

			local var_28_17 = arg_25_1.actors_["1211ui_story"]

			if 1.999999999999 < arg_25_1.time_ and arg_25_1.time_ <= 1.999999999999 + arg_28_0 and not isNil(var_28_17) and arg_25_1.var_.characterEffect1211ui_story == nil then
				arg_25_1.var_.characterEffect1211ui_story = var_28_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_18 = 0.200000002980232

			if 1.999999999999 <= arg_25_1.time_ and arg_25_1.time_ < 1.999999999999 + var_28_18 and not isNil(var_28_17) then
				if arg_25_1.var_.characterEffect1211ui_story and not isNil(var_28_17) then
					arg_25_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 1.999999999999 + var_28_18 and arg_25_1.time_ < 1.999999999999 + var_28_18 + arg_28_0 and not isNil(var_28_17) and arg_25_1.var_.characterEffect1211ui_story then
				arg_25_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 1.999999999999 < arg_25_1.time_ and arg_25_1.time_ <= 1.999999999999 + arg_28_0 then
				arg_25_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action2_1")
			end

			if 1.999999999999 < arg_25_1.time_ and arg_25_1.time_ <= 1.999999999999 + arg_28_0 then
				arg_25_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			if 0.999999999999001 < arg_25_1.time_ and arg_25_1.time_ <= 0.999999999999001 + arg_28_0 then
				if arg_25_1.var_.effect2001 then
					Object.Destroy(arg_25_1.var_.effect2001)

					arg_25_1.var_.effect2001 = nil
				end
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_21 = 1.999999999999
			local var_28_22 = 0.475

			if 1.999999999999 < arg_25_1.time_ and arg_25_1.time_ <= var_28_21 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_23 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_23:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_24 = arg_25_1:GetWordFromCfg(322062006)
				local var_28_25 = arg_25_1:FormatText(var_28_24.content)

				arg_25_1.text_.text = var_28_25

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_27 = 20 <= 0 and var_28_22 or var_28_22 * (utf8.len(var_28_25) / 20)

				if (20 <= 0 and var_28_22 or var_28_22 * (utf8.len(var_28_25) / 20)) > 0 and var_28_22 < var_28_27 then
					arg_25_1.talkMaxDuration = var_28_27
					var_28_21 = var_28_21 + 0.3

					if var_28_27 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_27 + var_28_21
					end
				end

				arg_25_1.text_.text = var_28_25
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062006", "story_v_out_322062.awb") ~= 0 then
					local var_28_28 = manager.audio:GetVoiceLength("story_v_out_322062", "322062006", "story_v_out_322062.awb") / 1000

					if var_28_28 + var_28_21 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_21
					end

					if var_28_24.prefab_name ~= "" and arg_25_1.actors_[var_28_24.prefab_name] ~= nil then
						local var_28_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_24.prefab_name].transform, "story_v_out_322062", "322062006", "story_v_out_322062.awb")

						arg_25_1:RecordAudio("322062006", var_28_29)
						arg_25_1:RecordAudio("322062006", var_28_29)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_322062", "322062006", "story_v_out_322062.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_322062", "322062006", "story_v_out_322062.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_30 = var_28_21 + 0.3
			local var_28_31 = math.max(var_28_22, arg_25_1.talkMaxDuration)

			if var_28_21 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_30 + var_28_31 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_30) / var_28_31

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_30 + var_28_31 and arg_25_1.time_ < var_28_30 + var_28_31 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play322062007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 322062007
		arg_31_1.duration_ = 4.7

		local var_31_0 = {
			zh = 3.733,
			ja = 4.7
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
				arg_31_0:Play322062008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if arg_31_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_34_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_31_1.stage_.transform)

				var_34_0.name = "1284ui_story"
				var_34_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["1284ui_story"] = var_34_0

				local var_34_1 = var_34_0:GetComponentInChildren(typeof(CharacterEffect))

				var_34_1.enabled = true

				local var_34_2 = GameObjectTools.GetOrAddComponent(var_34_0, typeof(DynamicBoneHelper))

				if var_34_2 then
					var_34_2:EnableDynamicBone(false)
				end

				arg_31_1:ShowWeapon(var_34_1.transform, false)

				arg_31_1.var_["1284ui_story" .. "Animator"] = var_34_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_31_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_31_1.var_["1284ui_story" .. "LipSync"] = var_34_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_34_3 = arg_31_1.actors_["1284ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1284ui_story = var_34_3.localPosition

				arg_31_1:ShowWeapon(arg_31_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_34_4 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				var_34_3.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_31_1.time_ - 0) / var_34_4)
				var_34_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_3.position).x, (manager.ui.mainCamera.transform.position - var_34_3.position).y, (manager.ui.mainCamera.transform.position - var_34_3.position).z)
				var_34_3.localEulerAngles.z = 0
				var_34_3.localEulerAngles.x = 0
				var_34_3.localEulerAngles = var_34_3.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				var_34_3.localPosition = Vector3.New(0.7, -0.985, -6.22)
				var_34_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_3.position).x, (manager.ui.mainCamera.transform.position - var_34_3.position).y, (manager.ui.mainCamera.transform.position - var_34_3.position).z)
				var_34_3.localEulerAngles.z = 0
				var_34_3.localEulerAngles.x = 0
				var_34_3.localEulerAngles = var_34_3.localEulerAngles
			end

			local var_34_5 = arg_31_1.actors_["1284ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect1284ui_story == nil then
				arg_31_1.var_.characterEffect1284ui_story = var_34_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_6 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_6 and not isNil(var_34_5) then
				if arg_31_1.var_.characterEffect1284ui_story and not isNil(var_34_5) then
					arg_31_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_6 and arg_31_1.time_ < 0 + var_34_6 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect1284ui_story then
				arg_31_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_34_8 = arg_31_1.actors_["1211ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_8) and arg_31_1.var_.characterEffect1211ui_story == nil then
				arg_31_1.var_.characterEffect1211ui_story = var_34_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_9 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_9 and not isNil(var_34_8) then
				if arg_31_1.var_.characterEffect1211ui_story and not isNil(var_34_8) then
					arg_31_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_9)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_9 and arg_31_1.time_ < 0 + var_34_9 + arg_34_0 and not isNil(var_34_8) and arg_31_1.var_.characterEffect1211ui_story then
				arg_31_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_34_10 = 0
			local var_34_11 = 0.375

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_12 = arg_31_1:GetWordFromCfg(322062007)
				local var_34_13 = arg_31_1:FormatText(var_34_12.content)

				arg_31_1.text_.text = var_34_13

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_15 = 15 <= 0 and var_34_11 or var_34_11 * (utf8.len(var_34_13) / 15)

				if (15 <= 0 and var_34_11 or var_34_11 * (utf8.len(var_34_13) / 15)) > 0 and var_34_11 < var_34_15 then
					arg_31_1.talkMaxDuration = var_34_15

					if var_34_15 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_15 + var_34_10
					end
				end

				arg_31_1.text_.text = var_34_13
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062007", "story_v_out_322062.awb") ~= 0 then
					local var_34_16 = manager.audio:GetVoiceLength("story_v_out_322062", "322062007", "story_v_out_322062.awb") / 1000

					if var_34_16 + var_34_10 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_16 + var_34_10
					end

					if var_34_12.prefab_name ~= "" and arg_31_1.actors_[var_34_12.prefab_name] ~= nil then
						local var_34_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_12.prefab_name].transform, "story_v_out_322062", "322062007", "story_v_out_322062.awb")

						arg_31_1:RecordAudio("322062007", var_34_17)
						arg_31_1:RecordAudio("322062007", var_34_17)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_322062", "322062007", "story_v_out_322062.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_322062", "322062007", "story_v_out_322062.awb")
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
				actorName = "1284ui_story",
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
	Play322062008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 322062008
		arg_35_1.duration_ = 7.93

		local var_35_0 = {
			zh = 7.933,
			ja = 7.333
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
				arg_35_0:Play322062009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1211ui_story"]) and arg_35_1.var_.characterEffect1211ui_story == nil then
				arg_35_1.var_.characterEffect1211ui_story = arg_35_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1211ui_story"]) then
				if arg_35_1.var_.characterEffect1211ui_story and not isNil(arg_35_1.actors_["1211ui_story"]) then
					arg_35_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1211ui_story"]) and arg_35_1.var_.characterEffect1211ui_story then
				arg_35_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_38_2 = arg_35_1.actors_["1284ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.characterEffect1284ui_story == nil then
				arg_35_1.var_.characterEffect1284ui_story = var_38_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_3 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_3 and not isNil(var_38_2) then
				if arg_35_1.var_.characterEffect1284ui_story and not isNil(var_38_2) then
					arg_35_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_3)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_3 and arg_35_1.time_ < 0 + var_38_3 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.characterEffect1284ui_story then
				arg_35_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action2_2")
			end

			local var_38_4 = 0
			local var_38_5 = 0.6

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(322062008)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 24 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 24)

				if (24 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 24)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062008", "story_v_out_322062.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_322062", "322062008", "story_v_out_322062.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_322062", "322062008", "story_v_out_322062.awb")

						arg_35_1:RecordAudio("322062008", var_38_11)
						arg_35_1:RecordAudio("322062008", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_322062", "322062008", "story_v_out_322062.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_322062", "322062008", "story_v_out_322062.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_12 and arg_35_1.time_ < var_38_4 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play322062009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 322062009
		arg_39_1.duration_ = 2

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play322062010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1284ui_story"]) and arg_39_1.var_.characterEffect1284ui_story == nil then
				arg_39_1.var_.characterEffect1284ui_story = arg_39_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1284ui_story"]) then
				if arg_39_1.var_.characterEffect1284ui_story and not isNil(arg_39_1.actors_["1284ui_story"]) then
					arg_39_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1284ui_story"]) and arg_39_1.var_.characterEffect1284ui_story then
				arg_39_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_42_2 = arg_39_1.actors_["1211ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.characterEffect1211ui_story == nil then
				arg_39_1.var_.characterEffect1211ui_story = var_42_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_3 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 and not isNil(var_42_2) then
				if arg_39_1.var_.characterEffect1211ui_story and not isNil(var_42_2) then
					arg_39_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_3)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 and not isNil(var_42_2) and arg_39_1.var_.characterEffect1211ui_story then
				arg_39_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_2")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_42_4 = 0
			local var_42_5 = 0.15

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(322062009)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 6 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 6)

				if (6 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 6)) > 0 and var_42_5 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062009", "story_v_out_322062.awb") ~= 0 then
					local var_42_10 = manager.audio:GetVoiceLength("story_v_out_322062", "322062009", "story_v_out_322062.awb") / 1000

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end

					if var_42_6.prefab_name ~= "" and arg_39_1.actors_[var_42_6.prefab_name] ~= nil then
						local var_42_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_6.prefab_name].transform, "story_v_out_322062", "322062009", "story_v_out_322062.awb")

						arg_39_1:RecordAudio("322062009", var_42_11)
						arg_39_1:RecordAudio("322062009", var_42_11)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_322062", "322062009", "story_v_out_322062.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_322062", "322062009", "story_v_out_322062.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_12 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_12 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_12

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_12 and arg_39_1.time_ < var_42_4 + var_42_12 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play322062010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 322062010
		arg_43_1.duration_ = 4.33

		local var_43_0 = {
			zh = 3.8,
			ja = 4.333
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
				arg_43_0:Play322062011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1284ui_story = arg_43_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1284ui_story"].transform.position).z)
				arg_43_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1284ui_story"].transform.localEulerAngles = arg_43_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1284ui_story"].transform.position).z)
				arg_43_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1284ui_story"].transform.localEulerAngles = arg_43_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1211ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1211ui_story = var_46_1.localPosition
			end

			local var_46_2 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 then
				var_46_1.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_43_1.time_ - 0) / var_46_2)
				var_46_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_1.position).x, (manager.ui.mainCamera.transform.position - var_46_1.position).y, (manager.ui.mainCamera.transform.position - var_46_1.position).z)
				var_46_1.localEulerAngles.z = 0
				var_46_1.localEulerAngles.x = 0
				var_46_1.localEulerAngles = var_46_1.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 then
				var_46_1.localPosition = Vector3.New(0, 100, 0)
				var_46_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_1.position).x, (manager.ui.mainCamera.transform.position - var_46_1.position).y, (manager.ui.mainCamera.transform.position - var_46_1.position).z)
				var_46_1.localEulerAngles.z = 0
				var_46_1.localEulerAngles.x = 0
				var_46_1.localEulerAngles = var_46_1.localEulerAngles
			end

			local var_46_3 = 0
			local var_46_4 = 0.325

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_3 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_5 = arg_43_1:GetWordFromCfg(322062010)
				local var_46_6 = arg_43_1:FormatText(var_46_5.content)

				arg_43_1.text_.text = var_46_6

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_8 = 13 <= 0 and var_46_4 or var_46_4 * (utf8.len(var_46_6) / 13)

				if (13 <= 0 and var_46_4 or var_46_4 * (utf8.len(var_46_6) / 13)) > 0 and var_46_4 < var_46_8 then
					arg_43_1.talkMaxDuration = var_46_8

					if var_46_8 + var_46_3 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_3
					end
				end

				arg_43_1.text_.text = var_46_6
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062010", "story_v_out_322062.awb") ~= 0 then
					local var_46_9 = manager.audio:GetVoiceLength("story_v_out_322062", "322062010", "story_v_out_322062.awb") / 1000

					if var_46_9 + var_46_3 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_3
					end

					if var_46_5.prefab_name ~= "" and arg_43_1.actors_[var_46_5.prefab_name] ~= nil then
						local var_46_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_5.prefab_name].transform, "story_v_out_322062", "322062010", "story_v_out_322062.awb")

						arg_43_1:RecordAudio("322062010", var_46_10)
						arg_43_1:RecordAudio("322062010", var_46_10)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_322062", "322062010", "story_v_out_322062.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_322062", "322062010", "story_v_out_322062.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_11 = math.max(var_46_4, arg_43_1.talkMaxDuration)

			if var_46_3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_3 + var_46_11 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_3) / var_46_11

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_3 + var_46_11 and arg_43_1.time_ < var_46_3 + var_46_11 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_43_1:InitPlayNodeList()
	end,
	Play322062011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 322062011
		arg_47_1.duration_ = 2.03

		local var_47_0 = {
			zh = 2.033,
			ja = 2
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
				arg_47_0:Play322062012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.075

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_1 = arg_47_1:GetWordFromCfg(322062011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 3 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 3)

				if (3 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 3)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062011", "story_v_out_322062.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062011", "story_v_out_322062.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_322062", "322062011", "story_v_out_322062.awb")

						arg_47_1:RecordAudio("322062011", var_50_6)
						arg_47_1:RecordAudio("322062011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_322062", "322062011", "story_v_out_322062.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_322062", "322062011", "story_v_out_322062.awb")
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
	Play322062012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 322062012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play322062013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if arg_51_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_54_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_51_1.stage_.transform)

				var_54_0.name = "1156ui_story"
				var_54_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["1156ui_story"] = var_54_0

				local var_54_1 = var_54_0:GetComponentInChildren(typeof(CharacterEffect))

				var_54_1.enabled = true

				local var_54_2 = GameObjectTools.GetOrAddComponent(var_54_0, typeof(DynamicBoneHelper))

				if var_54_2 then
					var_54_2:EnableDynamicBone(false)
				end

				arg_51_1:ShowWeapon(var_54_1.transform, false)

				arg_51_1.var_["1156ui_story" .. "Animator"] = var_54_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_51_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_51_1.var_["1156ui_story" .. "LipSync"] = var_54_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_54_3 = arg_51_1.actors_["1156ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1156ui_story = var_54_3.localPosition
			end

			local var_54_4 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				var_54_3.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_4)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				var_54_3.localPosition = Vector3.New(0, 100, 0)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			local var_54_5 = "404001ui_story"

			if arg_51_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_54_6 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_51_1.stage_.transform)

				var_54_6.name = var_54_5
				var_54_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_[var_54_5] = var_54_6

				local var_54_7 = var_54_6:GetComponentInChildren(typeof(CharacterEffect))

				var_54_7.enabled = true

				local var_54_8 = GameObjectTools.GetOrAddComponent(var_54_6, typeof(DynamicBoneHelper))

				if var_54_8 then
					var_54_8:EnableDynamicBone(false)
				end

				arg_51_1:ShowWeapon(var_54_7.transform, false)

				arg_51_1.var_[var_54_5 .. "Animator"] = var_54_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_51_1.var_[var_54_5 .. "Animator"].applyRootMotion = true
				arg_51_1.var_[var_54_5 .. "LipSync"] = var_54_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_54_9 = arg_51_1.actors_["404001ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos404001ui_story = var_54_9.localPosition
			end

			local var_54_10 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_10 then
				var_54_9.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_10)
				var_54_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_9.position).x, (manager.ui.mainCamera.transform.position - var_54_9.position).y, (manager.ui.mainCamera.transform.position - var_54_9.position).z)
				var_54_9.localEulerAngles.z = 0
				var_54_9.localEulerAngles.x = 0
				var_54_9.localEulerAngles = var_54_9.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_10 and arg_51_1.time_ < 0 + var_54_10 + arg_54_0 then
				var_54_9.localPosition = Vector3.New(0, 100, 0)
				var_54_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_9.position).x, (manager.ui.mainCamera.transform.position - var_54_9.position).y, (manager.ui.mainCamera.transform.position - var_54_9.position).z)
				var_54_9.localEulerAngles.z = 0
				var_54_9.localEulerAngles.x = 0
				var_54_9.localEulerAngles = var_54_9.localEulerAngles
			end

			local var_54_11 = 0
			local var_54_12 = 1.2

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_13 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(322062012).content)

				arg_51_1.text_.text = var_54_13

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_15 = 48 <= 0 and var_54_12 or var_54_12 * (utf8.len(var_54_13) / 48)

				if (48 <= 0 and var_54_12 or var_54_12 * (utf8.len(var_54_13) / 48)) > 0 and var_54_12 < var_54_15 then
					arg_51_1.talkMaxDuration = var_54_15

					if var_54_15 + var_54_11 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_15 + var_54_11
					end
				end

				arg_51_1.text_.text = var_54_13
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_16 = math.max(var_54_12, arg_51_1.talkMaxDuration)

			if var_54_11 <= arg_51_1.time_ and arg_51_1.time_ < var_54_11 + var_54_16 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_11) / var_54_16

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_11 + var_54_16 and arg_51_1.time_ < var_54_11 + var_54_16 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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

		arg_51_1:InitPlayNodeList()
	end,
	Play322062013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 322062013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play322062014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 1.725

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(322062013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 69 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 69)

				if (69 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 69)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play322062014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 322062014
		arg_59_1.duration_ = 4.17

		local var_59_0 = {
			zh = 2.8,
			ja = 4.166
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
				arg_59_0:Play322062015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos404001ui_story = arg_59_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["404001ui_story"].transform.position).z)
				arg_59_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["404001ui_story"].transform.localEulerAngles = arg_59_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_59_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["404001ui_story"].transform.position).z)
				arg_59_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["404001ui_story"].transform.localEulerAngles = arg_59_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["404001ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect404001ui_story == nil then
				arg_59_1.var_.characterEffect404001ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect404001ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect404001ui_story then
				arg_59_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_62_4 = 0
			local var_62_5 = 0.275

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(322062014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 11 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 11)

				if (11 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 11)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062014", "story_v_out_322062.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_322062", "322062014", "story_v_out_322062.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_322062", "322062014", "story_v_out_322062.awb")

						arg_59_1:RecordAudio("322062014", var_62_11)
						arg_59_1:RecordAudio("322062014", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_322062", "322062014", "story_v_out_322062.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_322062", "322062014", "story_v_out_322062.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_12 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_12 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_12

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_12 and arg_59_1.time_ < var_62_4 + var_62_12 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play322062015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 322062015
		arg_63_1.duration_ = 4.97

		local var_63_0 = {
			zh = 4.1,
			ja = 4.966
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
				arg_63_0:Play322062016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1284ui_story = arg_63_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1284ui_story"].transform.position).z)
				arg_63_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1284ui_story"].transform.localEulerAngles = arg_63_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_63_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1284ui_story"].transform.position).z)
				arg_63_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1284ui_story"].transform.localEulerAngles = arg_63_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["404001ui_story"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos404001ui_story = var_66_1.localPosition
			end

			local var_66_2 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 then
				var_66_1.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 0) / var_66_2)
				var_66_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_1.position).x, (manager.ui.mainCamera.transform.position - var_66_1.position).y, (manager.ui.mainCamera.transform.position - var_66_1.position).z)
				var_66_1.localEulerAngles.z = 0
				var_66_1.localEulerAngles.x = 0
				var_66_1.localEulerAngles = var_66_1.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 then
				var_66_1.localPosition = Vector3.New(0, 100, 0)
				var_66_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_1.position).x, (manager.ui.mainCamera.transform.position - var_66_1.position).y, (manager.ui.mainCamera.transform.position - var_66_1.position).z)
				var_66_1.localEulerAngles.z = 0
				var_66_1.localEulerAngles.x = 0
				var_66_1.localEulerAngles = var_66_1.localEulerAngles
			end

			local var_66_3 = arg_63_1.actors_["1284ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_3) and arg_63_1.var_.characterEffect1284ui_story == nil then
				arg_63_1.var_.characterEffect1284ui_story = var_66_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_4 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 and not isNil(var_66_3) then
				if arg_63_1.var_.characterEffect1284ui_story and not isNil(var_66_3) then
					arg_63_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 and not isNil(var_66_3) and arg_63_1.var_.characterEffect1284ui_story then
				arg_63_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_66_6 = arg_63_1.actors_["404001ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_6) and arg_63_1.var_.characterEffect404001ui_story == nil then
				arg_63_1.var_.characterEffect404001ui_story = var_66_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_7 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 and not isNil(var_66_6) then
				if arg_63_1.var_.characterEffect404001ui_story and not isNil(var_66_6) then
					arg_63_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_63_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_7)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 and not isNil(var_66_6) and arg_63_1.var_.characterEffect404001ui_story then
				arg_63_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_63_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_66_8 = 0
			local var_66_9 = 0.475

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_10 = arg_63_1:GetWordFromCfg(322062015)
				local var_66_11 = arg_63_1:FormatText(var_66_10.content)

				arg_63_1.text_.text = var_66_11

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_13 = 19 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 19)

				if (19 <= 0 and var_66_9 or var_66_9 * (utf8.len(var_66_11) / 19)) > 0 and var_66_9 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_8
					end
				end

				arg_63_1.text_.text = var_66_11
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062015", "story_v_out_322062.awb") ~= 0 then
					local var_66_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062015", "story_v_out_322062.awb") / 1000

					if var_66_14 + var_66_8 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_8
					end

					if var_66_10.prefab_name ~= "" and arg_63_1.actors_[var_66_10.prefab_name] ~= nil then
						local var_66_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_10.prefab_name].transform, "story_v_out_322062", "322062015", "story_v_out_322062.awb")

						arg_63_1:RecordAudio("322062015", var_66_15)
						arg_63_1:RecordAudio("322062015", var_66_15)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_322062", "322062015", "story_v_out_322062.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_322062", "322062015", "story_v_out_322062.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_16 = math.max(var_66_9, arg_63_1.talkMaxDuration)

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_8) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_8 + var_66_16 and arg_63_1.time_ < var_66_8 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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

		arg_63_1:InitPlayNodeList()
	end,
	Play322062016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 322062016
		arg_67_1.duration_ = 8.33

		local var_67_0 = {
			zh = 5.833,
			ja = 8.333
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
				arg_67_0:Play322062017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1156ui_story = arg_67_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1156ui_story, Vector3.New(0.9, -1.1, -6.18), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1156ui_story"].transform.position).z)
				arg_67_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1156ui_story"].transform.localEulerAngles = arg_67_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0.9, -1.1, -6.18)
				arg_67_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1156ui_story"].transform.position).z)
				arg_67_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1156ui_story"].transform.localEulerAngles = arg_67_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1156ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1156ui_story == nil then
				arg_67_1.var_.characterEffect1156ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1156ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1156ui_story then
				arg_67_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_70_4 = arg_67_1.actors_["1284ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect1284ui_story == nil then
				arg_67_1.var_.characterEffect1284ui_story = var_70_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_5 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_5 and not isNil(var_70_4) then
				if arg_67_1.var_.characterEffect1284ui_story and not isNil(var_70_4) then
					arg_67_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_5)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_5 and arg_67_1.time_ < 0 + var_70_5 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect1284ui_story then
				arg_67_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_70_6 = 0
			local var_70_7 = 0.6

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_8 = arg_67_1:GetWordFromCfg(322062016)
				local var_70_9 = arg_67_1:FormatText(var_70_8.content)

				arg_67_1.text_.text = var_70_9

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 24 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_9) / 24)

				if (24 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_9) / 24)) > 0 and var_70_7 < var_70_11 then
					arg_67_1.talkMaxDuration = var_70_11

					if var_70_11 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_11 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_9
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062016", "story_v_out_322062.awb") ~= 0 then
					local var_70_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062016", "story_v_out_322062.awb") / 1000

					if var_70_12 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_12 + var_70_6
					end

					if var_70_8.prefab_name ~= "" and arg_67_1.actors_[var_70_8.prefab_name] ~= nil then
						local var_70_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_8.prefab_name].transform, "story_v_out_322062", "322062016", "story_v_out_322062.awb")

						arg_67_1:RecordAudio("322062016", var_70_13)
						arg_67_1:RecordAudio("322062016", var_70_13)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_322062", "322062016", "story_v_out_322062.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_322062", "322062016", "story_v_out_322062.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_14 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_14 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_14

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_14 and arg_67_1.time_ < var_70_6 + var_70_14 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play322062017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322062017
		arg_71_1.duration_ = 5.43

		local var_71_0 = {
			zh = 5.433,
			ja = 5.133
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
				arg_71_0:Play322062018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos404001ui_story = arg_71_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["404001ui_story"].transform.position).z)
				arg_71_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["404001ui_story"].transform.localEulerAngles = arg_71_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_71_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["404001ui_story"].transform.position).z)
				arg_71_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["404001ui_story"].transform.localEulerAngles = arg_71_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1156ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1156ui_story = var_74_1.localPosition
			end

			local var_74_2 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 then
				var_74_1.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_2)
				var_74_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_1.position).x, (manager.ui.mainCamera.transform.position - var_74_1.position).y, (manager.ui.mainCamera.transform.position - var_74_1.position).z)
				var_74_1.localEulerAngles.z = 0
				var_74_1.localEulerAngles.x = 0
				var_74_1.localEulerAngles = var_74_1.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 then
				var_74_1.localPosition = Vector3.New(0, 100, 0)
				var_74_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_1.position).x, (manager.ui.mainCamera.transform.position - var_74_1.position).y, (manager.ui.mainCamera.transform.position - var_74_1.position).z)
				var_74_1.localEulerAngles.z = 0
				var_74_1.localEulerAngles.x = 0
				var_74_1.localEulerAngles = var_74_1.localEulerAngles
			end

			local var_74_3 = arg_71_1.actors_["1284ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1284ui_story = var_74_3.localPosition
			end

			local var_74_4 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				var_74_3.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_4)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				var_74_3.localPosition = Vector3.New(0, 100, 0)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			local var_74_5 = arg_71_1.actors_["404001ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.characterEffect404001ui_story == nil then
				arg_71_1.var_.characterEffect404001ui_story = var_74_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_6 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_6 and not isNil(var_74_5) then
				if arg_71_1.var_.characterEffect404001ui_story and not isNil(var_74_5) then
					arg_71_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_6 and arg_71_1.time_ < 0 + var_74_6 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.characterEffect404001ui_story then
				arg_71_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_74_8 = arg_71_1.actors_["1156ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_8) and arg_71_1.var_.characterEffect1156ui_story == nil then
				arg_71_1.var_.characterEffect1156ui_story = var_74_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_9 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_9 and not isNil(var_74_8) then
				if arg_71_1.var_.characterEffect1156ui_story and not isNil(var_74_8) then
					arg_71_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_9)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_9 and arg_71_1.time_ < 0 + var_74_9 + arg_74_0 and not isNil(var_74_8) and arg_71_1.var_.characterEffect1156ui_story then
				arg_71_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_74_10 = 0
			local var_74_11 = 0.425

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_12 = arg_71_1:GetWordFromCfg(322062017)
				local var_74_13 = arg_71_1:FormatText(var_74_12.content)

				arg_71_1.text_.text = var_74_13

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_15 = 17 <= 0 and var_74_11 or var_74_11 * (utf8.len(var_74_13) / 17)

				if (17 <= 0 and var_74_11 or var_74_11 * (utf8.len(var_74_13) / 17)) > 0 and var_74_11 < var_74_15 then
					arg_71_1.talkMaxDuration = var_74_15

					if var_74_15 + var_74_10 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_15 + var_74_10
					end
				end

				arg_71_1.text_.text = var_74_13
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062017", "story_v_out_322062.awb") ~= 0 then
					local var_74_16 = manager.audio:GetVoiceLength("story_v_out_322062", "322062017", "story_v_out_322062.awb") / 1000

					if var_74_16 + var_74_10 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_16 + var_74_10
					end

					if var_74_12.prefab_name ~= "" and arg_71_1.actors_[var_74_12.prefab_name] ~= nil then
						local var_74_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_12.prefab_name].transform, "story_v_out_322062", "322062017", "story_v_out_322062.awb")

						arg_71_1:RecordAudio("322062017", var_74_17)
						arg_71_1:RecordAudio("322062017", var_74_17)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_322062", "322062017", "story_v_out_322062.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_322062", "322062017", "story_v_out_322062.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_18 = math.max(var_74_11, arg_71_1.talkMaxDuration)

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_18 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_10) / var_74_18

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_10 + var_74_18 and arg_71_1.time_ < var_74_10 + var_74_18 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play322062018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 322062018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play322062019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if arg_75_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_78_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_75_1.stage_.transform)

				var_78_0.name = "10104ui_story"
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["10104ui_story"] = var_78_0

				local var_78_1 = var_78_0:GetComponentInChildren(typeof(CharacterEffect))

				var_78_1.enabled = true

				local var_78_2 = GameObjectTools.GetOrAddComponent(var_78_0, typeof(DynamicBoneHelper))

				if var_78_2 then
					var_78_2:EnableDynamicBone(false)
				end

				arg_75_1:ShowWeapon(var_78_1.transform, false)

				arg_75_1.var_["10104ui_story" .. "Animator"] = var_78_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_75_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_75_1.var_["10104ui_story" .. "LipSync"] = var_78_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_78_3 = arg_75_1.actors_["10104ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10104ui_story = var_78_3.localPosition
			end

			local var_78_4 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				var_78_3.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_75_1.time_ - 0) / var_78_4)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				var_78_3.localPosition = Vector3.New(0.99, -1.12, -5.99)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			local var_78_5 = arg_75_1.actors_["404001ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos404001ui_story = var_78_5.localPosition
			end

			local var_78_6 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_6 then
				var_78_5.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_75_1.time_ - 0) / var_78_6)
				var_78_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_5.position).x, (manager.ui.mainCamera.transform.position - var_78_5.position).y, (manager.ui.mainCamera.transform.position - var_78_5.position).z)
				var_78_5.localEulerAngles.z = 0
				var_78_5.localEulerAngles.x = 0
				var_78_5.localEulerAngles = var_78_5.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_6 and arg_75_1.time_ < 0 + var_78_6 + arg_78_0 then
				var_78_5.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				var_78_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_5.position).x, (manager.ui.mainCamera.transform.position - var_78_5.position).y, (manager.ui.mainCamera.transform.position - var_78_5.position).z)
				var_78_5.localEulerAngles.z = 0
				var_78_5.localEulerAngles.x = 0
				var_78_5.localEulerAngles = var_78_5.localEulerAngles
			end

			local var_78_7 = arg_75_1.actors_["10104ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.characterEffect10104ui_story == nil then
				arg_75_1.var_.characterEffect10104ui_story = var_78_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_8 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_8 and not isNil(var_78_7) then
				if arg_75_1.var_.characterEffect10104ui_story and not isNil(var_78_7) then
					arg_75_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_8 and arg_75_1.time_ < 0 + var_78_8 + arg_78_0 and not isNil(var_78_7) and arg_75_1.var_.characterEffect10104ui_story then
				arg_75_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_78_10 = arg_75_1.actors_["404001ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_10) and arg_75_1.var_.characterEffect404001ui_story == nil then
				arg_75_1.var_.characterEffect404001ui_story = var_78_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_11 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_11 and not isNil(var_78_10) then
				if arg_75_1.var_.characterEffect404001ui_story and not isNil(var_78_10) then
					arg_75_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_75_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_11)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_11 and arg_75_1.time_ < 0 + var_78_11 + arg_78_0 and not isNil(var_78_10) and arg_75_1.var_.characterEffect404001ui_story then
				arg_75_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_75_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				if arg_75_1.var_.characterEffect10104ui_story == nil then
					arg_75_1.var_.characterEffect10104ui_story = arg_75_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_78_12 = arg_75_1.var_.characterEffect10104ui_story

				arg_75_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_78_12.interferenceEffect.enabled = true
				var_78_12.interferenceEffect.noise = 0.001
				var_78_12.interferenceEffect.simTimeScale = 1
				var_78_12.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				if arg_75_1.var_.characterEffect10104ui_story == nil then
					arg_75_1.var_.characterEffect10104ui_story = arg_75_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_75_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_78_14 = 0
			local var_78_15 = 0.175

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_16 = arg_75_1:GetWordFromCfg(322062018)
				local var_78_17 = arg_75_1:FormatText(var_78_16.content)

				arg_75_1.text_.text = var_78_17

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_19 = 7 <= 0 and var_78_15 or var_78_15 * (utf8.len(var_78_17) / 7)

				if (7 <= 0 and var_78_15 or var_78_15 * (utf8.len(var_78_17) / 7)) > 0 and var_78_15 < var_78_19 then
					arg_75_1.talkMaxDuration = var_78_19

					if var_78_19 + var_78_14 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_19 + var_78_14
					end
				end

				arg_75_1.text_.text = var_78_17
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062018", "story_v_out_322062.awb") ~= 0 then
					local var_78_20 = manager.audio:GetVoiceLength("story_v_out_322062", "322062018", "story_v_out_322062.awb") / 1000

					if var_78_20 + var_78_14 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_20 + var_78_14
					end

					if var_78_16.prefab_name ~= "" and arg_75_1.actors_[var_78_16.prefab_name] ~= nil then
						local var_78_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_16.prefab_name].transform, "story_v_out_322062", "322062018", "story_v_out_322062.awb")

						arg_75_1:RecordAudio("322062018", var_78_21)
						arg_75_1:RecordAudio("322062018", var_78_21)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_322062", "322062018", "story_v_out_322062.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_322062", "322062018", "story_v_out_322062.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_22 = math.max(var_78_15, arg_75_1.talkMaxDuration)

			if var_78_14 <= arg_75_1.time_ and arg_75_1.time_ < var_78_14 + var_78_22 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_14) / var_78_22

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_14 + var_78_22 and arg_75_1.time_ < var_78_14 + var_78_22 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_75_1:InitPlayNodeList()
	end,
	Play322062019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 322062019
		arg_79_1.duration_ = 11.03

		local var_79_0 = {
			zh = 8.633,
			ja = 11.033
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
				arg_79_0:Play322062020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["404001ui_story"]) and arg_79_1.var_.characterEffect404001ui_story == nil then
				arg_79_1.var_.characterEffect404001ui_story = arg_79_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["404001ui_story"]) then
				if arg_79_1.var_.characterEffect404001ui_story and not isNil(arg_79_1.actors_["404001ui_story"]) then
					arg_79_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["404001ui_story"]) and arg_79_1.var_.characterEffect404001ui_story then
				arg_79_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_82_2 = arg_79_1.actors_["10104ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect10104ui_story == nil then
				arg_79_1.var_.characterEffect10104ui_story = var_82_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_3 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.characterEffect10104ui_story and not isNil(var_82_2) then
					arg_79_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_3)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect10104ui_story then
				arg_79_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_82_4 = 0
			local var_82_5 = 1.05

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(322062019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 42 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 42)

				if (42 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 42)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062019", "story_v_out_322062.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_322062", "322062019", "story_v_out_322062.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_322062", "322062019", "story_v_out_322062.awb")

						arg_79_1:RecordAudio("322062019", var_82_11)
						arg_79_1:RecordAudio("322062019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_322062", "322062019", "story_v_out_322062.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_322062", "322062019", "story_v_out_322062.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play322062020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322062020
		arg_83_1.duration_ = 16

		local var_83_0 = {
			zh = 5.8,
			ja = 16
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
				arg_83_0:Play322062021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["10104ui_story"]) and arg_83_1.var_.characterEffect10104ui_story == nil then
				arg_83_1.var_.characterEffect10104ui_story = arg_83_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["10104ui_story"]) then
				if arg_83_1.var_.characterEffect10104ui_story and not isNil(arg_83_1.actors_["10104ui_story"]) then
					arg_83_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["10104ui_story"]) and arg_83_1.var_.characterEffect10104ui_story then
				arg_83_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_86_2 = arg_83_1.actors_["404001ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect404001ui_story == nil then
				arg_83_1.var_.characterEffect404001ui_story = var_86_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_3 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.characterEffect404001ui_story and not isNil(var_86_2) then
					arg_83_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_83_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_3)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect404001ui_story then
				arg_83_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_83_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				if arg_83_1.var_.characterEffect10104ui_story == nil then
					arg_83_1.var_.characterEffect10104ui_story = arg_83_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_86_4 = arg_83_1.var_.characterEffect10104ui_story

				arg_83_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_86_4.interferenceEffect.enabled = true
				var_86_4.interferenceEffect.noise = 0.001
				var_86_4.interferenceEffect.simTimeScale = 1
				var_86_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				if arg_83_1.var_.characterEffect10104ui_story == nil then
					arg_83_1.var_.characterEffect10104ui_story = arg_83_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_83_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_86_6 = 0
			local var_86_7 = 0.725

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_8 = arg_83_1:GetWordFromCfg(322062020)
				local var_86_9 = arg_83_1:FormatText(var_86_8.content)

				arg_83_1.text_.text = var_86_9

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_11 = 29 <= 0 and var_86_7 or var_86_7 * (utf8.len(var_86_9) / 29)

				if (29 <= 0 and var_86_7 or var_86_7 * (utf8.len(var_86_9) / 29)) > 0 and var_86_7 < var_86_11 then
					arg_83_1.talkMaxDuration = var_86_11

					if var_86_11 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_9
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062020", "story_v_out_322062.awb") ~= 0 then
					local var_86_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062020", "story_v_out_322062.awb") / 1000

					if var_86_12 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_12 + var_86_6
					end

					if var_86_8.prefab_name ~= "" and arg_83_1.actors_[var_86_8.prefab_name] ~= nil then
						local var_86_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_8.prefab_name].transform, "story_v_out_322062", "322062020", "story_v_out_322062.awb")

						arg_83_1:RecordAudio("322062020", var_86_13)
						arg_83_1:RecordAudio("322062020", var_86_13)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_322062", "322062020", "story_v_out_322062.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_322062", "322062020", "story_v_out_322062.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_14 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_14 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_14

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_14 and arg_83_1.time_ < var_86_6 + var_86_14 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play322062021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322062021
		arg_87_1.duration_ = 5.47

		local var_87_0 = {
			zh = 4.233,
			ja = 5.466
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
				arg_87_0:Play322062022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["404001ui_story"]) and arg_87_1.var_.characterEffect404001ui_story == nil then
				arg_87_1.var_.characterEffect404001ui_story = arg_87_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["404001ui_story"]) then
				if arg_87_1.var_.characterEffect404001ui_story and not isNil(arg_87_1.actors_["404001ui_story"]) then
					arg_87_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["404001ui_story"]) and arg_87_1.var_.characterEffect404001ui_story then
				arg_87_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_90_2 = arg_87_1.actors_["10104ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.characterEffect10104ui_story == nil then
				arg_87_1.var_.characterEffect10104ui_story = var_90_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_3 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_2) then
				if arg_87_1.var_.characterEffect10104ui_story and not isNil(var_90_2) then
					arg_87_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_3)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.characterEffect10104ui_story then
				arg_87_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_90_4 = 0
			local var_90_5 = 0.425

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(322062021)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 17 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 17)

				if (17 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 17)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062021", "story_v_out_322062.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_322062", "322062021", "story_v_out_322062.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_322062", "322062021", "story_v_out_322062.awb")

						arg_87_1:RecordAudio("322062021", var_90_11)
						arg_87_1:RecordAudio("322062021", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_322062", "322062021", "story_v_out_322062.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_322062", "322062021", "story_v_out_322062.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_12 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_12 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_12

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_12 and arg_87_1.time_ < var_90_4 + var_90_12 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play322062022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 322062022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play322062023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["10104ui_story"]) and arg_91_1.var_.characterEffect10104ui_story == nil then
				arg_91_1.var_.characterEffect10104ui_story = arg_91_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["10104ui_story"]) then
				if arg_91_1.var_.characterEffect10104ui_story and not isNil(arg_91_1.actors_["10104ui_story"]) then
					arg_91_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["10104ui_story"]) and arg_91_1.var_.characterEffect10104ui_story then
				arg_91_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_94_2 = arg_91_1.actors_["404001ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.characterEffect404001ui_story == nil then
				arg_91_1.var_.characterEffect404001ui_story = var_94_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_3 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 and not isNil(var_94_2) then
				if arg_91_1.var_.characterEffect404001ui_story and not isNil(var_94_2) then
					arg_91_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_91_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_3)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.characterEffect404001ui_story then
				arg_91_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_91_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				if arg_91_1.var_.characterEffect10104ui_story == nil then
					arg_91_1.var_.characterEffect10104ui_story = arg_91_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_94_4 = arg_91_1.var_.characterEffect10104ui_story

				arg_91_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_94_4.interferenceEffect.enabled = true
				var_94_4.interferenceEffect.noise = 0.001
				var_94_4.interferenceEffect.simTimeScale = 1
				var_94_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				if arg_91_1.var_.characterEffect10104ui_story == nil then
					arg_91_1.var_.characterEffect10104ui_story = arg_91_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_91_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_94_6 = 0
			local var_94_7 = 0.2

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_8 = arg_91_1:GetWordFromCfg(322062022)
				local var_94_9 = arg_91_1:FormatText(var_94_8.content)

				arg_91_1.text_.text = var_94_9

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_11 = 8 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 8)

				if (8 <= 0 and var_94_7 or var_94_7 * (utf8.len(var_94_9) / 8)) > 0 and var_94_7 < var_94_11 then
					arg_91_1.talkMaxDuration = var_94_11

					if var_94_11 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_11 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_9
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062022", "story_v_out_322062.awb") ~= 0 then
					local var_94_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062022", "story_v_out_322062.awb") / 1000

					if var_94_12 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_6
					end

					if var_94_8.prefab_name ~= "" and arg_91_1.actors_[var_94_8.prefab_name] ~= nil then
						local var_94_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_8.prefab_name].transform, "story_v_out_322062", "322062022", "story_v_out_322062.awb")

						arg_91_1:RecordAudio("322062022", var_94_13)
						arg_91_1:RecordAudio("322062022", var_94_13)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_322062", "322062022", "story_v_out_322062.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_322062", "322062022", "story_v_out_322062.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_14 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_14 and arg_91_1.time_ < var_94_6 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play322062023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 322062023
		arg_95_1.duration_ = 13.07

		local var_95_0 = {
			zh = 9.766,
			ja = 13.066
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
				arg_95_0:Play322062024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				if arg_95_1.var_.characterEffect10104ui_story == nil then
					arg_95_1.var_.characterEffect10104ui_story = arg_95_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_98_0 = arg_95_1.var_.characterEffect10104ui_story

				arg_95_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_98_0.interferenceEffect.enabled = true
				var_98_0.interferenceEffect.noise = 0.001
				var_98_0.interferenceEffect.simTimeScale = 1
				var_98_0.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				if arg_95_1.var_.characterEffect10104ui_story == nil then
					arg_95_1.var_.characterEffect10104ui_story = arg_95_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_95_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_98_2 = 0
			local var_98_3 = 1.1

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_4 = arg_95_1:GetWordFromCfg(322062023)
				local var_98_5 = arg_95_1:FormatText(var_98_4.content)

				arg_95_1.text_.text = var_98_5

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_7 = 44 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_5) / 44)

				if (44 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_5) / 44)) > 0 and var_98_3 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_2
					end
				end

				arg_95_1.text_.text = var_98_5
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062023", "story_v_out_322062.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062023", "story_v_out_322062.awb") / 1000

					if var_98_8 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_2
					end

					if var_98_4.prefab_name ~= "" and arg_95_1.actors_[var_98_4.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_4.prefab_name].transform, "story_v_out_322062", "322062023", "story_v_out_322062.awb")

						arg_95_1:RecordAudio("322062023", var_98_9)
						arg_95_1:RecordAudio("322062023", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_322062", "322062023", "story_v_out_322062.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_322062", "322062023", "story_v_out_322062.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_3, arg_95_1.talkMaxDuration)

			if var_98_2 <= arg_95_1.time_ and arg_95_1.time_ < var_98_2 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_2) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_2 + var_98_10 and arg_95_1.time_ < var_98_2 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play322062024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 322062024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play322062025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10104ui_story = arg_99_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10104ui_story"].transform.position).z)
				arg_99_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10104ui_story"].transform.localEulerAngles = arg_99_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10104ui_story"].transform.position).z)
				arg_99_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10104ui_story"].transform.localEulerAngles = arg_99_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["404001ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos404001ui_story = var_102_1.localPosition
			end

			local var_102_2 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 then
				var_102_1.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_2)
				var_102_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_1.position).x, (manager.ui.mainCamera.transform.position - var_102_1.position).y, (manager.ui.mainCamera.transform.position - var_102_1.position).z)
				var_102_1.localEulerAngles.z = 0
				var_102_1.localEulerAngles.x = 0
				var_102_1.localEulerAngles = var_102_1.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 then
				var_102_1.localPosition = Vector3.New(0, 100, 0)
				var_102_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_1.position).x, (manager.ui.mainCamera.transform.position - var_102_1.position).y, (manager.ui.mainCamera.transform.position - var_102_1.position).z)
				var_102_1.localEulerAngles.z = 0
				var_102_1.localEulerAngles.x = 0
				var_102_1.localEulerAngles = var_102_1.localEulerAngles
			end

			if 0.3 < arg_99_1.time_ and arg_99_1.time_ <= 0.3 + arg_102_0 then
				arg_99_1:AudioAction("play", "effect", "se_story_145", "se_story_145_monster_scream01", "")
			end

			local var_102_4 = 0
			local var_102_5 = 1.5

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(322062024).content)

				arg_99_1.text_.text = var_102_6

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_8 = 60 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_6) / 60)

				if (60 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_6) / 60)) > 0 and var_102_5 < var_102_8 then
					arg_99_1.talkMaxDuration = var_102_8

					if var_102_8 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_6
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_9 = math.max(var_102_5, arg_99_1.talkMaxDuration)

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_9 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_4) / var_102_9

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_4 + var_102_9 and arg_99_1.time_ < var_102_4 + var_102_9 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_99_1:InitPlayNodeList()
	end,
	Play322062025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 322062025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play322062026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 1.15

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(322062025).content)

				arg_103_1.text_.text = var_106_1

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_3 = 46 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 46)

				if (46 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 46)) > 0 and var_106_0 < var_106_3 then
					arg_103_1.talkMaxDuration = var_106_3

					if var_106_3 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_3 + 0
					end
				end

				arg_103_1.text_.text = var_106_1
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_4 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_4

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play322062026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 322062026
		arg_107_1.duration_ = 4.77

		local var_107_0 = {
			zh = 4.766,
			ja = 2.466
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
				arg_107_0:Play322062027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos404001ui_story = arg_107_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["404001ui_story"].transform.position).z)
				arg_107_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["404001ui_story"].transform.localEulerAngles = arg_107_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_107_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["404001ui_story"].transform.position).z)
				arg_107_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["404001ui_story"].transform.localEulerAngles = arg_107_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["404001ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect404001ui_story == nil then
				arg_107_1.var_.characterEffect404001ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect404001ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect404001ui_story then
				arg_107_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_110_4 = 0
			local var_110_5 = 0.55

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(322062026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 22 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 22)

				if (22 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 22)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062026", "story_v_out_322062.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_out_322062", "322062026", "story_v_out_322062.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_out_322062", "322062026", "story_v_out_322062.awb")

						arg_107_1:RecordAudio("322062026", var_110_11)
						arg_107_1:RecordAudio("322062026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_322062", "322062026", "story_v_out_322062.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_322062", "322062026", "story_v_out_322062.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play322062027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 322062027
		arg_111_1.duration_ = 11.33

		local var_111_0 = {
			zh = 6.166,
			ja = 11.333
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
				arg_111_0:Play322062028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10104ui_story = arg_111_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10104ui_story"].transform.position).z)
				arg_111_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["10104ui_story"].transform.localEulerAngles = arg_111_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_111_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10104ui_story"].transform.position).z)
				arg_111_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["10104ui_story"].transform.localEulerAngles = arg_111_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_114_1 = arg_111_1.actors_["10104ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect10104ui_story == nil then
				arg_111_1.var_.characterEffect10104ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect10104ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect10104ui_story then
				arg_111_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_114_4 = arg_111_1.actors_["404001ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_4) and arg_111_1.var_.characterEffect404001ui_story == nil then
				arg_111_1.var_.characterEffect404001ui_story = var_114_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_5 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_5 and not isNil(var_114_4) then
				if arg_111_1.var_.characterEffect404001ui_story and not isNil(var_114_4) then
					arg_111_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_111_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_5)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_5 and arg_111_1.time_ < 0 + var_114_5 + arg_114_0 and not isNil(var_114_4) and arg_111_1.var_.characterEffect404001ui_story then
				arg_111_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_111_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				if arg_111_1.var_.characterEffect10104ui_story == nil then
					arg_111_1.var_.characterEffect10104ui_story = arg_111_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_114_6 = arg_111_1.var_.characterEffect10104ui_story

				arg_111_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_114_6.interferenceEffect.enabled = true
				var_114_6.interferenceEffect.noise = 0.001
				var_114_6.interferenceEffect.simTimeScale = 1
				var_114_6.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				if arg_111_1.var_.characterEffect10104ui_story == nil then
					arg_111_1.var_.characterEffect10104ui_story = arg_111_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_111_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_114_8 = 0
			local var_114_9 = 0.9

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_10 = arg_111_1:GetWordFromCfg(322062027)
				local var_114_11 = arg_111_1:FormatText(var_114_10.content)

				arg_111_1.text_.text = var_114_11

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_13 = 36 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 36)

				if (36 <= 0 and var_114_9 or var_114_9 * (utf8.len(var_114_11) / 36)) > 0 and var_114_9 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_8
					end
				end

				arg_111_1.text_.text = var_114_11
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062027", "story_v_out_322062.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062027", "story_v_out_322062.awb") / 1000

					if var_114_14 + var_114_8 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_8
					end

					if var_114_10.prefab_name ~= "" and arg_111_1.actors_[var_114_10.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_10.prefab_name].transform, "story_v_out_322062", "322062027", "story_v_out_322062.awb")

						arg_111_1:RecordAudio("322062027", var_114_15)
						arg_111_1:RecordAudio("322062027", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_322062", "322062027", "story_v_out_322062.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_322062", "322062027", "story_v_out_322062.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_9, arg_111_1.talkMaxDuration)

			if var_114_8 <= arg_111_1.time_ and arg_111_1.time_ < var_114_8 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_8) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_8 + var_114_16 and arg_111_1.time_ < var_114_8 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play322062028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 322062028
		arg_115_1.duration_ = 15.7

		local var_115_0 = {
			zh = 7.333,
			ja = 15.7
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play322062029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10104ui_story = arg_115_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10104ui_story"].transform.position).z)
				arg_115_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["10104ui_story"].transform.localEulerAngles = arg_115_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_115_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10104ui_story"].transform.position).z)
				arg_115_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["10104ui_story"].transform.localEulerAngles = arg_115_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				if arg_115_1.var_.characterEffect10104ui_story == nil then
					arg_115_1.var_.characterEffect10104ui_story = arg_115_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_118_1 = arg_115_1.var_.characterEffect10104ui_story

				arg_115_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_118_1.interferenceEffect.enabled = true
				var_118_1.interferenceEffect.noise = 0.001
				var_118_1.interferenceEffect.simTimeScale = 1
				var_118_1.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				if arg_115_1.var_.characterEffect10104ui_story == nil then
					arg_115_1.var_.characterEffect10104ui_story = arg_115_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_115_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_118_3 = 0
			local var_118_4 = 0.975

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_3 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_5 = arg_115_1:GetWordFromCfg(322062028)
				local var_118_6 = arg_115_1:FormatText(var_118_5.content)

				arg_115_1.text_.text = var_118_6

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_8 = 39 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_6) / 39)

				if (39 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_6) / 39)) > 0 and var_118_4 < var_118_8 then
					arg_115_1.talkMaxDuration = var_118_8

					if var_118_8 + var_118_3 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_3
					end
				end

				arg_115_1.text_.text = var_118_6
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062028", "story_v_out_322062.awb") ~= 0 then
					local var_118_9 = manager.audio:GetVoiceLength("story_v_out_322062", "322062028", "story_v_out_322062.awb") / 1000

					if var_118_9 + var_118_3 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_3
					end

					if var_118_5.prefab_name ~= "" and arg_115_1.actors_[var_118_5.prefab_name] ~= nil then
						local var_118_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_5.prefab_name].transform, "story_v_out_322062", "322062028", "story_v_out_322062.awb")

						arg_115_1:RecordAudio("322062028", var_118_10)
						arg_115_1:RecordAudio("322062028", var_118_10)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_322062", "322062028", "story_v_out_322062.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_322062", "322062028", "story_v_out_322062.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_11 = math.max(var_118_4, arg_115_1.talkMaxDuration)

			if var_118_3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_3 + var_118_11 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_3) / var_118_11

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_3 + var_118_11 and arg_115_1.time_ < var_118_3 + var_118_11 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play322062029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 322062029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play322062030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_9000

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10104ui_story = arg_119_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10104ui_story"].transform.position).z)
				arg_119_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10104ui_story"].transform.localEulerAngles = arg_119_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10104ui_story"].transform.position).z)
				arg_119_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10104ui_story"].transform.localEulerAngles = arg_119_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["404001ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos404001ui_story = var_122_1.localPosition
			end

			local var_122_2 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 then
				var_122_1.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_2)
				var_122_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_1.position).x, (manager.ui.mainCamera.transform.position - var_122_1.position).y, (manager.ui.mainCamera.transform.position - var_122_1.position).z)
				var_122_1.localEulerAngles.z = 0
				var_122_1.localEulerAngles.x = 0
				var_122_1.localEulerAngles = var_122_1.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 then
				var_122_1.localPosition = Vector3.New(0, 100, 0)
				var_122_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_1.position).x, (manager.ui.mainCamera.transform.position - var_122_1.position).y, (manager.ui.mainCamera.transform.position - var_122_1.position).z)
				var_122_1.localEulerAngles.z = 0
				var_122_1.localEulerAngles.x = 0
				var_122_1.localEulerAngles = var_122_1.localEulerAngles
			end

			if 1.16666666666667 < arg_119_1.time_ and arg_119_1.time_ <= 1.16666666666667 + arg_122_0 then
				arg_119_1:AudioAction("play", "effect", "se_story_145", "se_story_145_plane01", "")
			end

			if 0.166666666666667 < arg_119_1.time_ and arg_119_1.time_ <= 0.166666666666667 + arg_122_0 then
				arg_119_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion05", "")
			end

			if 0.166666666666667 < arg_119_1.time_ and arg_119_1.time_ <= 0.166666666666667 + arg_122_0 then
				local var_122_5 = arg_119_1.var_.effect20209

				if not arg_119_1.var_.effect20209 then
					var_122_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_122_5.name = "20209"
					arg_119_1.var_.effect20209 = var_122_5
				else
					var_122_5.transform:SetParent(var_122_9000)
				end

				var_122_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_122_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.15 < arg_119_1.time_ and arg_119_1.time_ <= 2.15 + arg_122_0 then
				if arg_119_1.var_.effect20209 then
					Object.Destroy(arg_119_1.var_.effect20209)

					arg_119_1.var_.effect20209 = nil
				end
			end

			local var_122_8 = manager.ui.mainCamera.transform

			if 0.166666666666667 < arg_119_1.time_ and arg_119_1.time_ <= 0.166666666666667 + arg_122_0 then
				arg_119_1.var_.shakeOldPos = var_122_8.localPosition
			end

			local var_122_9 = 0.233333333333333

			if 0.166666666666667 <= arg_119_1.time_ and arg_119_1.time_ < 0.166666666666667 + var_122_9 then
				local var_122_10, var_122_11 = math.modf((arg_119_1.time_ - 0.166666666666667) / 0.066)

				var_122_8.localPosition = Vector3.New(var_122_11 * 0.13, var_122_11 * 0.13, var_122_11 * 0.13) + arg_119_1.var_.shakeOldPos
			end

			if arg_119_1.time_ >= 0.166666666666667 + var_122_9 and arg_119_1.time_ < 0.166666666666667 + var_122_9 + arg_122_0 then
				var_122_8.localPosition = arg_119_1.var_.shakeOldPos
			end

			local var_122_12 = 0
			local var_122_13 = 1.4

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_14 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(322062029).content)

				arg_119_1.text_.text = var_122_14

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_16 = 56 <= 0 and var_122_13 or var_122_13 * (utf8.len(var_122_14) / 56)

				if (56 <= 0 and var_122_13 or var_122_13 * (utf8.len(var_122_14) / 56)) > 0 and var_122_13 < var_122_16 then
					arg_119_1.talkMaxDuration = var_122_16

					if var_122_16 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_16 + var_122_12
					end
				end

				arg_119_1.text_.text = var_122_14
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_17 = math.max(var_122_13, arg_119_1.talkMaxDuration)

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_17 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_12) / var_122_17

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_12 + var_122_17 and arg_119_1.time_ < var_122_12 + var_122_17 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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

		arg_119_1:InitPlayNodeList()
	end,
	Play322062030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 322062030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play322062031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 1.475

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(322062030).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 59 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 59)

				if (59 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 59)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play322062031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322062031
		arg_127_1.duration_ = 2

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play322062032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1211ui_story = arg_127_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1211ui_story"].transform.position).z)
				arg_127_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1211ui_story"].transform.localEulerAngles = arg_127_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_127_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1211ui_story"].transform.position).z)
				arg_127_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1211ui_story"].transform.localEulerAngles = arg_127_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1211ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1211ui_story == nil then
				arg_127_1.var_.characterEffect1211ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1211ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1211ui_story then
				arg_127_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action9_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_130_4 = 0
			local var_130_5 = 0.125

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(322062031)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 5 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 5)

				if (5 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 5)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062031", "story_v_out_322062.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_322062", "322062031", "story_v_out_322062.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_322062", "322062031", "story_v_out_322062.awb")

						arg_127_1:RecordAudio("322062031", var_130_11)
						arg_127_1:RecordAudio("322062031", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_322062", "322062031", "story_v_out_322062.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_322062", "322062031", "story_v_out_322062.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play322062032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 322062032
		arg_131_1.duration_ = 2.53

		local var_131_0 = {
			zh = 1.766,
			ja = 2.533
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
				arg_131_0:Play322062033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos404001ui_story = arg_131_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["404001ui_story"].transform.position).z)
				arg_131_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["404001ui_story"].transform.localEulerAngles = arg_131_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_131_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["404001ui_story"].transform.position).z)
				arg_131_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["404001ui_story"].transform.localEulerAngles = arg_131_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["404001ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect404001ui_story == nil then
				arg_131_1.var_.characterEffect404001ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect404001ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect404001ui_story then
				arg_131_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_134_4 = arg_131_1.actors_["1211ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1211ui_story == nil then
				arg_131_1.var_.characterEffect1211ui_story = var_134_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_5 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_5 and not isNil(var_134_4) then
				if arg_131_1.var_.characterEffect1211ui_story and not isNil(var_134_4) then
					arg_131_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_5)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_5 and arg_131_1.time_ < 0 + var_134_5 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1211ui_story then
				arg_131_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_134_6 = 0
			local var_134_7 = 0.2

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(322062032)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 8 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 8)

				if (8 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 8)) > 0 and var_134_7 < var_134_11 then
					arg_131_1.talkMaxDuration = var_134_11

					if var_134_11 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062032", "story_v_out_322062.awb") ~= 0 then
					local var_134_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062032", "story_v_out_322062.awb") / 1000

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end

					if var_134_8.prefab_name ~= "" and arg_131_1.actors_[var_134_8.prefab_name] ~= nil then
						local var_134_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_8.prefab_name].transform, "story_v_out_322062", "322062032", "story_v_out_322062.awb")

						arg_131_1:RecordAudio("322062032", var_134_13)
						arg_131_1:RecordAudio("322062032", var_134_13)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_322062", "322062032", "story_v_out_322062.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_322062", "322062032", "story_v_out_322062.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_14 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_14 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_14

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_14 and arg_131_1.time_ < var_134_6 + var_134_14 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play322062033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322062033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play322062034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1211ui_story = arg_135_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1211ui_story"].transform.position).z)
				arg_135_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1211ui_story"].transform.localEulerAngles = arg_135_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1211ui_story"].transform.position).z)
				arg_135_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1211ui_story"].transform.localEulerAngles = arg_135_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["404001ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos404001ui_story = var_138_1.localPosition
			end

			local var_138_2 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 then
				var_138_1.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_2)
				var_138_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_1.position).x, (manager.ui.mainCamera.transform.position - var_138_1.position).y, (manager.ui.mainCamera.transform.position - var_138_1.position).z)
				var_138_1.localEulerAngles.z = 0
				var_138_1.localEulerAngles.x = 0
				var_138_1.localEulerAngles = var_138_1.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 then
				var_138_1.localPosition = Vector3.New(0, 100, 0)
				var_138_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_1.position).x, (manager.ui.mainCamera.transform.position - var_138_1.position).y, (manager.ui.mainCamera.transform.position - var_138_1.position).z)
				var_138_1.localEulerAngles.z = 0
				var_138_1.localEulerAngles.x = 0
				var_138_1.localEulerAngles = var_138_1.localEulerAngles
			end

			local var_138_3 = 0
			local var_138_4 = 1.5

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_3 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_5 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(322062033).content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 60 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_5) / 60)

				if (60 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_5) / 60)) > 0 and var_138_4 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_3 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_3
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_8 = math.max(var_138_4, arg_135_1.talkMaxDuration)

			if var_138_3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_3 + var_138_8 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_3) / var_138_8

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_3 + var_138_8 and arg_135_1.time_ < var_138_3 + var_138_8 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play322062034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 322062034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play322062035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0.1 < arg_139_1.time_ and arg_139_1.time_ <= 0.1 + arg_142_0 then
				arg_139_1:AudioAction("play", "effect", "se_story_145", "se_story_145_star_movement_wobble02", "")
			end

			local var_142_1 = 0
			local var_142_2 = 1.25

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(322062034).content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 50 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 50)

				if (50 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_3) / 50)) > 0 and var_142_2 < var_142_5 then
					arg_139_1.talkMaxDuration = var_142_5

					if var_142_5 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_6 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_6 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_6

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_6 and arg_139_1.time_ < var_142_1 + var_142_6 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play322062035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 322062035
		arg_143_1.duration_ = 2.3

		local var_143_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_143_0:Play322062036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos404001ui_story = arg_143_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["404001ui_story"].transform.position).z)
				arg_143_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["404001ui_story"].transform.localEulerAngles = arg_143_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_143_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["404001ui_story"].transform.position).z)
				arg_143_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["404001ui_story"].transform.localEulerAngles = arg_143_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["404001ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect404001ui_story == nil then
				arg_143_1.var_.characterEffect404001ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect404001ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect404001ui_story then
				arg_143_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva", "EmotionTimelineAnimator")
			end

			local var_146_4 = 0
			local var_146_5 = 0.175

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(322062035)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 7 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 7)

				if (7 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 7)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062035", "story_v_out_322062.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_322062", "322062035", "story_v_out_322062.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_322062", "322062035", "story_v_out_322062.awb")

						arg_143_1:RecordAudio("322062035", var_146_11)
						arg_143_1:RecordAudio("322062035", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_322062", "322062035", "story_v_out_322062.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_322062", "322062035", "story_v_out_322062.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play322062036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 322062036
		arg_147_1.duration_ = 3.6

		local var_147_0 = {
			zh = 2.266,
			ja = 3.6
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
				arg_147_0:Play322062037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1284ui_story = arg_147_1.actors_["1284ui_story"].transform.localPosition

				arg_147_1:ShowWeapon(arg_147_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1284ui_story"].transform.position).z)
				arg_147_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1284ui_story"].transform.localEulerAngles = arg_147_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_147_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1284ui_story"].transform.position).z)
				arg_147_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1284ui_story"].transform.localEulerAngles = arg_147_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1284ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1284ui_story == nil then
				arg_147_1.var_.characterEffect1284ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1284ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1284ui_story then
				arg_147_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_150_4 = arg_147_1.actors_["404001ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.characterEffect404001ui_story == nil then
				arg_147_1.var_.characterEffect404001ui_story = var_150_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_5 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_5 and not isNil(var_150_4) then
				if arg_147_1.var_.characterEffect404001ui_story and not isNil(var_150_4) then
					arg_147_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_147_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_5)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_5 and arg_147_1.time_ < 0 + var_150_5 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.characterEffect404001ui_story then
				arg_147_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_147_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_150_6 = 0
			local var_150_7 = 0.25

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_8 = arg_147_1:GetWordFromCfg(322062036)
				local var_150_9 = arg_147_1:FormatText(var_150_8.content)

				arg_147_1.text_.text = var_150_9

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 10 <= 0 and var_150_7 or var_150_7 * (utf8.len(var_150_9) / 10)

				if (10 <= 0 and var_150_7 or var_150_7 * (utf8.len(var_150_9) / 10)) > 0 and var_150_7 < var_150_11 then
					arg_147_1.talkMaxDuration = var_150_11

					if var_150_11 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_9
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062036", "story_v_out_322062.awb") ~= 0 then
					local var_150_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062036", "story_v_out_322062.awb") / 1000

					if var_150_12 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_6
					end

					if var_150_8.prefab_name ~= "" and arg_147_1.actors_[var_150_8.prefab_name] ~= nil then
						local var_150_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_8.prefab_name].transform, "story_v_out_322062", "322062036", "story_v_out_322062.awb")

						arg_147_1:RecordAudio("322062036", var_150_13)
						arg_147_1:RecordAudio("322062036", var_150_13)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_322062", "322062036", "story_v_out_322062.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_322062", "322062036", "story_v_out_322062.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_14 and arg_147_1.time_ < var_150_6 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322062037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 322062037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play322062038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos404001ui_story = arg_151_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["404001ui_story"].transform.position).z)
				arg_151_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["404001ui_story"].transform.localEulerAngles = arg_151_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["404001ui_story"].transform.position).z)
				arg_151_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["404001ui_story"].transform.localEulerAngles = arg_151_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1284ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1284ui_story = var_154_1.localPosition
			end

			local var_154_2 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 then
				var_154_1.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_2)
				var_154_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_1.position).x, (manager.ui.mainCamera.transform.position - var_154_1.position).y, (manager.ui.mainCamera.transform.position - var_154_1.position).z)
				var_154_1.localEulerAngles.z = 0
				var_154_1.localEulerAngles.x = 0
				var_154_1.localEulerAngles = var_154_1.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 then
				var_154_1.localPosition = Vector3.New(0, 100, 0)
				var_154_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_1.position).x, (manager.ui.mainCamera.transform.position - var_154_1.position).y, (manager.ui.mainCamera.transform.position - var_154_1.position).z)
				var_154_1.localEulerAngles.z = 0
				var_154_1.localEulerAngles.x = 0
				var_154_1.localEulerAngles = var_154_1.localEulerAngles
			end

			local var_154_3 = arg_151_1.actors_["1284ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_3) and arg_151_1.var_.characterEffect1284ui_story == nil then
				arg_151_1.var_.characterEffect1284ui_story = var_154_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_4 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 and not isNil(var_154_3) then
				if arg_151_1.var_.characterEffect1284ui_story and not isNil(var_154_3) then
					arg_151_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_4)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 and not isNil(var_154_3) and arg_151_1.var_.characterEffect1284ui_story then
				arg_151_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_151_1.time_ and arg_151_1.time_ <= 0.034000001847744 + arg_154_0 then
				arg_151_1:AudioAction("play", "effect", "se_story_145", "se_story_145_star_movement_wobble01", "")
			end

			local var_154_6 = 0
			local var_154_7 = 0.975

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_8 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(322062037).content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 39 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_8) / 39)

				if (39 <= 0 and var_154_7 or var_154_7 * (utf8.len(var_154_8) / 39)) > 0 and var_154_7 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10

					if var_154_10 + var_154_6 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_6
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_11 = math.max(var_154_7, arg_151_1.talkMaxDuration)

			if var_154_6 <= arg_151_1.time_ and arg_151_1.time_ < var_154_6 + var_154_11 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_6) / var_154_11

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_6 + var_154_11 and arg_151_1.time_ < var_154_6 + var_154_11 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322062038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 322062038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play322062039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_145", "se_story_145_laser", "")
			end

			local var_158_1 = 0
			local var_158_2 = 1.625

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(322062038).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 65 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 65)

				if (65 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 65)) > 0 and var_158_2 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_6 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_6 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_6

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_6 and arg_155_1.time_ < var_158_1 + var_158_6 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play322062039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 322062039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play322062040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0.1 < arg_159_1.time_ and arg_159_1.time_ <= 0.1 + arg_162_0 then
				arg_159_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_energy03", "")
			end

			local var_162_1 = 0
			local var_162_2 = 1.475

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(322062039).content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 59 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 59)

				if (59 <= 0 and var_162_2 or var_162_2 * (utf8.len(var_162_3) / 59)) > 0 and var_162_2 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_1 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_1
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_6 = math.max(var_162_2, arg_159_1.talkMaxDuration)

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_6 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_1) / var_162_6

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_1 + var_162_6 and arg_159_1.time_ < var_162_1 + var_162_6 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play322062040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 322062040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play322062041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_9000

			if 0.3 < arg_163_1.time_ and arg_163_1.time_ <= 0.3 + arg_166_0 then
				arg_163_1:AudioAction("play", "effect", "se_story_129", "se_story_129_alarm", "")
			end

			if 0.3 < arg_163_1.time_ and arg_163_1.time_ <= 0.3 + arg_166_0 then
				local var_166_1 = arg_163_1.var_.effect2040

				if not arg_163_1.var_.effect2040 then
					var_166_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), manager.ui.mainCamera.transform)
					var_166_1.name = "2040"
					arg_163_1.var_.effect2040 = var_166_1
				else
					var_166_1.transform:SetParent(var_166_9000)
				end

				var_166_1.transform.localPosition = Vector3.New(0, 0, -2)
				var_166_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_166_1.transform.localScale = Vector3.New(var_166_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_166_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_166_1.transform.localScale.z)
			end

			local var_166_3 = 0
			local var_166_4 = 1.525

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_3 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_5 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(322062040).content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 61 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_5) / 61)

				if (61 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_5) / 61)) > 0 and var_166_4 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_3 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_3
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_8 = math.max(var_166_4, arg_163_1.talkMaxDuration)

			if var_166_3 <= arg_163_1.time_ and arg_163_1.time_ < var_166_3 + var_166_8 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_3) / var_166_8

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_3 + var_166_8 and arg_163_1.time_ < var_166_3 + var_166_8 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play322062041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 322062041
		arg_167_1.duration_ = 4.2

		local var_167_0 = {
			zh = 3.5,
			ja = 4.2
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play322062042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1211ui_story = arg_167_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1211ui_story"].transform.position).z)
				arg_167_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1211ui_story"].transform.localEulerAngles = arg_167_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_167_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1211ui_story"].transform.position).z)
				arg_167_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1211ui_story"].transform.localEulerAngles = arg_167_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1211ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1211ui_story == nil then
				arg_167_1.var_.characterEffect1211ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1211ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1211ui_story then
				arg_167_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				if arg_167_1.var_.effect2040 then
					Object.Destroy(arg_167_1.var_.effect2040)

					arg_167_1.var_.effect2040 = nil
				end
			end

			local var_170_5 = 0
			local var_170_6 = 0.35

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:GetWordFromCfg(322062041)
				local var_170_8 = arg_167_1:FormatText(var_170_7.content)

				arg_167_1.text_.text = var_170_8

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_10 = 14 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 14)

				if (14 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 14)) > 0 and var_170_6 < var_170_10 then
					arg_167_1.talkMaxDuration = var_170_10

					if var_170_10 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_5
					end
				end

				arg_167_1.text_.text = var_170_8
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062041", "story_v_out_322062.awb") ~= 0 then
					local var_170_11 = manager.audio:GetVoiceLength("story_v_out_322062", "322062041", "story_v_out_322062.awb") / 1000

					if var_170_11 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_5
					end

					if var_170_7.prefab_name ~= "" and arg_167_1.actors_[var_170_7.prefab_name] ~= nil then
						local var_170_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_7.prefab_name].transform, "story_v_out_322062", "322062041", "story_v_out_322062.awb")

						arg_167_1:RecordAudio("322062041", var_170_12)
						arg_167_1:RecordAudio("322062041", var_170_12)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_322062", "322062041", "story_v_out_322062.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_322062", "322062041", "story_v_out_322062.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_13 = math.max(var_170_6, arg_167_1.talkMaxDuration)

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_13 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_5) / var_170_13

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_5 + var_170_13 and arg_167_1.time_ < var_170_5 + var_170_13 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play322062042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 322062042
		arg_171_1.duration_ = 10.47

		local var_171_0 = {
			zh = 4.999999999999,
			ja = 10.466
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play322062043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10104ui_story = arg_171_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10104ui_story"].transform.position).z)
				arg_171_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10104ui_story"].transform.localEulerAngles = arg_171_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_171_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10104ui_story"].transform.position).z)
				arg_171_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10104ui_story"].transform.localEulerAngles = arg_171_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["10104ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10104ui_story == nil then
				arg_171_1.var_.characterEffect10104ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect10104ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10104ui_story then
				arg_171_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_174_4 = arg_171_1.actors_["1211ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect1211ui_story == nil then
				arg_171_1.var_.characterEffect1211ui_story = var_174_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_5 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_5 and not isNil(var_174_4) then
				if arg_171_1.var_.characterEffect1211ui_story and not isNil(var_174_4) then
					arg_171_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_5)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_5 and arg_171_1.time_ < 0 + var_174_5 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect1211ui_story then
				arg_171_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				if arg_171_1.var_.characterEffect10104ui_story == nil then
					arg_171_1.var_.characterEffect10104ui_story = arg_171_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_174_6 = arg_171_1.var_.characterEffect10104ui_story

				arg_171_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_174_6.interferenceEffect.enabled = true
				var_174_6.interferenceEffect.noise = 0.001
				var_174_6.interferenceEffect.simTimeScale = 1
				var_174_6.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				if arg_171_1.var_.characterEffect10104ui_story == nil then
					arg_171_1.var_.characterEffect10104ui_story = arg_171_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_171_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_174_8 = 0
			local var_174_9 = 0.55

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(322062042)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 22 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 22)

				if (22 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 22)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062042", "story_v_out_322062.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062042", "story_v_out_322062.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_322062", "322062042", "story_v_out_322062.awb")

						arg_171_1:RecordAudio("322062042", var_174_15)
						arg_171_1:RecordAudio("322062042", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_322062", "322062042", "story_v_out_322062.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_322062", "322062042", "story_v_out_322062.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_16 and arg_171_1.time_ < var_174_8 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play322062043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 322062043
		arg_175_1.duration_ = 5.6

		local var_175_0 = {
			zh = 4.166,
			ja = 5.6
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play322062044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos404001ui_story = arg_175_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).z)
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles = arg_175_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_175_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["404001ui_story"].transform.position).z)
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["404001ui_story"].transform.localEulerAngles = arg_175_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1211ui_story"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1211ui_story = var_178_1.localPosition
			end

			local var_178_2 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 then
				var_178_1.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_2)
				var_178_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_1.position).x, (manager.ui.mainCamera.transform.position - var_178_1.position).y, (manager.ui.mainCamera.transform.position - var_178_1.position).z)
				var_178_1.localEulerAngles.z = 0
				var_178_1.localEulerAngles.x = 0
				var_178_1.localEulerAngles = var_178_1.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 then
				var_178_1.localPosition = Vector3.New(0, 100, 0)
				var_178_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_1.position).x, (manager.ui.mainCamera.transform.position - var_178_1.position).y, (manager.ui.mainCamera.transform.position - var_178_1.position).z)
				var_178_1.localEulerAngles.z = 0
				var_178_1.localEulerAngles.x = 0
				var_178_1.localEulerAngles = var_178_1.localEulerAngles
			end

			local var_178_3 = arg_175_1.actors_["404001ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_3) and arg_175_1.var_.characterEffect404001ui_story == nil then
				arg_175_1.var_.characterEffect404001ui_story = var_178_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_4 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 and not isNil(var_178_3) then
				if arg_175_1.var_.characterEffect404001ui_story and not isNil(var_178_3) then
					arg_175_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 and not isNil(var_178_3) and arg_175_1.var_.characterEffect404001ui_story then
				arg_175_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_178_6 = arg_175_1.actors_["10104ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_6) and arg_175_1.var_.characterEffect10104ui_story == nil then
				arg_175_1.var_.characterEffect10104ui_story = var_178_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_7 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 and not isNil(var_178_6) then
				if arg_175_1.var_.characterEffect10104ui_story and not isNil(var_178_6) then
					arg_175_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_7)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 and not isNil(var_178_6) and arg_175_1.var_.characterEffect10104ui_story then
				arg_175_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_178_8 = 0
			local var_178_9 = 0.475

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:GetWordFromCfg(322062043)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 19 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 19)

				if (19 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 19)) > 0 and var_178_9 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062043", "story_v_out_322062.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062043", "story_v_out_322062.awb") / 1000

					if var_178_14 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_8
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_out_322062", "322062043", "story_v_out_322062.awb")

						arg_175_1:RecordAudio("322062043", var_178_15)
						arg_175_1:RecordAudio("322062043", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_322062", "322062043", "story_v_out_322062.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_322062", "322062043", "story_v_out_322062.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_9, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_8) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_16 and arg_175_1.time_ < var_178_8 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_175_1:InitPlayNodeList()
	end,
	Play322062044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 322062044
		arg_179_1.duration_ = 9.7

		local var_179_0 = {
			zh = 4.999999999999,
			ja = 9.7
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play322062045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10104ui_story = arg_179_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10104ui_story"].transform.position).z)
				arg_179_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10104ui_story"].transform.localEulerAngles = arg_179_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_179_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["10104ui_story"].transform.position).z)
				arg_179_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["10104ui_story"].transform.localEulerAngles = arg_179_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["10104ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect10104ui_story == nil then
				arg_179_1.var_.characterEffect10104ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect10104ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect10104ui_story then
				arg_179_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_182_4 = arg_179_1.actors_["404001ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect404001ui_story == nil then
				arg_179_1.var_.characterEffect404001ui_story = var_182_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_5 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_5 and not isNil(var_182_4) then
				if arg_179_1.var_.characterEffect404001ui_story and not isNil(var_182_4) then
					arg_179_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_179_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_5)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_5 and arg_179_1.time_ < 0 + var_182_5 + arg_182_0 and not isNil(var_182_4) and arg_179_1.var_.characterEffect404001ui_story then
				arg_179_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_179_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				if arg_179_1.var_.characterEffect10104ui_story == nil then
					arg_179_1.var_.characterEffect10104ui_story = arg_179_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_182_6 = arg_179_1.var_.characterEffect10104ui_story

				arg_179_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_182_6.interferenceEffect.enabled = true
				var_182_6.interferenceEffect.noise = 0.001
				var_182_6.interferenceEffect.simTimeScale = 1
				var_182_6.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				if arg_179_1.var_.characterEffect10104ui_story == nil then
					arg_179_1.var_.characterEffect10104ui_story = arg_179_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_179_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_182_8 = 0
			local var_182_9 = 0.6

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(322062044)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 24 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 24)

				if (24 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 24)) > 0 and var_182_9 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062044", "story_v_out_322062.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062044", "story_v_out_322062.awb") / 1000

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end

					if var_182_10.prefab_name ~= "" and arg_179_1.actors_[var_182_10.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_10.prefab_name].transform, "story_v_out_322062", "322062044", "story_v_out_322062.awb")

						arg_179_1:RecordAudio("322062044", var_182_15)
						arg_179_1:RecordAudio("322062044", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_322062", "322062044", "story_v_out_322062.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_322062", "322062044", "story_v_out_322062.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_16 = math.max(var_182_9, arg_179_1.talkMaxDuration)

			if var_182_8 <= arg_179_1.time_ and arg_179_1.time_ < var_182_8 + var_182_16 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_8) / var_182_16

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_8 + var_182_16 and arg_179_1.time_ < var_182_8 + var_182_16 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play322062045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 322062045
		arg_183_1.duration_ = 14.33

		local var_183_0 = {
			zh = 8.133,
			ja = 14.333
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play322062046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10104ui_story = arg_183_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).z)
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles = arg_183_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_183_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).z)
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles = arg_183_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				if arg_183_1.var_.characterEffect10104ui_story == nil then
					arg_183_1.var_.characterEffect10104ui_story = arg_183_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_186_1 = arg_183_1.var_.characterEffect10104ui_story

				arg_183_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_186_1.interferenceEffect.enabled = true
				var_186_1.interferenceEffect.noise = 0.001
				var_186_1.interferenceEffect.simTimeScale = 1
				var_186_1.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				if arg_183_1.var_.characterEffect10104ui_story == nil then
					arg_183_1.var_.characterEffect10104ui_story = arg_183_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_183_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_186_3 = 0
			local var_186_4 = 0.95

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_5 = arg_183_1:GetWordFromCfg(322062045)
				local var_186_6 = arg_183_1:FormatText(var_186_5.content)

				arg_183_1.text_.text = var_186_6

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_8 = 38 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_6) / 38)

				if (38 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_6) / 38)) > 0 and var_186_4 < var_186_8 then
					arg_183_1.talkMaxDuration = var_186_8

					if var_186_8 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_3
					end
				end

				arg_183_1.text_.text = var_186_6
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062045", "story_v_out_322062.awb") ~= 0 then
					local var_186_9 = manager.audio:GetVoiceLength("story_v_out_322062", "322062045", "story_v_out_322062.awb") / 1000

					if var_186_9 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_3
					end

					if var_186_5.prefab_name ~= "" and arg_183_1.actors_[var_186_5.prefab_name] ~= nil then
						local var_186_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_5.prefab_name].transform, "story_v_out_322062", "322062045", "story_v_out_322062.awb")

						arg_183_1:RecordAudio("322062045", var_186_10)
						arg_183_1:RecordAudio("322062045", var_186_10)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_322062", "322062045", "story_v_out_322062.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_322062", "322062045", "story_v_out_322062.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_11 = math.max(var_186_4, arg_183_1.talkMaxDuration)

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_11 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_3) / var_186_11

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_3 + var_186_11 and arg_183_1.time_ < var_186_3 + var_186_11 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play322062046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 322062046
		arg_187_1.duration_ = 3.8

		local var_187_0 = {
			zh = 2.666,
			ja = 3.8
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play322062047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos404001ui_story = arg_187_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["404001ui_story"].transform.position).z)
				arg_187_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["404001ui_story"].transform.localEulerAngles = arg_187_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_187_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["404001ui_story"].transform.position).z)
				arg_187_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["404001ui_story"].transform.localEulerAngles = arg_187_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["404001ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect404001ui_story == nil then
				arg_187_1.var_.characterEffect404001ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect404001ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect404001ui_story then
				arg_187_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_190_4 = arg_187_1.actors_["10104ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_4) and arg_187_1.var_.characterEffect10104ui_story == nil then
				arg_187_1.var_.characterEffect10104ui_story = var_190_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_5 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_5 and not isNil(var_190_4) then
				if arg_187_1.var_.characterEffect10104ui_story and not isNil(var_190_4) then
					arg_187_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_5)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_5 and arg_187_1.time_ < 0 + var_190_5 + arg_190_0 and not isNil(var_190_4) and arg_187_1.var_.characterEffect10104ui_story then
				arg_187_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_190_6 = 0
			local var_190_7 = 0.35

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_8 = arg_187_1:GetWordFromCfg(322062046)
				local var_190_9 = arg_187_1:FormatText(var_190_8.content)

				arg_187_1.text_.text = var_190_9

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 14 <= 0 and var_190_7 or var_190_7 * (utf8.len(var_190_9) / 14)

				if (14 <= 0 and var_190_7 or var_190_7 * (utf8.len(var_190_9) / 14)) > 0 and var_190_7 < var_190_11 then
					arg_187_1.talkMaxDuration = var_190_11

					if var_190_11 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_11 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_9
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062046", "story_v_out_322062.awb") ~= 0 then
					local var_190_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062046", "story_v_out_322062.awb") / 1000

					if var_190_12 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_12 + var_190_6
					end

					if var_190_8.prefab_name ~= "" and arg_187_1.actors_[var_190_8.prefab_name] ~= nil then
						local var_190_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_8.prefab_name].transform, "story_v_out_322062", "322062046", "story_v_out_322062.awb")

						arg_187_1:RecordAudio("322062046", var_190_13)
						arg_187_1:RecordAudio("322062046", var_190_13)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_322062", "322062046", "story_v_out_322062.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_322062", "322062046", "story_v_out_322062.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_14 and arg_187_1.time_ < var_190_6 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play322062047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 322062047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play322062048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos404001ui_story = arg_191_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["404001ui_story"].transform.position).z)
				arg_191_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["404001ui_story"].transform.localEulerAngles = arg_191_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["404001ui_story"].transform.position).z)
				arg_191_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["404001ui_story"].transform.localEulerAngles = arg_191_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["10104ui_story"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10104ui_story = var_194_1.localPosition
			end

			local var_194_2 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 then
				var_194_1.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_2)
				var_194_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_1.position).x, (manager.ui.mainCamera.transform.position - var_194_1.position).y, (manager.ui.mainCamera.transform.position - var_194_1.position).z)
				var_194_1.localEulerAngles.z = 0
				var_194_1.localEulerAngles.x = 0
				var_194_1.localEulerAngles = var_194_1.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 then
				var_194_1.localPosition = Vector3.New(0, 100, 0)
				var_194_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_1.position).x, (manager.ui.mainCamera.transform.position - var_194_1.position).y, (manager.ui.mainCamera.transform.position - var_194_1.position).z)
				var_194_1.localEulerAngles.z = 0
				var_194_1.localEulerAngles.x = 0
				var_194_1.localEulerAngles = var_194_1.localEulerAngles
			end

			local var_194_3 = arg_191_1.actors_["404001ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect404001ui_story == nil then
				arg_191_1.var_.characterEffect404001ui_story = var_194_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_4 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 and not isNil(var_194_3) then
				if arg_191_1.var_.characterEffect404001ui_story and not isNil(var_194_3) then
					arg_191_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_191_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_4)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect404001ui_story then
				arg_191_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_191_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:AudioAction("play", "effect", "se_story_145", "se_story_145_star_movement_wobble01", "")
			end

			if 2.1 < arg_191_1.time_ and arg_191_1.time_ <= 2.1 + arg_194_0 then
				arg_191_1:AudioAction("play", "effect", "se_story_145", "se_story_145_star_light", "")
			end

			local var_194_7 = 0
			local var_194_8 = 1.5

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_7 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_9 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(322062047).content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 60 <= 0 and var_194_8 or var_194_8 * (utf8.len(var_194_9) / 60)

				if (60 <= 0 and var_194_8 or var_194_8 * (utf8.len(var_194_9) / 60)) > 0 and var_194_8 < var_194_11 then
					arg_191_1.talkMaxDuration = var_194_11

					if var_194_11 + var_194_7 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_7
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_8, arg_191_1.talkMaxDuration)

			if var_194_7 <= arg_191_1.time_ and arg_191_1.time_ < var_194_7 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_7) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_7 + var_194_12 and arg_191_1.time_ < var_194_7 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play322062048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 322062048
		arg_195_1.duration_ = 2.8

		local var_195_0 = {
			zh = 2.8,
			ja = 1.999999999999
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play322062049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1284ui_story = arg_195_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1284ui_story"].transform.position).z)
				arg_195_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1284ui_story"].transform.localEulerAngles = arg_195_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_195_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1284ui_story"].transform.position).z)
				arg_195_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1284ui_story"].transform.localEulerAngles = arg_195_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["1284ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1284ui_story == nil then
				arg_195_1.var_.characterEffect1284ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect1284ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1284ui_story then
				arg_195_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_198_4 = 0
			local var_198_5 = 0.175

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(322062048)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 7 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 7)

				if (7 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 7)) > 0 and var_198_5 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062048", "story_v_out_322062.awb") ~= 0 then
					local var_198_10 = manager.audio:GetVoiceLength("story_v_out_322062", "322062048", "story_v_out_322062.awb") / 1000

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end

					if var_198_6.prefab_name ~= "" and arg_195_1.actors_[var_198_6.prefab_name] ~= nil then
						local var_198_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_6.prefab_name].transform, "story_v_out_322062", "322062048", "story_v_out_322062.awb")

						arg_195_1:RecordAudio("322062048", var_198_11)
						arg_195_1:RecordAudio("322062048", var_198_11)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_322062", "322062048", "story_v_out_322062.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_322062", "322062048", "story_v_out_322062.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_12 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_12 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_12

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_12 and arg_195_1.time_ < var_198_4 + var_198_12 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322062049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 322062049
		arg_199_1.duration_ = 3.37

		local var_199_0 = {
			zh = 3.3,
			ja = 3.366
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play322062050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos404001ui_story = arg_199_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["404001ui_story"].transform.position).z)
				arg_199_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["404001ui_story"].transform.localEulerAngles = arg_199_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_199_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["404001ui_story"].transform.position).z)
				arg_199_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["404001ui_story"].transform.localEulerAngles = arg_199_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["404001ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect404001ui_story == nil then
				arg_199_1.var_.characterEffect404001ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect404001ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect404001ui_story then
				arg_199_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_202_4 = arg_199_1.actors_["1284ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect1284ui_story == nil then
				arg_199_1.var_.characterEffect1284ui_story = var_202_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_5 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_5 and not isNil(var_202_4) then
				if arg_199_1.var_.characterEffect1284ui_story and not isNil(var_202_4) then
					arg_199_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_5)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_5 and arg_199_1.time_ < 0 + var_202_5 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect1284ui_story then
				arg_199_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_202_6 = 0
			local var_202_7 = 0.3

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_8 = arg_199_1:GetWordFromCfg(322062049)
				local var_202_9 = arg_199_1:FormatText(var_202_8.content)

				arg_199_1.text_.text = var_202_9

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 12 <= 0 and var_202_7 or var_202_7 * (utf8.len(var_202_9) / 12)

				if (12 <= 0 and var_202_7 or var_202_7 * (utf8.len(var_202_9) / 12)) > 0 and var_202_7 < var_202_11 then
					arg_199_1.talkMaxDuration = var_202_11

					if var_202_11 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_9
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062049", "story_v_out_322062.awb") ~= 0 then
					local var_202_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062049", "story_v_out_322062.awb") / 1000

					if var_202_12 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_6
					end

					if var_202_8.prefab_name ~= "" and arg_199_1.actors_[var_202_8.prefab_name] ~= nil then
						local var_202_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_8.prefab_name].transform, "story_v_out_322062", "322062049", "story_v_out_322062.awb")

						arg_199_1:RecordAudio("322062049", var_202_13)
						arg_199_1:RecordAudio("322062049", var_202_13)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_322062", "322062049", "story_v_out_322062.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_322062", "322062049", "story_v_out_322062.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_14 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_14 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_14

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_14 and arg_199_1.time_ < var_202_6 + var_202_14 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play322062050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 322062050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play322062051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos404001ui_story = arg_203_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["404001ui_story"].transform.position).z)
				arg_203_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["404001ui_story"].transform.localEulerAngles = arg_203_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["404001ui_story"].transform.position).z)
				arg_203_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["404001ui_story"].transform.localEulerAngles = arg_203_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1284ui_story"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1284ui_story = var_206_1.localPosition
			end

			local var_206_2 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 then
				var_206_1.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 0) / var_206_2)
				var_206_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_1.position).x, (manager.ui.mainCamera.transform.position - var_206_1.position).y, (manager.ui.mainCamera.transform.position - var_206_1.position).z)
				var_206_1.localEulerAngles.z = 0
				var_206_1.localEulerAngles.x = 0
				var_206_1.localEulerAngles = var_206_1.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 then
				var_206_1.localPosition = Vector3.New(0, 100, 0)
				var_206_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_1.position).x, (manager.ui.mainCamera.transform.position - var_206_1.position).y, (manager.ui.mainCamera.transform.position - var_206_1.position).z)
				var_206_1.localEulerAngles.z = 0
				var_206_1.localEulerAngles.x = 0
				var_206_1.localEulerAngles = var_206_1.localEulerAngles
			end

			local var_206_3 = 0
			local var_206_4 = 0.6

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_3 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_5 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(322062050).content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 24 <= 0 and var_206_4 or var_206_4 * (utf8.len(var_206_5) / 24)

				if (24 <= 0 and var_206_4 or var_206_4 * (utf8.len(var_206_5) / 24)) > 0 and var_206_4 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_3 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_3
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_8 = math.max(var_206_4, arg_203_1.talkMaxDuration)

			if var_206_3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_3 + var_206_8 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_3) / var_206_8

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_3 + var_206_8 and arg_203_1.time_ < var_206_3 + var_206_8 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play322062051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 322062051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play322062052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:AudioAction("play", "effect", "se_story_145", "se_story_145_light", "")
			end

			local var_210_1 = 0
			local var_210_2 = 1.85

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(322062051).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 74 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 74)

				if (74 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 74)) > 0 and var_210_2 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_6 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_6 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_6

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_6 and arg_207_1.time_ < var_210_1 + var_210_6 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play322062052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 322062052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play322062053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 1.375

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(322062052).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 55 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 55)

				if (55 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 55)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play322062053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 322062053
		arg_215_1.duration_ = 3.73

		local var_215_0 = {
			zh = 3.733,
			ja = 2.666
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play322062054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.35

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:GetWordFromCfg(322062053)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 14 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 14)

				if (14 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 14)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062053", "story_v_out_322062.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062053", "story_v_out_322062.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_322062", "322062053", "story_v_out_322062.awb")

						arg_215_1:RecordAudio("322062053", var_218_6)
						arg_215_1:RecordAudio("322062053", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_322062", "322062053", "story_v_out_322062.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_322062", "322062053", "story_v_out_322062.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_7 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_7

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play322062054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 322062054
		arg_219_1.duration_ = 2

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play322062055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos404001ui_story = arg_219_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["404001ui_story"].transform.position).z)
				arg_219_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["404001ui_story"].transform.localEulerAngles = arg_219_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_219_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["404001ui_story"].transform.position).z)
				arg_219_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["404001ui_story"].transform.localEulerAngles = arg_219_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["404001ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect404001ui_story == nil then
				arg_219_1.var_.characterEffect404001ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect404001ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect404001ui_story then
				arg_219_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_222_4 = arg_219_1.actors_["1284ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect1284ui_story == nil then
				arg_219_1.var_.characterEffect1284ui_story = var_222_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_5 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_5 and not isNil(var_222_4) then
				if arg_219_1.var_.characterEffect1284ui_story and not isNil(var_222_4) then
					arg_219_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_5)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_5 and arg_219_1.time_ < 0 + var_222_5 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect1284ui_story then
				arg_219_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_222_6 = 0
			local var_222_7 = 0.15

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_8 = arg_219_1:GetWordFromCfg(322062054)
				local var_222_9 = arg_219_1:FormatText(var_222_8.content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 6 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 6)

				if (6 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 6)) > 0 and var_222_7 < var_222_11 then
					arg_219_1.talkMaxDuration = var_222_11

					if var_222_11 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_11 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062054", "story_v_out_322062.awb") ~= 0 then
					local var_222_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062054", "story_v_out_322062.awb") / 1000

					if var_222_12 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_6
					end

					if var_222_8.prefab_name ~= "" and arg_219_1.actors_[var_222_8.prefab_name] ~= nil then
						local var_222_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_8.prefab_name].transform, "story_v_out_322062", "322062054", "story_v_out_322062.awb")

						arg_219_1:RecordAudio("322062054", var_222_13)
						arg_219_1:RecordAudio("322062054", var_222_13)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_322062", "322062054", "story_v_out_322062.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_322062", "322062054", "story_v_out_322062.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_14 and arg_219_1.time_ < var_222_6 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
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

		arg_219_1:InitPlayNodeList()
	end,
	Play322062055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 322062055
		arg_223_1.duration_ = 5.07

		local var_223_0 = {
			zh = 5.066,
			ja = 4
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play322062056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["404001ui_story"]) and arg_223_1.var_.characterEffect404001ui_story == nil then
				arg_223_1.var_.characterEffect404001ui_story = arg_223_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["404001ui_story"]) then
				if arg_223_1.var_.characterEffect404001ui_story and not isNil(arg_223_1.actors_["404001ui_story"]) then
					arg_223_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_223_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["404001ui_story"]) and arg_223_1.var_.characterEffect404001ui_story then
				arg_223_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_223_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0
			local var_226_2 = 0.375

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:GetWordFromCfg(322062055)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_6 = 15 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_4) / 15)

				if (15 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_4) / 15)) > 0 and var_226_2 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062055", "story_v_out_322062.awb") ~= 0 then
					local var_226_7 = manager.audio:GetVoiceLength("story_v_out_322062", "322062055", "story_v_out_322062.awb") / 1000

					if var_226_7 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_1
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_out_322062", "322062055", "story_v_out_322062.awb")

						arg_223_1:RecordAudio("322062055", var_226_8)
						arg_223_1:RecordAudio("322062055", var_226_8)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_322062", "322062055", "story_v_out_322062.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_322062", "322062055", "story_v_out_322062.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_9 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_9 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_9

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_9 and arg_223_1.time_ < var_226_1 + var_226_9 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play322062056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 322062056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play322062057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos404001ui_story = arg_227_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["404001ui_story"].transform.position).z)
				arg_227_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["404001ui_story"].transform.localEulerAngles = arg_227_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["404001ui_story"].transform.position).z)
				arg_227_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["404001ui_story"].transform.localEulerAngles = arg_227_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_230_1 = 0
			local var_230_2 = 1.425

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(322062056).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 57 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 57)

				if (57 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 57)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_6 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_6 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_6

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_6 and arg_227_1.time_ < var_230_1 + var_230_6 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play322062057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 322062057
		arg_231_1.duration_ = 5.83

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play322062058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_9000

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:AudioAction("play", "effect", "se_story_6", "se_story_6_giant_sword", "")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				local var_234_1 = arg_231_1.var_.effect2056

				if not arg_231_1.var_.effect2056 then
					var_234_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_234_1.name = "2056"
					arg_231_1.var_.effect2056 = var_234_1
				else
					var_234_1.transform:SetParent(var_234_9000)
				end

				var_234_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_234_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_234_3 = manager.ui.mainCamera.transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.shakeOldPos = var_234_3.localPosition
			end

			local var_234_4 = 0.4

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				local var_234_5, var_234_6 = math.modf((arg_231_1.time_ - 0) / 0.066)

				var_234_3.localPosition = Vector3.New(var_234_6 * 0.13, var_234_6 * 0.13, var_234_6 * 0.13) + arg_231_1.var_.shakeOldPos
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				var_234_3.localPosition = arg_231_1.var_.shakeOldPos
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_7 = 0.833333333333333
			local var_234_8 = 1.4

			if 0.833333333333333 < arg_231_1.time_ and arg_231_1.time_ <= var_234_7 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_9 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_9:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_10 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(322062057).content)

				arg_231_1.text_.text = var_234_10

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_12 = 56 <= 0 and var_234_8 or var_234_8 * (utf8.len(var_234_10) / 56)

				if (56 <= 0 and var_234_8 or var_234_8 * (utf8.len(var_234_10) / 56)) > 0 and var_234_8 < var_234_12 then
					arg_231_1.talkMaxDuration = var_234_12
					var_234_7 = var_234_7 + 0.3

					if var_234_12 + var_234_7 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_12 + var_234_7
					end
				end

				arg_231_1.text_.text = var_234_10
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_13 = var_234_7 + 0.3
			local var_234_14 = math.max(var_234_8, arg_231_1.talkMaxDuration)

			if var_234_7 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_13 + var_234_14 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_13) / var_234_14

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_13 + var_234_14 and arg_231_1.time_ < var_234_13 + var_234_14 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play322062058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 322062058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play322062059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_9000

			if 0.397879499010742 < arg_237_1.time_ and arg_237_1.time_ <= 0.397879499010742 + arg_240_0 then
				arg_237_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_sword02", "")
			end

			if 0.397879499010742 < arg_237_1.time_ and arg_237_1.time_ <= 0.397879499010742 + arg_240_0 then
				local var_240_1 = arg_237_1.var_.effect2058

				if not arg_237_1.var_.effect2058 then
					var_240_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang02"), manager.ui.mainCamera.transform)
					var_240_1.name = "2058"
					arg_237_1.var_.effect2058 = var_240_1
				else
					var_240_1.transform:SetParent(var_240_9000)
				end

				var_240_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_240_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.33333333333333 < arg_237_1.time_ and arg_237_1.time_ <= 2.33333333333333 + arg_240_0 then
				if arg_237_1.var_.effect2058 then
					Object.Destroy(arg_237_1.var_.effect2058)

					arg_237_1.var_.effect2058 = nil
				end
			end

			local var_240_4 = manager.ui.mainCamera.transform

			if 0.397879499010742 < arg_237_1.time_ and arg_237_1.time_ <= 0.397879499010742 + arg_240_0 then
				arg_237_1.var_.shakeOldPos = var_240_4.localPosition
			end

			local var_240_5 = 0.735453834322592

			if 0.397879499010742 <= arg_237_1.time_ and arg_237_1.time_ < 0.397879499010742 + var_240_5 then
				local var_240_6, var_240_7 = math.modf((arg_237_1.time_ - 0.397879499010742) / 0.066)

				var_240_4.localPosition = Vector3.New(var_240_7 * 0.13, var_240_7 * 0.13, var_240_7 * 0.13) + arg_237_1.var_.shakeOldPos
			end

			if arg_237_1.time_ >= 0.397879499010742 + var_240_5 and arg_237_1.time_ < 0.397879499010742 + var_240_5 + arg_240_0 then
				var_240_4.localPosition = arg_237_1.var_.shakeOldPos
			end

			local var_240_8 = 0
			local var_240_9 = 1.775

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_10 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(322062058).content)

				arg_237_1.text_.text = var_240_10

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_12 = 71 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_10) / 71)

				if (71 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_10) / 71)) > 0 and var_240_9 < var_240_12 then
					arg_237_1.talkMaxDuration = var_240_12

					if var_240_12 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_12 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_10
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_13 = math.max(var_240_9, arg_237_1.talkMaxDuration)

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_13 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_8) / var_240_13

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_8 + var_240_13 and arg_237_1.time_ < var_240_8 + var_240_13 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play322062059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 322062059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play322062060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 1.2

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(322062059).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 48 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 48)

				if (48 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 48)) > 0 and var_244_0 < var_244_3 then
					arg_241_1.talkMaxDuration = var_244_3

					if var_244_3 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_3 + 0
					end
				end

				arg_241_1.text_.text = var_244_1
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_4 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_4

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play322062060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 322062060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play322062061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_9000

			if 0.575 < arg_245_1.time_ and arg_245_1.time_ <= 0.575 + arg_248_0 then
				arg_245_1:AudioAction("play", "effect", "se_story_141", "se_story_141_snake04", "")
			end

			if 0.575 < arg_245_1.time_ and arg_245_1.time_ <= 0.575 + arg_248_0 then
				local var_248_1 = arg_245_1.var_.effect2060

				if not arg_245_1.var_.effect2060 then
					var_248_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), manager.ui.mainCamera.transform)
					var_248_1.name = "2060"
					arg_245_1.var_.effect2060 = var_248_1
				else
					var_248_1.transform:SetParent(var_248_9000)
				end

				var_248_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.66666666666667 < arg_245_1.time_ and arg_245_1.time_ <= 2.66666666666667 + arg_248_0 then
				if arg_245_1.var_.effect2060 then
					Object.Destroy(arg_245_1.var_.effect2060)

					arg_245_1.var_.effect2060 = nil
				end
			end

			local var_248_4 = manager.ui.mainCamera.transform

			if 0.575 < arg_245_1.time_ and arg_245_1.time_ <= 0.575 + arg_248_0 then
				arg_245_1.var_.shakeOldPos = var_248_4.localPosition
			end

			local var_248_5 = 0.158333333333333

			if 0.575 <= arg_245_1.time_ and arg_245_1.time_ < 0.575 + var_248_5 then
				local var_248_6, var_248_7 = math.modf((arg_245_1.time_ - 0.575) / 0.066)

				var_248_4.localPosition = Vector3.New(var_248_7 * 0.13, var_248_7 * 0.13, var_248_7 * 0.13) + arg_245_1.var_.shakeOldPos
			end

			if arg_245_1.time_ >= 0.575 + var_248_5 and arg_245_1.time_ < 0.575 + var_248_5 + arg_248_0 then
				var_248_4.localPosition = arg_245_1.var_.shakeOldPos
			end

			local var_248_8 = 0
			local var_248_9 = 1.575

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_10 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(322062060).content)

				arg_245_1.text_.text = var_248_10

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_12 = 63 <= 0 and var_248_9 or var_248_9 * (utf8.len(var_248_10) / 63)

				if (63 <= 0 and var_248_9 or var_248_9 * (utf8.len(var_248_10) / 63)) > 0 and var_248_9 < var_248_12 then
					arg_245_1.talkMaxDuration = var_248_12

					if var_248_12 + var_248_8 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_12 + var_248_8
					end
				end

				arg_245_1.text_.text = var_248_10
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_13 = math.max(var_248_9, arg_245_1.talkMaxDuration)

			if var_248_8 <= arg_245_1.time_ and arg_245_1.time_ < var_248_8 + var_248_13 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_8) / var_248_13

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_8 + var_248_13 and arg_245_1.time_ < var_248_8 + var_248_13 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play322062061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 322062061
		arg_249_1.duration_ = 3.5

		local var_249_0 = {
			zh = 3.1,
			ja = 3.5
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
				arg_249_0:Play322062062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos404001ui_story = arg_249_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["404001ui_story"].transform.position).z)
				arg_249_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["404001ui_story"].transform.localEulerAngles = arg_249_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_249_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["404001ui_story"].transform.position).z)
				arg_249_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["404001ui_story"].transform.localEulerAngles = arg_249_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["404001ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect404001ui_story == nil then
				arg_249_1.var_.characterEffect404001ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect404001ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect404001ui_story then
				arg_249_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				if arg_249_1.var_.effect2060 then
					Object.Destroy(arg_249_1.var_.effect2060)

					arg_249_1.var_.effect2060 = nil
				end
			end

			local var_252_5 = 0
			local var_252_6 = 0.325

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_7 = arg_249_1:GetWordFromCfg(322062061)
				local var_252_8 = arg_249_1:FormatText(var_252_7.content)

				arg_249_1.text_.text = var_252_8

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_10 = 13 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 13)

				if (13 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 13)) > 0 and var_252_6 < var_252_10 then
					arg_249_1.talkMaxDuration = var_252_10

					if var_252_10 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_5
					end
				end

				arg_249_1.text_.text = var_252_8
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062061", "story_v_out_322062.awb") ~= 0 then
					local var_252_11 = manager.audio:GetVoiceLength("story_v_out_322062", "322062061", "story_v_out_322062.awb") / 1000

					if var_252_11 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_5
					end

					if var_252_7.prefab_name ~= "" and arg_249_1.actors_[var_252_7.prefab_name] ~= nil then
						local var_252_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_7.prefab_name].transform, "story_v_out_322062", "322062061", "story_v_out_322062.awb")

						arg_249_1:RecordAudio("322062061", var_252_12)
						arg_249_1:RecordAudio("322062061", var_252_12)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_322062", "322062061", "story_v_out_322062.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_322062", "322062061", "story_v_out_322062.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_13 = math.max(var_252_6, arg_249_1.talkMaxDuration)

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_13 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_5) / var_252_13

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_5 + var_252_13 and arg_249_1.time_ < var_252_5 + var_252_13 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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

		arg_249_1:InitPlayNodeList()
	end,
	Play322062062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 322062062
		arg_253_1.duration_ = 7.1

		local var_253_0 = {
			zh = 3.7,
			ja = 7.1
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
				arg_253_0:Play322062063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10104ui_story = arg_253_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10104ui_story"].transform.position).z)
				arg_253_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["10104ui_story"].transform.localEulerAngles = arg_253_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_253_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10104ui_story"].transform.position).z)
				arg_253_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["10104ui_story"].transform.localEulerAngles = arg_253_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["10104ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect10104ui_story == nil then
				arg_253_1.var_.characterEffect10104ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect10104ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect10104ui_story then
				arg_253_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_256_4 = arg_253_1.actors_["404001ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect404001ui_story == nil then
				arg_253_1.var_.characterEffect404001ui_story = var_256_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_5 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_5 and not isNil(var_256_4) then
				if arg_253_1.var_.characterEffect404001ui_story and not isNil(var_256_4) then
					arg_253_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_253_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_5)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_5 and arg_253_1.time_ < 0 + var_256_5 + arg_256_0 and not isNil(var_256_4) and arg_253_1.var_.characterEffect404001ui_story then
				arg_253_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_253_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action4_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_256_6 = 0
			local var_256_7 = 0.475

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_8 = arg_253_1:GetWordFromCfg(322062062)
				local var_256_9 = arg_253_1:FormatText(var_256_8.content)

				arg_253_1.text_.text = var_256_9

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 19 <= 0 and var_256_7 or var_256_7 * (utf8.len(var_256_9) / 19)

				if (19 <= 0 and var_256_7 or var_256_7 * (utf8.len(var_256_9) / 19)) > 0 and var_256_7 < var_256_11 then
					arg_253_1.talkMaxDuration = var_256_11

					if var_256_11 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_11 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_9
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062062", "story_v_out_322062.awb") ~= 0 then
					local var_256_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062062", "story_v_out_322062.awb") / 1000

					if var_256_12 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_12 + var_256_6
					end

					if var_256_8.prefab_name ~= "" and arg_253_1.actors_[var_256_8.prefab_name] ~= nil then
						local var_256_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_8.prefab_name].transform, "story_v_out_322062", "322062062", "story_v_out_322062.awb")

						arg_253_1:RecordAudio("322062062", var_256_13)
						arg_253_1:RecordAudio("322062062", var_256_13)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_322062", "322062062", "story_v_out_322062.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_322062", "322062062", "story_v_out_322062.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_14 and arg_253_1.time_ < var_256_6 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play322062063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322062063
		arg_257_1.duration_ = 6.2

		local var_257_0 = {
			zh = 3.333,
			ja = 6.2
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
				arg_257_0:Play322062064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1211ui_story = arg_257_1.actors_["1211ui_story"].transform.localPosition

				arg_257_1:ShowWeapon(arg_257_1.var_["1211ui_story" .. "Animator"].transform, false)
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1211ui_story, Vector3.New(0, -0.67, -6.07), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1211ui_story"].transform.position).z)
				arg_257_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1211ui_story"].transform.localEulerAngles = arg_257_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, -0.67, -6.07)
				arg_257_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1211ui_story"].transform.position).z)
				arg_257_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1211ui_story"].transform.localEulerAngles = arg_257_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["404001ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos404001ui_story = var_260_1.localPosition
			end

			local var_260_2 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 then
				var_260_1.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_2)
				var_260_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_1.position).x, (manager.ui.mainCamera.transform.position - var_260_1.position).y, (manager.ui.mainCamera.transform.position - var_260_1.position).z)
				var_260_1.localEulerAngles.z = 0
				var_260_1.localEulerAngles.x = 0
				var_260_1.localEulerAngles = var_260_1.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 then
				var_260_1.localPosition = Vector3.New(0, 100, 0)
				var_260_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_1.position).x, (manager.ui.mainCamera.transform.position - var_260_1.position).y, (manager.ui.mainCamera.transform.position - var_260_1.position).z)
				var_260_1.localEulerAngles.z = 0
				var_260_1.localEulerAngles.x = 0
				var_260_1.localEulerAngles = var_260_1.localEulerAngles
			end

			local var_260_3 = arg_257_1.actors_["10104ui_story"].transform

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos10104ui_story = var_260_3.localPosition
			end

			local var_260_4 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				var_260_3.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_4)
				var_260_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_3.position).x, (manager.ui.mainCamera.transform.position - var_260_3.position).y, (manager.ui.mainCamera.transform.position - var_260_3.position).z)
				var_260_3.localEulerAngles.z = 0
				var_260_3.localEulerAngles.x = 0
				var_260_3.localEulerAngles = var_260_3.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				var_260_3.localPosition = Vector3.New(0, 100, 0)
				var_260_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_3.position).x, (manager.ui.mainCamera.transform.position - var_260_3.position).y, (manager.ui.mainCamera.transform.position - var_260_3.position).z)
				var_260_3.localEulerAngles.z = 0
				var_260_3.localEulerAngles.x = 0
				var_260_3.localEulerAngles = var_260_3.localEulerAngles
			end

			local var_260_5 = arg_257_1.actors_["1211ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.characterEffect1211ui_story == nil then
				arg_257_1.var_.characterEffect1211ui_story = var_260_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_6 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_6 and not isNil(var_260_5) then
				if arg_257_1.var_.characterEffect1211ui_story and not isNil(var_260_5) then
					arg_257_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_6 and arg_257_1.time_ < 0 + var_260_6 + arg_260_0 and not isNil(var_260_5) and arg_257_1.var_.characterEffect1211ui_story then
				arg_257_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_260_8 = arg_257_1.actors_["10104ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.characterEffect10104ui_story == nil then
				arg_257_1.var_.characterEffect10104ui_story = var_260_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_9 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_9 and not isNil(var_260_8) then
				if arg_257_1.var_.characterEffect10104ui_story and not isNil(var_260_8) then
					arg_257_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_257_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_9)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_9 and arg_257_1.time_ < 0 + var_260_9 + arg_260_0 and not isNil(var_260_8) and arg_257_1.var_.characterEffect10104ui_story then
				arg_257_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_257_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_260_10 = 0
			local var_260_11 = 0.35

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_12 = arg_257_1:GetWordFromCfg(322062063)
				local var_260_13 = arg_257_1:FormatText(var_260_12.content)

				arg_257_1.text_.text = var_260_13

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_15 = 14 <= 0 and var_260_11 or var_260_11 * (utf8.len(var_260_13) / 14)

				if (14 <= 0 and var_260_11 or var_260_11 * (utf8.len(var_260_13) / 14)) > 0 and var_260_11 < var_260_15 then
					arg_257_1.talkMaxDuration = var_260_15

					if var_260_15 + var_260_10 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_15 + var_260_10
					end
				end

				arg_257_1.text_.text = var_260_13
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062063", "story_v_out_322062.awb") ~= 0 then
					local var_260_16 = manager.audio:GetVoiceLength("story_v_out_322062", "322062063", "story_v_out_322062.awb") / 1000

					if var_260_16 + var_260_10 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_16 + var_260_10
					end

					if var_260_12.prefab_name ~= "" and arg_257_1.actors_[var_260_12.prefab_name] ~= nil then
						local var_260_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_12.prefab_name].transform, "story_v_out_322062", "322062063", "story_v_out_322062.awb")

						arg_257_1:RecordAudio("322062063", var_260_17)
						arg_257_1:RecordAudio("322062063", var_260_17)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322062", "322062063", "story_v_out_322062.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322062", "322062063", "story_v_out_322062.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_18 = math.max(var_260_11, arg_257_1.talkMaxDuration)

			if var_260_10 <= arg_257_1.time_ and arg_257_1.time_ < var_260_10 + var_260_18 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_10) / var_260_18

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_10 + var_260_18 and arg_257_1.time_ < var_260_10 + var_260_18 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play322062064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322062064
		arg_261_1.duration_ = 8.63

		local var_261_0 = {
			zh = 7.566,
			ja = 8.633
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play322062065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1284ui_story = arg_261_1.actors_["1284ui_story"].transform.localPosition

				arg_261_1:ShowWeapon(arg_261_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1284ui_story"].transform.position).z)
				arg_261_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1284ui_story"].transform.localEulerAngles = arg_261_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_261_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1284ui_story"].transform.position).z)
				arg_261_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1284ui_story"].transform.localEulerAngles = arg_261_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1211ui_story"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1211ui_story = var_264_1.localPosition
			end

			local var_264_2 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 then
				var_264_1.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_261_1.time_ - 0) / var_264_2)
				var_264_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_1.position).x, (manager.ui.mainCamera.transform.position - var_264_1.position).y, (manager.ui.mainCamera.transform.position - var_264_1.position).z)
				var_264_1.localEulerAngles.z = 0
				var_264_1.localEulerAngles.x = 0
				var_264_1.localEulerAngles = var_264_1.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 then
				var_264_1.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				var_264_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_1.position).x, (manager.ui.mainCamera.transform.position - var_264_1.position).y, (manager.ui.mainCamera.transform.position - var_264_1.position).z)
				var_264_1.localEulerAngles.z = 0
				var_264_1.localEulerAngles.x = 0
				var_264_1.localEulerAngles = var_264_1.localEulerAngles
			end

			local var_264_3 = arg_261_1.actors_["1284ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_3) and arg_261_1.var_.characterEffect1284ui_story == nil then
				arg_261_1.var_.characterEffect1284ui_story = var_264_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_4 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 and not isNil(var_264_3) then
				if arg_261_1.var_.characterEffect1284ui_story and not isNil(var_264_3) then
					arg_261_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 and not isNil(var_264_3) and arg_261_1.var_.characterEffect1284ui_story then
				arg_261_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_264_6 = arg_261_1.actors_["1211ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_6) and arg_261_1.var_.characterEffect1211ui_story == nil then
				arg_261_1.var_.characterEffect1211ui_story = var_264_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_7 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 and not isNil(var_264_6) then
				if arg_261_1.var_.characterEffect1211ui_story and not isNil(var_264_6) then
					arg_261_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_7)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 and not isNil(var_264_6) and arg_261_1.var_.characterEffect1211ui_story then
				arg_261_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_264_8 = 0
			local var_264_9 = 0.725

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_10 = arg_261_1:GetWordFromCfg(322062064)
				local var_264_11 = arg_261_1:FormatText(var_264_10.content)

				arg_261_1.text_.text = var_264_11

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_13 = 29 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_11) / 29)

				if (29 <= 0 and var_264_9 or var_264_9 * (utf8.len(var_264_11) / 29)) > 0 and var_264_9 < var_264_13 then
					arg_261_1.talkMaxDuration = var_264_13

					if var_264_13 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_13 + var_264_8
					end
				end

				arg_261_1.text_.text = var_264_11
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062064", "story_v_out_322062.awb") ~= 0 then
					local var_264_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062064", "story_v_out_322062.awb") / 1000

					if var_264_14 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_14 + var_264_8
					end

					if var_264_10.prefab_name ~= "" and arg_261_1.actors_[var_264_10.prefab_name] ~= nil then
						local var_264_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_10.prefab_name].transform, "story_v_out_322062", "322062064", "story_v_out_322062.awb")

						arg_261_1:RecordAudio("322062064", var_264_15)
						arg_261_1:RecordAudio("322062064", var_264_15)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_322062", "322062064", "story_v_out_322062.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_322062", "322062064", "story_v_out_322062.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_16 = math.max(var_264_9, arg_261_1.talkMaxDuration)

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_16 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_8) / var_264_16

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_8 + var_264_16 and arg_261_1.time_ < var_264_8 + var_264_16 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_261_1:InitPlayNodeList()
	end,
	Play322062065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 322062065
		arg_265_1.duration_ = 5.73

		local var_265_0 = {
			zh = 4.366,
			ja = 5.733
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
				arg_265_0:Play322062066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos404001ui_story = arg_265_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["404001ui_story"].transform.position).z)
				arg_265_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["404001ui_story"].transform.localEulerAngles = arg_265_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_265_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["404001ui_story"].transform.position).z)
				arg_265_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["404001ui_story"].transform.localEulerAngles = arg_265_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1211ui_story"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1211ui_story = var_268_1.localPosition
			end

			local var_268_2 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 then
				var_268_1.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_2)
				var_268_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_1.position).x, (manager.ui.mainCamera.transform.position - var_268_1.position).y, (manager.ui.mainCamera.transform.position - var_268_1.position).z)
				var_268_1.localEulerAngles.z = 0
				var_268_1.localEulerAngles.x = 0
				var_268_1.localEulerAngles = var_268_1.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 then
				var_268_1.localPosition = Vector3.New(0, 100, 0)
				var_268_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_1.position).x, (manager.ui.mainCamera.transform.position - var_268_1.position).y, (manager.ui.mainCamera.transform.position - var_268_1.position).z)
				var_268_1.localEulerAngles.z = 0
				var_268_1.localEulerAngles.x = 0
				var_268_1.localEulerAngles = var_268_1.localEulerAngles
			end

			local var_268_3 = arg_265_1.actors_["404001ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_3) and arg_265_1.var_.characterEffect404001ui_story == nil then
				arg_265_1.var_.characterEffect404001ui_story = var_268_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_4 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 and not isNil(var_268_3) then
				if arg_265_1.var_.characterEffect404001ui_story and not isNil(var_268_3) then
					arg_265_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 and not isNil(var_268_3) and arg_265_1.var_.characterEffect404001ui_story then
				arg_265_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_268_6 = arg_265_1.actors_["1284ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_6) and arg_265_1.var_.characterEffect1284ui_story == nil then
				arg_265_1.var_.characterEffect1284ui_story = var_268_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_7 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 and not isNil(var_268_6) then
				if arg_265_1.var_.characterEffect1284ui_story and not isNil(var_268_6) then
					arg_265_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_7)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 and not isNil(var_268_6) and arg_265_1.var_.characterEffect1284ui_story then
				arg_265_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_268_8 = 0
			local var_268_9 = 0.475

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_10 = arg_265_1:GetWordFromCfg(322062065)
				local var_268_11 = arg_265_1:FormatText(var_268_10.content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_13 = 19 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 19)

				if (19 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 19)) > 0 and var_268_9 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062065", "story_v_out_322062.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062065", "story_v_out_322062.awb") / 1000

					if var_268_14 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_8
					end

					if var_268_10.prefab_name ~= "" and arg_265_1.actors_[var_268_10.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_10.prefab_name].transform, "story_v_out_322062", "322062065", "story_v_out_322062.awb")

						arg_265_1:RecordAudio("322062065", var_268_15)
						arg_265_1:RecordAudio("322062065", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_322062", "322062065", "story_v_out_322062.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_322062", "322062065", "story_v_out_322062.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_16 = math.max(var_268_9, arg_265_1.talkMaxDuration)

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_16 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_8) / var_268_16

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_8 + var_268_16 and arg_265_1.time_ < var_268_8 + var_268_16 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_265_1:InitPlayNodeList()
	end,
	Play322062066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322062066
		arg_269_1.duration_ = 7.53

		local var_269_0 = {
			zh = 5.4,
			ja = 7.533
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
				arg_269_0:Play322062067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1284ui_story = arg_269_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1284ui_story"].transform.position).z)
				arg_269_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1284ui_story"].transform.localEulerAngles = arg_269_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_269_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1284ui_story"].transform.position).z)
				arg_269_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1284ui_story"].transform.localEulerAngles = arg_269_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["1284ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1284ui_story == nil then
				arg_269_1.var_.characterEffect1284ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1284ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1284ui_story then
				arg_269_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_272_4 = arg_269_1.actors_["404001ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_4) and arg_269_1.var_.characterEffect404001ui_story == nil then
				arg_269_1.var_.characterEffect404001ui_story = var_272_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_5 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_5 and not isNil(var_272_4) then
				if arg_269_1.var_.characterEffect404001ui_story and not isNil(var_272_4) then
					arg_269_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_269_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_5)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_5 and arg_269_1.time_ < 0 + var_272_5 + arg_272_0 and not isNil(var_272_4) and arg_269_1.var_.characterEffect404001ui_story then
				arg_269_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_269_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action4_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_272_6 = 0
			local var_272_7 = 0.65

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_8 = arg_269_1:GetWordFromCfg(322062066)
				local var_272_9 = arg_269_1:FormatText(var_272_8.content)

				arg_269_1.text_.text = var_272_9

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_11 = 26 <= 0 and var_272_7 or var_272_7 * (utf8.len(var_272_9) / 26)

				if (26 <= 0 and var_272_7 or var_272_7 * (utf8.len(var_272_9) / 26)) > 0 and var_272_7 < var_272_11 then
					arg_269_1.talkMaxDuration = var_272_11

					if var_272_11 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_11 + var_272_6
					end
				end

				arg_269_1.text_.text = var_272_9
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062066", "story_v_out_322062.awb") ~= 0 then
					local var_272_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062066", "story_v_out_322062.awb") / 1000

					if var_272_12 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_12 + var_272_6
					end

					if var_272_8.prefab_name ~= "" and arg_269_1.actors_[var_272_8.prefab_name] ~= nil then
						local var_272_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_8.prefab_name].transform, "story_v_out_322062", "322062066", "story_v_out_322062.awb")

						arg_269_1:RecordAudio("322062066", var_272_13)
						arg_269_1:RecordAudio("322062066", var_272_13)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322062", "322062066", "story_v_out_322062.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322062", "322062066", "story_v_out_322062.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_14 = math.max(var_272_7, arg_269_1.talkMaxDuration)

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_14 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_6) / var_272_14

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_6 + var_272_14 and arg_269_1.time_ < var_272_6 + var_272_14 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322062067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322062067
		arg_273_1.duration_ = 4.9

		local var_273_0 = {
			zh = 4.5,
			ja = 4.9
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play322062068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1156ui_story = arg_273_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1156ui_story, Vector3.New(0.9, -1.1, -6.18), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1156ui_story"].transform.position).z)
				arg_273_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1156ui_story"].transform.localEulerAngles = arg_273_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0.9, -1.1, -6.18)
				arg_273_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1156ui_story"].transform.position).z)
				arg_273_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1156ui_story"].transform.localEulerAngles = arg_273_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["1284ui_story"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1284ui_story = var_276_1.localPosition
			end

			local var_276_2 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 then
				var_276_1.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_2)
				var_276_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_1.position).x, (manager.ui.mainCamera.transform.position - var_276_1.position).y, (manager.ui.mainCamera.transform.position - var_276_1.position).z)
				var_276_1.localEulerAngles.z = 0
				var_276_1.localEulerAngles.x = 0
				var_276_1.localEulerAngles = var_276_1.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 then
				var_276_1.localPosition = Vector3.New(0, 100, 0)
				var_276_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_1.position).x, (manager.ui.mainCamera.transform.position - var_276_1.position).y, (manager.ui.mainCamera.transform.position - var_276_1.position).z)
				var_276_1.localEulerAngles.z = 0
				var_276_1.localEulerAngles.x = 0
				var_276_1.localEulerAngles = var_276_1.localEulerAngles
			end

			local var_276_3 = arg_273_1.actors_["1156ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_3) and arg_273_1.var_.characterEffect1156ui_story == nil then
				arg_273_1.var_.characterEffect1156ui_story = var_276_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_4 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 and not isNil(var_276_3) then
				if arg_273_1.var_.characterEffect1156ui_story and not isNil(var_276_3) then
					arg_273_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 and not isNil(var_276_3) and arg_273_1.var_.characterEffect1156ui_story then
				arg_273_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_276_6 = arg_273_1.actors_["1284ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_6) and arg_273_1.var_.characterEffect1284ui_story == nil then
				arg_273_1.var_.characterEffect1284ui_story = var_276_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_7 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 and not isNil(var_276_6) then
				if arg_273_1.var_.characterEffect1284ui_story and not isNil(var_276_6) then
					arg_273_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_7)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 and not isNil(var_276_6) and arg_273_1.var_.characterEffect1284ui_story then
				arg_273_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_276_8 = 0
			local var_276_9 = 0.5

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_10 = arg_273_1:GetWordFromCfg(322062067)
				local var_276_11 = arg_273_1:FormatText(var_276_10.content)

				arg_273_1.text_.text = var_276_11

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_13 = 20 <= 0 and var_276_9 or var_276_9 * (utf8.len(var_276_11) / 20)

				if (20 <= 0 and var_276_9 or var_276_9 * (utf8.len(var_276_11) / 20)) > 0 and var_276_9 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_8
					end
				end

				arg_273_1.text_.text = var_276_11
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062067", "story_v_out_322062.awb") ~= 0 then
					local var_276_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062067", "story_v_out_322062.awb") / 1000

					if var_276_14 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_14 + var_276_8
					end

					if var_276_10.prefab_name ~= "" and arg_273_1.actors_[var_276_10.prefab_name] ~= nil then
						local var_276_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_10.prefab_name].transform, "story_v_out_322062", "322062067", "story_v_out_322062.awb")

						arg_273_1:RecordAudio("322062067", var_276_15)
						arg_273_1:RecordAudio("322062067", var_276_15)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_322062", "322062067", "story_v_out_322062.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_322062", "322062067", "story_v_out_322062.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_16 = math.max(var_276_9, arg_273_1.talkMaxDuration)

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_16 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_8) / var_276_16

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_8 + var_276_16 and arg_273_1.time_ < var_276_8 + var_276_16 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322062068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322062068
		arg_277_1.duration_ = 10.33

		local var_277_0 = {
			zh = 5.6,
			ja = 10.333
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
				arg_277_0:Play322062069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos404001ui_story = arg_277_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["404001ui_story"].transform.position).z)
				arg_277_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["404001ui_story"].transform.localEulerAngles = arg_277_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_277_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["404001ui_story"].transform.position).z)
				arg_277_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["404001ui_story"].transform.localEulerAngles = arg_277_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["404001ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect404001ui_story == nil then
				arg_277_1.var_.characterEffect404001ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect404001ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect404001ui_story then
				arg_277_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_280_4 = arg_277_1.actors_["1156ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect1156ui_story == nil then
				arg_277_1.var_.characterEffect1156ui_story = var_280_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_5 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_5 and not isNil(var_280_4) then
				if arg_277_1.var_.characterEffect1156ui_story and not isNil(var_280_4) then
					arg_277_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_5)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_5 and arg_277_1.time_ < 0 + var_280_5 + arg_280_0 and not isNil(var_280_4) and arg_277_1.var_.characterEffect1156ui_story then
				arg_277_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_280_6 = 0
			local var_280_7 = 0.675

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_8 = arg_277_1:GetWordFromCfg(322062068)
				local var_280_9 = arg_277_1:FormatText(var_280_8.content)

				arg_277_1.text_.text = var_280_9

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 27 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 27)

				if (27 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 27)) > 0 and var_280_7 < var_280_11 then
					arg_277_1.talkMaxDuration = var_280_11

					if var_280_11 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_9
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062068", "story_v_out_322062.awb") ~= 0 then
					local var_280_12 = manager.audio:GetVoiceLength("story_v_out_322062", "322062068", "story_v_out_322062.awb") / 1000

					if var_280_12 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_12 + var_280_6
					end

					if var_280_8.prefab_name ~= "" and arg_277_1.actors_[var_280_8.prefab_name] ~= nil then
						local var_280_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_8.prefab_name].transform, "story_v_out_322062", "322062068", "story_v_out_322062.awb")

						arg_277_1:RecordAudio("322062068", var_280_13)
						arg_277_1:RecordAudio("322062068", var_280_13)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322062", "322062068", "story_v_out_322062.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322062", "322062068", "story_v_out_322062.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_14 = math.max(var_280_7, arg_277_1.talkMaxDuration)

			if var_280_6 <= arg_277_1.time_ and arg_277_1.time_ < var_280_6 + var_280_14 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_6) / var_280_14

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_6 + var_280_14 and arg_277_1.time_ < var_280_6 + var_280_14 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
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

		arg_277_1:InitPlayNodeList()
	end,
	Play322062069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322062069
		arg_281_1.duration_ = 7.23

		local var_281_0 = {
			zh = 7.233,
			ja = 5.8
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
				arg_281_0:Play322062070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_284_0 = 0
			local var_284_1 = 0.825

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(322062069)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 33 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 33)

				if (33 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 33)) > 0 and var_284_1 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062069", "story_v_out_322062.awb") ~= 0 then
					local var_284_6 = manager.audio:GetVoiceLength("story_v_out_322062", "322062069", "story_v_out_322062.awb") / 1000

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end

					if var_284_2.prefab_name ~= "" and arg_281_1.actors_[var_284_2.prefab_name] ~= nil then
						local var_284_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_2.prefab_name].transform, "story_v_out_322062", "322062069", "story_v_out_322062.awb")

						arg_281_1:RecordAudio("322062069", var_284_7)
						arg_281_1:RecordAudio("322062069", var_284_7)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_322062", "322062069", "story_v_out_322062.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_322062", "322062069", "story_v_out_322062.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_8 and arg_281_1.time_ < var_284_0 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play322062070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322062070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play322062071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos404001ui_story = arg_285_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["404001ui_story"].transform.position).z)
				arg_285_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["404001ui_story"].transform.localEulerAngles = arg_285_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["404001ui_story"].transform.position).z)
				arg_285_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["404001ui_story"].transform.localEulerAngles = arg_285_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1156ui_story"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1156ui_story = var_288_1.localPosition
			end

			local var_288_2 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 then
				var_288_1.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_2)
				var_288_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_1.position).x, (manager.ui.mainCamera.transform.position - var_288_1.position).y, (manager.ui.mainCamera.transform.position - var_288_1.position).z)
				var_288_1.localEulerAngles.z = 0
				var_288_1.localEulerAngles.x = 0
				var_288_1.localEulerAngles = var_288_1.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 then
				var_288_1.localPosition = Vector3.New(0, 100, 0)
				var_288_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_1.position).x, (manager.ui.mainCamera.transform.position - var_288_1.position).y, (manager.ui.mainCamera.transform.position - var_288_1.position).z)
				var_288_1.localEulerAngles.z = 0
				var_288_1.localEulerAngles.x = 0
				var_288_1.localEulerAngles = var_288_1.localEulerAngles
			end

			local var_288_3 = 0
			local var_288_4 = 1.5

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_3 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_5 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(322062070).content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_7 = 60 <= 0 and var_288_4 or var_288_4 * (utf8.len(var_288_5) / 60)

				if (60 <= 0 and var_288_4 or var_288_4 * (utf8.len(var_288_5) / 60)) > 0 and var_288_4 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_3 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_3
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_8 = math.max(var_288_4, arg_285_1.talkMaxDuration)

			if var_288_3 <= arg_285_1.time_ and arg_285_1.time_ < var_288_3 + var_288_8 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_3) / var_288_8

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_3 + var_288_8 and arg_285_1.time_ < var_288_3 + var_288_8 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_285_1:InitPlayNodeList()
	end,
	Play322062071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322062071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play322062072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 1.3

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(322062071).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 52 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 52)

				if (52 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 52)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play322062072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 322062072
		arg_293_1.duration_ = 4.03

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play322062073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1156ui_story = arg_293_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1156ui_story, Vector3.New(0, -1.1, -6.18), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1156ui_story"].transform.position).z)
				arg_293_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1156ui_story"].transform.localEulerAngles = arg_293_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.18)
				arg_293_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1156ui_story"].transform.position).z)
				arg_293_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1156ui_story"].transform.localEulerAngles = arg_293_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["1156ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1156ui_story == nil then
				arg_293_1.var_.characterEffect1156ui_story = var_296_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 and not isNil(var_296_1) then
				if arg_293_1.var_.characterEffect1156ui_story and not isNil(var_296_1) then
					arg_293_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1156ui_story then
				arg_293_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_296_4 = 0
			local var_296_5 = 0.4

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_6 = arg_293_1:GetWordFromCfg(322062072)
				local var_296_7 = arg_293_1:FormatText(var_296_6.content)

				arg_293_1.text_.text = var_296_7

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_9 = 16 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 16)

				if (16 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_7) / 16)) > 0 and var_296_5 < var_296_9 then
					arg_293_1.talkMaxDuration = var_296_9

					if var_296_9 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_7
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062072", "story_v_out_322062.awb") ~= 0 then
					local var_296_10 = manager.audio:GetVoiceLength("story_v_out_322062", "322062072", "story_v_out_322062.awb") / 1000

					if var_296_10 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_4
					end

					if var_296_6.prefab_name ~= "" and arg_293_1.actors_[var_296_6.prefab_name] ~= nil then
						local var_296_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_6.prefab_name].transform, "story_v_out_322062", "322062072", "story_v_out_322062.awb")

						arg_293_1:RecordAudio("322062072", var_296_11)
						arg_293_1:RecordAudio("322062072", var_296_11)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322062", "322062072", "story_v_out_322062.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322062", "322062072", "story_v_out_322062.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_12 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_12 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_12

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_12 and arg_293_1.time_ < var_296_4 + var_296_12 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
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

		arg_293_1:InitPlayNodeList()
	end,
	Play322062073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 322062073
		arg_297_1.duration_ = 14.5

		local var_297_0 = {
			zh = 13,
			ja = 14.5
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play322062074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if arg_297_1.bgs_.ST61a == nil then
				local var_300_0 = Object.Instantiate(arg_297_1.paintGo_)

				var_300_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61a")
				var_300_0.name = "ST61a"
				var_300_0.transform.parent = arg_297_1.stage_.transform
				var_300_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.bgs_.ST61a = var_300_0
			end

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= 2 + arg_300_0 then
				local var_300_1 = arg_297_1.bgs_.ST61a

				arg_297_1.bgs_.ST61a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_300_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_300_2 = var_300_1:GetComponent("SpriteRenderer")

				if var_300_2 and var_300_2.sprite then
					local var_300_3 = 2 * (var_300_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_300_1.transform.localScale = Vector3.New(var_300_3 / var_300_2.sprite.bounds.size.y < var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x and var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x or var_300_3 / var_300_2.sprite.bounds.size.y, var_300_3 / var_300_2.sprite.bounds.size.y < var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x and var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x or var_300_3 / var_300_2.sprite.bounds.size.y, 0)
				end

				for iter_300_0, iter_300_1 in pairs(arg_297_1.bgs_) do
					if iter_300_0 ~= "ST61a" then
						iter_300_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_300_4 = 4

			if 4 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.allBtn_.enabled = false
			end

			if arg_297_1.time_ >= var_300_4 + 0.3 and arg_297_1.time_ < var_300_4 + 0.3 + arg_300_0 then
				arg_297_1.allBtn_.enabled = true
			end

			local var_300_5 = 0

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_6 = 2

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_6 then
				local var_300_7 = Color.New(0, 0, 0)

				var_300_7.a = Mathf.Lerp(0, 1, (arg_297_1.time_ - var_300_5) / var_300_6)
				arg_297_1.mask_.color = var_300_7
			end

			if arg_297_1.time_ >= var_300_5 + var_300_6 and arg_297_1.time_ < var_300_5 + var_300_6 + arg_300_0 then
				local var_300_8 = Color.New(0, 0, 0)

				var_300_8.a = 1
				arg_297_1.mask_.color = var_300_8
			end

			local var_300_9 = 2

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_9 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_10 = 2

			if var_300_9 <= arg_297_1.time_ and arg_297_1.time_ < var_300_9 + var_300_10 then
				local var_300_11 = Color.New(0, 0, 0)

				var_300_11.a = Mathf.Lerp(1, 0, (arg_297_1.time_ - var_300_9) / var_300_10)
				arg_297_1.mask_.color = var_300_11
			end

			if arg_297_1.time_ >= var_300_9 + var_300_10 and arg_297_1.time_ < var_300_9 + var_300_10 + arg_300_0 then
				local var_300_12 = Color.New(0, 0, 0)

				arg_297_1.mask_.enabled = false
				var_300_12.a = 0
				arg_297_1.mask_.color = var_300_12
			end

			local var_300_13 = arg_297_1.actors_["1156ui_story"].transform

			if 1.96599999815226 < arg_297_1.time_ and arg_297_1.time_ <= 1.96599999815226 + arg_300_0 then
				arg_297_1.var_.moveOldPos1156ui_story = var_300_13.localPosition
			end

			local var_300_14 = 0.001

			if 1.96599999815226 <= arg_297_1.time_ and arg_297_1.time_ < 1.96599999815226 + var_300_14 then
				var_300_13.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 1.96599999815226) / var_300_14)
				var_300_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_13.position).x, (manager.ui.mainCamera.transform.position - var_300_13.position).y, (manager.ui.mainCamera.transform.position - var_300_13.position).z)
				var_300_13.localEulerAngles.z = 0
				var_300_13.localEulerAngles.x = 0
				var_300_13.localEulerAngles = var_300_13.localEulerAngles
			end

			if arg_297_1.time_ >= 1.96599999815226 + var_300_14 and arg_297_1.time_ < 1.96599999815226 + var_300_14 + arg_300_0 then
				var_300_13.localPosition = Vector3.New(0, 100, 0)
				var_300_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_13.position).x, (manager.ui.mainCamera.transform.position - var_300_13.position).y, (manager.ui.mainCamera.transform.position - var_300_13.position).z)
				var_300_13.localEulerAngles.z = 0
				var_300_13.localEulerAngles.x = 0
				var_300_13.localEulerAngles = var_300_13.localEulerAngles
			end

			local var_300_15 = arg_297_1.actors_["1156ui_story"]

			if 1.96599999815226 < arg_297_1.time_ and arg_297_1.time_ <= 1.96599999815226 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.characterEffect1156ui_story == nil then
				arg_297_1.var_.characterEffect1156ui_story = var_300_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_16 = 0.034000001847744

			if 1.96599999815226 <= arg_297_1.time_ and arg_297_1.time_ < 1.96599999815226 + var_300_16 and not isNil(var_300_15) then
				if arg_297_1.var_.characterEffect1156ui_story and not isNil(var_300_15) then
					arg_297_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 1.96599999815226) / var_300_16)
				end
			end

			if arg_297_1.time_ >= 1.96599999815226 + var_300_16 and arg_297_1.time_ < 1.96599999815226 + var_300_16 + arg_300_0 and not isNil(var_300_15) and arg_297_1.var_.characterEffect1156ui_story then
				arg_297_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_297_1.time_ and arg_297_1.time_ <= 0.1 + arg_300_0 then
				arg_297_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_fire", "")
			end

			if 1.53333333333333 < arg_297_1.time_ and arg_297_1.time_ <= 1.53333333333333 + arg_300_0 then
				arg_297_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_300_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_297_1.bgmTxt_.text ~= var_300_21 and arg_297_1.bgmTxt_.text ~= "" then
						if arg_297_1.bgmTxt2_.text ~= "" then
							arg_297_1.bgmTxt_.text = arg_297_1.bgmTxt2_.text
						end

						arg_297_1.bgmTxt2_.text = var_300_21

						arg_297_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_297_1.bgmTxt_.text = var_300_21
						arg_297_1.bgmTxt2_.text = var_300_21
					end

					if arg_297_1.bgmTimer then
						arg_297_1.bgmTimer:Stop()

						arg_297_1.bgmTimer = nil
					end

					if arg_297_1.settingData.show_music_name == 1 then
						arg_297_1.musicController:SetSelectedState("show")
						arg_297_1.musicAnimator_:Play("open", 0, 0)

						if arg_297_1.settingData.music_time ~= 0 then
							arg_297_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_297_1.settingData.music_time), function()
								if arg_297_1 == nil or isNil(arg_297_1.bgmTxt_) then
									return
								end

								arg_297_1.musicController:SetSelectedState("hide")
								arg_297_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_297_1.time_ and arg_297_1.time_ <= 0.433333333333333 + arg_300_0 then
				arg_297_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious.awb")

				local var_300_24 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious")

				if "" ~= "" then
					if arg_297_1.bgmTxt_.text ~= var_300_24 and arg_297_1.bgmTxt_.text ~= "" then
						if arg_297_1.bgmTxt2_.text ~= "" then
							arg_297_1.bgmTxt_.text = arg_297_1.bgmTxt2_.text
						end

						arg_297_1.bgmTxt2_.text = var_300_24

						arg_297_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_297_1.bgmTxt_.text = var_300_24
						arg_297_1.bgmTxt2_.text = var_300_24
					end

					if arg_297_1.bgmTimer then
						arg_297_1.bgmTimer:Stop()

						arg_297_1.bgmTimer = nil
					end

					if arg_297_1.settingData.show_music_name == 1 then
						arg_297_1.musicController:SetSelectedState("show")
						arg_297_1.musicAnimator_:Play("open", 0, 0)

						if arg_297_1.settingData.music_time ~= 0 then
							arg_297_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_297_1.settingData.music_time), function()
								if arg_297_1 == nil or isNil(arg_297_1.bgmTxt_) then
									return
								end

								arg_297_1.musicController:SetSelectedState("hide")
								arg_297_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.44 < arg_297_1.time_ and arg_297_1.time_ <= 0.44 + arg_300_0 then
				arg_297_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "init_story", "bgm_activity_4_5_story_serious.awb")

				local var_300_27 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_story")

				if "" ~= "" then
					if arg_297_1.bgmTxt_.text ~= var_300_27 and arg_297_1.bgmTxt_.text ~= "" then
						if arg_297_1.bgmTxt2_.text ~= "" then
							arg_297_1.bgmTxt_.text = arg_297_1.bgmTxt2_.text
						end

						arg_297_1.bgmTxt2_.text = var_300_27

						arg_297_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_297_1.bgmTxt_.text = var_300_27
						arg_297_1.bgmTxt2_.text = var_300_27
					end

					if arg_297_1.bgmTimer then
						arg_297_1.bgmTimer:Stop()

						arg_297_1.bgmTimer = nil
					end

					if arg_297_1.settingData.show_music_name == 1 then
						arg_297_1.musicController:SetSelectedState("show")
						arg_297_1.musicAnimator_:Play("open", 0, 0)

						if arg_297_1.settingData.music_time ~= 0 then
							arg_297_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_297_1.settingData.music_time), function()
								if arg_297_1 == nil or isNil(arg_297_1.bgmTxt_) then
									return
								end

								arg_297_1.musicController:SetSelectedState("hide")
								arg_297_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_28 = 4
			local var_300_29 = 0.975

			if 4 < arg_297_1.time_ and arg_297_1.time_ <= var_300_28 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_30 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_30:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_297_1.dialogCg_.alpha = arg_304_0
				end))
				var_300_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_31 = arg_297_1:GetWordFromCfg(322062073)
				local var_300_32 = arg_297_1:FormatText(var_300_31.content)

				arg_297_1.text_.text = var_300_32

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_34 = 39 <= 0 and var_300_29 or var_300_29 * (utf8.len(var_300_32) / 39)

				if (39 <= 0 and var_300_29 or var_300_29 * (utf8.len(var_300_32) / 39)) > 0 and var_300_29 < var_300_34 then
					arg_297_1.talkMaxDuration = var_300_34
					var_300_28 = var_300_28 + 0.3

					if var_300_34 + var_300_28 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_34 + var_300_28
					end
				end

				arg_297_1.text_.text = var_300_32
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062073", "story_v_out_322062.awb") ~= 0 then
					local var_300_35 = manager.audio:GetVoiceLength("story_v_out_322062", "322062073", "story_v_out_322062.awb") / 1000

					if var_300_35 + var_300_28 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_35 + var_300_28
					end

					if var_300_31.prefab_name ~= "" and arg_297_1.actors_[var_300_31.prefab_name] ~= nil then
						local var_300_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_31.prefab_name].transform, "story_v_out_322062", "322062073", "story_v_out_322062.awb")

						arg_297_1:RecordAudio("322062073", var_300_36)
						arg_297_1:RecordAudio("322062073", var_300_36)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_322062", "322062073", "story_v_out_322062.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_322062", "322062073", "story_v_out_322062.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_37 = var_300_28 + 0.3
			local var_300_38 = math.max(var_300_29, arg_297_1.talkMaxDuration)

			if var_300_28 + 0.3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_37 + var_300_38 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_37) / var_300_38

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_37 + var_300_38 and arg_297_1.time_ < var_300_37 + var_300_38 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play322062074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 322062074
		arg_306_1.duration_ = 9.07

		local var_306_0 = {
			zh = 6.6,
			ja = 9.066
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play322062075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if arg_306_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_309_0 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_306_1.stage_.transform)

				var_309_0.name = "1089ui_story"
				var_309_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_306_1.actors_["1089ui_story"] = var_309_0

				local var_309_1 = var_309_0:GetComponentInChildren(typeof(CharacterEffect))

				var_309_1.enabled = true

				local var_309_2 = GameObjectTools.GetOrAddComponent(var_309_0, typeof(DynamicBoneHelper))

				if var_309_2 then
					var_309_2:EnableDynamicBone(false)
				end

				arg_306_1:ShowWeapon(var_309_1.transform, false)

				arg_306_1.var_["1089ui_story" .. "Animator"] = var_309_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_306_1.var_["1089ui_story" .. "Animator"].applyRootMotion = true
				arg_306_1.var_["1089ui_story" .. "LipSync"] = var_309_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_309_3 = arg_306_1.actors_["1089ui_story"].transform

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos1089ui_story = var_309_3.localPosition
			end

			local var_309_4 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 then
				var_309_3.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_306_1.time_ - 0) / var_309_4)
				var_309_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_309_3.position).x, (manager.ui.mainCamera.transform.position - var_309_3.position).y, (manager.ui.mainCamera.transform.position - var_309_3.position).z)
				var_309_3.localEulerAngles.z = 0
				var_309_3.localEulerAngles.x = 0
				var_309_3.localEulerAngles = var_309_3.localEulerAngles
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				var_309_3.localPosition = Vector3.New(0, -1.1, -6.17)
				var_309_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_309_3.position).x, (manager.ui.mainCamera.transform.position - var_309_3.position).y, (manager.ui.mainCamera.transform.position - var_309_3.position).z)
				var_309_3.localEulerAngles.z = 0
				var_309_3.localEulerAngles.x = 0
				var_309_3.localEulerAngles = var_309_3.localEulerAngles
			end

			local var_309_5 = arg_306_1.actors_["1089ui_story"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_5) and arg_306_1.var_.characterEffect1089ui_story == nil then
				arg_306_1.var_.characterEffect1089ui_story = var_309_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_6 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_6 and not isNil(var_309_5) then
				if arg_306_1.var_.characterEffect1089ui_story and not isNil(var_309_5) then
					arg_306_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= 0 + var_309_6 and arg_306_1.time_ < 0 + var_309_6 + arg_309_0 and not isNil(var_309_5) and arg_306_1.var_.characterEffect1089ui_story then
				arg_306_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_309_8 = 0
			local var_309_9 = 0.575

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_8 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_10 = arg_306_1:GetWordFromCfg(322062074)
				local var_309_11 = arg_306_1:FormatText(var_309_10.content)

				arg_306_1.text_.text = var_309_11

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_13 = 23 <= 0 and var_309_9 or var_309_9 * (utf8.len(var_309_11) / 23)

				if (23 <= 0 and var_309_9 or var_309_9 * (utf8.len(var_309_11) / 23)) > 0 and var_309_9 < var_309_13 then
					arg_306_1.talkMaxDuration = var_309_13

					if var_309_13 + var_309_8 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_13 + var_309_8
					end
				end

				arg_306_1.text_.text = var_309_11
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062074", "story_v_out_322062.awb") ~= 0 then
					local var_309_14 = manager.audio:GetVoiceLength("story_v_out_322062", "322062074", "story_v_out_322062.awb") / 1000

					if var_309_14 + var_309_8 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_14 + var_309_8
					end

					if var_309_10.prefab_name ~= "" and arg_306_1.actors_[var_309_10.prefab_name] ~= nil then
						local var_309_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_10.prefab_name].transform, "story_v_out_322062", "322062074", "story_v_out_322062.awb")

						arg_306_1:RecordAudio("322062074", var_309_15)
						arg_306_1:RecordAudio("322062074", var_309_15)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_322062", "322062074", "story_v_out_322062.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_322062", "322062074", "story_v_out_322062.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_16 = math.max(var_309_9, arg_306_1.talkMaxDuration)

			if var_309_8 <= arg_306_1.time_ and arg_306_1.time_ < var_309_8 + var_309_16 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_8) / var_309_16

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_8 + var_309_16 and arg_306_1.time_ < var_309_8 + var_309_16 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play322062075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 322062075
		arg_310_1.duration_ = 8.93

		local var_310_0 = {
			zh = 6.9,
			ja = 8.933
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play322062076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["1089ui_story"]) and arg_310_1.var_.characterEffect1089ui_story == nil then
				arg_310_1.var_.characterEffect1089ui_story = arg_310_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["1089ui_story"]) then
				if arg_310_1.var_.characterEffect1089ui_story and not isNil(arg_310_1.actors_["1089ui_story"]) then
					arg_310_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_310_1.time_ - 0) / var_313_0)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["1089ui_story"]) and arg_310_1.var_.characterEffect1089ui_story then
				arg_310_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_313_1 = 0
			local var_313_2 = 0.75

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_3 = arg_310_1:GetWordFromCfg(322062075)
				local var_313_4 = arg_310_1:FormatText(var_313_3.content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_6 = 30 <= 0 and var_313_2 or var_313_2 * (utf8.len(var_313_4) / 30)

				if (30 <= 0 and var_313_2 or var_313_2 * (utf8.len(var_313_4) / 30)) > 0 and var_313_2 < var_313_6 then
					arg_310_1.talkMaxDuration = var_313_6

					if var_313_6 + var_313_1 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_6 + var_313_1
					end
				end

				arg_310_1.text_.text = var_313_4
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062075", "story_v_out_322062.awb") ~= 0 then
					local var_313_7 = manager.audio:GetVoiceLength("story_v_out_322062", "322062075", "story_v_out_322062.awb") / 1000

					if var_313_7 + var_313_1 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_1
					end

					if var_313_3.prefab_name ~= "" and arg_310_1.actors_[var_313_3.prefab_name] ~= nil then
						local var_313_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_3.prefab_name].transform, "story_v_out_322062", "322062075", "story_v_out_322062.awb")

						arg_310_1:RecordAudio("322062075", var_313_8)
						arg_310_1:RecordAudio("322062075", var_313_8)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_322062", "322062075", "story_v_out_322062.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_322062", "322062075", "story_v_out_322062.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_9 = math.max(var_313_2, arg_310_1.talkMaxDuration)

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_9 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_1) / var_313_9

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_1 + var_313_9 and arg_310_1.time_ < var_313_1 + var_313_9 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play322062076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 322062076
		arg_314_1.duration_ = 6.9

		local var_314_0 = {
			zh = 5.933,
			ja = 6.9
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play322062077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["1089ui_story"]) and arg_314_1.var_.characterEffect1089ui_story == nil then
				arg_314_1.var_.characterEffect1089ui_story = arg_314_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_0 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["1089ui_story"]) then
				if arg_314_1.var_.characterEffect1089ui_story and not isNil(arg_314_1.actors_["1089ui_story"]) then
					arg_314_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["1089ui_story"]) and arg_314_1.var_.characterEffect1089ui_story then
				arg_314_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_2")
			end

			local var_317_2 = 0
			local var_317_3 = 0.625

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_2 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_4 = arg_314_1:GetWordFromCfg(322062076)
				local var_317_5 = arg_314_1:FormatText(var_317_4.content)

				arg_314_1.text_.text = var_317_5

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_7 = 25 <= 0 and var_317_3 or var_317_3 * (utf8.len(var_317_5) / 25)

				if (25 <= 0 and var_317_3 or var_317_3 * (utf8.len(var_317_5) / 25)) > 0 and var_317_3 < var_317_7 then
					arg_314_1.talkMaxDuration = var_317_7

					if var_317_7 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_7 + var_317_2
					end
				end

				arg_314_1.text_.text = var_317_5
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062076", "story_v_out_322062.awb") ~= 0 then
					local var_317_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062076", "story_v_out_322062.awb") / 1000

					if var_317_8 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_8 + var_317_2
					end

					if var_317_4.prefab_name ~= "" and arg_314_1.actors_[var_317_4.prefab_name] ~= nil then
						local var_317_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_4.prefab_name].transform, "story_v_out_322062", "322062076", "story_v_out_322062.awb")

						arg_314_1:RecordAudio("322062076", var_317_9)
						arg_314_1:RecordAudio("322062076", var_317_9)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_322062", "322062076", "story_v_out_322062.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_322062", "322062076", "story_v_out_322062.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_10 = math.max(var_317_3, arg_314_1.talkMaxDuration)

			if var_317_2 <= arg_314_1.time_ and arg_314_1.time_ < var_317_2 + var_317_10 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_2) / var_317_10

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_2 + var_317_10 and arg_314_1.time_ < var_317_2 + var_317_10 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play322062077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 322062077
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play322062078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1089ui_story = arg_318_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_321_0 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 then
				arg_318_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_318_1.time_ - 0) / var_321_0)
				arg_318_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1089ui_story"].transform.position).z)
				arg_318_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1089ui_story"].transform.localEulerAngles = arg_318_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 then
				arg_318_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_318_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_318_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_318_1.actors_["1089ui_story"].transform.position).z)
				arg_318_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_318_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_318_1.actors_["1089ui_story"].transform.localEulerAngles = arg_318_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_321_1 = 0
			local var_321_2 = 1.425

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_3 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(322062077).content)

				arg_318_1.text_.text = var_321_3

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 57 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_3) / 57)

				if (57 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_3) / 57)) > 0 and var_321_2 < var_321_5 then
					arg_318_1.talkMaxDuration = var_321_5

					if var_321_5 + var_321_1 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + var_321_1
					end
				end

				arg_318_1.text_.text = var_321_3
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_6 = math.max(var_321_2, arg_318_1.talkMaxDuration)

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_6 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_1) / var_321_6

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_1 + var_321_6 and arg_318_1.time_ < var_321_1 + var_321_6 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play322062078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 322062078
		arg_322_1.duration_ = 14.47

		local var_322_0 = {
			zh = 8.333,
			ja = 14.466
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play322062079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_9001
			local var_325_9000

			if arg_322_1.actors_["10103ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10103ui_story"))) then
				local var_325_0 = Object.Instantiate(Asset.Load("Char/" .. "10103ui_story"), arg_322_1.stage_.transform)

				var_325_0.name = "10103ui_story"
				var_325_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_322_1.actors_["10103ui_story"] = var_325_0

				local var_325_1 = var_325_0:GetComponentInChildren(typeof(CharacterEffect))

				var_325_1.enabled = true

				local var_325_2 = GameObjectTools.GetOrAddComponent(var_325_0, typeof(DynamicBoneHelper))

				if var_325_2 then
					var_325_2:EnableDynamicBone(false)
				end

				arg_322_1:ShowWeapon(var_325_1.transform, false)

				arg_322_1.var_["10103ui_story" .. "Animator"] = var_325_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_322_1.var_["10103ui_story" .. "Animator"].applyRootMotion = true
				arg_322_1.var_["10103ui_story" .. "LipSync"] = var_325_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_325_3 = arg_322_1.actors_["10103ui_story"].transform

			if 1.01666666666667 < arg_322_1.time_ and arg_322_1.time_ <= 1.01666666666667 + arg_325_0 then
				arg_322_1.var_.moveOldPos10103ui_story = var_325_3.localPosition

				local var_325_4 = GameObjectTools.GetOrAddComponent(var_325_3.gameObject, typeof(DynamicBoneHelper))

				if var_325_4 then
					var_325_4:EnableDynamicBone(false)
				end
			end

			local var_325_5 = 0.001

			if 1.01666666666667 <= arg_322_1.time_ and arg_322_1.time_ < 1.01666666666667 + var_325_5 then
				var_325_3.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10103ui_story, Vector3.New(0, -0.95, -6.2), (arg_322_1.time_ - 1.01666666666667) / var_325_5)
				var_325_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_325_3.position).x, (manager.ui.mainCamera.transform.position - var_325_3.position).y, (manager.ui.mainCamera.transform.position - var_325_3.position).z)
				var_325_3.localEulerAngles.z = 0
				var_325_3.localEulerAngles.x = 0
				var_325_3.localEulerAngles = var_325_3.localEulerAngles
			end

			if arg_322_1.time_ >= 1.01666666666667 + var_325_5 and arg_322_1.time_ < 1.01666666666667 + var_325_5 + arg_325_0 then
				var_325_3.localPosition = Vector3.New(0, -0.95, -6.2)
				var_325_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_325_3.position).x, (manager.ui.mainCamera.transform.position - var_325_3.position).y, (manager.ui.mainCamera.transform.position - var_325_3.position).z)
				var_325_3.localEulerAngles.z = 0
				var_325_3.localEulerAngles.x = 0
				var_325_3.localEulerAngles = var_325_3.localEulerAngles

				local var_325_6 = GameObjectTools.GetOrAddComponent(var_325_3.gameObject, typeof(DynamicBoneHelper))

				if var_325_6 then
					var_325_6:EnableDynamicBone(true)
				end
			end

			local var_325_7 = arg_322_1.actors_["10103ui_story"]

			if 1.01666666666667 < arg_322_1.time_ and arg_322_1.time_ <= 1.01666666666667 + arg_325_0 and not isNil(var_325_7) and arg_322_1.var_.characterEffect10103ui_story == nil then
				arg_322_1.var_.characterEffect10103ui_story = var_325_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_8 = 0.200000002980232

			if 1.01666666666667 <= arg_322_1.time_ and arg_322_1.time_ < 1.01666666666667 + var_325_8 and not isNil(var_325_7) then
				if arg_322_1.var_.characterEffect10103ui_story and not isNil(var_325_7) then
					arg_322_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= 1.01666666666667 + var_325_8 and arg_322_1.time_ < 1.01666666666667 + var_325_8 + arg_325_0 and not isNil(var_325_7) and arg_322_1.var_.characterEffect10103ui_story then
				arg_322_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 1.01666666666667 < arg_322_1.time_ and arg_322_1.time_ <= 1.01666666666667 + arg_325_0 then
				arg_322_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			if 1.01666666666667 < arg_322_1.time_ and arg_322_1.time_ <= 1.01666666666667 + arg_325_0 then
				arg_322_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 1.01666666666667 < arg_322_1.time_ and arg_322_1.time_ <= 1.01666666666667 + arg_325_0 then
				local var_325_10 = arg_322_1.var_.effect078

				if not arg_322_1.var_.effect078 then
					var_325_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_monitor"), manager.ui.mainCamera.transform)
					var_325_10.name = "078"
					arg_322_1.var_.effect078 = var_325_10
				else
					var_325_10.transform:SetParent(var_325_9001)
				end

				var_325_10.transform.localPosition = Vector3.New(0, 0, -3)
				var_325_10.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_325_12 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_325_13 = var_325_10.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_325_0, iter_325_1 in ipairs((var_325_13:ToTable())) do
					iter_325_1.transform.localScale = Vector3.New(iter_325_1.transform.localScale.x / var_325_12 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_325_13 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_325_1.transform.localScale.y / var_325_12, iter_325_1.transform.localScale.z)
				end
			end

			if 1 < arg_322_1.time_ and arg_322_1.time_ <= 1 + arg_325_0 then
				local var_325_15 = arg_322_1.var_.effect0781

				if not arg_322_1.var_.effect0781 then
					var_325_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), manager.ui.mainCamera.transform)
					var_325_15.name = "0781"
					arg_322_1.var_.effect0781 = var_325_15
				else
					var_325_15.transform:SetParent(var_325_9000)
				end

				var_325_15.transform.localPosition = Vector3.New(0, 0, -1)
				var_325_15.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_325_17 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_325_18 = var_325_15.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_325_2, iter_325_3 in ipairs((var_325_18:ToTable())) do
					iter_325_3.transform.localScale = Vector3.New(iter_325_3.transform.localScale.x / var_325_17 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_325_18 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_325_3.transform.localScale.y / var_325_17, iter_325_3.transform.localScale.z)
				end
			end

			if 1.01666666666667 < arg_322_1.time_ and arg_322_1.time_ <= 1.01666666666667 + arg_325_0 then
				if not isNil(arg_322_1.actors_["10103ui_story"]) then
					local var_325_20 = GameObjectTools.GetOrAddComponent(arg_322_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_325_20 then
						var_325_20:EnableDynamicBone(true)
					end
				end
			end

			local var_325_21 = 1

			arg_322_1.isInRecall_ = false

			if var_325_21 < arg_322_1.time_ and arg_322_1.time_ <= var_325_21 + arg_325_0 then
				arg_322_1.screenFilterGo_:SetActive(true)

				arg_322_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_blue.asset")

				for iter_325_4, iter_325_5 in pairs(arg_322_1.actors_) do
					for iter_325_6, iter_325_7 in ipairs((iter_325_5:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_325_7.color = iter_325_7.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_325_22 = 0.0166666666666667

			if var_325_21 <= arg_322_1.time_ and arg_322_1.time_ < var_325_21 + var_325_22 then
				arg_322_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_322_1.time_ - var_325_21) / var_325_22)
			end

			if arg_322_1.time_ >= var_325_21 + var_325_22 and arg_322_1.time_ < var_325_21 + var_325_22 + arg_325_0 then
				arg_322_1.screenFilterEffect_.weight = 1
			end

			local var_325_23 = 0

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_23 + arg_325_0 then
				arg_322_1.mask_.enabled = true
				arg_322_1.mask_.raycastTarget = true

				arg_322_1:SetGaussion(false)
			end

			local var_325_24 = 1

			if var_325_23 <= arg_322_1.time_ and arg_322_1.time_ < var_325_23 + var_325_24 then
				local var_325_25 = Color.New(0, 0, 0)

				var_325_25.a = Mathf.Lerp(0, 1, (arg_322_1.time_ - var_325_23) / var_325_24)
				arg_322_1.mask_.color = var_325_25
			end

			if arg_322_1.time_ >= var_325_23 + var_325_24 and arg_322_1.time_ < var_325_23 + var_325_24 + arg_325_0 then
				local var_325_26 = Color.New(0, 0, 0)

				var_325_26.a = 1
				arg_322_1.mask_.color = var_325_26
			end

			local var_325_27 = 1

			if 1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_27 + arg_325_0 then
				arg_322_1.mask_.enabled = true
				arg_322_1.mask_.raycastTarget = true

				arg_322_1:SetGaussion(false)
			end

			local var_325_28 = 1

			if var_325_27 <= arg_322_1.time_ and arg_322_1.time_ < var_325_27 + var_325_28 then
				local var_325_29 = Color.New(0, 0, 0)

				var_325_29.a = Mathf.Lerp(1, 0, (arg_322_1.time_ - var_325_27) / var_325_28)
				arg_322_1.mask_.color = var_325_29
			end

			if arg_322_1.time_ >= var_325_27 + var_325_28 and arg_322_1.time_ < var_325_27 + var_325_28 + arg_325_0 then
				local var_325_30 = Color.New(0, 0, 0)

				arg_322_1.mask_.enabled = false
				var_325_30.a = 0
				arg_322_1.mask_.color = var_325_30
			end

			local var_325_31 = "L01h"

			if arg_322_1.bgs_.L01h == nil then
				local var_325_32 = Object.Instantiate(arg_322_1.paintGo_)

				var_325_32:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_325_31)
				var_325_32.name = var_325_31
				var_325_32.transform.parent = arg_322_1.stage_.transform
				var_325_32.transform.localPosition = Vector3.New(0, 100, 0)
				arg_322_1.bgs_[var_325_31] = var_325_32
			end

			if 1 < arg_322_1.time_ and arg_322_1.time_ <= 1 + arg_325_0 then
				local var_325_33 = arg_322_1.bgs_.L01h

				arg_322_1.bgs_.L01h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_325_33.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_325_34 = var_325_33:GetComponent("SpriteRenderer")

				if var_325_34 and var_325_34.sprite then
					local var_325_35 = 2 * (var_325_33.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_325_33.transform.localScale = Vector3.New(var_325_35 / var_325_34.sprite.bounds.size.y < var_325_35 * manager.ui.mainCameraCom_.aspect / var_325_34.sprite.bounds.size.x and var_325_35 * manager.ui.mainCameraCom_.aspect / var_325_34.sprite.bounds.size.x or var_325_35 / var_325_34.sprite.bounds.size.y, var_325_35 / var_325_34.sprite.bounds.size.y < var_325_35 * manager.ui.mainCameraCom_.aspect / var_325_34.sprite.bounds.size.x and var_325_35 * manager.ui.mainCameraCom_.aspect / var_325_34.sprite.bounds.size.x or var_325_35 / var_325_34.sprite.bounds.size.y, 0)
				end

				for iter_325_8, iter_325_9 in pairs(arg_322_1.bgs_) do
					if iter_325_8 ~= "L01h" then
						iter_325_9.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_322_1.frameCnt_ <= 1 then
				arg_322_1.dialog_:SetActive(false)
			end

			local var_325_36 = 1.6
			local var_325_37 = 0.725

			if 1.6 < arg_322_1.time_ and arg_322_1.time_ <= var_325_36 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0

				arg_322_1.dialog_:SetActive(true)

				arg_322_1.dialogCg_.alpha = 0

				local var_325_38 = LeanTween.value(arg_322_1.dialog_, 0, 1, 0.3)

				var_325_38:setOnUpdate(LuaHelper.FloatAction(function(arg_326_0)
					arg_322_1.dialogCg_.alpha = arg_326_0
				end))
				var_325_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_322_1.dialog_)
					var_325_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_322_1.duration_ = arg_322_1.duration_ + 0.3

				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_39 = arg_322_1:GetWordFromCfg(322062078)
				local var_325_40 = arg_322_1:FormatText(var_325_39.content)

				arg_322_1.text_.text = var_325_40

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_42 = 29 <= 0 and var_325_37 or var_325_37 * (utf8.len(var_325_40) / 29)

				if (29 <= 0 and var_325_37 or var_325_37 * (utf8.len(var_325_40) / 29)) > 0 and var_325_37 < var_325_42 then
					arg_322_1.talkMaxDuration = var_325_42
					var_325_36 = var_325_36 + 0.3

					if var_325_42 + var_325_36 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_42 + var_325_36
					end
				end

				arg_322_1.text_.text = var_325_40
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062078", "story_v_out_322062.awb") ~= 0 then
					local var_325_43 = manager.audio:GetVoiceLength("story_v_out_322062", "322062078", "story_v_out_322062.awb") / 1000

					if var_325_43 + var_325_36 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_43 + var_325_36
					end

					if var_325_39.prefab_name ~= "" and arg_322_1.actors_[var_325_39.prefab_name] ~= nil then
						local var_325_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_39.prefab_name].transform, "story_v_out_322062", "322062078", "story_v_out_322062.awb")

						arg_322_1:RecordAudio("322062078", var_325_44)
						arg_322_1:RecordAudio("322062078", var_325_44)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_322062", "322062078", "story_v_out_322062.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_322062", "322062078", "story_v_out_322062.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_45 = var_325_36 + 0.3
			local var_325_46 = math.max(var_325_37, arg_322_1.talkMaxDuration)

			if var_325_36 + 0.3 <= arg_322_1.time_ and arg_322_1.time_ < var_325_45 + var_325_46 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_45) / var_325_46

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_45 + var_325_46 and arg_322_1.time_ < var_325_45 + var_325_46 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play322062079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 322062079
		arg_328_1.duration_ = 24.17

		local var_328_0 = {
			zh = 13.366,
			ja = 24.166
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
				arg_328_0:Play322062080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 1.525

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_1 = arg_328_1:GetWordFromCfg(322062079)
				local var_331_2 = arg_328_1:FormatText(var_331_1.content)

				arg_328_1.text_.text = var_331_2

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_4 = 61 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 61)

				if (61 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_2) / 61)) > 0 and var_331_0 < var_331_4 then
					arg_328_1.talkMaxDuration = var_331_4

					if var_331_4 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_4 + 0
					end
				end

				arg_328_1.text_.text = var_331_2
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062079", "story_v_out_322062.awb") ~= 0 then
					local var_331_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062079", "story_v_out_322062.awb") / 1000

					if var_331_5 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_5 + 0
					end

					if var_331_1.prefab_name ~= "" and arg_328_1.actors_[var_331_1.prefab_name] ~= nil then
						local var_331_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_1.prefab_name].transform, "story_v_out_322062", "322062079", "story_v_out_322062.awb")

						arg_328_1:RecordAudio("322062079", var_331_6)
						arg_328_1:RecordAudio("322062079", var_331_6)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_322062", "322062079", "story_v_out_322062.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_322062", "322062079", "story_v_out_322062.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_7 = math.max(var_331_0, arg_328_1.talkMaxDuration)

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_7 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - 0) / var_331_7

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= 0 + var_331_7 and arg_328_1.time_ < 0 + var_331_7 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play322062080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 322062080
		arg_332_1.duration_ = 24.6

		local var_332_0 = {
			zh = 11,
			ja = 24.6
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
				arg_332_0:Play322062081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_1")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				if not isNil(arg_332_1.actors_["10103ui_story"]) then
					local var_335_0 = GameObjectTools.GetOrAddComponent(arg_332_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_335_0 then
						var_335_0:EnableDynamicBone(true)
					end
				end
			end

			local var_335_1 = 0
			local var_335_2 = 1.2

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_3 = arg_332_1:GetWordFromCfg(322062080)
				local var_335_4 = arg_332_1:FormatText(var_335_3.content)

				arg_332_1.text_.text = var_335_4

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_6 = 48 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_4) / 48)

				if (48 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_4) / 48)) > 0 and var_335_2 < var_335_6 then
					arg_332_1.talkMaxDuration = var_335_6

					if var_335_6 + var_335_1 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_6 + var_335_1
					end
				end

				arg_332_1.text_.text = var_335_4
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062080", "story_v_out_322062.awb") ~= 0 then
					local var_335_7 = manager.audio:GetVoiceLength("story_v_out_322062", "322062080", "story_v_out_322062.awb") / 1000

					if var_335_7 + var_335_1 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_1
					end

					if var_335_3.prefab_name ~= "" and arg_332_1.actors_[var_335_3.prefab_name] ~= nil then
						local var_335_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_3.prefab_name].transform, "story_v_out_322062", "322062080", "story_v_out_322062.awb")

						arg_332_1:RecordAudio("322062080", var_335_8)
						arg_332_1:RecordAudio("322062080", var_335_8)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_322062", "322062080", "story_v_out_322062.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_322062", "322062080", "story_v_out_322062.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_9 = math.max(var_335_2, arg_332_1.talkMaxDuration)

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_9 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_1) / var_335_9

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_1 + var_335_9 and arg_332_1.time_ < var_335_1 + var_335_9 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play322062081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 322062081
		arg_336_1.duration_ = 5.93

		local var_336_0 = {
			zh = 4.666,
			ja = 5.933
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
				arg_336_0:Play322062082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(arg_336_1.actors_["10103ui_story"]) and arg_336_1.var_.characterEffect10103ui_story == nil then
				arg_336_1.var_.characterEffect10103ui_story = arg_336_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_0 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 and not isNil(arg_336_1.actors_["10103ui_story"]) then
				if arg_336_1.var_.characterEffect10103ui_story and not isNil(arg_336_1.actors_["10103ui_story"]) then
					arg_336_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_336_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_336_1.time_ - 0) / var_339_0)
				end
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 and not isNil(arg_336_1.actors_["10103ui_story"]) and arg_336_1.var_.characterEffect10103ui_story then
				arg_336_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_336_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			local var_339_1 = 0
			local var_339_2 = 0.525

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_3 = arg_336_1:GetWordFromCfg(322062081)
				local var_339_4 = arg_336_1:FormatText(var_339_3.content)

				arg_336_1.text_.text = var_339_4

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_6 = 21 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_4) / 21)

				if (21 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_4) / 21)) > 0 and var_339_2 < var_339_6 then
					arg_336_1.talkMaxDuration = var_339_6

					if var_339_6 + var_339_1 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_6 + var_339_1
					end
				end

				arg_336_1.text_.text = var_339_4
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062081", "story_v_out_322062.awb") ~= 0 then
					local var_339_7 = manager.audio:GetVoiceLength("story_v_out_322062", "322062081", "story_v_out_322062.awb") / 1000

					if var_339_7 + var_339_1 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_1
					end

					if var_339_3.prefab_name ~= "" and arg_336_1.actors_[var_339_3.prefab_name] ~= nil then
						local var_339_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_3.prefab_name].transform, "story_v_out_322062", "322062081", "story_v_out_322062.awb")

						arg_336_1:RecordAudio("322062081", var_339_8)
						arg_336_1:RecordAudio("322062081", var_339_8)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_322062", "322062081", "story_v_out_322062.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_322062", "322062081", "story_v_out_322062.awb")
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
	Play322062082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 322062082
		arg_340_1.duration_ = 12.03

		local var_340_0 = {
			zh = 10.2,
			ja = 12.033
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
				arg_340_0:Play322062083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["10103ui_story"]) and arg_340_1.var_.characterEffect10103ui_story == nil then
				arg_340_1.var_.characterEffect10103ui_story = arg_340_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_0 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["10103ui_story"]) then
				if arg_340_1.var_.characterEffect10103ui_story and not isNil(arg_340_1.actors_["10103ui_story"]) then
					arg_340_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["10103ui_story"]) and arg_340_1.var_.characterEffect10103ui_story then
				arg_340_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				if not isNil(arg_340_1.actors_["10103ui_story"]) then
					local var_343_2 = GameObjectTools.GetOrAddComponent(arg_340_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_343_2 then
						var_343_2:EnableDynamicBone(true)
					end
				end
			end

			local var_343_3 = 0
			local var_343_4 = 1.05

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_3 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_5 = arg_340_1:GetWordFromCfg(322062082)
				local var_343_6 = arg_340_1:FormatText(var_343_5.content)

				arg_340_1.text_.text = var_343_6

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_8 = 42 <= 0 and var_343_4 or var_343_4 * (utf8.len(var_343_6) / 42)

				if (42 <= 0 and var_343_4 or var_343_4 * (utf8.len(var_343_6) / 42)) > 0 and var_343_4 < var_343_8 then
					arg_340_1.talkMaxDuration = var_343_8

					if var_343_8 + var_343_3 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_8 + var_343_3
					end
				end

				arg_340_1.text_.text = var_343_6
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062082", "story_v_out_322062.awb") ~= 0 then
					local var_343_9 = manager.audio:GetVoiceLength("story_v_out_322062", "322062082", "story_v_out_322062.awb") / 1000

					if var_343_9 + var_343_3 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_9 + var_343_3
					end

					if var_343_5.prefab_name ~= "" and arg_340_1.actors_[var_343_5.prefab_name] ~= nil then
						local var_343_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_5.prefab_name].transform, "story_v_out_322062", "322062082", "story_v_out_322062.awb")

						arg_340_1:RecordAudio("322062082", var_343_10)
						arg_340_1:RecordAudio("322062082", var_343_10)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_322062", "322062082", "story_v_out_322062.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_322062", "322062082", "story_v_out_322062.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_11 = math.max(var_343_4, arg_340_1.talkMaxDuration)

			if var_343_3 <= arg_340_1.time_ and arg_340_1.time_ < var_343_3 + var_343_11 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_3) / var_343_11

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_3 + var_343_11 and arg_340_1.time_ < var_343_3 + var_343_11 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play322062083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 322062083
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play322062084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos10103ui_story = arg_344_1.actors_["10103ui_story"].transform.localPosition

				local var_347_0 = GameObjectTools.GetOrAddComponent(arg_344_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_347_0 then
					var_347_0:EnableDynamicBone(false)
				end
			end

			local var_347_1 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_1 then
				arg_344_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_344_1.time_ - 0) / var_347_1)
				arg_344_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_344_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["10103ui_story"].transform.position).z)
				arg_344_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_344_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_344_1.actors_["10103ui_story"].transform.localEulerAngles = arg_344_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_344_1.time_ >= 0 + var_347_1 and arg_344_1.time_ < 0 + var_347_1 + arg_347_0 then
				arg_344_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_344_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_344_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_344_1.actors_["10103ui_story"].transform.position).z)
				arg_344_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_344_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_344_1.actors_["10103ui_story"].transform.localEulerAngles = arg_344_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_347_2 = GameObjectTools.GetOrAddComponent(arg_344_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_347_2 then
					var_347_2:EnableDynamicBone(true)
				end
			end

			local var_347_3 = 0
			local var_347_4 = 1.4

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_3 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_5 = arg_344_1:FormatText(arg_344_1:GetWordFromCfg(322062083).content)

				arg_344_1.text_.text = var_347_5

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_7 = 56 <= 0 and var_347_4 or var_347_4 * (utf8.len(var_347_5) / 56)

				if (56 <= 0 and var_347_4 or var_347_4 * (utf8.len(var_347_5) / 56)) > 0 and var_347_4 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_3 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_3
					end
				end

				arg_344_1.text_.text = var_347_5
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_8 = math.max(var_347_4, arg_344_1.talkMaxDuration)

			if var_347_3 <= arg_344_1.time_ and arg_344_1.time_ < var_347_3 + var_347_8 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_3) / var_347_8

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_3 + var_347_8 and arg_344_1.time_ < var_347_3 + var_347_8 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play322062084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 322062084
		arg_348_1.duration_ = 2.77

		local var_348_0 = {
			zh = 2.1,
			ja = 2.766
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
				arg_348_0:Play322062085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.25

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_1 = arg_348_1:GetWordFromCfg(322062084)
				local var_351_2 = arg_348_1:FormatText(var_351_1.content)

				arg_348_1.text_.text = var_351_2

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 10 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 10)

				if (10 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 10)) > 0 and var_351_0 < var_351_4 then
					arg_348_1.talkMaxDuration = var_351_4

					if var_351_4 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_4 + 0
					end
				end

				arg_348_1.text_.text = var_351_2
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062084", "story_v_out_322062.awb") ~= 0 then
					local var_351_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062084", "story_v_out_322062.awb") / 1000

					if var_351_5 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + 0
					end

					if var_351_1.prefab_name ~= "" and arg_348_1.actors_[var_351_1.prefab_name] ~= nil then
						local var_351_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_1.prefab_name].transform, "story_v_out_322062", "322062084", "story_v_out_322062.awb")

						arg_348_1:RecordAudio("322062084", var_351_6)
						arg_348_1:RecordAudio("322062084", var_351_6)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_322062", "322062084", "story_v_out_322062.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_322062", "322062084", "story_v_out_322062.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_7 and arg_348_1.time_ < 0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play322062085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 322062085
		arg_352_1.duration_ = 10.1

		local var_352_0 = {
			zh = 3.7,
			ja = 10.1
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play322062086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos10103ui_story = arg_352_1.actors_["10103ui_story"].transform.localPosition

				local var_355_0 = GameObjectTools.GetOrAddComponent(arg_352_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_355_0 then
					var_355_0:EnableDynamicBone(false)
				end
			end

			local var_355_1 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_1 then
				arg_352_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos10103ui_story, Vector3.New(0, -0.95, -6.2), (arg_352_1.time_ - 0) / var_355_1)
				arg_352_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["10103ui_story"].transform.position).z)
				arg_352_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["10103ui_story"].transform.localEulerAngles = arg_352_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_352_1.time_ >= 0 + var_355_1 and arg_352_1.time_ < 0 + var_355_1 + arg_355_0 then
				arg_352_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.2)
				arg_352_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_352_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_352_1.actors_["10103ui_story"].transform.position).z)
				arg_352_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_352_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_352_1.actors_["10103ui_story"].transform.localEulerAngles = arg_352_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_355_2 = GameObjectTools.GetOrAddComponent(arg_352_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_355_2 then
					var_355_2:EnableDynamicBone(true)
				end
			end

			local var_355_3 = arg_352_1.actors_["10103ui_story"]

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(var_355_3) and arg_352_1.var_.characterEffect10103ui_story == nil then
				arg_352_1.var_.characterEffect10103ui_story = var_355_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_4 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_4 and not isNil(var_355_3) then
				if arg_352_1.var_.characterEffect10103ui_story and not isNil(var_355_3) then
					arg_352_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= 0 + var_355_4 and arg_352_1.time_ < 0 + var_355_4 + arg_355_0 and not isNil(var_355_3) and arg_352_1.var_.characterEffect10103ui_story then
				arg_352_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				if not isNil(arg_352_1.actors_["10103ui_story"]) then
					local var_355_6 = GameObjectTools.GetOrAddComponent(arg_352_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_355_6 then
						var_355_6:EnableDynamicBone(true)
					end
				end
			end

			local var_355_7 = 0
			local var_355_8 = 0.4

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_7 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_9 = arg_352_1:GetWordFromCfg(322062085)
				local var_355_10 = arg_352_1:FormatText(var_355_9.content)

				arg_352_1.text_.text = var_355_10

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_12 = 16 <= 0 and var_355_8 or var_355_8 * (utf8.len(var_355_10) / 16)

				if (16 <= 0 and var_355_8 or var_355_8 * (utf8.len(var_355_10) / 16)) > 0 and var_355_8 < var_355_12 then
					arg_352_1.talkMaxDuration = var_355_12

					if var_355_12 + var_355_7 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_12 + var_355_7
					end
				end

				arg_352_1.text_.text = var_355_10
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062085", "story_v_out_322062.awb") ~= 0 then
					local var_355_13 = manager.audio:GetVoiceLength("story_v_out_322062", "322062085", "story_v_out_322062.awb") / 1000

					if var_355_13 + var_355_7 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_13 + var_355_7
					end

					if var_355_9.prefab_name ~= "" and arg_352_1.actors_[var_355_9.prefab_name] ~= nil then
						local var_355_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_9.prefab_name].transform, "story_v_out_322062", "322062085", "story_v_out_322062.awb")

						arg_352_1:RecordAudio("322062085", var_355_14)
						arg_352_1:RecordAudio("322062085", var_355_14)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_322062", "322062085", "story_v_out_322062.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_322062", "322062085", "story_v_out_322062.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_15 = math.max(var_355_8, arg_352_1.talkMaxDuration)

			if var_355_7 <= arg_352_1.time_ and arg_352_1.time_ < var_355_7 + var_355_15 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_7) / var_355_15

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_7 + var_355_15 and arg_352_1.time_ < var_355_7 + var_355_15 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play322062086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 322062086
		arg_356_1.duration_ = 6.27

		local var_356_0 = {
			zh = 3.433,
			ja = 6.266
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play322062087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(arg_356_1.actors_["10103ui_story"]) and arg_356_1.var_.characterEffect10103ui_story == nil then
				arg_356_1.var_.characterEffect10103ui_story = arg_356_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_0 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 and not isNil(arg_356_1.actors_["10103ui_story"]) then
				if arg_356_1.var_.characterEffect10103ui_story and not isNil(arg_356_1.actors_["10103ui_story"]) then
					arg_356_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_356_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_356_1.time_ - 0) / var_359_0)
				end
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 and not isNil(arg_356_1.actors_["10103ui_story"]) and arg_356_1.var_.characterEffect10103ui_story then
				arg_356_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_356_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			local var_359_1 = 0
			local var_359_2 = 0.375

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_1 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_3 = arg_356_1:GetWordFromCfg(322062086)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_6 = 15 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_4) / 15)

				if (15 <= 0 and var_359_2 or var_359_2 * (utf8.len(var_359_4) / 15)) > 0 and var_359_2 < var_359_6 then
					arg_356_1.talkMaxDuration = var_359_6

					if var_359_6 + var_359_1 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_6 + var_359_1
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062086", "story_v_out_322062.awb") ~= 0 then
					local var_359_7 = manager.audio:GetVoiceLength("story_v_out_322062", "322062086", "story_v_out_322062.awb") / 1000

					if var_359_7 + var_359_1 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_1
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_322062", "322062086", "story_v_out_322062.awb")

						arg_356_1:RecordAudio("322062086", var_359_8)
						arg_356_1:RecordAudio("322062086", var_359_8)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_322062", "322062086", "story_v_out_322062.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_322062", "322062086", "story_v_out_322062.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_9 = math.max(var_359_2, arg_356_1.talkMaxDuration)

			if var_359_1 <= arg_356_1.time_ and arg_356_1.time_ < var_359_1 + var_359_9 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_1) / var_359_9

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_1 + var_359_9 and arg_356_1.time_ < var_359_1 + var_359_9 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play322062087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 322062087
		arg_360_1.duration_ = 2.97

		local var_360_0 = {
			zh = 2.966,
			ja = 2.833
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play322062088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(arg_360_1.actors_["10103ui_story"]) and arg_360_1.var_.characterEffect10103ui_story == nil then
				arg_360_1.var_.characterEffect10103ui_story = arg_360_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_0 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 and not isNil(arg_360_1.actors_["10103ui_story"]) then
				if arg_360_1.var_.characterEffect10103ui_story and not isNil(arg_360_1.actors_["10103ui_story"]) then
					arg_360_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 and not isNil(arg_360_1.actors_["10103ui_story"]) and arg_360_1.var_.characterEffect10103ui_story then
				arg_360_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action4_1")
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				if not isNil(arg_360_1.actors_["10103ui_story"]) then
					local var_363_2 = GameObjectTools.GetOrAddComponent(arg_360_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_363_2 then
						var_363_2:EnableDynamicBone(true)
					end
				end
			end

			local var_363_3 = 0
			local var_363_4 = 0.275

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_3 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_5 = arg_360_1:GetWordFromCfg(322062087)
				local var_363_6 = arg_360_1:FormatText(var_363_5.content)

				arg_360_1.text_.text = var_363_6

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_8 = 11 <= 0 and var_363_4 or var_363_4 * (utf8.len(var_363_6) / 11)

				if (11 <= 0 and var_363_4 or var_363_4 * (utf8.len(var_363_6) / 11)) > 0 and var_363_4 < var_363_8 then
					arg_360_1.talkMaxDuration = var_363_8

					if var_363_8 + var_363_3 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_8 + var_363_3
					end
				end

				arg_360_1.text_.text = var_363_6
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062087", "story_v_out_322062.awb") ~= 0 then
					local var_363_9 = manager.audio:GetVoiceLength("story_v_out_322062", "322062087", "story_v_out_322062.awb") / 1000

					if var_363_9 + var_363_3 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_9 + var_363_3
					end

					if var_363_5.prefab_name ~= "" and arg_360_1.actors_[var_363_5.prefab_name] ~= nil then
						local var_363_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_5.prefab_name].transform, "story_v_out_322062", "322062087", "story_v_out_322062.awb")

						arg_360_1:RecordAudio("322062087", var_363_10)
						arg_360_1:RecordAudio("322062087", var_363_10)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_322062", "322062087", "story_v_out_322062.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_322062", "322062087", "story_v_out_322062.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_11 = math.max(var_363_4, arg_360_1.talkMaxDuration)

			if var_363_3 <= arg_360_1.time_ and arg_360_1.time_ < var_363_3 + var_363_11 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_3) / var_363_11

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_3 + var_363_11 and arg_360_1.time_ < var_363_3 + var_363_11 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play322062088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 322062088
		arg_364_1.duration_ = 6.5

		local var_364_0 = {
			zh = 3.766,
			ja = 6.5
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play322062089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(arg_364_1.actors_["10103ui_story"]) and arg_364_1.var_.characterEffect10103ui_story == nil then
				arg_364_1.var_.characterEffect10103ui_story = arg_364_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_0 = 0.200000002980232

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 and not isNil(arg_364_1.actors_["10103ui_story"]) then
				if arg_364_1.var_.characterEffect10103ui_story and not isNil(arg_364_1.actors_["10103ui_story"]) then
					arg_364_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_364_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_364_1.time_ - 0) / var_367_0)
				end
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 and not isNil(arg_364_1.actors_["10103ui_story"]) and arg_364_1.var_.characterEffect10103ui_story then
				arg_364_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_364_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			local var_367_1 = 0
			local var_367_2 = 0.4

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_3 = arg_364_1:GetWordFromCfg(322062088)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_6 = 16 <= 0 and var_367_2 or var_367_2 * (utf8.len(var_367_4) / 16)

				if (16 <= 0 and var_367_2 or var_367_2 * (utf8.len(var_367_4) / 16)) > 0 and var_367_2 < var_367_6 then
					arg_364_1.talkMaxDuration = var_367_6

					if var_367_6 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_6 + var_367_1
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062088", "story_v_out_322062.awb") ~= 0 then
					local var_367_7 = manager.audio:GetVoiceLength("story_v_out_322062", "322062088", "story_v_out_322062.awb") / 1000

					if var_367_7 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_1
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_322062", "322062088", "story_v_out_322062.awb")

						arg_364_1:RecordAudio("322062088", var_367_8)
						arg_364_1:RecordAudio("322062088", var_367_8)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_322062", "322062088", "story_v_out_322062.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_322062", "322062088", "story_v_out_322062.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_9 = math.max(var_367_2, arg_364_1.talkMaxDuration)

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_9 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_1) / var_367_9

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_1 + var_367_9 and arg_364_1.time_ < var_367_1 + var_367_9 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play322062089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 322062089
		arg_368_1.duration_ = 2.2

		local var_368_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play322062090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(arg_368_1.actors_["10103ui_story"]) and arg_368_1.var_.characterEffect10103ui_story == nil then
				arg_368_1.var_.characterEffect10103ui_story = arg_368_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_0 = 0.200000002980232

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 and not isNil(arg_368_1.actors_["10103ui_story"]) then
				if arg_368_1.var_.characterEffect10103ui_story and not isNil(arg_368_1.actors_["10103ui_story"]) then
					arg_368_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 and not isNil(arg_368_1.actors_["10103ui_story"]) and arg_368_1.var_.characterEffect10103ui_story then
				arg_368_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103actionlink/10103action448")
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				if not isNil(arg_368_1.actors_["10103ui_story"]) then
					local var_371_2 = GameObjectTools.GetOrAddComponent(arg_368_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_371_2 then
						var_371_2:EnableDynamicBone(true)
					end
				end
			end

			local var_371_3 = 0
			local var_371_4 = 0.05

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_3 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_5 = arg_368_1:GetWordFromCfg(322062089)
				local var_371_6 = arg_368_1:FormatText(var_371_5.content)

				arg_368_1.text_.text = var_371_6

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_8 = 2 <= 0 and var_371_4 or var_371_4 * (utf8.len(var_371_6) / 2)

				if (2 <= 0 and var_371_4 or var_371_4 * (utf8.len(var_371_6) / 2)) > 0 and var_371_4 < var_371_8 then
					arg_368_1.talkMaxDuration = var_371_8

					if var_371_8 + var_371_3 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_3
					end
				end

				arg_368_1.text_.text = var_371_6
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062089", "story_v_out_322062.awb") ~= 0 then
					local var_371_9 = manager.audio:GetVoiceLength("story_v_out_322062", "322062089", "story_v_out_322062.awb") / 1000

					if var_371_9 + var_371_3 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_9 + var_371_3
					end

					if var_371_5.prefab_name ~= "" and arg_368_1.actors_[var_371_5.prefab_name] ~= nil then
						local var_371_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_5.prefab_name].transform, "story_v_out_322062", "322062089", "story_v_out_322062.awb")

						arg_368_1:RecordAudio("322062089", var_371_10)
						arg_368_1:RecordAudio("322062089", var_371_10)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_322062", "322062089", "story_v_out_322062.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_322062", "322062089", "story_v_out_322062.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_11 = math.max(var_371_4, arg_368_1.talkMaxDuration)

			if var_371_3 <= arg_368_1.time_ and arg_368_1.time_ < var_371_3 + var_371_11 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_3) / var_371_11

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_3 + var_371_11 and arg_368_1.time_ < var_371_3 + var_371_11 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play322062090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 322062090
		arg_372_1.duration_ = 6.5

		local var_372_0 = {
			zh = 3.733,
			ja = 6.5
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play322062091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["10103ui_story"]) and arg_372_1.var_.characterEffect10103ui_story == nil then
				arg_372_1.var_.characterEffect10103ui_story = arg_372_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_0 = 0.200000002980232

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["10103ui_story"]) then
				if arg_372_1.var_.characterEffect10103ui_story and not isNil(arg_372_1.actors_["10103ui_story"]) then
					arg_372_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_372_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_372_1.time_ - 0) / var_375_0)
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["10103ui_story"]) and arg_372_1.var_.characterEffect10103ui_story then
				arg_372_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_372_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			local var_375_1 = 0
			local var_375_2 = 0.325

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_3 = arg_372_1:GetWordFromCfg(322062090)
				local var_375_4 = arg_372_1:FormatText(var_375_3.content)

				arg_372_1.text_.text = var_375_4

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_6 = 13 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_4) / 13)

				if (13 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_4) / 13)) > 0 and var_375_2 < var_375_6 then
					arg_372_1.talkMaxDuration = var_375_6

					if var_375_6 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_6 + var_375_1
					end
				end

				arg_372_1.text_.text = var_375_4
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062090", "story_v_out_322062.awb") ~= 0 then
					local var_375_7 = manager.audio:GetVoiceLength("story_v_out_322062", "322062090", "story_v_out_322062.awb") / 1000

					if var_375_7 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_7 + var_375_1
					end

					if var_375_3.prefab_name ~= "" and arg_372_1.actors_[var_375_3.prefab_name] ~= nil then
						local var_375_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_3.prefab_name].transform, "story_v_out_322062", "322062090", "story_v_out_322062.awb")

						arg_372_1:RecordAudio("322062090", var_375_8)
						arg_372_1:RecordAudio("322062090", var_375_8)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_322062", "322062090", "story_v_out_322062.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_322062", "322062090", "story_v_out_322062.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_9 = math.max(var_375_2, arg_372_1.talkMaxDuration)

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_9 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_1) / var_375_9

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_1 + var_375_9 and arg_372_1.time_ < var_375_1 + var_375_9 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play322062091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 322062091
		arg_376_1.duration_ = 5.3

		local var_376_0 = {
			zh = 2.833,
			ja = 5.3
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play322062092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["10103ui_story"]) and arg_376_1.var_.characterEffect10103ui_story == nil then
				arg_376_1.var_.characterEffect10103ui_story = arg_376_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_0 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["10103ui_story"]) then
				if arg_376_1.var_.characterEffect10103ui_story and not isNil(arg_376_1.actors_["10103ui_story"]) then
					arg_376_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["10103ui_story"]) and arg_376_1.var_.characterEffect10103ui_story then
				arg_376_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				if not isNil(arg_376_1.actors_["10103ui_story"]) then
					local var_379_2 = GameObjectTools.GetOrAddComponent(arg_376_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_379_2 then
						var_379_2:EnableDynamicBone(true)
					end
				end
			end

			local var_379_3 = 0
			local var_379_4 = 0.25

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_3 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_5 = arg_376_1:GetWordFromCfg(322062091)
				local var_379_6 = arg_376_1:FormatText(var_379_5.content)

				arg_376_1.text_.text = var_379_6

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_8 = 10 <= 0 and var_379_4 or var_379_4 * (utf8.len(var_379_6) / 10)

				if (10 <= 0 and var_379_4 or var_379_4 * (utf8.len(var_379_6) / 10)) > 0 and var_379_4 < var_379_8 then
					arg_376_1.talkMaxDuration = var_379_8

					if var_379_8 + var_379_3 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_3
					end
				end

				arg_376_1.text_.text = var_379_6
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062091", "story_v_out_322062.awb") ~= 0 then
					local var_379_9 = manager.audio:GetVoiceLength("story_v_out_322062", "322062091", "story_v_out_322062.awb") / 1000

					if var_379_9 + var_379_3 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_9 + var_379_3
					end

					if var_379_5.prefab_name ~= "" and arg_376_1.actors_[var_379_5.prefab_name] ~= nil then
						local var_379_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_5.prefab_name].transform, "story_v_out_322062", "322062091", "story_v_out_322062.awb")

						arg_376_1:RecordAudio("322062091", var_379_10)
						arg_376_1:RecordAudio("322062091", var_379_10)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_322062", "322062091", "story_v_out_322062.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_322062", "322062091", "story_v_out_322062.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_11 = math.max(var_379_4, arg_376_1.talkMaxDuration)

			if var_379_3 <= arg_376_1.time_ and arg_376_1.time_ < var_379_3 + var_379_11 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_3) / var_379_11

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_3 + var_379_11 and arg_376_1.time_ < var_379_3 + var_379_11 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play322062092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 322062092
		arg_380_1.duration_ = 1.6

		local var_380_0 = {
			zh = 1.533,
			ja = 1.6
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play322062093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["10103ui_story"]) and arg_380_1.var_.characterEffect10103ui_story == nil then
				arg_380_1.var_.characterEffect10103ui_story = arg_380_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_0 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["10103ui_story"]) then
				if arg_380_1.var_.characterEffect10103ui_story and not isNil(arg_380_1.actors_["10103ui_story"]) then
					arg_380_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_380_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_380_1.time_ - 0) / var_383_0)
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["10103ui_story"]) and arg_380_1.var_.characterEffect10103ui_story then
				arg_380_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_380_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			local var_383_1 = 0
			local var_383_2 = 0.175

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:GetWordFromCfg(322062092)
				local var_383_4 = arg_380_1:FormatText(var_383_3.content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_6 = 7 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_4) / 7)

				if (7 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_4) / 7)) > 0 and var_383_2 < var_383_6 then
					arg_380_1.talkMaxDuration = var_383_6

					if var_383_6 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_6 + var_383_1
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062092", "story_v_out_322062.awb") ~= 0 then
					local var_383_7 = manager.audio:GetVoiceLength("story_v_out_322062", "322062092", "story_v_out_322062.awb") / 1000

					if var_383_7 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_1
					end

					if var_383_3.prefab_name ~= "" and arg_380_1.actors_[var_383_3.prefab_name] ~= nil then
						local var_383_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_3.prefab_name].transform, "story_v_out_322062", "322062092", "story_v_out_322062.awb")

						arg_380_1:RecordAudio("322062092", var_383_8)
						arg_380_1:RecordAudio("322062092", var_383_8)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_322062", "322062092", "story_v_out_322062.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_322062", "322062092", "story_v_out_322062.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_9 = math.max(var_383_2, arg_380_1.talkMaxDuration)

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_9 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_1) / var_383_9

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_1 + var_383_9 and arg_380_1.time_ < var_383_1 + var_383_9 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play322062093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 322062093
		arg_384_1.duration_ = 2.37

		local var_384_0 = {
			zh = 1.666,
			ja = 2.366
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play322062094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(arg_384_1.actors_["10103ui_story"]) and arg_384_1.var_.characterEffect10103ui_story == nil then
				arg_384_1.var_.characterEffect10103ui_story = arg_384_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_0 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 and not isNil(arg_384_1.actors_["10103ui_story"]) then
				if arg_384_1.var_.characterEffect10103ui_story and not isNil(arg_384_1.actors_["10103ui_story"]) then
					arg_384_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 and not isNil(arg_384_1.actors_["10103ui_story"]) and arg_384_1.var_.characterEffect10103ui_story then
				arg_384_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_387_2 = 0
			local var_387_3 = 0.15

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_2 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_4 = arg_384_1:GetWordFromCfg(322062093)
				local var_387_5 = arg_384_1:FormatText(var_387_4.content)

				arg_384_1.text_.text = var_387_5

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_7 = 6 <= 0 and var_387_3 or var_387_3 * (utf8.len(var_387_5) / 6)

				if (6 <= 0 and var_387_3 or var_387_3 * (utf8.len(var_387_5) / 6)) > 0 and var_387_3 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_2 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_2
					end
				end

				arg_384_1.text_.text = var_387_5
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062093", "story_v_out_322062.awb") ~= 0 then
					local var_387_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062093", "story_v_out_322062.awb") / 1000

					if var_387_8 + var_387_2 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_8 + var_387_2
					end

					if var_387_4.prefab_name ~= "" and arg_384_1.actors_[var_387_4.prefab_name] ~= nil then
						local var_387_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_4.prefab_name].transform, "story_v_out_322062", "322062093", "story_v_out_322062.awb")

						arg_384_1:RecordAudio("322062093", var_387_9)
						arg_384_1:RecordAudio("322062093", var_387_9)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_322062", "322062093", "story_v_out_322062.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_322062", "322062093", "story_v_out_322062.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_10 = math.max(var_387_3, arg_384_1.talkMaxDuration)

			if var_387_2 <= arg_384_1.time_ and arg_384_1.time_ < var_387_2 + var_387_10 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_2) / var_387_10

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_2 + var_387_10 and arg_384_1.time_ < var_387_2 + var_387_10 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play322062094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 322062094
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play322062095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos10103ui_story = arg_388_1.actors_["10103ui_story"].transform.localPosition

				local var_391_0 = GameObjectTools.GetOrAddComponent(arg_388_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_391_0 then
					var_391_0:EnableDynamicBone(false)
				end
			end

			local var_391_1 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_1 then
				arg_388_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_388_1.time_ - 0) / var_391_1)
				arg_388_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["10103ui_story"].transform.position).z)
				arg_388_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["10103ui_story"].transform.localEulerAngles = arg_388_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_1 and arg_388_1.time_ < 0 + var_391_1 + arg_391_0 then
				arg_388_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_388_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["10103ui_story"].transform.position).z)
				arg_388_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["10103ui_story"].transform.localEulerAngles = arg_388_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_391_2 = GameObjectTools.GetOrAddComponent(arg_388_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_391_2 then
					var_391_2:EnableDynamicBone(true)
				end
			end

			local var_391_3 = arg_388_1.actors_["1089ui_story"].transform

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1089ui_story = var_391_3.localPosition
			end

			local var_391_4 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_4 then
				var_391_3.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_388_1.time_ - 0) / var_391_4)
				var_391_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_3.position).x, (manager.ui.mainCamera.transform.position - var_391_3.position).y, (manager.ui.mainCamera.transform.position - var_391_3.position).z)
				var_391_3.localEulerAngles.z = 0
				var_391_3.localEulerAngles.x = 0
				var_391_3.localEulerAngles = var_391_3.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_4 and arg_388_1.time_ < 0 + var_391_4 + arg_391_0 then
				var_391_3.localPosition = Vector3.New(0, 100, 0)
				var_391_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_3.position).x, (manager.ui.mainCamera.transform.position - var_391_3.position).y, (manager.ui.mainCamera.transform.position - var_391_3.position).z)
				var_391_3.localEulerAngles.z = 0
				var_391_3.localEulerAngles.x = 0
				var_391_3.localEulerAngles = var_391_3.localEulerAngles
			end

			if 0.9 < arg_388_1.time_ and arg_388_1.time_ <= 0.9 + arg_391_0 then
				arg_388_1:AudioAction("play", "effect", "se_story_145", "se_story_145_cup_paper", "")
			end

			local var_391_6 = 0
			local var_391_7 = 1.15

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_6 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_8 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(322062094).content)

				arg_388_1.text_.text = var_391_8

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_10 = 46 <= 0 and var_391_7 or var_391_7 * (utf8.len(var_391_8) / 46)

				if (46 <= 0 and var_391_7 or var_391_7 * (utf8.len(var_391_8) / 46)) > 0 and var_391_7 < var_391_10 then
					arg_388_1.talkMaxDuration = var_391_10

					if var_391_10 + var_391_6 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_6
					end
				end

				arg_388_1.text_.text = var_391_8
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_11 = math.max(var_391_7, arg_388_1.talkMaxDuration)

			if var_391_6 <= arg_388_1.time_ and arg_388_1.time_ < var_391_6 + var_391_11 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_6) / var_391_11

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_6 + var_391_11 and arg_388_1.time_ < var_391_6 + var_391_11 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play322062095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 322062095
		arg_392_1.duration_ = 4.27

		local var_392_0 = {
			zh = 2.1,
			ja = 4.266
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play322062096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos10103ui_story = arg_392_1.actors_["10103ui_story"].transform.localPosition

				local var_395_0 = GameObjectTools.GetOrAddComponent(arg_392_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_395_0 then
					var_395_0:EnableDynamicBone(false)
				end
			end

			local var_395_1 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_1 then
				arg_392_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos10103ui_story, Vector3.New(0, -0.95, -6.2), (arg_392_1.time_ - 0) / var_395_1)
				arg_392_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["10103ui_story"].transform.position).z)
				arg_392_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["10103ui_story"].transform.localEulerAngles = arg_392_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_392_1.time_ >= 0 + var_395_1 and arg_392_1.time_ < 0 + var_395_1 + arg_395_0 then
				arg_392_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.2)
				arg_392_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["10103ui_story"].transform.position).z)
				arg_392_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["10103ui_story"].transform.localEulerAngles = arg_392_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_395_2 = GameObjectTools.GetOrAddComponent(arg_392_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_395_2 then
					var_395_2:EnableDynamicBone(true)
				end
			end

			local var_395_3 = arg_392_1.actors_["10103ui_story"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_3) and arg_392_1.var_.characterEffect10103ui_story == nil then
				arg_392_1.var_.characterEffect10103ui_story = var_395_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_4 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_4 and not isNil(var_395_3) then
				if arg_392_1.var_.characterEffect10103ui_story and not isNil(var_395_3) then
					arg_392_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= 0 + var_395_4 and arg_392_1.time_ < 0 + var_395_4 + arg_395_0 and not isNil(var_395_3) and arg_392_1.var_.characterEffect10103ui_story then
				arg_392_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				if not isNil(arg_392_1.actors_["10103ui_story"]) then
					local var_395_6 = GameObjectTools.GetOrAddComponent(arg_392_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_395_6 then
						var_395_6:EnableDynamicBone(true)
					end
				end
			end

			local var_395_7 = 0
			local var_395_8 = 0.25

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_7 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_9 = arg_392_1:GetWordFromCfg(322062095)
				local var_395_10 = arg_392_1:FormatText(var_395_9.content)

				arg_392_1.text_.text = var_395_10

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_12 = 10 <= 0 and var_395_8 or var_395_8 * (utf8.len(var_395_10) / 10)

				if (10 <= 0 and var_395_8 or var_395_8 * (utf8.len(var_395_10) / 10)) > 0 and var_395_8 < var_395_12 then
					arg_392_1.talkMaxDuration = var_395_12

					if var_395_12 + var_395_7 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_12 + var_395_7
					end
				end

				arg_392_1.text_.text = var_395_10
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062095", "story_v_out_322062.awb") ~= 0 then
					local var_395_13 = manager.audio:GetVoiceLength("story_v_out_322062", "322062095", "story_v_out_322062.awb") / 1000

					if var_395_13 + var_395_7 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_13 + var_395_7
					end

					if var_395_9.prefab_name ~= "" and arg_392_1.actors_[var_395_9.prefab_name] ~= nil then
						local var_395_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_9.prefab_name].transform, "story_v_out_322062", "322062095", "story_v_out_322062.awb")

						arg_392_1:RecordAudio("322062095", var_395_14)
						arg_392_1:RecordAudio("322062095", var_395_14)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_322062", "322062095", "story_v_out_322062.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_322062", "322062095", "story_v_out_322062.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_15 = math.max(var_395_8, arg_392_1.talkMaxDuration)

			if var_395_7 <= arg_392_1.time_ and arg_392_1.time_ < var_395_7 + var_395_15 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_7) / var_395_15

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_7 + var_395_15 and arg_392_1.time_ < var_395_7 + var_395_15 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play322062096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 322062096
		arg_396_1.duration_ = 13.03

		local var_396_0 = {
			zh = 9.1,
			ja = 13.033
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play322062097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(arg_396_1.actors_["10103ui_story"]) and arg_396_1.var_.characterEffect10103ui_story == nil then
				arg_396_1.var_.characterEffect10103ui_story = arg_396_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_0 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 and not isNil(arg_396_1.actors_["10103ui_story"]) then
				if arg_396_1.var_.characterEffect10103ui_story and not isNil(arg_396_1.actors_["10103ui_story"]) then
					arg_396_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_396_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_396_1.time_ - 0) / var_399_0)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 and not isNil(arg_396_1.actors_["10103ui_story"]) and arg_396_1.var_.characterEffect10103ui_story then
				arg_396_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_396_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			local var_399_1 = 0
			local var_399_2 = 0.95

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_3 = arg_396_1:GetWordFromCfg(322062096)
				local var_399_4 = arg_396_1:FormatText(var_399_3.content)

				arg_396_1.text_.text = var_399_4

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_6 = 37 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_4) / 37)

				if (37 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_4) / 37)) > 0 and var_399_2 < var_399_6 then
					arg_396_1.talkMaxDuration = var_399_6

					if var_399_6 + var_399_1 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_6 + var_399_1
					end
				end

				arg_396_1.text_.text = var_399_4
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062096", "story_v_out_322062.awb") ~= 0 then
					local var_399_7 = manager.audio:GetVoiceLength("story_v_out_322062", "322062096", "story_v_out_322062.awb") / 1000

					if var_399_7 + var_399_1 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_1
					end

					if var_399_3.prefab_name ~= "" and arg_396_1.actors_[var_399_3.prefab_name] ~= nil then
						local var_399_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_3.prefab_name].transform, "story_v_out_322062", "322062096", "story_v_out_322062.awb")

						arg_396_1:RecordAudio("322062096", var_399_8)
						arg_396_1:RecordAudio("322062096", var_399_8)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_322062", "322062096", "story_v_out_322062.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_322062", "322062096", "story_v_out_322062.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_9 = math.max(var_399_2, arg_396_1.talkMaxDuration)

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_9 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_1) / var_399_9

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_1 + var_399_9 and arg_396_1.time_ < var_399_1 + var_399_9 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play322062097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 322062097
		arg_400_1.duration_ = 7.47

		local var_400_0 = {
			zh = 7.466,
			ja = 6.266
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play322062098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0.8

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_1 = arg_400_1:GetWordFromCfg(322062097)
				local var_403_2 = arg_400_1:FormatText(var_403_1.content)

				arg_400_1.text_.text = var_403_2

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_4 = 32 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_2) / 32)

				if (32 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_2) / 32)) > 0 and var_403_0 < var_403_4 then
					arg_400_1.talkMaxDuration = var_403_4

					if var_403_4 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_4 + 0
					end
				end

				arg_400_1.text_.text = var_403_2
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062097", "story_v_out_322062.awb") ~= 0 then
					local var_403_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062097", "story_v_out_322062.awb") / 1000

					if var_403_5 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_5 + 0
					end

					if var_403_1.prefab_name ~= "" and arg_400_1.actors_[var_403_1.prefab_name] ~= nil then
						local var_403_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_1.prefab_name].transform, "story_v_out_322062", "322062097", "story_v_out_322062.awb")

						arg_400_1:RecordAudio("322062097", var_403_6)
						arg_400_1:RecordAudio("322062097", var_403_6)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_322062", "322062097", "story_v_out_322062.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_322062", "322062097", "story_v_out_322062.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_7 = math.max(var_403_0, arg_400_1.talkMaxDuration)

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_7 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - 0) / var_403_7

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= 0 + var_403_7 and arg_400_1.time_ < 0 + var_403_7 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play322062098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 322062098
		arg_404_1.duration_ = 7.87

		local var_404_0 = {
			zh = 5.6,
			ja = 7.866
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
				arg_404_0:Play322062099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(arg_404_1.actors_["10103ui_story"]) and arg_404_1.var_.characterEffect10103ui_story == nil then
				arg_404_1.var_.characterEffect10103ui_story = arg_404_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_0 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 and not isNil(arg_404_1.actors_["10103ui_story"]) then
				if arg_404_1.var_.characterEffect10103ui_story and not isNil(arg_404_1.actors_["10103ui_story"]) then
					arg_404_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 and not isNil(arg_404_1.actors_["10103ui_story"]) and arg_404_1.var_.characterEffect10103ui_story then
				arg_404_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_407_2 = 0
			local var_407_3 = 0.75

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_2 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_4 = arg_404_1:GetWordFromCfg(322062098)
				local var_407_5 = arg_404_1:FormatText(var_407_4.content)

				arg_404_1.text_.text = var_407_5

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_7 = 30 <= 0 and var_407_3 or var_407_3 * (utf8.len(var_407_5) / 30)

				if (30 <= 0 and var_407_3 or var_407_3 * (utf8.len(var_407_5) / 30)) > 0 and var_407_3 < var_407_7 then
					arg_404_1.talkMaxDuration = var_407_7

					if var_407_7 + var_407_2 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_2
					end
				end

				arg_404_1.text_.text = var_407_5
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062098", "story_v_out_322062.awb") ~= 0 then
					local var_407_8 = manager.audio:GetVoiceLength("story_v_out_322062", "322062098", "story_v_out_322062.awb") / 1000

					if var_407_8 + var_407_2 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_8 + var_407_2
					end

					if var_407_4.prefab_name ~= "" and arg_404_1.actors_[var_407_4.prefab_name] ~= nil then
						local var_407_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_4.prefab_name].transform, "story_v_out_322062", "322062098", "story_v_out_322062.awb")

						arg_404_1:RecordAudio("322062098", var_407_9)
						arg_404_1:RecordAudio("322062098", var_407_9)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_322062", "322062098", "story_v_out_322062.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_322062", "322062098", "story_v_out_322062.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_10 = math.max(var_407_3, arg_404_1.talkMaxDuration)

			if var_407_2 <= arg_404_1.time_ and arg_404_1.time_ < var_407_2 + var_407_10 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_2) / var_407_10

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_2 + var_407_10 and arg_404_1.time_ < var_407_2 + var_407_10 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play322062099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 322062099
		arg_408_1.duration_ = 4.7

		local var_408_0 = {
			zh = 3.9,
			ja = 4.7
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
				arg_408_0:Play322062100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action6_1")
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				if not isNil(arg_408_1.actors_["10103ui_story"]) then
					local var_411_0 = GameObjectTools.GetOrAddComponent(arg_408_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_411_0 then
						var_411_0:EnableDynamicBone(true)
					end
				end
			end

			local var_411_1 = 0
			local var_411_2 = 0.325

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_3 = arg_408_1:GetWordFromCfg(322062099)
				local var_411_4 = arg_408_1:FormatText(var_411_3.content)

				arg_408_1.text_.text = var_411_4

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_6 = 13 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_4) / 13)

				if (13 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_4) / 13)) > 0 and var_411_2 < var_411_6 then
					arg_408_1.talkMaxDuration = var_411_6

					if var_411_6 + var_411_1 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_6 + var_411_1
					end
				end

				arg_408_1.text_.text = var_411_4
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062099", "story_v_out_322062.awb") ~= 0 then
					local var_411_7 = manager.audio:GetVoiceLength("story_v_out_322062", "322062099", "story_v_out_322062.awb") / 1000

					if var_411_7 + var_411_1 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_7 + var_411_1
					end

					if var_411_3.prefab_name ~= "" and arg_408_1.actors_[var_411_3.prefab_name] ~= nil then
						local var_411_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_3.prefab_name].transform, "story_v_out_322062", "322062099", "story_v_out_322062.awb")

						arg_408_1:RecordAudio("322062099", var_411_8)
						arg_408_1:RecordAudio("322062099", var_411_8)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_322062", "322062099", "story_v_out_322062.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_322062", "322062099", "story_v_out_322062.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_9 = math.max(var_411_2, arg_408_1.talkMaxDuration)

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_9 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_1) / var_411_9

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_1 + var_411_9 and arg_408_1.time_ < var_411_1 + var_411_9 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play322062100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 322062100
		arg_412_1.duration_ = 7.8

		local var_412_0 = {
			zh = 2.866,
			ja = 7.8
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play322062101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(arg_412_1.actors_["10103ui_story"]) and arg_412_1.var_.characterEffect10103ui_story == nil then
				arg_412_1.var_.characterEffect10103ui_story = arg_412_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_0 = 0.200000002980232

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 and not isNil(arg_412_1.actors_["10103ui_story"]) then
				if arg_412_1.var_.characterEffect10103ui_story and not isNil(arg_412_1.actors_["10103ui_story"]) then
					arg_412_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_412_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_412_1.time_ - 0) / var_415_0)
				end
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 and not isNil(arg_412_1.actors_["10103ui_story"]) and arg_412_1.var_.characterEffect10103ui_story then
				arg_412_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_412_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			local var_415_1 = 0
			local var_415_2 = 0.375

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_1 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_3 = arg_412_1:GetWordFromCfg(322062100)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_6 = 15 <= 0 and var_415_2 or var_415_2 * (utf8.len(var_415_4) / 15)

				if (15 <= 0 and var_415_2 or var_415_2 * (utf8.len(var_415_4) / 15)) > 0 and var_415_2 < var_415_6 then
					arg_412_1.talkMaxDuration = var_415_6

					if var_415_6 + var_415_1 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_6 + var_415_1
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062100", "story_v_out_322062.awb") ~= 0 then
					local var_415_7 = manager.audio:GetVoiceLength("story_v_out_322062", "322062100", "story_v_out_322062.awb") / 1000

					if var_415_7 + var_415_1 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_1
					end

					if var_415_3.prefab_name ~= "" and arg_412_1.actors_[var_415_3.prefab_name] ~= nil then
						local var_415_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_3.prefab_name].transform, "story_v_out_322062", "322062100", "story_v_out_322062.awb")

						arg_412_1:RecordAudio("322062100", var_415_8)
						arg_412_1:RecordAudio("322062100", var_415_8)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_322062", "322062100", "story_v_out_322062.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_322062", "322062100", "story_v_out_322062.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_9 = math.max(var_415_2, arg_412_1.talkMaxDuration)

			if var_415_1 <= arg_412_1.time_ and arg_412_1.time_ < var_415_1 + var_415_9 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_1) / var_415_9

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_1 + var_415_9 and arg_412_1.time_ < var_415_1 + var_415_9 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play322062101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 322062101
		arg_416_1.duration_ = 6.2

		local var_416_0 = {
			zh = 5.766,
			ja = 6.2
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play322062102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0.625

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_1 = arg_416_1:GetWordFromCfg(322062101)
				local var_419_2 = arg_416_1:FormatText(var_419_1.content)

				arg_416_1.text_.text = var_419_2

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 25 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 25)

				if (25 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 25)) > 0 and var_419_0 < var_419_4 then
					arg_416_1.talkMaxDuration = var_419_4

					if var_419_4 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_4 + 0
					end
				end

				arg_416_1.text_.text = var_419_2
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062101", "story_v_out_322062.awb") ~= 0 then
					local var_419_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062101", "story_v_out_322062.awb") / 1000

					if var_419_5 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + 0
					end

					if var_419_1.prefab_name ~= "" and arg_416_1.actors_[var_419_1.prefab_name] ~= nil then
						local var_419_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_1.prefab_name].transform, "story_v_out_322062", "322062101", "story_v_out_322062.awb")

						arg_416_1:RecordAudio("322062101", var_419_6)
						arg_416_1:RecordAudio("322062101", var_419_6)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_322062", "322062101", "story_v_out_322062.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_322062", "322062101", "story_v_out_322062.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play322062102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 322062102
		arg_420_1.duration_ = 13.5

		local var_420_0 = {
			zh = 7.933,
			ja = 13.5
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play322062103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(arg_420_1.actors_["10103ui_story"]) and arg_420_1.var_.characterEffect10103ui_story == nil then
				arg_420_1.var_.characterEffect10103ui_story = arg_420_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_0 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 and not isNil(arg_420_1.actors_["10103ui_story"]) then
				if arg_420_1.var_.characterEffect10103ui_story and not isNil(arg_420_1.actors_["10103ui_story"]) then
					arg_420_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 and not isNil(arg_420_1.actors_["10103ui_story"]) and arg_420_1.var_.characterEffect10103ui_story then
				arg_420_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action6_2")
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				if not isNil(arg_420_1.actors_["10103ui_story"]) then
					local var_423_2 = GameObjectTools.GetOrAddComponent(arg_420_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_423_2 then
						var_423_2:EnableDynamicBone(true)
					end
				end
			end

			local var_423_3 = 0
			local var_423_4 = 0.85

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_3 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_5 = arg_420_1:GetWordFromCfg(322062102)
				local var_423_6 = arg_420_1:FormatText(var_423_5.content)

				arg_420_1.text_.text = var_423_6

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_8 = 34 <= 0 and var_423_4 or var_423_4 * (utf8.len(var_423_6) / 34)

				if (34 <= 0 and var_423_4 or var_423_4 * (utf8.len(var_423_6) / 34)) > 0 and var_423_4 < var_423_8 then
					arg_420_1.talkMaxDuration = var_423_8

					if var_423_8 + var_423_3 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_8 + var_423_3
					end
				end

				arg_420_1.text_.text = var_423_6
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062102", "story_v_out_322062.awb") ~= 0 then
					local var_423_9 = manager.audio:GetVoiceLength("story_v_out_322062", "322062102", "story_v_out_322062.awb") / 1000

					if var_423_9 + var_423_3 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_9 + var_423_3
					end

					if var_423_5.prefab_name ~= "" and arg_420_1.actors_[var_423_5.prefab_name] ~= nil then
						local var_423_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_5.prefab_name].transform, "story_v_out_322062", "322062102", "story_v_out_322062.awb")

						arg_420_1:RecordAudio("322062102", var_423_10)
						arg_420_1:RecordAudio("322062102", var_423_10)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_322062", "322062102", "story_v_out_322062.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_322062", "322062102", "story_v_out_322062.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_11 = math.max(var_423_4, arg_420_1.talkMaxDuration)

			if var_423_3 <= arg_420_1.time_ and arg_420_1.time_ < var_423_3 + var_423_11 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_3) / var_423_11

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_3 + var_423_11 and arg_420_1.time_ < var_423_3 + var_423_11 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play322062103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 322062103
		arg_424_1.duration_ = 5.43

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play322062104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos10103ui_story = arg_424_1.actors_["10103ui_story"].transform.localPosition

				local var_427_0 = GameObjectTools.GetOrAddComponent(arg_424_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_427_0 then
					var_427_0:EnableDynamicBone(false)
				end
			end

			local var_427_1 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_1 then
				arg_424_1.actors_["10103ui_story"].transform.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_424_1.time_ - 0) / var_427_1)
				arg_424_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["10103ui_story"].transform.position).z)
				arg_424_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["10103ui_story"].transform.localEulerAngles = arg_424_1.actors_["10103ui_story"].transform.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_1 and arg_424_1.time_ < 0 + var_427_1 + arg_427_0 then
				arg_424_1.actors_["10103ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_424_1.actors_["10103ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["10103ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["10103ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["10103ui_story"].transform.position).z)
				arg_424_1.actors_["10103ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["10103ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["10103ui_story"].transform.localEulerAngles = arg_424_1.actors_["10103ui_story"].transform.localEulerAngles

				local var_427_2 = GameObjectTools.GetOrAddComponent(arg_424_1.actors_["10103ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_427_2 then
					var_427_2:EnableDynamicBone(true)
				end
			end

			local var_427_3 = arg_424_1.actors_["1089ui_story"].transform

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos1089ui_story = var_427_3.localPosition
			end

			local var_427_4 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_4 then
				var_427_3.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_424_1.time_ - 0) / var_427_4)
				var_427_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_427_3.position).x, (manager.ui.mainCamera.transform.position - var_427_3.position).y, (manager.ui.mainCamera.transform.position - var_427_3.position).z)
				var_427_3.localEulerAngles.z = 0
				var_427_3.localEulerAngles.x = 0
				var_427_3.localEulerAngles = var_427_3.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_4 and arg_424_1.time_ < 0 + var_427_4 + arg_427_0 then
				var_427_3.localPosition = Vector3.New(0, 100, 0)
				var_427_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_427_3.position).x, (manager.ui.mainCamera.transform.position - var_427_3.position).y, (manager.ui.mainCamera.transform.position - var_427_3.position).z)
				var_427_3.localEulerAngles.z = 0
				var_427_3.localEulerAngles.x = 0
				var_427_3.localEulerAngles = var_427_3.localEulerAngles
			end

			if 0.433333333333333 < arg_424_1.time_ and arg_424_1.time_ <= 0.433333333333333 + arg_427_0 then
				arg_424_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_gun01", "")
			end

			if 2.98023250522306e-09 < arg_424_1.time_ and arg_424_1.time_ <= 2.98023250522306e-09 + arg_427_0 then
				if arg_424_1.var_.effect078 then
					Object.Destroy(arg_424_1.var_.effect078)

					arg_424_1.var_.effect078 = nil
				end
			end

			if 2.98023250522306e-09 < arg_424_1.time_ and arg_424_1.time_ <= 2.98023250522306e-09 + arg_427_0 then
				if arg_424_1.var_.effect0781 then
					Object.Destroy(arg_424_1.var_.effect0781)

					arg_424_1.var_.effect0781 = nil
				end
			end

			local var_427_8 = 0

			arg_424_1.isInRecall_ = false

			if var_427_8 < arg_424_1.time_ and arg_424_1.time_ <= var_427_8 + arg_427_0 then
				arg_424_1.screenFilterGo_:SetActive(false)

				for iter_427_0, iter_427_1 in pairs(arg_424_1.actors_) do
					for iter_427_2, iter_427_3 in ipairs((iter_427_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_427_3.color = iter_427_3.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_427_9 = 0.0166666666666667

			if var_427_8 <= arg_424_1.time_ and arg_424_1.time_ < var_427_8 + var_427_9 then
				arg_424_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_424_1.time_ - var_427_8) / var_427_9)
			end

			if arg_424_1.time_ >= var_427_8 + var_427_9 and arg_424_1.time_ < var_427_8 + var_427_9 + arg_427_0 then
				arg_424_1.screenFilterEffect_.weight = 0
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				local var_427_10 = arg_424_1.bgs_.ST61a

				arg_424_1.bgs_.ST61a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_427_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_427_11 = var_427_10:GetComponent("SpriteRenderer")

				if var_427_11 and var_427_11.sprite then
					local var_427_12 = 2 * (var_427_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_427_10.transform.localScale = Vector3.New(var_427_12 / var_427_11.sprite.bounds.size.y < var_427_12 * manager.ui.mainCameraCom_.aspect / var_427_11.sprite.bounds.size.x and var_427_12 * manager.ui.mainCameraCom_.aspect / var_427_11.sprite.bounds.size.x or var_427_12 / var_427_11.sprite.bounds.size.y, var_427_12 / var_427_11.sprite.bounds.size.y < var_427_12 * manager.ui.mainCameraCom_.aspect / var_427_11.sprite.bounds.size.x and var_427_12 * manager.ui.mainCameraCom_.aspect / var_427_11.sprite.bounds.size.x or var_427_12 / var_427_11.sprite.bounds.size.y, 0)
				end

				for iter_427_4, iter_427_5 in pairs(arg_424_1.bgs_) do
					if iter_427_4 ~= "ST61a" then
						iter_427_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_427_13 = 0

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_13 + arg_427_0 then
				arg_424_1.mask_.enabled = true
				arg_424_1.mask_.raycastTarget = false

				arg_424_1:SetGaussion(false)
			end

			local var_427_14 = 0.5

			if var_427_13 <= arg_424_1.time_ and arg_424_1.time_ < var_427_13 + var_427_14 then
				local var_427_15 = Color.New(1, 1, 1)

				var_427_15.a = Mathf.Lerp(1, 0, (arg_424_1.time_ - var_427_13) / var_427_14)
				arg_424_1.mask_.color = var_427_15
			end

			if arg_424_1.time_ >= var_427_13 + var_427_14 and arg_424_1.time_ < var_427_13 + var_427_14 + arg_427_0 then
				local var_427_16 = Color.New(1, 1, 1)

				arg_424_1.mask_.enabled = false
				var_427_16.a = 0
				arg_424_1.mask_.color = var_427_16
			end

			if arg_424_1.frameCnt_ <= 1 then
				arg_424_1.dialog_:SetActive(false)
			end

			local var_427_17 = 0.433333333333333
			local var_427_18 = 1.2

			if 0.433333333333333 < arg_424_1.time_ and arg_424_1.time_ <= var_427_17 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0

				arg_424_1.dialog_:SetActive(true)

				arg_424_1.dialogCg_.alpha = 0

				local var_427_19 = LeanTween.value(arg_424_1.dialog_, 0, 1, 0.3)

				var_427_19:setOnUpdate(LuaHelper.FloatAction(function(arg_428_0)
					arg_424_1.dialogCg_.alpha = arg_428_0
				end))
				var_427_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_424_1.dialog_)
					var_427_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_424_1.duration_ = arg_424_1.duration_ + 0.3

				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_20 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(322062103).content)

				arg_424_1.text_.text = var_427_20

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_22 = 48 <= 0 and var_427_18 or var_427_18 * (utf8.len(var_427_20) / 48)

				if (48 <= 0 and var_427_18 or var_427_18 * (utf8.len(var_427_20) / 48)) > 0 and var_427_18 < var_427_22 then
					arg_424_1.talkMaxDuration = var_427_22
					var_427_17 = var_427_17 + 0.3

					if var_427_22 + var_427_17 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_22 + var_427_17
					end
				end

				arg_424_1.text_.text = var_427_20
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_23 = var_427_17 + 0.3
			local var_427_24 = math.max(var_427_18, arg_424_1.talkMaxDuration)

			if var_427_17 + 0.3 <= arg_424_1.time_ and arg_424_1.time_ < var_427_23 + var_427_24 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_23) / var_427_24

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_23 + var_427_24 and arg_424_1.time_ < var_427_23 + var_427_24 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play322062104 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 322062104
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play322062105(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 1.7

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_1 = arg_430_1:FormatText(arg_430_1:GetWordFromCfg(322062104).content)

				arg_430_1.text_.text = var_433_1

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_3 = 68 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 68)

				if (68 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_1) / 68)) > 0 and var_433_0 < var_433_3 then
					arg_430_1.talkMaxDuration = var_433_3

					if var_433_3 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_3 + 0
					end
				end

				arg_430_1.text_.text = var_433_1
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_4 = math.max(var_433_0, arg_430_1.talkMaxDuration)

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_4 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - 0) / var_433_4

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= 0 + var_433_4 and arg_430_1.time_ < 0 + var_433_4 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play322062105 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 322062105
		arg_434_1.duration_ = 7.93

		local var_434_0 = {
			zh = 5.3,
			ja = 7.933
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play322062106(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0.575

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_434_1.callingController_:SetSelectedState("calling")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_1 = arg_434_1:GetWordFromCfg(322062105)
				local var_437_2 = arg_434_1:FormatText(var_437_1.content)

				arg_434_1.text_.text = var_437_2

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_4 = 23 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 23)

				if (23 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 23)) > 0 and var_437_0 < var_437_4 then
					arg_434_1.talkMaxDuration = var_437_4

					if var_437_4 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_4 + 0
					end
				end

				arg_434_1.text_.text = var_437_2
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062105", "story_v_out_322062.awb") ~= 0 then
					local var_437_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062105", "story_v_out_322062.awb") / 1000

					if var_437_5 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + 0
					end

					if var_437_1.prefab_name ~= "" and arg_434_1.actors_[var_437_1.prefab_name] ~= nil then
						local var_437_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_1.prefab_name].transform, "story_v_out_322062", "322062105", "story_v_out_322062.awb")

						arg_434_1:RecordAudio("322062105", var_437_6)
						arg_434_1:RecordAudio("322062105", var_437_6)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_322062", "322062105", "story_v_out_322062.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_322062", "322062105", "story_v_out_322062.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_7 = math.max(var_437_0, arg_434_1.talkMaxDuration)

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_7 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - 0) / var_437_7

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= 0 + var_437_7 and arg_434_1.time_ < 0 + var_437_7 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play322062106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 322062106
		arg_438_1.duration_ = 6.6

		local var_438_0 = {
			zh = 6.566,
			ja = 6.6
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play322062107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if arg_438_1.bgs_.MS2202 == nil then
				local var_441_0 = Object.Instantiate(arg_438_1.paintGo_)

				var_441_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2202")
				var_441_0.name = "MS2202"
				var_441_0.transform.parent = arg_438_1.stage_.transform
				var_441_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_438_1.bgs_.MS2202 = var_441_0
			end

			if 2 < arg_438_1.time_ and arg_438_1.time_ <= 2 + arg_441_0 then
				local var_441_1 = arg_438_1.bgs_.MS2202

				arg_438_1.bgs_.MS2202.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_441_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_441_2 = var_441_1:GetComponent("SpriteRenderer")

				if var_441_2 and var_441_2.sprite then
					local var_441_3 = 2 * (var_441_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_441_1.transform.localScale = Vector3.New(var_441_3 / var_441_2.sprite.bounds.size.y < var_441_3 * manager.ui.mainCameraCom_.aspect / var_441_2.sprite.bounds.size.x and var_441_3 * manager.ui.mainCameraCom_.aspect / var_441_2.sprite.bounds.size.x or var_441_3 / var_441_2.sprite.bounds.size.y, var_441_3 / var_441_2.sprite.bounds.size.y < var_441_3 * manager.ui.mainCameraCom_.aspect / var_441_2.sprite.bounds.size.x and var_441_3 * manager.ui.mainCameraCom_.aspect / var_441_2.sprite.bounds.size.x or var_441_3 / var_441_2.sprite.bounds.size.y, 0)
				end

				for iter_441_0, iter_441_1 in pairs(arg_438_1.bgs_) do
					if iter_441_0 ~= "MS2202" then
						iter_441_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_441_4 = 4

			if 4 < arg_438_1.time_ and arg_438_1.time_ <= var_441_4 + arg_441_0 then
				arg_438_1.allBtn_.enabled = false
			end

			if arg_438_1.time_ >= var_441_4 + 0.3 and arg_438_1.time_ < var_441_4 + 0.3 + arg_441_0 then
				arg_438_1.allBtn_.enabled = true
			end

			local var_441_5 = 0

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_5 + arg_441_0 then
				arg_438_1.mask_.enabled = true
				arg_438_1.mask_.raycastTarget = true

				arg_438_1:SetGaussion(false)
			end

			local var_441_6 = 2

			if var_441_5 <= arg_438_1.time_ and arg_438_1.time_ < var_441_5 + var_441_6 then
				local var_441_7 = Color.New(0, 0, 0)

				var_441_7.a = Mathf.Lerp(0, 1, (arg_438_1.time_ - var_441_5) / var_441_6)
				arg_438_1.mask_.color = var_441_7
			end

			if arg_438_1.time_ >= var_441_5 + var_441_6 and arg_438_1.time_ < var_441_5 + var_441_6 + arg_441_0 then
				local var_441_8 = Color.New(0, 0, 0)

				var_441_8.a = 1
				arg_438_1.mask_.color = var_441_8
			end

			local var_441_9 = 2

			if 2 < arg_438_1.time_ and arg_438_1.time_ <= var_441_9 + arg_441_0 then
				arg_438_1.mask_.enabled = true
				arg_438_1.mask_.raycastTarget = true

				arg_438_1:SetGaussion(false)
			end

			local var_441_10 = 2

			if var_441_9 <= arg_438_1.time_ and arg_438_1.time_ < var_441_9 + var_441_10 then
				local var_441_11 = Color.New(0, 0, 0)

				var_441_11.a = Mathf.Lerp(1, 0, (arg_438_1.time_ - var_441_9) / var_441_10)
				arg_438_1.mask_.color = var_441_11
			end

			if arg_438_1.time_ >= var_441_9 + var_441_10 and arg_438_1.time_ < var_441_9 + var_441_10 + arg_441_0 then
				local var_441_12 = Color.New(0, 0, 0)

				arg_438_1.mask_.enabled = false
				var_441_12.a = 0
				arg_438_1.mask_.color = var_441_12
			end

			if 0.266666666666667 < arg_438_1.time_ and arg_438_1.time_ <= 0.266666666666667 + arg_441_0 then
				arg_438_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if 1.56666666666667 < arg_438_1.time_ and arg_438_1.time_ <= 1.56666666666667 + arg_441_0 then
				arg_438_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_MS2202", "")
			end

			local var_441_15 = arg_438_1.bgs_.MS2202.transform

			if 2 < arg_438_1.time_ and arg_438_1.time_ <= 2 + arg_441_0 then
				arg_438_1.var_.moveOldPosMS2202 = var_441_15.localPosition
			end

			local var_441_16 = 0.001

			if 2 <= arg_438_1.time_ and arg_438_1.time_ < 2 + var_441_16 then
				var_441_15.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPosMS2202, Vector3.New(0, 0.5, 8), (arg_438_1.time_ - 2) / var_441_16)
			end

			if arg_438_1.time_ >= 2 + var_441_16 and arg_438_1.time_ < 2 + var_441_16 + arg_441_0 then
				var_441_15.localPosition = Vector3.New(0, 0.5, 8)
			end

			local var_441_17 = arg_438_1.bgs_.MS2202.transform

			if 2.01666666666667 < arg_438_1.time_ and arg_438_1.time_ <= 2.01666666666667 + arg_441_0 then
				arg_438_1.var_.moveOldPosMS2202 = var_441_17.localPosition
			end

			local var_441_18 = 1.98333333333333

			if 2.01666666666667 <= arg_438_1.time_ and arg_438_1.time_ < 2.01666666666667 + var_441_18 then
				var_441_17.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPosMS2202, Vector3.New(0, 1, 9), (arg_438_1.time_ - 2.01666666666667) / var_441_18)
			end

			if arg_438_1.time_ >= 2.01666666666667 + var_441_18 and arg_438_1.time_ < 2.01666666666667 + var_441_18 + arg_441_0 then
				var_441_17.localPosition = Vector3.New(0, 1, 9)
			end

			if 1.56666666666667 < arg_438_1.time_ and arg_438_1.time_ <= 1.56666666666667 + arg_441_0 then
				arg_438_1:AudioAction("play", "music", "bgm_activity_4_5_story_serious", "battle", "bgm_activity_4_5_story_serious.awb")

				local var_441_21 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "battle")

				if "" ~= "" then
					if arg_438_1.bgmTxt_.text ~= var_441_21 and arg_438_1.bgmTxt_.text ~= "" then
						if arg_438_1.bgmTxt2_.text ~= "" then
							arg_438_1.bgmTxt_.text = arg_438_1.bgmTxt2_.text
						end

						arg_438_1.bgmTxt2_.text = var_441_21

						arg_438_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_438_1.bgmTxt_.text = var_441_21
						arg_438_1.bgmTxt2_.text = var_441_21
					end

					if arg_438_1.bgmTimer then
						arg_438_1.bgmTimer:Stop()

						arg_438_1.bgmTimer = nil
					end

					if arg_438_1.settingData.show_music_name == 1 then
						arg_438_1.musicController:SetSelectedState("show")
						arg_438_1.musicAnimator_:Play("open", 0, 0)

						if arg_438_1.settingData.music_time ~= 0 then
							arg_438_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_438_1.settingData.music_time), function()
								if arg_438_1 == nil or isNil(arg_438_1.bgmTxt_) then
									return
								end

								arg_438_1.musicController:SetSelectedState("hide")
								arg_438_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.96666666666667 < arg_438_1.time_ and arg_438_1.time_ <= 1.96666666666667 + arg_441_0 then
				if arg_438_1.var_.characterEffect10103ui_story == nil then
					arg_438_1.var_.characterEffect10103ui_story = arg_438_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_441_22 = arg_438_1.var_.characterEffect10103ui_story

				arg_438_1.var_.characterEffect10103ui_story.imageEffect:turnOff()

				var_441_22.interferenceEffect.enabled = false
				var_441_22.interferenceEffect.noise = 0.001
				var_441_22.interferenceEffect.simTimeScale = 1
				var_441_22.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 1.96666666666667 < arg_438_1.time_ and arg_438_1.time_ <= 1.96666666666667 + arg_441_0 then
				if arg_438_1.var_.characterEffect10103ui_story == nil then
					arg_438_1.var_.characterEffect10103ui_story = arg_438_1.actors_["10103ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_438_1.var_.characterEffect10103ui_story.imageEffect:turnOff()
			end

			if arg_438_1.frameCnt_ <= 1 then
				arg_438_1.dialog_:SetActive(false)
			end

			local var_441_24 = 4
			local var_441_25 = 0.3

			if 4 < arg_438_1.time_ and arg_438_1.time_ <= var_441_24 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0

				arg_438_1.dialog_:SetActive(true)

				arg_438_1.dialogCg_.alpha = 0

				local var_441_26 = LeanTween.value(arg_438_1.dialog_, 0, 1, 0.3)

				var_441_26:setOnUpdate(LuaHelper.FloatAction(function(arg_443_0)
					arg_438_1.dialogCg_.alpha = arg_443_0
				end))
				var_441_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_438_1.dialog_)
					var_441_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_438_1.duration_ = arg_438_1.duration_ + 0.3

				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_27 = arg_438_1:GetWordFromCfg(322062106)
				local var_441_28 = arg_438_1:FormatText(var_441_27.content)

				arg_438_1.text_.text = var_441_28

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_30 = 12 <= 0 and var_441_25 or var_441_25 * (utf8.len(var_441_28) / 12)

				if (12 <= 0 and var_441_25 or var_441_25 * (utf8.len(var_441_28) / 12)) > 0 and var_441_25 < var_441_30 then
					arg_438_1.talkMaxDuration = var_441_30
					var_441_24 = var_441_24 + 0.3

					if var_441_30 + var_441_24 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_30 + var_441_24
					end
				end

				arg_438_1.text_.text = var_441_28
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062106", "story_v_out_322062.awb") ~= 0 then
					local var_441_31 = manager.audio:GetVoiceLength("story_v_out_322062", "322062106", "story_v_out_322062.awb") / 1000

					if var_441_31 + var_441_24 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_31 + var_441_24
					end

					if var_441_27.prefab_name ~= "" and arg_438_1.actors_[var_441_27.prefab_name] ~= nil then
						local var_441_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_27.prefab_name].transform, "story_v_out_322062", "322062106", "story_v_out_322062.awb")

						arg_438_1:RecordAudio("322062106", var_441_32)
						arg_438_1:RecordAudio("322062106", var_441_32)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_322062", "322062106", "story_v_out_322062.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_322062", "322062106", "story_v_out_322062.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_33 = var_441_24 + 0.3
			local var_441_34 = math.max(var_441_25, arg_438_1.talkMaxDuration)

			if var_441_24 + 0.3 <= arg_438_1.time_ and arg_438_1.time_ < var_441_33 + var_441_34 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_33) / var_441_34

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_33 + var_441_34 and arg_438_1.time_ < var_441_33 + var_441_34 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.98333333333333,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play322062107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 322062107
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play322062108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0.6

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_1 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(322062107).content)

				arg_445_1.text_.text = var_448_1

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_3 = 24 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 24)

				if (24 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 24)) > 0 and var_448_0 < var_448_3 then
					arg_445_1.talkMaxDuration = var_448_3

					if var_448_3 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_3 + 0
					end
				end

				arg_445_1.text_.text = var_448_1
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_4 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_4 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_4

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_4 and arg_445_1.time_ < 0 + var_448_4 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play322062108 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 322062108
		arg_449_1.duration_ = 7

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play322062109(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPosMS2202 = arg_449_1.bgs_.MS2202.transform.localPosition
			end

			local var_452_0 = 2

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 then
				arg_449_1.bgs_.MS2202.transform.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPosMS2202, Vector3.New(0, 1, 10), (arg_449_1.time_ - 0) / var_452_0)
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 then
				arg_449_1.bgs_.MS2202.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_452_1 = 0

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.allBtn_.enabled = false
			end

			if arg_449_1.time_ >= var_452_1 + 2 and arg_449_1.time_ < var_452_1 + 2 + arg_452_0 then
				arg_449_1.allBtn_.enabled = true
			end

			if arg_449_1.frameCnt_ <= 1 then
				arg_449_1.dialog_:SetActive(false)
			end

			local var_452_2 = 2
			local var_452_3 = 1.275

			if 2 < arg_449_1.time_ and arg_449_1.time_ <= var_452_2 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0

				arg_449_1.dialog_:SetActive(true)

				arg_449_1.dialogCg_.alpha = 0

				local var_452_4 = LeanTween.value(arg_449_1.dialog_, 0, 1, 0.3)

				var_452_4:setOnUpdate(LuaHelper.FloatAction(function(arg_453_0)
					arg_449_1.dialogCg_.alpha = arg_453_0
				end))
				var_452_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_449_1.dialog_)
					var_452_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_449_1.duration_ = arg_449_1.duration_ + 0.3

				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_5 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(322062108).content)

				arg_449_1.text_.text = var_452_5

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_7 = 51 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_5) / 51)

				if (51 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_5) / 51)) > 0 and var_452_3 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7
					var_452_2 = var_452_2 + 0.3

					if var_452_7 + var_452_2 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_2
					end
				end

				arg_449_1.text_.text = var_452_5
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_8 = var_452_2 + 0.3
			local var_452_9 = math.max(var_452_3, arg_449_1.talkMaxDuration)

			if var_452_2 + 0.3 <= arg_449_1.time_ and arg_449_1.time_ < var_452_8 + var_452_9 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_8) / var_452_9

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_8 + var_452_9 and arg_449_1.time_ < var_452_8 + var_452_9 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2202",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutCubic
				}
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play322062109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 322062109
		arg_455_1.duration_ = 7.33

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play322062110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0.333333333333333 < arg_455_1.time_ and arg_455_1.time_ <= 0.333333333333333 + arg_458_0 then
				local var_458_0 = arg_455_1.bgs_.MS2202

				arg_455_1.bgs_.MS2202.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_458_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_458_1 = var_458_0:GetComponent("SpriteRenderer")

				if var_458_1 and var_458_1.sprite then
					local var_458_2 = 2 * (var_458_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_458_0.transform.localScale = Vector3.New(var_458_2 / var_458_1.sprite.bounds.size.y < var_458_2 * manager.ui.mainCameraCom_.aspect / var_458_1.sprite.bounds.size.x and var_458_2 * manager.ui.mainCameraCom_.aspect / var_458_1.sprite.bounds.size.x or var_458_2 / var_458_1.sprite.bounds.size.y, var_458_2 / var_458_1.sprite.bounds.size.y < var_458_2 * manager.ui.mainCameraCom_.aspect / var_458_1.sprite.bounds.size.x and var_458_2 * manager.ui.mainCameraCom_.aspect / var_458_1.sprite.bounds.size.x or var_458_2 / var_458_1.sprite.bounds.size.y, 0)
				end

				for iter_458_0, iter_458_1 in pairs(arg_455_1.bgs_) do
					if iter_458_0 ~= "MS2202" then
						iter_458_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_458_3 = 0

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_3 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_4 = 0.333333333333333

			if var_458_3 <= arg_455_1.time_ and arg_455_1.time_ < var_458_3 + var_458_4 then
				local var_458_5 = Color.New(0, 0, 0)

				var_458_5.a = Mathf.Lerp(0, 1, (arg_455_1.time_ - var_458_3) / var_458_4)
				arg_455_1.mask_.color = var_458_5
			end

			if arg_455_1.time_ >= var_458_3 + var_458_4 and arg_455_1.time_ < var_458_3 + var_458_4 + arg_458_0 then
				local var_458_6 = Color.New(0, 0, 0)

				var_458_6.a = 1
				arg_455_1.mask_.color = var_458_6
			end

			local var_458_7 = 0.333333333333333

			if 0.333333333333333 < arg_455_1.time_ and arg_455_1.time_ <= var_458_7 + arg_458_0 then
				arg_455_1.mask_.enabled = true
				arg_455_1.mask_.raycastTarget = true

				arg_455_1:SetGaussion(false)
			end

			local var_458_8 = 0.333333333333333

			if var_458_7 <= arg_455_1.time_ and arg_455_1.time_ < var_458_7 + var_458_8 then
				local var_458_9 = Color.New(0, 0, 0)

				var_458_9.a = Mathf.Lerp(1, 0, (arg_455_1.time_ - var_458_7) / var_458_8)
				arg_455_1.mask_.color = var_458_9
			end

			if arg_455_1.time_ >= var_458_7 + var_458_8 and arg_455_1.time_ < var_458_7 + var_458_8 + arg_458_0 then
				local var_458_10 = Color.New(0, 0, 0)

				arg_455_1.mask_.enabled = false
				var_458_10.a = 0
				arg_455_1.mask_.color = var_458_10
			end

			local var_458_11 = arg_455_1.bgs_.MS2202.transform

			if 0.333333333333333 < arg_455_1.time_ and arg_455_1.time_ <= 0.333333333333333 + arg_458_0 then
				arg_455_1.var_.moveOldPosMS2202 = var_458_11.localPosition
			end

			local var_458_12 = 0.001

			if 0.333333333333333 <= arg_455_1.time_ and arg_455_1.time_ < 0.333333333333333 + var_458_12 then
				var_458_11.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPosMS2202, Vector3.New(0, 1, 9.5), (arg_455_1.time_ - 0.333333333333333) / var_458_12)
			end

			if arg_455_1.time_ >= 0.333333333333333 + var_458_12 and arg_455_1.time_ < 0.333333333333333 + var_458_12 + arg_458_0 then
				var_458_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_458_13 = arg_455_1.bgs_.MS2202.transform

			if 0.35 < arg_455_1.time_ and arg_455_1.time_ <= 0.35 + arg_458_0 then
				arg_455_1.var_.moveOldPosMS2202 = var_458_13.localPosition
			end

			local var_458_14 = 1.26666666666667

			if 0.35 <= arg_455_1.time_ and arg_455_1.time_ < 0.35 + var_458_14 then
				var_458_13.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPosMS2202, Vector3.New(0, 1, 10), (arg_455_1.time_ - 0.35) / var_458_14)
			end

			if arg_455_1.time_ >= 0.35 + var_458_14 and arg_455_1.time_ < 0.35 + var_458_14 + arg_458_0 then
				var_458_13.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_455_1.frameCnt_ <= 1 then
				arg_455_1.dialog_:SetActive(false)
			end

			local var_458_15 = 2.33333333333333
			local var_458_16 = 1.825

			if 2.33333333333333 < arg_455_1.time_ and arg_455_1.time_ <= var_458_15 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0

				arg_455_1.dialog_:SetActive(true)

				arg_455_1.dialogCg_.alpha = 0

				local var_458_17 = LeanTween.value(arg_455_1.dialog_, 0, 1, 0.3)

				var_458_17:setOnUpdate(LuaHelper.FloatAction(function(arg_459_0)
					arg_455_1.dialogCg_.alpha = arg_459_0
				end))
				var_458_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_455_1.dialog_)
					var_458_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_455_1.duration_ = arg_455_1.duration_ + 0.3

				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_18 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(322062109).content)

				arg_455_1.text_.text = var_458_18

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_20 = 73 <= 0 and var_458_16 or var_458_16 * (utf8.len(var_458_18) / 73)

				if (73 <= 0 and var_458_16 or var_458_16 * (utf8.len(var_458_18) / 73)) > 0 and var_458_16 < var_458_20 then
					arg_455_1.talkMaxDuration = var_458_20
					var_458_15 = var_458_15 + 0.3

					if var_458_20 + var_458_15 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_20 + var_458_15
					end
				end

				arg_455_1.text_.text = var_458_18
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_21 = var_458_15 + 0.3
			local var_458_22 = math.max(var_458_16, arg_455_1.talkMaxDuration)

			if var_458_15 + 0.3 <= arg_455_1.time_ and arg_455_1.time_ < var_458_21 + var_458_22 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_21) / var_458_22

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_21 + var_458_22 and arg_455_1.time_ < var_458_21 + var_458_22 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.26666666666667,
				className = "StoryMoveNode",
				startTime = 0.35,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play322062110 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 322062110
		arg_461_1.duration_ = 6.8

		local var_461_0 = {
			zh = 4.7,
			ja = 6.8
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play322062111(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0.575

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_1 = arg_461_1:GetWordFromCfg(322062110)
				local var_464_2 = arg_461_1:FormatText(var_464_1.content)

				arg_461_1.text_.text = var_464_2

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_4 = 23 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 23)

				if (23 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_2) / 23)) > 0 and var_464_0 < var_464_4 then
					arg_461_1.talkMaxDuration = var_464_4

					if var_464_4 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_4 + 0
					end
				end

				arg_461_1.text_.text = var_464_2
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062110", "story_v_out_322062.awb") ~= 0 then
					local var_464_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062110", "story_v_out_322062.awb") / 1000

					if var_464_5 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + 0
					end

					if var_464_1.prefab_name ~= "" and arg_461_1.actors_[var_464_1.prefab_name] ~= nil then
						local var_464_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_1.prefab_name].transform, "story_v_out_322062", "322062110", "story_v_out_322062.awb")

						arg_461_1:RecordAudio("322062110", var_464_6)
						arg_461_1:RecordAudio("322062110", var_464_6)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_322062", "322062110", "story_v_out_322062.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_322062", "322062110", "story_v_out_322062.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_7 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_7 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_7

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_7 and arg_461_1.time_ < 0 + var_464_7 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play322062111 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 322062111
		arg_465_1.duration_ = 1.8

		local var_465_0 = {
			zh = 1.4,
			ja = 1.8
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play322062112(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0.125

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_1 = arg_465_1:GetWordFromCfg(322062111)
				local var_468_2 = arg_465_1:FormatText(var_468_1.content)

				arg_465_1.text_.text = var_468_2

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_4 = 5 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 5)

				if (5 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 5)) > 0 and var_468_0 < var_468_4 then
					arg_465_1.talkMaxDuration = var_468_4

					if var_468_4 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_4 + 0
					end
				end

				arg_465_1.text_.text = var_468_2
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062111", "story_v_out_322062.awb") ~= 0 then
					local var_468_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062111", "story_v_out_322062.awb") / 1000

					if var_468_5 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + 0
					end

					if var_468_1.prefab_name ~= "" and arg_465_1.actors_[var_468_1.prefab_name] ~= nil then
						local var_468_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_1.prefab_name].transform, "story_v_out_322062", "322062111", "story_v_out_322062.awb")

						arg_465_1:RecordAudio("322062111", var_468_6)
						arg_465_1:RecordAudio("322062111", var_468_6)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_322062", "322062111", "story_v_out_322062.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_322062", "322062111", "story_v_out_322062.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_7 and arg_465_1.time_ < 0 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play322062112 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 322062112
		arg_469_1.duration_ = 2.07

		local var_469_0 = {
			zh = 1.266,
			ja = 2.066
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play322062113(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.125

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_469_1.callingController_:SetSelectedState("calling")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_1 = arg_469_1:GetWordFromCfg(322062112)
				local var_472_2 = arg_469_1:FormatText(var_472_1.content)

				arg_469_1.text_.text = var_472_2

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_4 = 5 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 5)

				if (5 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 5)) > 0 and var_472_0 < var_472_4 then
					arg_469_1.talkMaxDuration = var_472_4

					if var_472_4 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_4 + 0
					end
				end

				arg_469_1.text_.text = var_472_2
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062112", "story_v_out_322062.awb") ~= 0 then
					local var_472_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062112", "story_v_out_322062.awb") / 1000

					if var_472_5 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + 0
					end

					if var_472_1.prefab_name ~= "" and arg_469_1.actors_[var_472_1.prefab_name] ~= nil then
						local var_472_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_1.prefab_name].transform, "story_v_out_322062", "322062112", "story_v_out_322062.awb")

						arg_469_1:RecordAudio("322062112", var_472_6)
						arg_469_1:RecordAudio("322062112", var_472_6)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_322062", "322062112", "story_v_out_322062.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_322062", "322062112", "story_v_out_322062.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_7 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_7 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_7

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_7 and arg_469_1.time_ < 0 + var_472_7 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play322062113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 322062113
		arg_473_1.duration_ = 2.83

		local var_473_0 = {
			zh = 1.233,
			ja = 2.833
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play322062114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.125

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_1 = arg_473_1:GetWordFromCfg(322062113)
				local var_476_2 = arg_473_1:FormatText(var_476_1.content)

				arg_473_1.text_.text = var_476_2

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 5 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 5)

				if (5 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 5)) > 0 and var_476_0 < var_476_4 then
					arg_473_1.talkMaxDuration = var_476_4

					if var_476_4 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_4 + 0
					end
				end

				arg_473_1.text_.text = var_476_2
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062113", "story_v_out_322062.awb") ~= 0 then
					local var_476_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062113", "story_v_out_322062.awb") / 1000

					if var_476_5 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + 0
					end

					if var_476_1.prefab_name ~= "" and arg_473_1.actors_[var_476_1.prefab_name] ~= nil then
						local var_476_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_1.prefab_name].transform, "story_v_out_322062", "322062113", "story_v_out_322062.awb")

						arg_473_1:RecordAudio("322062113", var_476_6)
						arg_473_1:RecordAudio("322062113", var_476_6)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_322062", "322062113", "story_v_out_322062.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_322062", "322062113", "story_v_out_322062.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_7 and arg_473_1.time_ < 0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play322062114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 322062114
		arg_477_1.duration_ = 9.77

		local var_477_0 = {
			zh = 7,
			ja = 9.766
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play322062115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.725

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_477_1.callingController_:SetSelectedState("calling")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_1 = arg_477_1:GetWordFromCfg(322062114)
				local var_480_2 = arg_477_1:FormatText(var_480_1.content)

				arg_477_1.text_.text = var_480_2

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_4 = 29 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 29)

				if (29 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 29)) > 0 and var_480_0 < var_480_4 then
					arg_477_1.talkMaxDuration = var_480_4

					if var_480_4 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_4 + 0
					end
				end

				arg_477_1.text_.text = var_480_2
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062114", "story_v_out_322062.awb") ~= 0 then
					local var_480_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062114", "story_v_out_322062.awb") / 1000

					if var_480_5 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + 0
					end

					if var_480_1.prefab_name ~= "" and arg_477_1.actors_[var_480_1.prefab_name] ~= nil then
						local var_480_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_1.prefab_name].transform, "story_v_out_322062", "322062114", "story_v_out_322062.awb")

						arg_477_1:RecordAudio("322062114", var_480_6)
						arg_477_1:RecordAudio("322062114", var_480_6)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_322062", "322062114", "story_v_out_322062.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_322062", "322062114", "story_v_out_322062.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_7 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_7 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_7

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_7 and arg_477_1.time_ < 0 + var_480_7 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play322062115 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 322062115
		arg_481_1.duration_ = 14.17

		local var_481_0 = {
			zh = 8.266,
			ja = 14.166
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play322062116(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.925

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_481_1.callingController_:SetSelectedState("calling")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_1 = arg_481_1:GetWordFromCfg(322062115)
				local var_484_2 = arg_481_1:FormatText(var_484_1.content)

				arg_481_1.text_.text = var_484_2

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 37 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 37)

				if (37 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 37)) > 0 and var_484_0 < var_484_4 then
					arg_481_1.talkMaxDuration = var_484_4

					if var_484_4 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_4 + 0
					end
				end

				arg_481_1.text_.text = var_484_2
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062115", "story_v_out_322062.awb") ~= 0 then
					local var_484_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062115", "story_v_out_322062.awb") / 1000

					if var_484_5 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + 0
					end

					if var_484_1.prefab_name ~= "" and arg_481_1.actors_[var_484_1.prefab_name] ~= nil then
						local var_484_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_1.prefab_name].transform, "story_v_out_322062", "322062115", "story_v_out_322062.awb")

						arg_481_1:RecordAudio("322062115", var_484_6)
						arg_481_1:RecordAudio("322062115", var_484_6)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_322062", "322062115", "story_v_out_322062.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_322062", "322062115", "story_v_out_322062.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_7 and arg_481_1.time_ < 0 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play322062116 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 322062116
		arg_485_1.duration_ = 9.8

		local var_485_0 = {
			zh = 4.466,
			ja = 9.8
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play322062117(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.55

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_485_1.callingController_:SetSelectedState("calling")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_1 = arg_485_1:GetWordFromCfg(322062116)
				local var_488_2 = arg_485_1:FormatText(var_488_1.content)

				arg_485_1.text_.text = var_488_2

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_4 = 22 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 22)

				if (22 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 22)) > 0 and var_488_0 < var_488_4 then
					arg_485_1.talkMaxDuration = var_488_4

					if var_488_4 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_4 + 0
					end
				end

				arg_485_1.text_.text = var_488_2
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062116", "story_v_out_322062.awb") ~= 0 then
					local var_488_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062116", "story_v_out_322062.awb") / 1000

					if var_488_5 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_5 + 0
					end

					if var_488_1.prefab_name ~= "" and arg_485_1.actors_[var_488_1.prefab_name] ~= nil then
						local var_488_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_1.prefab_name].transform, "story_v_out_322062", "322062116", "story_v_out_322062.awb")

						arg_485_1:RecordAudio("322062116", var_488_6)
						arg_485_1:RecordAudio("322062116", var_488_6)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_322062", "322062116", "story_v_out_322062.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_322062", "322062116", "story_v_out_322062.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_7 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_7 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_7

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_7 and arg_485_1.time_ < 0 + var_488_7 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play322062117 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 322062117
		arg_489_1.duration_ = 3.17

		local var_489_0 = {
			zh = 3.166,
			ja = 3.133
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
			arg_489_1.auto_ = false
		end

		function arg_489_1.playNext_(arg_491_0)
			arg_489_1.onStoryFinished_()
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.275

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_489_1.callingController_:SetSelectedState("calling")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_1 = arg_489_1:GetWordFromCfg(322062117)
				local var_492_2 = arg_489_1:FormatText(var_492_1.content)

				arg_489_1.text_.text = var_492_2

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_4 = 11 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 11)

				if (11 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 11)) > 0 and var_492_0 < var_492_4 then
					arg_489_1.talkMaxDuration = var_492_4

					if var_492_4 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_4 + 0
					end
				end

				arg_489_1.text_.text = var_492_2
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322062", "322062117", "story_v_out_322062.awb") ~= 0 then
					local var_492_5 = manager.audio:GetVoiceLength("story_v_out_322062", "322062117", "story_v_out_322062.awb") / 1000

					if var_492_5 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + 0
					end

					if var_492_1.prefab_name ~= "" and arg_489_1.actors_[var_492_1.prefab_name] ~= nil then
						local var_492_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_1.prefab_name].transform, "story_v_out_322062", "322062117", "story_v_out_322062.awb")

						arg_489_1:RecordAudio("322062117", var_492_6)
						arg_489_1:RecordAudio("322062117", var_492_6)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_322062", "322062117", "story_v_out_322062.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_322062", "322062117", "story_v_out_322062.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_7 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_7

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L10j",
		"TextureConfig/Background/ST61a",
		"TextureConfig/Background/L01h",
		"TextureConfig/Background/MS2202"
	},
	voices = {
		"story_v_out_322062.awb"
	}
}
