return {
	Play417221001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417221001
		arg_1_1.duration_ = 17.5

		local var_1_0 = {
			zh = 17.5,
			ja = 16.866
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
				arg_1_0:Play417221002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 7.4 < arg_1_1.time_ and arg_1_1.time_ <= 7.4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 7.4 + 0.3 and arg_1_1.time_ < 7.4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I16f")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501067).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501068).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_0 + 5 and arg_1_1.time_ < var_4_0 + 5 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_1 = 5

			if 5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_1 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_2 = 1.2

			if var_4_1 <= arg_1_1.time_ and arg_1_1.time_ < var_4_1 + var_4_2 then
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_1) / var_4_2)
				arg_1_1.mask_.color = var_4_3
			end

			if arg_1_1.time_ >= var_4_1 + var_4_2 and arg_1_1.time_ < var_4_1 + var_4_2 + arg_4_0 then
				local var_4_4 = Color.New(0, 0, 0)

				var_4_4.a = 1
				arg_1_1.mask_.color = var_4_4
			end

			local var_4_5 = 6.2

			if 6.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 1.2

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

			local var_4_9 = "I16f"

			if arg_1_1.bgs_.I16f == nil then
				local var_4_10 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_9)
				var_4_10.name = var_4_9
				var_4_10.transform.parent = arg_1_1.stage_.transform
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_9] = var_4_10
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_11 = arg_1_1.bgs_.I16f

				arg_1_1.bgs_.I16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = 2 * (var_4_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_11.transform.localScale = Vector3.New(var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I16f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_14 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_15 = 5

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				local var_4_16 = Color.New(0, 0, 0)

				var_4_16.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_14) / var_4_15)
				arg_1_1.mask_.color = var_4_16
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				local var_4_17 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_17.a = 0
				arg_1_1.mask_.color = var_4_17
			end

			local var_4_18 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 1

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = Color.New(0, 0, 0)

				var_4_20.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_18) / var_4_19)
				arg_1_1.mask_.color = var_4_20
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_21 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_21.a = 0
				arg_1_1.mask_.color = var_4_21
			end

			if 5.8 < arg_1_1.time_ and arg_1_1.time_ <= 5.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_thunderloop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_25 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_25

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_25
						arg_1_1.bgmTxt2_.text = var_4_25
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

			if 5.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 5.46666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_4_28 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_28 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_28

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_28
						arg_1_1.bgmTxt2_.text = var_4_28
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

			local var_4_29 = 7.4
			local var_4_30 = 0.625

			if 7.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_31 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_31:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_32 = arg_1_1:GetWordFromCfg(417221001)
				local var_4_33 = arg_1_1:FormatText(var_4_32.content)

				arg_1_1.text_.text = var_4_33

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 25 <= 0 and var_4_30 or var_4_30 * (utf8.len(var_4_33) / 25)

				if (25 <= 0 and var_4_30 or var_4_30 * (utf8.len(var_4_33) / 25)) > 0 and var_4_30 < var_4_35 then
					arg_1_1.talkMaxDuration = var_4_35
					var_4_29 = var_4_29 + 0.3

					if var_4_35 + var_4_29 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_29
					end
				end

				arg_1_1.text_.text = var_4_33
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221001", "story_v_out_417221.awb") ~= 0 then
					local var_4_36 = manager.audio:GetVoiceLength("story_v_out_417221", "417221001", "story_v_out_417221.awb") / 1000

					if var_4_36 + var_4_29 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_36 + var_4_29
					end

					if var_4_32.prefab_name ~= "" and arg_1_1.actors_[var_4_32.prefab_name] ~= nil then
						local var_4_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_32.prefab_name].transform, "story_v_out_417221", "417221001", "story_v_out_417221.awb")

						arg_1_1:RecordAudio("417221001", var_4_37)
						arg_1_1:RecordAudio("417221001", var_4_37)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417221", "417221001", "story_v_out_417221.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417221", "417221001", "story_v_out_417221.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_38 = var_4_29 + 0.3
			local var_4_39 = math.max(var_4_30, arg_1_1.talkMaxDuration)

			if var_4_29 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_39 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_38) / var_4_39

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417221002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417221002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417221003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 1.1

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_1 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(417221002).content)

				arg_10_1.text_.text = var_13_1

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_3 = 44 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_1) / 44)

				if (44 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_1) / 44)) > 0 and var_13_0 < var_13_3 then
					arg_10_1.talkMaxDuration = var_13_3

					if var_13_3 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_3 + 0
					end
				end

				arg_10_1.text_.text = var_13_1
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_4 = math.max(var_13_0, arg_10_1.talkMaxDuration)

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_4 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - 0) / var_13_4

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= 0 + var_13_4 and arg_10_1.time_ < 0 + var_13_4 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417221003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417221003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417221004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 1.625

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_1 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(417221003).content)

				arg_14_1.text_.text = var_17_1

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_3 = 65 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 65)

				if (65 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 65)) > 0 and var_17_0 < var_17_3 then
					arg_14_1.talkMaxDuration = var_17_3

					if var_17_3 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_3 + 0
					end
				end

				arg_14_1.text_.text = var_17_1
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_4 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_4 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_4

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_4 and arg_14_1.time_ < 0 + var_17_4 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417221004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417221004
		arg_18_1.duration_ = 4.6

		local var_18_0 = {
			zh = 4.6,
			ja = 4.566
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417221005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.35

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_1 = arg_18_1:GetWordFromCfg(417221004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 14 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 14)

				if (14 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 14)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221004", "story_v_out_417221.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221004", "story_v_out_417221.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_417221", "417221004", "story_v_out_417221.awb")

						arg_18_1:RecordAudio("417221004", var_21_6)
						arg_18_1:RecordAudio("417221004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417221", "417221004", "story_v_out_417221.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417221", "417221004", "story_v_out_417221.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_0, arg_18_1.talkMaxDuration)

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - 0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= 0 + var_21_7 and arg_18_1.time_ < 0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417221005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417221005
		arg_22_1.duration_ = 9.57

		local var_22_0 = {
			zh = 9.566,
			ja = 9.4
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play417221006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.775

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_1 = arg_22_1:GetWordFromCfg(417221005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 31 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 31)

				if (31 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 31)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221005", "story_v_out_417221.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221005", "story_v_out_417221.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_417221", "417221005", "story_v_out_417221.awb")

						arg_22_1:RecordAudio("417221005", var_25_6)
						arg_22_1:RecordAudio("417221005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417221", "417221005", "story_v_out_417221.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417221", "417221005", "story_v_out_417221.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_7 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_7 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_7

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_7 and arg_22_1.time_ < 0 + var_25_7 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play417221006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417221006
		arg_26_1.duration_ = 10.07

		local var_26_0 = {
			zh = 10.066,
			ja = 9.366
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417221007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.9

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_1 = arg_26_1:GetWordFromCfg(417221006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 36 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 36)

				if (36 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 36)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221006", "story_v_out_417221.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221006", "story_v_out_417221.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_417221", "417221006", "story_v_out_417221.awb")

						arg_26_1:RecordAudio("417221006", var_29_6)
						arg_26_1:RecordAudio("417221006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417221", "417221006", "story_v_out_417221.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417221", "417221006", "story_v_out_417221.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417221007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417221007
		arg_30_1.duration_ = 13.9

		local var_30_0 = {
			zh = 13.666,
			ja = 13.9
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play417221008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 1.075

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_1 = arg_30_1:GetWordFromCfg(417221007)
				local var_33_2 = arg_30_1:FormatText(var_33_1.content)

				arg_30_1.text_.text = var_33_2

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 43 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 43)

				if (43 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 43)) > 0 and var_33_0 < var_33_4 then
					arg_30_1.talkMaxDuration = var_33_4

					if var_33_4 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_4 + 0
					end
				end

				arg_30_1.text_.text = var_33_2
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221007", "story_v_out_417221.awb") ~= 0 then
					local var_33_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221007", "story_v_out_417221.awb") / 1000

					if var_33_5 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + 0
					end

					if var_33_1.prefab_name ~= "" and arg_30_1.actors_[var_33_1.prefab_name] ~= nil then
						local var_33_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_1.prefab_name].transform, "story_v_out_417221", "417221007", "story_v_out_417221.awb")

						arg_30_1:RecordAudio("417221007", var_33_6)
						arg_30_1:RecordAudio("417221007", var_33_6)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417221", "417221007", "story_v_out_417221.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417221", "417221007", "story_v_out_417221.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_7 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_7 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_7

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_7 and arg_30_1.time_ < 0 + var_33_7 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play417221008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417221008
		arg_34_1.duration_ = 16.73

		local var_34_0 = {
			zh = 12.4,
			ja = 16.733
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417221009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.95

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_1 = arg_34_1:GetWordFromCfg(417221008)
				local var_37_2 = arg_34_1:FormatText(var_37_1.content)

				arg_34_1.text_.text = var_37_2

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_4 = 38 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 38)

				if (38 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_2) / 38)) > 0 and var_37_0 < var_37_4 then
					arg_34_1.talkMaxDuration = var_37_4

					if var_37_4 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_4 + 0
					end
				end

				arg_34_1.text_.text = var_37_2
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221008", "story_v_out_417221.awb") ~= 0 then
					local var_37_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221008", "story_v_out_417221.awb") / 1000

					if var_37_5 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_5 + 0
					end

					if var_37_1.prefab_name ~= "" and arg_34_1.actors_[var_37_1.prefab_name] ~= nil then
						local var_37_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_1.prefab_name].transform, "story_v_out_417221", "417221008", "story_v_out_417221.awb")

						arg_34_1:RecordAudio("417221008", var_37_6)
						arg_34_1:RecordAudio("417221008", var_37_6)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417221", "417221008", "story_v_out_417221.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417221", "417221008", "story_v_out_417221.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_7 and arg_34_1.time_ < 0 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417221009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417221009
		arg_38_1.duration_ = 12.37

		local var_38_0 = {
			zh = 12.366,
			ja = 10.233
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play417221010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 1.175

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_1 = arg_38_1:GetWordFromCfg(417221009)
				local var_41_2 = arg_38_1:FormatText(var_41_1.content)

				arg_38_1.text_.text = var_41_2

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 47 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 47)

				if (47 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 47)) > 0 and var_41_0 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end

				arg_38_1.text_.text = var_41_2
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221009", "story_v_out_417221.awb") ~= 0 then
					local var_41_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221009", "story_v_out_417221.awb") / 1000

					if var_41_5 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + 0
					end

					if var_41_1.prefab_name ~= "" and arg_38_1.actors_[var_41_1.prefab_name] ~= nil then
						local var_41_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_1.prefab_name].transform, "story_v_out_417221", "417221009", "story_v_out_417221.awb")

						arg_38_1:RecordAudio("417221009", var_41_6)
						arg_38_1:RecordAudio("417221009", var_41_6)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417221", "417221009", "story_v_out_417221.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417221", "417221009", "story_v_out_417221.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_7 and arg_38_1.time_ < 0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play417221010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417221010
		arg_42_1.duration_ = 17.47

		local var_42_0 = {
			zh = 16.7,
			ja = 17.466
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play417221011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 1.225

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_1 = arg_42_1:GetWordFromCfg(417221010)
				local var_45_2 = arg_42_1:FormatText(var_45_1.content)

				arg_42_1.text_.text = var_45_2

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_4 = 49 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 49)

				if (49 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 49)) > 0 and var_45_0 < var_45_4 then
					arg_42_1.talkMaxDuration = var_45_4

					if var_45_4 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_4 + 0
					end
				end

				arg_42_1.text_.text = var_45_2
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221010", "story_v_out_417221.awb") ~= 0 then
					local var_45_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221010", "story_v_out_417221.awb") / 1000

					if var_45_5 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + 0
					end

					if var_45_1.prefab_name ~= "" and arg_42_1.actors_[var_45_1.prefab_name] ~= nil then
						local var_45_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_1.prefab_name].transform, "story_v_out_417221", "417221010", "story_v_out_417221.awb")

						arg_42_1:RecordAudio("417221010", var_45_6)
						arg_42_1:RecordAudio("417221010", var_45_6)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417221", "417221010", "story_v_out_417221.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417221", "417221010", "story_v_out_417221.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_7 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_7

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play417221011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417221011
		arg_46_1.duration_ = 6.3

		local var_46_0 = {
			zh = 5.433,
			ja = 6.3
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417221012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.425

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_1 = arg_46_1:GetWordFromCfg(417221011)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 17 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 17)

				if (17 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 17)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221011", "story_v_out_417221.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221011", "story_v_out_417221.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_417221", "417221011", "story_v_out_417221.awb")

						arg_46_1:RecordAudio("417221011", var_49_6)
						arg_46_1:RecordAudio("417221011", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417221", "417221011", "story_v_out_417221.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417221", "417221011", "story_v_out_417221.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play417221012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417221012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play417221013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.6

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_1 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(417221012).content)

				arg_50_1.text_.text = var_53_1

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_3 = 24 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 24)

				if (24 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 24)) > 0 and var_53_0 < var_53_3 then
					arg_50_1.talkMaxDuration = var_53_3

					if var_53_3 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_3 + 0
					end
				end

				arg_50_1.text_.text = var_53_1
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_4 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_4

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play417221013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417221013
		arg_54_1.duration_ = 13.4

		local var_54_0 = {
			zh = 13.4,
			ja = 12.066
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play417221014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 1.15

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_1 = arg_54_1:GetWordFromCfg(417221013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 46 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 46)

				if (46 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 46)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221013", "story_v_out_417221.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221013", "story_v_out_417221.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_417221", "417221013", "story_v_out_417221.awb")

						arg_54_1:RecordAudio("417221013", var_57_6)
						arg_54_1:RecordAudio("417221013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417221", "417221013", "story_v_out_417221.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417221", "417221013", "story_v_out_417221.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play417221014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417221014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play417221015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_61_1 = 0
			local var_61_2 = 0.725

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_3 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(417221014).content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 29 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 29)

				if (29 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 29)) > 0 and var_61_2 < var_61_5 then
					arg_58_1.talkMaxDuration = var_61_5

					if var_61_5 + var_61_1 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + var_61_1
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_6 = math.max(var_61_2, arg_58_1.talkMaxDuration)

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_6 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_1) / var_61_6

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_1 + var_61_6 and arg_58_1.time_ < var_61_1 + var_61_6 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417221015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417221015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play417221016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 1.1

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(417221015).content)

				arg_62_1.text_.text = var_65_1

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_3 = 44 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 44)

				if (44 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 44)) > 0 and var_65_0 < var_65_3 then
					arg_62_1.talkMaxDuration = var_65_3

					if var_65_3 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_3 + 0
					end
				end

				arg_62_1.text_.text = var_65_1
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_4 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_4

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play417221016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417221016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play417221017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 1.625

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(417221016).content)

				arg_66_1.text_.text = var_69_1

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_3 = 65 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 65)

				if (65 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 65)) > 0 and var_69_0 < var_69_3 then
					arg_66_1.talkMaxDuration = var_69_3

					if var_69_3 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_3 + 0
					end
				end

				arg_66_1.text_.text = var_69_1
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_4 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_4

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play417221017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417221017
		arg_70_1.duration_ = 3.63

		local var_70_0 = {
			zh = 2.233,
			ja = 3.633
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
				arg_70_0:Play417221018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.actors_["10113"] == nil then
				local var_73_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_73_0) then
					local var_73_1 = Object.Instantiate(var_73_0, arg_70_1.canvasGo_.transform)

					var_73_1.transform:SetSiblingIndex(1)

					var_73_1.name = "10113"
					var_73_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_70_1.actors_["10113"] = var_73_1

					if arg_70_1.isInRecall_ then
						for iter_73_0, iter_73_1 in ipairs((var_73_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_73_1.color = arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_73_2 = arg_70_1.actors_["10113"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps10113 == nil then
				arg_70_1.var_.actorSpriteComps10113 = var_73_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_3 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.actorSpriteComps10113 then
					for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_73_3 then
							if arg_70_1.isInRecall_ then
								iter_73_3.color = Color.New(Mathf.Lerp(iter_73_3.color.r, arg_70_1.hightColor1.r, (arg_70_1.time_ - 0) / var_73_3), Mathf.Lerp(iter_73_3.color.g, arg_70_1.hightColor1.g, (arg_70_1.time_ - 0) / var_73_3), (Mathf.Lerp(iter_73_3.color.b, arg_70_1.hightColor1.b, (arg_70_1.time_ - 0) / var_73_3)))
							else
								local var_73_4 = Mathf.Lerp(iter_73_3.color.r, 1, (arg_70_1.time_ - 0) / var_73_3)

								iter_73_3.color = Color.New(var_73_4, var_73_4, var_73_4)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps10113 then
				for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_73_5 then
						iter_73_5.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_70_1.var_.actorSpriteComps10113 = nil
			end

			local var_73_5 = arg_70_1.actors_["10113"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos10113 = var_73_5.localPosition
				var_73_5.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("10113", 3)

				for iter_73_6 = 0, var_73_5.childCount - 1 do
					local var_73_6 = var_73_5:GetChild(iter_73_6)

					if var_73_6.name == "" or not string.find(var_73_6.name, "split") then
						var_73_6.gameObject:SetActive(true)
					else
						var_73_6.gameObject:SetActive(false)
					end
				end
			end

			local var_73_7 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				var_73_5.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_70_1.time_ - 0) / var_73_7)
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				var_73_5.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				local var_73_8 = arg_70_1.actors_["10113"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_73_8 then
					arg_70_1.var_.alphaOldValue10113 = var_73_8.alpha
					arg_70_1.var_.characterEffect10113 = var_73_8
				end

				arg_70_1.var_.alphaOldValue10113 = 0
			end

			local var_73_9 = 0.333333333333333

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_9 then
				if arg_70_1.var_.characterEffect10113 then
					arg_70_1.var_.characterEffect10113.alpha = Mathf.Lerp(arg_70_1.var_.alphaOldValue10113, 1, (arg_70_1.time_ - 0) / var_73_9)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_9 and arg_70_1.time_ < 0 + var_73_9 + arg_73_0 and arg_70_1.var_.characterEffect10113 then
				arg_70_1.var_.characterEffect10113.alpha = 1
			end

			local var_73_10 = 0
			local var_73_11 = 0.1

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_12 = arg_70_1:GetWordFromCfg(417221017)
				local var_73_13 = arg_70_1:FormatText(var_73_12.content)

				arg_70_1.text_.text = var_73_13

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_15 = 4 <= 0 and var_73_11 or var_73_11 * (utf8.len(var_73_13) / 4)

				if (4 <= 0 and var_73_11 or var_73_11 * (utf8.len(var_73_13) / 4)) > 0 and var_73_11 < var_73_15 then
					arg_70_1.talkMaxDuration = var_73_15

					if var_73_15 + var_73_10 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_15 + var_73_10
					end
				end

				arg_70_1.text_.text = var_73_13
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221017", "story_v_out_417221.awb") ~= 0 then
					local var_73_16 = manager.audio:GetVoiceLength("story_v_out_417221", "417221017", "story_v_out_417221.awb") / 1000

					if var_73_16 + var_73_10 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_16 + var_73_10
					end

					if var_73_12.prefab_name ~= "" and arg_70_1.actors_[var_73_12.prefab_name] ~= nil then
						local var_73_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_12.prefab_name].transform, "story_v_out_417221", "417221017", "story_v_out_417221.awb")

						arg_70_1:RecordAudio("417221017", var_73_17)
						arg_70_1:RecordAudio("417221017", var_73_17)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417221", "417221017", "story_v_out_417221.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417221", "417221017", "story_v_out_417221.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_18 = math.max(var_73_11, arg_70_1.talkMaxDuration)

			if var_73_10 <= arg_70_1.time_ and arg_70_1.time_ < var_73_10 + var_73_18 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_10) / var_73_18

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_10 + var_73_18 and arg_70_1.time_ < var_73_10 + var_73_18 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play417221018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 417221018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play417221019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos10113 = arg_74_1.actors_["10113"].transform.localPosition
				arg_74_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_74_1:CheckSpriteTmpPos("10113", 7)

				for iter_77_0 = 0, arg_74_1.actors_["10113"].transform.childCount - 1 do
					local var_77_0 = arg_74_1.actors_["10113"].transform:GetChild(iter_77_0)

					if var_77_0.name == "" or not string.find(var_77_0.name, "split") then
						var_77_0.gameObject:SetActive(true)
					else
						var_77_0.gameObject:SetActive(false)
					end
				end
			end

			local var_77_1 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_1 then
				arg_74_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_74_1.time_ - 0) / var_77_1)
			end

			if arg_74_1.time_ >= 0 + var_77_1 and arg_74_1.time_ < 0 + var_77_1 + arg_77_0 then
				arg_74_1.actors_["10113"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_77_2 = 0
			local var_77_3 = 0.725

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_4 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(417221018).content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_6 = 29 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 29)

				if (29 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 29)) > 0 and var_77_3 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_3, arg_74_1.talkMaxDuration)

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_2) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_2 + var_77_7 and arg_74_1.time_ < var_77_2 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play417221019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 417221019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play417221020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 1.625

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_1 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(417221019).content)

				arg_78_1.text_.text = var_81_1

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_3 = 65 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 65)

				if (65 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 65)) > 0 and var_81_0 < var_81_3 then
					arg_78_1.talkMaxDuration = var_81_3

					if var_81_3 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_3 + 0
					end
				end

				arg_78_1.text_.text = var_81_1
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_4 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_4

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play417221020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 417221020
		arg_82_1.duration_ = 6.5

		local var_82_0 = {
			zh = 6.5,
			ja = 6.233
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
				arg_82_0:Play417221021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["10113"]) and arg_82_1.var_.actorSpriteComps10113 == nil then
				arg_82_1.var_.actorSpriteComps10113 = arg_82_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_0 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["10113"]) then
				if arg_82_1.var_.actorSpriteComps10113 then
					for iter_85_0, iter_85_1 in pairs(arg_82_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_85_1 then
							if arg_82_1.isInRecall_ then
								iter_85_1.color = Color.New(Mathf.Lerp(iter_85_1.color.r, arg_82_1.hightColor1.r, (arg_82_1.time_ - 0) / var_85_0), Mathf.Lerp(iter_85_1.color.g, arg_82_1.hightColor1.g, (arg_82_1.time_ - 0) / var_85_0), (Mathf.Lerp(iter_85_1.color.b, arg_82_1.hightColor1.b, (arg_82_1.time_ - 0) / var_85_0)))
							else
								local var_85_1 = Mathf.Lerp(iter_85_1.color.r, 1, (arg_82_1.time_ - 0) / var_85_0)

								iter_85_1.color = Color.New(var_85_1, var_85_1, var_85_1)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["10113"]) and arg_82_1.var_.actorSpriteComps10113 then
				for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_85_3 then
						iter_85_3.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_82_1.var_.actorSpriteComps10113 = nil
			end

			local var_85_2 = arg_82_1.actors_["10113"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos10113 = var_85_2.localPosition
				var_85_2.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("10113", 3)

				for iter_85_4 = 0, var_85_2.childCount - 1 do
					local var_85_3 = var_85_2:GetChild(iter_85_4)

					if var_85_3.name == "split_1" or not string.find(var_85_3.name, "split") then
						var_85_3.gameObject:SetActive(true)
					else
						var_85_3.gameObject:SetActive(false)
					end
				end
			end

			local var_85_4 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 then
				var_85_2.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_82_1.time_ - 0) / var_85_4)
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 then
				var_85_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_85_5 = 0
			local var_85_6 = 0.625

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_7 = arg_82_1:GetWordFromCfg(417221020)
				local var_85_8 = arg_82_1:FormatText(var_85_7.content)

				arg_82_1.text_.text = var_85_8

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_10 = 25 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_8) / 25)

				if (25 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_8) / 25)) > 0 and var_85_6 < var_85_10 then
					arg_82_1.talkMaxDuration = var_85_10

					if var_85_10 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_5
					end
				end

				arg_82_1.text_.text = var_85_8
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221020", "story_v_out_417221.awb") ~= 0 then
					local var_85_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221020", "story_v_out_417221.awb") / 1000

					if var_85_11 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_5
					end

					if var_85_7.prefab_name ~= "" and arg_82_1.actors_[var_85_7.prefab_name] ~= nil then
						local var_85_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_7.prefab_name].transform, "story_v_out_417221", "417221020", "story_v_out_417221.awb")

						arg_82_1:RecordAudio("417221020", var_85_12)
						arg_82_1:RecordAudio("417221020", var_85_12)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_417221", "417221020", "story_v_out_417221.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_417221", "417221020", "story_v_out_417221.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_13 = math.max(var_85_6, arg_82_1.talkMaxDuration)

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_13 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_5) / var_85_13

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_5 + var_85_13 and arg_82_1.time_ < var_85_5 + var_85_13 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play417221021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 417221021
		arg_86_1.duration_ = 4.5

		local var_86_0 = {
			zh = 2.933,
			ja = 4.5
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
				arg_86_0:Play417221022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.25

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:GetWordFromCfg(417221021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 10 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 10)

				if (10 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 10)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221021", "story_v_out_417221.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221021", "story_v_out_417221.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_417221", "417221021", "story_v_out_417221.awb")

						arg_86_1:RecordAudio("417221021", var_89_6)
						arg_86_1:RecordAudio("417221021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_417221", "417221021", "story_v_out_417221.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_417221", "417221021", "story_v_out_417221.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play417221022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 417221022
		arg_90_1.duration_ = 5.1

		local var_90_0 = {
			zh = 5.1,
			ja = 4.666
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
				arg_90_0:Play417221023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.575

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:GetWordFromCfg(417221022)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 20 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 20)

				if (20 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 20)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221022", "story_v_out_417221.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221022", "story_v_out_417221.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_417221", "417221022", "story_v_out_417221.awb")

						arg_90_1:RecordAudio("417221022", var_93_6)
						arg_90_1:RecordAudio("417221022", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_417221", "417221022", "story_v_out_417221.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_417221", "417221022", "story_v_out_417221.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play417221023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 417221023
		arg_94_1.duration_ = 5.47

		local var_94_0 = {
			zh = 4.166,
			ja = 5.466
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
				arg_94_0:Play417221024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if arg_94_1.bgs_.ST69 == nil then
				local var_97_0 = Object.Instantiate(arg_94_1.paintGo_)

				var_97_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST69")
				var_97_0.name = "ST69"
				var_97_0.transform.parent = arg_94_1.stage_.transform
				var_97_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.bgs_.ST69 = var_97_0
			end

			if 1 < arg_94_1.time_ and arg_94_1.time_ <= 1 + arg_97_0 then
				local var_97_1 = arg_94_1.bgs_.ST69

				arg_94_1.bgs_.ST69.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_97_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_97_2 = var_97_1:GetComponent("SpriteRenderer")

				if var_97_2 and var_97_2.sprite then
					local var_97_3 = 2 * (var_97_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_97_1.transform.localScale = Vector3.New(var_97_3 / var_97_2.sprite.bounds.size.y < var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x and var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x or var_97_3 / var_97_2.sprite.bounds.size.y, var_97_3 / var_97_2.sprite.bounds.size.y < var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x and var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x or var_97_3 / var_97_2.sprite.bounds.size.y, 0)
				end

				for iter_97_0, iter_97_1 in pairs(arg_94_1.bgs_) do
					if iter_97_0 ~= "ST69" then
						iter_97_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_97_4 = 3

			if 3 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.allBtn_.enabled = false
			end

			if arg_94_1.time_ >= var_97_4 + 0.0750000000000002 and arg_94_1.time_ < var_97_4 + 0.0750000000000002 + arg_97_0 then
				arg_94_1.allBtn_.enabled = true
			end

			local var_97_5 = 0

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_6 = 1

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 then
				local var_97_7 = Color.New(0, 0, 0)

				var_97_7.a = Mathf.Lerp(0, 1, (arg_94_1.time_ - var_97_5) / var_97_6)
				arg_94_1.mask_.color = var_97_7
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 then
				local var_97_8 = Color.New(0, 0, 0)

				var_97_8.a = 1
				arg_94_1.mask_.color = var_97_8
			end

			local var_97_9 = 1

			if 1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_10 = 2

			if var_97_9 <= arg_94_1.time_ and arg_94_1.time_ < var_97_9 + var_97_10 then
				local var_97_11 = Color.New(0, 0, 0)

				var_97_11.a = Mathf.Lerp(1, 0, (arg_94_1.time_ - var_97_9) / var_97_10)
				arg_94_1.mask_.color = var_97_11
			end

			if arg_94_1.time_ >= var_97_9 + var_97_10 and arg_94_1.time_ < var_97_9 + var_97_10 + arg_97_0 then
				local var_97_12 = Color.New(0, 0, 0)

				arg_94_1.mask_.enabled = false
				var_97_12.a = 0
				arg_94_1.mask_.color = var_97_12
			end

			local var_97_13 = "1034"

			if arg_94_1.actors_["1034"] == nil then
				local var_97_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_97_14) then
					local var_97_15 = Object.Instantiate(var_97_14, arg_94_1.canvasGo_.transform)

					var_97_15.transform:SetSiblingIndex(1)

					var_97_15.name = var_97_13
					var_97_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_94_1.actors_[var_97_13] = var_97_15

					if arg_94_1.isInRecall_ then
						for iter_97_2, iter_97_3 in ipairs((var_97_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_97_3.color = arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_97_16 = arg_94_1.actors_["1034"].transform

			if 2.73266666666667 < arg_94_1.time_ and arg_94_1.time_ <= 2.73266666666667 + arg_97_0 then
				arg_94_1.var_.moveOldPos1034 = var_97_16.localPosition
				var_97_16.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("1034", 3)

				for iter_97_4 = 0, var_97_16.childCount - 1 do
					local var_97_17 = var_97_16:GetChild(iter_97_4)

					if var_97_17.name == "split_6" or not string.find(var_97_17.name, "split") then
						var_97_17.gameObject:SetActive(true)
					else
						var_97_17.gameObject:SetActive(false)
					end
				end
			end

			local var_97_18 = 0.001

			if 2.73266666666667 <= arg_94_1.time_ and arg_94_1.time_ < 2.73266666666667 + var_97_18 then
				var_97_16.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_94_1.time_ - 2.73266666666667) / var_97_18)
			end

			if arg_94_1.time_ >= 2.73266666666667 + var_97_18 and arg_94_1.time_ < 2.73266666666667 + var_97_18 + arg_97_0 then
				var_97_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_97_19 = arg_94_1.actors_["1034"]

			if 2.73266666666667 < arg_94_1.time_ and arg_94_1.time_ <= 2.73266666666667 + arg_97_0 and not isNil(var_97_19) and arg_94_1.var_.actorSpriteComps1034 == nil then
				arg_94_1.var_.actorSpriteComps1034 = var_97_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_20 = 0.2

			if 2.73266666666667 <= arg_94_1.time_ and arg_94_1.time_ < 2.73266666666667 + var_97_20 and not isNil(var_97_19) then
				if arg_94_1.var_.actorSpriteComps1034 then
					for iter_97_5, iter_97_6 in pairs(arg_94_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_97_6 then
							if arg_94_1.isInRecall_ then
								iter_97_6.color = Color.New(Mathf.Lerp(iter_97_6.color.r, arg_94_1.hightColor1.r, (arg_94_1.time_ - 2.73266666666667) / var_97_20), Mathf.Lerp(iter_97_6.color.g, arg_94_1.hightColor1.g, (arg_94_1.time_ - 2.73266666666667) / var_97_20), (Mathf.Lerp(iter_97_6.color.b, arg_94_1.hightColor1.b, (arg_94_1.time_ - 2.73266666666667) / var_97_20)))
							else
								local var_97_21 = Mathf.Lerp(iter_97_6.color.r, 1, (arg_94_1.time_ - 2.73266666666667) / var_97_20)

								iter_97_6.color = Color.New(var_97_21, var_97_21, var_97_21)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 2.73266666666667 + var_97_20 and arg_94_1.time_ < 2.73266666666667 + var_97_20 + arg_97_0 and not isNil(var_97_19) and arg_94_1.var_.actorSpriteComps1034 then
				for iter_97_7, iter_97_8 in pairs(arg_94_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_97_8 then
						iter_97_8.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_94_1.var_.actorSpriteComps1034 = nil
			end

			if 2.73266666666667 < arg_94_1.time_ and arg_94_1.time_ <= 2.73266666666667 + arg_97_0 then
				local var_97_22 = arg_94_1.actors_["1034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_97_22 then
					arg_94_1.var_.alphaOldValue1034 = var_97_22.alpha
					arg_94_1.var_.characterEffect1034 = var_97_22
				end

				arg_94_1.var_.alphaOldValue1034 = 0
			end

			local var_97_23 = 0.267333333333333

			if 2.73266666666667 <= arg_94_1.time_ and arg_94_1.time_ < 2.73266666666667 + var_97_23 then
				if arg_94_1.var_.characterEffect1034 then
					arg_94_1.var_.characterEffect1034.alpha = Mathf.Lerp(arg_94_1.var_.alphaOldValue1034, 1, (arg_94_1.time_ - 2.73266666666667) / var_97_23)
				end
			end

			if arg_94_1.time_ >= 2.73266666666667 + var_97_23 and arg_94_1.time_ < 2.73266666666667 + var_97_23 + arg_97_0 and arg_94_1.var_.characterEffect1034 then
				arg_94_1.var_.characterEffect1034.alpha = 1
			end

			local var_97_24 = arg_94_1.actors_["10113"].transform

			if 1 < arg_94_1.time_ and arg_94_1.time_ <= 1 + arg_97_0 then
				arg_94_1.var_.moveOldPos10113 = var_97_24.localPosition
				var_97_24.localScale = Vector3.New(1, 1, 1)

				arg_94_1:CheckSpriteTmpPos("10113", 7)

				for iter_97_9 = 0, var_97_24.childCount - 1 do
					local var_97_25 = var_97_24:GetChild(iter_97_9)

					if var_97_25.name == "" or not string.find(var_97_25.name, "split") then
						var_97_25.gameObject:SetActive(true)
					else
						var_97_25.gameObject:SetActive(false)
					end
				end
			end

			local var_97_26 = 0.001

			if 1 <= arg_94_1.time_ and arg_94_1.time_ < 1 + var_97_26 then
				var_97_24.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_94_1.time_ - 1) / var_97_26)
			end

			if arg_94_1.time_ >= 1 + var_97_26 and arg_94_1.time_ < 1 + var_97_26 + arg_97_0 then
				var_97_24.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.2 < arg_94_1.time_ and arg_94_1.time_ <= 0.2 + arg_97_0 then
				arg_94_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_thunderloop", "")
			end

			if arg_94_1.frameCnt_ <= 1 then
				arg_94_1.dialog_:SetActive(false)
			end

			local var_97_28 = 3
			local var_97_29 = 0.075

			if 3 < arg_94_1.time_ and arg_94_1.time_ <= var_97_28 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				arg_94_1.dialog_:SetActive(true)

				arg_94_1.dialogCg_.alpha = 0

				local var_97_30 = LeanTween.value(arg_94_1.dialog_, 0, 1, 0.3)

				var_97_30:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_94_1.dialogCg_.alpha = arg_98_0
				end))
				var_97_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_94_1.dialog_)
					var_97_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_94_1.duration_ = arg_94_1.duration_ + 0.3

				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_31 = arg_94_1:GetWordFromCfg(417221023)
				local var_97_32 = arg_94_1:FormatText(var_97_31.content)

				arg_94_1.text_.text = var_97_32

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_34 = 3 <= 0 and var_97_29 or var_97_29 * (utf8.len(var_97_32) / 3)

				if (3 <= 0 and var_97_29 or var_97_29 * (utf8.len(var_97_32) / 3)) > 0 and var_97_29 < var_97_34 then
					arg_94_1.talkMaxDuration = var_97_34
					var_97_28 = var_97_28 + 0.3

					if var_97_34 + var_97_28 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_34 + var_97_28
					end
				end

				arg_94_1.text_.text = var_97_32
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221023", "story_v_out_417221.awb") ~= 0 then
					local var_97_35 = manager.audio:GetVoiceLength("story_v_out_417221", "417221023", "story_v_out_417221.awb") / 1000

					if var_97_35 + var_97_28 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_35 + var_97_28
					end

					if var_97_31.prefab_name ~= "" and arg_94_1.actors_[var_97_31.prefab_name] ~= nil then
						local var_97_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_31.prefab_name].transform, "story_v_out_417221", "417221023", "story_v_out_417221.awb")

						arg_94_1:RecordAudio("417221023", var_97_36)
						arg_94_1:RecordAudio("417221023", var_97_36)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_417221", "417221023", "story_v_out_417221.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_417221", "417221023", "story_v_out_417221.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_37 = var_97_28 + 0.3
			local var_97_38 = math.max(var_97_29, arg_94_1.talkMaxDuration)

			if var_97_28 + 0.3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_37 + var_97_38 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_37) / var_97_38

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_37 + var_97_38 and arg_94_1.time_ < var_97_37 + var_97_38 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.73266666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play417221024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 417221024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play417221025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1034 = arg_100_1.actors_["1034"].transform.localPosition
				arg_100_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("1034", 7)

				for iter_103_0 = 0, arg_100_1.actors_["1034"].transform.childCount - 1 do
					local var_103_0 = arg_100_1.actors_["1034"].transform:GetChild(iter_103_0)

					if var_103_0.name == "" or not string.find(var_103_0.name, "split") then
						var_103_0.gameObject:SetActive(true)
					else
						var_103_0.gameObject:SetActive(false)
					end
				end
			end

			local var_103_1 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_1 then
				arg_100_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_100_1.time_ - 0) / var_103_1)
			end

			if arg_100_1.time_ >= 0 + var_103_1 and arg_100_1.time_ < 0 + var_103_1 + arg_103_0 then
				arg_100_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.36666666666667 < arg_100_1.time_ and arg_100_1.time_ <= 1.36666666666667 + arg_103_0 then
				arg_100_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_uiout", "")
			end

			local var_103_3 = 0
			local var_103_4 = 1.15

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_3 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_5 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(417221024).content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 46 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_5) / 46)

				if (46 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_5) / 46)) > 0 and var_103_4 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_3 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_3
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_4, arg_100_1.talkMaxDuration)

			if var_103_3 <= arg_100_1.time_ and arg_100_1.time_ < var_103_3 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_3) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_3 + var_103_8 and arg_100_1.time_ < var_103_3 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play417221025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417221025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play417221026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 1.25

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(417221025).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 50 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 50)

				if (50 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 50)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play417221026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417221026
		arg_108_1.duration_ = 6

		local var_108_0 = {
			zh = 5.1,
			ja = 6
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play417221027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1034"]) and arg_108_1.var_.actorSpriteComps1034 == nil then
				arg_108_1.var_.actorSpriteComps1034 = arg_108_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_0 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1034"]) then
				if arg_108_1.var_.actorSpriteComps1034 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								iter_111_1.color = Color.New(Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor1.r, (arg_108_1.time_ - 0) / var_111_0), Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor1.g, (arg_108_1.time_ - 0) / var_111_0), (Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor1.b, (arg_108_1.time_ - 0) / var_111_0)))
							else
								local var_111_1 = Mathf.Lerp(iter_111_1.color.r, 1, (arg_108_1.time_ - 0) / var_111_0)

								iter_111_1.color = Color.New(var_111_1, var_111_1, var_111_1)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1034"]) and arg_108_1.var_.actorSpriteComps1034 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_111_3 then
						iter_111_3.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_108_1.var_.actorSpriteComps1034 = nil
			end

			local var_111_2 = arg_108_1.actors_["1034"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1034 = var_111_2.localPosition
				var_111_2.localScale = Vector3.New(1, 1, 1)

				arg_108_1:CheckSpriteTmpPos("1034", 3)

				for iter_111_4 = 0, var_111_2.childCount - 1 do
					local var_111_3 = var_111_2:GetChild(iter_111_4)

					if var_111_3.name == "split_6" or not string.find(var_111_3.name, "split") then
						var_111_3.gameObject:SetActive(true)
					else
						var_111_3.gameObject:SetActive(false)
					end
				end
			end

			local var_111_4 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				var_111_2.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_108_1.time_ - 0) / var_111_4)
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				var_111_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_111_5 = 0
			local var_111_6 = 0.575

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_7 = arg_108_1:GetWordFromCfg(417221026)
				local var_111_8 = arg_108_1:FormatText(var_111_7.content)

				arg_108_1.text_.text = var_111_8

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_10 = 23 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 23)

				if (23 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 23)) > 0 and var_111_6 < var_111_10 then
					arg_108_1.talkMaxDuration = var_111_10

					if var_111_10 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_5
					end
				end

				arg_108_1.text_.text = var_111_8
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221026", "story_v_out_417221.awb") ~= 0 then
					local var_111_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221026", "story_v_out_417221.awb") / 1000

					if var_111_11 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_11 + var_111_5
					end

					if var_111_7.prefab_name ~= "" and arg_108_1.actors_[var_111_7.prefab_name] ~= nil then
						local var_111_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_7.prefab_name].transform, "story_v_out_417221", "417221026", "story_v_out_417221.awb")

						arg_108_1:RecordAudio("417221026", var_111_12)
						arg_108_1:RecordAudio("417221026", var_111_12)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417221", "417221026", "story_v_out_417221.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417221", "417221026", "story_v_out_417221.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_13 = math.max(var_111_6, arg_108_1.talkMaxDuration)

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_13 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_5) / var_111_13

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_5 + var_111_13 and arg_108_1.time_ < var_111_5 + var_111_13 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play417221027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417221027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play417221028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1034 = arg_112_1.actors_["1034"].transform.localPosition
				arg_112_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_112_1:CheckSpriteTmpPos("1034", 7)

				for iter_115_0 = 0, arg_112_1.actors_["1034"].transform.childCount - 1 do
					local var_115_0 = arg_112_1.actors_["1034"].transform:GetChild(iter_115_0)

					if var_115_0.name == "" or not string.find(var_115_0.name, "split") then
						var_115_0.gameObject:SetActive(true)
					else
						var_115_0.gameObject:SetActive(false)
					end
				end
			end

			local var_115_1 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_1 then
				arg_112_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_112_1.time_ - 0) / var_115_1)
			end

			if arg_112_1.time_ >= 0 + var_115_1 and arg_112_1.time_ < 0 + var_115_1 + arg_115_0 then
				arg_112_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_115_2 = 0
			local var_115_3 = 1.475

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(417221027).content)

				arg_112_1.text_.text = var_115_4

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_6 = 59 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_4) / 59)

				if (59 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_4) / 59)) > 0 and var_115_3 < var_115_6 then
					arg_112_1.talkMaxDuration = var_115_6

					if var_115_6 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_4
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_7 and arg_112_1.time_ < var_115_2 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play417221028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417221028
		arg_116_1.duration_ = 6.3

		local var_116_0 = {
			zh = 6.30066666666667,
			ja = 5.60066666666667
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
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play417221029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 2 < arg_116_1.time_ and arg_116_1.time_ <= 2 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			if arg_116_1.time_ >= 2 + 0.3 and arg_116_1.time_ < 2 + 0.3 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			if 1.00066666666667 < arg_116_1.time_ and arg_116_1.time_ <= 1.00066666666667 + arg_119_0 then
				local var_119_0 = arg_116_1.bgs_.ST69

				arg_116_1.bgs_.ST69.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_119_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_119_1 = var_119_0:GetComponent("SpriteRenderer")

				if var_119_1 and var_119_1.sprite then
					local var_119_2 = 2 * (var_119_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_119_0.transform.localScale = Vector3.New(var_119_2 / var_119_1.sprite.bounds.size.y < var_119_2 * manager.ui.mainCameraCom_.aspect / var_119_1.sprite.bounds.size.x and var_119_2 * manager.ui.mainCameraCom_.aspect / var_119_1.sprite.bounds.size.x or var_119_2 / var_119_1.sprite.bounds.size.y, var_119_2 / var_119_1.sprite.bounds.size.y < var_119_2 * manager.ui.mainCameraCom_.aspect / var_119_1.sprite.bounds.size.x and var_119_2 * manager.ui.mainCameraCom_.aspect / var_119_1.sprite.bounds.size.x or var_119_2 / var_119_1.sprite.bounds.size.y, 0)
				end

				for iter_119_0, iter_119_1 in pairs(arg_116_1.bgs_) do
					if iter_119_0 ~= "ST69" then
						iter_119_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_119_3 = 0

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_3 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_4 = 1

			if var_119_3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_3 + var_119_4 then
				local var_119_5 = Color.New(0, 0, 0)

				var_119_5.a = Mathf.Lerp(0, 1, (arg_116_1.time_ - var_119_3) / var_119_4)
				arg_116_1.mask_.color = var_119_5
			end

			if arg_116_1.time_ >= var_119_3 + var_119_4 and arg_116_1.time_ < var_119_3 + var_119_4 + arg_119_0 then
				local var_119_6 = Color.New(0, 0, 0)

				var_119_6.a = 1
				arg_116_1.mask_.color = var_119_6
			end

			local var_119_7 = 1

			if 1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_7 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_8 = 0.999999999999998

			if var_119_7 <= arg_116_1.time_ and arg_116_1.time_ < var_119_7 + var_119_8 then
				local var_119_9 = Color.New(0, 0, 0)

				var_119_9.a = Mathf.Lerp(1, 0, (arg_116_1.time_ - var_119_7) / var_119_8)
				arg_116_1.mask_.color = var_119_9
			end

			if arg_116_1.time_ >= var_119_7 + var_119_8 and arg_116_1.time_ < var_119_7 + var_119_8 + arg_119_0 then
				local var_119_10 = Color.New(0, 0, 0)

				arg_116_1.mask_.enabled = false
				var_119_10.a = 0
				arg_116_1.mask_.color = var_119_10
			end

			local var_119_11 = arg_116_1.actors_["1034"].transform

			if 0.966666666666667 < arg_116_1.time_ and arg_116_1.time_ <= 0.966666666666667 + arg_119_0 then
				arg_116_1.var_.moveOldPos1034 = var_119_11.localPosition
				var_119_11.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1034", 7)

				for iter_119_2 = 0, var_119_11.childCount - 1 do
					local var_119_12 = var_119_11:GetChild(iter_119_2)

					if var_119_12.name == "" or not string.find(var_119_12.name, "split") then
						var_119_12.gameObject:SetActive(true)
					else
						var_119_12.gameObject:SetActive(false)
					end
				end
			end

			local var_119_13 = 0.001

			if 0.966666666666667 <= arg_116_1.time_ and arg_116_1.time_ < 0.966666666666667 + var_119_13 then
				var_119_11.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_116_1.time_ - 0.966666666666667) / var_119_13)
			end

			if arg_116_1.time_ >= 0.966666666666667 + var_119_13 and arg_116_1.time_ < 0.966666666666667 + var_119_13 + arg_119_0 then
				var_119_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_119_14 = arg_116_1.actors_["1034"].transform

			if 1.83333333333333 < arg_116_1.time_ and arg_116_1.time_ <= 1.83333333333333 + arg_119_0 then
				arg_116_1.var_.moveOldPos1034 = var_119_14.localPosition
				var_119_14.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1034", 3)

				for iter_119_3 = 0, var_119_14.childCount - 1 do
					local var_119_15 = var_119_14:GetChild(iter_119_3)

					if var_119_15.name == "split_5" or not string.find(var_119_15.name, "split") then
						var_119_15.gameObject:SetActive(true)
					else
						var_119_15.gameObject:SetActive(false)
					end
				end
			end

			local var_119_16 = 0.001

			if 1.83333333333333 <= arg_116_1.time_ and arg_116_1.time_ < 1.83333333333333 + var_119_16 then
				var_119_14.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_116_1.time_ - 1.83333333333333) / var_119_16)
			end

			if arg_116_1.time_ >= 1.83333333333333 + var_119_16 and arg_116_1.time_ < 1.83333333333333 + var_119_16 + arg_119_0 then
				var_119_14.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_119_17 = arg_116_1.actors_["1034"]

			if 1.83333333333333 < arg_116_1.time_ and arg_116_1.time_ <= 1.83333333333333 + arg_119_0 and not isNil(var_119_17) and arg_116_1.var_.actorSpriteComps1034 == nil then
				arg_116_1.var_.actorSpriteComps1034 = var_119_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_18 = 0.167333333333333

			if 1.83333333333333 <= arg_116_1.time_ and arg_116_1.time_ < 1.83333333333333 + var_119_18 and not isNil(var_119_17) then
				if arg_116_1.var_.actorSpriteComps1034 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_119_5 then
							if arg_116_1.isInRecall_ then
								iter_119_5.color = Color.New(Mathf.Lerp(iter_119_5.color.r, arg_116_1.hightColor1.r, (arg_116_1.time_ - 1.83333333333333) / var_119_18), Mathf.Lerp(iter_119_5.color.g, arg_116_1.hightColor1.g, (arg_116_1.time_ - 1.83333333333333) / var_119_18), (Mathf.Lerp(iter_119_5.color.b, arg_116_1.hightColor1.b, (arg_116_1.time_ - 1.83333333333333) / var_119_18)))
							else
								local var_119_19 = Mathf.Lerp(iter_119_5.color.r, 1, (arg_116_1.time_ - 1.83333333333333) / var_119_18)

								iter_119_5.color = Color.New(var_119_19, var_119_19, var_119_19)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 1.83333333333333 + var_119_18 and arg_116_1.time_ < 1.83333333333333 + var_119_18 + arg_119_0 and not isNil(var_119_17) and arg_116_1.var_.actorSpriteComps1034 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_119_7 then
						iter_119_7.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_116_1.var_.actorSpriteComps1034 = nil
			end

			if 1.83333333333333 < arg_116_1.time_ and arg_116_1.time_ <= 1.83333333333333 + arg_119_0 then
				local var_119_20 = arg_116_1.actors_["1034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_119_20 then
					arg_116_1.var_.alphaOldValue1034 = var_119_20.alpha
					arg_116_1.var_.characterEffect1034 = var_119_20
				end

				arg_116_1.var_.alphaOldValue1034 = 0
			end

			local var_119_21 = 0.167333333333333

			if 1.83333333333333 <= arg_116_1.time_ and arg_116_1.time_ < 1.83333333333333 + var_119_21 then
				if arg_116_1.var_.characterEffect1034 then
					arg_116_1.var_.characterEffect1034.alpha = Mathf.Lerp(arg_116_1.var_.alphaOldValue1034, 1, (arg_116_1.time_ - 1.83333333333333) / var_119_21)
				end
			end

			if arg_116_1.time_ >= 1.83333333333333 + var_119_21 and arg_116_1.time_ < 1.83333333333333 + var_119_21 + arg_119_0 and arg_116_1.var_.characterEffect1034 then
				arg_116_1.var_.characterEffect1034.alpha = 1
			end

			local var_119_22 = 1.00066666666667

			arg_116_1.isInRecall_ = true

			if var_119_22 < arg_116_1.time_ and arg_116_1.time_ <= var_119_22 + arg_119_0 then
				arg_116_1.screenFilterGo_:SetActive(true)

				arg_116_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_116_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_116_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_119_8, iter_119_9 in pairs(arg_116_1.actors_) do
					for iter_119_10, iter_119_11 in ipairs((iter_119_9:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_119_11.color = iter_119_11.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_119_23 = 0.0660000000000001

			if var_119_22 <= arg_116_1.time_ and arg_116_1.time_ < var_119_22 + var_119_23 then
				arg_116_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_116_1.time_ - var_119_22) / var_119_23)
			end

			if arg_116_1.time_ >= var_119_22 + var_119_23 and arg_116_1.time_ < var_119_22 + var_119_23 + arg_119_0 then
				arg_116_1.screenFilterEffect_.weight = 1
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_24 = 2.00066666666667
			local var_119_25 = 0.55

			if 2.00066666666667 < arg_116_1.time_ and arg_116_1.time_ <= var_119_24 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_26 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_26:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_116_1.dialogCg_.alpha = arg_120_0
				end))
				var_119_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_27 = arg_116_1:GetWordFromCfg(417221028)
				local var_119_28 = arg_116_1:FormatText(var_119_27.content)

				arg_116_1.text_.text = var_119_28

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_30 = 22 <= 0 and var_119_25 or var_119_25 * (utf8.len(var_119_28) / 22)

				if (22 <= 0 and var_119_25 or var_119_25 * (utf8.len(var_119_28) / 22)) > 0 and var_119_25 < var_119_30 then
					arg_116_1.talkMaxDuration = var_119_30
					var_119_24 = var_119_24 + 0.3

					if var_119_30 + var_119_24 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_30 + var_119_24
					end
				end

				arg_116_1.text_.text = var_119_28
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221028", "story_v_out_417221.awb") ~= 0 then
					local var_119_31 = manager.audio:GetVoiceLength("story_v_out_417221", "417221028", "story_v_out_417221.awb") / 1000

					if var_119_31 + var_119_24 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_31 + var_119_24
					end

					if var_119_27.prefab_name ~= "" and arg_116_1.actors_[var_119_27.prefab_name] ~= nil then
						local var_119_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_27.prefab_name].transform, "story_v_out_417221", "417221028", "story_v_out_417221.awb")

						arg_116_1:RecordAudio("417221028", var_119_32)
						arg_116_1:RecordAudio("417221028", var_119_32)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417221", "417221028", "story_v_out_417221.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417221", "417221028", "story_v_out_417221.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_33 = var_119_24 + 0.3
			local var_119_34 = math.max(var_119_25, arg_116_1.talkMaxDuration)

			if var_119_24 + 0.3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_33 + var_119_34 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_33) / var_119_34

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_33 + var_119_34 and arg_116_1.time_ < var_119_33 + var_119_34 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play417221029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 417221029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play417221030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1034 = arg_122_1.actors_["1034"].transform.localPosition
				arg_122_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_122_1:CheckSpriteTmpPos("1034", 7)

				for iter_125_0 = 0, arg_122_1.actors_["1034"].transform.childCount - 1 do
					local var_125_0 = arg_122_1.actors_["1034"].transform:GetChild(iter_125_0)

					if var_125_0.name == "" or not string.find(var_125_0.name, "split") then
						var_125_0.gameObject:SetActive(true)
					else
						var_125_0.gameObject:SetActive(false)
					end
				end
			end

			local var_125_1 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_1 then
				arg_122_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_122_1.time_ - 0) / var_125_1)
			end

			if arg_122_1.time_ >= 0 + var_125_1 and arg_122_1.time_ < 0 + var_125_1 + arg_125_0 then
				arg_122_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.05 < arg_122_1.time_ and arg_122_1.time_ <= 0.05 + arg_125_0 then
				arg_122_1:AudioAction("play", "effect", "se_story_129", "se_story_129_alarm", "")
			end

			local var_125_3 = 0
			local var_125_4 = 1.3

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_3 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_5 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(417221029).content)

				arg_122_1.text_.text = var_125_5

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_7 = 52 <= 0 and var_125_4 or var_125_4 * (utf8.len(var_125_5) / 52)

				if (52 <= 0 and var_125_4 or var_125_4 * (utf8.len(var_125_5) / 52)) > 0 and var_125_4 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_3 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_3
					end
				end

				arg_122_1.text_.text = var_125_5
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_8 = math.max(var_125_4, arg_122_1.talkMaxDuration)

			if var_125_3 <= arg_122_1.time_ and arg_122_1.time_ < var_125_3 + var_125_8 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_3) / var_125_8

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_3 + var_125_8 and arg_122_1.time_ < var_125_3 + var_125_8 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play417221030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 417221030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play417221031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 1.15

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(417221030).content)

				arg_126_1.text_.text = var_129_1

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_3 = 46 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 46)

				if (46 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 46)) > 0 and var_129_0 < var_129_3 then
					arg_126_1.talkMaxDuration = var_129_3

					if var_129_3 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_3 + 0
					end
				end

				arg_126_1.text_.text = var_129_1
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_4 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_4

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play417221031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 417221031
		arg_130_1.duration_ = 4.02

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play417221032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1034 = arg_130_1.actors_["1034"].transform.localPosition
				arg_130_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("1034", 7)

				for iter_133_0 = 0, arg_130_1.actors_["1034"].transform.childCount - 1 do
					local var_133_0 = arg_130_1.actors_["1034"].transform:GetChild(iter_133_0)

					if var_133_0.name == "" or not string.find(var_133_0.name, "split") then
						var_133_0.gameObject:SetActive(true)
					else
						var_133_0.gameObject:SetActive(false)
					end
				end
			end

			local var_133_1 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_1 then
				arg_130_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_130_1.time_ - 0) / var_133_1)
			end

			if arg_130_1.time_ >= 0 + var_133_1 and arg_130_1.time_ < 0 + var_133_1 + arg_133_0 then
				arg_130_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.fswbg_:SetActive(true)
				arg_130_1.dialog_:SetActive(false)

				arg_130_1.fswtw_.percent = 0
				arg_130_1.fswt_.text = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(417221031).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.fswt_)

				arg_130_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_130_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_130_1.fswtw_:SetDirty()

				arg_130_1.typewritterCharCountI18N = 0

				SetActive(arg_130_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_130_1:ShowNextGo(false)
			end

			local var_133_2 = 0.0166666666666667

			if 0.0166666666666667 < arg_130_1.time_ and arg_130_1.time_ <= var_133_2 + arg_133_0 then
				arg_130_1.var_.oldValueTypewriter = arg_130_1.fswtw_.percent

				SetActive(arg_130_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_130_1:ShowNextGo(false)
			end

			local var_133_3 = 26
			local var_133_4 = 1.73333333333333
			local var_133_5, var_133_6 = arg_130_1:GetPercentByPara(arg_130_1:FormatText(arg_130_1:GetWordFromCfg(417221031).content), 1)

			if var_133_2 < arg_130_1.time_ and arg_130_1.time_ <= var_133_2 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0

				local var_133_7 = var_133_3 <= 0 and var_133_4 or var_133_4 * ((var_133_6 - arg_130_1.typewritterCharCountI18N) / var_133_3)

				if (var_133_3 <= 0 and var_133_4 or var_133_4 * ((var_133_6 - arg_130_1.typewritterCharCountI18N) / var_133_3)) > 0 and var_133_4 < var_133_7 then
					arg_130_1.talkMaxDuration = var_133_7

					if var_133_7 + var_133_2 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_7 + var_133_2
					end
				end
			end

			local var_133_8 = math.max(1.73333333333333, arg_130_1.talkMaxDuration)

			if var_133_2 <= arg_130_1.time_ and arg_130_1.time_ < var_133_2 + var_133_8 then
				arg_130_1.fswtw_.percent = Mathf.Lerp(arg_130_1.var_.oldValueTypewriter, var_133_5, (arg_130_1.time_ - var_133_2) / var_133_8)
				arg_130_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_130_1.fswtw_:SetDirty()
			end

			if arg_130_1.time_ >= var_133_2 + var_133_8 and arg_130_1.time_ < var_133_2 + var_133_8 + arg_133_0 then
				arg_130_1.fswtw_.percent = var_133_5

				arg_130_1.fswtw_:SetDirty()
				arg_130_1:ShowNextGo(true)

				arg_130_1.typewritterCharCountI18N = var_133_6
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				local var_133_9 = arg_130_1.fswbg_.transform:Find("textbox/adapt/content") or arg_130_1.fswbg_.transform:Find("textbox/content")
				local var_133_10 = arg_130_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_133_11 = var_133_9:GetComponent("RectTransform")

				var_133_9:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_133_11.offsetMin = Vector2.New(0, 0)
				var_133_11.offsetMax = Vector2.New(0, 0)
			end

			local var_133_12

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				local var_133_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_133_13 then
					var_133_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_133_13.radialBlurScale = 0
					var_133_13.radialBlurGradient = 1
					var_133_13.radialBlurIntensity = 1

					if var_133_12 then
						var_133_13.radialBlurTarget = var_133_12.transform
					end
				end
			end

			local var_133_14 = 1.75

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_14 then
				local var_133_15 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_133_15 then
					var_133_15.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_133_15.radialBlurScale = Mathf.Lerp(0, 0, (arg_130_1.time_ - 0) / var_133_14)
					var_133_15.radialBlurGradient = Mathf.Lerp(1, 1, (arg_130_1.time_ - 0) / var_133_14)
					var_133_15.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_130_1.time_ - 0) / var_133_14)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_14 and arg_130_1.time_ < 0 + var_133_14 + arg_133_0 then
				local var_133_16 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_133_16 then
					var_133_16.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_133_16.radialBlurScale = 0
					var_133_16.radialBlurGradient = 1
					var_133_16.radialBlurIntensity = 1
				end
			end

			local var_133_17 = 0.0166666666666667
			local var_133_18 = manager.audio:GetVoiceLength("story_v_out_417221", "417221031", "story_v_out_417221.awb") / 1000

			if var_133_18 > 0 and 4 < var_133_18 and var_133_18 + var_133_17 > arg_130_1.duration_ then
				arg_130_1.duration_ = var_133_18 + var_133_17
			end

			if var_133_17 < arg_130_1.time_ and arg_130_1.time_ <= var_133_17 + arg_133_0 then
				arg_130_1:AudioAction("play", "voice", "story_v_out_417221", "417221031", "story_v_out_417221.awb")
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play417221032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 417221032
		arg_134_1.duration_ = 4.15

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play417221033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.fswbg_:SetActive(true)
				arg_134_1.dialog_:SetActive(false)

				arg_134_1.fswtw_.percent = 0
				arg_134_1.fswt_.text = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(417221032).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.fswt_)

				arg_134_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_134_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_134_1.fswtw_:SetDirty()

				arg_134_1.typewritterCharCountI18N = 0

				SetActive(arg_134_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_134_1:ShowNextGo(false)
			end

			local var_137_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.var_.oldValueTypewriter = arg_134_1.fswtw_.percent

				SetActive(arg_134_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_134_1:ShowNextGo(false)
			end

			local var_137_1 = 26
			local var_137_2 = 1.73333333333333
			local var_137_3, var_137_4 = arg_134_1:GetPercentByPara(arg_134_1:FormatText(arg_134_1:GetWordFromCfg(417221032).content), 1)

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0

				local var_137_5 = var_137_1 <= 0 and var_137_2 or var_137_2 * ((var_137_4 - arg_134_1.typewritterCharCountI18N) / var_137_1)

				if (var_137_1 <= 0 and var_137_2 or var_137_2 * ((var_137_4 - arg_134_1.typewritterCharCountI18N) / var_137_1)) > 0 and var_137_2 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_0
					end
				end
			end

			local var_137_6 = math.max(1.73333333333333, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_6 then
				arg_134_1.fswtw_.percent = Mathf.Lerp(arg_134_1.var_.oldValueTypewriter, var_137_3, (arg_134_1.time_ - var_137_0) / var_137_6)
				arg_134_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_134_1.fswtw_:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_6 and arg_134_1.time_ < var_137_0 + var_137_6 + arg_137_0 then
				arg_134_1.fswtw_.percent = var_137_3

				arg_134_1.fswtw_:SetDirty()
				arg_134_1:ShowNextGo(true)

				arg_134_1.typewritterCharCountI18N = var_137_4
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				local var_137_7 = arg_134_1.fswbg_.transform:Find("textbox/adapt/content") or arg_134_1.fswbg_.transform:Find("textbox/content")
				local var_137_8 = arg_134_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_137_9 = var_137_7:GetComponent("RectTransform")

				var_137_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_137_9.offsetMin = Vector2.New(0, 0)
				var_137_9.offsetMax = Vector2.New(0, 0)
			end

			local var_137_10 = 0.0166666666666667
			local var_137_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221032", "") / 1000

			if var_137_11 > 0 and 4.133 < var_137_11 and var_137_11 + var_137_10 > arg_134_1.duration_ then
				arg_134_1.duration_ = var_137_11 + var_137_10
			end

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 then
				arg_134_1:AudioAction("play", "voice", "story_v_out_417221", "417221032", "")
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play417221033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 417221033
		arg_138_1.duration_ = 2.42

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play417221034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.fswbg_:SetActive(true)
				arg_138_1.dialog_:SetActive(false)

				arg_138_1.fswtw_.percent = 0
				arg_138_1.fswt_.text = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(417221033).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.fswt_)

				arg_138_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_138_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_138_1.fswtw_:SetDirty()

				arg_138_1.typewritterCharCountI18N = 0

				SetActive(arg_138_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_138_1:ShowNextGo(false)
			end

			local var_141_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.var_.oldValueTypewriter = arg_138_1.fswtw_.percent

				SetActive(arg_138_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_138_1:ShowNextGo(false)
			end

			local var_141_1 = 15
			local var_141_2 = 1
			local var_141_3, var_141_4 = arg_138_1:GetPercentByPara(arg_138_1:FormatText(arg_138_1:GetWordFromCfg(417221033).content), 1)

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0

				local var_141_5 = var_141_1 <= 0 and var_141_2 or var_141_2 * ((var_141_4 - arg_138_1.typewritterCharCountI18N) / var_141_1)

				if (var_141_1 <= 0 and var_141_2 or var_141_2 * ((var_141_4 - arg_138_1.typewritterCharCountI18N) / var_141_1)) > 0 and var_141_2 < var_141_5 then
					arg_138_1.talkMaxDuration = var_141_5

					if var_141_5 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + var_141_0
					end
				end
			end

			local var_141_6 = math.max(1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_6 then
				arg_138_1.fswtw_.percent = Mathf.Lerp(arg_138_1.var_.oldValueTypewriter, var_141_3, (arg_138_1.time_ - var_141_0) / var_141_6)
				arg_138_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_138_1.fswtw_:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_6 and arg_138_1.time_ < var_141_0 + var_141_6 + arg_141_0 then
				arg_138_1.fswtw_.percent = var_141_3

				arg_138_1.fswtw_:SetDirty()
				arg_138_1:ShowNextGo(true)

				arg_138_1.typewritterCharCountI18N = var_141_4
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				local var_141_7 = arg_138_1.fswbg_.transform:Find("textbox/adapt/content") or arg_138_1.fswbg_.transform:Find("textbox/content")
				local var_141_8 = arg_138_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_141_9 = var_141_7:GetComponent("RectTransform")

				var_141_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_141_9.offsetMin = Vector2.New(0, 0)
				var_141_9.offsetMax = Vector2.New(0, 0)
			end

			local var_141_10 = 0.0166666666666667
			local var_141_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221033", "") / 1000

			if var_141_11 > 0 and 2.4 < var_141_11 and var_141_11 + var_141_10 > arg_138_1.duration_ then
				arg_138_1.duration_ = var_141_11 + var_141_10
			end

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1:AudioAction("play", "voice", "story_v_out_417221", "417221033", "")
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play417221034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 417221034
		arg_142_1.duration_ = 3.37

		local var_142_0 = {
			zh = 3.366,
			ja = 3.3
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play417221035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1034"]) and arg_142_1.var_.actorSpriteComps1034 == nil then
				arg_142_1.var_.actorSpriteComps1034 = arg_142_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_0 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1034"]) then
				if arg_142_1.var_.actorSpriteComps1034 then
					for iter_145_0, iter_145_1 in pairs(arg_142_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_145_1 then
							if arg_142_1.isInRecall_ then
								iter_145_1.color = Color.New(Mathf.Lerp(iter_145_1.color.r, arg_142_1.hightColor1.r, (arg_142_1.time_ - 0) / var_145_0), Mathf.Lerp(iter_145_1.color.g, arg_142_1.hightColor1.g, (arg_142_1.time_ - 0) / var_145_0), (Mathf.Lerp(iter_145_1.color.b, arg_142_1.hightColor1.b, (arg_142_1.time_ - 0) / var_145_0)))
							else
								local var_145_1 = Mathf.Lerp(iter_145_1.color.r, 1, (arg_142_1.time_ - 0) / var_145_0)

								iter_145_1.color = Color.New(var_145_1, var_145_1, var_145_1)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1034"]) and arg_142_1.var_.actorSpriteComps1034 then
				for iter_145_2, iter_145_3 in pairs(arg_142_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_145_3 then
						iter_145_3.color = arg_142_1.isInRecall_ and (arg_142_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_142_1.var_.actorSpriteComps1034 = nil
			end

			local var_145_2 = arg_142_1.actors_["1034"].transform

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1034 = var_145_2.localPosition
				var_145_2.localScale = Vector3.New(1, 1, 1)

				arg_142_1:CheckSpriteTmpPos("1034", 3)

				for iter_145_4 = 0, var_145_2.childCount - 1 do
					local var_145_3 = var_145_2:GetChild(iter_145_4)

					if var_145_3.name == "split_6" or not string.find(var_145_3.name, "split") then
						var_145_3.gameObject:SetActive(true)
					else
						var_145_3.gameObject:SetActive(false)
					end
				end
			end

			local var_145_4 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 then
				var_145_2.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_142_1.time_ - 0) / var_145_4)
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 then
				var_145_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.fswbg_:SetActive(false)
				arg_142_1.dialog_:SetActive(false)
				SetActive(arg_142_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_142_1:ShowNextGo(false)
			end

			local var_145_5

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				local var_145_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_145_6 then
					var_145_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_145_6.radialBlurScale = 0
					var_145_6.radialBlurGradient = 0
					var_145_6.radialBlurIntensity = 0

					if var_145_5 then
						var_145_6.radialBlurTarget = var_145_5.transform
					end
				end
			end

			local var_145_7 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_7 then
				local var_145_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_145_8 then
					var_145_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_145_8.radialBlurScale = Mathf.Lerp(0, 0, (arg_142_1.time_ - 0) / var_145_7)
					var_145_8.radialBlurGradient = Mathf.Lerp(0, 0, (arg_142_1.time_ - 0) / var_145_7)
					var_145_8.radialBlurIntensity = Mathf.Lerp(0, 0, (arg_142_1.time_ - 0) / var_145_7)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_7 and arg_142_1.time_ < 0 + var_145_7 + arg_145_0 then
				local var_145_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_145_9 then
					var_145_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_145_9.radialBlurScale = 0
					var_145_9.radialBlurGradient = 0
					var_145_9.radialBlurIntensity = 0
				end
			end

			local var_145_10 = 0
			local var_145_11 = 0.375

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_12 = arg_142_1:GetWordFromCfg(417221034)
				local var_145_13 = arg_142_1:FormatText(var_145_12.content)

				arg_142_1.text_.text = var_145_13

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_15 = 15 <= 0 and var_145_11 or var_145_11 * (utf8.len(var_145_13) / 15)

				if (15 <= 0 and var_145_11 or var_145_11 * (utf8.len(var_145_13) / 15)) > 0 and var_145_11 < var_145_15 then
					arg_142_1.talkMaxDuration = var_145_15

					if var_145_15 + var_145_10 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_15 + var_145_10
					end
				end

				arg_142_1.text_.text = var_145_13
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221034", "story_v_out_417221.awb") ~= 0 then
					local var_145_16 = manager.audio:GetVoiceLength("story_v_out_417221", "417221034", "story_v_out_417221.awb") / 1000

					if var_145_16 + var_145_10 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_16 + var_145_10
					end

					if var_145_12.prefab_name ~= "" and arg_142_1.actors_[var_145_12.prefab_name] ~= nil then
						local var_145_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_12.prefab_name].transform, "story_v_out_417221", "417221034", "story_v_out_417221.awb")

						arg_142_1:RecordAudio("417221034", var_145_17)
						arg_142_1:RecordAudio("417221034", var_145_17)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_417221", "417221034", "story_v_out_417221.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_417221", "417221034", "story_v_out_417221.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_18 = math.max(var_145_11, arg_142_1.talkMaxDuration)

			if var_145_10 <= arg_142_1.time_ and arg_142_1.time_ < var_145_10 + var_145_18 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_10) / var_145_18

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_10 + var_145_18 and arg_142_1.time_ < var_145_10 + var_145_18 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play417221035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417221035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play417221036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1034"]) and arg_146_1.var_.actorSpriteComps1034 == nil then
				arg_146_1.var_.actorSpriteComps1034 = arg_146_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_0 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1034"]) then
				if arg_146_1.var_.actorSpriteComps1034 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_149_1 then
							if arg_146_1.isInRecall_ then
								iter_149_1.color = Color.New(Mathf.Lerp(iter_149_1.color.r, arg_146_1.hightColor2.r, (arg_146_1.time_ - 0) / var_149_0), Mathf.Lerp(iter_149_1.color.g, arg_146_1.hightColor2.g, (arg_146_1.time_ - 0) / var_149_0), (Mathf.Lerp(iter_149_1.color.b, arg_146_1.hightColor2.b, (arg_146_1.time_ - 0) / var_149_0)))
							else
								local var_149_1 = Mathf.Lerp(iter_149_1.color.r, 0.5, (arg_146_1.time_ - 0) / var_149_0)

								iter_149_1.color = Color.New(var_149_1, var_149_1, var_149_1)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1034"]) and arg_146_1.var_.actorSpriteComps1034 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_149_3 then
						iter_149_3.color = arg_146_1.isInRecall_ and (arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_146_1.var_.actorSpriteComps1034 = nil
			end

			local var_149_2 = arg_146_1.actors_["1034"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1034 = var_149_2.localPosition
				var_149_2.localScale = Vector3.New(1, 1, 1)

				arg_146_1:CheckSpriteTmpPos("1034", 7)

				for iter_149_4 = 0, var_149_2.childCount - 1 do
					local var_149_3 = var_149_2:GetChild(iter_149_4)

					if var_149_3.name == "" or not string.find(var_149_3.name, "split") then
						var_149_3.gameObject:SetActive(true)
					else
						var_149_3.gameObject:SetActive(false)
					end
				end
			end

			local var_149_4 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 then
				var_149_2.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_146_1.time_ - 0) / var_149_4)
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 then
				var_149_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.5 < arg_146_1.time_ and arg_146_1.time_ <= 0.5 + arg_149_0 then
				arg_146_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_uiout", "")
			end

			local var_149_6 = 0
			local var_149_7 = 1.25

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_8 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(417221035).content)

				arg_146_1.text_.text = var_149_8

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_10 = 50 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_8) / 50)

				if (50 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_8) / 50)) > 0 and var_149_7 < var_149_10 then
					arg_146_1.talkMaxDuration = var_149_10

					if var_149_10 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_8
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_11 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_11 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_11

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_11 and arg_146_1.time_ < var_149_6 + var_149_11 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play417221036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 417221036
		arg_150_1.duration_ = 8.83

		local var_150_0 = {
			zh = 7.4,
			ja = 8.833
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play417221037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if arg_150_1.bgs_.I05e == nil then
				local var_153_0 = Object.Instantiate(arg_150_1.paintGo_)

				var_153_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05e")
				var_153_0.name = "I05e"
				var_153_0.transform.parent = arg_150_1.stage_.transform
				var_153_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.bgs_.I05e = var_153_0
			end

			if 1 < arg_150_1.time_ and arg_150_1.time_ <= 1 + arg_153_0 then
				local var_153_1 = arg_150_1.bgs_.I05e

				arg_150_1.bgs_.I05e.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_153_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_153_2 = var_153_1:GetComponent("SpriteRenderer")

				if var_153_2 and var_153_2.sprite then
					local var_153_3 = 2 * (var_153_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_153_1.transform.localScale = Vector3.New(var_153_3 / var_153_2.sprite.bounds.size.y < var_153_3 * manager.ui.mainCameraCom_.aspect / var_153_2.sprite.bounds.size.x and var_153_3 * manager.ui.mainCameraCom_.aspect / var_153_2.sprite.bounds.size.x or var_153_3 / var_153_2.sprite.bounds.size.y, var_153_3 / var_153_2.sprite.bounds.size.y < var_153_3 * manager.ui.mainCameraCom_.aspect / var_153_2.sprite.bounds.size.x and var_153_3 * manager.ui.mainCameraCom_.aspect / var_153_2.sprite.bounds.size.x or var_153_3 / var_153_2.sprite.bounds.size.y, 0)
				end

				for iter_153_0, iter_153_1 in pairs(arg_150_1.bgs_) do
					if iter_153_0 ~= "I05e" then
						iter_153_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_153_4 = 2

			if 2 < arg_150_1.time_ and arg_150_1.time_ <= var_153_4 + arg_153_0 then
				arg_150_1.allBtn_.enabled = false
			end

			if arg_150_1.time_ >= var_153_4 + 0.3 and arg_150_1.time_ < var_153_4 + 0.3 + arg_153_0 then
				arg_150_1.allBtn_.enabled = true
			end

			local var_153_5 = 0

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 then
				arg_150_1.mask_.enabled = true
				arg_150_1.mask_.raycastTarget = true

				arg_150_1:SetGaussion(false)
			end

			local var_153_6 = 1

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_6 then
				local var_153_7 = Color.New(0, 0, 0)

				var_153_7.a = Mathf.Lerp(0, 1, (arg_150_1.time_ - var_153_5) / var_153_6)
				arg_150_1.mask_.color = var_153_7
			end

			if arg_150_1.time_ >= var_153_5 + var_153_6 and arg_150_1.time_ < var_153_5 + var_153_6 + arg_153_0 then
				local var_153_8 = Color.New(0, 0, 0)

				var_153_8.a = 1
				arg_150_1.mask_.color = var_153_8
			end

			local var_153_9 = 1

			if 1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_9 + arg_153_0 then
				arg_150_1.mask_.enabled = true
				arg_150_1.mask_.raycastTarget = true

				arg_150_1:SetGaussion(false)
			end

			local var_153_10 = 1

			if var_153_9 <= arg_150_1.time_ and arg_150_1.time_ < var_153_9 + var_153_10 then
				local var_153_11 = Color.New(0, 0, 0)

				var_153_11.a = Mathf.Lerp(1, 0, (arg_150_1.time_ - var_153_9) / var_153_10)
				arg_150_1.mask_.color = var_153_11
			end

			if arg_150_1.time_ >= var_153_9 + var_153_10 and arg_150_1.time_ < var_153_9 + var_153_10 + arg_153_0 then
				local var_153_12 = Color.New(0, 0, 0)

				arg_150_1.mask_.enabled = false
				var_153_12.a = 0
				arg_150_1.mask_.color = var_153_12
			end

			local var_153_13 = "1060"

			if arg_150_1.actors_["1060"] == nil then
				local var_153_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_153_14) then
					local var_153_15 = Object.Instantiate(var_153_14, arg_150_1.canvasGo_.transform)

					var_153_15.transform:SetSiblingIndex(1)

					var_153_15.name = var_153_13
					var_153_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_150_1.actors_[var_153_13] = var_153_15

					if arg_150_1.isInRecall_ then
						for iter_153_2, iter_153_3 in ipairs((var_153_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_153_3.color = arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_153_16 = arg_150_1.actors_["1060"]

			if 1.76666666666667 < arg_150_1.time_ and arg_150_1.time_ <= 1.76666666666667 + arg_153_0 and not isNil(var_153_16) and arg_150_1.var_.actorSpriteComps1060 == nil then
				arg_150_1.var_.actorSpriteComps1060 = var_153_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_17 = 0.2

			if 1.76666666666667 <= arg_150_1.time_ and arg_150_1.time_ < 1.76666666666667 + var_153_17 and not isNil(var_153_16) then
				if arg_150_1.var_.actorSpriteComps1060 then
					for iter_153_4, iter_153_5 in pairs(arg_150_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_153_5 then
							if arg_150_1.isInRecall_ then
								iter_153_5.color = Color.New(Mathf.Lerp(iter_153_5.color.r, arg_150_1.hightColor1.r, (arg_150_1.time_ - 1.76666666666667) / var_153_17), Mathf.Lerp(iter_153_5.color.g, arg_150_1.hightColor1.g, (arg_150_1.time_ - 1.76666666666667) / var_153_17), (Mathf.Lerp(iter_153_5.color.b, arg_150_1.hightColor1.b, (arg_150_1.time_ - 1.76666666666667) / var_153_17)))
							else
								local var_153_18 = Mathf.Lerp(iter_153_5.color.r, 1, (arg_150_1.time_ - 1.76666666666667) / var_153_17)

								iter_153_5.color = Color.New(var_153_18, var_153_18, var_153_18)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 1.76666666666667 + var_153_17 and arg_150_1.time_ < 1.76666666666667 + var_153_17 + arg_153_0 and not isNil(var_153_16) and arg_150_1.var_.actorSpriteComps1060 then
				for iter_153_6, iter_153_7 in pairs(arg_150_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_153_7 then
						iter_153_7.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_150_1.var_.actorSpriteComps1060 = nil
			end

			local var_153_19 = arg_150_1.actors_["1060"].transform

			if 1.76666666666667 < arg_150_1.time_ and arg_150_1.time_ <= 1.76666666666667 + arg_153_0 then
				arg_150_1.var_.moveOldPos1060 = var_153_19.localPosition
				var_153_19.localScale = Vector3.New(1, 1, 1)

				arg_150_1:CheckSpriteTmpPos("1060", 3)

				for iter_153_8 = 0, var_153_19.childCount - 1 do
					local var_153_20 = var_153_19:GetChild(iter_153_8)

					if var_153_20.name == "" or not string.find(var_153_20.name, "split") then
						var_153_20.gameObject:SetActive(true)
					else
						var_153_20.gameObject:SetActive(false)
					end
				end
			end

			local var_153_21 = 0.001

			if 1.76666666666667 <= arg_150_1.time_ and arg_150_1.time_ < 1.76666666666667 + var_153_21 then
				var_153_19.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_150_1.time_ - 1.76666666666667) / var_153_21)
			end

			if arg_150_1.time_ >= 1.76666666666667 + var_153_21 and arg_150_1.time_ < 1.76666666666667 + var_153_21 + arg_153_0 then
				var_153_19.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			if 1.76666666666667 < arg_150_1.time_ and arg_150_1.time_ <= 1.76666666666667 + arg_153_0 then
				local var_153_22 = arg_150_1.actors_["1060"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_153_22 then
					arg_150_1.var_.alphaOldValue1060 = var_153_22.alpha
					arg_150_1.var_.characterEffect1060 = var_153_22
				end

				arg_150_1.var_.alphaOldValue1060 = 0
			end

			local var_153_23 = 0.233333333333333

			if 1.76666666666667 <= arg_150_1.time_ and arg_150_1.time_ < 1.76666666666667 + var_153_23 then
				if arg_150_1.var_.characterEffect1060 then
					arg_150_1.var_.characterEffect1060.alpha = Mathf.Lerp(arg_150_1.var_.alphaOldValue1060, 1, (arg_150_1.time_ - 1.76666666666667) / var_153_23)
				end
			end

			if arg_150_1.time_ >= 1.76666666666667 + var_153_23 and arg_150_1.time_ < 1.76666666666667 + var_153_23 + arg_153_0 and arg_150_1.var_.characterEffect1060 then
				arg_150_1.var_.characterEffect1060.alpha = 1
			end

			if arg_150_1.frameCnt_ <= 1 then
				arg_150_1.dialog_:SetActive(false)
			end

			local var_153_24 = 2
			local var_153_25 = 0.8

			if 2 < arg_150_1.time_ and arg_150_1.time_ <= var_153_24 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0

				arg_150_1.dialog_:SetActive(true)

				arg_150_1.dialogCg_.alpha = 0

				local var_153_26 = LeanTween.value(arg_150_1.dialog_, 0, 1, 0.3)

				var_153_26:setOnUpdate(LuaHelper.FloatAction(function(arg_154_0)
					arg_150_1.dialogCg_.alpha = arg_154_0
				end))
				var_153_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_150_1.dialog_)
					var_153_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_150_1.duration_ = arg_150_1.duration_ + 0.3

				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_27 = arg_150_1:GetWordFromCfg(417221036)
				local var_153_28 = arg_150_1:FormatText(var_153_27.content)

				arg_150_1.text_.text = var_153_28

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_30 = 32 <= 0 and var_153_25 or var_153_25 * (utf8.len(var_153_28) / 32)

				if (32 <= 0 and var_153_25 or var_153_25 * (utf8.len(var_153_28) / 32)) > 0 and var_153_25 < var_153_30 then
					arg_150_1.talkMaxDuration = var_153_30
					var_153_24 = var_153_24 + 0.3

					if var_153_30 + var_153_24 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_30 + var_153_24
					end
				end

				arg_150_1.text_.text = var_153_28
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221036", "story_v_out_417221.awb") ~= 0 then
					local var_153_31 = manager.audio:GetVoiceLength("story_v_out_417221", "417221036", "story_v_out_417221.awb") / 1000

					if var_153_31 + var_153_24 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_31 + var_153_24
					end

					if var_153_27.prefab_name ~= "" and arg_150_1.actors_[var_153_27.prefab_name] ~= nil then
						local var_153_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_27.prefab_name].transform, "story_v_out_417221", "417221036", "story_v_out_417221.awb")

						arg_150_1:RecordAudio("417221036", var_153_32)
						arg_150_1:RecordAudio("417221036", var_153_32)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_417221", "417221036", "story_v_out_417221.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_417221", "417221036", "story_v_out_417221.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_33 = var_153_24 + 0.3
			local var_153_34 = math.max(var_153_25, arg_150_1.talkMaxDuration)

			if var_153_24 + 0.3 <= arg_150_1.time_ and arg_150_1.time_ < var_153_33 + var_153_34 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_33) / var_153_34

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_33 + var_153_34 and arg_150_1.time_ < var_153_33 + var_153_34 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play417221037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417221037
		arg_156_1.duration_ = 7.13

		local var_156_0 = {
			zh = 4.4,
			ja = 7.133
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
				arg_156_0:Play417221038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1034"]) and arg_156_1.var_.actorSpriteComps1034 == nil then
				arg_156_1.var_.actorSpriteComps1034 = arg_156_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_0 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1034"]) then
				if arg_156_1.var_.actorSpriteComps1034 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								iter_159_1.color = Color.New(Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor1.r, (arg_156_1.time_ - 0) / var_159_0), Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor1.g, (arg_156_1.time_ - 0) / var_159_0), (Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor1.b, (arg_156_1.time_ - 0) / var_159_0)))
							else
								local var_159_1 = Mathf.Lerp(iter_159_1.color.r, 1, (arg_156_1.time_ - 0) / var_159_0)

								iter_159_1.color = Color.New(var_159_1, var_159_1, var_159_1)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1034"]) and arg_156_1.var_.actorSpriteComps1034 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_159_3 then
						iter_159_3.color = arg_156_1.isInRecall_ and (arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_156_1.var_.actorSpriteComps1034 = nil
			end

			local var_159_2 = arg_156_1.actors_["1060"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.actorSpriteComps1060 == nil then
				arg_156_1.var_.actorSpriteComps1060 = var_159_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_3 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_3 and not isNil(var_159_2) then
				if arg_156_1.var_.actorSpriteComps1060 then
					for iter_159_4, iter_159_5 in pairs(arg_156_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_159_5 then
							if arg_156_1.isInRecall_ then
								iter_159_5.color = Color.New(Mathf.Lerp(iter_159_5.color.r, arg_156_1.hightColor2.r, (arg_156_1.time_ - 0) / var_159_3), Mathf.Lerp(iter_159_5.color.g, arg_156_1.hightColor2.g, (arg_156_1.time_ - 0) / var_159_3), (Mathf.Lerp(iter_159_5.color.b, arg_156_1.hightColor2.b, (arg_156_1.time_ - 0) / var_159_3)))
							else
								local var_159_4 = Mathf.Lerp(iter_159_5.color.r, 0.5, (arg_156_1.time_ - 0) / var_159_3)

								iter_159_5.color = Color.New(var_159_4, var_159_4, var_159_4)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= 0 + var_159_3 and arg_156_1.time_ < 0 + var_159_3 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.actorSpriteComps1060 then
				for iter_159_6, iter_159_7 in pairs(arg_156_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_159_7 then
						iter_159_7.color = arg_156_1.isInRecall_ and (arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_156_1.var_.actorSpriteComps1060 = nil
			end

			local var_159_5 = arg_156_1.actors_["1060"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1060 = var_159_5.localPosition
				var_159_5.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("1060", 2)

				for iter_159_8 = 0, var_159_5.childCount - 1 do
					local var_159_6 = var_159_5:GetChild(iter_159_8)

					if var_159_6.name == "" or not string.find(var_159_6.name, "split") then
						var_159_6.gameObject:SetActive(true)
					else
						var_159_6.gameObject:SetActive(false)
					end
				end
			end

			local var_159_7 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				var_159_5.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_156_1.time_ - 0) / var_159_7)
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				var_159_5.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_159_8 = arg_156_1.actors_["1034"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1034 = var_159_8.localPosition
				var_159_8.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("1034", 4)

				for iter_159_9 = 0, var_159_8.childCount - 1 do
					local var_159_9 = var_159_8:GetChild(iter_159_9)

					if var_159_9.name == "" or not string.find(var_159_9.name, "split") then
						var_159_9.gameObject:SetActive(true)
					else
						var_159_9.gameObject:SetActive(false)
					end
				end
			end

			local var_159_10 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_10 then
				var_159_8.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1034, Vector3.New(373.7, -331.9, -324), (arg_156_1.time_ - 0) / var_159_10)
			end

			if arg_156_1.time_ >= 0 + var_159_10 and arg_156_1.time_ < 0 + var_159_10 + arg_159_0 then
				var_159_8.localPosition = Vector3.New(373.7, -331.9, -324)
			end

			local var_159_11 = 0
			local var_159_12 = 0.4

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_11 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_13 = arg_156_1:GetWordFromCfg(417221037)
				local var_159_14 = arg_156_1:FormatText(var_159_13.content)

				arg_156_1.text_.text = var_159_14

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_16 = 16 <= 0 and var_159_12 or var_159_12 * (utf8.len(var_159_14) / 16)

				if (16 <= 0 and var_159_12 or var_159_12 * (utf8.len(var_159_14) / 16)) > 0 and var_159_12 < var_159_16 then
					arg_156_1.talkMaxDuration = var_159_16

					if var_159_16 + var_159_11 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_16 + var_159_11
					end
				end

				arg_156_1.text_.text = var_159_14
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221037", "story_v_out_417221.awb") ~= 0 then
					local var_159_17 = manager.audio:GetVoiceLength("story_v_out_417221", "417221037", "story_v_out_417221.awb") / 1000

					if var_159_17 + var_159_11 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_17 + var_159_11
					end

					if var_159_13.prefab_name ~= "" and arg_156_1.actors_[var_159_13.prefab_name] ~= nil then
						local var_159_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_13.prefab_name].transform, "story_v_out_417221", "417221037", "story_v_out_417221.awb")

						arg_156_1:RecordAudio("417221037", var_159_18)
						arg_156_1:RecordAudio("417221037", var_159_18)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_417221", "417221037", "story_v_out_417221.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_417221", "417221037", "story_v_out_417221.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_19 = math.max(var_159_12, arg_156_1.talkMaxDuration)

			if var_159_11 <= arg_156_1.time_ and arg_156_1.time_ < var_159_11 + var_159_19 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_11) / var_159_19

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_11 + var_159_19 and arg_156_1.time_ < var_159_11 + var_159_19 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play417221038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417221038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play417221039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1060 = arg_160_1.actors_["1060"].transform.localPosition
				arg_160_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_160_1:CheckSpriteTmpPos("1060", 7)

				for iter_163_0 = 0, arg_160_1.actors_["1060"].transform.childCount - 1 do
					local var_163_0 = arg_160_1.actors_["1060"].transform:GetChild(iter_163_0)

					if var_163_0.name == "" or not string.find(var_163_0.name, "split") then
						var_163_0.gameObject:SetActive(true)
					else
						var_163_0.gameObject:SetActive(false)
					end
				end
			end

			local var_163_1 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_1 then
				arg_160_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_160_1.time_ - 0) / var_163_1)
			end

			if arg_160_1.time_ >= 0 + var_163_1 and arg_160_1.time_ < 0 + var_163_1 + arg_163_0 then
				arg_160_1.actors_["1060"].transform.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_163_2 = arg_160_1.actors_["1034"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1034 = var_163_2.localPosition
				var_163_2.localScale = Vector3.New(1, 1, 1)

				arg_160_1:CheckSpriteTmpPos("1034", 7)

				for iter_163_1 = 0, var_163_2.childCount - 1 do
					local var_163_3 = var_163_2:GetChild(iter_163_1)

					if var_163_3.name == "" or not string.find(var_163_3.name, "split") then
						var_163_3.gameObject:SetActive(true)
					else
						var_163_3.gameObject:SetActive(false)
					end
				end
			end

			local var_163_4 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 then
				var_163_2.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_160_1.time_ - 0) / var_163_4)
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 then
				var_163_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.166666666666667 < arg_160_1.time_ and arg_160_1.time_ <= 0.166666666666667 + arg_163_0 then
				arg_160_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_tip", "")
			end

			local var_163_6 = 0
			local var_163_7 = 0.975

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_8 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(417221038).content)

				arg_160_1.text_.text = var_163_8

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_10 = 39 <= 0 and var_163_7 or var_163_7 * (utf8.len(var_163_8) / 39)

				if (39 <= 0 and var_163_7 or var_163_7 * (utf8.len(var_163_8) / 39)) > 0 and var_163_7 < var_163_10 then
					arg_160_1.talkMaxDuration = var_163_10

					if var_163_10 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_10 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_8
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_11 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_11 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_11

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_11 and arg_160_1.time_ < var_163_6 + var_163_11 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play417221039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 417221039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play417221040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.775

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_1 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(417221039).content)

				arg_164_1.text_.text = var_167_1

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_3 = 26 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 26)

				if (26 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 26)) > 0 and var_167_0 < var_167_3 then
					arg_164_1.talkMaxDuration = var_167_3

					if var_167_3 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_3 + 0
					end
				end

				arg_164_1.text_.text = var_167_1
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_4 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_4

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play417221040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 417221040
		arg_168_1.duration_ = 10.3

		local var_168_0 = {
			zh = 5.033,
			ja = 10.3
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
				arg_168_0:Play417221041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 2 < arg_168_1.time_ and arg_168_1.time_ <= 2 + arg_171_0 then
				arg_168_1.allBtn_.enabled = false
			end

			if arg_168_1.time_ >= 2 + 0.3 and arg_168_1.time_ < 2 + 0.3 + arg_171_0 then
				arg_168_1.allBtn_.enabled = true
			end

			local var_171_0 = "ST2106"

			if arg_168_1.bgs_.ST2106 == nil then
				local var_171_1 = Object.Instantiate(arg_168_1.paintGo_)

				var_171_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_171_0)
				var_171_1.name = var_171_0
				var_171_1.transform.parent = arg_168_1.stage_.transform
				var_171_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_168_1.bgs_[var_171_0] = var_171_1
			end

			if 0.999999999999 < arg_168_1.time_ and arg_168_1.time_ <= 0.999999999999 + arg_171_0 then
				local var_171_2 = arg_168_1.bgs_.ST2106

				arg_168_1.bgs_.ST2106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_171_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_171_3 = var_171_2:GetComponent("SpriteRenderer")

				if var_171_3 and var_171_3.sprite then
					local var_171_4 = 2 * (var_171_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_171_2.transform.localScale = Vector3.New(var_171_4 / var_171_3.sprite.bounds.size.y < var_171_4 * manager.ui.mainCameraCom_.aspect / var_171_3.sprite.bounds.size.x and var_171_4 * manager.ui.mainCameraCom_.aspect / var_171_3.sprite.bounds.size.x or var_171_4 / var_171_3.sprite.bounds.size.y, var_171_4 / var_171_3.sprite.bounds.size.y < var_171_4 * manager.ui.mainCameraCom_.aspect / var_171_3.sprite.bounds.size.x and var_171_4 * manager.ui.mainCameraCom_.aspect / var_171_3.sprite.bounds.size.x or var_171_4 / var_171_3.sprite.bounds.size.y, 0)
				end

				for iter_171_0, iter_171_1 in pairs(arg_168_1.bgs_) do
					if iter_171_0 ~= "ST2106" then
						iter_171_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_171_5 = 0

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1.mask_.enabled = true
				arg_168_1.mask_.raycastTarget = true

				arg_168_1:SetGaussion(false)
			end

			local var_171_6 = 1

			if var_171_5 <= arg_168_1.time_ and arg_168_1.time_ < var_171_5 + var_171_6 then
				local var_171_7 = Color.New(0, 0, 0)

				var_171_7.a = Mathf.Lerp(0, 1, (arg_168_1.time_ - var_171_5) / var_171_6)
				arg_168_1.mask_.color = var_171_7
			end

			if arg_168_1.time_ >= var_171_5 + var_171_6 and arg_168_1.time_ < var_171_5 + var_171_6 + arg_171_0 then
				local var_171_8 = Color.New(0, 0, 0)

				var_171_8.a = 1
				arg_168_1.mask_.color = var_171_8
			end

			local var_171_9 = 1

			if 1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_9 + arg_171_0 then
				arg_168_1.mask_.enabled = true
				arg_168_1.mask_.raycastTarget = true

				arg_168_1:SetGaussion(false)
			end

			local var_171_10 = 1

			if var_171_9 <= arg_168_1.time_ and arg_168_1.time_ < var_171_9 + var_171_10 then
				local var_171_11 = Color.New(0, 0, 0)

				var_171_11.a = Mathf.Lerp(1, 0, (arg_168_1.time_ - var_171_9) / var_171_10)
				arg_168_1.mask_.color = var_171_11
			end

			if arg_168_1.time_ >= var_171_9 + var_171_10 and arg_168_1.time_ < var_171_9 + var_171_10 + arg_171_0 then
				local var_171_12 = Color.New(0, 0, 0)

				arg_168_1.mask_.enabled = false
				var_171_12.a = 0
				arg_168_1.mask_.color = var_171_12
			end

			local var_171_13 = arg_168_1.actors_["1034"]

			if 1.76666666666667 < arg_168_1.time_ and arg_168_1.time_ <= 1.76666666666667 + arg_171_0 and not isNil(var_171_13) and arg_168_1.var_.actorSpriteComps1034 == nil then
				arg_168_1.var_.actorSpriteComps1034 = var_171_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_14 = 0.2

			if 1.76666666666667 <= arg_168_1.time_ and arg_168_1.time_ < 1.76666666666667 + var_171_14 and not isNil(var_171_13) then
				if arg_168_1.var_.actorSpriteComps1034 then
					for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_171_3 then
							if arg_168_1.isInRecall_ then
								iter_171_3.color = Color.New(Mathf.Lerp(iter_171_3.color.r, arg_168_1.hightColor1.r, (arg_168_1.time_ - 1.76666666666667) / var_171_14), Mathf.Lerp(iter_171_3.color.g, arg_168_1.hightColor1.g, (arg_168_1.time_ - 1.76666666666667) / var_171_14), (Mathf.Lerp(iter_171_3.color.b, arg_168_1.hightColor1.b, (arg_168_1.time_ - 1.76666666666667) / var_171_14)))
							else
								local var_171_15 = Mathf.Lerp(iter_171_3.color.r, 1, (arg_168_1.time_ - 1.76666666666667) / var_171_14)

								iter_171_3.color = Color.New(var_171_15, var_171_15, var_171_15)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 1.76666666666667 + var_171_14 and arg_168_1.time_ < 1.76666666666667 + var_171_14 + arg_171_0 and not isNil(var_171_13) and arg_168_1.var_.actorSpriteComps1034 then
				for iter_171_4, iter_171_5 in pairs(arg_168_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_171_5 then
						iter_171_5.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_168_1.var_.actorSpriteComps1034 = nil
			end

			local var_171_16 = arg_168_1.actors_["1034"].transform

			if 1.76666666666667 < arg_168_1.time_ and arg_168_1.time_ <= 1.76666666666667 + arg_171_0 then
				arg_168_1.var_.moveOldPos1034 = var_171_16.localPosition
				var_171_16.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("1034", 3)

				for iter_171_6 = 0, var_171_16.childCount - 1 do
					local var_171_17 = var_171_16:GetChild(iter_171_6)

					if var_171_17.name == "" or not string.find(var_171_17.name, "split") then
						var_171_17.gameObject:SetActive(true)
					else
						var_171_17.gameObject:SetActive(false)
					end
				end
			end

			local var_171_18 = 0.001

			if 1.76666666666667 <= arg_168_1.time_ and arg_168_1.time_ < 1.76666666666667 + var_171_18 then
				var_171_16.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_168_1.time_ - 1.76666666666667) / var_171_18)
			end

			if arg_168_1.time_ >= 1.76666666666667 + var_171_18 and arg_168_1.time_ < 1.76666666666667 + var_171_18 + arg_171_0 then
				var_171_16.localPosition = Vector3.New(0, -331.9, -324)
			end

			if 1.76666666666667 < arg_168_1.time_ and arg_168_1.time_ <= 1.76666666666667 + arg_171_0 then
				local var_171_19 = arg_168_1.actors_["1034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_171_19 then
					arg_168_1.var_.alphaOldValue1034 = var_171_19.alpha
					arg_168_1.var_.characterEffect1034 = var_171_19
				end

				arg_168_1.var_.alphaOldValue1034 = 0
			end

			local var_171_20 = 0.233333333333333

			if 1.76666666666667 <= arg_168_1.time_ and arg_168_1.time_ < 1.76666666666667 + var_171_20 then
				if arg_168_1.var_.characterEffect1034 then
					arg_168_1.var_.characterEffect1034.alpha = Mathf.Lerp(arg_168_1.var_.alphaOldValue1034, 1, (arg_168_1.time_ - 1.76666666666667) / var_171_20)
				end
			end

			if arg_168_1.time_ >= 1.76666666666667 + var_171_20 and arg_168_1.time_ < 1.76666666666667 + var_171_20 + arg_171_0 and arg_168_1.var_.characterEffect1034 then
				arg_168_1.var_.characterEffect1034.alpha = 1
			end

			if arg_168_1.frameCnt_ <= 1 then
				arg_168_1.dialog_:SetActive(false)
			end

			local var_171_21 = 2
			local var_171_22 = 0.35

			if 2 < arg_168_1.time_ and arg_168_1.time_ <= var_171_21 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0

				arg_168_1.dialog_:SetActive(true)

				arg_168_1.dialogCg_.alpha = 0

				local var_171_23 = LeanTween.value(arg_168_1.dialog_, 0, 1, 0.3)

				var_171_23:setOnUpdate(LuaHelper.FloatAction(function(arg_172_0)
					arg_168_1.dialogCg_.alpha = arg_172_0
				end))
				var_171_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_168_1.dialog_)
					var_171_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_168_1.duration_ = arg_168_1.duration_ + 0.3

				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_24 = arg_168_1:GetWordFromCfg(417221040)
				local var_171_25 = arg_168_1:FormatText(var_171_24.content)

				arg_168_1.text_.text = var_171_25

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_27 = 14 <= 0 and var_171_22 or var_171_22 * (utf8.len(var_171_25) / 14)

				if (14 <= 0 and var_171_22 or var_171_22 * (utf8.len(var_171_25) / 14)) > 0 and var_171_22 < var_171_27 then
					arg_168_1.talkMaxDuration = var_171_27
					var_171_21 = var_171_21 + 0.3

					if var_171_27 + var_171_21 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_27 + var_171_21
					end
				end

				arg_168_1.text_.text = var_171_25
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221040", "story_v_out_417221.awb") ~= 0 then
					local var_171_28 = manager.audio:GetVoiceLength("story_v_out_417221", "417221040", "story_v_out_417221.awb") / 1000

					if var_171_28 + var_171_21 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_28 + var_171_21
					end

					if var_171_24.prefab_name ~= "" and arg_168_1.actors_[var_171_24.prefab_name] ~= nil then
						local var_171_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_24.prefab_name].transform, "story_v_out_417221", "417221040", "story_v_out_417221.awb")

						arg_168_1:RecordAudio("417221040", var_171_29)
						arg_168_1:RecordAudio("417221040", var_171_29)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_417221", "417221040", "story_v_out_417221.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_417221", "417221040", "story_v_out_417221.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_30 = var_171_21 + 0.3
			local var_171_31 = math.max(var_171_22, arg_168_1.talkMaxDuration)

			if var_171_21 + 0.3 <= arg_168_1.time_ and arg_168_1.time_ < var_171_30 + var_171_31 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_30) / var_171_31

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_30 + var_171_31 and arg_168_1.time_ < var_171_30 + var_171_31 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play417221041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417221041
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play417221042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1034 = arg_174_1.actors_["1034"].transform.localPosition
				arg_174_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1034", 7)

				for iter_177_0 = 0, arg_174_1.actors_["1034"].transform.childCount - 1 do
					local var_177_0 = arg_174_1.actors_["1034"].transform:GetChild(iter_177_0)

					if var_177_0.name == "" or not string.find(var_177_0.name, "split") then
						var_177_0.gameObject:SetActive(true)
					else
						var_177_0.gameObject:SetActive(false)
					end
				end
			end

			local var_177_1 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_1 then
				arg_174_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_174_1.time_ - 0) / var_177_1)
			end

			if arg_174_1.time_ >= 0 + var_177_1 and arg_174_1.time_ < 0 + var_177_1 + arg_177_0 then
				arg_174_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_174_1.time_ and arg_174_1.time_ <= 0.034 + arg_177_0 then
				arg_174_1:AudioAction("play", "effect", "ui_system_3_0", "ui_sight_archieve_in", "")
			end

			local var_177_3 = 0
			local var_177_4 = 1.125

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_3 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_5 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(417221041).content)

				arg_174_1.text_.text = var_177_5

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_7 = 44 <= 0 and var_177_4 or var_177_4 * (utf8.len(var_177_5) / 44)

				if (44 <= 0 and var_177_4 or var_177_4 * (utf8.len(var_177_5) / 44)) > 0 and var_177_4 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_3 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_3
					end
				end

				arg_174_1.text_.text = var_177_5
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_8 = math.max(var_177_4, arg_174_1.talkMaxDuration)

			if var_177_3 <= arg_174_1.time_ and arg_174_1.time_ < var_177_3 + var_177_8 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_3) / var_177_8

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_3 + var_177_8 and arg_174_1.time_ < var_177_3 + var_177_8 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play417221042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417221042
		arg_178_1.duration_ = 5.2

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play417221043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = false

				arg_178_1:SetGaussion(false)
			end

			local var_181_0 = 0.7

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				local var_181_1 = Color.New(0, 0, 0)

				var_181_1.a = Mathf.Lerp(0, 1, (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.mask_.color = var_181_1
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				local var_181_2 = Color.New(0, 0, 0)

				var_181_2.a = 1
				arg_178_1.mask_.color = var_181_2
			end

			local var_181_3 = 0.7

			if 0.7 < arg_178_1.time_ and arg_178_1.time_ <= var_181_3 + arg_181_0 then
				arg_178_1.mask_.enabled = true
				arg_178_1.mask_.raycastTarget = false

				arg_178_1:SetGaussion(false)
			end

			local var_181_4 = 0.7

			if var_181_3 <= arg_178_1.time_ and arg_178_1.time_ < var_181_3 + var_181_4 then
				local var_181_5 = Color.New(0, 0, 0)

				var_181_5.a = Mathf.Lerp(1, 0, (arg_178_1.time_ - var_181_3) / var_181_4)
				arg_178_1.mask_.color = var_181_5
			end

			if arg_178_1.time_ >= var_181_3 + var_181_4 and arg_178_1.time_ < var_181_3 + var_181_4 + arg_181_0 then
				local var_181_6 = Color.New(0, 0, 0)

				arg_178_1.mask_.enabled = false
				var_181_6.a = 0
				arg_178_1.mask_.color = var_181_6
			end

			if 0.7 < arg_178_1.time_ and arg_178_1.time_ <= 0.7 + arg_181_0 then
				arg_178_1.cswbg_:SetActive(true)

				local var_181_7 = arg_178_1.cswt_:GetComponent("RectTransform")

				arg_178_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_181_7.offsetMin = Vector2.New(0, 0)
				var_181_7.offsetMax = Vector2.New(0, 0)
				arg_178_1.cswt_.text = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(419113).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.cswt_)

				arg_178_1.cswt_.fontSize = 120
				arg_178_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_178_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_178_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_181_8 = "STblack"

			if arg_178_1.bgs_.STblack == nil then
				local var_181_9 = Object.Instantiate(arg_178_1.paintGo_)

				var_181_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_181_8)
				var_181_9.name = var_181_8
				var_181_9.transform.parent = arg_178_1.stage_.transform
				var_181_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_178_1.bgs_[var_181_8] = var_181_9
			end

			if 0.7 < arg_178_1.time_ and arg_178_1.time_ <= 0.7 + arg_181_0 then
				local var_181_10 = arg_178_1.bgs_.STblack

				arg_178_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_181_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_181_11 = var_181_10:GetComponent("SpriteRenderer")

				if var_181_11 and var_181_11.sprite then
					local var_181_12 = 2 * (var_181_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_181_10.transform.localScale = Vector3.New(var_181_12 / var_181_11.sprite.bounds.size.y < var_181_12 * manager.ui.mainCameraCom_.aspect / var_181_11.sprite.bounds.size.x and var_181_12 * manager.ui.mainCameraCom_.aspect / var_181_11.sprite.bounds.size.x or var_181_12 / var_181_11.sprite.bounds.size.y, var_181_12 / var_181_11.sprite.bounds.size.y < var_181_12 * manager.ui.mainCameraCom_.aspect / var_181_11.sprite.bounds.size.x and var_181_12 * manager.ui.mainCameraCom_.aspect / var_181_11.sprite.bounds.size.x or var_181_12 / var_181_11.sprite.bounds.size.y, 0)
				end

				for iter_181_0, iter_181_1 in pairs(arg_178_1.bgs_) do
					if iter_181_0 ~= "STblack" then
						iter_181_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.7 < arg_178_1.time_ and arg_178_1.time_ <= 0.7 + arg_181_0 then
				arg_178_1.fswbg_:SetActive(true)
				arg_178_1.dialog_:SetActive(false)

				arg_178_1.fswtw_.percent = 0
				arg_178_1.fswt_.text = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(417221042).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.fswt_)

				arg_178_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_178_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_178_1.fswtw_:SetDirty()

				arg_178_1.typewritterCharCountI18N = 0

				SetActive(arg_178_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_178_1:ShowNextGo(false)
			end

			local var_181_13 = 1.13333333333333

			if 1.13333333333333 < arg_178_1.time_ and arg_178_1.time_ <= var_181_13 + arg_181_0 then
				arg_178_1.var_.oldValueTypewriter = arg_178_1.fswtw_.percent

				SetActive(arg_178_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_178_1:ShowNextGo(false)
			end

			local var_181_14 = 19
			local var_181_15 = 1.26666666666667
			local var_181_16, var_181_17 = arg_178_1:GetPercentByPara(arg_178_1:FormatText(arg_178_1:GetWordFromCfg(417221042).content), 1)

			if var_181_13 < arg_178_1.time_ and arg_178_1.time_ <= var_181_13 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0

				local var_181_18 = var_181_14 <= 0 and var_181_15 or var_181_15 * ((var_181_17 - arg_178_1.typewritterCharCountI18N) / var_181_14)

				if (var_181_14 <= 0 and var_181_15 or var_181_15 * ((var_181_17 - arg_178_1.typewritterCharCountI18N) / var_181_14)) > 0 and var_181_15 < var_181_18 then
					arg_178_1.talkMaxDuration = var_181_18

					if var_181_18 + var_181_13 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_18 + var_181_13
					end
				end
			end

			local var_181_19 = math.max(1.26666666666667, arg_178_1.talkMaxDuration)

			if var_181_13 <= arg_178_1.time_ and arg_178_1.time_ < var_181_13 + var_181_19 then
				arg_178_1.fswtw_.percent = Mathf.Lerp(arg_178_1.var_.oldValueTypewriter, var_181_16, (arg_178_1.time_ - var_181_13) / var_181_19)
				arg_178_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_178_1.fswtw_:SetDirty()
			end

			if arg_178_1.time_ >= var_181_13 + var_181_19 and arg_178_1.time_ < var_181_13 + var_181_19 + arg_181_0 then
				arg_178_1.fswtw_.percent = var_181_16

				arg_178_1.fswtw_:SetDirty()
				arg_178_1:ShowNextGo(true)

				arg_178_1.typewritterCharCountI18N = var_181_17
			end

			if 0.7 < arg_178_1.time_ and arg_178_1.time_ <= 0.7 + arg_181_0 then
				local var_181_20 = arg_178_1.fswbg_.transform:Find("textbox/adapt/content") or arg_178_1.fswbg_.transform:Find("textbox/content")
				local var_181_21 = arg_178_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_181_22 = var_181_20:GetComponent("RectTransform")

				var_181_20:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_181_22.offsetMin = Vector2.New(0, 0)
				var_181_22.offsetMax = Vector2.New(0, 0)
			end

			local var_181_23 = 0.683333333333333

			arg_178_1.isInRecall_ = false

			if var_181_23 < arg_178_1.time_ and arg_178_1.time_ <= var_181_23 + arg_181_0 then
				arg_178_1.screenFilterGo_:SetActive(false)

				for iter_181_2, iter_181_3 in pairs(arg_178_1.actors_) do
					for iter_181_4, iter_181_5 in ipairs((iter_181_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_181_5.color = iter_181_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_181_24 = 0.0166666666666667

			if var_181_23 <= arg_178_1.time_ and arg_178_1.time_ < var_181_23 + var_181_24 then
				arg_178_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_178_1.time_ - var_181_23) / var_181_24)
			end

			if arg_178_1.time_ >= var_181_23 + var_181_24 and arg_178_1.time_ < var_181_23 + var_181_24 + arg_181_0 then
				arg_178_1.screenFilterEffect_.weight = 0
			end

			if 1.13333333333333 < arg_178_1.time_ and arg_178_1.time_ <= 1.13333333333333 + arg_181_0 then
				arg_178_1:AudioAction("play", "music", "story_v_out_417221", "417221042", "story_v_out_417221.awb")

				local var_181_27 = manager.audio:GetAudioName("story_v_out_417221", "417221042")

				if "" ~= "" then
					if arg_178_1.bgmTxt_.text ~= var_181_27 and arg_178_1.bgmTxt_.text ~= "" then
						if arg_178_1.bgmTxt2_.text ~= "" then
							arg_178_1.bgmTxt_.text = arg_178_1.bgmTxt2_.text
						end

						arg_178_1.bgmTxt2_.text = var_181_27

						arg_178_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_178_1.bgmTxt_.text = var_181_27
						arg_178_1.bgmTxt2_.text = var_181_27
					end

					if arg_178_1.bgmTimer then
						arg_178_1.bgmTimer:Stop()

						arg_178_1.bgmTimer = nil
					end

					if arg_178_1.settingData.show_music_name == 1 then
						arg_178_1.musicController:SetSelectedState("show")
						arg_178_1.musicAnimator_:Play("open", 0, 0)

						if arg_178_1.settingData.music_time ~= 0 then
							arg_178_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_178_1.settingData.music_time), function()
								if arg_178_1 == nil or isNil(arg_178_1.bgmTxt_) then
									return
								end

								arg_178_1.musicController:SetSelectedState("hide")
								arg_178_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play417221043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 417221043
		arg_183_1.duration_ = 7

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play417221044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 2 < arg_183_1.time_ and arg_183_1.time_ <= 2 + arg_186_0 then
				arg_183_1.allBtn_.enabled = false
			end

			if arg_183_1.time_ >= 2 + 0.3 and arg_183_1.time_ < 2 + 0.3 + arg_186_0 then
				arg_183_1.allBtn_.enabled = true
			end

			if 0.999999999999999 < arg_183_1.time_ and arg_183_1.time_ <= 0.999999999999999 + arg_186_0 then
				local var_186_0 = arg_183_1.bgs_.ST69

				arg_183_1.bgs_.ST69.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_186_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_1 = var_186_0:GetComponent("SpriteRenderer")

				if var_186_1 and var_186_1.sprite then
					local var_186_2 = 2 * (var_186_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_186_0.transform.localScale = Vector3.New(var_186_2 / var_186_1.sprite.bounds.size.y < var_186_2 * manager.ui.mainCameraCom_.aspect / var_186_1.sprite.bounds.size.x and var_186_2 * manager.ui.mainCameraCom_.aspect / var_186_1.sprite.bounds.size.x or var_186_2 / var_186_1.sprite.bounds.size.y, var_186_2 / var_186_1.sprite.bounds.size.y < var_186_2 * manager.ui.mainCameraCom_.aspect / var_186_1.sprite.bounds.size.x and var_186_2 * manager.ui.mainCameraCom_.aspect / var_186_1.sprite.bounds.size.x or var_186_2 / var_186_1.sprite.bounds.size.y, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "ST69" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_3 = 0

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_4 = 1

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_4 then
				local var_186_5 = Color.New(0, 0, 0)

				var_186_5.a = Mathf.Lerp(0, 1, (arg_183_1.time_ - var_186_3) / var_186_4)
				arg_183_1.mask_.color = var_186_5
			end

			if arg_183_1.time_ >= var_186_3 + var_186_4 and arg_183_1.time_ < var_186_3 + var_186_4 + arg_186_0 then
				local var_186_6 = Color.New(0, 0, 0)

				var_186_6.a = 1
				arg_183_1.mask_.color = var_186_6
			end

			local var_186_7 = 0.999999999999999

			if 0.999999999999999 < arg_183_1.time_ and arg_183_1.time_ <= var_186_7 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_8 = 1

			if var_186_7 <= arg_183_1.time_ and arg_183_1.time_ < var_186_7 + var_186_8 then
				local var_186_9 = Color.New(0, 0, 0)

				var_186_9.a = Mathf.Lerp(1, 0, (arg_183_1.time_ - var_186_7) / var_186_8)
				arg_183_1.mask_.color = var_186_9
			end

			if arg_183_1.time_ >= var_186_7 + var_186_8 and arg_183_1.time_ < var_186_7 + var_186_8 + arg_186_0 then
				local var_186_10 = Color.New(0, 0, 0)

				arg_183_1.mask_.enabled = false
				var_186_10.a = 0
				arg_183_1.mask_.color = var_186_10
			end

			local var_186_11 = arg_183_1.actors_["1034"].transform

			if 0.965999999999999 < arg_183_1.time_ and arg_183_1.time_ <= 0.965999999999999 + arg_186_0 then
				arg_183_1.var_.moveOldPos1034 = var_186_11.localPosition
				var_186_11.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1034", 7)

				for iter_186_2 = 0, var_186_11.childCount - 1 do
					local var_186_12 = var_186_11:GetChild(iter_186_2)

					if var_186_12.name == "" or not string.find(var_186_12.name, "split") then
						var_186_12.gameObject:SetActive(true)
					else
						var_186_12.gameObject:SetActive(false)
					end
				end
			end

			local var_186_13 = 0.001

			if 0.965999999999999 <= arg_183_1.time_ and arg_183_1.time_ < 0.965999999999999 + var_186_13 then
				var_186_11.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_183_1.time_ - 0.965999999999999) / var_186_13)
			end

			if arg_183_1.time_ >= 0.965999999999999 + var_186_13 and arg_183_1.time_ < 0.965999999999999 + var_186_13 + arg_186_0 then
				var_186_11.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.966666666666667 < arg_183_1.time_ and arg_183_1.time_ <= 0.966666666666667 + arg_186_0 then
				arg_183_1.cswbg_:SetActive(false)
			end

			if 0.966666666666667 < arg_183_1.time_ and arg_183_1.time_ <= 0.966666666666667 + arg_186_0 then
				arg_183_1.fswbg_:SetActive(false)
				arg_183_1.dialog_:SetActive(false)
				SetActive(arg_183_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_183_1:ShowNextGo(false)
			end

			if arg_183_1.frameCnt_ <= 1 then
				arg_183_1.dialog_:SetActive(false)
			end

			local var_186_14 = 2
			local var_186_15 = 0.9

			if 2 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0

				arg_183_1.dialog_:SetActive(true)

				arg_183_1.dialogCg_.alpha = 0

				local var_186_16 = LeanTween.value(arg_183_1.dialog_, 0, 1, 0.3)

				var_186_16:setOnUpdate(LuaHelper.FloatAction(function(arg_187_0)
					arg_183_1.dialogCg_.alpha = arg_187_0
				end))
				var_186_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_183_1.dialog_)
					var_186_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_183_1.duration_ = arg_183_1.duration_ + 0.3

				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_17 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(417221043).content)

				arg_183_1.text_.text = var_186_17

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_19 = 36 <= 0 and var_186_15 or var_186_15 * (utf8.len(var_186_17) / 36)

				if (36 <= 0 and var_186_15 or var_186_15 * (utf8.len(var_186_17) / 36)) > 0 and var_186_15 < var_186_19 then
					arg_183_1.talkMaxDuration = var_186_19
					var_186_14 = var_186_14 + 0.3

					if var_186_19 + var_186_14 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_19 + var_186_14
					end
				end

				arg_183_1.text_.text = var_186_17
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_20 = var_186_14 + 0.3
			local var_186_21 = math.max(var_186_15, arg_183_1.talkMaxDuration)

			if var_186_14 + 0.3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_20 + var_186_21 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_20) / var_186_21

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_20 + var_186_21 and arg_183_1.time_ < var_186_20 + var_186_21 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.965999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play417221044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 417221044
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play417221045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.cswbg_:SetActive(false)
			end

			local var_192_0 = 0
			local var_192_1 = 1.775

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(417221044).content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 71 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_2) / 71)

				if (71 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_2) / 71)) > 0 and var_192_1 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_5 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_5 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_5

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_5 and arg_189_1.time_ < var_192_0 + var_192_5 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play417221045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 417221045
		arg_193_1.duration_ = 8.87

		local var_193_0 = {
			zh = 7.6,
			ja = 8.866
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play417221046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1034"]) and arg_193_1.var_.actorSpriteComps1034 == nil then
				arg_193_1.var_.actorSpriteComps1034 = arg_193_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_0 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1034"]) then
				if arg_193_1.var_.actorSpriteComps1034 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								iter_196_1.color = Color.New(Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_0), Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_0), (Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_0)))
							else
								local var_196_1 = Mathf.Lerp(iter_196_1.color.r, 1, (arg_193_1.time_ - 0) / var_196_0)

								iter_196_1.color = Color.New(var_196_1, var_196_1, var_196_1)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1034"]) and arg_193_1.var_.actorSpriteComps1034 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_196_3 then
						iter_196_3.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps1034 = nil
			end

			local var_196_2 = arg_193_1.actors_["1034"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1034 = var_196_2.localPosition
				var_196_2.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("1034", 3)

				for iter_196_4 = 0, var_196_2.childCount - 1 do
					local var_196_3 = var_196_2:GetChild(iter_196_4)

					if var_196_3.name == "" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				var_196_2.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_193_1.time_ - 0) / var_196_4)
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				var_196_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_196_5 = 0
			local var_196_6 = 0.7

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_7 = arg_193_1:GetWordFromCfg(417221045)
				local var_196_8 = arg_193_1:FormatText(var_196_7.content)

				arg_193_1.text_.text = var_196_8

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 28 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 28)

				if (28 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 28)) > 0 and var_196_6 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_5
					end
				end

				arg_193_1.text_.text = var_196_8
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221045", "story_v_out_417221.awb") ~= 0 then
					local var_196_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221045", "story_v_out_417221.awb") / 1000

					if var_196_11 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_5
					end

					if var_196_7.prefab_name ~= "" and arg_193_1.actors_[var_196_7.prefab_name] ~= nil then
						local var_196_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_7.prefab_name].transform, "story_v_out_417221", "417221045", "story_v_out_417221.awb")

						arg_193_1:RecordAudio("417221045", var_196_12)
						arg_193_1:RecordAudio("417221045", var_196_12)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_417221", "417221045", "story_v_out_417221.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_417221", "417221045", "story_v_out_417221.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_13 = math.max(var_196_6, arg_193_1.talkMaxDuration)

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_13 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_5) / var_196_13

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_5 + var_196_13 and arg_193_1.time_ < var_196_5 + var_196_13 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play417221046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 417221046
		arg_197_1.duration_ = 6.5

		local var_197_0 = {
			zh = 6.5,
			ja = 6
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play417221047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.55

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(417221046)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 22 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 22)

				if (22 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 22)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221046", "story_v_out_417221.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221046", "story_v_out_417221.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_417221", "417221046", "story_v_out_417221.awb")

						arg_197_1:RecordAudio("417221046", var_200_6)
						arg_197_1:RecordAudio("417221046", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_417221", "417221046", "story_v_out_417221.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_417221", "417221046", "story_v_out_417221.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play417221047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 417221047
		arg_201_1.duration_ = 4.2

		local var_201_0 = {
			zh = 3.2,
			ja = 4.2
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play417221048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1034 = arg_201_1.actors_["1034"].transform.localPosition
				arg_201_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("1034", 3)

				for iter_204_0 = 0, arg_201_1.actors_["1034"].transform.childCount - 1 do
					local var_204_0 = arg_201_1.actors_["1034"].transform:GetChild(iter_204_0)

					if var_204_0.name == "split_6" or not string.find(var_204_0.name, "split") then
						var_204_0.gameObject:SetActive(true)
					else
						var_204_0.gameObject:SetActive(false)
					end
				end
			end

			local var_204_1 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_1 then
				arg_201_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_201_1.time_ - 0) / var_204_1)
			end

			if arg_201_1.time_ >= 0 + var_204_1 and arg_201_1.time_ < 0 + var_204_1 + arg_204_0 then
				arg_201_1.actors_["1034"].transform.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_204_2 = 0
			local var_204_3 = 0.275

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_2 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_4 = arg_201_1:GetWordFromCfg(417221047)
				local var_204_5 = arg_201_1:FormatText(var_204_4.content)

				arg_201_1.text_.text = var_204_5

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_7 = 11 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 11)

				if (11 <= 0 and var_204_3 or var_204_3 * (utf8.len(var_204_5) / 11)) > 0 and var_204_3 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_2
					end
				end

				arg_201_1.text_.text = var_204_5
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221047", "story_v_out_417221.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221047", "story_v_out_417221.awb") / 1000

					if var_204_8 + var_204_2 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_2
					end

					if var_204_4.prefab_name ~= "" and arg_201_1.actors_[var_204_4.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_4.prefab_name].transform, "story_v_out_417221", "417221047", "story_v_out_417221.awb")

						arg_201_1:RecordAudio("417221047", var_204_9)
						arg_201_1:RecordAudio("417221047", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_417221", "417221047", "story_v_out_417221.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_417221", "417221047", "story_v_out_417221.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_3, arg_201_1.talkMaxDuration)

			if var_204_2 <= arg_201_1.time_ and arg_201_1.time_ < var_204_2 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_2) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_2 + var_204_10 and arg_201_1.time_ < var_204_2 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play417221048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 417221048
		arg_205_1.duration_ = 10.6

		local var_205_0 = {
			zh = 8.933,
			ja = 10.6
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play417221049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 2 < arg_205_1.time_ and arg_205_1.time_ <= 2 + arg_208_0 then
				local var_208_0 = arg_205_1.bgs_.I16f

				arg_205_1.bgs_.I16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_208_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_208_1 = var_208_0:GetComponent("SpriteRenderer")

				if var_208_1 and var_208_1.sprite then
					local var_208_2 = 2 * (var_208_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_208_0.transform.localScale = Vector3.New(var_208_2 / var_208_1.sprite.bounds.size.y < var_208_2 * manager.ui.mainCameraCom_.aspect / var_208_1.sprite.bounds.size.x and var_208_2 * manager.ui.mainCameraCom_.aspect / var_208_1.sprite.bounds.size.x or var_208_2 / var_208_1.sprite.bounds.size.y, var_208_2 / var_208_1.sprite.bounds.size.y < var_208_2 * manager.ui.mainCameraCom_.aspect / var_208_1.sprite.bounds.size.x and var_208_2 * manager.ui.mainCameraCom_.aspect / var_208_1.sprite.bounds.size.x or var_208_2 / var_208_1.sprite.bounds.size.y, 0)
				end

				for iter_208_0, iter_208_1 in pairs(arg_205_1.bgs_) do
					if iter_208_0 ~= "I16f" then
						iter_208_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_208_3 = 4

			if 4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_3 + arg_208_0 then
				arg_205_1.allBtn_.enabled = false
			end

			if arg_205_1.time_ >= var_208_3 + 0.3 and arg_205_1.time_ < var_208_3 + 0.3 + arg_208_0 then
				arg_205_1.allBtn_.enabled = true
			end

			local var_208_4 = 0

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_5 = 2

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_5 then
				local var_208_6 = Color.New(0, 0, 0)

				var_208_6.a = Mathf.Lerp(0, 1, (arg_205_1.time_ - var_208_4) / var_208_5)
				arg_205_1.mask_.color = var_208_6
			end

			if arg_205_1.time_ >= var_208_4 + var_208_5 and arg_205_1.time_ < var_208_4 + var_208_5 + arg_208_0 then
				local var_208_7 = Color.New(0, 0, 0)

				var_208_7.a = 1
				arg_205_1.mask_.color = var_208_7
			end

			local var_208_8 = 2

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_9 = 2

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 then
				local var_208_10 = Color.New(0, 0, 0)

				var_208_10.a = Mathf.Lerp(1, 0, (arg_205_1.time_ - var_208_8) / var_208_9)
				arg_205_1.mask_.color = var_208_10
			end

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 then
				local var_208_11 = Color.New(0, 0, 0)

				arg_205_1.mask_.enabled = false
				var_208_11.a = 0
				arg_205_1.mask_.color = var_208_11
			end

			local var_208_12 = arg_205_1.actors_["10113"]

			if 3.66666666666667 < arg_205_1.time_ and arg_205_1.time_ <= 3.66666666666667 + arg_208_0 and not isNil(var_208_12) and arg_205_1.var_.actorSpriteComps10113 == nil then
				arg_205_1.var_.actorSpriteComps10113 = var_208_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_13 = 0.2

			if 3.66666666666667 <= arg_205_1.time_ and arg_205_1.time_ < 3.66666666666667 + var_208_13 and not isNil(var_208_12) then
				if arg_205_1.var_.actorSpriteComps10113 then
					for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_208_3 then
							if arg_205_1.isInRecall_ then
								iter_208_3.color = Color.New(Mathf.Lerp(iter_208_3.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 3.66666666666667) / var_208_13), Mathf.Lerp(iter_208_3.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 3.66666666666667) / var_208_13), (Mathf.Lerp(iter_208_3.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 3.66666666666667) / var_208_13)))
							else
								local var_208_14 = Mathf.Lerp(iter_208_3.color.r, 1, (arg_205_1.time_ - 3.66666666666667) / var_208_13)

								iter_208_3.color = Color.New(var_208_14, var_208_14, var_208_14)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 3.66666666666667 + var_208_13 and arg_205_1.time_ < 3.66666666666667 + var_208_13 + arg_208_0 and not isNil(var_208_12) and arg_205_1.var_.actorSpriteComps10113 then
				for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_208_5 then
						iter_208_5.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps10113 = nil
			end

			local var_208_15 = arg_205_1.actors_["10113"].transform

			if 3.66666666666667 < arg_205_1.time_ and arg_205_1.time_ <= 3.66666666666667 + arg_208_0 then
				arg_205_1.var_.moveOldPos10113 = var_208_15.localPosition
				var_208_15.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10113", 3)

				for iter_208_6 = 0, var_208_15.childCount - 1 do
					local var_208_16 = var_208_15:GetChild(iter_208_6)

					if var_208_16.name == "" or not string.find(var_208_16.name, "split") then
						var_208_16.gameObject:SetActive(true)
					else
						var_208_16.gameObject:SetActive(false)
					end
				end
			end

			local var_208_17 = 0.001

			if 3.66666666666667 <= arg_205_1.time_ and arg_205_1.time_ < 3.66666666666667 + var_208_17 then
				var_208_15.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_205_1.time_ - 3.66666666666667) / var_208_17)
			end

			if arg_205_1.time_ >= 3.66666666666667 + var_208_17 and arg_205_1.time_ < 3.66666666666667 + var_208_17 + arg_208_0 then
				var_208_15.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_208_18 = arg_205_1.actors_["1034"].transform

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= 2 + arg_208_0 then
				arg_205_1.var_.moveOldPos1034 = var_208_18.localPosition
				var_208_18.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1034", 7)

				for iter_208_7 = 0, var_208_18.childCount - 1 do
					local var_208_19 = var_208_18:GetChild(iter_208_7)

					if var_208_19.name == "" or not string.find(var_208_19.name, "split") then
						var_208_19.gameObject:SetActive(true)
					else
						var_208_19.gameObject:SetActive(false)
					end
				end
			end

			local var_208_20 = 0.001

			if 2 <= arg_205_1.time_ and arg_205_1.time_ < 2 + var_208_20 then
				var_208_18.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_205_1.time_ - 2) / var_208_20)
			end

			if arg_205_1.time_ >= 2 + var_208_20 and arg_205_1.time_ < 2 + var_208_20 + arg_208_0 then
				var_208_18.localPosition = Vector3.New(0, -2000, 0)
			end

			if 3.66666666666667 < arg_205_1.time_ and arg_205_1.time_ <= 3.66666666666667 + arg_208_0 then
				local var_208_21 = arg_205_1.actors_["10113"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_208_21 then
					arg_205_1.var_.alphaOldValue10113 = var_208_21.alpha
					arg_205_1.var_.characterEffect10113 = var_208_21
				end

				arg_205_1.var_.alphaOldValue10113 = 0
			end

			local var_208_22 = 0.333333333333333

			if 3.66666666666667 <= arg_205_1.time_ and arg_205_1.time_ < 3.66666666666667 + var_208_22 then
				if arg_205_1.var_.characterEffect10113 then
					arg_205_1.var_.characterEffect10113.alpha = Mathf.Lerp(arg_205_1.var_.alphaOldValue10113, 1, (arg_205_1.time_ - 3.66666666666667) / var_208_22)
				end
			end

			if arg_205_1.time_ >= 3.66666666666667 + var_208_22 and arg_205_1.time_ < 3.66666666666667 + var_208_22 + arg_208_0 and arg_205_1.var_.characterEffect10113 then
				arg_205_1.var_.characterEffect10113.alpha = 1
			end

			if 1.73333333333333 < arg_205_1.time_ and arg_205_1.time_ <= 1.73333333333333 + arg_208_0 then
				arg_205_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_thunderloop", "")
			end

			if arg_205_1.frameCnt_ <= 1 then
				arg_205_1.dialog_:SetActive(false)
			end

			local var_208_24 = 4
			local var_208_25 = 0.55

			if 4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_24 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				arg_205_1.dialog_:SetActive(true)

				arg_205_1.dialogCg_.alpha = 0

				local var_208_26 = LeanTween.value(arg_205_1.dialog_, 0, 1, 0.3)

				var_208_26:setOnUpdate(LuaHelper.FloatAction(function(arg_209_0)
					arg_205_1.dialogCg_.alpha = arg_209_0
				end))
				var_208_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_205_1.dialog_)
					var_208_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_205_1.duration_ = arg_205_1.duration_ + 0.3

				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_27 = arg_205_1:GetWordFromCfg(417221048)
				local var_208_28 = arg_205_1:FormatText(var_208_27.content)

				arg_205_1.text_.text = var_208_28

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_30 = 22 <= 0 and var_208_25 or var_208_25 * (utf8.len(var_208_28) / 22)

				if (22 <= 0 and var_208_25 or var_208_25 * (utf8.len(var_208_28) / 22)) > 0 and var_208_25 < var_208_30 then
					arg_205_1.talkMaxDuration = var_208_30
					var_208_24 = var_208_24 + 0.3

					if var_208_30 + var_208_24 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_30 + var_208_24
					end
				end

				arg_205_1.text_.text = var_208_28
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221048", "story_v_out_417221.awb") ~= 0 then
					local var_208_31 = manager.audio:GetVoiceLength("story_v_out_417221", "417221048", "story_v_out_417221.awb") / 1000

					if var_208_31 + var_208_24 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_31 + var_208_24
					end

					if var_208_27.prefab_name ~= "" and arg_205_1.actors_[var_208_27.prefab_name] ~= nil then
						local var_208_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_27.prefab_name].transform, "story_v_out_417221", "417221048", "story_v_out_417221.awb")

						arg_205_1:RecordAudio("417221048", var_208_32)
						arg_205_1:RecordAudio("417221048", var_208_32)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_417221", "417221048", "story_v_out_417221.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_417221", "417221048", "story_v_out_417221.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_33 = var_208_24 + 0.3
			local var_208_34 = math.max(var_208_25, arg_205_1.talkMaxDuration)

			if var_208_24 + 0.3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_33 + var_208_34 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_33) / var_208_34

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_33 + var_208_34 and arg_205_1.time_ < var_208_33 + var_208_34 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play417221049 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 417221049
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play417221050(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10113 = arg_211_1.actors_["10113"].transform.localPosition
				arg_211_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10113", 7)

				for iter_214_0 = 0, arg_211_1.actors_["10113"].transform.childCount - 1 do
					local var_214_0 = arg_211_1.actors_["10113"].transform:GetChild(iter_214_0)

					if var_214_0.name == "" or not string.find(var_214_0.name, "split") then
						var_214_0.gameObject:SetActive(true)
					else
						var_214_0.gameObject:SetActive(false)
					end
				end
			end

			local var_214_1 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_1 then
				arg_211_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_211_1.time_ - 0) / var_214_1)
			end

			if arg_211_1.time_ >= 0 + var_214_1 and arg_211_1.time_ < 0 + var_214_1 + arg_214_0 then
				arg_211_1.actors_["10113"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.05 < arg_211_1.time_ and arg_211_1.time_ <= 0.05 + arg_214_0 then
				arg_211_1:AudioAction("play", "effect", "se_story_side_1084", "se_story_1084_applause", "")
			end

			local var_214_3 = 0
			local var_214_4 = 1.625

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_5 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(417221049).content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 65 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 65)

				if (65 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 65)) > 0 and var_214_4 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_3 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_3
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_4, arg_211_1.talkMaxDuration)

			if var_214_3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_3 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_3) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_3 + var_214_8 and arg_211_1.time_ < var_214_3 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play417221050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 417221050
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play417221051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.55

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(417221050).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 62 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 62)

				if (62 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 62)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play417221051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 417221051
		arg_219_1.duration_ = 1.83

		local var_219_0 = {
			zh = 1.033,
			ja = 1.833
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play417221052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.166666666666667

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1149].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10110_split_2")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_1 = arg_219_1:GetWordFromCfg(417221051)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 2 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 2)

				if (2 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 2)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221051", "story_v_out_417221.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221051", "story_v_out_417221.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_417221", "417221051", "story_v_out_417221.awb")

						arg_219_1:RecordAudio("417221051", var_222_6)
						arg_219_1:RecordAudio("417221051", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_417221", "417221051", "story_v_out_417221.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_417221", "417221051", "story_v_out_417221.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_7 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_7

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play417221052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 417221052
		arg_223_1.duration_ = 10.83

		local var_223_0 = {
			zh = 9.666,
			ja = 10.833
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
				arg_223_0:Play417221053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["10113"]) and arg_223_1.var_.actorSpriteComps10113 == nil then
				arg_223_1.var_.actorSpriteComps10113 = arg_223_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["10113"]) then
				if arg_223_1.var_.actorSpriteComps10113 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								iter_226_1.color = Color.New(Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor1.r, (arg_223_1.time_ - 0) / var_226_0), Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor1.g, (arg_223_1.time_ - 0) / var_226_0), (Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor1.b, (arg_223_1.time_ - 0) / var_226_0)))
							else
								local var_226_1 = Mathf.Lerp(iter_226_1.color.r, 1, (arg_223_1.time_ - 0) / var_226_0)

								iter_226_1.color = Color.New(var_226_1, var_226_1, var_226_1)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["10113"]) and arg_223_1.var_.actorSpriteComps10113 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_226_3 then
						iter_226_3.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps10113 = nil
			end

			local var_226_2 = arg_223_1.actors_["10113"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10113 = var_226_2.localPosition
				var_226_2.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10113", 3)

				for iter_226_4 = 0, var_226_2.childCount - 1 do
					local var_226_3 = var_226_2:GetChild(iter_226_4)

					if var_226_3.name == "" or not string.find(var_226_3.name, "split") then
						var_226_3.gameObject:SetActive(true)
					else
						var_226_3.gameObject:SetActive(false)
					end
				end
			end

			local var_226_4 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				var_226_2.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_223_1.time_ - 0) / var_226_4)
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				var_226_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_226_5 = 0
			local var_226_6 = 0.925

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_7 = arg_223_1:GetWordFromCfg(417221052)
				local var_226_8 = arg_223_1:FormatText(var_226_7.content)

				arg_223_1.text_.text = var_226_8

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_10 = 37 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 37)

				if (37 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 37)) > 0 and var_226_6 < var_226_10 then
					arg_223_1.talkMaxDuration = var_226_10

					if var_226_10 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_5
					end
				end

				arg_223_1.text_.text = var_226_8
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221052", "story_v_out_417221.awb") ~= 0 then
					local var_226_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221052", "story_v_out_417221.awb") / 1000

					if var_226_11 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_5
					end

					if var_226_7.prefab_name ~= "" and arg_223_1.actors_[var_226_7.prefab_name] ~= nil then
						local var_226_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_7.prefab_name].transform, "story_v_out_417221", "417221052", "story_v_out_417221.awb")

						arg_223_1:RecordAudio("417221052", var_226_12)
						arg_223_1:RecordAudio("417221052", var_226_12)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_417221", "417221052", "story_v_out_417221.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_417221", "417221052", "story_v_out_417221.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_13 = math.max(var_226_6, arg_223_1.talkMaxDuration)

			if var_226_5 <= arg_223_1.time_ and arg_223_1.time_ < var_226_5 + var_226_13 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_5) / var_226_13

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_5 + var_226_13 and arg_223_1.time_ < var_226_5 + var_226_13 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play417221053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 417221053
		arg_227_1.duration_ = 6.5

		local var_227_0 = {
			zh = 5.666,
			ja = 6.5
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play417221054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos10113 = arg_227_1.actors_["10113"].transform.localPosition
				arg_227_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10113", 7)

				for iter_230_0 = 0, arg_227_1.actors_["10113"].transform.childCount - 1 do
					local var_230_0 = arg_227_1.actors_["10113"].transform:GetChild(iter_230_0)

					if var_230_0.name == "" or not string.find(var_230_0.name, "split") then
						var_230_0.gameObject:SetActive(true)
					else
						var_230_0.gameObject:SetActive(false)
					end
				end
			end

			local var_230_1 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_1 then
				arg_227_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_227_1.time_ - 0) / var_230_1)
			end

			if arg_227_1.time_ >= 0 + var_230_1 and arg_227_1.time_ < 0 + var_230_1 + arg_230_0 then
				arg_227_1.actors_["10113"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_230_2 = 0
			local var_230_3 = 0.65

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1150].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_4 = arg_227_1:GetWordFromCfg(417221053)
				local var_230_5 = arg_227_1:FormatText(var_230_4.content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 26 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 26)

				if (26 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 26)) > 0 and var_230_3 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221053", "story_v_out_417221.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221053", "story_v_out_417221.awb") / 1000

					if var_230_8 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_2
					end

					if var_230_4.prefab_name ~= "" and arg_227_1.actors_[var_230_4.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_4.prefab_name].transform, "story_v_out_417221", "417221053", "story_v_out_417221.awb")

						arg_227_1:RecordAudio("417221053", var_230_9)
						arg_227_1:RecordAudio("417221053", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_417221", "417221053", "story_v_out_417221.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_417221", "417221053", "story_v_out_417221.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_10 and arg_227_1.time_ < var_230_2 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play417221054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 417221054
		arg_231_1.duration_ = 2.63

		local var_231_0 = {
			zh = 1.2,
			ja = 2.633
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play417221055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.2

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[1150].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_1 = arg_231_1:GetWordFromCfg(417221054)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 4 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 4)

				if (4 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 4)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221054", "story_v_out_417221.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221054", "story_v_out_417221.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_417221", "417221054", "story_v_out_417221.awb")

						arg_231_1:RecordAudio("417221054", var_234_6)
						arg_231_1:RecordAudio("417221054", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_417221", "417221054", "story_v_out_417221.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_417221", "417221054", "story_v_out_417221.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play417221055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 417221055
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play417221056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.9

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(417221055).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 36 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 36)

				if (36 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 36)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play417221056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 417221056
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play417221057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 1.35 < arg_239_1.time_ and arg_239_1.time_ <= 1.35 + arg_242_0 then
				arg_239_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_shoes", "")
			end

			local var_242_1 = 0
			local var_242_2 = 1.35

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_3 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(417221056).content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 54 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 54)

				if (54 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 54)) > 0 and var_242_2 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_6 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_6 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_6

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_6 and arg_239_1.time_ < var_242_1 + var_242_6 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play417221057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 417221057
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play417221058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 1.1 < arg_243_1.time_ and arg_243_1.time_ <= 1.1 + arg_246_0 then
				arg_243_1:AudioAction("play", "effect", "se_story_11", "se_story_11_microphone", "")
			end

			local var_246_1 = 0
			local var_246_2 = 1.275

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(417221057).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 51 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 51)

				if (51 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 51)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play417221058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 417221058
		arg_247_1.duration_ = 12.27

		local var_247_0 = {
			zh = 9.366,
			ja = 12.266
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play417221059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10113"]) and arg_247_1.var_.actorSpriteComps10113 == nil then
				arg_247_1.var_.actorSpriteComps10113 = arg_247_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_0 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["10113"]) then
				if arg_247_1.var_.actorSpriteComps10113 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								iter_250_1.color = Color.New(Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor1.r, (arg_247_1.time_ - 0) / var_250_0), Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor1.g, (arg_247_1.time_ - 0) / var_250_0), (Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor1.b, (arg_247_1.time_ - 0) / var_250_0)))
							else
								local var_250_1 = Mathf.Lerp(iter_250_1.color.r, 1, (arg_247_1.time_ - 0) / var_250_0)

								iter_250_1.color = Color.New(var_250_1, var_250_1, var_250_1)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["10113"]) and arg_247_1.var_.actorSpriteComps10113 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_250_3 then
						iter_250_3.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_247_1.var_.actorSpriteComps10113 = nil
			end

			local var_250_2 = arg_247_1.actors_["10113"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10113 = var_250_2.localPosition
				var_250_2.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10113", 3)

				for iter_250_4 = 0, var_250_2.childCount - 1 do
					local var_250_3 = var_250_2:GetChild(iter_250_4)

					if var_250_3.name == "" or not string.find(var_250_3.name, "split") then
						var_250_3.gameObject:SetActive(true)
					else
						var_250_3.gameObject:SetActive(false)
					end
				end
			end

			local var_250_4 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				var_250_2.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_247_1.time_ - 0) / var_250_4)
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				var_250_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_250_5 = 0
			local var_250_6 = 0.875

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_7 = arg_247_1:GetWordFromCfg(417221058)
				local var_250_8 = arg_247_1:FormatText(var_250_7.content)

				arg_247_1.text_.text = var_250_8

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_10 = 35 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_8) / 35)

				if (35 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_8) / 35)) > 0 and var_250_6 < var_250_10 then
					arg_247_1.talkMaxDuration = var_250_10

					if var_250_10 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_5
					end
				end

				arg_247_1.text_.text = var_250_8
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221058", "story_v_out_417221.awb") ~= 0 then
					local var_250_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221058", "story_v_out_417221.awb") / 1000

					if var_250_11 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_11 + var_250_5
					end

					if var_250_7.prefab_name ~= "" and arg_247_1.actors_[var_250_7.prefab_name] ~= nil then
						local var_250_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_7.prefab_name].transform, "story_v_out_417221", "417221058", "story_v_out_417221.awb")

						arg_247_1:RecordAudio("417221058", var_250_12)
						arg_247_1:RecordAudio("417221058", var_250_12)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_417221", "417221058", "story_v_out_417221.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_417221", "417221058", "story_v_out_417221.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_13 = math.max(var_250_6, arg_247_1.talkMaxDuration)

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_13 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_5) / var_250_13

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_5 + var_250_13 and arg_247_1.time_ < var_250_5 + var_250_13 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play417221059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 417221059
		arg_251_1.duration_ = 10.3

		local var_251_0 = {
			zh = 5.7,
			ja = 10.3
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play417221060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["10113"]) and arg_251_1.var_.actorSpriteComps10113 == nil then
				arg_251_1.var_.actorSpriteComps10113 = arg_251_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["10113"]) then
				if arg_251_1.var_.actorSpriteComps10113 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								iter_254_1.color = Color.New(Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor2.r, (arg_251_1.time_ - 0) / var_254_0), Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor2.g, (arg_251_1.time_ - 0) / var_254_0), (Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor2.b, (arg_251_1.time_ - 0) / var_254_0)))
							else
								local var_254_1 = Mathf.Lerp(iter_254_1.color.r, 0.5, (arg_251_1.time_ - 0) / var_254_0)

								iter_254_1.color = Color.New(var_254_1, var_254_1, var_254_1)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["10113"]) and arg_251_1.var_.actorSpriteComps10113 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_251_1.var_.actorSpriteComps10113 = nil
			end

			local var_254_2 = 0
			local var_254_3 = 0.7

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1150].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_4 = arg_251_1:GetWordFromCfg(417221059)
				local var_254_5 = arg_251_1:FormatText(var_254_4.content)

				arg_251_1.text_.text = var_254_5

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_7 = 28 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 28)

				if (28 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_5) / 28)) > 0 and var_254_3 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_5
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221059", "story_v_out_417221.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221059", "story_v_out_417221.awb") / 1000

					if var_254_8 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_2
					end

					if var_254_4.prefab_name ~= "" and arg_251_1.actors_[var_254_4.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_4.prefab_name].transform, "story_v_out_417221", "417221059", "story_v_out_417221.awb")

						arg_251_1:RecordAudio("417221059", var_254_9)
						arg_251_1:RecordAudio("417221059", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_417221", "417221059", "story_v_out_417221.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_417221", "417221059", "story_v_out_417221.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_3, arg_251_1.talkMaxDuration)

			if var_254_2 <= arg_251_1.time_ and arg_251_1.time_ < var_254_2 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_2) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_2 + var_254_10 and arg_251_1.time_ < var_254_2 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play417221060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 417221060
		arg_255_1.duration_ = 7.47

		local var_255_0 = {
			zh = 7.466,
			ja = 7.433
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play417221061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10113"]) and arg_255_1.var_.actorSpriteComps10113 == nil then
				arg_255_1.var_.actorSpriteComps10113 = arg_255_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["10113"]) then
				if arg_255_1.var_.actorSpriteComps10113 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								iter_258_1.color = Color.New(Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 0) / var_258_0), Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 0) / var_258_0), (Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 0) / var_258_0)))
							else
								local var_258_1 = Mathf.Lerp(iter_258_1.color.r, 1, (arg_255_1.time_ - 0) / var_258_0)

								iter_258_1.color = Color.New(var_258_1, var_258_1, var_258_1)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["10113"]) and arg_255_1.var_.actorSpriteComps10113 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps10113 = nil
			end

			local var_258_2 = 0
			local var_258_3 = 0.525

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_4 = arg_255_1:GetWordFromCfg(417221060)
				local var_258_5 = arg_255_1:FormatText(var_258_4.content)

				arg_255_1.text_.text = var_258_5

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_7 = 21 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 21)

				if (21 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 21)) > 0 and var_258_3 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_2
					end
				end

				arg_255_1.text_.text = var_258_5
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221060", "story_v_out_417221.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221060", "story_v_out_417221.awb") / 1000

					if var_258_8 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_2
					end

					if var_258_4.prefab_name ~= "" and arg_255_1.actors_[var_258_4.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_4.prefab_name].transform, "story_v_out_417221", "417221060", "story_v_out_417221.awb")

						arg_255_1:RecordAudio("417221060", var_258_9)
						arg_255_1:RecordAudio("417221060", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_417221", "417221060", "story_v_out_417221.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_417221", "417221060", "story_v_out_417221.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_3, arg_255_1.talkMaxDuration)

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_2) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_2 + var_258_10 and arg_255_1.time_ < var_258_2 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play417221061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 417221061
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play417221062(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10113 = arg_259_1.actors_["10113"].transform.localPosition
				arg_259_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10113", 7)

				for iter_262_0 = 0, arg_259_1.actors_["10113"].transform.childCount - 1 do
					local var_262_0 = arg_259_1.actors_["10113"].transform:GetChild(iter_262_0)

					if var_262_0.name == "" or not string.find(var_262_0.name, "split") then
						var_262_0.gameObject:SetActive(true)
					else
						var_262_0.gameObject:SetActive(false)
					end
				end
			end

			local var_262_1 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_1 then
				arg_259_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_259_1.time_ - 0) / var_262_1)
			end

			if arg_259_1.time_ >= 0 + var_262_1 and arg_259_1.time_ < 0 + var_262_1 + arg_262_0 then
				arg_259_1.actors_["10113"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_262_2 = 0
			local var_262_3 = 1.5

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_2 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_4 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(417221061).content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_6 = 60 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_4) / 60)

				if (60 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_4) / 60)) > 0 and var_262_3 < var_262_6 then
					arg_259_1.talkMaxDuration = var_262_6

					if var_262_6 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_6 + var_262_2
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_3, arg_259_1.talkMaxDuration)

			if var_262_2 <= arg_259_1.time_ and arg_259_1.time_ < var_262_2 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_2) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_2 + var_262_7 and arg_259_1.time_ < var_262_2 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play417221062 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 417221062
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play417221063(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.6

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(417221062).content)

				arg_263_1.text_.text = var_266_1

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_3 = 24 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 24)

				if (24 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 24)) > 0 and var_266_0 < var_266_3 then
					arg_263_1.talkMaxDuration = var_266_3

					if var_266_3 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_3 + 0
					end
				end

				arg_263_1.text_.text = var_266_1
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_4 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_4

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play417221063 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 417221063
		arg_267_1.duration_ = 6.23

		local var_267_0 = {
			zh = 3.866,
			ja = 6.233
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play417221064(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 2 < arg_267_1.time_ and arg_267_1.time_ <= 2 + arg_270_0 then
				arg_267_1.allBtn_.enabled = false
			end

			if arg_267_1.time_ >= 2 + 0.0666666666666669 and arg_267_1.time_ < 2 + 0.0666666666666669 + arg_270_0 then
				arg_267_1.allBtn_.enabled = true
			end

			local var_270_0 = "I07a"

			if arg_267_1.bgs_.I07a == nil then
				local var_270_1 = Object.Instantiate(arg_267_1.paintGo_)

				var_270_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_270_0)
				var_270_1.name = var_270_0
				var_270_1.transform.parent = arg_267_1.stage_.transform
				var_270_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_267_1.bgs_[var_270_0] = var_270_1
			end

			if 1 < arg_267_1.time_ and arg_267_1.time_ <= 1 + arg_270_0 then
				local var_270_2 = arg_267_1.bgs_.I07a

				arg_267_1.bgs_.I07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_270_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_270_3 = var_270_2:GetComponent("SpriteRenderer")

				if var_270_3 and var_270_3.sprite then
					local var_270_4 = 2 * (var_270_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_270_2.transform.localScale = Vector3.New(var_270_4 / var_270_3.sprite.bounds.size.y < var_270_4 * manager.ui.mainCameraCom_.aspect / var_270_3.sprite.bounds.size.x and var_270_4 * manager.ui.mainCameraCom_.aspect / var_270_3.sprite.bounds.size.x or var_270_4 / var_270_3.sprite.bounds.size.y, var_270_4 / var_270_3.sprite.bounds.size.y < var_270_4 * manager.ui.mainCameraCom_.aspect / var_270_3.sprite.bounds.size.x and var_270_4 * manager.ui.mainCameraCom_.aspect / var_270_3.sprite.bounds.size.x or var_270_4 / var_270_3.sprite.bounds.size.y, 0)
				end

				for iter_270_0, iter_270_1 in pairs(arg_267_1.bgs_) do
					if iter_270_0 ~= "I07a" then
						iter_270_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_270_5 = 0

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_6 = 1

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_6 then
				local var_270_7 = Color.New(0, 0, 0)

				var_270_7.a = Mathf.Lerp(0, 1, (arg_267_1.time_ - var_270_5) / var_270_6)
				arg_267_1.mask_.color = var_270_7
			end

			if arg_267_1.time_ >= var_270_5 + var_270_6 and arg_267_1.time_ < var_270_5 + var_270_6 + arg_270_0 then
				local var_270_8 = Color.New(0, 0, 0)

				var_270_8.a = 1
				arg_267_1.mask_.color = var_270_8
			end

			local var_270_9 = 1

			if 1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_9 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_10 = 1

			if var_270_9 <= arg_267_1.time_ and arg_267_1.time_ < var_270_9 + var_270_10 then
				local var_270_11 = Color.New(0, 0, 0)

				var_270_11.a = Mathf.Lerp(1, 0, (arg_267_1.time_ - var_270_9) / var_270_10)
				arg_267_1.mask_.color = var_270_11
			end

			if arg_267_1.time_ >= var_270_9 + var_270_10 and arg_267_1.time_ < var_270_9 + var_270_10 + arg_270_0 then
				local var_270_12 = Color.New(0, 0, 0)

				arg_267_1.mask_.enabled = false
				var_270_12.a = 0
				arg_267_1.mask_.color = var_270_12
			end

			if 0.05 < arg_267_1.time_ and arg_267_1.time_ <= 0.05 + arg_270_0 then
				arg_267_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_thunderloop", "")
			end

			if arg_267_1.frameCnt_ <= 1 then
				arg_267_1.dialog_:SetActive(false)
			end

			local var_270_14 = 2
			local var_270_15 = 0.15

			if 2 < arg_267_1.time_ and arg_267_1.time_ <= var_270_14 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0

				arg_267_1.dialog_:SetActive(true)

				arg_267_1.dialogCg_.alpha = 0

				local var_270_16 = LeanTween.value(arg_267_1.dialog_, 0, 1, 0.3)

				var_270_16:setOnUpdate(LuaHelper.FloatAction(function(arg_271_0)
					arg_267_1.dialogCg_.alpha = arg_271_0
				end))
				var_270_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_267_1.dialog_)
					var_270_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_267_1.duration_ = arg_267_1.duration_ + 0.3

				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[1135].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_17 = arg_267_1:GetWordFromCfg(417221063)
				local var_270_18 = arg_267_1:FormatText(var_270_17.content)

				arg_267_1.text_.text = var_270_18

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_20 = 6 <= 0 and var_270_15 or var_270_15 * (utf8.len(var_270_18) / 6)

				if (6 <= 0 and var_270_15 or var_270_15 * (utf8.len(var_270_18) / 6)) > 0 and var_270_15 < var_270_20 then
					arg_267_1.talkMaxDuration = var_270_20
					var_270_14 = var_270_14 + 0.3

					if var_270_20 + var_270_14 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_20 + var_270_14
					end
				end

				arg_267_1.text_.text = var_270_18
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221063", "story_v_out_417221.awb") ~= 0 then
					local var_270_21 = manager.audio:GetVoiceLength("story_v_out_417221", "417221063", "story_v_out_417221.awb") / 1000

					if var_270_21 + var_270_14 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_21 + var_270_14
					end

					if var_270_17.prefab_name ~= "" and arg_267_1.actors_[var_270_17.prefab_name] ~= nil then
						local var_270_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_17.prefab_name].transform, "story_v_out_417221", "417221063", "story_v_out_417221.awb")

						arg_267_1:RecordAudio("417221063", var_270_22)
						arg_267_1:RecordAudio("417221063", var_270_22)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_417221", "417221063", "story_v_out_417221.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_417221", "417221063", "story_v_out_417221.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_23 = var_270_14 + 0.3
			local var_270_24 = math.max(var_270_15, arg_267_1.talkMaxDuration)

			if var_270_14 + 0.3 <= arg_267_1.time_ and arg_267_1.time_ < var_270_23 + var_270_24 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_23) / var_270_24

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_23 + var_270_24 and arg_267_1.time_ < var_270_23 + var_270_24 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play417221064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 417221064
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play417221065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 1.4

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(417221064).content)

				arg_273_1.text_.text = var_276_1

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_3 = 56 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 56)

				if (56 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 56)) > 0 and var_276_0 < var_276_3 then
					arg_273_1.talkMaxDuration = var_276_3

					if var_276_3 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_3 + 0
					end
				end

				arg_273_1.text_.text = var_276_1
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_4 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_4

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play417221065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 417221065
		arg_277_1.duration_ = 4.47

		local var_277_0 = {
			zh = 3.5,
			ja = 4.466
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
				arg_277_0:Play417221066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if arg_277_1.actors_["10128"] == nil then
				local var_280_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_280_0) then
					local var_280_1 = Object.Instantiate(var_280_0, arg_277_1.canvasGo_.transform)

					var_280_1.transform:SetSiblingIndex(1)

					var_280_1.name = "10128"
					var_280_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_277_1.actors_["10128"] = var_280_1

					if arg_277_1.isInRecall_ then
						for iter_280_0, iter_280_1 in ipairs((var_280_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_280_1.color = arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_280_2 = arg_277_1.actors_["10128"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps10128 == nil then
				arg_277_1.var_.actorSpriteComps10128 = var_280_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_3 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.actorSpriteComps10128 then
					for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_280_3 then
							if arg_277_1.isInRecall_ then
								iter_280_3.color = Color.New(Mathf.Lerp(iter_280_3.color.r, arg_277_1.hightColor1.r, (arg_277_1.time_ - 0) / var_280_3), Mathf.Lerp(iter_280_3.color.g, arg_277_1.hightColor1.g, (arg_277_1.time_ - 0) / var_280_3), (Mathf.Lerp(iter_280_3.color.b, arg_277_1.hightColor1.b, (arg_277_1.time_ - 0) / var_280_3)))
							else
								local var_280_4 = Mathf.Lerp(iter_280_3.color.r, 1, (arg_277_1.time_ - 0) / var_280_3)

								iter_280_3.color = Color.New(var_280_4, var_280_4, var_280_4)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps10128 then
				for iter_280_4, iter_280_5 in pairs(arg_277_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_280_5 then
						iter_280_5.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps10128 = nil
			end

			local var_280_5 = arg_277_1.actors_["10128"].transform

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10128 = var_280_5.localPosition
				var_280_5.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("10128", 3)

				for iter_280_6 = 0, var_280_5.childCount - 1 do
					local var_280_6 = var_280_5:GetChild(iter_280_6)

					if var_280_6.name == "" or not string.find(var_280_6.name, "split") then
						var_280_6.gameObject:SetActive(true)
					else
						var_280_6.gameObject:SetActive(false)
					end
				end
			end

			local var_280_7 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				var_280_5.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_277_1.time_ - 0) / var_280_7)
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				var_280_5.localPosition = Vector3.New(0, -347, -300)
			end

			local var_280_8 = 0
			local var_280_9 = 0.35

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_8 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_10 = arg_277_1:GetWordFromCfg(417221065)
				local var_280_11 = arg_277_1:FormatText(var_280_10.content)

				arg_277_1.text_.text = var_280_11

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_13 = 14 <= 0 and var_280_9 or var_280_9 * (utf8.len(var_280_11) / 14)

				if (14 <= 0 and var_280_9 or var_280_9 * (utf8.len(var_280_11) / 14)) > 0 and var_280_9 < var_280_13 then
					arg_277_1.talkMaxDuration = var_280_13

					if var_280_13 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_13 + var_280_8
					end
				end

				arg_277_1.text_.text = var_280_11
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221065", "story_v_out_417221.awb") ~= 0 then
					local var_280_14 = manager.audio:GetVoiceLength("story_v_out_417221", "417221065", "story_v_out_417221.awb") / 1000

					if var_280_14 + var_280_8 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_14 + var_280_8
					end

					if var_280_10.prefab_name ~= "" and arg_277_1.actors_[var_280_10.prefab_name] ~= nil then
						local var_280_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_10.prefab_name].transform, "story_v_out_417221", "417221065", "story_v_out_417221.awb")

						arg_277_1:RecordAudio("417221065", var_280_15)
						arg_277_1:RecordAudio("417221065", var_280_15)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_417221", "417221065", "story_v_out_417221.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_417221", "417221065", "story_v_out_417221.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_16 = math.max(var_280_9, arg_277_1.talkMaxDuration)

			if var_280_8 <= arg_277_1.time_ and arg_277_1.time_ < var_280_8 + var_280_16 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_8) / var_280_16

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_8 + var_280_16 and arg_277_1.time_ < var_280_8 + var_280_16 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play417221066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 417221066
		arg_281_1.duration_ = 5

		local var_281_0 = {
			zh = 2.966,
			ja = 5
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
				arg_281_0:Play417221067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.35

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:GetWordFromCfg(417221066)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 14 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 14)

				if (14 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 14)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221066", "story_v_out_417221.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221066", "story_v_out_417221.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_417221", "417221066", "story_v_out_417221.awb")

						arg_281_1:RecordAudio("417221066", var_284_6)
						arg_281_1:RecordAudio("417221066", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_417221", "417221066", "story_v_out_417221.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_417221", "417221066", "story_v_out_417221.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play417221067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 417221067
		arg_285_1.duration_ = 9

		local var_285_0 = {
			zh = 6.2,
			ja = 9
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play417221068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["10128"]) and arg_285_1.var_.actorSpriteComps10128 == nil then
				arg_285_1.var_.actorSpriteComps10128 = arg_285_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_0 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["10128"]) then
				if arg_285_1.var_.actorSpriteComps10128 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								iter_288_1.color = Color.New(Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor2.r, (arg_285_1.time_ - 0) / var_288_0), Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor2.g, (arg_285_1.time_ - 0) / var_288_0), (Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor2.b, (arg_285_1.time_ - 0) / var_288_0)))
							else
								local var_288_1 = Mathf.Lerp(iter_288_1.color.r, 0.5, (arg_285_1.time_ - 0) / var_288_0)

								iter_288_1.color = Color.New(var_288_1, var_288_1, var_288_1)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["10128"]) and arg_285_1.var_.actorSpriteComps10128 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_285_1.var_.actorSpriteComps10128 = nil
			end

			local var_288_2 = 0
			local var_288_3 = 0.825

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1135].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_4 = arg_285_1:GetWordFromCfg(417221067)
				local var_288_5 = arg_285_1:FormatText(var_288_4.content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_7 = 33 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 33)

				if (33 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 33)) > 0 and var_288_3 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_2
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221067", "story_v_out_417221.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221067", "story_v_out_417221.awb") / 1000

					if var_288_8 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_2
					end

					if var_288_4.prefab_name ~= "" and arg_285_1.actors_[var_288_4.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_4.prefab_name].transform, "story_v_out_417221", "417221067", "story_v_out_417221.awb")

						arg_285_1:RecordAudio("417221067", var_288_9)
						arg_285_1:RecordAudio("417221067", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_417221", "417221067", "story_v_out_417221.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_417221", "417221067", "story_v_out_417221.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_3, arg_285_1.talkMaxDuration)

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_2) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_2 + var_288_10 and arg_285_1.time_ < var_288_2 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play417221068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 417221068
		arg_289_1.duration_ = 5.87

		local var_289_0 = {
			zh = 3,
			ja = 5.866
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play417221069(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["10128"]) and arg_289_1.var_.actorSpriteComps10128 == nil then
				arg_289_1.var_.actorSpriteComps10128 = arg_289_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_0 = 0.2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["10128"]) then
				if arg_289_1.var_.actorSpriteComps10128 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								iter_292_1.color = Color.New(Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor1.r, (arg_289_1.time_ - 0) / var_292_0), Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor1.g, (arg_289_1.time_ - 0) / var_292_0), (Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor1.b, (arg_289_1.time_ - 0) / var_292_0)))
							else
								local var_292_1 = Mathf.Lerp(iter_292_1.color.r, 1, (arg_289_1.time_ - 0) / var_292_0)

								iter_292_1.color = Color.New(var_292_1, var_292_1, var_292_1)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["10128"]) and arg_289_1.var_.actorSpriteComps10128 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_292_3 then
						iter_292_3.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_289_1.var_.actorSpriteComps10128 = nil
			end

			local var_292_2 = 0
			local var_292_3 = 0.4

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_4 = arg_289_1:GetWordFromCfg(417221068)
				local var_292_5 = arg_289_1:FormatText(var_292_4.content)

				arg_289_1.text_.text = var_292_5

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_7 = 16 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 16)

				if (16 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 16)) > 0 and var_292_3 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_2
					end
				end

				arg_289_1.text_.text = var_292_5
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221068", "story_v_out_417221.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221068", "story_v_out_417221.awb") / 1000

					if var_292_8 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_2
					end

					if var_292_4.prefab_name ~= "" and arg_289_1.actors_[var_292_4.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_4.prefab_name].transform, "story_v_out_417221", "417221068", "story_v_out_417221.awb")

						arg_289_1:RecordAudio("417221068", var_292_9)
						arg_289_1:RecordAudio("417221068", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_417221", "417221068", "story_v_out_417221.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_417221", "417221068", "story_v_out_417221.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_3, arg_289_1.talkMaxDuration)

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_2) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_2 + var_292_10 and arg_289_1.time_ < var_292_2 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play417221069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 417221069
		arg_293_1.duration_ = 5.6

		local var_293_0 = {
			zh = 3.7,
			ja = 5.6
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play417221070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["10128"]) and arg_293_1.var_.actorSpriteComps10128 == nil then
				arg_293_1.var_.actorSpriteComps10128 = arg_293_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_0 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["10128"]) then
				if arg_293_1.var_.actorSpriteComps10128 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								iter_296_1.color = Color.New(Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor2.r, (arg_293_1.time_ - 0) / var_296_0), Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor2.g, (arg_293_1.time_ - 0) / var_296_0), (Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor2.b, (arg_293_1.time_ - 0) / var_296_0)))
							else
								local var_296_1 = Mathf.Lerp(iter_296_1.color.r, 0.5, (arg_293_1.time_ - 0) / var_296_0)

								iter_296_1.color = Color.New(var_296_1, var_296_1, var_296_1)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["10128"]) and arg_293_1.var_.actorSpriteComps10128 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_296_3 then
						iter_296_3.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_293_1.var_.actorSpriteComps10128 = nil
			end

			local var_296_2 = 0
			local var_296_3 = 0.45

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_2 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1135].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_4 = arg_293_1:GetWordFromCfg(417221069)
				local var_296_5 = arg_293_1:FormatText(var_296_4.content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 18 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 18)

				if (18 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_5) / 18)) > 0 and var_296_3 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_2
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221069", "story_v_out_417221.awb") ~= 0 then
					local var_296_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221069", "story_v_out_417221.awb") / 1000

					if var_296_8 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_2
					end

					if var_296_4.prefab_name ~= "" and arg_293_1.actors_[var_296_4.prefab_name] ~= nil then
						local var_296_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_4.prefab_name].transform, "story_v_out_417221", "417221069", "story_v_out_417221.awb")

						arg_293_1:RecordAudio("417221069", var_296_9)
						arg_293_1:RecordAudio("417221069", var_296_9)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_417221", "417221069", "story_v_out_417221.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_417221", "417221069", "story_v_out_417221.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_10 = math.max(var_296_3, arg_293_1.talkMaxDuration)

			if var_296_2 <= arg_293_1.time_ and arg_293_1.time_ < var_296_2 + var_296_10 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_2) / var_296_10

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_2 + var_296_10 and arg_293_1.time_ < var_296_2 + var_296_10 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play417221070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 417221070
		arg_297_1.duration_ = 7

		local var_297_0 = {
			zh = 3.866,
			ja = 7
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
				arg_297_0:Play417221071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["10128"]) and arg_297_1.var_.actorSpriteComps10128 == nil then
				arg_297_1.var_.actorSpriteComps10128 = arg_297_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_0 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["10128"]) then
				if arg_297_1.var_.actorSpriteComps10128 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								iter_300_1.color = Color.New(Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor1.r, (arg_297_1.time_ - 0) / var_300_0), Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor1.g, (arg_297_1.time_ - 0) / var_300_0), (Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor1.b, (arg_297_1.time_ - 0) / var_300_0)))
							else
								local var_300_1 = Mathf.Lerp(iter_300_1.color.r, 1, (arg_297_1.time_ - 0) / var_300_0)

								iter_300_1.color = Color.New(var_300_1, var_300_1, var_300_1)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["10128"]) and arg_297_1.var_.actorSpriteComps10128 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_300_3 then
						iter_300_3.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_297_1.var_.actorSpriteComps10128 = nil
			end

			local var_300_2 = 0
			local var_300_3 = 0.575

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_4 = arg_297_1:GetWordFromCfg(417221070)
				local var_300_5 = arg_297_1:FormatText(var_300_4.content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 23 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 23)

				if (23 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 23)) > 0 and var_300_3 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221070", "story_v_out_417221.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221070", "story_v_out_417221.awb") / 1000

					if var_300_8 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_2
					end

					if var_300_4.prefab_name ~= "" and arg_297_1.actors_[var_300_4.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_4.prefab_name].transform, "story_v_out_417221", "417221070", "story_v_out_417221.awb")

						arg_297_1:RecordAudio("417221070", var_300_9)
						arg_297_1:RecordAudio("417221070", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_417221", "417221070", "story_v_out_417221.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_417221", "417221070", "story_v_out_417221.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_3, arg_297_1.talkMaxDuration)

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_2) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_2 + var_300_10 and arg_297_1.time_ < var_300_2 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play417221071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 417221071
		arg_301_1.duration_ = 8.43

		local var_301_0 = {
			zh = 6.166,
			ja = 8.433
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play417221072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["10128"]) and arg_301_1.var_.actorSpriteComps10128 == nil then
				arg_301_1.var_.actorSpriteComps10128 = arg_301_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_0 = 0.2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["10128"]) then
				if arg_301_1.var_.actorSpriteComps10128 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_304_1 then
							if arg_301_1.isInRecall_ then
								iter_304_1.color = Color.New(Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor2.r, (arg_301_1.time_ - 0) / var_304_0), Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor2.g, (arg_301_1.time_ - 0) / var_304_0), (Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor2.b, (arg_301_1.time_ - 0) / var_304_0)))
							else
								local var_304_1 = Mathf.Lerp(iter_304_1.color.r, 0.5, (arg_301_1.time_ - 0) / var_304_0)

								iter_304_1.color = Color.New(var_304_1, var_304_1, var_304_1)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["10128"]) and arg_301_1.var_.actorSpriteComps10128 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_304_3 then
						iter_304_3.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_301_1.var_.actorSpriteComps10128 = nil
			end

			local var_304_2 = 0
			local var_304_3 = 0.85

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_2 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[1135].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_4 = arg_301_1:GetWordFromCfg(417221071)
				local var_304_5 = arg_301_1:FormatText(var_304_4.content)

				arg_301_1.text_.text = var_304_5

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_7 = 34 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_5) / 34)

				if (34 <= 0 and var_304_3 or var_304_3 * (utf8.len(var_304_5) / 34)) > 0 and var_304_3 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_2
					end
				end

				arg_301_1.text_.text = var_304_5
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221071", "story_v_out_417221.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221071", "story_v_out_417221.awb") / 1000

					if var_304_8 + var_304_2 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_2
					end

					if var_304_4.prefab_name ~= "" and arg_301_1.actors_[var_304_4.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_4.prefab_name].transform, "story_v_out_417221", "417221071", "story_v_out_417221.awb")

						arg_301_1:RecordAudio("417221071", var_304_9)
						arg_301_1:RecordAudio("417221071", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_417221", "417221071", "story_v_out_417221.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_417221", "417221071", "story_v_out_417221.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_3, arg_301_1.talkMaxDuration)

			if var_304_2 <= arg_301_1.time_ and arg_301_1.time_ < var_304_2 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_2) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_2 + var_304_10 and arg_301_1.time_ < var_304_2 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play417221072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 417221072
		arg_305_1.duration_ = 3.9

		local var_305_0 = {
			zh = 2.033,
			ja = 3.9
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play417221073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.225

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[1135].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:GetWordFromCfg(417221072)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 9 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 9)

				if (9 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 9)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221072", "story_v_out_417221.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221072", "story_v_out_417221.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_out_417221", "417221072", "story_v_out_417221.awb")

						arg_305_1:RecordAudio("417221072", var_308_6)
						arg_305_1:RecordAudio("417221072", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_417221", "417221072", "story_v_out_417221.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_417221", "417221072", "story_v_out_417221.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play417221073 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 417221073
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play417221074(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos10128 = arg_309_1.actors_["10128"].transform.localPosition
				arg_309_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("10128", 7)

				for iter_312_0 = 0, arg_309_1.actors_["10128"].transform.childCount - 1 do
					local var_312_0 = arg_309_1.actors_["10128"].transform:GetChild(iter_312_0)

					if var_312_0.name == "" or not string.find(var_312_0.name, "split") then
						var_312_0.gameObject:SetActive(true)
					else
						var_312_0.gameObject:SetActive(false)
					end
				end
			end

			local var_312_1 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_1 then
				arg_309_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_309_1.time_ - 0) / var_312_1)
			end

			if arg_309_1.time_ >= 0 + var_312_1 and arg_309_1.time_ < 0 + var_312_1 + arg_312_0 then
				arg_309_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			if 0.133333333333333 < arg_309_1.time_ and arg_309_1.time_ <= 0.133333333333333 + arg_312_0 then
				arg_309_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_handcuffs", "")
			end

			local var_312_3 = 0
			local var_312_4 = 0.925

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_3 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_5 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(417221073).content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_7 = 37 <= 0 and var_312_4 or var_312_4 * (utf8.len(var_312_5) / 37)

				if (37 <= 0 and var_312_4 or var_312_4 * (utf8.len(var_312_5) / 37)) > 0 and var_312_4 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_3 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_3
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_4, arg_309_1.talkMaxDuration)

			if var_312_3 <= arg_309_1.time_ and arg_309_1.time_ < var_312_3 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_3) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_3 + var_312_8 and arg_309_1.time_ < var_312_3 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play417221074 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 417221074
		arg_313_1.duration_ = 7.93

		local var_313_0 = {
			zh = 7.933,
			ja = 7.2
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play417221075(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["10128"]) and arg_313_1.var_.actorSpriteComps10128 == nil then
				arg_313_1.var_.actorSpriteComps10128 = arg_313_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_0 = 0.2

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["10128"]) then
				if arg_313_1.var_.actorSpriteComps10128 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_316_1 then
							if arg_313_1.isInRecall_ then
								iter_316_1.color = Color.New(Mathf.Lerp(iter_316_1.color.r, arg_313_1.hightColor1.r, (arg_313_1.time_ - 0) / var_316_0), Mathf.Lerp(iter_316_1.color.g, arg_313_1.hightColor1.g, (arg_313_1.time_ - 0) / var_316_0), (Mathf.Lerp(iter_316_1.color.b, arg_313_1.hightColor1.b, (arg_313_1.time_ - 0) / var_316_0)))
							else
								local var_316_1 = Mathf.Lerp(iter_316_1.color.r, 1, (arg_313_1.time_ - 0) / var_316_0)

								iter_316_1.color = Color.New(var_316_1, var_316_1, var_316_1)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["10128"]) and arg_313_1.var_.actorSpriteComps10128 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_316_3 then
						iter_316_3.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_313_1.var_.actorSpriteComps10128 = nil
			end

			local var_316_2 = arg_313_1.actors_["10128"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos10128 = var_316_2.localPosition
				var_316_2.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10128", 3)

				for iter_316_4 = 0, var_316_2.childCount - 1 do
					local var_316_3 = var_316_2:GetChild(iter_316_4)

					if var_316_3.name == "split_6" or not string.find(var_316_3.name, "split") then
						var_316_3.gameObject:SetActive(true)
					else
						var_316_3.gameObject:SetActive(false)
					end
				end
			end

			local var_316_4 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				var_316_2.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_313_1.time_ - 0) / var_316_4)
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				var_316_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_316_5 = 0
			local var_316_6 = 0.75

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_7 = arg_313_1:GetWordFromCfg(417221074)
				local var_316_8 = arg_313_1:FormatText(var_316_7.content)

				arg_313_1.text_.text = var_316_8

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_10 = 30 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 30)

				if (30 <= 0 and var_316_6 or var_316_6 * (utf8.len(var_316_8) / 30)) > 0 and var_316_6 < var_316_10 then
					arg_313_1.talkMaxDuration = var_316_10

					if var_316_10 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_5
					end
				end

				arg_313_1.text_.text = var_316_8
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221074", "story_v_out_417221.awb") ~= 0 then
					local var_316_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221074", "story_v_out_417221.awb") / 1000

					if var_316_11 + var_316_5 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_11 + var_316_5
					end

					if var_316_7.prefab_name ~= "" and arg_313_1.actors_[var_316_7.prefab_name] ~= nil then
						local var_316_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_7.prefab_name].transform, "story_v_out_417221", "417221074", "story_v_out_417221.awb")

						arg_313_1:RecordAudio("417221074", var_316_12)
						arg_313_1:RecordAudio("417221074", var_316_12)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_417221", "417221074", "story_v_out_417221.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_417221", "417221074", "story_v_out_417221.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_13 = math.max(var_316_6, arg_313_1.talkMaxDuration)

			if var_316_5 <= arg_313_1.time_ and arg_313_1.time_ < var_316_5 + var_316_13 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_5) / var_316_13

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_5 + var_316_13 and arg_313_1.time_ < var_316_5 + var_316_13 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play417221075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 417221075
		arg_317_1.duration_ = 6.67

		local var_317_0 = {
			zh = 3.333,
			ja = 6.666
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play417221076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["10128"]) and arg_317_1.var_.actorSpriteComps10128 == nil then
				arg_317_1.var_.actorSpriteComps10128 = arg_317_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_0 = 0.2

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["10128"]) then
				if arg_317_1.var_.actorSpriteComps10128 then
					for iter_320_0, iter_320_1 in pairs(arg_317_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_320_1 then
							if arg_317_1.isInRecall_ then
								iter_320_1.color = Color.New(Mathf.Lerp(iter_320_1.color.r, arg_317_1.hightColor2.r, (arg_317_1.time_ - 0) / var_320_0), Mathf.Lerp(iter_320_1.color.g, arg_317_1.hightColor2.g, (arg_317_1.time_ - 0) / var_320_0), (Mathf.Lerp(iter_320_1.color.b, arg_317_1.hightColor2.b, (arg_317_1.time_ - 0) / var_320_0)))
							else
								local var_320_1 = Mathf.Lerp(iter_320_1.color.r, 0.5, (arg_317_1.time_ - 0) / var_320_0)

								iter_320_1.color = Color.New(var_320_1, var_320_1, var_320_1)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["10128"]) and arg_317_1.var_.actorSpriteComps10128 then
				for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_320_3 then
						iter_320_3.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_317_1.var_.actorSpriteComps10128 = nil
			end

			local var_320_2 = 0
			local var_320_3 = 0.45

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[1135].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_4 = arg_317_1:GetWordFromCfg(417221075)
				local var_320_5 = arg_317_1:FormatText(var_320_4.content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 18 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 18)

				if (18 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 18)) > 0 and var_320_3 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_2
					end
				end

				arg_317_1.text_.text = var_320_5
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221075", "story_v_out_417221.awb") ~= 0 then
					local var_320_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221075", "story_v_out_417221.awb") / 1000

					if var_320_8 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_8 + var_320_2
					end

					if var_320_4.prefab_name ~= "" and arg_317_1.actors_[var_320_4.prefab_name] ~= nil then
						local var_320_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_4.prefab_name].transform, "story_v_out_417221", "417221075", "story_v_out_417221.awb")

						arg_317_1:RecordAudio("417221075", var_320_9)
						arg_317_1:RecordAudio("417221075", var_320_9)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_417221", "417221075", "story_v_out_417221.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_417221", "417221075", "story_v_out_417221.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_10 = math.max(var_320_3, arg_317_1.talkMaxDuration)

			if var_320_2 <= arg_317_1.time_ and arg_317_1.time_ < var_320_2 + var_320_10 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_2) / var_320_10

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_2 + var_320_10 and arg_317_1.time_ < var_320_2 + var_320_10 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play417221076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 417221076
		arg_321_1.duration_ = 14.3

		local var_321_0 = {
			zh = 12.933,
			ja = 14.3
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play417221077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 4 < arg_321_1.time_ and arg_321_1.time_ <= 4 + arg_324_0 then
				arg_321_1.allBtn_.enabled = false
			end

			if arg_321_1.time_ >= 4 + 0.3 and arg_321_1.time_ < 4 + 0.3 + arg_324_0 then
				arg_321_1.allBtn_.enabled = true
			end

			if 2 < arg_321_1.time_ and arg_321_1.time_ <= 2 + arg_324_0 then
				local var_324_0 = arg_321_1.bgs_.I16f

				arg_321_1.bgs_.I16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_324_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_324_1 = var_324_0:GetComponent("SpriteRenderer")

				if var_324_1 and var_324_1.sprite then
					local var_324_2 = 2 * (var_324_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_324_0.transform.localScale = Vector3.New(var_324_2 / var_324_1.sprite.bounds.size.y < var_324_2 * manager.ui.mainCameraCom_.aspect / var_324_1.sprite.bounds.size.x and var_324_2 * manager.ui.mainCameraCom_.aspect / var_324_1.sprite.bounds.size.x or var_324_2 / var_324_1.sprite.bounds.size.y, var_324_2 / var_324_1.sprite.bounds.size.y < var_324_2 * manager.ui.mainCameraCom_.aspect / var_324_1.sprite.bounds.size.x and var_324_2 * manager.ui.mainCameraCom_.aspect / var_324_1.sprite.bounds.size.x or var_324_2 / var_324_1.sprite.bounds.size.y, 0)
				end

				for iter_324_0, iter_324_1 in pairs(arg_321_1.bgs_) do
					if iter_324_0 ~= "I16f" then
						iter_324_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_324_3 = 0

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_3 + arg_324_0 then
				arg_321_1.mask_.enabled = true
				arg_321_1.mask_.raycastTarget = true

				arg_321_1:SetGaussion(false)
			end

			local var_324_4 = 2

			if var_324_3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_3 + var_324_4 then
				local var_324_5 = Color.New(0, 0, 0)

				var_324_5.a = Mathf.Lerp(0, 1, (arg_321_1.time_ - var_324_3) / var_324_4)
				arg_321_1.mask_.color = var_324_5
			end

			if arg_321_1.time_ >= var_324_3 + var_324_4 and arg_321_1.time_ < var_324_3 + var_324_4 + arg_324_0 then
				local var_324_6 = Color.New(0, 0, 0)

				var_324_6.a = 1
				arg_321_1.mask_.color = var_324_6
			end

			local var_324_7 = 2

			if 2 < arg_321_1.time_ and arg_321_1.time_ <= var_324_7 + arg_324_0 then
				arg_321_1.mask_.enabled = true
				arg_321_1.mask_.raycastTarget = true

				arg_321_1:SetGaussion(false)
			end

			local var_324_8 = 2

			if var_324_7 <= arg_321_1.time_ and arg_321_1.time_ < var_324_7 + var_324_8 then
				local var_324_9 = Color.New(0, 0, 0)

				var_324_9.a = Mathf.Lerp(1, 0, (arg_321_1.time_ - var_324_7) / var_324_8)
				arg_321_1.mask_.color = var_324_9
			end

			if arg_321_1.time_ >= var_324_7 + var_324_8 and arg_321_1.time_ < var_324_7 + var_324_8 + arg_324_0 then
				local var_324_10 = Color.New(0, 0, 0)

				arg_321_1.mask_.enabled = false
				var_324_10.a = 0
				arg_321_1.mask_.color = var_324_10
			end

			local var_324_11 = arg_321_1.actors_["10113"]

			if 3.76666666666667 < arg_321_1.time_ and arg_321_1.time_ <= 3.76666666666667 + arg_324_0 and not isNil(var_324_11) and arg_321_1.var_.actorSpriteComps10113 == nil then
				arg_321_1.var_.actorSpriteComps10113 = var_324_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_12 = 0.2

			if 3.76666666666667 <= arg_321_1.time_ and arg_321_1.time_ < 3.76666666666667 + var_324_12 and not isNil(var_324_11) then
				if arg_321_1.var_.actorSpriteComps10113 then
					for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_324_3 then
							if arg_321_1.isInRecall_ then
								iter_324_3.color = Color.New(Mathf.Lerp(iter_324_3.color.r, arg_321_1.hightColor1.r, (arg_321_1.time_ - 3.76666666666667) / var_324_12), Mathf.Lerp(iter_324_3.color.g, arg_321_1.hightColor1.g, (arg_321_1.time_ - 3.76666666666667) / var_324_12), (Mathf.Lerp(iter_324_3.color.b, arg_321_1.hightColor1.b, (arg_321_1.time_ - 3.76666666666667) / var_324_12)))
							else
								local var_324_13 = Mathf.Lerp(iter_324_3.color.r, 1, (arg_321_1.time_ - 3.76666666666667) / var_324_12)

								iter_324_3.color = Color.New(var_324_13, var_324_13, var_324_13)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 3.76666666666667 + var_324_12 and arg_321_1.time_ < 3.76666666666667 + var_324_12 + arg_324_0 and not isNil(var_324_11) and arg_321_1.var_.actorSpriteComps10113 then
				for iter_324_4, iter_324_5 in pairs(arg_321_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_324_5 then
						iter_324_5.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_321_1.var_.actorSpriteComps10113 = nil
			end

			local var_324_14 = arg_321_1.actors_["10128"].transform

			if 2 < arg_321_1.time_ and arg_321_1.time_ <= 2 + arg_324_0 then
				arg_321_1.var_.moveOldPos10128 = var_324_14.localPosition
				var_324_14.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("10128", 7)

				for iter_324_6 = 0, var_324_14.childCount - 1 do
					local var_324_15 = var_324_14:GetChild(iter_324_6)

					if var_324_15.name == "" or not string.find(var_324_15.name, "split") then
						var_324_15.gameObject:SetActive(true)
					else
						var_324_15.gameObject:SetActive(false)
					end
				end
			end

			local var_324_16 = 0.001

			if 2 <= arg_321_1.time_ and arg_321_1.time_ < 2 + var_324_16 then
				var_324_14.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_321_1.time_ - 2) / var_324_16)
			end

			if arg_321_1.time_ >= 2 + var_324_16 and arg_321_1.time_ < 2 + var_324_16 + arg_324_0 then
				var_324_14.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_324_17 = arg_321_1.actors_["10113"].transform

			if 3.76666666666667 < arg_321_1.time_ and arg_321_1.time_ <= 3.76666666666667 + arg_324_0 then
				arg_321_1.var_.moveOldPos10113 = var_324_17.localPosition
				var_324_17.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("10113", 3)

				for iter_324_7 = 0, var_324_17.childCount - 1 do
					local var_324_18 = var_324_17:GetChild(iter_324_7)

					if var_324_18.name == "" or not string.find(var_324_18.name, "split") then
						var_324_18.gameObject:SetActive(true)
					else
						var_324_18.gameObject:SetActive(false)
					end
				end
			end

			local var_324_19 = 0.001

			if 3.76666666666667 <= arg_321_1.time_ and arg_321_1.time_ < 3.76666666666667 + var_324_19 then
				var_324_17.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_321_1.time_ - 3.76666666666667) / var_324_19)
			end

			if arg_321_1.time_ >= 3.76666666666667 + var_324_19 and arg_321_1.time_ < 3.76666666666667 + var_324_19 + arg_324_0 then
				var_324_17.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			if 3.76666666666667 < arg_321_1.time_ and arg_321_1.time_ <= 3.76666666666667 + arg_324_0 then
				local var_324_20 = arg_321_1.actors_["10113"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_324_20 then
					arg_321_1.var_.alphaOldValue10113 = var_324_20.alpha
					arg_321_1.var_.characterEffect10113 = var_324_20
				end

				arg_321_1.var_.alphaOldValue10113 = 0
			end

			local var_324_21 = 0.233333333333333

			if 3.76666666666667 <= arg_321_1.time_ and arg_321_1.time_ < 3.76666666666667 + var_324_21 then
				if arg_321_1.var_.characterEffect10113 then
					arg_321_1.var_.characterEffect10113.alpha = Mathf.Lerp(arg_321_1.var_.alphaOldValue10113, 1, (arg_321_1.time_ - 3.76666666666667) / var_324_21)
				end
			end

			if arg_321_1.time_ >= 3.76666666666667 + var_324_21 and arg_321_1.time_ < 3.76666666666667 + var_324_21 + arg_324_0 and arg_321_1.var_.characterEffect10113 then
				arg_321_1.var_.characterEffect10113.alpha = 1
			end

			if 1.7 < arg_321_1.time_ and arg_321_1.time_ <= 1.7 + arg_324_0 then
				arg_321_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_thunderloop", "")
			end

			if arg_321_1.frameCnt_ <= 1 then
				arg_321_1.dialog_:SetActive(false)
			end

			local var_324_23 = 4
			local var_324_24 = 1.05

			if 4 < arg_321_1.time_ and arg_321_1.time_ <= var_324_23 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				arg_321_1.dialog_:SetActive(true)

				arg_321_1.dialogCg_.alpha = 0

				local var_324_25 = LeanTween.value(arg_321_1.dialog_, 0, 1, 0.3)

				var_324_25:setOnUpdate(LuaHelper.FloatAction(function(arg_325_0)
					arg_321_1.dialogCg_.alpha = arg_325_0
				end))
				var_324_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_321_1.dialog_)
					var_324_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_321_1.duration_ = arg_321_1.duration_ + 0.3

				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_26 = arg_321_1:GetWordFromCfg(417221076)
				local var_324_27 = arg_321_1:FormatText(var_324_26.content)

				arg_321_1.text_.text = var_324_27

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_29 = 42 <= 0 and var_324_24 or var_324_24 * (utf8.len(var_324_27) / 42)

				if (42 <= 0 and var_324_24 or var_324_24 * (utf8.len(var_324_27) / 42)) > 0 and var_324_24 < var_324_29 then
					arg_321_1.talkMaxDuration = var_324_29
					var_324_23 = var_324_23 + 0.3

					if var_324_29 + var_324_23 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_29 + var_324_23
					end
				end

				arg_321_1.text_.text = var_324_27
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221076", "story_v_out_417221.awb") ~= 0 then
					local var_324_30 = manager.audio:GetVoiceLength("story_v_out_417221", "417221076", "story_v_out_417221.awb") / 1000

					if var_324_30 + var_324_23 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_30 + var_324_23
					end

					if var_324_26.prefab_name ~= "" and arg_321_1.actors_[var_324_26.prefab_name] ~= nil then
						local var_324_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_26.prefab_name].transform, "story_v_out_417221", "417221076", "story_v_out_417221.awb")

						arg_321_1:RecordAudio("417221076", var_324_31)
						arg_321_1:RecordAudio("417221076", var_324_31)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_417221", "417221076", "story_v_out_417221.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_417221", "417221076", "story_v_out_417221.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_32 = var_324_23 + 0.3
			local var_324_33 = math.max(var_324_24, arg_321_1.talkMaxDuration)

			if var_324_23 + 0.3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_32 + var_324_33 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_32) / var_324_33

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_32 + var_324_33 and arg_321_1.time_ < var_324_32 + var_324_33 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play417221077 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 417221077
		arg_327_1.duration_ = 9.67

		local var_327_0 = {
			zh = 9.666,
			ja = 9.366
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play417221078(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 1.05

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:GetWordFromCfg(417221077)
				local var_330_2 = arg_327_1:FormatText(var_330_1.content)

				arg_327_1.text_.text = var_330_2

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 42 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 42)

				if (42 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 42)) > 0 and var_330_0 < var_330_4 then
					arg_327_1.talkMaxDuration = var_330_4

					if var_330_4 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_4 + 0
					end
				end

				arg_327_1.text_.text = var_330_2
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221077", "story_v_out_417221.awb") ~= 0 then
					local var_330_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221077", "story_v_out_417221.awb") / 1000

					if var_330_5 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + 0
					end

					if var_330_1.prefab_name ~= "" and arg_327_1.actors_[var_330_1.prefab_name] ~= nil then
						local var_330_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_1.prefab_name].transform, "story_v_out_417221", "417221077", "story_v_out_417221.awb")

						arg_327_1:RecordAudio("417221077", var_330_6)
						arg_327_1:RecordAudio("417221077", var_330_6)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_417221", "417221077", "story_v_out_417221.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_417221", "417221077", "story_v_out_417221.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play417221078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 417221078
		arg_331_1.duration_ = 13.17

		local var_331_0 = {
			zh = 12.933,
			ja = 13.166
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play417221079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 1.375

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:GetWordFromCfg(417221078)
				local var_334_2 = arg_331_1:FormatText(var_334_1.content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 55 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 55)

				if (55 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 55)) > 0 and var_334_0 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + 0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221078", "story_v_out_417221.awb") ~= 0 then
					local var_334_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221078", "story_v_out_417221.awb") / 1000

					if var_334_5 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + 0
					end

					if var_334_1.prefab_name ~= "" and arg_331_1.actors_[var_334_1.prefab_name] ~= nil then
						local var_334_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_1.prefab_name].transform, "story_v_out_417221", "417221078", "story_v_out_417221.awb")

						arg_331_1:RecordAudio("417221078", var_334_6)
						arg_331_1:RecordAudio("417221078", var_334_6)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_417221", "417221078", "story_v_out_417221.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_417221", "417221078", "story_v_out_417221.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play417221079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 417221079
		arg_335_1.duration_ = 12.83

		local var_335_0 = {
			zh = 9.833,
			ja = 12.833
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play417221080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 1.075

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_1 = arg_335_1:GetWordFromCfg(417221079)
				local var_338_2 = arg_335_1:FormatText(var_338_1.content)

				arg_335_1.text_.text = var_338_2

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_4 = 43 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 43)

				if (43 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 43)) > 0 and var_338_0 < var_338_4 then
					arg_335_1.talkMaxDuration = var_338_4

					if var_338_4 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_4 + 0
					end
				end

				arg_335_1.text_.text = var_338_2
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221079", "story_v_out_417221.awb") ~= 0 then
					local var_338_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221079", "story_v_out_417221.awb") / 1000

					if var_338_5 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + 0
					end

					if var_338_1.prefab_name ~= "" and arg_335_1.actors_[var_338_1.prefab_name] ~= nil then
						local var_338_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_1.prefab_name].transform, "story_v_out_417221", "417221079", "story_v_out_417221.awb")

						arg_335_1:RecordAudio("417221079", var_338_6)
						arg_335_1:RecordAudio("417221079", var_338_6)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_417221", "417221079", "story_v_out_417221.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_417221", "417221079", "story_v_out_417221.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_7 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_7 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_7

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_7 and arg_335_1.time_ < 0 + var_338_7 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play417221080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 417221080
		arg_339_1.duration_ = 9.27

		local var_339_0 = {
			zh = 6.233,
			ja = 9.266
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play417221081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos10113 = arg_339_1.actors_["10113"].transform.localPosition
				arg_339_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("10113", 3)

				for iter_342_0 = 0, arg_339_1.actors_["10113"].transform.childCount - 1 do
					local var_342_0 = arg_339_1.actors_["10113"].transform:GetChild(iter_342_0)

					if var_342_0.name == "split_4" or not string.find(var_342_0.name, "split") then
						var_342_0.gameObject:SetActive(true)
					else
						var_342_0.gameObject:SetActive(false)
					end
				end
			end

			local var_342_1 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_1 then
				arg_339_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_339_1.time_ - 0) / var_342_1)
			end

			if arg_339_1.time_ >= 0 + var_342_1 and arg_339_1.time_ < 0 + var_342_1 + arg_342_0 then
				arg_339_1.actors_["10113"].transform.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_342_2 = 0
			local var_342_3 = 0.5

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_2 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_4 = arg_339_1:GetWordFromCfg(417221080)
				local var_342_5 = arg_339_1:FormatText(var_342_4.content)

				arg_339_1.text_.text = var_342_5

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_7 = 20 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 20)

				if (20 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_5) / 20)) > 0 and var_342_3 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_2
					end
				end

				arg_339_1.text_.text = var_342_5
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221080", "story_v_out_417221.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221080", "story_v_out_417221.awb") / 1000

					if var_342_8 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_2
					end

					if var_342_4.prefab_name ~= "" and arg_339_1.actors_[var_342_4.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_4.prefab_name].transform, "story_v_out_417221", "417221080", "story_v_out_417221.awb")

						arg_339_1:RecordAudio("417221080", var_342_9)
						arg_339_1:RecordAudio("417221080", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_417221", "417221080", "story_v_out_417221.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_417221", "417221080", "story_v_out_417221.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_10 = math.max(var_342_3, arg_339_1.talkMaxDuration)

			if var_342_2 <= arg_339_1.time_ and arg_339_1.time_ < var_342_2 + var_342_10 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_2) / var_342_10

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_2 + var_342_10 and arg_339_1.time_ < var_342_2 + var_342_10 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play417221081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 417221081
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play417221082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["10113"]) and arg_343_1.var_.actorSpriteComps10113 == nil then
				arg_343_1.var_.actorSpriteComps10113 = arg_343_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_0 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["10113"]) then
				if arg_343_1.var_.actorSpriteComps10113 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								iter_346_1.color = Color.New(Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor2.r, (arg_343_1.time_ - 0) / var_346_0), Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor2.g, (arg_343_1.time_ - 0) / var_346_0), (Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor2.b, (arg_343_1.time_ - 0) / var_346_0)))
							else
								local var_346_1 = Mathf.Lerp(iter_346_1.color.r, 0.5, (arg_343_1.time_ - 0) / var_346_0)

								iter_346_1.color = Color.New(var_346_1, var_346_1, var_346_1)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["10113"]) and arg_343_1.var_.actorSpriteComps10113 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_346_3 then
						iter_346_3.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_343_1.var_.actorSpriteComps10113 = nil
			end

			local var_346_2 = 0
			local var_346_3 = 1.5

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_4 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(417221081).content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_6 = 60 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_4) / 60)

				if (60 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_4) / 60)) > 0 and var_346_3 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_2 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_2
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_3, arg_343_1.talkMaxDuration)

			if var_346_2 <= arg_343_1.time_ and arg_343_1.time_ < var_346_2 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_2) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_2 + var_346_7 and arg_343_1.time_ < var_346_2 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play417221082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 417221082
		arg_347_1.duration_ = 8.1

		local var_347_0 = {
			zh = 6,
			ja = 8.1
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play417221083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["10113"]) and arg_347_1.var_.actorSpriteComps10113 == nil then
				arg_347_1.var_.actorSpriteComps10113 = arg_347_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_0 = 0.034

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["10113"]) then
				if arg_347_1.var_.actorSpriteComps10113 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								iter_350_1.color = Color.New(Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor1.r, (arg_347_1.time_ - 0) / var_350_0), Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor1.g, (arg_347_1.time_ - 0) / var_350_0), (Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor1.b, (arg_347_1.time_ - 0) / var_350_0)))
							else
								local var_350_1 = Mathf.Lerp(iter_350_1.color.r, 1, (arg_347_1.time_ - 0) / var_350_0)

								iter_350_1.color = Color.New(var_350_1, var_350_1, var_350_1)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["10113"]) and arg_347_1.var_.actorSpriteComps10113 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_350_3 then
						iter_350_3.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_347_1.var_.actorSpriteComps10113 = nil
			end

			local var_350_2 = arg_347_1.actors_["10113"].transform

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos10113 = var_350_2.localPosition
				var_350_2.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10113", 3)

				for iter_350_4 = 0, var_350_2.childCount - 1 do
					local var_350_3 = var_350_2:GetChild(iter_350_4)

					if var_350_3.name == "split_3" or not string.find(var_350_3.name, "split") then
						var_350_3.gameObject:SetActive(true)
					else
						var_350_3.gameObject:SetActive(false)
					end
				end
			end

			local var_350_4 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_4 then
				var_350_2.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_347_1.time_ - 0) / var_350_4)
			end

			if arg_347_1.time_ >= 0 + var_350_4 and arg_347_1.time_ < 0 + var_350_4 + arg_350_0 then
				var_350_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_350_5 = 0
			local var_350_6 = 0.55

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_5 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_7 = arg_347_1:GetWordFromCfg(417221082)
				local var_350_8 = arg_347_1:FormatText(var_350_7.content)

				arg_347_1.text_.text = var_350_8

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_10 = 22 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 22)

				if (22 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 22)) > 0 and var_350_6 < var_350_10 then
					arg_347_1.talkMaxDuration = var_350_10

					if var_350_10 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_5
					end
				end

				arg_347_1.text_.text = var_350_8
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221082", "story_v_out_417221.awb") ~= 0 then
					local var_350_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221082", "story_v_out_417221.awb") / 1000

					if var_350_11 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_5
					end

					if var_350_7.prefab_name ~= "" and arg_347_1.actors_[var_350_7.prefab_name] ~= nil then
						local var_350_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_7.prefab_name].transform, "story_v_out_417221", "417221082", "story_v_out_417221.awb")

						arg_347_1:RecordAudio("417221082", var_350_12)
						arg_347_1:RecordAudio("417221082", var_350_12)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_417221", "417221082", "story_v_out_417221.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_417221", "417221082", "story_v_out_417221.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_13 = math.max(var_350_6, arg_347_1.talkMaxDuration)

			if var_350_5 <= arg_347_1.time_ and arg_347_1.time_ < var_350_5 + var_350_13 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_5) / var_350_13

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_5 + var_350_13 and arg_347_1.time_ < var_350_5 + var_350_13 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play417221083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 417221083
		arg_351_1.duration_ = 11

		local var_351_0 = {
			zh = 8.466,
			ja = 11
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play417221084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.775

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:GetWordFromCfg(417221083)
				local var_354_2 = arg_351_1:FormatText(var_354_1.content)

				arg_351_1.text_.text = var_354_2

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 31 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 31)

				if (31 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 31)) > 0 and var_354_0 < var_354_4 then
					arg_351_1.talkMaxDuration = var_354_4

					if var_354_4 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_4 + 0
					end
				end

				arg_351_1.text_.text = var_354_2
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221083", "story_v_out_417221.awb") ~= 0 then
					local var_354_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221083", "story_v_out_417221.awb") / 1000

					if var_354_5 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + 0
					end

					if var_354_1.prefab_name ~= "" and arg_351_1.actors_[var_354_1.prefab_name] ~= nil then
						local var_354_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_1.prefab_name].transform, "story_v_out_417221", "417221083", "story_v_out_417221.awb")

						arg_351_1:RecordAudio("417221083", var_354_6)
						arg_351_1:RecordAudio("417221083", var_354_6)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_417221", "417221083", "story_v_out_417221.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_417221", "417221083", "story_v_out_417221.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_7 and arg_351_1.time_ < 0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play417221084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 417221084
		arg_355_1.duration_ = 9.67

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play417221085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 1.96666666666667 < arg_355_1.time_ and arg_355_1.time_ <= 1.96666666666667 + arg_358_0 then
				arg_355_1.cswbg_:SetActive(true)

				local var_358_0 = arg_355_1.cswt_:GetComponent("RectTransform")

				arg_355_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_358_0.offsetMin = Vector2.New(0, 0)
				var_358_0.offsetMax = Vector2.New(0, 0)
				arg_355_1.cswt_.text = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(419114).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.cswt_)

				arg_355_1.cswt_.fontSize = 120
				arg_355_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_355_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_355_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1.96666666666667 < arg_355_1.time_ and arg_355_1.time_ <= 1.96666666666667 + arg_358_0 then
				local var_358_1 = arg_355_1.bgs_.STblack

				arg_355_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_358_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_358_2 = var_358_1:GetComponent("SpriteRenderer")

				if var_358_2 and var_358_2.sprite then
					local var_358_3 = 2 * (var_358_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_358_1.transform.localScale = Vector3.New(var_358_3 / var_358_2.sprite.bounds.size.y < var_358_3 * manager.ui.mainCameraCom_.aspect / var_358_2.sprite.bounds.size.x and var_358_3 * manager.ui.mainCameraCom_.aspect / var_358_2.sprite.bounds.size.x or var_358_3 / var_358_2.sprite.bounds.size.y, var_358_3 / var_358_2.sprite.bounds.size.y < var_358_3 * manager.ui.mainCameraCom_.aspect / var_358_2.sprite.bounds.size.x and var_358_3 * manager.ui.mainCameraCom_.aspect / var_358_2.sprite.bounds.size.x or var_358_3 / var_358_2.sprite.bounds.size.y, 0)
				end

				for iter_358_0, iter_358_1 in pairs(arg_355_1.bgs_) do
					if iter_358_0 ~= "STblack" then
						iter_358_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.96666666666667 < arg_355_1.time_ and arg_355_1.time_ <= 1.96666666666667 + arg_358_0 then
				arg_355_1.fswbg_:SetActive(true)
				arg_355_1.dialog_:SetActive(false)

				arg_355_1.fswtw_.percent = 0
				arg_355_1.fswt_.text = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(417221084).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.fswt_)

				arg_355_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_355_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_355_1.fswtw_:SetDirty()

				arg_355_1.typewritterCharCountI18N = 0

				SetActive(arg_355_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_355_1:ShowNextGo(false)
			end

			local var_358_4 = 3.33333333333333

			if 3.33333333333333 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.var_.oldValueTypewriter = arg_355_1.fswtw_.percent

				SetActive(arg_355_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_355_1:ShowNextGo(false)
			end

			local var_358_5 = 24
			local var_358_6 = 1.6
			local var_358_7, var_358_8 = arg_355_1:GetPercentByPara(arg_355_1:FormatText(arg_355_1:GetWordFromCfg(417221084).content), 1)

			if var_358_4 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0

				local var_358_9 = var_358_5 <= 0 and var_358_6 or var_358_6 * ((var_358_8 - arg_355_1.typewritterCharCountI18N) / var_358_5)

				if (var_358_5 <= 0 and var_358_6 or var_358_6 * ((var_358_8 - arg_355_1.typewritterCharCountI18N) / var_358_5)) > 0 and var_358_6 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_4
					end
				end
			end

			local var_358_10 = math.max(1.6, arg_355_1.talkMaxDuration)

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_10 then
				arg_355_1.fswtw_.percent = Mathf.Lerp(arg_355_1.var_.oldValueTypewriter, var_358_7, (arg_355_1.time_ - var_358_4) / var_358_10)
				arg_355_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_355_1.fswtw_:SetDirty()
			end

			if arg_355_1.time_ >= var_358_4 + var_358_10 and arg_355_1.time_ < var_358_4 + var_358_10 + arg_358_0 then
				arg_355_1.fswtw_.percent = var_358_7

				arg_355_1.fswtw_:SetDirty()
				arg_355_1:ShowNextGo(true)

				arg_355_1.typewritterCharCountI18N = var_358_8
			end

			local var_358_11 = 0

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_11 + arg_358_0 then
				arg_355_1.mask_.enabled = true
				arg_355_1.mask_.raycastTarget = false

				arg_355_1:SetGaussion(false)
			end

			local var_358_12 = 1.96666666666667

			if var_358_11 <= arg_355_1.time_ and arg_355_1.time_ < var_358_11 + var_358_12 then
				local var_358_13 = Color.New(0, 0, 0)

				var_358_13.a = Mathf.Lerp(0, 1, (arg_355_1.time_ - var_358_11) / var_358_12)
				arg_355_1.mask_.color = var_358_13
			end

			if arg_355_1.time_ >= var_358_11 + var_358_12 and arg_355_1.time_ < var_358_11 + var_358_12 + arg_358_0 then
				local var_358_14 = Color.New(0, 0, 0)

				var_358_14.a = 1
				arg_355_1.mask_.color = var_358_14
			end

			local var_358_15 = 1.96666666666667

			if 1.96666666666667 < arg_355_1.time_ and arg_355_1.time_ <= var_358_15 + arg_358_0 then
				arg_355_1.mask_.enabled = true
				arg_355_1.mask_.raycastTarget = false

				arg_355_1:SetGaussion(false)
			end

			local var_358_16 = 1.96666666666667

			if var_358_15 <= arg_355_1.time_ and arg_355_1.time_ < var_358_15 + var_358_16 then
				local var_358_17 = Color.New(0, 0, 0)

				var_358_17.a = Mathf.Lerp(1, 0, (arg_355_1.time_ - var_358_15) / var_358_16)
				arg_355_1.mask_.color = var_358_17
			end

			if arg_355_1.time_ >= var_358_15 + var_358_16 and arg_355_1.time_ < var_358_15 + var_358_16 + arg_358_0 then
				local var_358_18 = Color.New(0, 0, 0)

				arg_355_1.mask_.enabled = false
				var_358_18.a = 0
				arg_355_1.mask_.color = var_358_18
			end

			local var_358_19 = arg_355_1.actors_["10113"].transform

			if 1.93266666666667 < arg_355_1.time_ and arg_355_1.time_ <= 1.93266666666667 + arg_358_0 then
				arg_355_1.var_.moveOldPos10113 = var_358_19.localPosition
				var_358_19.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10113", 7)

				for iter_358_2 = 0, var_358_19.childCount - 1 do
					local var_358_20 = var_358_19:GetChild(iter_358_2)

					if var_358_20.name == "" or not string.find(var_358_20.name, "split") then
						var_358_20.gameObject:SetActive(true)
					else
						var_358_20.gameObject:SetActive(false)
					end
				end
			end

			local var_358_21 = 0.001

			if 1.93266666666667 <= arg_355_1.time_ and arg_355_1.time_ < 1.93266666666667 + var_358_21 then
				var_358_19.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_355_1.time_ - 1.93266666666667) / var_358_21)
			end

			if arg_355_1.time_ >= 1.93266666666667 + var_358_21 and arg_355_1.time_ < 1.93266666666667 + var_358_21 + arg_358_0 then
				var_358_19.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.96666666666667 < arg_355_1.time_ and arg_355_1.time_ <= 1.96666666666667 + arg_358_0 then
				local var_358_22 = arg_355_1.fswbg_.transform:Find("textbox/adapt/content") or arg_355_1.fswbg_.transform:Find("textbox/content")
				local var_358_23 = arg_355_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_358_24 = var_358_22:GetComponent("RectTransform")

				var_358_22:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_358_24.offsetMin = Vector2.New(0, 0)
				var_358_24.offsetMax = Vector2.New(0, 0)
			end

			if 3.33333333333333 < arg_355_1.time_ and arg_355_1.time_ <= 3.33333333333333 + arg_358_0 then
				arg_355_1:AudioAction("play", "music", "story_v_out_417221", "417221084", "story_v_out_417221.awb")

				local var_358_27 = manager.audio:GetAudioName("story_v_out_417221", "417221084")

				if "" ~= "" then
					if arg_355_1.bgmTxt_.text ~= var_358_27 and arg_355_1.bgmTxt_.text ~= "" then
						if arg_355_1.bgmTxt2_.text ~= "" then
							arg_355_1.bgmTxt_.text = arg_355_1.bgmTxt2_.text
						end

						arg_355_1.bgmTxt2_.text = var_358_27

						arg_355_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_355_1.bgmTxt_.text = var_358_27
						arg_355_1.bgmTxt2_.text = var_358_27
					end

					if arg_355_1.bgmTimer then
						arg_355_1.bgmTimer:Stop()

						arg_355_1.bgmTimer = nil
					end

					if arg_355_1.settingData.show_music_name == 1 then
						arg_355_1.musicController:SetSelectedState("show")
						arg_355_1.musicAnimator_:Play("open", 0, 0)

						if arg_355_1.settingData.music_time ~= 0 then
							arg_355_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_355_1.settingData.music_time), function()
								if arg_355_1 == nil or isNil(arg_355_1.bgmTxt_) then
									return
								end

								arg_355_1.musicController:SetSelectedState("hide")
								arg_355_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.93266666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play417221085 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 417221085
		arg_360_1.duration_ = 10.17

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play417221086(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.fswbg_:SetActive(true)
				arg_360_1.dialog_:SetActive(false)

				arg_360_1.fswtw_.percent = 0
				arg_360_1.fswt_.text = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(417221085).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.fswt_)

				arg_360_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_360_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_360_1.fswtw_:SetDirty()

				arg_360_1.typewritterCharCountI18N = 0

				SetActive(arg_360_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_360_1:ShowNextGo(false)
			end

			local var_363_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.var_.oldValueTypewriter = arg_360_1.fswtw_.percent

				SetActive(arg_360_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_360_1:ShowNextGo(false)
			end

			local var_363_1 = 45
			local var_363_2 = 3
			local var_363_3, var_363_4 = arg_360_1:GetPercentByPara(arg_360_1:FormatText(arg_360_1:GetWordFromCfg(417221085).content), 1)

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0

				local var_363_5 = var_363_1 <= 0 and var_363_2 or var_363_2 * ((var_363_4 - arg_360_1.typewritterCharCountI18N) / var_363_1)

				if (var_363_1 <= 0 and var_363_2 or var_363_2 * ((var_363_4 - arg_360_1.typewritterCharCountI18N) / var_363_1)) > 0 and var_363_2 < var_363_5 then
					arg_360_1.talkMaxDuration = var_363_5

					if var_363_5 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + var_363_0
					end
				end
			end

			local var_363_6 = math.max(3, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_6 then
				arg_360_1.fswtw_.percent = Mathf.Lerp(arg_360_1.var_.oldValueTypewriter, var_363_3, (arg_360_1.time_ - var_363_0) / var_363_6)
				arg_360_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_360_1.fswtw_:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_6 and arg_360_1.time_ < var_363_0 + var_363_6 + arg_363_0 then
				arg_360_1.fswtw_.percent = var_363_3

				arg_360_1.fswtw_:SetDirty()
				arg_360_1:ShowNextGo(true)

				arg_360_1.typewritterCharCountI18N = var_363_4
			end

			if 0.0999999999999999 < arg_360_1.time_ and arg_360_1.time_ <= 0.0999999999999999 + arg_363_0 then
				arg_360_1:AudioAction("play", "music", "story_v_out_417221", "417221085", "story_v_out_417221.awb")

				local var_363_9 = manager.audio:GetAudioName("story_v_out_417221", "417221085")

				if "" ~= "" then
					if arg_360_1.bgmTxt_.text ~= var_363_9 and arg_360_1.bgmTxt_.text ~= "" then
						if arg_360_1.bgmTxt2_.text ~= "" then
							arg_360_1.bgmTxt_.text = arg_360_1.bgmTxt2_.text
						end

						arg_360_1.bgmTxt2_.text = var_363_9

						arg_360_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_360_1.bgmTxt_.text = var_363_9
						arg_360_1.bgmTxt2_.text = var_363_9
					end

					if arg_360_1.bgmTimer then
						arg_360_1.bgmTimer:Stop()

						arg_360_1.bgmTimer = nil
					end

					if arg_360_1.settingData.show_music_name == 1 then
						arg_360_1.musicController:SetSelectedState("show")
						arg_360_1.musicAnimator_:Play("open", 0, 0)

						if arg_360_1.settingData.music_time ~= 0 then
							arg_360_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_360_1.settingData.music_time), function()
								if arg_360_1 == nil or isNil(arg_360_1.bgmTxt_) then
									return
								end

								arg_360_1.musicController:SetSelectedState("hide")
								arg_360_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play417221086 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 417221086
		arg_365_1.duration_ = 12.13

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play417221087(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.fswbg_:SetActive(true)
				arg_365_1.dialog_:SetActive(false)

				arg_365_1.fswtw_.percent = 0
				arg_365_1.fswt_.text = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(417221086).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.fswt_)

				arg_365_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_365_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_365_1.fswtw_:SetDirty()

				arg_365_1.typewritterCharCountI18N = 0

				SetActive(arg_365_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_365_1:ShowNextGo(false)
			end

			local var_368_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.var_.oldValueTypewriter = arg_365_1.fswtw_.percent

				SetActive(arg_365_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_365_1:ShowNextGo(false)
			end

			local var_368_1 = 50
			local var_368_2 = 2.33333333333333
			local var_368_3, var_368_4 = arg_365_1:GetPercentByPara(arg_365_1:FormatText(arg_365_1:GetWordFromCfg(417221086).content), 1)

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0

				local var_368_5 = var_368_1 <= 0 and var_368_2 or var_368_2 * ((var_368_4 - arg_365_1.typewritterCharCountI18N) / var_368_1)

				if (var_368_1 <= 0 and var_368_2 or var_368_2 * ((var_368_4 - arg_365_1.typewritterCharCountI18N) / var_368_1)) > 0 and var_368_2 < var_368_5 then
					arg_365_1.talkMaxDuration = var_368_5

					if var_368_5 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + var_368_0
					end
				end
			end

			local var_368_6 = math.max(2.33333333333333, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_6 then
				arg_365_1.fswtw_.percent = Mathf.Lerp(arg_365_1.var_.oldValueTypewriter, var_368_3, (arg_365_1.time_ - var_368_0) / var_368_6)
				arg_365_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_365_1.fswtw_:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_6 and arg_365_1.time_ < var_368_0 + var_368_6 + arg_368_0 then
				arg_365_1.fswtw_.percent = var_368_3

				arg_365_1.fswtw_:SetDirty()
				arg_365_1:ShowNextGo(true)

				arg_365_1.typewritterCharCountI18N = var_368_4
			end

			if 0.0999999999999999 < arg_365_1.time_ and arg_365_1.time_ <= 0.0999999999999999 + arg_368_0 then
				arg_365_1:AudioAction("play", "music", "story_v_out_417221", "417221086", "story_v_out_417221.awb")

				local var_368_9 = manager.audio:GetAudioName("story_v_out_417221", "417221086")

				if "" ~= "" then
					if arg_365_1.bgmTxt_.text ~= var_368_9 and arg_365_1.bgmTxt_.text ~= "" then
						if arg_365_1.bgmTxt2_.text ~= "" then
							arg_365_1.bgmTxt_.text = arg_365_1.bgmTxt2_.text
						end

						arg_365_1.bgmTxt2_.text = var_368_9

						arg_365_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_365_1.bgmTxt_.text = var_368_9
						arg_365_1.bgmTxt2_.text = var_368_9
					end

					if arg_365_1.bgmTimer then
						arg_365_1.bgmTimer:Stop()

						arg_365_1.bgmTimer = nil
					end

					if arg_365_1.settingData.show_music_name == 1 then
						arg_365_1.musicController:SetSelectedState("show")
						arg_365_1.musicAnimator_:Play("open", 0, 0)

						if arg_365_1.settingData.music_time ~= 0 then
							arg_365_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_365_1.settingData.music_time), function()
								if arg_365_1 == nil or isNil(arg_365_1.bgmTxt_) then
									return
								end

								arg_365_1.musicController:SetSelectedState("hide")
								arg_365_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play417221087 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 417221087
		arg_370_1.duration_ = 7.87

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play417221088(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.fswbg_:SetActive(true)
				arg_370_1.dialog_:SetActive(false)

				arg_370_1.fswtw_.percent = 0
				arg_370_1.fswt_.text = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(417221087).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.fswt_)

				arg_370_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_370_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_370_1.fswtw_:SetDirty()

				arg_370_1.typewritterCharCountI18N = 0

				SetActive(arg_370_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_370_1:ShowNextGo(false)
			end

			local var_373_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.var_.oldValueTypewriter = arg_370_1.fswtw_.percent

				SetActive(arg_370_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_370_1:ShowNextGo(false)
			end

			local var_373_1 = 34
			local var_373_2 = 2.26666666666667
			local var_373_3, var_373_4 = arg_370_1:GetPercentByPara(arg_370_1:FormatText(arg_370_1:GetWordFromCfg(417221087).content), 1)

			if var_373_0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0

				local var_373_5 = var_373_1 <= 0 and var_373_2 or var_373_2 * ((var_373_4 - arg_370_1.typewritterCharCountI18N) / var_373_1)

				if (var_373_1 <= 0 and var_373_2 or var_373_2 * ((var_373_4 - arg_370_1.typewritterCharCountI18N) / var_373_1)) > 0 and var_373_2 < var_373_5 then
					arg_370_1.talkMaxDuration = var_373_5

					if var_373_5 + var_373_0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + var_373_0
					end
				end
			end

			local var_373_6 = math.max(2.26666666666667, arg_370_1.talkMaxDuration)

			if var_373_0 <= arg_370_1.time_ and arg_370_1.time_ < var_373_0 + var_373_6 then
				arg_370_1.fswtw_.percent = Mathf.Lerp(arg_370_1.var_.oldValueTypewriter, var_373_3, (arg_370_1.time_ - var_373_0) / var_373_6)
				arg_370_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_370_1.fswtw_:SetDirty()
			end

			if arg_370_1.time_ >= var_373_0 + var_373_6 and arg_370_1.time_ < var_373_0 + var_373_6 + arg_373_0 then
				arg_370_1.fswtw_.percent = var_373_3

				arg_370_1.fswtw_:SetDirty()
				arg_370_1:ShowNextGo(true)

				arg_370_1.typewritterCharCountI18N = var_373_4
			end

			if 0.1 < arg_370_1.time_ and arg_370_1.time_ <= 0.1 + arg_373_0 then
				arg_370_1:AudioAction("play", "music", "story_v_out_417221", "417221087", "story_v_out_417221.awb")

				local var_373_9 = manager.audio:GetAudioName("story_v_out_417221", "417221087")

				if "" ~= "" then
					if arg_370_1.bgmTxt_.text ~= var_373_9 and arg_370_1.bgmTxt_.text ~= "" then
						if arg_370_1.bgmTxt2_.text ~= "" then
							arg_370_1.bgmTxt_.text = arg_370_1.bgmTxt2_.text
						end

						arg_370_1.bgmTxt2_.text = var_373_9

						arg_370_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_370_1.bgmTxt_.text = var_373_9
						arg_370_1.bgmTxt2_.text = var_373_9
					end

					if arg_370_1.bgmTimer then
						arg_370_1.bgmTimer:Stop()

						arg_370_1.bgmTimer = nil
					end

					if arg_370_1.settingData.show_music_name == 1 then
						arg_370_1.musicController:SetSelectedState("show")
						arg_370_1.musicAnimator_:Play("open", 0, 0)

						if arg_370_1.settingData.music_time ~= 0 then
							arg_370_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_370_1.settingData.music_time), function()
								if arg_370_1 == nil or isNil(arg_370_1.bgmTxt_) then
									return
								end

								arg_370_1.musicController:SetSelectedState("hide")
								arg_370_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play417221088 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 417221088
		arg_375_1.duration_ = 13.17

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play417221089(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.fswbg_:SetActive(true)
				arg_375_1.dialog_:SetActive(false)

				arg_375_1.fswtw_.percent = 0
				arg_375_1.fswt_.text = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(417221088).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.fswt_)

				arg_375_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_375_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_375_1.fswtw_:SetDirty()

				arg_375_1.typewritterCharCountI18N = 0

				SetActive(arg_375_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_375_1:ShowNextGo(false)
			end

			local var_378_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.var_.oldValueTypewriter = arg_375_1.fswtw_.percent

				SetActive(arg_375_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_375_1:ShowNextGo(false)
			end

			local var_378_1 = 59
			local var_378_2 = 3.93333333333333
			local var_378_3, var_378_4 = arg_375_1:GetPercentByPara(arg_375_1:FormatText(arg_375_1:GetWordFromCfg(417221088).content), 1)

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0

				local var_378_5 = var_378_1 <= 0 and var_378_2 or var_378_2 * ((var_378_4 - arg_375_1.typewritterCharCountI18N) / var_378_1)

				if (var_378_1 <= 0 and var_378_2 or var_378_2 * ((var_378_4 - arg_375_1.typewritterCharCountI18N) / var_378_1)) > 0 and var_378_2 < var_378_5 then
					arg_375_1.talkMaxDuration = var_378_5

					if var_378_5 + var_378_0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + var_378_0
					end
				end
			end

			local var_378_6 = math.max(3.93333333333333, arg_375_1.talkMaxDuration)

			if var_378_0 <= arg_375_1.time_ and arg_375_1.time_ < var_378_0 + var_378_6 then
				arg_375_1.fswtw_.percent = Mathf.Lerp(arg_375_1.var_.oldValueTypewriter, var_378_3, (arg_375_1.time_ - var_378_0) / var_378_6)
				arg_375_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_375_1.fswtw_:SetDirty()
			end

			if arg_375_1.time_ >= var_378_0 + var_378_6 and arg_375_1.time_ < var_378_0 + var_378_6 + arg_378_0 then
				arg_375_1.fswtw_.percent = var_378_3

				arg_375_1.fswtw_:SetDirty()
				arg_375_1:ShowNextGo(true)

				arg_375_1.typewritterCharCountI18N = var_378_4
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.cswbg_:SetActive(false)
			end

			if 1 < arg_375_1.time_ and arg_375_1.time_ <= 1 + arg_378_0 then
				arg_375_1.cswbg_:SetActive(true)

				local var_378_7 = arg_375_1.cswt_:GetComponent("RectTransform")

				arg_375_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_378_7.offsetMin = Vector2.New(0, 0)
				var_378_7.offsetMax = Vector2.New(0, 0)
				arg_375_1.cswt_.text = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(419115).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.cswt_)

				arg_375_1.cswt_.fontSize = 120
				arg_375_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_375_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_375_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0.1 < arg_375_1.time_ and arg_375_1.time_ <= 0.1 + arg_378_0 then
				arg_375_1:AudioAction("play", "music", "story_v_out_417221", "417221088", "story_v_out_417221.awb")

				local var_378_10 = manager.audio:GetAudioName("story_v_out_417221", "417221088")

				if "" ~= "" then
					if arg_375_1.bgmTxt_.text ~= var_378_10 and arg_375_1.bgmTxt_.text ~= "" then
						if arg_375_1.bgmTxt2_.text ~= "" then
							arg_375_1.bgmTxt_.text = arg_375_1.bgmTxt2_.text
						end

						arg_375_1.bgmTxt2_.text = var_378_10

						arg_375_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_375_1.bgmTxt_.text = var_378_10
						arg_375_1.bgmTxt2_.text = var_378_10
					end

					if arg_375_1.bgmTimer then
						arg_375_1.bgmTimer:Stop()

						arg_375_1.bgmTimer = nil
					end

					if arg_375_1.settingData.show_music_name == 1 then
						arg_375_1.musicController:SetSelectedState("show")
						arg_375_1.musicAnimator_:Play("open", 0, 0)

						if arg_375_1.settingData.music_time ~= 0 then
							arg_375_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_375_1.settingData.music_time), function()
								if arg_375_1 == nil or isNil(arg_375_1.bgmTxt_) then
									return
								end

								arg_375_1.musicController:SetSelectedState("hide")
								arg_375_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play417221089 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 417221089
		arg_380_1.duration_ = 13.03

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play417221090(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.fswbg_:SetActive(true)
				arg_380_1.dialog_:SetActive(false)

				arg_380_1.fswtw_.percent = 0
				arg_380_1.fswt_.text = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(417221089).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.fswt_)

				arg_380_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_380_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_380_1.fswtw_:SetDirty()

				arg_380_1.typewritterCharCountI18N = 0

				SetActive(arg_380_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_380_1:ShowNextGo(false)
			end

			local var_383_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.var_.oldValueTypewriter = arg_380_1.fswtw_.percent

				SetActive(arg_380_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_380_1:ShowNextGo(false)
			end

			local var_383_1 = 54
			local var_383_2 = 3.6
			local var_383_3, var_383_4 = arg_380_1:GetPercentByPara(arg_380_1:FormatText(arg_380_1:GetWordFromCfg(417221089).content), 1)

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0

				local var_383_5 = var_383_1 <= 0 and var_383_2 or var_383_2 * ((var_383_4 - arg_380_1.typewritterCharCountI18N) / var_383_1)

				if (var_383_1 <= 0 and var_383_2 or var_383_2 * ((var_383_4 - arg_380_1.typewritterCharCountI18N) / var_383_1)) > 0 and var_383_2 < var_383_5 then
					arg_380_1.talkMaxDuration = var_383_5

					if var_383_5 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + var_383_0
					end
				end
			end

			local var_383_6 = math.max(3.6, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_6 then
				arg_380_1.fswtw_.percent = Mathf.Lerp(arg_380_1.var_.oldValueTypewriter, var_383_3, (arg_380_1.time_ - var_383_0) / var_383_6)
				arg_380_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_380_1.fswtw_:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_6 and arg_380_1.time_ < var_383_0 + var_383_6 + arg_383_0 then
				arg_380_1.fswtw_.percent = var_383_3

				arg_380_1.fswtw_:SetDirty()
				arg_380_1:ShowNextGo(true)

				arg_380_1.typewritterCharCountI18N = var_383_4
			end

			if 0.0999999999999999 < arg_380_1.time_ and arg_380_1.time_ <= 0.0999999999999999 + arg_383_0 then
				arg_380_1:AudioAction("play", "music", "story_v_out_417221", "417221089", "story_v_out_417221.awb")

				local var_383_9 = manager.audio:GetAudioName("story_v_out_417221", "417221089")

				if "" ~= "" then
					if arg_380_1.bgmTxt_.text ~= var_383_9 and arg_380_1.bgmTxt_.text ~= "" then
						if arg_380_1.bgmTxt2_.text ~= "" then
							arg_380_1.bgmTxt_.text = arg_380_1.bgmTxt2_.text
						end

						arg_380_1.bgmTxt2_.text = var_383_9

						arg_380_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_380_1.bgmTxt_.text = var_383_9
						arg_380_1.bgmTxt2_.text = var_383_9
					end

					if arg_380_1.bgmTimer then
						arg_380_1.bgmTimer:Stop()

						arg_380_1.bgmTimer = nil
					end

					if arg_380_1.settingData.show_music_name == 1 then
						arg_380_1.musicController:SetSelectedState("show")
						arg_380_1.musicAnimator_:Play("open", 0, 0)

						if arg_380_1.settingData.music_time ~= 0 then
							arg_380_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_380_1.settingData.music_time), function()
								if arg_380_1 == nil or isNil(arg_380_1.bgmTxt_) then
									return
								end

								arg_380_1.musicController:SetSelectedState("hide")
								arg_380_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play417221090 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 417221090
		arg_385_1.duration_ = 11.6

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play417221091(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.fswbg_:SetActive(true)
				arg_385_1.dialog_:SetActive(false)

				arg_385_1.fswtw_.percent = 0
				arg_385_1.fswt_.text = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(417221090).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.fswt_)

				arg_385_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_385_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_385_1.fswtw_:SetDirty()

				arg_385_1.typewritterCharCountI18N = 0

				SetActive(arg_385_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_385_1:ShowNextGo(false)
			end

			local var_388_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.var_.oldValueTypewriter = arg_385_1.fswtw_.percent

				SetActive(arg_385_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_385_1:ShowNextGo(false)
			end

			local var_388_1 = 54
			local var_388_2 = 2.33333333333333
			local var_388_3, var_388_4 = arg_385_1:GetPercentByPara(arg_385_1:FormatText(arg_385_1:GetWordFromCfg(417221090).content), 1)

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0

				local var_388_5 = var_388_1 <= 0 and var_388_2 or var_388_2 * ((var_388_4 - arg_385_1.typewritterCharCountI18N) / var_388_1)

				if (var_388_1 <= 0 and var_388_2 or var_388_2 * ((var_388_4 - arg_385_1.typewritterCharCountI18N) / var_388_1)) > 0 and var_388_2 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_0
					end
				end
			end

			local var_388_6 = math.max(2.33333333333333, arg_385_1.talkMaxDuration)

			if var_388_0 <= arg_385_1.time_ and arg_385_1.time_ < var_388_0 + var_388_6 then
				arg_385_1.fswtw_.percent = Mathf.Lerp(arg_385_1.var_.oldValueTypewriter, var_388_3, (arg_385_1.time_ - var_388_0) / var_388_6)
				arg_385_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_385_1.fswtw_:SetDirty()
			end

			if arg_385_1.time_ >= var_388_0 + var_388_6 and arg_385_1.time_ < var_388_0 + var_388_6 + arg_388_0 then
				arg_385_1.fswtw_.percent = var_388_3

				arg_385_1.fswtw_:SetDirty()
				arg_385_1:ShowNextGo(true)

				arg_385_1.typewritterCharCountI18N = var_388_4
			end

			if 0.0999999999999999 < arg_385_1.time_ and arg_385_1.time_ <= 0.0999999999999999 + arg_388_0 then
				arg_385_1:AudioAction("play", "music", "story_v_out_417221", "417221090", "story_v_out_417221.awb")

				local var_388_9 = manager.audio:GetAudioName("story_v_out_417221", "417221090")

				if "" ~= "" then
					if arg_385_1.bgmTxt_.text ~= var_388_9 and arg_385_1.bgmTxt_.text ~= "" then
						if arg_385_1.bgmTxt2_.text ~= "" then
							arg_385_1.bgmTxt_.text = arg_385_1.bgmTxt2_.text
						end

						arg_385_1.bgmTxt2_.text = var_388_9

						arg_385_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_385_1.bgmTxt_.text = var_388_9
						arg_385_1.bgmTxt2_.text = var_388_9
					end

					if arg_385_1.bgmTimer then
						arg_385_1.bgmTimer:Stop()

						arg_385_1.bgmTimer = nil
					end

					if arg_385_1.settingData.show_music_name == 1 then
						arg_385_1.musicController:SetSelectedState("show")
						arg_385_1.musicAnimator_:Play("open", 0, 0)

						if arg_385_1.settingData.music_time ~= 0 then
							arg_385_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_385_1.settingData.music_time), function()
								if arg_385_1 == nil or isNil(arg_385_1.bgmTxt_) then
									return
								end

								arg_385_1.musicController:SetSelectedState("hide")
								arg_385_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play417221091 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 417221091
		arg_390_1.duration_ = 12.47

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play417221092(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.fswbg_:SetActive(true)
				arg_390_1.dialog_:SetActive(false)

				arg_390_1.fswtw_.percent = 0
				arg_390_1.fswt_.text = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(417221091).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.fswt_)

				arg_390_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_390_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_390_1.fswtw_:SetDirty()

				arg_390_1.typewritterCharCountI18N = 0

				SetActive(arg_390_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_390_1:ShowNextGo(false)
			end

			local var_393_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.var_.oldValueTypewriter = arg_390_1.fswtw_.percent

				SetActive(arg_390_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_390_1:ShowNextGo(false)
			end

			local var_393_1 = 47
			local var_393_2 = 3.13333333333333
			local var_393_3, var_393_4 = arg_390_1:GetPercentByPara(arg_390_1:FormatText(arg_390_1:GetWordFromCfg(417221091).content), 1)

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0

				local var_393_5 = var_393_1 <= 0 and var_393_2 or var_393_2 * ((var_393_4 - arg_390_1.typewritterCharCountI18N) / var_393_1)

				if (var_393_1 <= 0 and var_393_2 or var_393_2 * ((var_393_4 - arg_390_1.typewritterCharCountI18N) / var_393_1)) > 0 and var_393_2 < var_393_5 then
					arg_390_1.talkMaxDuration = var_393_5

					if var_393_5 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + var_393_0
					end
				end
			end

			local var_393_6 = math.max(3.13333333333333, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_6 then
				arg_390_1.fswtw_.percent = Mathf.Lerp(arg_390_1.var_.oldValueTypewriter, var_393_3, (arg_390_1.time_ - var_393_0) / var_393_6)
				arg_390_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_390_1.fswtw_:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_6 and arg_390_1.time_ < var_393_0 + var_393_6 + arg_393_0 then
				arg_390_1.fswtw_.percent = var_393_3

				arg_390_1.fswtw_:SetDirty()
				arg_390_1:ShowNextGo(true)

				arg_390_1.typewritterCharCountI18N = var_393_4
			end

			if 0.0999999999999999 < arg_390_1.time_ and arg_390_1.time_ <= 0.0999999999999999 + arg_393_0 then
				arg_390_1:AudioAction("play", "music", "story_v_out_417221", "417221091", "story_v_out_417221.awb")

				local var_393_9 = manager.audio:GetAudioName("story_v_out_417221", "417221091")

				if "" ~= "" then
					if arg_390_1.bgmTxt_.text ~= var_393_9 and arg_390_1.bgmTxt_.text ~= "" then
						if arg_390_1.bgmTxt2_.text ~= "" then
							arg_390_1.bgmTxt_.text = arg_390_1.bgmTxt2_.text
						end

						arg_390_1.bgmTxt2_.text = var_393_9

						arg_390_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_390_1.bgmTxt_.text = var_393_9
						arg_390_1.bgmTxt2_.text = var_393_9
					end

					if arg_390_1.bgmTimer then
						arg_390_1.bgmTimer:Stop()

						arg_390_1.bgmTimer = nil
					end

					if arg_390_1.settingData.show_music_name == 1 then
						arg_390_1.musicController:SetSelectedState("show")
						arg_390_1.musicAnimator_:Play("open", 0, 0)

						if arg_390_1.settingData.music_time ~= 0 then
							arg_390_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_390_1.settingData.music_time), function()
								if arg_390_1 == nil or isNil(arg_390_1.bgmTxt_) then
									return
								end

								arg_390_1.musicController:SetSelectedState("hide")
								arg_390_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play417221092 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 417221092
		arg_395_1.duration_ = 17.03

		local var_395_0 = {
			zh = 13.366,
			ja = 17.033
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play417221093(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 2 < arg_395_1.time_ and arg_395_1.time_ <= 2 + arg_398_0 then
				local var_398_0 = arg_395_1.bgs_.I16f

				arg_395_1.bgs_.I16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_398_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_398_1 = var_398_0:GetComponent("SpriteRenderer")

				if var_398_1 and var_398_1.sprite then
					local var_398_2 = 2 * (var_398_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_398_0.transform.localScale = Vector3.New(var_398_2 / var_398_1.sprite.bounds.size.y < var_398_2 * manager.ui.mainCameraCom_.aspect / var_398_1.sprite.bounds.size.x and var_398_2 * manager.ui.mainCameraCom_.aspect / var_398_1.sprite.bounds.size.x or var_398_2 / var_398_1.sprite.bounds.size.y, var_398_2 / var_398_1.sprite.bounds.size.y < var_398_2 * manager.ui.mainCameraCom_.aspect / var_398_1.sprite.bounds.size.x and var_398_2 * manager.ui.mainCameraCom_.aspect / var_398_1.sprite.bounds.size.x or var_398_2 / var_398_1.sprite.bounds.size.y, 0)
				end

				for iter_398_0, iter_398_1 in pairs(arg_395_1.bgs_) do
					if iter_398_0 ~= "I16f" then
						iter_398_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_398_3 = 4

			if 4 < arg_395_1.time_ and arg_395_1.time_ <= var_398_3 + arg_398_0 then
				arg_395_1.allBtn_.enabled = false
			end

			if arg_395_1.time_ >= var_398_3 + 0.3 and arg_395_1.time_ < var_398_3 + 0.3 + arg_398_0 then
				arg_395_1.allBtn_.enabled = true
			end

			local var_398_4 = 0

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1.mask_.enabled = true
				arg_395_1.mask_.raycastTarget = true

				arg_395_1:SetGaussion(false)
			end

			local var_398_5 = 2

			if var_398_4 <= arg_395_1.time_ and arg_395_1.time_ < var_398_4 + var_398_5 then
				local var_398_6 = Color.New(0, 0, 0)

				var_398_6.a = Mathf.Lerp(0, 1, (arg_395_1.time_ - var_398_4) / var_398_5)
				arg_395_1.mask_.color = var_398_6
			end

			if arg_395_1.time_ >= var_398_4 + var_398_5 and arg_395_1.time_ < var_398_4 + var_398_5 + arg_398_0 then
				local var_398_7 = Color.New(0, 0, 0)

				var_398_7.a = 1
				arg_395_1.mask_.color = var_398_7
			end

			local var_398_8 = 2

			if 2 < arg_395_1.time_ and arg_395_1.time_ <= var_398_8 + arg_398_0 then
				arg_395_1.mask_.enabled = true
				arg_395_1.mask_.raycastTarget = true

				arg_395_1:SetGaussion(false)
			end

			local var_398_9 = 2

			if var_398_8 <= arg_395_1.time_ and arg_395_1.time_ < var_398_8 + var_398_9 then
				local var_398_10 = Color.New(0, 0, 0)

				var_398_10.a = Mathf.Lerp(1, 0, (arg_395_1.time_ - var_398_8) / var_398_9)
				arg_395_1.mask_.color = var_398_10
			end

			if arg_395_1.time_ >= var_398_8 + var_398_9 and arg_395_1.time_ < var_398_8 + var_398_9 + arg_398_0 then
				local var_398_11 = Color.New(0, 0, 0)

				arg_395_1.mask_.enabled = false
				var_398_11.a = 0
				arg_395_1.mask_.color = var_398_11
			end

			local var_398_12 = arg_395_1.actors_["10113"].transform

			if 1.96666666666667 < arg_395_1.time_ and arg_395_1.time_ <= 1.96666666666667 + arg_398_0 then
				arg_395_1.var_.moveOldPos10113 = var_398_12.localPosition
				var_398_12.localScale = Vector3.New(1, 1, 1)

				arg_395_1:CheckSpriteTmpPos("10113", 7)

				for iter_398_2 = 0, var_398_12.childCount - 1 do
					local var_398_13 = var_398_12:GetChild(iter_398_2)

					if var_398_13.name == "" or not string.find(var_398_13.name, "split") then
						var_398_13.gameObject:SetActive(true)
					else
						var_398_13.gameObject:SetActive(false)
					end
				end
			end

			local var_398_14 = 0.001

			if 1.96666666666667 <= arg_395_1.time_ and arg_395_1.time_ < 1.96666666666667 + var_398_14 then
				var_398_12.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_395_1.time_ - 1.96666666666667) / var_398_14)
			end

			if arg_395_1.time_ >= 1.96666666666667 + var_398_14 and arg_395_1.time_ < 1.96666666666667 + var_398_14 + arg_398_0 then
				var_398_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_398_15 = arg_395_1.actors_["10113"].transform

			if 3.76666666666667 < arg_395_1.time_ and arg_395_1.time_ <= 3.76666666666667 + arg_398_0 then
				arg_395_1.var_.moveOldPos10113 = var_398_15.localPosition
				var_398_15.localScale = Vector3.New(1, 1, 1)

				arg_395_1:CheckSpriteTmpPos("10113", 3)

				for iter_398_3 = 0, var_398_15.childCount - 1 do
					local var_398_16 = var_398_15:GetChild(iter_398_3)

					if var_398_16.name == "split_3" or not string.find(var_398_16.name, "split") then
						var_398_16.gameObject:SetActive(true)
					else
						var_398_16.gameObject:SetActive(false)
					end
				end
			end

			local var_398_17 = 0.001

			if 3.76666666666667 <= arg_395_1.time_ and arg_395_1.time_ < 3.76666666666667 + var_398_17 then
				var_398_15.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_395_1.time_ - 3.76666666666667) / var_398_17)
			end

			if arg_395_1.time_ >= 3.76666666666667 + var_398_17 and arg_395_1.time_ < 3.76666666666667 + var_398_17 + arg_398_0 then
				var_398_15.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			if 3.76666666666667 < arg_395_1.time_ and arg_395_1.time_ <= 3.76666666666667 + arg_398_0 then
				local var_398_18 = arg_395_1.actors_["10113"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_398_18 then
					arg_395_1.var_.alphaOldValue10113 = var_398_18.alpha
					arg_395_1.var_.characterEffect10113 = var_398_18
				end

				arg_395_1.var_.alphaOldValue10113 = 0
			end

			local var_398_19 = 0.233333333333333

			if 3.76666666666667 <= arg_395_1.time_ and arg_395_1.time_ < 3.76666666666667 + var_398_19 then
				if arg_395_1.var_.characterEffect10113 then
					arg_395_1.var_.characterEffect10113.alpha = Mathf.Lerp(arg_395_1.var_.alphaOldValue10113, 1, (arg_395_1.time_ - 3.76666666666667) / var_398_19)
				end
			end

			if arg_395_1.time_ >= 3.76666666666667 + var_398_19 and arg_395_1.time_ < 3.76666666666667 + var_398_19 + arg_398_0 and arg_395_1.var_.characterEffect10113 then
				arg_395_1.var_.characterEffect10113.alpha = 1
			end

			local var_398_20 = arg_395_1.actors_["10113"]

			if 3.76666666666667 < arg_395_1.time_ and arg_395_1.time_ <= 3.76666666666667 + arg_398_0 and not isNil(var_398_20) and arg_395_1.var_.actorSpriteComps10113 == nil then
				arg_395_1.var_.actorSpriteComps10113 = var_398_20:GetComponentsInChildren(typeof(Image), true)
			end

			local var_398_21 = 0.2

			if 3.76666666666667 <= arg_395_1.time_ and arg_395_1.time_ < 3.76666666666667 + var_398_21 and not isNil(var_398_20) then
				if arg_395_1.var_.actorSpriteComps10113 then
					for iter_398_4, iter_398_5 in pairs(arg_395_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_398_5 then
							if arg_395_1.isInRecall_ then
								iter_398_5.color = Color.New(Mathf.Lerp(iter_398_5.color.r, arg_395_1.hightColor1.r, (arg_395_1.time_ - 3.76666666666667) / var_398_21), Mathf.Lerp(iter_398_5.color.g, arg_395_1.hightColor1.g, (arg_395_1.time_ - 3.76666666666667) / var_398_21), (Mathf.Lerp(iter_398_5.color.b, arg_395_1.hightColor1.b, (arg_395_1.time_ - 3.76666666666667) / var_398_21)))
							else
								local var_398_22 = Mathf.Lerp(iter_398_5.color.r, 1, (arg_395_1.time_ - 3.76666666666667) / var_398_21)

								iter_398_5.color = Color.New(var_398_22, var_398_22, var_398_22)
							end
						end
					end
				end
			end

			if arg_395_1.time_ >= 3.76666666666667 + var_398_21 and arg_395_1.time_ < 3.76666666666667 + var_398_21 + arg_398_0 and not isNil(var_398_20) and arg_395_1.var_.actorSpriteComps10113 then
				for iter_398_6, iter_398_7 in pairs(arg_395_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_398_7 then
						iter_398_7.color = arg_395_1.isInRecall_ and (arg_395_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_395_1.var_.actorSpriteComps10113 = nil
			end

			if 1.90066666666667 < arg_395_1.time_ and arg_395_1.time_ <= 1.90066666666667 + arg_398_0 then
				arg_395_1.cswbg_:SetActive(false)
			end

			if 1.90066666666667 < arg_395_1.time_ and arg_395_1.time_ <= 1.90066666666667 + arg_398_0 then
				arg_395_1.fswbg_:SetActive(false)
				arg_395_1.dialog_:SetActive(false)
				SetActive(arg_395_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_395_1:ShowNextGo(false)
			end

			if arg_395_1.frameCnt_ <= 1 then
				arg_395_1.dialog_:SetActive(false)
			end

			local var_398_23 = 4
			local var_398_24 = 0.625

			if 4 < arg_395_1.time_ and arg_395_1.time_ <= var_398_23 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0

				arg_395_1.dialog_:SetActive(true)

				arg_395_1.dialogCg_.alpha = 0

				local var_398_25 = LeanTween.value(arg_395_1.dialog_, 0, 1, 0.3)

				var_398_25:setOnUpdate(LuaHelper.FloatAction(function(arg_399_0)
					arg_395_1.dialogCg_.alpha = arg_399_0
				end))
				var_398_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_395_1.dialog_)
					var_398_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_395_1.duration_ = arg_395_1.duration_ + 0.3

				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_26 = arg_395_1:GetWordFromCfg(417221092)
				local var_398_27 = arg_395_1:FormatText(var_398_26.content)

				arg_395_1.text_.text = var_398_27

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_29 = 25 <= 0 and var_398_24 or var_398_24 * (utf8.len(var_398_27) / 25)

				if (25 <= 0 and var_398_24 or var_398_24 * (utf8.len(var_398_27) / 25)) > 0 and var_398_24 < var_398_29 then
					arg_395_1.talkMaxDuration = var_398_29
					var_398_23 = var_398_23 + 0.3

					if var_398_29 + var_398_23 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_29 + var_398_23
					end
				end

				arg_395_1.text_.text = var_398_27
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221092", "story_v_out_417221.awb") ~= 0 then
					local var_398_30 = manager.audio:GetVoiceLength("story_v_out_417221", "417221092", "story_v_out_417221.awb") / 1000

					if var_398_30 + var_398_23 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_30 + var_398_23
					end

					if var_398_26.prefab_name ~= "" and arg_395_1.actors_[var_398_26.prefab_name] ~= nil then
						local var_398_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_26.prefab_name].transform, "story_v_out_417221", "417221092", "story_v_out_417221.awb")

						arg_395_1:RecordAudio("417221092", var_398_31)
						arg_395_1:RecordAudio("417221092", var_398_31)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_417221", "417221092", "story_v_out_417221.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_417221", "417221092", "story_v_out_417221.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_32 = var_398_23 + 0.3
			local var_398_33 = math.max(var_398_24, arg_395_1.talkMaxDuration)

			if var_398_23 + 0.3 <= arg_395_1.time_ and arg_395_1.time_ < var_398_32 + var_398_33 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_32) / var_398_33

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_32 + var_398_33 and arg_395_1.time_ < var_398_32 + var_398_33 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play417221093 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 417221093
		arg_401_1.duration_ = 7.27

		local var_401_0 = {
			zh = 6.066,
			ja = 7.266
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play417221094(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["10113"]) and arg_401_1.var_.actorSpriteComps10113 == nil then
				arg_401_1.var_.actorSpriteComps10113 = arg_401_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_0 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["10113"]) then
				if arg_401_1.var_.actorSpriteComps10113 then
					for iter_404_0, iter_404_1 in pairs(arg_401_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_404_1 then
							if arg_401_1.isInRecall_ then
								iter_404_1.color = Color.New(Mathf.Lerp(iter_404_1.color.r, arg_401_1.hightColor2.r, (arg_401_1.time_ - 0) / var_404_0), Mathf.Lerp(iter_404_1.color.g, arg_401_1.hightColor2.g, (arg_401_1.time_ - 0) / var_404_0), (Mathf.Lerp(iter_404_1.color.b, arg_401_1.hightColor2.b, (arg_401_1.time_ - 0) / var_404_0)))
							else
								local var_404_1 = Mathf.Lerp(iter_404_1.color.r, 0.5, (arg_401_1.time_ - 0) / var_404_0)

								iter_404_1.color = Color.New(var_404_1, var_404_1, var_404_1)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["10113"]) and arg_401_1.var_.actorSpriteComps10113 then
				for iter_404_2, iter_404_3 in pairs(arg_401_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_404_3 then
						iter_404_3.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_401_1.var_.actorSpriteComps10113 = nil
			end

			local var_404_2 = 0
			local var_404_3 = 0.775

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_2 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[1150].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_4 = arg_401_1:GetWordFromCfg(417221093)
				local var_404_5 = arg_401_1:FormatText(var_404_4.content)

				arg_401_1.text_.text = var_404_5

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_7 = 31 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_5) / 31)

				if (31 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_5) / 31)) > 0 and var_404_3 < var_404_7 then
					arg_401_1.talkMaxDuration = var_404_7

					if var_404_7 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_7 + var_404_2
					end
				end

				arg_401_1.text_.text = var_404_5
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221093", "story_v_out_417221.awb") ~= 0 then
					local var_404_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221093", "story_v_out_417221.awb") / 1000

					if var_404_8 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_8 + var_404_2
					end

					if var_404_4.prefab_name ~= "" and arg_401_1.actors_[var_404_4.prefab_name] ~= nil then
						local var_404_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_4.prefab_name].transform, "story_v_out_417221", "417221093", "story_v_out_417221.awb")

						arg_401_1:RecordAudio("417221093", var_404_9)
						arg_401_1:RecordAudio("417221093", var_404_9)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_417221", "417221093", "story_v_out_417221.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_417221", "417221093", "story_v_out_417221.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_10 = math.max(var_404_3, arg_401_1.talkMaxDuration)

			if var_404_2 <= arg_401_1.time_ and arg_401_1.time_ < var_404_2 + var_404_10 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_2) / var_404_10

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_2 + var_404_10 and arg_401_1.time_ < var_404_2 + var_404_10 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play417221094 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 417221094
		arg_405_1.duration_ = 11.47

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play417221095(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 1 < arg_405_1.time_ and arg_405_1.time_ <= 1 + arg_408_0 then
				local var_408_0 = arg_405_1.bgs_.STblack

				arg_405_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_408_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_408_1 = var_408_0:GetComponent("SpriteRenderer")

				if var_408_1 and var_408_1.sprite then
					local var_408_2 = 2 * (var_408_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_408_0.transform.localScale = Vector3.New(var_408_2 / var_408_1.sprite.bounds.size.y < var_408_2 * manager.ui.mainCameraCom_.aspect / var_408_1.sprite.bounds.size.x and var_408_2 * manager.ui.mainCameraCom_.aspect / var_408_1.sprite.bounds.size.x or var_408_2 / var_408_1.sprite.bounds.size.y, var_408_2 / var_408_1.sprite.bounds.size.y < var_408_2 * manager.ui.mainCameraCom_.aspect / var_408_1.sprite.bounds.size.x and var_408_2 * manager.ui.mainCameraCom_.aspect / var_408_1.sprite.bounds.size.x or var_408_2 / var_408_1.sprite.bounds.size.y, 0)
				end

				for iter_408_0, iter_408_1 in pairs(arg_405_1.bgs_) do
					if iter_408_0 ~= "STblack" then
						iter_408_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_408_3 = 0

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_3 + arg_408_0 then
				arg_405_1.mask_.enabled = true
				arg_405_1.mask_.raycastTarget = true

				arg_405_1:SetGaussion(false)
			end

			local var_408_4 = 1

			if var_408_3 <= arg_405_1.time_ and arg_405_1.time_ < var_408_3 + var_408_4 then
				local var_408_5 = Color.New(0, 0, 0)

				var_408_5.a = Mathf.Lerp(0, 1, (arg_405_1.time_ - var_408_3) / var_408_4)
				arg_405_1.mask_.color = var_408_5
			end

			if arg_405_1.time_ >= var_408_3 + var_408_4 and arg_405_1.time_ < var_408_3 + var_408_4 + arg_408_0 then
				local var_408_6 = Color.New(0, 0, 0)

				var_408_6.a = 1
				arg_405_1.mask_.color = var_408_6
			end

			local var_408_7 = 1

			if 1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_7 + arg_408_0 then
				arg_405_1.mask_.enabled = true
				arg_405_1.mask_.raycastTarget = true

				arg_405_1:SetGaussion(false)
			end

			local var_408_8 = 0.966666666666667

			if var_408_7 <= arg_405_1.time_ and arg_405_1.time_ < var_408_7 + var_408_8 then
				local var_408_9 = Color.New(0, 0, 0)

				var_408_9.a = Mathf.Lerp(1, 0, (arg_405_1.time_ - var_408_7) / var_408_8)
				arg_405_1.mask_.color = var_408_9
			end

			if arg_405_1.time_ >= var_408_7 + var_408_8 and arg_405_1.time_ < var_408_7 + var_408_8 + arg_408_0 then
				local var_408_10 = Color.New(0, 0, 0)

				arg_405_1.mask_.enabled = false
				var_408_10.a = 0
				arg_405_1.mask_.color = var_408_10
			end

			if 1 < arg_405_1.time_ and arg_405_1.time_ <= 1 + arg_408_0 then
				arg_405_1.cswbg_:SetActive(true)

				local var_408_11 = arg_405_1.cswt_:GetComponent("RectTransform")

				arg_405_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_408_11.offsetMin = Vector2.New(0, 0)
				var_408_11.offsetMax = Vector2.New(0, 0)
				arg_405_1.cswt_.text = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(419116).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.cswt_)

				arg_405_1.cswt_.fontSize = 120
				arg_405_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_405_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_405_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_408_12 = arg_405_1.actors_["10113"].transform

			if 0.966 < arg_405_1.time_ and arg_405_1.time_ <= 0.966 + arg_408_0 then
				arg_405_1.var_.moveOldPos10113 = var_408_12.localPosition
				var_408_12.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("10113", 7)

				for iter_408_2 = 0, var_408_12.childCount - 1 do
					local var_408_13 = var_408_12:GetChild(iter_408_2)

					if var_408_13.name == "" or not string.find(var_408_13.name, "split") then
						var_408_13.gameObject:SetActive(true)
					else
						var_408_13.gameObject:SetActive(false)
					end
				end
			end

			local var_408_14 = 0.001

			if 0.966 <= arg_405_1.time_ and arg_405_1.time_ < 0.966 + var_408_14 then
				var_408_12.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_405_1.time_ - 0.966) / var_408_14)
			end

			if arg_405_1.time_ >= 0.966 + var_408_14 and arg_405_1.time_ < 0.966 + var_408_14 + arg_408_0 then
				var_408_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_405_1.time_ and arg_405_1.time_ <= 1 + arg_408_0 then
				arg_405_1.fswbg_:SetActive(true)
				arg_405_1.dialog_:SetActive(false)

				arg_405_1.fswtw_.percent = 0
				arg_405_1.fswt_.text = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(417221094).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.fswt_)

				arg_405_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_405_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_405_1.fswtw_:SetDirty()

				arg_405_1.typewritterCharCountI18N = 0

				SetActive(arg_405_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_405_1:ShowNextGo(false)
			end

			local var_408_15 = 1.96666666666667

			if 1.96666666666667 < arg_405_1.time_ and arg_405_1.time_ <= var_408_15 + arg_408_0 then
				arg_405_1.var_.oldValueTypewriter = arg_405_1.fswtw_.percent

				SetActive(arg_405_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_405_1:ShowNextGo(false)
			end

			local var_408_16 = 36
			local var_408_17 = 2.4
			local var_408_18, var_408_19 = arg_405_1:GetPercentByPara(arg_405_1:FormatText(arg_405_1:GetWordFromCfg(417221094).content), 1)

			if var_408_15 < arg_405_1.time_ and arg_405_1.time_ <= var_408_15 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0

				local var_408_20 = var_408_16 <= 0 and var_408_17 or var_408_17 * ((var_408_19 - arg_405_1.typewritterCharCountI18N) / var_408_16)

				if (var_408_16 <= 0 and var_408_17 or var_408_17 * ((var_408_19 - arg_405_1.typewritterCharCountI18N) / var_408_16)) > 0 and var_408_17 < var_408_20 then
					arg_405_1.talkMaxDuration = var_408_20

					if var_408_20 + var_408_15 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_20 + var_408_15
					end
				end
			end

			local var_408_21 = math.max(2.4, arg_405_1.talkMaxDuration)

			if var_408_15 <= arg_405_1.time_ and arg_405_1.time_ < var_408_15 + var_408_21 then
				arg_405_1.fswtw_.percent = Mathf.Lerp(arg_405_1.var_.oldValueTypewriter, var_408_18, (arg_405_1.time_ - var_408_15) / var_408_21)
				arg_405_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_405_1.fswtw_:SetDirty()
			end

			if arg_405_1.time_ >= var_408_15 + var_408_21 and arg_405_1.time_ < var_408_15 + var_408_21 + arg_408_0 then
				arg_405_1.fswtw_.percent = var_408_18

				arg_405_1.fswtw_:SetDirty()
				arg_405_1:ShowNextGo(true)

				arg_405_1.typewritterCharCountI18N = var_408_19
			end

			if 1.96666666666667 < arg_405_1.time_ and arg_405_1.time_ <= 1.96666666666667 + arg_408_0 then
				arg_405_1:AudioAction("play", "music", "story_v_out_417221", "417221094", "story_v_out_417221.awb")

				local var_408_24 = manager.audio:GetAudioName("story_v_out_417221", "417221094")

				if "" ~= "" then
					if arg_405_1.bgmTxt_.text ~= var_408_24 and arg_405_1.bgmTxt_.text ~= "" then
						if arg_405_1.bgmTxt2_.text ~= "" then
							arg_405_1.bgmTxt_.text = arg_405_1.bgmTxt2_.text
						end

						arg_405_1.bgmTxt2_.text = var_408_24

						arg_405_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_405_1.bgmTxt_.text = var_408_24
						arg_405_1.bgmTxt2_.text = var_408_24
					end

					if arg_405_1.bgmTimer then
						arg_405_1.bgmTimer:Stop()

						arg_405_1.bgmTimer = nil
					end

					if arg_405_1.settingData.show_music_name == 1 then
						arg_405_1.musicController:SetSelectedState("show")
						arg_405_1.musicAnimator_:Play("open", 0, 0)

						if arg_405_1.settingData.music_time ~= 0 then
							arg_405_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_405_1.settingData.music_time), function()
								if arg_405_1 == nil or isNil(arg_405_1.bgmTxt_) then
									return
								end

								arg_405_1.musicController:SetSelectedState("hide")
								arg_405_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play417221095 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 417221095
		arg_410_1.duration_ = 7.47

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play417221096(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.fswbg_:SetActive(true)
				arg_410_1.dialog_:SetActive(false)

				arg_410_1.fswtw_.percent = 0
				arg_410_1.fswt_.text = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(417221095).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.fswt_)

				arg_410_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_410_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_410_1.fswtw_:SetDirty()

				arg_410_1.typewritterCharCountI18N = 0

				SetActive(arg_410_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_410_1:ShowNextGo(false)
			end

			local var_413_0 = 0.0999999999999999

			if 0.0999999999999999 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.var_.oldValueTypewriter = arg_410_1.fswtw_.percent

				SetActive(arg_410_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_410_1:ShowNextGo(false)
			end

			local var_413_1 = 32
			local var_413_2 = 2.13333333333333
			local var_413_3, var_413_4 = arg_410_1:GetPercentByPara(arg_410_1:FormatText(arg_410_1:GetWordFromCfg(417221095).content), 1)

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0

				local var_413_5 = var_413_1 <= 0 and var_413_2 or var_413_2 * ((var_413_4 - arg_410_1.typewritterCharCountI18N) / var_413_1)

				if (var_413_1 <= 0 and var_413_2 or var_413_2 * ((var_413_4 - arg_410_1.typewritterCharCountI18N) / var_413_1)) > 0 and var_413_2 < var_413_5 then
					arg_410_1.talkMaxDuration = var_413_5

					if var_413_5 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + var_413_0
					end
				end
			end

			local var_413_6 = math.max(2.13333333333333, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_6 then
				arg_410_1.fswtw_.percent = Mathf.Lerp(arg_410_1.var_.oldValueTypewriter, var_413_3, (arg_410_1.time_ - var_413_0) / var_413_6)
				arg_410_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_410_1.fswtw_:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_6 and arg_410_1.time_ < var_413_0 + var_413_6 + arg_413_0 then
				arg_410_1.fswtw_.percent = var_413_3

				arg_410_1.fswtw_:SetDirty()
				arg_410_1:ShowNextGo(true)

				arg_410_1.typewritterCharCountI18N = var_413_4
			end

			if 0.0999999999999999 < arg_410_1.time_ and arg_410_1.time_ <= 0.0999999999999999 + arg_413_0 then
				arg_410_1:AudioAction("play", "music", "story_v_out_417221", "417221095", "story_v_out_417221.awb")

				local var_413_9 = manager.audio:GetAudioName("story_v_out_417221", "417221095")

				if "" ~= "" then
					if arg_410_1.bgmTxt_.text ~= var_413_9 and arg_410_1.bgmTxt_.text ~= "" then
						if arg_410_1.bgmTxt2_.text ~= "" then
							arg_410_1.bgmTxt_.text = arg_410_1.bgmTxt2_.text
						end

						arg_410_1.bgmTxt2_.text = var_413_9

						arg_410_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_410_1.bgmTxt_.text = var_413_9
						arg_410_1.bgmTxt2_.text = var_413_9
					end

					if arg_410_1.bgmTimer then
						arg_410_1.bgmTimer:Stop()

						arg_410_1.bgmTimer = nil
					end

					if arg_410_1.settingData.show_music_name == 1 then
						arg_410_1.musicController:SetSelectedState("show")
						arg_410_1.musicAnimator_:Play("open", 0, 0)

						if arg_410_1.settingData.music_time ~= 0 then
							arg_410_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_410_1.settingData.music_time), function()
								if arg_410_1 == nil or isNil(arg_410_1.bgmTxt_) then
									return
								end

								arg_410_1.musicController:SetSelectedState("hide")
								arg_410_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play417221096 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 417221096
		arg_415_1.duration_ = 11.73

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play417221097(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.cswbg_:SetActive(true)

				local var_418_0 = arg_415_1.cswt_:GetComponent("RectTransform")

				arg_415_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_418_0.offsetMin = Vector2.New(0, 0)
				var_418_0.offsetMax = Vector2.New(0, 0)
				arg_415_1.cswt_.text = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(419117).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.cswt_)

				arg_415_1.cswt_.fontSize = 120
				arg_415_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_415_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_415_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.fswbg_:SetActive(true)
				arg_415_1.dialog_:SetActive(false)

				arg_415_1.fswtw_.percent = 0
				arg_415_1.fswt_.text = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(417221096).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.fswt_)

				arg_415_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_415_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_415_1.fswtw_:SetDirty()

				arg_415_1.typewritterCharCountI18N = 0

				SetActive(arg_415_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_415_1:ShowNextGo(false)
			end

			local var_418_1 = 0.0999999999999999

			if 0.0999999999999999 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.var_.oldValueTypewriter = arg_415_1.fswtw_.percent

				SetActive(arg_415_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_415_1:ShowNextGo(false)
			end

			local var_418_2 = 50
			local var_418_3 = 2.33333333333333
			local var_418_4, var_418_5 = arg_415_1:GetPercentByPara(arg_415_1:FormatText(arg_415_1:GetWordFromCfg(417221096).content), 1)

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				local var_418_6 = var_418_2 <= 0 and var_418_3 or var_418_3 * ((var_418_5 - arg_415_1.typewritterCharCountI18N) / var_418_2)

				if (var_418_2 <= 0 and var_418_3 or var_418_3 * ((var_418_5 - arg_415_1.typewritterCharCountI18N) / var_418_2)) > 0 and var_418_3 < var_418_6 then
					arg_415_1.talkMaxDuration = var_418_6

					if var_418_6 + var_418_1 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_6 + var_418_1
					end
				end
			end

			local var_418_7 = math.max(2.33333333333333, arg_415_1.talkMaxDuration)

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_7 then
				arg_415_1.fswtw_.percent = Mathf.Lerp(arg_415_1.var_.oldValueTypewriter, var_418_4, (arg_415_1.time_ - var_418_1) / var_418_7)
				arg_415_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_415_1.fswtw_:SetDirty()
			end

			if arg_415_1.time_ >= var_418_1 + var_418_7 and arg_415_1.time_ < var_418_1 + var_418_7 + arg_418_0 then
				arg_415_1.fswtw_.percent = var_418_4

				arg_415_1.fswtw_:SetDirty()
				arg_415_1:ShowNextGo(true)

				arg_415_1.typewritterCharCountI18N = var_418_5
			end

			if 0.0999999999999999 < arg_415_1.time_ and arg_415_1.time_ <= 0.0999999999999999 + arg_418_0 then
				arg_415_1:AudioAction("play", "music", "story_v_out_417221", "417221096", "story_v_out_417221.awb")

				local var_418_10 = manager.audio:GetAudioName("story_v_out_417221", "417221096")

				if "" ~= "" then
					if arg_415_1.bgmTxt_.text ~= var_418_10 and arg_415_1.bgmTxt_.text ~= "" then
						if arg_415_1.bgmTxt2_.text ~= "" then
							arg_415_1.bgmTxt_.text = arg_415_1.bgmTxt2_.text
						end

						arg_415_1.bgmTxt2_.text = var_418_10

						arg_415_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_415_1.bgmTxt_.text = var_418_10
						arg_415_1.bgmTxt2_.text = var_418_10
					end

					if arg_415_1.bgmTimer then
						arg_415_1.bgmTimer:Stop()

						arg_415_1.bgmTimer = nil
					end

					if arg_415_1.settingData.show_music_name == 1 then
						arg_415_1.musicController:SetSelectedState("show")
						arg_415_1.musicAnimator_:Play("open", 0, 0)

						if arg_415_1.settingData.music_time ~= 0 then
							arg_415_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_415_1.settingData.music_time), function()
								if arg_415_1 == nil or isNil(arg_415_1.bgmTxt_) then
									return
								end

								arg_415_1.musicController:SetSelectedState("hide")
								arg_415_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play417221097 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 417221097
		arg_420_1.duration_ = 11.93

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play417221098(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.cswbg_:SetActive(true)

				local var_423_0 = arg_420_1.cswt_:GetComponent("RectTransform")

				arg_420_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_423_0.offsetMin = Vector2.New(0, 0)
				var_423_0.offsetMax = Vector2.New(0, 0)
				arg_420_1.cswt_.text = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(419118).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.cswt_)

				arg_420_1.cswt_.fontSize = 120
				arg_420_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_420_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_420_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.fswbg_:SetActive(true)
				arg_420_1.dialog_:SetActive(false)

				arg_420_1.fswtw_.percent = 0
				arg_420_1.fswt_.text = arg_420_1:FormatText(arg_420_1:GetWordFromCfg(417221097).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.fswt_)

				arg_420_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_420_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_420_1.fswtw_:SetDirty()

				arg_420_1.typewritterCharCountI18N = 0

				SetActive(arg_420_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_420_1:ShowNextGo(false)
			end

			local var_423_1 = 0.0999999999999999

			if 0.0999999999999999 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 then
				arg_420_1.var_.oldValueTypewriter = arg_420_1.fswtw_.percent

				SetActive(arg_420_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_420_1:ShowNextGo(false)
			end

			local var_423_2 = 46
			local var_423_3 = 2.33333333333333
			local var_423_4, var_423_5 = arg_420_1:GetPercentByPara(arg_420_1:FormatText(arg_420_1:GetWordFromCfg(417221097).content), 1)

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0

				local var_423_6 = var_423_2 <= 0 and var_423_3 or var_423_3 * ((var_423_5 - arg_420_1.typewritterCharCountI18N) / var_423_2)

				if (var_423_2 <= 0 and var_423_3 or var_423_3 * ((var_423_5 - arg_420_1.typewritterCharCountI18N) / var_423_2)) > 0 and var_423_3 < var_423_6 then
					arg_420_1.talkMaxDuration = var_423_6

					if var_423_6 + var_423_1 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_6 + var_423_1
					end
				end
			end

			local var_423_7 = math.max(2.33333333333333, arg_420_1.talkMaxDuration)

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_7 then
				arg_420_1.fswtw_.percent = Mathf.Lerp(arg_420_1.var_.oldValueTypewriter, var_423_4, (arg_420_1.time_ - var_423_1) / var_423_7)
				arg_420_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_420_1.fswtw_:SetDirty()
			end

			if arg_420_1.time_ >= var_423_1 + var_423_7 and arg_420_1.time_ < var_423_1 + var_423_7 + arg_423_0 then
				arg_420_1.fswtw_.percent = var_423_4

				arg_420_1.fswtw_:SetDirty()
				arg_420_1:ShowNextGo(true)

				arg_420_1.typewritterCharCountI18N = var_423_5
			end

			if 0.0999999999999999 < arg_420_1.time_ and arg_420_1.time_ <= 0.0999999999999999 + arg_423_0 then
				arg_420_1:AudioAction("play", "music", "story_v_out_417221", "417221097", "story_v_out_417221.awb")

				local var_423_10 = manager.audio:GetAudioName("story_v_out_417221", "417221097")

				if "" ~= "" then
					if arg_420_1.bgmTxt_.text ~= var_423_10 and arg_420_1.bgmTxt_.text ~= "" then
						if arg_420_1.bgmTxt2_.text ~= "" then
							arg_420_1.bgmTxt_.text = arg_420_1.bgmTxt2_.text
						end

						arg_420_1.bgmTxt2_.text = var_423_10

						arg_420_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_420_1.bgmTxt_.text = var_423_10
						arg_420_1.bgmTxt2_.text = var_423_10
					end

					if arg_420_1.bgmTimer then
						arg_420_1.bgmTimer:Stop()

						arg_420_1.bgmTimer = nil
					end

					if arg_420_1.settingData.show_music_name == 1 then
						arg_420_1.musicController:SetSelectedState("show")
						arg_420_1.musicAnimator_:Play("open", 0, 0)

						if arg_420_1.settingData.music_time ~= 0 then
							arg_420_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_420_1.settingData.music_time), function()
								if arg_420_1 == nil or isNil(arg_420_1.bgmTxt_) then
									return
								end

								arg_420_1.musicController:SetSelectedState("hide")
								arg_420_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play417221098 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 417221098
		arg_425_1.duration_ = 9

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play417221099(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 4 < arg_425_1.time_ and arg_425_1.time_ <= 4 + arg_428_0 then
				arg_425_1.allBtn_.enabled = false
			end

			if arg_425_1.time_ >= 4 + 0.833333333333333 and arg_425_1.time_ < 4 + 0.833333333333333 + arg_428_0 then
				arg_425_1.allBtn_.enabled = true
			end

			if 2 < arg_425_1.time_ and arg_425_1.time_ <= 2 + arg_428_0 then
				local var_428_0 = arg_425_1.bgs_.I16f

				arg_425_1.bgs_.I16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_428_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_428_1 = var_428_0:GetComponent("SpriteRenderer")

				if var_428_1 and var_428_1.sprite then
					local var_428_2 = 2 * (var_428_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_428_0.transform.localScale = Vector3.New(var_428_2 / var_428_1.sprite.bounds.size.y < var_428_2 * manager.ui.mainCameraCom_.aspect / var_428_1.sprite.bounds.size.x and var_428_2 * manager.ui.mainCameraCom_.aspect / var_428_1.sprite.bounds.size.x or var_428_2 / var_428_1.sprite.bounds.size.y, var_428_2 / var_428_1.sprite.bounds.size.y < var_428_2 * manager.ui.mainCameraCom_.aspect / var_428_1.sprite.bounds.size.x and var_428_2 * manager.ui.mainCameraCom_.aspect / var_428_1.sprite.bounds.size.x or var_428_2 / var_428_1.sprite.bounds.size.y, 0)
				end

				for iter_428_0, iter_428_1 in pairs(arg_425_1.bgs_) do
					if iter_428_0 ~= "I16f" then
						iter_428_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_428_3 = 0

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_3 + arg_428_0 then
				arg_425_1.mask_.enabled = true
				arg_425_1.mask_.raycastTarget = true

				arg_425_1:SetGaussion(false)
			end

			local var_428_4 = 2

			if var_428_3 <= arg_425_1.time_ and arg_425_1.time_ < var_428_3 + var_428_4 then
				local var_428_5 = Color.New(0, 0, 0)

				var_428_5.a = Mathf.Lerp(0, 1, (arg_425_1.time_ - var_428_3) / var_428_4)
				arg_425_1.mask_.color = var_428_5
			end

			if arg_425_1.time_ >= var_428_3 + var_428_4 and arg_425_1.time_ < var_428_3 + var_428_4 + arg_428_0 then
				local var_428_6 = Color.New(0, 0, 0)

				var_428_6.a = 1
				arg_425_1.mask_.color = var_428_6
			end

			local var_428_7 = 2

			if 2 < arg_425_1.time_ and arg_425_1.time_ <= var_428_7 + arg_428_0 then
				arg_425_1.mask_.enabled = true
				arg_425_1.mask_.raycastTarget = true

				arg_425_1:SetGaussion(false)
			end

			local var_428_8 = 2

			if var_428_7 <= arg_425_1.time_ and arg_425_1.time_ < var_428_7 + var_428_8 then
				local var_428_9 = Color.New(0, 0, 0)

				var_428_9.a = Mathf.Lerp(1, 0, (arg_425_1.time_ - var_428_7) / var_428_8)
				arg_425_1.mask_.color = var_428_9
			end

			if arg_425_1.time_ >= var_428_7 + var_428_8 and arg_425_1.time_ < var_428_7 + var_428_8 + arg_428_0 then
				local var_428_10 = Color.New(0, 0, 0)

				arg_425_1.mask_.enabled = false
				var_428_10.a = 0
				arg_425_1.mask_.color = var_428_10
			end

			if 1.9 < arg_425_1.time_ and arg_425_1.time_ <= 1.9 + arg_428_0 then
				arg_425_1.cswbg_:SetActive(false)
			end

			if 1.9 < arg_425_1.time_ and arg_425_1.time_ <= 1.9 + arg_428_0 then
				arg_425_1.fswbg_:SetActive(false)
				arg_425_1.dialog_:SetActive(false)
				SetActive(arg_425_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_425_1:ShowNextGo(false)
			end

			if arg_425_1.frameCnt_ <= 1 then
				arg_425_1.dialog_:SetActive(false)
			end

			local var_428_11 = 4
			local var_428_12 = 1.35

			if 4 < arg_425_1.time_ and arg_425_1.time_ <= var_428_11 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0

				arg_425_1.dialog_:SetActive(true)

				arg_425_1.dialogCg_.alpha = 0

				local var_428_13 = LeanTween.value(arg_425_1.dialog_, 0, 1, 0.3)

				var_428_13:setOnUpdate(LuaHelper.FloatAction(function(arg_429_0)
					arg_425_1.dialogCg_.alpha = arg_429_0
				end))
				var_428_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_425_1.dialog_)
					var_428_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_425_1.duration_ = arg_425_1.duration_ + 0.3

				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_14 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(417221098).content)

				arg_425_1.text_.text = var_428_14

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_16 = 54 <= 0 and var_428_12 or var_428_12 * (utf8.len(var_428_14) / 54)

				if (54 <= 0 and var_428_12 or var_428_12 * (utf8.len(var_428_14) / 54)) > 0 and var_428_12 < var_428_16 then
					arg_425_1.talkMaxDuration = var_428_16
					var_428_11 = var_428_11 + 0.3

					if var_428_16 + var_428_11 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_16 + var_428_11
					end
				end

				arg_425_1.text_.text = var_428_14
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_17 = var_428_11 + 0.3
			local var_428_18 = math.max(var_428_12, arg_425_1.talkMaxDuration)

			if var_428_11 + 0.3 <= arg_425_1.time_ and arg_425_1.time_ < var_428_17 + var_428_18 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_17) / var_428_18

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_17 + var_428_18 and arg_425_1.time_ < var_428_17 + var_428_18 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play417221099 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 417221099
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play417221100(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 1.125

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(417221099).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 45 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 45)

				if (45 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 45)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play417221100 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 417221100
		arg_435_1.duration_ = 9.37

		local var_435_0 = {
			zh = 8.366,
			ja = 9.366
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play417221101(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["10113"]) and arg_435_1.var_.actorSpriteComps10113 == nil then
				arg_435_1.var_.actorSpriteComps10113 = arg_435_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_0 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["10113"]) then
				if arg_435_1.var_.actorSpriteComps10113 then
					for iter_438_0, iter_438_1 in pairs(arg_435_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_438_1 then
							if arg_435_1.isInRecall_ then
								iter_438_1.color = Color.New(Mathf.Lerp(iter_438_1.color.r, arg_435_1.hightColor1.r, (arg_435_1.time_ - 0) / var_438_0), Mathf.Lerp(iter_438_1.color.g, arg_435_1.hightColor1.g, (arg_435_1.time_ - 0) / var_438_0), (Mathf.Lerp(iter_438_1.color.b, arg_435_1.hightColor1.b, (arg_435_1.time_ - 0) / var_438_0)))
							else
								local var_438_1 = Mathf.Lerp(iter_438_1.color.r, 1, (arg_435_1.time_ - 0) / var_438_0)

								iter_438_1.color = Color.New(var_438_1, var_438_1, var_438_1)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["10113"]) and arg_435_1.var_.actorSpriteComps10113 then
				for iter_438_2, iter_438_3 in pairs(arg_435_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_438_3 then
						iter_438_3.color = arg_435_1.isInRecall_ and (arg_435_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_435_1.var_.actorSpriteComps10113 = nil
			end

			local var_438_2 = arg_435_1.actors_["10113"].transform

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos10113 = var_438_2.localPosition
				var_438_2.localScale = Vector3.New(1, 1, 1)

				arg_435_1:CheckSpriteTmpPos("10113", 3)

				for iter_438_4 = 0, var_438_2.childCount - 1 do
					local var_438_3 = var_438_2:GetChild(iter_438_4)

					if var_438_3.name == "split_6" or not string.find(var_438_3.name, "split") then
						var_438_3.gameObject:SetActive(true)
					else
						var_438_3.gameObject:SetActive(false)
					end
				end
			end

			local var_438_4 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_4 then
				var_438_2.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_435_1.time_ - 0) / var_438_4)
			end

			if arg_435_1.time_ >= 0 + var_438_4 and arg_435_1.time_ < 0 + var_438_4 + arg_438_0 then
				var_438_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_438_5 = 0
			local var_438_6 = 0.95

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_5 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_7 = arg_435_1:GetWordFromCfg(417221100)
				local var_438_8 = arg_435_1:FormatText(var_438_7.content)

				arg_435_1.text_.text = var_438_8

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_10 = 38 <= 0 and var_438_6 or var_438_6 * (utf8.len(var_438_8) / 38)

				if (38 <= 0 and var_438_6 or var_438_6 * (utf8.len(var_438_8) / 38)) > 0 and var_438_6 < var_438_10 then
					arg_435_1.talkMaxDuration = var_438_10

					if var_438_10 + var_438_5 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_10 + var_438_5
					end
				end

				arg_435_1.text_.text = var_438_8
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221100", "story_v_out_417221.awb") ~= 0 then
					local var_438_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221100", "story_v_out_417221.awb") / 1000

					if var_438_11 + var_438_5 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_11 + var_438_5
					end

					if var_438_7.prefab_name ~= "" and arg_435_1.actors_[var_438_7.prefab_name] ~= nil then
						local var_438_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_7.prefab_name].transform, "story_v_out_417221", "417221100", "story_v_out_417221.awb")

						arg_435_1:RecordAudio("417221100", var_438_12)
						arg_435_1:RecordAudio("417221100", var_438_12)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_417221", "417221100", "story_v_out_417221.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_417221", "417221100", "story_v_out_417221.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_13 = math.max(var_438_6, arg_435_1.talkMaxDuration)

			if var_438_5 <= arg_435_1.time_ and arg_435_1.time_ < var_438_5 + var_438_13 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_5) / var_438_13

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_5 + var_438_13 and arg_435_1.time_ < var_438_5 + var_438_13 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play417221101 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 417221101
		arg_439_1.duration_ = 16.63

		local var_439_0 = {
			zh = 12.1,
			ja = 16.633
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play417221102(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 1.325

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_1 = arg_439_1:GetWordFromCfg(417221101)
				local var_442_2 = arg_439_1:FormatText(var_442_1.content)

				arg_439_1.text_.text = var_442_2

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_4 = 53 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_2) / 53)

				if (53 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_2) / 53)) > 0 and var_442_0 < var_442_4 then
					arg_439_1.talkMaxDuration = var_442_4

					if var_442_4 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_4 + 0
					end
				end

				arg_439_1.text_.text = var_442_2
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221101", "story_v_out_417221.awb") ~= 0 then
					local var_442_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221101", "story_v_out_417221.awb") / 1000

					if var_442_5 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + 0
					end

					if var_442_1.prefab_name ~= "" and arg_439_1.actors_[var_442_1.prefab_name] ~= nil then
						local var_442_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_1.prefab_name].transform, "story_v_out_417221", "417221101", "story_v_out_417221.awb")

						arg_439_1:RecordAudio("417221101", var_442_6)
						arg_439_1:RecordAudio("417221101", var_442_6)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_417221", "417221101", "story_v_out_417221.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_417221", "417221101", "story_v_out_417221.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_7 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_7 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_7

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_7 and arg_439_1.time_ < 0 + var_442_7 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play417221102 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 417221102
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play417221103(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(arg_443_1.actors_["10113"]) and arg_443_1.var_.actorSpriteComps10113 == nil then
				arg_443_1.var_.actorSpriteComps10113 = arg_443_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_0 = 0.2

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 and not isNil(arg_443_1.actors_["10113"]) then
				if arg_443_1.var_.actorSpriteComps10113 then
					for iter_446_0, iter_446_1 in pairs(arg_443_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_446_1 then
							if arg_443_1.isInRecall_ then
								iter_446_1.color = Color.New(Mathf.Lerp(iter_446_1.color.r, arg_443_1.hightColor2.r, (arg_443_1.time_ - 0) / var_446_0), Mathf.Lerp(iter_446_1.color.g, arg_443_1.hightColor2.g, (arg_443_1.time_ - 0) / var_446_0), (Mathf.Lerp(iter_446_1.color.b, arg_443_1.hightColor2.b, (arg_443_1.time_ - 0) / var_446_0)))
							else
								local var_446_1 = Mathf.Lerp(iter_446_1.color.r, 0.5, (arg_443_1.time_ - 0) / var_446_0)

								iter_446_1.color = Color.New(var_446_1, var_446_1, var_446_1)
							end
						end
					end
				end
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 and not isNil(arg_443_1.actors_["10113"]) and arg_443_1.var_.actorSpriteComps10113 then
				for iter_446_2, iter_446_3 in pairs(arg_443_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_446_3 then
						iter_446_3.color = arg_443_1.isInRecall_ and (arg_443_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_443_1.var_.actorSpriteComps10113 = nil
			end

			local var_446_2 = 0
			local var_446_3 = 1.25

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_2 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_4 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(417221102).content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_6 = 50 <= 0 and var_446_3 or var_446_3 * (utf8.len(var_446_4) / 50)

				if (50 <= 0 and var_446_3 or var_446_3 * (utf8.len(var_446_4) / 50)) > 0 and var_446_3 < var_446_6 then
					arg_443_1.talkMaxDuration = var_446_6

					if var_446_6 + var_446_2 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_6 + var_446_2
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_7 = math.max(var_446_3, arg_443_1.talkMaxDuration)

			if var_446_2 <= arg_443_1.time_ and arg_443_1.time_ < var_446_2 + var_446_7 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_2) / var_446_7

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_2 + var_446_7 and arg_443_1.time_ < var_446_2 + var_446_7 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play417221103 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 417221103
		arg_447_1.duration_ = 10.7

		local var_447_0 = {
			zh = 9.766,
			ja = 10.7
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play417221104(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(arg_447_1.actors_["10113"]) and arg_447_1.var_.actorSpriteComps10113 == nil then
				arg_447_1.var_.actorSpriteComps10113 = arg_447_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_450_0 = 0.2

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 and not isNil(arg_447_1.actors_["10113"]) then
				if arg_447_1.var_.actorSpriteComps10113 then
					for iter_450_0, iter_450_1 in pairs(arg_447_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_450_1 then
							if arg_447_1.isInRecall_ then
								iter_450_1.color = Color.New(Mathf.Lerp(iter_450_1.color.r, arg_447_1.hightColor1.r, (arg_447_1.time_ - 0) / var_450_0), Mathf.Lerp(iter_450_1.color.g, arg_447_1.hightColor1.g, (arg_447_1.time_ - 0) / var_450_0), (Mathf.Lerp(iter_450_1.color.b, arg_447_1.hightColor1.b, (arg_447_1.time_ - 0) / var_450_0)))
							else
								local var_450_1 = Mathf.Lerp(iter_450_1.color.r, 1, (arg_447_1.time_ - 0) / var_450_0)

								iter_450_1.color = Color.New(var_450_1, var_450_1, var_450_1)
							end
						end
					end
				end
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 and not isNil(arg_447_1.actors_["10113"]) and arg_447_1.var_.actorSpriteComps10113 then
				for iter_450_2, iter_450_3 in pairs(arg_447_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_450_3 then
						iter_450_3.color = arg_447_1.isInRecall_ and (arg_447_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_447_1.var_.actorSpriteComps10113 = nil
			end

			local var_450_2 = arg_447_1.actors_["10113"].transform

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos10113 = var_450_2.localPosition
				var_450_2.localScale = Vector3.New(1, 1, 1)

				arg_447_1:CheckSpriteTmpPos("10113", 3)

				for iter_450_4 = 0, var_450_2.childCount - 1 do
					local var_450_3 = var_450_2:GetChild(iter_450_4)

					if var_450_3.name == "split_3" or not string.find(var_450_3.name, "split") then
						var_450_3.gameObject:SetActive(true)
					else
						var_450_3.gameObject:SetActive(false)
					end
				end
			end

			local var_450_4 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_4 then
				var_450_2.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_447_1.time_ - 0) / var_450_4)
			end

			if arg_447_1.time_ >= 0 + var_450_4 and arg_447_1.time_ < 0 + var_450_4 + arg_450_0 then
				var_450_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			if 2.32914680149406 < arg_447_1.time_ and arg_447_1.time_ <= 2.32914680149406 + arg_450_0 then
				arg_447_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_thunder04", "")
			end

			local var_450_6 = 0
			local var_450_7 = 0.7

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_6 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_8 = arg_447_1:GetWordFromCfg(417221103)
				local var_450_9 = arg_447_1:FormatText(var_450_8.content)

				arg_447_1.text_.text = var_450_9

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_11 = 28 <= 0 and var_450_7 or var_450_7 * (utf8.len(var_450_9) / 28)

				if (28 <= 0 and var_450_7 or var_450_7 * (utf8.len(var_450_9) / 28)) > 0 and var_450_7 < var_450_11 then
					arg_447_1.talkMaxDuration = var_450_11

					if var_450_11 + var_450_6 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_11 + var_450_6
					end
				end

				arg_447_1.text_.text = var_450_9
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221103", "story_v_out_417221.awb") ~= 0 then
					local var_450_12 = manager.audio:GetVoiceLength("story_v_out_417221", "417221103", "story_v_out_417221.awb") / 1000

					if var_450_12 + var_450_6 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_12 + var_450_6
					end

					if var_450_8.prefab_name ~= "" and arg_447_1.actors_[var_450_8.prefab_name] ~= nil then
						local var_450_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_8.prefab_name].transform, "story_v_out_417221", "417221103", "story_v_out_417221.awb")

						arg_447_1:RecordAudio("417221103", var_450_13)
						arg_447_1:RecordAudio("417221103", var_450_13)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_417221", "417221103", "story_v_out_417221.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_417221", "417221103", "story_v_out_417221.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_14 = math.max(var_450_7, arg_447_1.talkMaxDuration)

			if var_450_6 <= arg_447_1.time_ and arg_447_1.time_ < var_450_6 + var_450_14 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_6) / var_450_14

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_6 + var_450_14 and arg_447_1.time_ < var_450_6 + var_450_14 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play417221104 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 417221104
		arg_451_1.duration_ = 5.77

		local var_451_0 = {
			zh = 4.866,
			ja = 5.766
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play417221105(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos10113 = arg_451_1.actors_["10113"].transform.localPosition
				arg_451_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_451_1:CheckSpriteTmpPos("10113", 7)

				for iter_454_0 = 0, arg_451_1.actors_["10113"].transform.childCount - 1 do
					local var_454_0 = arg_451_1.actors_["10113"].transform:GetChild(iter_454_0)

					if var_454_0.name == "" or not string.find(var_454_0.name, "split") then
						var_454_0.gameObject:SetActive(true)
					else
						var_454_0.gameObject:SetActive(false)
					end
				end
			end

			local var_454_1 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_1 then
				arg_451_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_451_1.time_ - 0) / var_454_1)
			end

			if arg_451_1.time_ >= 0 + var_454_1 and arg_451_1.time_ < 0 + var_454_1 + arg_454_0 then
				arg_451_1.actors_["10113"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_454_2 = 0
			local var_454_3 = 0.5

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_2 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[1150].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, true)
				arg_451_1.iconController_:SetSelectedState("hero")

				arg_451_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandmaa")

				arg_451_1.callingController_:SetSelectedState("normal")

				arg_451_1.keyicon_.color = Color.New(1, 1, 1)
				arg_451_1.icon_.color = Color.New(1, 1, 1)

				local var_454_4 = arg_451_1:GetWordFromCfg(417221104)
				local var_454_5 = arg_451_1:FormatText(var_454_4.content)

				arg_451_1.text_.text = var_454_5

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_7 = 20 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_5) / 20)

				if (20 <= 0 and var_454_3 or var_454_3 * (utf8.len(var_454_5) / 20)) > 0 and var_454_3 < var_454_7 then
					arg_451_1.talkMaxDuration = var_454_7

					if var_454_7 + var_454_2 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_7 + var_454_2
					end
				end

				arg_451_1.text_.text = var_454_5
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221104", "story_v_out_417221.awb") ~= 0 then
					local var_454_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221104", "story_v_out_417221.awb") / 1000

					if var_454_8 + var_454_2 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_8 + var_454_2
					end

					if var_454_4.prefab_name ~= "" and arg_451_1.actors_[var_454_4.prefab_name] ~= nil then
						local var_454_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_4.prefab_name].transform, "story_v_out_417221", "417221104", "story_v_out_417221.awb")

						arg_451_1:RecordAudio("417221104", var_454_9)
						arg_451_1:RecordAudio("417221104", var_454_9)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_417221", "417221104", "story_v_out_417221.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_417221", "417221104", "story_v_out_417221.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_10 = math.max(var_454_3, arg_451_1.talkMaxDuration)

			if var_454_2 <= arg_451_1.time_ and arg_451_1.time_ < var_454_2 + var_454_10 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_2) / var_454_10

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_2 + var_454_10 and arg_451_1.time_ < var_454_2 + var_454_10 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play417221105 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 417221105
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play417221106(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0.05 < arg_455_1.time_ and arg_455_1.time_ <= 0.05 + arg_458_0 then
				arg_455_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_surround", "")
			end

			local var_458_1 = 0
			local var_458_2 = 0.85

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_3 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(417221105).content)

				arg_455_1.text_.text = var_458_3

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 34 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_3) / 34)

				if (34 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_3) / 34)) > 0 and var_458_2 < var_458_5 then
					arg_455_1.talkMaxDuration = var_458_5

					if var_458_5 + var_458_1 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + var_458_1
					end
				end

				arg_455_1.text_.text = var_458_3
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_6 = math.max(var_458_2, arg_455_1.talkMaxDuration)

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_6 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_1) / var_458_6

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_1 + var_458_6 and arg_455_1.time_ < var_458_1 + var_458_6 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play417221106 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 417221106
		arg_459_1.duration_ = 10.6

		local var_459_0 = {
			zh = 9.133,
			ja = 10.6
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play417221107(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if arg_459_1.bgs_.ST73 == nil then
				local var_462_0 = Object.Instantiate(arg_459_1.paintGo_)

				var_462_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST73")
				var_462_0.name = "ST73"
				var_462_0.transform.parent = arg_459_1.stage_.transform
				var_462_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_459_1.bgs_.ST73 = var_462_0
			end

			if 2 < arg_459_1.time_ and arg_459_1.time_ <= 2 + arg_462_0 then
				local var_462_1 = arg_459_1.bgs_.ST73

				arg_459_1.bgs_.ST73.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_462_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_462_2 = var_462_1:GetComponent("SpriteRenderer")

				if var_462_2 and var_462_2.sprite then
					local var_462_3 = 2 * (var_462_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_462_1.transform.localScale = Vector3.New(var_462_3 / var_462_2.sprite.bounds.size.y < var_462_3 * manager.ui.mainCameraCom_.aspect / var_462_2.sprite.bounds.size.x and var_462_3 * manager.ui.mainCameraCom_.aspect / var_462_2.sprite.bounds.size.x or var_462_3 / var_462_2.sprite.bounds.size.y, var_462_3 / var_462_2.sprite.bounds.size.y < var_462_3 * manager.ui.mainCameraCom_.aspect / var_462_2.sprite.bounds.size.x and var_462_3 * manager.ui.mainCameraCom_.aspect / var_462_2.sprite.bounds.size.x or var_462_3 / var_462_2.sprite.bounds.size.y, 0)
				end

				for iter_462_0, iter_462_1 in pairs(arg_459_1.bgs_) do
					if iter_462_0 ~= "ST73" then
						iter_462_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_462_4 = 4

			if 4 < arg_459_1.time_ and arg_459_1.time_ <= var_462_4 + arg_462_0 then
				arg_459_1.allBtn_.enabled = false
			end

			if arg_459_1.time_ >= var_462_4 + 0.3 and arg_459_1.time_ < var_462_4 + 0.3 + arg_462_0 then
				arg_459_1.allBtn_.enabled = true
			end

			local var_462_5 = 0

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_5 + arg_462_0 then
				arg_459_1.mask_.enabled = true
				arg_459_1.mask_.raycastTarget = true

				arg_459_1:SetGaussion(false)
			end

			local var_462_6 = 2

			if var_462_5 <= arg_459_1.time_ and arg_459_1.time_ < var_462_5 + var_462_6 then
				local var_462_7 = Color.New(0, 0, 0)

				var_462_7.a = Mathf.Lerp(0, 1, (arg_459_1.time_ - var_462_5) / var_462_6)
				arg_459_1.mask_.color = var_462_7
			end

			if arg_459_1.time_ >= var_462_5 + var_462_6 and arg_459_1.time_ < var_462_5 + var_462_6 + arg_462_0 then
				local var_462_8 = Color.New(0, 0, 0)

				var_462_8.a = 1
				arg_459_1.mask_.color = var_462_8
			end

			local var_462_9 = 2

			if 2 < arg_459_1.time_ and arg_459_1.time_ <= var_462_9 + arg_462_0 then
				arg_459_1.mask_.enabled = true
				arg_459_1.mask_.raycastTarget = true

				arg_459_1:SetGaussion(false)
			end

			local var_462_10 = 2

			if var_462_9 <= arg_459_1.time_ and arg_459_1.time_ < var_462_9 + var_462_10 then
				local var_462_11 = Color.New(0, 0, 0)

				var_462_11.a = Mathf.Lerp(1, 0, (arg_459_1.time_ - var_462_9) / var_462_10)
				arg_459_1.mask_.color = var_462_11
			end

			if arg_459_1.time_ >= var_462_9 + var_462_10 and arg_459_1.time_ < var_462_9 + var_462_10 + arg_462_0 then
				local var_462_12 = Color.New(0, 0, 0)

				arg_459_1.mask_.enabled = false
				var_462_12.a = 0
				arg_459_1.mask_.color = var_462_12
			end

			local var_462_13 = "10115"

			if arg_459_1.actors_["10115"] == nil then
				local var_462_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

				if not isNil(var_462_14) then
					local var_462_15 = Object.Instantiate(var_462_14, arg_459_1.canvasGo_.transform)

					var_462_15.transform:SetSiblingIndex(1)

					var_462_15.name = var_462_13
					var_462_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_459_1.actors_[var_462_13] = var_462_15

					if arg_459_1.isInRecall_ then
						for iter_462_2, iter_462_3 in ipairs((var_462_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_462_3.color = arg_459_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_462_16 = arg_459_1.actors_["10115"]

			if 3.76666666666667 < arg_459_1.time_ and arg_459_1.time_ <= 3.76666666666667 + arg_462_0 and not isNil(var_462_16) and arg_459_1.var_.actorSpriteComps10115 == nil then
				arg_459_1.var_.actorSpriteComps10115 = var_462_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_462_17 = 0.2

			if 3.76666666666667 <= arg_459_1.time_ and arg_459_1.time_ < 3.76666666666667 + var_462_17 and not isNil(var_462_16) then
				if arg_459_1.var_.actorSpriteComps10115 then
					for iter_462_4, iter_462_5 in pairs(arg_459_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_462_5 then
							if arg_459_1.isInRecall_ then
								iter_462_5.color = Color.New(Mathf.Lerp(iter_462_5.color.r, arg_459_1.hightColor1.r, (arg_459_1.time_ - 3.76666666666667) / var_462_17), Mathf.Lerp(iter_462_5.color.g, arg_459_1.hightColor1.g, (arg_459_1.time_ - 3.76666666666667) / var_462_17), (Mathf.Lerp(iter_462_5.color.b, arg_459_1.hightColor1.b, (arg_459_1.time_ - 3.76666666666667) / var_462_17)))
							else
								local var_462_18 = Mathf.Lerp(iter_462_5.color.r, 1, (arg_459_1.time_ - 3.76666666666667) / var_462_17)

								iter_462_5.color = Color.New(var_462_18, var_462_18, var_462_18)
							end
						end
					end
				end
			end

			if arg_459_1.time_ >= 3.76666666666667 + var_462_17 and arg_459_1.time_ < 3.76666666666667 + var_462_17 + arg_462_0 and not isNil(var_462_16) and arg_459_1.var_.actorSpriteComps10115 then
				for iter_462_6, iter_462_7 in pairs(arg_459_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_462_7 then
						iter_462_7.color = arg_459_1.isInRecall_ and (arg_459_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_459_1.var_.actorSpriteComps10115 = nil
			end

			local var_462_19 = arg_459_1.actors_["10115"].transform

			if 3.76666666666667 < arg_459_1.time_ and arg_459_1.time_ <= 3.76666666666667 + arg_462_0 then
				arg_459_1.var_.moveOldPos10115 = var_462_19.localPosition
				var_462_19.localScale = Vector3.New(1, 1, 1)

				arg_459_1:CheckSpriteTmpPos("10115", 3)

				for iter_462_8 = 0, var_462_19.childCount - 1 do
					local var_462_20 = var_462_19:GetChild(iter_462_8)

					if var_462_20.name == "split_2" or not string.find(var_462_20.name, "split") then
						var_462_20.gameObject:SetActive(true)
					else
						var_462_20.gameObject:SetActive(false)
					end
				end
			end

			local var_462_21 = 0.001

			if 3.76666666666667 <= arg_459_1.time_ and arg_459_1.time_ < 3.76666666666667 + var_462_21 then
				var_462_19.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos10115, Vector3.New(0, -355, -140), (arg_459_1.time_ - 3.76666666666667) / var_462_21)
			end

			if arg_459_1.time_ >= 3.76666666666667 + var_462_21 and arg_459_1.time_ < 3.76666666666667 + var_462_21 + arg_462_0 then
				var_462_19.localPosition = Vector3.New(0, -355, -140)
			end

			if 3.76666666666667 < arg_459_1.time_ and arg_459_1.time_ <= 3.76666666666667 + arg_462_0 then
				local var_462_22 = arg_459_1.actors_["10115"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_462_22 then
					arg_459_1.var_.alphaOldValue10115 = var_462_22.alpha
					arg_459_1.var_.characterEffect10115 = var_462_22
				end

				arg_459_1.var_.alphaOldValue10115 = 0
			end

			local var_462_23 = 0.233333333333333

			if 3.76666666666667 <= arg_459_1.time_ and arg_459_1.time_ < 3.76666666666667 + var_462_23 then
				if arg_459_1.var_.characterEffect10115 then
					arg_459_1.var_.characterEffect10115.alpha = Mathf.Lerp(arg_459_1.var_.alphaOldValue10115, 1, (arg_459_1.time_ - 3.76666666666667) / var_462_23)
				end
			end

			if arg_459_1.time_ >= 3.76666666666667 + var_462_23 and arg_459_1.time_ < 3.76666666666667 + var_462_23 + arg_462_0 and arg_459_1.var_.characterEffect10115 then
				arg_459_1.var_.characterEffect10115.alpha = 1
			end

			if 1.43333333333333 < arg_459_1.time_ and arg_459_1.time_ <= 1.43333333333333 + arg_462_0 then
				arg_459_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_thunderloop", "")
			end

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_462_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_459_1.bgmTxt_.text ~= var_462_27 and arg_459_1.bgmTxt_.text ~= "" then
						if arg_459_1.bgmTxt2_.text ~= "" then
							arg_459_1.bgmTxt_.text = arg_459_1.bgmTxt2_.text
						end

						arg_459_1.bgmTxt2_.text = var_462_27

						arg_459_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_459_1.bgmTxt_.text = var_462_27
						arg_459_1.bgmTxt2_.text = var_462_27
					end

					if arg_459_1.bgmTimer then
						arg_459_1.bgmTimer:Stop()

						arg_459_1.bgmTimer = nil
					end

					if arg_459_1.settingData.show_music_name == 1 then
						arg_459_1.musicController:SetSelectedState("show")
						arg_459_1.musicAnimator_:Play("open", 0, 0)

						if arg_459_1.settingData.music_time ~= 0 then
							arg_459_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_459_1.settingData.music_time), function()
								if arg_459_1 == nil or isNil(arg_459_1.bgmTxt_) then
									return
								end

								arg_459_1.musicController:SetSelectedState("hide")
								arg_459_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_459_1.frameCnt_ <= 1 then
				arg_459_1.dialog_:SetActive(false)
			end

			local var_462_28 = 4
			local var_462_29 = 0.55

			if 4 < arg_459_1.time_ and arg_459_1.time_ <= var_462_28 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0

				arg_459_1.dialog_:SetActive(true)

				arg_459_1.dialogCg_.alpha = 0

				local var_462_30 = LeanTween.value(arg_459_1.dialog_, 0, 1, 0.3)

				var_462_30:setOnUpdate(LuaHelper.FloatAction(function(arg_464_0)
					arg_459_1.dialogCg_.alpha = arg_464_0
				end))
				var_462_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_459_1.dialog_)
					var_462_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_459_1.duration_ = arg_459_1.duration_ + 0.3

				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_31 = arg_459_1:GetWordFromCfg(417221106)
				local var_462_32 = arg_459_1:FormatText(var_462_31.content)

				arg_459_1.text_.text = var_462_32

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_34 = 22 <= 0 and var_462_29 or var_462_29 * (utf8.len(var_462_32) / 22)

				if (22 <= 0 and var_462_29 or var_462_29 * (utf8.len(var_462_32) / 22)) > 0 and var_462_29 < var_462_34 then
					arg_459_1.talkMaxDuration = var_462_34
					var_462_28 = var_462_28 + 0.3

					if var_462_34 + var_462_28 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_34 + var_462_28
					end
				end

				arg_459_1.text_.text = var_462_32
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221106", "story_v_out_417221.awb") ~= 0 then
					local var_462_35 = manager.audio:GetVoiceLength("story_v_out_417221", "417221106", "story_v_out_417221.awb") / 1000

					if var_462_35 + var_462_28 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_35 + var_462_28
					end

					if var_462_31.prefab_name ~= "" and arg_459_1.actors_[var_462_31.prefab_name] ~= nil then
						local var_462_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_31.prefab_name].transform, "story_v_out_417221", "417221106", "story_v_out_417221.awb")

						arg_459_1:RecordAudio("417221106", var_462_36)
						arg_459_1:RecordAudio("417221106", var_462_36)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_417221", "417221106", "story_v_out_417221.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_417221", "417221106", "story_v_out_417221.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_37 = var_462_28 + 0.3
			local var_462_38 = math.max(var_462_29, arg_459_1.talkMaxDuration)

			if var_462_28 + 0.3 <= arg_459_1.time_ and arg_459_1.time_ < var_462_37 + var_462_38 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_37) / var_462_38

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_37 + var_462_38 and arg_459_1.time_ < var_462_37 + var_462_38 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play417221107 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 417221107
		arg_466_1.duration_ = 7.67

		local var_466_0 = {
			zh = 5.566,
			ja = 7.666
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play417221108(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0.65

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_1 = arg_466_1:GetWordFromCfg(417221107)
				local var_469_2 = arg_466_1:FormatText(var_469_1.content)

				arg_466_1.text_.text = var_469_2

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_4 = 26 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_2) / 26)

				if (26 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_2) / 26)) > 0 and var_469_0 < var_469_4 then
					arg_466_1.talkMaxDuration = var_469_4

					if var_469_4 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_4 + 0
					end
				end

				arg_466_1.text_.text = var_469_2
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221107", "story_v_out_417221.awb") ~= 0 then
					local var_469_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221107", "story_v_out_417221.awb") / 1000

					if var_469_5 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_5 + 0
					end

					if var_469_1.prefab_name ~= "" and arg_466_1.actors_[var_469_1.prefab_name] ~= nil then
						local var_469_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_1.prefab_name].transform, "story_v_out_417221", "417221107", "story_v_out_417221.awb")

						arg_466_1:RecordAudio("417221107", var_469_6)
						arg_466_1:RecordAudio("417221107", var_469_6)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_417221", "417221107", "story_v_out_417221.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_417221", "417221107", "story_v_out_417221.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_7 = math.max(var_469_0, arg_466_1.talkMaxDuration)

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_7 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - 0) / var_469_7

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= 0 + var_469_7 and arg_466_1.time_ < 0 + var_469_7 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play417221108 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 417221108
		arg_470_1.duration_ = 11.93

		local var_470_0 = {
			zh = 8.7,
			ja = 11.933
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play417221109(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 1.05

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_1 = arg_470_1:GetWordFromCfg(417221108)
				local var_473_2 = arg_470_1:FormatText(var_473_1.content)

				arg_470_1.text_.text = var_473_2

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_4 = 42 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 42)

				if (42 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 42)) > 0 and var_473_0 < var_473_4 then
					arg_470_1.talkMaxDuration = var_473_4

					if var_473_4 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_4 + 0
					end
				end

				arg_470_1.text_.text = var_473_2
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221108", "story_v_out_417221.awb") ~= 0 then
					local var_473_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221108", "story_v_out_417221.awb") / 1000

					if var_473_5 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_5 + 0
					end

					if var_473_1.prefab_name ~= "" and arg_470_1.actors_[var_473_1.prefab_name] ~= nil then
						local var_473_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_1.prefab_name].transform, "story_v_out_417221", "417221108", "story_v_out_417221.awb")

						arg_470_1:RecordAudio("417221108", var_473_6)
						arg_470_1:RecordAudio("417221108", var_473_6)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_417221", "417221108", "story_v_out_417221.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_417221", "417221108", "story_v_out_417221.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_7 = math.max(var_473_0, arg_470_1.talkMaxDuration)

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_7 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - 0) / var_473_7

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= 0 + var_473_7 and arg_470_1.time_ < 0 + var_473_7 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play417221109 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 417221109
		arg_474_1.duration_ = 3.93

		local var_474_0 = {
			zh = 3.933,
			ja = 3
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play417221110(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0.425

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_1 = arg_474_1:GetWordFromCfg(417221109)
				local var_477_2 = arg_474_1:FormatText(var_477_1.content)

				arg_474_1.text_.text = var_477_2

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_4 = 17 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_2) / 17)

				if (17 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_2) / 17)) > 0 and var_477_0 < var_477_4 then
					arg_474_1.talkMaxDuration = var_477_4

					if var_477_4 + 0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_4 + 0
					end
				end

				arg_474_1.text_.text = var_477_2
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221109", "story_v_out_417221.awb") ~= 0 then
					local var_477_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221109", "story_v_out_417221.awb") / 1000

					if var_477_5 + 0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_5 + 0
					end

					if var_477_1.prefab_name ~= "" and arg_474_1.actors_[var_477_1.prefab_name] ~= nil then
						local var_477_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_1.prefab_name].transform, "story_v_out_417221", "417221109", "story_v_out_417221.awb")

						arg_474_1:RecordAudio("417221109", var_477_6)
						arg_474_1:RecordAudio("417221109", var_477_6)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_417221", "417221109", "story_v_out_417221.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_417221", "417221109", "story_v_out_417221.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_7 = math.max(var_477_0, arg_474_1.talkMaxDuration)

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_7 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - 0) / var_477_7

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= 0 + var_477_7 and arg_474_1.time_ < 0 + var_477_7 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play417221110 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 417221110
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play417221111(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.var_.moveOldPos10115 = arg_478_1.actors_["10115"].transform.localPosition
				arg_478_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_478_1:CheckSpriteTmpPos("10115", 7)

				for iter_481_0 = 0, arg_478_1.actors_["10115"].transform.childCount - 1 do
					local var_481_0 = arg_478_1.actors_["10115"].transform:GetChild(iter_481_0)

					if var_481_0.name == "" or not string.find(var_481_0.name, "split") then
						var_481_0.gameObject:SetActive(true)
					else
						var_481_0.gameObject:SetActive(false)
					end
				end
			end

			local var_481_1 = 0.001

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_1 then
				arg_478_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_478_1.var_.moveOldPos10115, Vector3.New(0, -2000, -140), (arg_478_1.time_ - 0) / var_481_1)
			end

			if arg_478_1.time_ >= 0 + var_481_1 and arg_478_1.time_ < 0 + var_481_1 + arg_481_0 then
				arg_478_1.actors_["10115"].transform.localPosition = Vector3.New(0, -2000, -140)
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_481_4 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_478_1.bgmTxt_.text ~= var_481_4 and arg_478_1.bgmTxt_.text ~= "" then
						if arg_478_1.bgmTxt2_.text ~= "" then
							arg_478_1.bgmTxt_.text = arg_478_1.bgmTxt2_.text
						end

						arg_478_1.bgmTxt2_.text = var_481_4

						arg_478_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_478_1.bgmTxt_.text = var_481_4
						arg_478_1.bgmTxt2_.text = var_481_4
					end

					if arg_478_1.bgmTimer then
						arg_478_1.bgmTimer:Stop()

						arg_478_1.bgmTimer = nil
					end

					if arg_478_1.settingData.show_music_name == 1 then
						arg_478_1.musicController:SetSelectedState("show")
						arg_478_1.musicAnimator_:Play("open", 0, 0)

						if arg_478_1.settingData.music_time ~= 0 then
							arg_478_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_478_1.settingData.music_time), function()
								if arg_478_1 == nil or isNil(arg_478_1.bgmTxt_) then
									return
								end

								arg_478_1.musicController:SetSelectedState("hide")
								arg_478_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_478_1.time_ and arg_478_1.time_ <= 0.3 + arg_481_0 then
				arg_478_1:AudioAction("play", "music", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_481_7 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

				if "" ~= "" then
					if arg_478_1.bgmTxt_.text ~= var_481_7 and arg_478_1.bgmTxt_.text ~= "" then
						if arg_478_1.bgmTxt2_.text ~= "" then
							arg_478_1.bgmTxt_.text = arg_478_1.bgmTxt2_.text
						end

						arg_478_1.bgmTxt2_.text = var_481_7

						arg_478_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_478_1.bgmTxt_.text = var_481_7
						arg_478_1.bgmTxt2_.text = var_481_7
					end

					if arg_478_1.bgmTimer then
						arg_478_1.bgmTimer:Stop()

						arg_478_1.bgmTimer = nil
					end

					if arg_478_1.settingData.show_music_name == 1 then
						arg_478_1.musicController:SetSelectedState("show")
						arg_478_1.musicAnimator_:Play("open", 0, 0)

						if arg_478_1.settingData.music_time ~= 0 then
							arg_478_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_478_1.settingData.music_time), function()
								if arg_478_1 == nil or isNil(arg_478_1.bgmTxt_) then
									return
								end

								arg_478_1.musicController:SetSelectedState("hide")
								arg_478_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_481_8 = 0
			local var_481_9 = 1.175

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_8 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_10 = arg_478_1:FormatText(arg_478_1:GetWordFromCfg(417221110).content)

				arg_478_1.text_.text = var_481_10

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_12 = 47 <= 0 and var_481_9 or var_481_9 * (utf8.len(var_481_10) / 47)

				if (47 <= 0 and var_481_9 or var_481_9 * (utf8.len(var_481_10) / 47)) > 0 and var_481_9 < var_481_12 then
					arg_478_1.talkMaxDuration = var_481_12

					if var_481_12 + var_481_8 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_12 + var_481_8
					end
				end

				arg_478_1.text_.text = var_481_10
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_13 = math.max(var_481_9, arg_478_1.talkMaxDuration)

			if var_481_8 <= arg_478_1.time_ and arg_478_1.time_ < var_481_8 + var_481_13 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_8) / var_481_13

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_8 + var_481_13 and arg_478_1.time_ < var_481_8 + var_481_13 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_478_1:InitPlayNodeList()
	end,
	Play417221111 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 417221111
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play417221112(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0.85

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, false)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_1 = arg_484_1:FormatText(arg_484_1:GetWordFromCfg(417221111).content)

				arg_484_1.text_.text = var_487_1

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_3 = 34 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_1) / 34)

				if (34 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_1) / 34)) > 0 and var_487_0 < var_487_3 then
					arg_484_1.talkMaxDuration = var_487_3

					if var_487_3 + 0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_3 + 0
					end
				end

				arg_484_1.text_.text = var_487_1
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_4 = math.max(var_487_0, arg_484_1.talkMaxDuration)

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_4 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - 0) / var_487_4

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= 0 + var_487_4 and arg_484_1.time_ < 0 + var_487_4 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play417221112 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 417221112
		arg_488_1.duration_ = 2.47

		local var_488_0 = {
			zh = 1.2,
			ja = 2.466
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play417221113(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 and not isNil(arg_488_1.actors_["10115"]) and arg_488_1.var_.actorSpriteComps10115 == nil then
				arg_488_1.var_.actorSpriteComps10115 = arg_488_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_491_0 = 0.2

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 and not isNil(arg_488_1.actors_["10115"]) then
				if arg_488_1.var_.actorSpriteComps10115 then
					for iter_491_0, iter_491_1 in pairs(arg_488_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_491_1 then
							if arg_488_1.isInRecall_ then
								iter_491_1.color = Color.New(Mathf.Lerp(iter_491_1.color.r, arg_488_1.hightColor1.r, (arg_488_1.time_ - 0) / var_491_0), Mathf.Lerp(iter_491_1.color.g, arg_488_1.hightColor1.g, (arg_488_1.time_ - 0) / var_491_0), (Mathf.Lerp(iter_491_1.color.b, arg_488_1.hightColor1.b, (arg_488_1.time_ - 0) / var_491_0)))
							else
								local var_491_1 = Mathf.Lerp(iter_491_1.color.r, 1, (arg_488_1.time_ - 0) / var_491_0)

								iter_491_1.color = Color.New(var_491_1, var_491_1, var_491_1)
							end
						end
					end
				end
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 and not isNil(arg_488_1.actors_["10115"]) and arg_488_1.var_.actorSpriteComps10115 then
				for iter_491_2, iter_491_3 in pairs(arg_488_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_491_3 then
						iter_491_3.color = arg_488_1.isInRecall_ and (arg_488_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_488_1.var_.actorSpriteComps10115 = nil
			end

			local var_491_2 = arg_488_1.actors_["10115"].transform

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.var_.moveOldPos10115 = var_491_2.localPosition
				var_491_2.localScale = Vector3.New(1, 1, 1)

				arg_488_1:CheckSpriteTmpPos("10115", 3)

				for iter_491_4 = 0, var_491_2.childCount - 1 do
					local var_491_3 = var_491_2:GetChild(iter_491_4)

					if var_491_3.name == "split_1" or not string.find(var_491_3.name, "split") then
						var_491_3.gameObject:SetActive(true)
					else
						var_491_3.gameObject:SetActive(false)
					end
				end
			end

			local var_491_4 = 0.001

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_4 then
				var_491_2.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos10115, Vector3.New(0, -355, -140), (arg_488_1.time_ - 0) / var_491_4)
			end

			if arg_488_1.time_ >= 0 + var_491_4 and arg_488_1.time_ < 0 + var_491_4 + arg_491_0 then
				var_491_2.localPosition = Vector3.New(0, -355, -140)
			end

			local var_491_5 = 0
			local var_491_6 = 0.1

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= var_491_5 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_7 = arg_488_1:GetWordFromCfg(417221112)
				local var_491_8 = arg_488_1:FormatText(var_491_7.content)

				arg_488_1.text_.text = var_491_8

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_10 = 4 <= 0 and var_491_6 or var_491_6 * (utf8.len(var_491_8) / 4)

				if (4 <= 0 and var_491_6 or var_491_6 * (utf8.len(var_491_8) / 4)) > 0 and var_491_6 < var_491_10 then
					arg_488_1.talkMaxDuration = var_491_10

					if var_491_10 + var_491_5 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_10 + var_491_5
					end
				end

				arg_488_1.text_.text = var_491_8
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221112", "story_v_out_417221.awb") ~= 0 then
					local var_491_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221112", "story_v_out_417221.awb") / 1000

					if var_491_11 + var_491_5 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_11 + var_491_5
					end

					if var_491_7.prefab_name ~= "" and arg_488_1.actors_[var_491_7.prefab_name] ~= nil then
						local var_491_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_7.prefab_name].transform, "story_v_out_417221", "417221112", "story_v_out_417221.awb")

						arg_488_1:RecordAudio("417221112", var_491_12)
						arg_488_1:RecordAudio("417221112", var_491_12)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_417221", "417221112", "story_v_out_417221.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_417221", "417221112", "story_v_out_417221.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_13 = math.max(var_491_6, arg_488_1.talkMaxDuration)

			if var_491_5 <= arg_488_1.time_ and arg_488_1.time_ < var_491_5 + var_491_13 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_5) / var_491_13

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_5 + var_491_13 and arg_488_1.time_ < var_491_5 + var_491_13 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play417221113 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 417221113
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play417221114(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.var_.moveOldPos10115 = arg_492_1.actors_["10115"].transform.localPosition
				arg_492_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_492_1:CheckSpriteTmpPos("10115", 7)

				for iter_495_0 = 0, arg_492_1.actors_["10115"].transform.childCount - 1 do
					local var_495_0 = arg_492_1.actors_["10115"].transform:GetChild(iter_495_0)

					if var_495_0.name == "" or not string.find(var_495_0.name, "split") then
						var_495_0.gameObject:SetActive(true)
					else
						var_495_0.gameObject:SetActive(false)
					end
				end
			end

			local var_495_1 = 0.001

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_1 then
				arg_492_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos10115, Vector3.New(0, -2000, -140), (arg_492_1.time_ - 0) / var_495_1)
			end

			if arg_492_1.time_ >= 0 + var_495_1 and arg_492_1.time_ < 0 + var_495_1 + arg_495_0 then
				arg_492_1.actors_["10115"].transform.localPosition = Vector3.New(0, -2000, -140)
			end

			if 0.02 < arg_492_1.time_ and arg_492_1.time_ <= 0.02 + arg_495_0 then
				arg_492_1:AudioAction("play", "effect", "ui_system_3_0", "ui_sight_archieve_in", "")
			end

			local var_495_3 = 0
			local var_495_4 = 0.925

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_3 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, false)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_5 = arg_492_1:FormatText(arg_492_1:GetWordFromCfg(417221113).content)

				arg_492_1.text_.text = var_495_5

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_7 = 37 <= 0 and var_495_4 or var_495_4 * (utf8.len(var_495_5) / 37)

				if (37 <= 0 and var_495_4 or var_495_4 * (utf8.len(var_495_5) / 37)) > 0 and var_495_4 < var_495_7 then
					arg_492_1.talkMaxDuration = var_495_7

					if var_495_7 + var_495_3 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_7 + var_495_3
					end
				end

				arg_492_1.text_.text = var_495_5
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_8 = math.max(var_495_4, arg_492_1.talkMaxDuration)

			if var_495_3 <= arg_492_1.time_ and arg_492_1.time_ < var_495_3 + var_495_8 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_3) / var_495_8

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_3 + var_495_8 and arg_492_1.time_ < var_495_3 + var_495_8 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play417221114 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 417221114
		arg_496_1.duration_ = 10.13

		local var_496_0 = {
			zh = 8.366,
			ja = 10.133
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play417221115(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_9000

			if arg_496_1.bgs_.ST2104 == nil then
				local var_499_0 = Object.Instantiate(arg_496_1.paintGo_)

				var_499_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2104")
				var_499_0.name = "ST2104"
				var_499_0.transform.parent = arg_496_1.stage_.transform
				var_499_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_496_1.bgs_.ST2104 = var_499_0
			end

			if 2 < arg_496_1.time_ and arg_496_1.time_ <= 2 + arg_499_0 then
				local var_499_1 = arg_496_1.bgs_.ST2104

				arg_496_1.bgs_.ST2104.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_499_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_499_2 = var_499_1:GetComponent("SpriteRenderer")

				if var_499_2 and var_499_2.sprite then
					local var_499_3 = 2 * (var_499_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_499_1.transform.localScale = Vector3.New(var_499_3 / var_499_2.sprite.bounds.size.y < var_499_3 * manager.ui.mainCameraCom_.aspect / var_499_2.sprite.bounds.size.x and var_499_3 * manager.ui.mainCameraCom_.aspect / var_499_2.sprite.bounds.size.x or var_499_3 / var_499_2.sprite.bounds.size.y, var_499_3 / var_499_2.sprite.bounds.size.y < var_499_3 * manager.ui.mainCameraCom_.aspect / var_499_2.sprite.bounds.size.x and var_499_3 * manager.ui.mainCameraCom_.aspect / var_499_2.sprite.bounds.size.x or var_499_3 / var_499_2.sprite.bounds.size.y, 0)
				end

				for iter_499_0, iter_499_1 in pairs(arg_496_1.bgs_) do
					if iter_499_0 ~= "ST2104" then
						iter_499_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_499_4 = 4

			if 4 < arg_496_1.time_ and arg_496_1.time_ <= var_499_4 + arg_499_0 then
				arg_496_1.allBtn_.enabled = false
			end

			if arg_496_1.time_ >= var_499_4 + 0.3 and arg_496_1.time_ < var_499_4 + 0.3 + arg_499_0 then
				arg_496_1.allBtn_.enabled = true
			end

			local var_499_5 = 0

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_5 + arg_499_0 then
				arg_496_1.mask_.enabled = true
				arg_496_1.mask_.raycastTarget = true

				arg_496_1:SetGaussion(false)
			end

			local var_499_6 = 2

			if var_499_5 <= arg_496_1.time_ and arg_496_1.time_ < var_499_5 + var_499_6 then
				local var_499_7 = Color.New(0, 0, 0)

				var_499_7.a = Mathf.Lerp(0, 1, (arg_496_1.time_ - var_499_5) / var_499_6)
				arg_496_1.mask_.color = var_499_7
			end

			if arg_496_1.time_ >= var_499_5 + var_499_6 and arg_496_1.time_ < var_499_5 + var_499_6 + arg_499_0 then
				local var_499_8 = Color.New(0, 0, 0)

				var_499_8.a = 1
				arg_496_1.mask_.color = var_499_8
			end

			local var_499_9 = 2

			if 2 < arg_496_1.time_ and arg_496_1.time_ <= var_499_9 + arg_499_0 then
				arg_496_1.mask_.enabled = true
				arg_496_1.mask_.raycastTarget = true

				arg_496_1:SetGaussion(false)
			end

			local var_499_10 = 2

			if var_499_9 <= arg_496_1.time_ and arg_496_1.time_ < var_499_9 + var_499_10 then
				local var_499_11 = Color.New(0, 0, 0)

				var_499_11.a = Mathf.Lerp(1, 0, (arg_496_1.time_ - var_499_9) / var_499_10)
				arg_496_1.mask_.color = var_499_11
			end

			if arg_496_1.time_ >= var_499_9 + var_499_10 and arg_496_1.time_ < var_499_9 + var_499_10 + arg_499_0 then
				local var_499_12 = Color.New(0, 0, 0)

				arg_496_1.mask_.enabled = false
				var_499_12.a = 0
				arg_496_1.mask_.color = var_499_12
			end

			if 2 < arg_496_1.time_ and arg_496_1.time_ <= 2 + arg_499_0 then
				local var_499_13 = arg_496_1.var_.effect21114

				if not arg_496_1.var_.effect21114 then
					var_499_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_jingbao_in_keep"), manager.ui.mainCamera.transform)
					var_499_13.name = "21114"
					arg_496_1.var_.effect21114 = var_499_13
				else
					var_499_13.transform:SetParent(var_499_9000)
				end

				var_499_13.transform.localPosition = Vector3.New(0, 0, -0.6)
				var_499_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_499_15 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_499_2, iter_499_3 in ipairs((var_499_13.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_499_3.transform.localScale = Vector3.New(iter_499_3.transform.localScale.x / var_499_15 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_499_3.transform.localScale.y / var_499_15, iter_499_3.transform.localScale.z)
				end
			end

			if 2 < arg_496_1.time_ and arg_496_1.time_ <= 2 + arg_499_0 then
				arg_496_1:AudioAction("play", "effect", "se_story_129", "se_story_129_alarm", "")
			end

			if arg_496_1.frameCnt_ <= 1 then
				arg_496_1.dialog_:SetActive(false)
			end

			local var_499_18 = 4
			local var_499_19 = 0.65

			if 4 < arg_496_1.time_ and arg_496_1.time_ <= var_499_18 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0

				arg_496_1.dialog_:SetActive(true)

				arg_496_1.dialogCg_.alpha = 0

				local var_499_20 = LeanTween.value(arg_496_1.dialog_, 0, 1, 0.3)

				var_499_20:setOnUpdate(LuaHelper.FloatAction(function(arg_500_0)
					arg_496_1.dialogCg_.alpha = arg_500_0
				end))
				var_499_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_496_1.dialog_)
					var_499_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_496_1.duration_ = arg_496_1.duration_ + 0.3

				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[1144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_21 = arg_496_1:GetWordFromCfg(417221114)
				local var_499_22 = arg_496_1:FormatText(var_499_21.content)

				arg_496_1.text_.text = var_499_22

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_24 = 26 <= 0 and var_499_19 or var_499_19 * (utf8.len(var_499_22) / 26)

				if (26 <= 0 and var_499_19 or var_499_19 * (utf8.len(var_499_22) / 26)) > 0 and var_499_19 < var_499_24 then
					arg_496_1.talkMaxDuration = var_499_24
					var_499_18 = var_499_18 + 0.3

					if var_499_24 + var_499_18 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_24 + var_499_18
					end
				end

				arg_496_1.text_.text = var_499_22
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221114", "story_v_out_417221.awb") ~= 0 then
					local var_499_25 = manager.audio:GetVoiceLength("story_v_out_417221", "417221114", "story_v_out_417221.awb") / 1000

					if var_499_25 + var_499_18 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_25 + var_499_18
					end

					if var_499_21.prefab_name ~= "" and arg_496_1.actors_[var_499_21.prefab_name] ~= nil then
						local var_499_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_21.prefab_name].transform, "story_v_out_417221", "417221114", "story_v_out_417221.awb")

						arg_496_1:RecordAudio("417221114", var_499_26)
						arg_496_1:RecordAudio("417221114", var_499_26)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_417221", "417221114", "story_v_out_417221.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_417221", "417221114", "story_v_out_417221.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_27 = var_499_18 + 0.3
			local var_499_28 = math.max(var_499_19, arg_496_1.talkMaxDuration)

			if var_499_18 + 0.3 <= arg_496_1.time_ and arg_496_1.time_ < var_499_27 + var_499_28 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_27) / var_499_28

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_27 + var_499_28 and arg_496_1.time_ < var_499_27 + var_499_28 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play417221115 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 417221115
		arg_502_1.duration_ = 5

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play417221116(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0.825

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, false)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_1 = arg_502_1:FormatText(arg_502_1:GetWordFromCfg(417221115).content)

				arg_502_1.text_.text = var_505_1

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_3 = 33 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_1) / 33)

				if (33 <= 0 and var_505_0 or var_505_0 * (utf8.len(var_505_1) / 33)) > 0 and var_505_0 < var_505_3 then
					arg_502_1.talkMaxDuration = var_505_3

					if var_505_3 + 0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_3 + 0
					end
				end

				arg_502_1.text_.text = var_505_1
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_4 = math.max(var_505_0, arg_502_1.talkMaxDuration)

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_4 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - 0) / var_505_4

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= 0 + var_505_4 and arg_502_1.time_ < 0 + var_505_4 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play417221116 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 417221116
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play417221117(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 1.05

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_1 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(417221116).content)

				arg_506_1.text_.text = var_509_1

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_3 = 42 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 42)

				if (42 <= 0 and var_509_0 or var_509_0 * (utf8.len(var_509_1) / 42)) > 0 and var_509_0 < var_509_3 then
					arg_506_1.talkMaxDuration = var_509_3

					if var_509_3 + 0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_3 + 0
					end
				end

				arg_506_1.text_.text = var_509_1
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_4 = math.max(var_509_0, arg_506_1.talkMaxDuration)

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_4 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - 0) / var_509_4

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= 0 + var_509_4 and arg_506_1.time_ < 0 + var_509_4 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play417221117 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 417221117
		arg_510_1.duration_ = 4.1

		local var_510_0 = {
			zh = 3.2,
			ja = 4.1
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play417221118(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				if arg_510_1.var_.effect21114 then
					Object.Destroy(arg_510_1.var_.effect21114)

					arg_510_1.var_.effect21114 = nil
				end
			end

			local var_513_1 = 0
			local var_513_2 = 0.35

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[1144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_3 = arg_510_1:GetWordFromCfg(417221117)
				local var_513_4 = arg_510_1:FormatText(var_513_3.content)

				arg_510_1.text_.text = var_513_4

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_6 = 14 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_4) / 14)

				if (14 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_4) / 14)) > 0 and var_513_2 < var_513_6 then
					arg_510_1.talkMaxDuration = var_513_6

					if var_513_6 + var_513_1 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_6 + var_513_1
					end
				end

				arg_510_1.text_.text = var_513_4
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221117", "story_v_out_417221.awb") ~= 0 then
					local var_513_7 = manager.audio:GetVoiceLength("story_v_out_417221", "417221117", "story_v_out_417221.awb") / 1000

					if var_513_7 + var_513_1 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_7 + var_513_1
					end

					if var_513_3.prefab_name ~= "" and arg_510_1.actors_[var_513_3.prefab_name] ~= nil then
						local var_513_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_3.prefab_name].transform, "story_v_out_417221", "417221117", "story_v_out_417221.awb")

						arg_510_1:RecordAudio("417221117", var_513_8)
						arg_510_1:RecordAudio("417221117", var_513_8)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_out_417221", "417221117", "story_v_out_417221.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_out_417221", "417221117", "story_v_out_417221.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_9 = math.max(var_513_2, arg_510_1.talkMaxDuration)

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_9 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_1) / var_513_9

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_1 + var_513_9 and arg_510_1.time_ < var_513_1 + var_513_9 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play417221118 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 417221118
		arg_514_1.duration_ = 3.47

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play417221119(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 0.225

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[1151].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, true)
				arg_514_1.iconController_:SetSelectedState("hero")

				arg_514_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_514_1.callingController_:SetSelectedState("calling")

				arg_514_1.keyicon_.color = Color.New(1, 1, 1)
				arg_514_1.icon_.color = Color.New(1, 1, 1)

				local var_517_1 = arg_514_1:GetWordFromCfg(417221118)
				local var_517_2 = arg_514_1:FormatText(var_517_1.content)

				arg_514_1.text_.text = var_517_2

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_4 = 9 <= 0 and var_517_0 or var_517_0 * (utf8.len(var_517_2) / 9)

				if (9 <= 0 and var_517_0 or var_517_0 * (utf8.len(var_517_2) / 9)) > 0 and var_517_0 < var_517_4 then
					arg_514_1.talkMaxDuration = var_517_4

					if var_517_4 + 0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_4 + 0
					end
				end

				arg_514_1.text_.text = var_517_2
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221118", "story_v_out_417221.awb") ~= 0 then
					local var_517_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221118", "story_v_out_417221.awb") / 1000

					if var_517_5 + 0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_5 + 0
					end

					if var_517_1.prefab_name ~= "" and arg_514_1.actors_[var_517_1.prefab_name] ~= nil then
						local var_517_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_1.prefab_name].transform, "story_v_out_417221", "417221118", "story_v_out_417221.awb")

						arg_514_1:RecordAudio("417221118", var_517_6)
						arg_514_1:RecordAudio("417221118", var_517_6)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_417221", "417221118", "story_v_out_417221.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_417221", "417221118", "story_v_out_417221.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_7 = math.max(var_517_0, arg_514_1.talkMaxDuration)

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_7 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - 0) / var_517_7

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= 0 + var_517_7 and arg_514_1.time_ < 0 + var_517_7 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play417221119 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 417221119
		arg_518_1.duration_ = 2.4

		local var_518_0 = {
			zh = 1.333,
			ja = 2.4
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play417221120(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(arg_518_1.actors_["10115"]) and arg_518_1.var_.actorSpriteComps10115 == nil then
				arg_518_1.var_.actorSpriteComps10115 = arg_518_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_521_0 = 0.2

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 and not isNil(arg_518_1.actors_["10115"]) then
				if arg_518_1.var_.actorSpriteComps10115 then
					for iter_521_0, iter_521_1 in pairs(arg_518_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_521_1 then
							if arg_518_1.isInRecall_ then
								iter_521_1.color = Color.New(Mathf.Lerp(iter_521_1.color.r, arg_518_1.hightColor1.r, (arg_518_1.time_ - 0) / var_521_0), Mathf.Lerp(iter_521_1.color.g, arg_518_1.hightColor1.g, (arg_518_1.time_ - 0) / var_521_0), (Mathf.Lerp(iter_521_1.color.b, arg_518_1.hightColor1.b, (arg_518_1.time_ - 0) / var_521_0)))
							else
								local var_521_1 = Mathf.Lerp(iter_521_1.color.r, 1, (arg_518_1.time_ - 0) / var_521_0)

								iter_521_1.color = Color.New(var_521_1, var_521_1, var_521_1)
							end
						end
					end
				end
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 and not isNil(arg_518_1.actors_["10115"]) and arg_518_1.var_.actorSpriteComps10115 then
				for iter_521_2, iter_521_3 in pairs(arg_518_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_521_3 then
						iter_521_3.color = arg_518_1.isInRecall_ and (arg_518_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_518_1.var_.actorSpriteComps10115 = nil
			end

			local var_521_2 = arg_518_1.actors_["10115"].transform

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.var_.moveOldPos10115 = var_521_2.localPosition
				var_521_2.localScale = Vector3.New(1, 1, 1)

				arg_518_1:CheckSpriteTmpPos("10115", 3)

				for iter_521_4 = 0, var_521_2.childCount - 1 do
					local var_521_3 = var_521_2:GetChild(iter_521_4)

					if var_521_3.name == "split_6" or not string.find(var_521_3.name, "split") then
						var_521_3.gameObject:SetActive(true)
					else
						var_521_3.gameObject:SetActive(false)
					end
				end
			end

			local var_521_4 = 0.001

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_4 then
				var_521_2.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos10115, Vector3.New(0, -355, -140), (arg_518_1.time_ - 0) / var_521_4)
			end

			if arg_518_1.time_ >= 0 + var_521_4 and arg_518_1.time_ < 0 + var_521_4 + arg_521_0 then
				var_521_2.localPosition = Vector3.New(0, -355, -140)
			end

			local var_521_5 = 0
			local var_521_6 = 0.15

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_5 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_7 = arg_518_1:GetWordFromCfg(417221119)
				local var_521_8 = arg_518_1:FormatText(var_521_7.content)

				arg_518_1.text_.text = var_521_8

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_10 = 6 <= 0 and var_521_6 or var_521_6 * (utf8.len(var_521_8) / 6)

				if (6 <= 0 and var_521_6 or var_521_6 * (utf8.len(var_521_8) / 6)) > 0 and var_521_6 < var_521_10 then
					arg_518_1.talkMaxDuration = var_521_10

					if var_521_10 + var_521_5 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_10 + var_521_5
					end
				end

				arg_518_1.text_.text = var_521_8
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221119", "story_v_out_417221.awb") ~= 0 then
					local var_521_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221119", "story_v_out_417221.awb") / 1000

					if var_521_11 + var_521_5 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_11 + var_521_5
					end

					if var_521_7.prefab_name ~= "" and arg_518_1.actors_[var_521_7.prefab_name] ~= nil then
						local var_521_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_7.prefab_name].transform, "story_v_out_417221", "417221119", "story_v_out_417221.awb")

						arg_518_1:RecordAudio("417221119", var_521_12)
						arg_518_1:RecordAudio("417221119", var_521_12)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_417221", "417221119", "story_v_out_417221.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_417221", "417221119", "story_v_out_417221.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_13 = math.max(var_521_6, arg_518_1.talkMaxDuration)

			if var_521_5 <= arg_518_1.time_ and arg_518_1.time_ < var_521_5 + var_521_13 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_5) / var_521_13

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_5 + var_521_13 and arg_518_1.time_ < var_521_5 + var_521_13 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	Play417221120 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 417221120
		arg_522_1.duration_ = 8.33

		local var_522_0 = {
			zh = 6.9,
			ja = 8.333
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play417221121(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1.var_.moveOldPos10115 = arg_522_1.actors_["10115"].transform.localPosition
				arg_522_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_522_1:CheckSpriteTmpPos("10115", 7)

				for iter_525_0 = 0, arg_522_1.actors_["10115"].transform.childCount - 1 do
					local var_525_0 = arg_522_1.actors_["10115"].transform:GetChild(iter_525_0)

					if var_525_0.name == "" or not string.find(var_525_0.name, "split") then
						var_525_0.gameObject:SetActive(true)
					else
						var_525_0.gameObject:SetActive(false)
					end
				end
			end

			local var_525_1 = 0.001

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_1 then
				arg_522_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos10115, Vector3.New(0, -2000, -140), (arg_522_1.time_ - 0) / var_525_1)
			end

			if arg_522_1.time_ >= 0 + var_525_1 and arg_522_1.time_ < 0 + var_525_1 + arg_525_0 then
				arg_522_1.actors_["10115"].transform.localPosition = Vector3.New(0, -2000, -140)
			end

			if 4.5 < arg_522_1.time_ and arg_522_1.time_ <= 4.5 + arg_525_0 then
				arg_522_1:AudioAction("play", "effect", "se_story_16", "se_story_16_attack03", "")
			end

			if 5.9 < arg_522_1.time_ and arg_522_1.time_ <= 5.9 + arg_525_0 then
				arg_522_1:AudioAction("play", "effect", "se_story_130", "se_story_130_noise", "")
			end

			local var_525_4 = 0
			local var_525_5 = 0.625

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_4 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[1151].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, true)
				arg_522_1.iconController_:SetSelectedState("hero")

				arg_522_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_522_1.callingController_:SetSelectedState("calling")

				arg_522_1.keyicon_.color = Color.New(1, 1, 1)
				arg_522_1.icon_.color = Color.New(1, 1, 1)

				local var_525_6 = arg_522_1:GetWordFromCfg(417221120)
				local var_525_7 = arg_522_1:FormatText(var_525_6.content)

				arg_522_1.text_.text = var_525_7

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_9 = 25 <= 0 and var_525_5 or var_525_5 * (utf8.len(var_525_7) / 25)

				if (25 <= 0 and var_525_5 or var_525_5 * (utf8.len(var_525_7) / 25)) > 0 and var_525_5 < var_525_9 then
					arg_522_1.talkMaxDuration = var_525_9

					if var_525_9 + var_525_4 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_9 + var_525_4
					end
				end

				arg_522_1.text_.text = var_525_7
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221120", "story_v_out_417221.awb") ~= 0 then
					local var_525_10 = manager.audio:GetVoiceLength("story_v_out_417221", "417221120", "story_v_out_417221.awb") / 1000

					if var_525_10 + var_525_4 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_10 + var_525_4
					end

					if var_525_6.prefab_name ~= "" and arg_522_1.actors_[var_525_6.prefab_name] ~= nil then
						local var_525_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_6.prefab_name].transform, "story_v_out_417221", "417221120", "story_v_out_417221.awb")

						arg_522_1:RecordAudio("417221120", var_525_11)
						arg_522_1:RecordAudio("417221120", var_525_11)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_417221", "417221120", "story_v_out_417221.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_417221", "417221120", "story_v_out_417221.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_12 = math.max(var_525_5, arg_522_1.talkMaxDuration)

			if var_525_4 <= arg_522_1.time_ and arg_522_1.time_ < var_525_4 + var_525_12 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_4) / var_525_12

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_4 + var_525_12 and arg_522_1.time_ < var_525_4 + var_525_12 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_522_1:InitPlayNodeList()
	end,
	Play417221121 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 417221121
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play417221122(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = 1.25

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, false)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_1 = arg_526_1:FormatText(arg_526_1:GetWordFromCfg(417221121).content)

				arg_526_1.text_.text = var_529_1

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_3 = 50 <= 0 and var_529_0 or var_529_0 * (utf8.len(var_529_1) / 50)

				if (50 <= 0 and var_529_0 or var_529_0 * (utf8.len(var_529_1) / 50)) > 0 and var_529_0 < var_529_3 then
					arg_526_1.talkMaxDuration = var_529_3

					if var_529_3 + 0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_3 + 0
					end
				end

				arg_526_1.text_.text = var_529_1
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_4 = math.max(var_529_0, arg_526_1.talkMaxDuration)

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_4 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - 0) / var_529_4

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= 0 + var_529_4 and arg_526_1.time_ < 0 + var_529_4 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play417221122 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 417221122
		arg_530_1.duration_ = 6.5

		local var_530_0 = {
			zh = 5.2,
			ja = 6.5
		}
		local var_530_1 = manager.audio:GetLocalizationFlag()

		if var_530_0[var_530_1] ~= nil then
			arg_530_1.duration_ = var_530_0[var_530_1]
		end

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play417221123(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = 0.75

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[1144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, true)
				arg_530_1.iconController_:SetSelectedState("hero")

				arg_530_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_530_1.callingController_:SetSelectedState("normal")

				arg_530_1.keyicon_.color = Color.New(1, 1, 1)
				arg_530_1.icon_.color = Color.New(1, 1, 1)

				local var_533_1 = arg_530_1:GetWordFromCfg(417221122)
				local var_533_2 = arg_530_1:FormatText(var_533_1.content)

				arg_530_1.text_.text = var_533_2

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_4 = 30 <= 0 and var_533_0 or var_533_0 * (utf8.len(var_533_2) / 30)

				if (30 <= 0 and var_533_0 or var_533_0 * (utf8.len(var_533_2) / 30)) > 0 and var_533_0 < var_533_4 then
					arg_530_1.talkMaxDuration = var_533_4

					if var_533_4 + 0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_4 + 0
					end
				end

				arg_530_1.text_.text = var_533_2
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221122", "story_v_out_417221.awb") ~= 0 then
					local var_533_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221122", "story_v_out_417221.awb") / 1000

					if var_533_5 + 0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_5 + 0
					end

					if var_533_1.prefab_name ~= "" and arg_530_1.actors_[var_533_1.prefab_name] ~= nil then
						local var_533_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_1.prefab_name].transform, "story_v_out_417221", "417221122", "story_v_out_417221.awb")

						arg_530_1:RecordAudio("417221122", var_533_6)
						arg_530_1:RecordAudio("417221122", var_533_6)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_out_417221", "417221122", "story_v_out_417221.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_out_417221", "417221122", "story_v_out_417221.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_7 = math.max(var_533_0, arg_530_1.talkMaxDuration)

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_7 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - 0) / var_533_7

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= 0 + var_533_7 and arg_530_1.time_ < 0 + var_533_7 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play417221123 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 417221123
		arg_534_1.duration_ = 5.1

		local var_534_0 = {
			zh = 4.9,
			ja = 5.1
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play417221124(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = 0.625

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[1144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, true)
				arg_534_1.iconController_:SetSelectedState("hero")

				arg_534_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_534_1.callingController_:SetSelectedState("normal")

				arg_534_1.keyicon_.color = Color.New(1, 1, 1)
				arg_534_1.icon_.color = Color.New(1, 1, 1)

				local var_537_1 = arg_534_1:GetWordFromCfg(417221123)
				local var_537_2 = arg_534_1:FormatText(var_537_1.content)

				arg_534_1.text_.text = var_537_2

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_4 = 25 <= 0 and var_537_0 or var_537_0 * (utf8.len(var_537_2) / 25)

				if (25 <= 0 and var_537_0 or var_537_0 * (utf8.len(var_537_2) / 25)) > 0 and var_537_0 < var_537_4 then
					arg_534_1.talkMaxDuration = var_537_4

					if var_537_4 + 0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_4 + 0
					end
				end

				arg_534_1.text_.text = var_537_2
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221123", "story_v_out_417221.awb") ~= 0 then
					local var_537_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221123", "story_v_out_417221.awb") / 1000

					if var_537_5 + 0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_5 + 0
					end

					if var_537_1.prefab_name ~= "" and arg_534_1.actors_[var_537_1.prefab_name] ~= nil then
						local var_537_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_1.prefab_name].transform, "story_v_out_417221", "417221123", "story_v_out_417221.awb")

						arg_534_1:RecordAudio("417221123", var_537_6)
						arg_534_1:RecordAudio("417221123", var_537_6)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_out_417221", "417221123", "story_v_out_417221.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_out_417221", "417221123", "story_v_out_417221.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_7 = math.max(var_537_0, arg_534_1.talkMaxDuration)

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_7 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - 0) / var_537_7

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= 0 + var_537_7 and arg_534_1.time_ < 0 + var_537_7 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play417221124 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 417221124
		arg_538_1.duration_ = 7.47

		local var_538_0 = {
			zh = 4.8,
			ja = 7.466
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play417221125(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 and not isNil(arg_538_1.actors_["10115"]) and arg_538_1.var_.actorSpriteComps10115 == nil then
				arg_538_1.var_.actorSpriteComps10115 = arg_538_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_541_0 = 0.2

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_0 and not isNil(arg_538_1.actors_["10115"]) then
				if arg_538_1.var_.actorSpriteComps10115 then
					for iter_541_0, iter_541_1 in pairs(arg_538_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_541_1 then
							if arg_538_1.isInRecall_ then
								iter_541_1.color = Color.New(Mathf.Lerp(iter_541_1.color.r, arg_538_1.hightColor1.r, (arg_538_1.time_ - 0) / var_541_0), Mathf.Lerp(iter_541_1.color.g, arg_538_1.hightColor1.g, (arg_538_1.time_ - 0) / var_541_0), (Mathf.Lerp(iter_541_1.color.b, arg_538_1.hightColor1.b, (arg_538_1.time_ - 0) / var_541_0)))
							else
								local var_541_1 = Mathf.Lerp(iter_541_1.color.r, 1, (arg_538_1.time_ - 0) / var_541_0)

								iter_541_1.color = Color.New(var_541_1, var_541_1, var_541_1)
							end
						end
					end
				end
			end

			if arg_538_1.time_ >= 0 + var_541_0 and arg_538_1.time_ < 0 + var_541_0 + arg_541_0 and not isNil(arg_538_1.actors_["10115"]) and arg_538_1.var_.actorSpriteComps10115 then
				for iter_541_2, iter_541_3 in pairs(arg_538_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_541_3 then
						iter_541_3.color = arg_538_1.isInRecall_ and (arg_538_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_538_1.var_.actorSpriteComps10115 = nil
			end

			local var_541_2 = arg_538_1.actors_["10115"].transform

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1.var_.moveOldPos10115 = var_541_2.localPosition
				var_541_2.localScale = Vector3.New(1, 1, 1)

				arg_538_1:CheckSpriteTmpPos("10115", 3)

				for iter_541_4 = 0, var_541_2.childCount - 1 do
					local var_541_3 = var_541_2:GetChild(iter_541_4)

					if var_541_3.name == "split_6" or not string.find(var_541_3.name, "split") then
						var_541_3.gameObject:SetActive(true)
					else
						var_541_3.gameObject:SetActive(false)
					end
				end
			end

			local var_541_4 = 0.001

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_4 then
				var_541_2.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos10115, Vector3.New(0, -355, -140), (arg_538_1.time_ - 0) / var_541_4)
			end

			if arg_538_1.time_ >= 0 + var_541_4 and arg_538_1.time_ < 0 + var_541_4 + arg_541_0 then
				var_541_2.localPosition = Vector3.New(0, -355, -140)
			end

			local var_541_5 = 0
			local var_541_6 = 0.525

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_5 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_7 = arg_538_1:GetWordFromCfg(417221124)
				local var_541_8 = arg_538_1:FormatText(var_541_7.content)

				arg_538_1.text_.text = var_541_8

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_10 = 21 <= 0 and var_541_6 or var_541_6 * (utf8.len(var_541_8) / 21)

				if (21 <= 0 and var_541_6 or var_541_6 * (utf8.len(var_541_8) / 21)) > 0 and var_541_6 < var_541_10 then
					arg_538_1.talkMaxDuration = var_541_10

					if var_541_10 + var_541_5 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_10 + var_541_5
					end
				end

				arg_538_1.text_.text = var_541_8
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221124", "story_v_out_417221.awb") ~= 0 then
					local var_541_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221124", "story_v_out_417221.awb") / 1000

					if var_541_11 + var_541_5 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_11 + var_541_5
					end

					if var_541_7.prefab_name ~= "" and arg_538_1.actors_[var_541_7.prefab_name] ~= nil then
						local var_541_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_7.prefab_name].transform, "story_v_out_417221", "417221124", "story_v_out_417221.awb")

						arg_538_1:RecordAudio("417221124", var_541_12)
						arg_538_1:RecordAudio("417221124", var_541_12)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_out_417221", "417221124", "story_v_out_417221.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_out_417221", "417221124", "story_v_out_417221.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_13 = math.max(var_541_6, arg_538_1.talkMaxDuration)

			if var_541_5 <= arg_538_1.time_ and arg_538_1.time_ < var_541_5 + var_541_13 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_5) / var_541_13

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_5 + var_541_13 and arg_538_1.time_ < var_541_5 + var_541_13 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_538_1:InitPlayNodeList()
	end,
	Play417221125 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 417221125
		arg_542_1.duration_ = 9.8

		local var_542_0 = {
			zh = 6.466,
			ja = 9.8
		}
		local var_542_1 = manager.audio:GetLocalizationFlag()

		if var_542_0[var_542_1] ~= nil then
			arg_542_1.duration_ = var_542_0[var_542_1]
		end

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play417221126(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 and not isNil(arg_542_1.actors_["10115"]) and arg_542_1.var_.actorSpriteComps10115 == nil then
				arg_542_1.var_.actorSpriteComps10115 = arg_542_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_545_0 = 0.2

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_0 and not isNil(arg_542_1.actors_["10115"]) then
				if arg_542_1.var_.actorSpriteComps10115 then
					for iter_545_0, iter_545_1 in pairs(arg_542_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_545_1 then
							if arg_542_1.isInRecall_ then
								iter_545_1.color = Color.New(Mathf.Lerp(iter_545_1.color.r, arg_542_1.hightColor2.r, (arg_542_1.time_ - 0) / var_545_0), Mathf.Lerp(iter_545_1.color.g, arg_542_1.hightColor2.g, (arg_542_1.time_ - 0) / var_545_0), (Mathf.Lerp(iter_545_1.color.b, arg_542_1.hightColor2.b, (arg_542_1.time_ - 0) / var_545_0)))
							else
								local var_545_1 = Mathf.Lerp(iter_545_1.color.r, 0.5, (arg_542_1.time_ - 0) / var_545_0)

								iter_545_1.color = Color.New(var_545_1, var_545_1, var_545_1)
							end
						end
					end
				end
			end

			if arg_542_1.time_ >= 0 + var_545_0 and arg_542_1.time_ < 0 + var_545_0 + arg_545_0 and not isNil(arg_542_1.actors_["10115"]) and arg_542_1.var_.actorSpriteComps10115 then
				for iter_545_2, iter_545_3 in pairs(arg_542_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_545_3 then
						iter_545_3.color = arg_542_1.isInRecall_ and (arg_542_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_542_1.var_.actorSpriteComps10115 = nil
			end

			local var_545_2 = 0
			local var_545_3 = 1

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_2 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				arg_542_1.leftNameTxt_.text = arg_542_1:FormatText(StoryNameCfg[1144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, true)
				arg_542_1.iconController_:SetSelectedState("hero")

				arg_542_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_542_1.callingController_:SetSelectedState("normal")

				arg_542_1.keyicon_.color = Color.New(1, 1, 1)
				arg_542_1.icon_.color = Color.New(1, 1, 1)

				local var_545_4 = arg_542_1:GetWordFromCfg(417221125)
				local var_545_5 = arg_542_1:FormatText(var_545_4.content)

				arg_542_1.text_.text = var_545_5

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_7 = 40 <= 0 and var_545_3 or var_545_3 * (utf8.len(var_545_5) / 40)

				if (40 <= 0 and var_545_3 or var_545_3 * (utf8.len(var_545_5) / 40)) > 0 and var_545_3 < var_545_7 then
					arg_542_1.talkMaxDuration = var_545_7

					if var_545_7 + var_545_2 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_7 + var_545_2
					end
				end

				arg_542_1.text_.text = var_545_5
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221125", "story_v_out_417221.awb") ~= 0 then
					local var_545_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221125", "story_v_out_417221.awb") / 1000

					if var_545_8 + var_545_2 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_8 + var_545_2
					end

					if var_545_4.prefab_name ~= "" and arg_542_1.actors_[var_545_4.prefab_name] ~= nil then
						local var_545_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_4.prefab_name].transform, "story_v_out_417221", "417221125", "story_v_out_417221.awb")

						arg_542_1:RecordAudio("417221125", var_545_9)
						arg_542_1:RecordAudio("417221125", var_545_9)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_out_417221", "417221125", "story_v_out_417221.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_out_417221", "417221125", "story_v_out_417221.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_10 = math.max(var_545_3, arg_542_1.talkMaxDuration)

			if var_545_2 <= arg_542_1.time_ and arg_542_1.time_ < var_545_2 + var_545_10 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_2) / var_545_10

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_2 + var_545_10 and arg_542_1.time_ < var_545_2 + var_545_10 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play417221126 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 417221126
		arg_546_1.duration_ = 5.53

		local var_546_0 = {
			zh = 4.966,
			ja = 5.533
		}
		local var_546_1 = manager.audio:GetLocalizationFlag()

		if var_546_0[var_546_1] ~= nil then
			arg_546_1.duration_ = var_546_0[var_546_1]
		end

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play417221127(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 and not isNil(arg_546_1.actors_["10115"]) and arg_546_1.var_.actorSpriteComps10115 == nil then
				arg_546_1.var_.actorSpriteComps10115 = arg_546_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_549_0 = 0.2

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_0 and not isNil(arg_546_1.actors_["10115"]) then
				if arg_546_1.var_.actorSpriteComps10115 then
					for iter_549_0, iter_549_1 in pairs(arg_546_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_549_1 then
							if arg_546_1.isInRecall_ then
								iter_549_1.color = Color.New(Mathf.Lerp(iter_549_1.color.r, arg_546_1.hightColor1.r, (arg_546_1.time_ - 0) / var_549_0), Mathf.Lerp(iter_549_1.color.g, arg_546_1.hightColor1.g, (arg_546_1.time_ - 0) / var_549_0), (Mathf.Lerp(iter_549_1.color.b, arg_546_1.hightColor1.b, (arg_546_1.time_ - 0) / var_549_0)))
							else
								local var_549_1 = Mathf.Lerp(iter_549_1.color.r, 1, (arg_546_1.time_ - 0) / var_549_0)

								iter_549_1.color = Color.New(var_549_1, var_549_1, var_549_1)
							end
						end
					end
				end
			end

			if arg_546_1.time_ >= 0 + var_549_0 and arg_546_1.time_ < 0 + var_549_0 + arg_549_0 and not isNil(arg_546_1.actors_["10115"]) and arg_546_1.var_.actorSpriteComps10115 then
				for iter_549_2, iter_549_3 in pairs(arg_546_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_549_3 then
						iter_549_3.color = arg_546_1.isInRecall_ and (arg_546_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_546_1.var_.actorSpriteComps10115 = nil
			end

			local var_549_2 = 0
			local var_549_3 = 0.625

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_2 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_4 = arg_546_1:GetWordFromCfg(417221126)
				local var_549_5 = arg_546_1:FormatText(var_549_4.content)

				arg_546_1.text_.text = var_549_5

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_7 = 25 <= 0 and var_549_3 or var_549_3 * (utf8.len(var_549_5) / 25)

				if (25 <= 0 and var_549_3 or var_549_3 * (utf8.len(var_549_5) / 25)) > 0 and var_549_3 < var_549_7 then
					arg_546_1.talkMaxDuration = var_549_7

					if var_549_7 + var_549_2 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_7 + var_549_2
					end
				end

				arg_546_1.text_.text = var_549_5
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221126", "story_v_out_417221.awb") ~= 0 then
					local var_549_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221126", "story_v_out_417221.awb") / 1000

					if var_549_8 + var_549_2 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_8 + var_549_2
					end

					if var_549_4.prefab_name ~= "" and arg_546_1.actors_[var_549_4.prefab_name] ~= nil then
						local var_549_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_4.prefab_name].transform, "story_v_out_417221", "417221126", "story_v_out_417221.awb")

						arg_546_1:RecordAudio("417221126", var_549_9)
						arg_546_1:RecordAudio("417221126", var_549_9)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_out_417221", "417221126", "story_v_out_417221.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_out_417221", "417221126", "story_v_out_417221.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_10 = math.max(var_549_3, arg_546_1.talkMaxDuration)

			if var_549_2 <= arg_546_1.time_ and arg_546_1.time_ < var_549_2 + var_549_10 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_2) / var_549_10

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_2 + var_549_10 and arg_546_1.time_ < var_549_2 + var_549_10 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play417221127 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 417221127
		arg_550_1.duration_ = 7.8

		local var_550_0 = {
			zh = 3.333,
			ja = 7.8
		}
		local var_550_1 = manager.audio:GetLocalizationFlag()

		if var_550_0[var_550_1] ~= nil then
			arg_550_1.duration_ = var_550_0[var_550_1]
		end

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play417221128(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 and not isNil(arg_550_1.actors_["10115"]) and arg_550_1.var_.actorSpriteComps10115 == nil then
				arg_550_1.var_.actorSpriteComps10115 = arg_550_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_553_0 = 0.2

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_0 and not isNil(arg_550_1.actors_["10115"]) then
				if arg_550_1.var_.actorSpriteComps10115 then
					for iter_553_0, iter_553_1 in pairs(arg_550_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_553_1 then
							if arg_550_1.isInRecall_ then
								iter_553_1.color = Color.New(Mathf.Lerp(iter_553_1.color.r, arg_550_1.hightColor2.r, (arg_550_1.time_ - 0) / var_553_0), Mathf.Lerp(iter_553_1.color.g, arg_550_1.hightColor2.g, (arg_550_1.time_ - 0) / var_553_0), (Mathf.Lerp(iter_553_1.color.b, arg_550_1.hightColor2.b, (arg_550_1.time_ - 0) / var_553_0)))
							else
								local var_553_1 = Mathf.Lerp(iter_553_1.color.r, 0.5, (arg_550_1.time_ - 0) / var_553_0)

								iter_553_1.color = Color.New(var_553_1, var_553_1, var_553_1)
							end
						end
					end
				end
			end

			if arg_550_1.time_ >= 0 + var_553_0 and arg_550_1.time_ < 0 + var_553_0 + arg_553_0 and not isNil(arg_550_1.actors_["10115"]) and arg_550_1.var_.actorSpriteComps10115 then
				for iter_553_2, iter_553_3 in pairs(arg_550_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_553_3 then
						iter_553_3.color = arg_550_1.isInRecall_ and (arg_550_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_550_1.var_.actorSpriteComps10115 = nil
			end

			local var_553_2 = 0
			local var_553_3 = 0.525

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_2 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				arg_550_1.leftNameTxt_.text = arg_550_1:FormatText(StoryNameCfg[1144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, true)
				arg_550_1.iconController_:SetSelectedState("hero")

				arg_550_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_550_1.callingController_:SetSelectedState("normal")

				arg_550_1.keyicon_.color = Color.New(1, 1, 1)
				arg_550_1.icon_.color = Color.New(1, 1, 1)

				local var_553_4 = arg_550_1:GetWordFromCfg(417221127)
				local var_553_5 = arg_550_1:FormatText(var_553_4.content)

				arg_550_1.text_.text = var_553_5

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_7 = 21 <= 0 and var_553_3 or var_553_3 * (utf8.len(var_553_5) / 21)

				if (21 <= 0 and var_553_3 or var_553_3 * (utf8.len(var_553_5) / 21)) > 0 and var_553_3 < var_553_7 then
					arg_550_1.talkMaxDuration = var_553_7

					if var_553_7 + var_553_2 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_7 + var_553_2
					end
				end

				arg_550_1.text_.text = var_553_5
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221127", "story_v_out_417221.awb") ~= 0 then
					local var_553_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221127", "story_v_out_417221.awb") / 1000

					if var_553_8 + var_553_2 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_8 + var_553_2
					end

					if var_553_4.prefab_name ~= "" and arg_550_1.actors_[var_553_4.prefab_name] ~= nil then
						local var_553_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_550_1.actors_[var_553_4.prefab_name].transform, "story_v_out_417221", "417221127", "story_v_out_417221.awb")

						arg_550_1:RecordAudio("417221127", var_553_9)
						arg_550_1:RecordAudio("417221127", var_553_9)
					else
						arg_550_1:AudioAction("play", "voice", "story_v_out_417221", "417221127", "story_v_out_417221.awb")
					end

					arg_550_1:RecordHistoryTalkVoice("story_v_out_417221", "417221127", "story_v_out_417221.awb")
				end

				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_10 = math.max(var_553_3, arg_550_1.talkMaxDuration)

			if var_553_2 <= arg_550_1.time_ and arg_550_1.time_ < var_553_2 + var_553_10 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_2) / var_553_10

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_2 + var_553_10 and arg_550_1.time_ < var_553_2 + var_553_10 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play417221128 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 417221128
		arg_554_1.duration_ = 5

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play417221129(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.var_.moveOldPos10115 = arg_554_1.actors_["10115"].transform.localPosition
				arg_554_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_554_1:CheckSpriteTmpPos("10115", 7)

				for iter_557_0 = 0, arg_554_1.actors_["10115"].transform.childCount - 1 do
					local var_557_0 = arg_554_1.actors_["10115"].transform:GetChild(iter_557_0)

					if var_557_0.name == "" or not string.find(var_557_0.name, "split") then
						var_557_0.gameObject:SetActive(true)
					else
						var_557_0.gameObject:SetActive(false)
					end
				end
			end

			local var_557_1 = 0.001

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_1 then
				arg_554_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_554_1.var_.moveOldPos10115, Vector3.New(0, -2000, -140), (arg_554_1.time_ - 0) / var_557_1)
			end

			if arg_554_1.time_ >= 0 + var_557_1 and arg_554_1.time_ < 0 + var_557_1 + arg_557_0 then
				arg_554_1.actors_["10115"].transform.localPosition = Vector3.New(0, -2000, -140)
			end

			if 1 < arg_554_1.time_ and arg_554_1.time_ <= 1 + arg_557_0 then
				arg_554_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_surround02", "")
			end

			local var_557_3 = 0
			local var_557_4 = 1.25

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_3 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, false)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_5 = arg_554_1:FormatText(arg_554_1:GetWordFromCfg(417221128).content)

				arg_554_1.text_.text = var_557_5

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_7 = 50 <= 0 and var_557_4 or var_557_4 * (utf8.len(var_557_5) / 50)

				if (50 <= 0 and var_557_4 or var_557_4 * (utf8.len(var_557_5) / 50)) > 0 and var_557_4 < var_557_7 then
					arg_554_1.talkMaxDuration = var_557_7

					if var_557_7 + var_557_3 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_7 + var_557_3
					end
				end

				arg_554_1.text_.text = var_557_5
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)
				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_8 = math.max(var_557_4, arg_554_1.talkMaxDuration)

			if var_557_3 <= arg_554_1.time_ and arg_554_1.time_ < var_557_3 + var_557_8 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_3) / var_557_8

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_3 + var_557_8 and arg_554_1.time_ < var_557_3 + var_557_8 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_554_1:InitPlayNodeList()
	end,
	Play417221129 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 417221129
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play417221130(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0.9

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, false)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_1 = arg_558_1:FormatText(arg_558_1:GetWordFromCfg(417221129).content)

				arg_558_1.text_.text = var_561_1

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_3 = 36 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_1) / 36)

				if (36 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_1) / 36)) > 0 and var_561_0 < var_561_3 then
					arg_558_1.talkMaxDuration = var_561_3

					if var_561_3 + 0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_3 + 0
					end
				end

				arg_558_1.text_.text = var_561_1
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_4 = math.max(var_561_0, arg_558_1.talkMaxDuration)

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_4 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - 0) / var_561_4

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= 0 + var_561_4 and arg_558_1.time_ < 0 + var_561_4 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play417221130 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 417221130
		arg_562_1.duration_ = 8.77

		local var_562_0 = {
			zh = 5.233,
			ja = 8.766
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play417221131(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 and not isNil(arg_562_1.actors_["10115"]) and arg_562_1.var_.actorSpriteComps10115 == nil then
				arg_562_1.var_.actorSpriteComps10115 = arg_562_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_565_0 = 0.2

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_0 and not isNil(arg_562_1.actors_["10115"]) then
				if arg_562_1.var_.actorSpriteComps10115 then
					for iter_565_0, iter_565_1 in pairs(arg_562_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_565_1 then
							if arg_562_1.isInRecall_ then
								iter_565_1.color = Color.New(Mathf.Lerp(iter_565_1.color.r, arg_562_1.hightColor1.r, (arg_562_1.time_ - 0) / var_565_0), Mathf.Lerp(iter_565_1.color.g, arg_562_1.hightColor1.g, (arg_562_1.time_ - 0) / var_565_0), (Mathf.Lerp(iter_565_1.color.b, arg_562_1.hightColor1.b, (arg_562_1.time_ - 0) / var_565_0)))
							else
								local var_565_1 = Mathf.Lerp(iter_565_1.color.r, 1, (arg_562_1.time_ - 0) / var_565_0)

								iter_565_1.color = Color.New(var_565_1, var_565_1, var_565_1)
							end
						end
					end
				end
			end

			if arg_562_1.time_ >= 0 + var_565_0 and arg_562_1.time_ < 0 + var_565_0 + arg_565_0 and not isNil(arg_562_1.actors_["10115"]) and arg_562_1.var_.actorSpriteComps10115 then
				for iter_565_2, iter_565_3 in pairs(arg_562_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_565_3 then
						iter_565_3.color = arg_562_1.isInRecall_ and (arg_562_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_562_1.var_.actorSpriteComps10115 = nil
			end

			local var_565_2 = arg_562_1.actors_["10115"].transform

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.var_.moveOldPos10115 = var_565_2.localPosition
				var_565_2.localScale = Vector3.New(1, 1, 1)

				arg_562_1:CheckSpriteTmpPos("10115", 3)

				for iter_565_4 = 0, var_565_2.childCount - 1 do
					local var_565_3 = var_565_2:GetChild(iter_565_4)

					if var_565_3.name == "split_2" or not string.find(var_565_3.name, "split") then
						var_565_3.gameObject:SetActive(true)
					else
						var_565_3.gameObject:SetActive(false)
					end
				end
			end

			local var_565_4 = 0.001

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_4 then
				var_565_2.localPosition = Vector3.Lerp(arg_562_1.var_.moveOldPos10115, Vector3.New(0, -355, -140), (arg_562_1.time_ - 0) / var_565_4)
			end

			if arg_562_1.time_ >= 0 + var_565_4 and arg_562_1.time_ < 0 + var_565_4 + arg_565_0 then
				var_565_2.localPosition = Vector3.New(0, -355, -140)
			end

			local var_565_5 = 0
			local var_565_6 = 0.625

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_5 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_7 = arg_562_1:GetWordFromCfg(417221130)
				local var_565_8 = arg_562_1:FormatText(var_565_7.content)

				arg_562_1.text_.text = var_565_8

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_10 = 25 <= 0 and var_565_6 or var_565_6 * (utf8.len(var_565_8) / 25)

				if (25 <= 0 and var_565_6 or var_565_6 * (utf8.len(var_565_8) / 25)) > 0 and var_565_6 < var_565_10 then
					arg_562_1.talkMaxDuration = var_565_10

					if var_565_10 + var_565_5 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_10 + var_565_5
					end
				end

				arg_562_1.text_.text = var_565_8
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221130", "story_v_out_417221.awb") ~= 0 then
					local var_565_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221130", "story_v_out_417221.awb") / 1000

					if var_565_11 + var_565_5 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_11 + var_565_5
					end

					if var_565_7.prefab_name ~= "" and arg_562_1.actors_[var_565_7.prefab_name] ~= nil then
						local var_565_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_7.prefab_name].transform, "story_v_out_417221", "417221130", "story_v_out_417221.awb")

						arg_562_1:RecordAudio("417221130", var_565_12)
						arg_562_1:RecordAudio("417221130", var_565_12)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_out_417221", "417221130", "story_v_out_417221.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_out_417221", "417221130", "story_v_out_417221.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_13 = math.max(var_565_6, arg_562_1.talkMaxDuration)

			if var_565_5 <= arg_562_1.time_ and arg_562_1.time_ < var_565_5 + var_565_13 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_5) / var_565_13

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_5 + var_565_13 and arg_562_1.time_ < var_565_5 + var_565_13 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_562_1:InitPlayNodeList()
	end,
	Play417221131 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 417221131
		arg_566_1.duration_ = 7

		local var_566_0 = {
			zh = 5.4,
			ja = 7
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play417221132(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 and not isNil(arg_566_1.actors_["10115"]) and arg_566_1.var_.actorSpriteComps10115 == nil then
				arg_566_1.var_.actorSpriteComps10115 = arg_566_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_569_0 = 0.2

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_0 and not isNil(arg_566_1.actors_["10115"]) then
				if arg_566_1.var_.actorSpriteComps10115 then
					for iter_569_0, iter_569_1 in pairs(arg_566_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_569_1 then
							if arg_566_1.isInRecall_ then
								iter_569_1.color = Color.New(Mathf.Lerp(iter_569_1.color.r, arg_566_1.hightColor2.r, (arg_566_1.time_ - 0) / var_569_0), Mathf.Lerp(iter_569_1.color.g, arg_566_1.hightColor2.g, (arg_566_1.time_ - 0) / var_569_0), (Mathf.Lerp(iter_569_1.color.b, arg_566_1.hightColor2.b, (arg_566_1.time_ - 0) / var_569_0)))
							else
								local var_569_1 = Mathf.Lerp(iter_569_1.color.r, 0.5, (arg_566_1.time_ - 0) / var_569_0)

								iter_569_1.color = Color.New(var_569_1, var_569_1, var_569_1)
							end
						end
					end
				end
			end

			if arg_566_1.time_ >= 0 + var_569_0 and arg_566_1.time_ < 0 + var_569_0 + arg_569_0 and not isNil(arg_566_1.actors_["10115"]) and arg_566_1.var_.actorSpriteComps10115 then
				for iter_569_2, iter_569_3 in pairs(arg_566_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_569_3 then
						iter_569_3.color = arg_566_1.isInRecall_ and (arg_566_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_566_1.var_.actorSpriteComps10115 = nil
			end

			local var_569_2 = 0
			local var_569_3 = 0.625

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_2 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[1144].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, true)
				arg_566_1.iconController_:SetSelectedState("hero")

				arg_566_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_566_1.callingController_:SetSelectedState("normal")

				arg_566_1.keyicon_.color = Color.New(1, 1, 1)
				arg_566_1.icon_.color = Color.New(1, 1, 1)

				local var_569_4 = arg_566_1:GetWordFromCfg(417221131)
				local var_569_5 = arg_566_1:FormatText(var_569_4.content)

				arg_566_1.text_.text = var_569_5

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_7 = 25 <= 0 and var_569_3 or var_569_3 * (utf8.len(var_569_5) / 25)

				if (25 <= 0 and var_569_3 or var_569_3 * (utf8.len(var_569_5) / 25)) > 0 and var_569_3 < var_569_7 then
					arg_566_1.talkMaxDuration = var_569_7

					if var_569_7 + var_569_2 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_7 + var_569_2
					end
				end

				arg_566_1.text_.text = var_569_5
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221131", "story_v_out_417221.awb") ~= 0 then
					local var_569_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221131", "story_v_out_417221.awb") / 1000

					if var_569_8 + var_569_2 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_8 + var_569_2
					end

					if var_569_4.prefab_name ~= "" and arg_566_1.actors_[var_569_4.prefab_name] ~= nil then
						local var_569_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_4.prefab_name].transform, "story_v_out_417221", "417221131", "story_v_out_417221.awb")

						arg_566_1:RecordAudio("417221131", var_569_9)
						arg_566_1:RecordAudio("417221131", var_569_9)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_out_417221", "417221131", "story_v_out_417221.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_out_417221", "417221131", "story_v_out_417221.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_10 = math.max(var_569_3, arg_566_1.talkMaxDuration)

			if var_569_2 <= arg_566_1.time_ and arg_566_1.time_ < var_569_2 + var_569_10 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_2) / var_569_10

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_2 + var_569_10 and arg_566_1.time_ < var_569_2 + var_569_10 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play417221132 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 417221132
		arg_570_1.duration_ = 11.47

		local var_570_0 = {
			zh = 10.9,
			ja = 11.466
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play417221133(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 and not isNil(arg_570_1.actors_["10115"]) and arg_570_1.var_.actorSpriteComps10115 == nil then
				arg_570_1.var_.actorSpriteComps10115 = arg_570_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_573_0 = 0.2

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_0 and not isNil(arg_570_1.actors_["10115"]) then
				if arg_570_1.var_.actorSpriteComps10115 then
					for iter_573_0, iter_573_1 in pairs(arg_570_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_573_1 then
							if arg_570_1.isInRecall_ then
								iter_573_1.color = Color.New(Mathf.Lerp(iter_573_1.color.r, arg_570_1.hightColor1.r, (arg_570_1.time_ - 0) / var_573_0), Mathf.Lerp(iter_573_1.color.g, arg_570_1.hightColor1.g, (arg_570_1.time_ - 0) / var_573_0), (Mathf.Lerp(iter_573_1.color.b, arg_570_1.hightColor1.b, (arg_570_1.time_ - 0) / var_573_0)))
							else
								local var_573_1 = Mathf.Lerp(iter_573_1.color.r, 1, (arg_570_1.time_ - 0) / var_573_0)

								iter_573_1.color = Color.New(var_573_1, var_573_1, var_573_1)
							end
						end
					end
				end
			end

			if arg_570_1.time_ >= 0 + var_573_0 and arg_570_1.time_ < 0 + var_573_0 + arg_573_0 and not isNil(arg_570_1.actors_["10115"]) and arg_570_1.var_.actorSpriteComps10115 then
				for iter_573_2, iter_573_3 in pairs(arg_570_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_573_3 then
						iter_573_3.color = arg_570_1.isInRecall_ and (arg_570_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_570_1.var_.actorSpriteComps10115 = nil
			end

			local var_573_2 = 0
			local var_573_3 = 1.35

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_2 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				arg_570_1.leftNameTxt_.text = arg_570_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_4 = arg_570_1:GetWordFromCfg(417221132)
				local var_573_5 = arg_570_1:FormatText(var_573_4.content)

				arg_570_1.text_.text = var_573_5

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_7 = 54 <= 0 and var_573_3 or var_573_3 * (utf8.len(var_573_5) / 54)

				if (54 <= 0 and var_573_3 or var_573_3 * (utf8.len(var_573_5) / 54)) > 0 and var_573_3 < var_573_7 then
					arg_570_1.talkMaxDuration = var_573_7

					if var_573_7 + var_573_2 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_7 + var_573_2
					end
				end

				arg_570_1.text_.text = var_573_5
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221132", "story_v_out_417221.awb") ~= 0 then
					local var_573_8 = manager.audio:GetVoiceLength("story_v_out_417221", "417221132", "story_v_out_417221.awb") / 1000

					if var_573_8 + var_573_2 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_8 + var_573_2
					end

					if var_573_4.prefab_name ~= "" and arg_570_1.actors_[var_573_4.prefab_name] ~= nil then
						local var_573_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_4.prefab_name].transform, "story_v_out_417221", "417221132", "story_v_out_417221.awb")

						arg_570_1:RecordAudio("417221132", var_573_9)
						arg_570_1:RecordAudio("417221132", var_573_9)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_417221", "417221132", "story_v_out_417221.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_417221", "417221132", "story_v_out_417221.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_10 = math.max(var_573_3, arg_570_1.talkMaxDuration)

			if var_573_2 <= arg_570_1.time_ and arg_570_1.time_ < var_573_2 + var_573_10 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_2) / var_573_10

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_2 + var_573_10 and arg_570_1.time_ < var_573_2 + var_573_10 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play417221133 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 417221133
		arg_574_1.duration_ = 1.33

		local var_574_0 = {
			zh = 1.333,
			ja = 1.166
		}
		local var_574_1 = manager.audio:GetLocalizationFlag()

		if var_574_0[var_574_1] ~= nil then
			arg_574_1.duration_ = var_574_0[var_574_1]
		end

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play417221134(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = 0.1

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				arg_574_1.leftNameTxt_.text = arg_574_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_1 = arg_574_1:GetWordFromCfg(417221133)
				local var_577_2 = arg_574_1:FormatText(var_577_1.content)

				arg_574_1.text_.text = var_577_2

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_4 = 4 <= 0 and var_577_0 or var_577_0 * (utf8.len(var_577_2) / 4)

				if (4 <= 0 and var_577_0 or var_577_0 * (utf8.len(var_577_2) / 4)) > 0 and var_577_0 < var_577_4 then
					arg_574_1.talkMaxDuration = var_577_4

					if var_577_4 + 0 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_4 + 0
					end
				end

				arg_574_1.text_.text = var_577_2
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221133", "story_v_out_417221.awb") ~= 0 then
					local var_577_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221133", "story_v_out_417221.awb") / 1000

					if var_577_5 + 0 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_5 + 0
					end

					if var_577_1.prefab_name ~= "" and arg_574_1.actors_[var_577_1.prefab_name] ~= nil then
						local var_577_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_574_1.actors_[var_577_1.prefab_name].transform, "story_v_out_417221", "417221133", "story_v_out_417221.awb")

						arg_574_1:RecordAudio("417221133", var_577_6)
						arg_574_1:RecordAudio("417221133", var_577_6)
					else
						arg_574_1:AudioAction("play", "voice", "story_v_out_417221", "417221133", "story_v_out_417221.awb")
					end

					arg_574_1:RecordHistoryTalkVoice("story_v_out_417221", "417221133", "story_v_out_417221.awb")
				end

				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_7 = math.max(var_577_0, arg_574_1.talkMaxDuration)

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_7 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - 0) / var_577_7

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= 0 + var_577_7 and arg_574_1.time_ < 0 + var_577_7 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play417221134 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 417221134
		arg_578_1.duration_ = 5.5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play417221135(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_9000

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.var_.moveOldPos10115 = arg_578_1.actors_["10115"].transform.localPosition
				arg_578_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_578_1:CheckSpriteTmpPos("10115", 7)

				for iter_581_0 = 0, arg_578_1.actors_["10115"].transform.childCount - 1 do
					local var_581_0 = arg_578_1.actors_["10115"].transform:GetChild(iter_581_0)

					if var_581_0.name == "split_2" or not string.find(var_581_0.name, "split") then
						var_581_0.gameObject:SetActive(true)
					else
						var_581_0.gameObject:SetActive(false)
					end
				end
			end

			local var_581_1 = 0.001

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_1 then
				arg_578_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos10115, Vector3.New(0, -2000, -140), (arg_578_1.time_ - 0) / var_581_1)
			end

			if arg_578_1.time_ >= 0 + var_581_1 and arg_578_1.time_ < 0 + var_581_1 + arg_581_0 then
				arg_578_1.actors_["10115"].transform.localPosition = Vector3.New(0, -2000, -140)
			end

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				local var_581_2 = arg_578_1.var_.effect1134

				if not arg_578_1.var_.effect1134 then
					var_581_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_581_2.name = "1134"
					arg_578_1.var_.effect1134 = var_581_2
				else
					var_581_2.transform:SetParent(var_581_9000)
				end

				var_581_2.transform.localPosition = Vector3.New(0, -0.17, 1.42)
				var_581_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_581_4 = manager.ui.mainCamera.transform

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.var_.shakeOldPos = var_581_4.localPosition
			end

			local var_581_5 = 0.4

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_5 then
				local var_581_6, var_581_7 = math.modf((arg_578_1.time_ - 0) / 0.066)

				var_581_4.localPosition = Vector3.New(var_581_7 * 0.13, var_581_7 * 0.13, var_581_7 * 0.13) + arg_578_1.var_.shakeOldPos
			end

			if arg_578_1.time_ >= 0 + var_581_5 and arg_578_1.time_ < 0 + var_581_5 + arg_581_0 then
				var_581_4.localPosition = arg_578_1.var_.shakeOldPos
			end

			if 0.02 < arg_578_1.time_ and arg_578_1.time_ <= 0.02 + arg_581_0 then
				arg_578_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_gun02", "")
			end

			if arg_578_1.frameCnt_ <= 1 then
				arg_578_1.dialog_:SetActive(false)
			end

			local var_581_9 = 0.5
			local var_581_10 = 0.875

			if 0.5 < arg_578_1.time_ and arg_578_1.time_ <= var_581_9 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0

				arg_578_1.dialog_:SetActive(true)

				arg_578_1.dialogCg_.alpha = 0

				local var_581_11 = LeanTween.value(arg_578_1.dialog_, 0, 1, 0.3)

				var_581_11:setOnUpdate(LuaHelper.FloatAction(function(arg_582_0)
					arg_578_1.dialogCg_.alpha = arg_582_0
				end))
				var_581_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_578_1.dialog_)
					var_581_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_578_1.duration_ = arg_578_1.duration_ + 0.3

				SetActive(arg_578_1.leftNameGo_, false)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_12 = arg_578_1:FormatText(arg_578_1:GetWordFromCfg(417221134).content)

				arg_578_1.text_.text = var_581_12

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_14 = 35 <= 0 and var_581_10 or var_581_10 * (utf8.len(var_581_12) / 35)

				if (35 <= 0 and var_581_10 or var_581_10 * (utf8.len(var_581_12) / 35)) > 0 and var_581_10 < var_581_14 then
					arg_578_1.talkMaxDuration = var_581_14
					var_581_9 = var_581_9 + 0.3

					if var_581_14 + var_581_9 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_14 + var_581_9
					end
				end

				arg_578_1.text_.text = var_581_12
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_15 = var_581_9 + 0.3
			local var_581_16 = math.max(var_581_10, arg_578_1.talkMaxDuration)

			if var_581_9 + 0.3 <= arg_578_1.time_ and arg_578_1.time_ < var_581_15 + var_581_16 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_15) / var_581_16

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_15 + var_581_16 and arg_578_1.time_ < var_581_15 + var_581_16 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_578_1:InitPlayNodeList()
	end,
	Play417221135 = function(arg_584_0, arg_584_1)
		arg_584_1.time_ = 0
		arg_584_1.frameCnt_ = 0
		arg_584_1.state_ = "playing"
		arg_584_1.curTalkId_ = 417221135
		arg_584_1.duration_ = 4.37

		local var_584_0 = {
			zh = 4.366,
			ja = 4.233
		}
		local var_584_1 = manager.audio:GetLocalizationFlag()

		if var_584_0[var_584_1] ~= nil then
			arg_584_1.duration_ = var_584_0[var_584_1]
		end

		SetActive(arg_584_1.tipsGo_, false)

		function arg_584_1.onSingleLineFinish_()
			arg_584_1.onSingleLineUpdate_ = nil
			arg_584_1.onSingleLineFinish_ = nil
			arg_584_1.state_ = "waiting"
		end

		function arg_584_1.playNext_(arg_586_0)
			if arg_586_0 == 1 then
				arg_584_0:Play417221136(arg_584_1)
			end
		end

		function arg_584_1.onSingleLineUpdate_(arg_587_0)
			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 and not isNil(arg_584_1.actors_["10115"]) and arg_584_1.var_.actorSpriteComps10115 == nil then
				arg_584_1.var_.actorSpriteComps10115 = arg_584_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_587_0 = 0.2

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_0 and not isNil(arg_584_1.actors_["10115"]) then
				if arg_584_1.var_.actorSpriteComps10115 then
					for iter_587_0, iter_587_1 in pairs(arg_584_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_587_1 then
							if arg_584_1.isInRecall_ then
								iter_587_1.color = Color.New(Mathf.Lerp(iter_587_1.color.r, arg_584_1.hightColor1.r, (arg_584_1.time_ - 0) / var_587_0), Mathf.Lerp(iter_587_1.color.g, arg_584_1.hightColor1.g, (arg_584_1.time_ - 0) / var_587_0), (Mathf.Lerp(iter_587_1.color.b, arg_584_1.hightColor1.b, (arg_584_1.time_ - 0) / var_587_0)))
							else
								local var_587_1 = Mathf.Lerp(iter_587_1.color.r, 1, (arg_584_1.time_ - 0) / var_587_0)

								iter_587_1.color = Color.New(var_587_1, var_587_1, var_587_1)
							end
						end
					end
				end
			end

			if arg_584_1.time_ >= 0 + var_587_0 and arg_584_1.time_ < 0 + var_587_0 + arg_587_0 and not isNil(arg_584_1.actors_["10115"]) and arg_584_1.var_.actorSpriteComps10115 then
				for iter_587_2, iter_587_3 in pairs(arg_584_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_587_3 then
						iter_587_3.color = arg_584_1.isInRecall_ and (arg_584_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_584_1.var_.actorSpriteComps10115 = nil
			end

			local var_587_2 = arg_584_1.actors_["10115"].transform

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= 0 + arg_587_0 then
				arg_584_1.var_.moveOldPos10115 = var_587_2.localPosition
				var_587_2.localScale = Vector3.New(1, 1, 1)

				arg_584_1:CheckSpriteTmpPos("10115", 3)

				for iter_587_4 = 0, var_587_2.childCount - 1 do
					local var_587_3 = var_587_2:GetChild(iter_587_4)

					if var_587_3.name == "split_1" or not string.find(var_587_3.name, "split") then
						var_587_3.gameObject:SetActive(true)
					else
						var_587_3.gameObject:SetActive(false)
					end
				end
			end

			local var_587_4 = 0.001

			if 0 <= arg_584_1.time_ and arg_584_1.time_ < 0 + var_587_4 then
				var_587_2.localPosition = Vector3.Lerp(arg_584_1.var_.moveOldPos10115, Vector3.New(0, -355, -140), (arg_584_1.time_ - 0) / var_587_4)
			end

			if arg_584_1.time_ >= 0 + var_587_4 and arg_584_1.time_ < 0 + var_587_4 + arg_587_0 then
				var_587_2.localPosition = Vector3.New(0, -355, -140)
			end

			local var_587_5 = 0
			local var_587_6 = 0.425

			if 0 < arg_584_1.time_ and arg_584_1.time_ <= var_587_5 + arg_587_0 then
				arg_584_1.talkMaxDuration = 0
				arg_584_1.dialogCg_.alpha = 1

				arg_584_1.dialog_:SetActive(true)
				SetActive(arg_584_1.leftNameGo_, true)

				arg_584_1.leftNameTxt_.text = arg_584_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_584_1.leftNameTxt_.transform)

				arg_584_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_584_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_584_1:RecordName(arg_584_1.leftNameTxt_.text)
				SetActive(arg_584_1.iconTrs_.gameObject, false)
				arg_584_1.callingController_:SetSelectedState("normal")

				local var_587_7 = arg_584_1:GetWordFromCfg(417221135)
				local var_587_8 = arg_584_1:FormatText(var_587_7.content)

				arg_584_1.text_.text = var_587_8

				LuaForUtil.ClearLinePrefixSymbol(arg_584_1.text_)

				local var_587_10 = 17 <= 0 and var_587_6 or var_587_6 * (utf8.len(var_587_8) / 17)

				if (17 <= 0 and var_587_6 or var_587_6 * (utf8.len(var_587_8) / 17)) > 0 and var_587_6 < var_587_10 then
					arg_584_1.talkMaxDuration = var_587_10

					if var_587_10 + var_587_5 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_10 + var_587_5
					end
				end

				arg_584_1.text_.text = var_587_8
				arg_584_1.typewritter.percent = 0

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221135", "story_v_out_417221.awb") ~= 0 then
					local var_587_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221135", "story_v_out_417221.awb") / 1000

					if var_587_11 + var_587_5 > arg_584_1.duration_ then
						arg_584_1.duration_ = var_587_11 + var_587_5
					end

					if var_587_7.prefab_name ~= "" and arg_584_1.actors_[var_587_7.prefab_name] ~= nil then
						local var_587_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_584_1.actors_[var_587_7.prefab_name].transform, "story_v_out_417221", "417221135", "story_v_out_417221.awb")

						arg_584_1:RecordAudio("417221135", var_587_12)
						arg_584_1:RecordAudio("417221135", var_587_12)
					else
						arg_584_1:AudioAction("play", "voice", "story_v_out_417221", "417221135", "story_v_out_417221.awb")
					end

					arg_584_1:RecordHistoryTalkVoice("story_v_out_417221", "417221135", "story_v_out_417221.awb")
				end

				arg_584_1:RecordContent(arg_584_1.text_.text)
			end

			local var_587_13 = math.max(var_587_6, arg_584_1.talkMaxDuration)

			if var_587_5 <= arg_584_1.time_ and arg_584_1.time_ < var_587_5 + var_587_13 then
				arg_584_1.typewritter.percent = (arg_584_1.time_ - var_587_5) / var_587_13

				arg_584_1.typewritter:SetDirty()
			end

			if arg_584_1.time_ >= var_587_5 + var_587_13 and arg_584_1.time_ < var_587_5 + var_587_13 + arg_587_0 then
				arg_584_1.typewritter.percent = 1

				arg_584_1.typewritter:SetDirty()
				arg_584_1:ShowNextGo(true)
			end
		end

		arg_584_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_584_1:InitPlayNodeList()
	end,
	Play417221136 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 417221136
		arg_588_1.duration_ = 9

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play417221137(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			if 2 < arg_588_1.time_ and arg_588_1.time_ <= 2 + arg_591_0 then
				local var_591_0 = arg_588_1.bgs_.I16f

				arg_588_1.bgs_.I16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_591_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_591_1 = var_591_0:GetComponent("SpriteRenderer")

				if var_591_1 and var_591_1.sprite then
					local var_591_2 = 2 * (var_591_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_591_0.transform.localScale = Vector3.New(var_591_2 / var_591_1.sprite.bounds.size.y < var_591_2 * manager.ui.mainCameraCom_.aspect / var_591_1.sprite.bounds.size.x and var_591_2 * manager.ui.mainCameraCom_.aspect / var_591_1.sprite.bounds.size.x or var_591_2 / var_591_1.sprite.bounds.size.y, var_591_2 / var_591_1.sprite.bounds.size.y < var_591_2 * manager.ui.mainCameraCom_.aspect / var_591_1.sprite.bounds.size.x and var_591_2 * manager.ui.mainCameraCom_.aspect / var_591_1.sprite.bounds.size.x or var_591_2 / var_591_1.sprite.bounds.size.y, 0)
				end

				for iter_591_0, iter_591_1 in pairs(arg_588_1.bgs_) do
					if iter_591_0 ~= "I16f" then
						iter_591_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_591_3 = 4

			if 4 < arg_588_1.time_ and arg_588_1.time_ <= var_591_3 + arg_591_0 then
				arg_588_1.allBtn_.enabled = false
			end

			if arg_588_1.time_ >= var_591_3 + 0.3 and arg_588_1.time_ < var_591_3 + 0.3 + arg_591_0 then
				arg_588_1.allBtn_.enabled = true
			end

			local var_591_4 = 0

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_4 + arg_591_0 then
				arg_588_1.mask_.enabled = true
				arg_588_1.mask_.raycastTarget = true

				arg_588_1:SetGaussion(false)
			end

			local var_591_5 = 2

			if var_591_4 <= arg_588_1.time_ and arg_588_1.time_ < var_591_4 + var_591_5 then
				local var_591_6 = Color.New(0, 0, 0)

				var_591_6.a = Mathf.Lerp(0, 1, (arg_588_1.time_ - var_591_4) / var_591_5)
				arg_588_1.mask_.color = var_591_6
			end

			if arg_588_1.time_ >= var_591_4 + var_591_5 and arg_588_1.time_ < var_591_4 + var_591_5 + arg_591_0 then
				local var_591_7 = Color.New(0, 0, 0)

				var_591_7.a = 1
				arg_588_1.mask_.color = var_591_7
			end

			local var_591_8 = 2

			if 2 < arg_588_1.time_ and arg_588_1.time_ <= var_591_8 + arg_591_0 then
				arg_588_1.mask_.enabled = true
				arg_588_1.mask_.raycastTarget = true

				arg_588_1:SetGaussion(false)
			end

			local var_591_9 = 2

			if var_591_8 <= arg_588_1.time_ and arg_588_1.time_ < var_591_8 + var_591_9 then
				local var_591_10 = Color.New(0, 0, 0)

				var_591_10.a = Mathf.Lerp(1, 0, (arg_588_1.time_ - var_591_8) / var_591_9)
				arg_588_1.mask_.color = var_591_10
			end

			if arg_588_1.time_ >= var_591_8 + var_591_9 and arg_588_1.time_ < var_591_8 + var_591_9 + arg_591_0 then
				local var_591_11 = Color.New(0, 0, 0)

				arg_588_1.mask_.enabled = false
				var_591_11.a = 0
				arg_588_1.mask_.color = var_591_11
			end

			local var_591_12 = arg_588_1.actors_["10115"].transform

			if 1.966 < arg_588_1.time_ and arg_588_1.time_ <= 1.966 + arg_591_0 then
				arg_588_1.var_.moveOldPos10115 = var_591_12.localPosition
				var_591_12.localScale = Vector3.New(1, 1, 1)

				arg_588_1:CheckSpriteTmpPos("10115", 7)

				for iter_591_2 = 0, var_591_12.childCount - 1 do
					local var_591_13 = var_591_12:GetChild(iter_591_2)

					if var_591_13.name == "" or not string.find(var_591_13.name, "split") then
						var_591_13.gameObject:SetActive(true)
					else
						var_591_13.gameObject:SetActive(false)
					end
				end
			end

			local var_591_14 = 0.001

			if 1.966 <= arg_588_1.time_ and arg_588_1.time_ < 1.966 + var_591_14 then
				var_591_12.localPosition = Vector3.Lerp(arg_588_1.var_.moveOldPos10115, Vector3.New(0, -2000, -140), (arg_588_1.time_ - 1.966) / var_591_14)
			end

			if arg_588_1.time_ >= 1.966 + var_591_14 and arg_588_1.time_ < 1.966 + var_591_14 + arg_591_0 then
				var_591_12.localPosition = Vector3.New(0, -2000, -140)
			end

			if 1.966 < arg_588_1.time_ and arg_588_1.time_ <= 1.966 + arg_591_0 then
				if arg_588_1.var_.effect21114 then
					Object.Destroy(arg_588_1.var_.effect21114)

					arg_588_1.var_.effect21114 = nil
				end
			end

			if 1.75135478796437 < arg_588_1.time_ and arg_588_1.time_ <= 1.75135478796437 + arg_591_0 then
				arg_588_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_thunderloop", "")
			end

			if arg_588_1.frameCnt_ <= 1 then
				arg_588_1.dialog_:SetActive(false)
			end

			local var_591_17 = 4
			local var_591_18 = 0.375

			if 4 < arg_588_1.time_ and arg_588_1.time_ <= var_591_17 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0

				arg_588_1.dialog_:SetActive(true)

				arg_588_1.dialogCg_.alpha = 0

				local var_591_19 = LeanTween.value(arg_588_1.dialog_, 0, 1, 0.3)

				var_591_19:setOnUpdate(LuaHelper.FloatAction(function(arg_592_0)
					arg_588_1.dialogCg_.alpha = arg_592_0
				end))
				var_591_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_588_1.dialog_)
					var_591_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_588_1.duration_ = arg_588_1.duration_ + 0.3

				SetActive(arg_588_1.leftNameGo_, false)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_20 = arg_588_1:FormatText(arg_588_1:GetWordFromCfg(417221136).content)

				arg_588_1.text_.text = var_591_20

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_22 = 15 <= 0 and var_591_18 or var_591_18 * (utf8.len(var_591_20) / 15)

				if (15 <= 0 and var_591_18 or var_591_18 * (utf8.len(var_591_20) / 15)) > 0 and var_591_18 < var_591_22 then
					arg_588_1.talkMaxDuration = var_591_22
					var_591_17 = var_591_17 + 0.3

					if var_591_22 + var_591_17 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_22 + var_591_17
					end
				end

				arg_588_1.text_.text = var_591_20
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_23 = var_591_17 + 0.3
			local var_591_24 = math.max(var_591_18, arg_588_1.talkMaxDuration)

			if var_591_17 + 0.3 <= arg_588_1.time_ and arg_588_1.time_ < var_591_23 + var_591_24 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_23) / var_591_24

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_23 + var_591_24 and arg_588_1.time_ < var_591_23 + var_591_24 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_588_1:InitPlayNodeList()
	end,
	Play417221137 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 417221137
		arg_594_1.duration_ = 5

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play417221138(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			if 0.133333333333333 < arg_594_1.time_ and arg_594_1.time_ <= 0.133333333333333 + arg_597_0 then
				arg_594_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_rush", "")
			end

			local var_597_1 = 0
			local var_597_2 = 1

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= var_597_1 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, false)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_3 = arg_594_1:FormatText(arg_594_1:GetWordFromCfg(417221137).content)

				arg_594_1.text_.text = var_597_3

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_5 = 40 <= 0 and var_597_2 or var_597_2 * (utf8.len(var_597_3) / 40)

				if (40 <= 0 and var_597_2 or var_597_2 * (utf8.len(var_597_3) / 40)) > 0 and var_597_2 < var_597_5 then
					arg_594_1.talkMaxDuration = var_597_5

					if var_597_5 + var_597_1 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_5 + var_597_1
					end
				end

				arg_594_1.text_.text = var_597_3
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)
				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_6 = math.max(var_597_2, arg_594_1.talkMaxDuration)

			if var_597_1 <= arg_594_1.time_ and arg_594_1.time_ < var_597_1 + var_597_6 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_1) / var_597_6

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_1 + var_597_6 and arg_594_1.time_ < var_597_1 + var_597_6 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {}

		arg_594_1:InitPlayNodeList()
	end,
	Play417221138 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 417221138
		arg_598_1.duration_ = 2.8

		local var_598_0 = {
			zh = 2.8,
			ja = 2.133
		}
		local var_598_1 = manager.audio:GetLocalizationFlag()

		if var_598_0[var_598_1] ~= nil then
			arg_598_1.duration_ = var_598_0[var_598_1]
		end

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play417221139(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 and not isNil(arg_598_1.actors_["10113"]) and arg_598_1.var_.actorSpriteComps10113 == nil then
				arg_598_1.var_.actorSpriteComps10113 = arg_598_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_601_0 = 0.2

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_0 and not isNil(arg_598_1.actors_["10113"]) then
				if arg_598_1.var_.actorSpriteComps10113 then
					for iter_601_0, iter_601_1 in pairs(arg_598_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_601_1 then
							if arg_598_1.isInRecall_ then
								iter_601_1.color = Color.New(Mathf.Lerp(iter_601_1.color.r, arg_598_1.hightColor1.r, (arg_598_1.time_ - 0) / var_601_0), Mathf.Lerp(iter_601_1.color.g, arg_598_1.hightColor1.g, (arg_598_1.time_ - 0) / var_601_0), (Mathf.Lerp(iter_601_1.color.b, arg_598_1.hightColor1.b, (arg_598_1.time_ - 0) / var_601_0)))
							else
								local var_601_1 = Mathf.Lerp(iter_601_1.color.r, 1, (arg_598_1.time_ - 0) / var_601_0)

								iter_601_1.color = Color.New(var_601_1, var_601_1, var_601_1)
							end
						end
					end
				end
			end

			if arg_598_1.time_ >= 0 + var_601_0 and arg_598_1.time_ < 0 + var_601_0 + arg_601_0 and not isNil(arg_598_1.actors_["10113"]) and arg_598_1.var_.actorSpriteComps10113 then
				for iter_601_2, iter_601_3 in pairs(arg_598_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_601_3 then
						iter_601_3.color = arg_598_1.isInRecall_ and (arg_598_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_598_1.var_.actorSpriteComps10113 = nil
			end

			local var_601_2 = arg_598_1.actors_["10113"].transform

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 then
				arg_598_1.var_.moveOldPos10113 = var_601_2.localPosition
				var_601_2.localScale = Vector3.New(1, 1, 1)

				arg_598_1:CheckSpriteTmpPos("10113", 3)

				for iter_601_4 = 0, var_601_2.childCount - 1 do
					local var_601_3 = var_601_2:GetChild(iter_601_4)

					if var_601_3.name == "split_2" or not string.find(var_601_3.name, "split") then
						var_601_3.gameObject:SetActive(true)
					else
						var_601_3.gameObject:SetActive(false)
					end
				end
			end

			local var_601_4 = 0.001

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_4 then
				var_601_2.localPosition = Vector3.Lerp(arg_598_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_598_1.time_ - 0) / var_601_4)
			end

			if arg_598_1.time_ >= 0 + var_601_4 and arg_598_1.time_ < 0 + var_601_4 + arg_601_0 then
				var_601_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_601_5 = 0
			local var_601_6 = 0.175

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= var_601_5 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				arg_598_1.leftNameTxt_.text = arg_598_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_7 = arg_598_1:GetWordFromCfg(417221138)
				local var_601_8 = arg_598_1:FormatText(var_601_7.content)

				arg_598_1.text_.text = var_601_8

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_10 = 7 <= 0 and var_601_6 or var_601_6 * (utf8.len(var_601_8) / 7)

				if (7 <= 0 and var_601_6 or var_601_6 * (utf8.len(var_601_8) / 7)) > 0 and var_601_6 < var_601_10 then
					arg_598_1.talkMaxDuration = var_601_10

					if var_601_10 + var_601_5 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_10 + var_601_5
					end
				end

				arg_598_1.text_.text = var_601_8
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221138", "story_v_out_417221.awb") ~= 0 then
					local var_601_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221138", "story_v_out_417221.awb") / 1000

					if var_601_11 + var_601_5 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_11 + var_601_5
					end

					if var_601_7.prefab_name ~= "" and arg_598_1.actors_[var_601_7.prefab_name] ~= nil then
						local var_601_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_7.prefab_name].transform, "story_v_out_417221", "417221138", "story_v_out_417221.awb")

						arg_598_1:RecordAudio("417221138", var_601_12)
						arg_598_1:RecordAudio("417221138", var_601_12)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_out_417221", "417221138", "story_v_out_417221.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_out_417221", "417221138", "story_v_out_417221.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_13 = math.max(var_601_6, arg_598_1.talkMaxDuration)

			if var_601_5 <= arg_598_1.time_ and arg_598_1.time_ < var_601_5 + var_601_13 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_5) / var_601_13

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_5 + var_601_13 and arg_598_1.time_ < var_601_5 + var_601_13 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_598_1:InitPlayNodeList()
	end,
	Play417221139 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 417221139
		arg_602_1.duration_ = 5

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play417221140(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1.var_.moveOldPos10113 = arg_602_1.actors_["10113"].transform.localPosition
				arg_602_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_602_1:CheckSpriteTmpPos("10113", 7)

				for iter_605_0 = 0, arg_602_1.actors_["10113"].transform.childCount - 1 do
					local var_605_0 = arg_602_1.actors_["10113"].transform:GetChild(iter_605_0)

					if var_605_0.name == "" or not string.find(var_605_0.name, "split") then
						var_605_0.gameObject:SetActive(true)
					else
						var_605_0.gameObject:SetActive(false)
					end
				end
			end

			local var_605_1 = 0.001

			if 0 <= arg_602_1.time_ and arg_602_1.time_ < 0 + var_605_1 then
				arg_602_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_602_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_602_1.time_ - 0) / var_605_1)
			end

			if arg_602_1.time_ >= 0 + var_605_1 and arg_602_1.time_ < 0 + var_605_1 + arg_605_0 then
				arg_602_1.actors_["10113"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_605_2 = 0
			local var_605_3 = 1.05

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= var_605_2 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, false)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_602_1.iconTrs_.gameObject, false)
				arg_602_1.callingController_:SetSelectedState("normal")

				local var_605_4 = arg_602_1:FormatText(arg_602_1:GetWordFromCfg(417221139).content)

				arg_602_1.text_.text = var_605_4

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_6 = 42 <= 0 and var_605_3 or var_605_3 * (utf8.len(var_605_4) / 42)

				if (42 <= 0 and var_605_3 or var_605_3 * (utf8.len(var_605_4) / 42)) > 0 and var_605_3 < var_605_6 then
					arg_602_1.talkMaxDuration = var_605_6

					if var_605_6 + var_605_2 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_6 + var_605_2
					end
				end

				arg_602_1.text_.text = var_605_4
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)
				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_7 = math.max(var_605_3, arg_602_1.talkMaxDuration)

			if var_605_2 <= arg_602_1.time_ and arg_602_1.time_ < var_605_2 + var_605_7 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_2) / var_605_7

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_2 + var_605_7 and arg_602_1.time_ < var_605_2 + var_605_7 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_602_1:InitPlayNodeList()
	end,
	Play417221140 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 417221140
		arg_606_1.duration_ = 5

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play417221141(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			local var_609_0 = 1.1

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, false)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_606_1.iconTrs_.gameObject, false)
				arg_606_1.callingController_:SetSelectedState("normal")

				local var_609_1 = arg_606_1:FormatText(arg_606_1:GetWordFromCfg(417221140).content)

				arg_606_1.text_.text = var_609_1

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_3 = 44 <= 0 and var_609_0 or var_609_0 * (utf8.len(var_609_1) / 44)

				if (44 <= 0 and var_609_0 or var_609_0 * (utf8.len(var_609_1) / 44)) > 0 and var_609_0 < var_609_3 then
					arg_606_1.talkMaxDuration = var_609_3

					if var_609_3 + 0 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_3 + 0
					end
				end

				arg_606_1.text_.text = var_609_1
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)
				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_4 = math.max(var_609_0, arg_606_1.talkMaxDuration)

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_4 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - 0) / var_609_4

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= 0 + var_609_4 and arg_606_1.time_ < 0 + var_609_4 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {}

		arg_606_1:InitPlayNodeList()
	end,
	Play417221141 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 417221141
		arg_610_1.duration_ = 5.37

		local var_610_0 = {
			zh = 5.366,
			ja = 3.633
		}
		local var_610_1 = manager.audio:GetLocalizationFlag()

		if var_610_0[var_610_1] ~= nil then
			arg_610_1.duration_ = var_610_0[var_610_1]
		end

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play417221142(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			if 0 < arg_610_1.time_ and arg_610_1.time_ <= 0 + arg_613_0 and not isNil(arg_610_1.actors_["10113"]) and arg_610_1.var_.actorSpriteComps10113 == nil then
				arg_610_1.var_.actorSpriteComps10113 = arg_610_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_613_0 = 0.2

			if 0 <= arg_610_1.time_ and arg_610_1.time_ < 0 + var_613_0 and not isNil(arg_610_1.actors_["10113"]) then
				if arg_610_1.var_.actorSpriteComps10113 then
					for iter_613_0, iter_613_1 in pairs(arg_610_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_613_1 then
							if arg_610_1.isInRecall_ then
								iter_613_1.color = Color.New(Mathf.Lerp(iter_613_1.color.r, arg_610_1.hightColor1.r, (arg_610_1.time_ - 0) / var_613_0), Mathf.Lerp(iter_613_1.color.g, arg_610_1.hightColor1.g, (arg_610_1.time_ - 0) / var_613_0), (Mathf.Lerp(iter_613_1.color.b, arg_610_1.hightColor1.b, (arg_610_1.time_ - 0) / var_613_0)))
							else
								local var_613_1 = Mathf.Lerp(iter_613_1.color.r, 1, (arg_610_1.time_ - 0) / var_613_0)

								iter_613_1.color = Color.New(var_613_1, var_613_1, var_613_1)
							end
						end
					end
				end
			end

			if arg_610_1.time_ >= 0 + var_613_0 and arg_610_1.time_ < 0 + var_613_0 + arg_613_0 and not isNil(arg_610_1.actors_["10113"]) and arg_610_1.var_.actorSpriteComps10113 then
				for iter_613_2, iter_613_3 in pairs(arg_610_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_613_3 then
						iter_613_3.color = arg_610_1.isInRecall_ and (arg_610_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_610_1.var_.actorSpriteComps10113 = nil
			end

			local var_613_2 = arg_610_1.actors_["10113"].transform

			if 0 < arg_610_1.time_ and arg_610_1.time_ <= 0 + arg_613_0 then
				arg_610_1.var_.moveOldPos10113 = var_613_2.localPosition
				var_613_2.localScale = Vector3.New(1, 1, 1)

				arg_610_1:CheckSpriteTmpPos("10113", 3)

				for iter_613_4 = 0, var_613_2.childCount - 1 do
					local var_613_3 = var_613_2:GetChild(iter_613_4)

					if var_613_3.name == "split_2" or not string.find(var_613_3.name, "split") then
						var_613_3.gameObject:SetActive(true)
					else
						var_613_3.gameObject:SetActive(false)
					end
				end
			end

			local var_613_4 = 0.001

			if 0 <= arg_610_1.time_ and arg_610_1.time_ < 0 + var_613_4 then
				var_613_2.localPosition = Vector3.Lerp(arg_610_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_610_1.time_ - 0) / var_613_4)
			end

			if arg_610_1.time_ >= 0 + var_613_4 and arg_610_1.time_ < 0 + var_613_4 + arg_613_0 then
				var_613_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_613_5 = 0
			local var_613_6 = 0.325

			if 0 < arg_610_1.time_ and arg_610_1.time_ <= var_613_5 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, true)

				arg_610_1.leftNameTxt_.text = arg_610_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_610_1.leftNameTxt_.transform)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1.leftNameTxt_.text)
				SetActive(arg_610_1.iconTrs_.gameObject, false)
				arg_610_1.callingController_:SetSelectedState("normal")

				local var_613_7 = arg_610_1:GetWordFromCfg(417221141)
				local var_613_8 = arg_610_1:FormatText(var_613_7.content)

				arg_610_1.text_.text = var_613_8

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_10 = 13 <= 0 and var_613_6 or var_613_6 * (utf8.len(var_613_8) / 13)

				if (13 <= 0 and var_613_6 or var_613_6 * (utf8.len(var_613_8) / 13)) > 0 and var_613_6 < var_613_10 then
					arg_610_1.talkMaxDuration = var_613_10

					if var_613_10 + var_613_5 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_10 + var_613_5
					end
				end

				arg_610_1.text_.text = var_613_8
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221141", "story_v_out_417221.awb") ~= 0 then
					local var_613_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221141", "story_v_out_417221.awb") / 1000

					if var_613_11 + var_613_5 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_11 + var_613_5
					end

					if var_613_7.prefab_name ~= "" and arg_610_1.actors_[var_613_7.prefab_name] ~= nil then
						local var_613_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_610_1.actors_[var_613_7.prefab_name].transform, "story_v_out_417221", "417221141", "story_v_out_417221.awb")

						arg_610_1:RecordAudio("417221141", var_613_12)
						arg_610_1:RecordAudio("417221141", var_613_12)
					else
						arg_610_1:AudioAction("play", "voice", "story_v_out_417221", "417221141", "story_v_out_417221.awb")
					end

					arg_610_1:RecordHistoryTalkVoice("story_v_out_417221", "417221141", "story_v_out_417221.awb")
				end

				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_13 = math.max(var_613_6, arg_610_1.talkMaxDuration)

			if var_613_5 <= arg_610_1.time_ and arg_610_1.time_ < var_613_5 + var_613_13 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - var_613_5) / var_613_13

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= var_613_5 + var_613_13 and arg_610_1.time_ < var_613_5 + var_613_13 + arg_613_0 then
				arg_610_1.typewritter.percent = 1

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(true)
			end
		end

		arg_610_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_610_1:InitPlayNodeList()
	end,
	Play417221142 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 417221142
		arg_614_1.duration_ = 9.17

		local var_614_0 = {
			zh = 8.6,
			ja = 9.166
		}
		local var_614_1 = manager.audio:GetLocalizationFlag()

		if var_614_0[var_614_1] ~= nil then
			arg_614_1.duration_ = var_614_0[var_614_1]
		end

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play417221143(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			local var_617_0 = 0.8

			if 0 < arg_614_1.time_ and arg_614_1.time_ <= 0 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0
				arg_614_1.dialogCg_.alpha = 1

				arg_614_1.dialog_:SetActive(true)
				SetActive(arg_614_1.leftNameGo_, true)

				arg_614_1.leftNameTxt_.text = arg_614_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_614_1.leftNameTxt_.transform)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1.leftNameTxt_.text)
				SetActive(arg_614_1.iconTrs_.gameObject, false)
				arg_614_1.callingController_:SetSelectedState("normal")

				local var_617_1 = arg_614_1:GetWordFromCfg(417221142)
				local var_617_2 = arg_614_1:FormatText(var_617_1.content)

				arg_614_1.text_.text = var_617_2

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_4 = 32 <= 0 and var_617_0 or var_617_0 * (utf8.len(var_617_2) / 32)

				if (32 <= 0 and var_617_0 or var_617_0 * (utf8.len(var_617_2) / 32)) > 0 and var_617_0 < var_617_4 then
					arg_614_1.talkMaxDuration = var_617_4

					if var_617_4 + 0 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_4 + 0
					end
				end

				arg_614_1.text_.text = var_617_2
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221142", "story_v_out_417221.awb") ~= 0 then
					local var_617_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221142", "story_v_out_417221.awb") / 1000

					if var_617_5 + 0 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_5 + 0
					end

					if var_617_1.prefab_name ~= "" and arg_614_1.actors_[var_617_1.prefab_name] ~= nil then
						local var_617_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_614_1.actors_[var_617_1.prefab_name].transform, "story_v_out_417221", "417221142", "story_v_out_417221.awb")

						arg_614_1:RecordAudio("417221142", var_617_6)
						arg_614_1:RecordAudio("417221142", var_617_6)
					else
						arg_614_1:AudioAction("play", "voice", "story_v_out_417221", "417221142", "story_v_out_417221.awb")
					end

					arg_614_1:RecordHistoryTalkVoice("story_v_out_417221", "417221142", "story_v_out_417221.awb")
				end

				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_7 = math.max(var_617_0, arg_614_1.talkMaxDuration)

			if 0 <= arg_614_1.time_ and arg_614_1.time_ < 0 + var_617_7 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - 0) / var_617_7

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= 0 + var_617_7 and arg_614_1.time_ < 0 + var_617_7 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {}

		arg_614_1:InitPlayNodeList()
	end,
	Play417221143 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 417221143
		arg_618_1.duration_ = 10.9

		local var_618_0 = {
			zh = 10.9,
			ja = 10.033
		}
		local var_618_1 = manager.audio:GetLocalizationFlag()

		if var_618_0[var_618_1] ~= nil then
			arg_618_1.duration_ = var_618_0[var_618_1]
		end

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play417221144(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			local var_621_0 = 1.125

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, true)

				arg_618_1.leftNameTxt_.text = arg_618_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, false)
				arg_618_1.callingController_:SetSelectedState("normal")

				local var_621_1 = arg_618_1:GetWordFromCfg(417221143)
				local var_621_2 = arg_618_1:FormatText(var_621_1.content)

				arg_618_1.text_.text = var_621_2

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_4 = 45 <= 0 and var_621_0 or var_621_0 * (utf8.len(var_621_2) / 45)

				if (45 <= 0 and var_621_0 or var_621_0 * (utf8.len(var_621_2) / 45)) > 0 and var_621_0 < var_621_4 then
					arg_618_1.talkMaxDuration = var_621_4

					if var_621_4 + 0 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_4 + 0
					end
				end

				arg_618_1.text_.text = var_621_2
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221143", "story_v_out_417221.awb") ~= 0 then
					local var_621_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221143", "story_v_out_417221.awb") / 1000

					if var_621_5 + 0 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_5 + 0
					end

					if var_621_1.prefab_name ~= "" and arg_618_1.actors_[var_621_1.prefab_name] ~= nil then
						local var_621_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_618_1.actors_[var_621_1.prefab_name].transform, "story_v_out_417221", "417221143", "story_v_out_417221.awb")

						arg_618_1:RecordAudio("417221143", var_621_6)
						arg_618_1:RecordAudio("417221143", var_621_6)
					else
						arg_618_1:AudioAction("play", "voice", "story_v_out_417221", "417221143", "story_v_out_417221.awb")
					end

					arg_618_1:RecordHistoryTalkVoice("story_v_out_417221", "417221143", "story_v_out_417221.awb")
				end

				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_7 = math.max(var_621_0, arg_618_1.talkMaxDuration)

			if 0 <= arg_618_1.time_ and arg_618_1.time_ < 0 + var_621_7 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - 0) / var_621_7

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= 0 + var_621_7 and arg_618_1.time_ < 0 + var_621_7 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {}

		arg_618_1:InitPlayNodeList()
	end,
	Play417221144 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 417221144
		arg_622_1.duration_ = 8.63

		local var_622_0 = {
			zh = 7.9,
			ja = 8.633
		}
		local var_622_1 = manager.audio:GetLocalizationFlag()

		if var_622_0[var_622_1] ~= nil then
			arg_622_1.duration_ = var_622_0[var_622_1]
		end

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play417221145(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = 0.775

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				arg_622_1.leftNameTxt_.text = arg_622_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, false)
				arg_622_1.callingController_:SetSelectedState("normal")

				local var_625_1 = arg_622_1:GetWordFromCfg(417221144)
				local var_625_2 = arg_622_1:FormatText(var_625_1.content)

				arg_622_1.text_.text = var_625_2

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_4 = 31 <= 0 and var_625_0 or var_625_0 * (utf8.len(var_625_2) / 31)

				if (31 <= 0 and var_625_0 or var_625_0 * (utf8.len(var_625_2) / 31)) > 0 and var_625_0 < var_625_4 then
					arg_622_1.talkMaxDuration = var_625_4

					if var_625_4 + 0 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_4 + 0
					end
				end

				arg_622_1.text_.text = var_625_2
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221144", "story_v_out_417221.awb") ~= 0 then
					local var_625_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221144", "story_v_out_417221.awb") / 1000

					if var_625_5 + 0 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_5 + 0
					end

					if var_625_1.prefab_name ~= "" and arg_622_1.actors_[var_625_1.prefab_name] ~= nil then
						local var_625_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_622_1.actors_[var_625_1.prefab_name].transform, "story_v_out_417221", "417221144", "story_v_out_417221.awb")

						arg_622_1:RecordAudio("417221144", var_625_6)
						arg_622_1:RecordAudio("417221144", var_625_6)
					else
						arg_622_1:AudioAction("play", "voice", "story_v_out_417221", "417221144", "story_v_out_417221.awb")
					end

					arg_622_1:RecordHistoryTalkVoice("story_v_out_417221", "417221144", "story_v_out_417221.awb")
				end

				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_7 = math.max(var_625_0, arg_622_1.talkMaxDuration)

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_7 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - 0) / var_625_7

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= 0 + var_625_7 and arg_622_1.time_ < 0 + var_625_7 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {}

		arg_622_1:InitPlayNodeList()
	end,
	Play417221145 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 417221145
		arg_626_1.duration_ = 11.6

		local var_626_0 = {
			zh = 11.066,
			ja = 11.6
		}
		local var_626_1 = manager.audio:GetLocalizationFlag()

		if var_626_0[var_626_1] ~= nil then
			arg_626_1.duration_ = var_626_0[var_626_1]
		end

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play417221146(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			local var_629_0 = 1.1

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, true)

				arg_626_1.leftNameTxt_.text = arg_626_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_1 = arg_626_1:GetWordFromCfg(417221145)
				local var_629_2 = arg_626_1:FormatText(var_629_1.content)

				arg_626_1.text_.text = var_629_2

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_4 = 44 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_2) / 44)

				if (44 <= 0 and var_629_0 or var_629_0 * (utf8.len(var_629_2) / 44)) > 0 and var_629_0 < var_629_4 then
					arg_626_1.talkMaxDuration = var_629_4

					if var_629_4 + 0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_4 + 0
					end
				end

				arg_626_1.text_.text = var_629_2
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221145", "story_v_out_417221.awb") ~= 0 then
					local var_629_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221145", "story_v_out_417221.awb") / 1000

					if var_629_5 + 0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_5 + 0
					end

					if var_629_1.prefab_name ~= "" and arg_626_1.actors_[var_629_1.prefab_name] ~= nil then
						local var_629_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_626_1.actors_[var_629_1.prefab_name].transform, "story_v_out_417221", "417221145", "story_v_out_417221.awb")

						arg_626_1:RecordAudio("417221145", var_629_6)
						arg_626_1:RecordAudio("417221145", var_629_6)
					else
						arg_626_1:AudioAction("play", "voice", "story_v_out_417221", "417221145", "story_v_out_417221.awb")
					end

					arg_626_1:RecordHistoryTalkVoice("story_v_out_417221", "417221145", "story_v_out_417221.awb")
				end

				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_7 = math.max(var_629_0, arg_626_1.talkMaxDuration)

			if 0 <= arg_626_1.time_ and arg_626_1.time_ < 0 + var_629_7 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - 0) / var_629_7

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= 0 + var_629_7 and arg_626_1.time_ < 0 + var_629_7 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play417221146 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 417221146
		arg_630_1.duration_ = 7.97

		local var_630_0 = {
			zh = 7.966,
			ja = 7.866
		}
		local var_630_1 = manager.audio:GetLocalizationFlag()

		if var_630_0[var_630_1] ~= nil then
			arg_630_1.duration_ = var_630_0[var_630_1]
		end

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play417221147(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			local var_633_0 = 0.7

			if 0 < arg_630_1.time_ and arg_630_1.time_ <= 0 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, true)

				arg_630_1.leftNameTxt_.text = arg_630_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_630_1.leftNameTxt_.transform)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1.leftNameTxt_.text)
				SetActive(arg_630_1.iconTrs_.gameObject, false)
				arg_630_1.callingController_:SetSelectedState("normal")

				local var_633_1 = arg_630_1:GetWordFromCfg(417221146)
				local var_633_2 = arg_630_1:FormatText(var_633_1.content)

				arg_630_1.text_.text = var_633_2

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_4 = 28 <= 0 and var_633_0 or var_633_0 * (utf8.len(var_633_2) / 28)

				if (28 <= 0 and var_633_0 or var_633_0 * (utf8.len(var_633_2) / 28)) > 0 and var_633_0 < var_633_4 then
					arg_630_1.talkMaxDuration = var_633_4

					if var_633_4 + 0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_4 + 0
					end
				end

				arg_630_1.text_.text = var_633_2
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221146", "story_v_out_417221.awb") ~= 0 then
					local var_633_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221146", "story_v_out_417221.awb") / 1000

					if var_633_5 + 0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_5 + 0
					end

					if var_633_1.prefab_name ~= "" and arg_630_1.actors_[var_633_1.prefab_name] ~= nil then
						local var_633_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_630_1.actors_[var_633_1.prefab_name].transform, "story_v_out_417221", "417221146", "story_v_out_417221.awb")

						arg_630_1:RecordAudio("417221146", var_633_6)
						arg_630_1:RecordAudio("417221146", var_633_6)
					else
						arg_630_1:AudioAction("play", "voice", "story_v_out_417221", "417221146", "story_v_out_417221.awb")
					end

					arg_630_1:RecordHistoryTalkVoice("story_v_out_417221", "417221146", "story_v_out_417221.awb")
				end

				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_7 = math.max(var_633_0, arg_630_1.talkMaxDuration)

			if 0 <= arg_630_1.time_ and arg_630_1.time_ < 0 + var_633_7 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - 0) / var_633_7

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= 0 + var_633_7 and arg_630_1.time_ < 0 + var_633_7 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {}

		arg_630_1:InitPlayNodeList()
	end,
	Play417221147 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 417221147
		arg_634_1.duration_ = 10.73

		local var_634_0 = {
			zh = 9.2,
			ja = 10.733
		}
		local var_634_1 = manager.audio:GetLocalizationFlag()

		if var_634_0[var_634_1] ~= nil then
			arg_634_1.duration_ = var_634_0[var_634_1]
		end

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play417221148(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			local var_637_0 = 0.875

			if 0 < arg_634_1.time_ and arg_634_1.time_ <= 0 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				arg_634_1.leftNameTxt_.text = arg_634_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, false)
				arg_634_1.callingController_:SetSelectedState("normal")

				local var_637_1 = arg_634_1:GetWordFromCfg(417221147)
				local var_637_2 = arg_634_1:FormatText(var_637_1.content)

				arg_634_1.text_.text = var_637_2

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_4 = 35 <= 0 and var_637_0 or var_637_0 * (utf8.len(var_637_2) / 35)

				if (35 <= 0 and var_637_0 or var_637_0 * (utf8.len(var_637_2) / 35)) > 0 and var_637_0 < var_637_4 then
					arg_634_1.talkMaxDuration = var_637_4

					if var_637_4 + 0 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_4 + 0
					end
				end

				arg_634_1.text_.text = var_637_2
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221147", "story_v_out_417221.awb") ~= 0 then
					local var_637_5 = manager.audio:GetVoiceLength("story_v_out_417221", "417221147", "story_v_out_417221.awb") / 1000

					if var_637_5 + 0 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_5 + 0
					end

					if var_637_1.prefab_name ~= "" and arg_634_1.actors_[var_637_1.prefab_name] ~= nil then
						local var_637_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_634_1.actors_[var_637_1.prefab_name].transform, "story_v_out_417221", "417221147", "story_v_out_417221.awb")

						arg_634_1:RecordAudio("417221147", var_637_6)
						arg_634_1:RecordAudio("417221147", var_637_6)
					else
						arg_634_1:AudioAction("play", "voice", "story_v_out_417221", "417221147", "story_v_out_417221.awb")
					end

					arg_634_1:RecordHistoryTalkVoice("story_v_out_417221", "417221147", "story_v_out_417221.awb")
				end

				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_7 = math.max(var_637_0, arg_634_1.talkMaxDuration)

			if 0 <= arg_634_1.time_ and arg_634_1.time_ < 0 + var_637_7 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - 0) / var_637_7

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= 0 + var_637_7 and arg_634_1.time_ < 0 + var_637_7 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {}

		arg_634_1:InitPlayNodeList()
	end,
	Play417221148 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 417221148
		arg_638_1.duration_ = 5

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play417221149(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 and not isNil(arg_638_1.actors_["10113"]) and arg_638_1.var_.actorSpriteComps10113 == nil then
				arg_638_1.var_.actorSpriteComps10113 = arg_638_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_641_0 = 0.2

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_0 and not isNil(arg_638_1.actors_["10113"]) then
				if arg_638_1.var_.actorSpriteComps10113 then
					for iter_641_0, iter_641_1 in pairs(arg_638_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_641_1 then
							if arg_638_1.isInRecall_ then
								iter_641_1.color = Color.New(Mathf.Lerp(iter_641_1.color.r, arg_638_1.hightColor2.r, (arg_638_1.time_ - 0) / var_641_0), Mathf.Lerp(iter_641_1.color.g, arg_638_1.hightColor2.g, (arg_638_1.time_ - 0) / var_641_0), (Mathf.Lerp(iter_641_1.color.b, arg_638_1.hightColor2.b, (arg_638_1.time_ - 0) / var_641_0)))
							else
								local var_641_1 = Mathf.Lerp(iter_641_1.color.r, 0.5, (arg_638_1.time_ - 0) / var_641_0)

								iter_641_1.color = Color.New(var_641_1, var_641_1, var_641_1)
							end
						end
					end
				end
			end

			if arg_638_1.time_ >= 0 + var_641_0 and arg_638_1.time_ < 0 + var_641_0 + arg_641_0 and not isNil(arg_638_1.actors_["10113"]) and arg_638_1.var_.actorSpriteComps10113 then
				for iter_641_2, iter_641_3 in pairs(arg_638_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_641_3 then
						iter_641_3.color = arg_638_1.isInRecall_ and (arg_638_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_638_1.var_.actorSpriteComps10113 = nil
			end

			local var_641_2 = arg_638_1.actors_["10113"].transform

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= 0 + arg_641_0 then
				arg_638_1.var_.moveOldPos10113 = var_641_2.localPosition
				var_641_2.localScale = Vector3.New(1, 1, 1)

				arg_638_1:CheckSpriteTmpPos("10113", 7)

				for iter_641_4 = 0, var_641_2.childCount - 1 do
					local var_641_3 = var_641_2:GetChild(iter_641_4)

					if var_641_3.name == "" or not string.find(var_641_3.name, "split") then
						var_641_3.gameObject:SetActive(true)
					else
						var_641_3.gameObject:SetActive(false)
					end
				end
			end

			local var_641_4 = 0.001

			if 0 <= arg_638_1.time_ and arg_638_1.time_ < 0 + var_641_4 then
				var_641_2.localPosition = Vector3.Lerp(arg_638_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_638_1.time_ - 0) / var_641_4)
			end

			if arg_638_1.time_ >= 0 + var_641_4 and arg_638_1.time_ < 0 + var_641_4 + arg_641_0 then
				var_641_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.733333333333333 < arg_638_1.time_ and arg_638_1.time_ <= 0.733333333333333 + arg_641_0 then
				arg_638_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_rush", "")
			end

			local var_641_6 = 0
			local var_641_7 = 0.95

			if 0 < arg_638_1.time_ and arg_638_1.time_ <= var_641_6 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, false)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_638_1.iconTrs_.gameObject, false)
				arg_638_1.callingController_:SetSelectedState("normal")

				local var_641_8 = arg_638_1:FormatText(arg_638_1:GetWordFromCfg(417221148).content)

				arg_638_1.text_.text = var_641_8

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_10 = 38 <= 0 and var_641_7 or var_641_7 * (utf8.len(var_641_8) / 38)

				if (38 <= 0 and var_641_7 or var_641_7 * (utf8.len(var_641_8) / 38)) > 0 and var_641_7 < var_641_10 then
					arg_638_1.talkMaxDuration = var_641_10

					if var_641_10 + var_641_6 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_10 + var_641_6
					end
				end

				arg_638_1.text_.text = var_641_8
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)
				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_11 = math.max(var_641_7, arg_638_1.talkMaxDuration)

			if var_641_6 <= arg_638_1.time_ and arg_638_1.time_ < var_641_6 + var_641_11 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - var_641_6) / var_641_11

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= var_641_6 + var_641_11 and arg_638_1.time_ < var_641_6 + var_641_11 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_638_1:InitPlayNodeList()
	end,
	Play417221149 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 417221149
		arg_642_1.duration_ = 5

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play417221150(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 then
				arg_642_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_hit02", "")
			end

			local var_645_1 = 0
			local var_645_2 = 1.1

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= var_645_1 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, false)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_642_1.iconTrs_.gameObject, false)
				arg_642_1.callingController_:SetSelectedState("normal")

				local var_645_3 = arg_642_1:FormatText(arg_642_1:GetWordFromCfg(417221149).content)

				arg_642_1.text_.text = var_645_3

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_5 = 44 <= 0 and var_645_2 or var_645_2 * (utf8.len(var_645_3) / 44)

				if (44 <= 0 and var_645_2 or var_645_2 * (utf8.len(var_645_3) / 44)) > 0 and var_645_2 < var_645_5 then
					arg_642_1.talkMaxDuration = var_645_5

					if var_645_5 + var_645_1 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_5 + var_645_1
					end
				end

				arg_642_1.text_.text = var_645_3
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)
				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_6 = math.max(var_645_2, arg_642_1.talkMaxDuration)

			if var_645_1 <= arg_642_1.time_ and arg_642_1.time_ < var_645_1 + var_645_6 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - var_645_1) / var_645_6

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= var_645_1 + var_645_6 and arg_642_1.time_ < var_645_1 + var_645_6 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {}

		arg_642_1:InitPlayNodeList()
	end,
	Play417221150 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 417221150
		arg_646_1.duration_ = 6.5

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play417221151(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			local var_649_9002
			local var_649_9001
			local var_649_9000

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_649_0 = 0.5

			if 0 <= arg_646_1.time_ and arg_646_1.time_ < 0 + var_649_0 then
				local var_649_1, var_649_2 = math.modf((arg_646_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_649_2 * 0.13, var_649_2 * 0.13, var_649_2 * 0.13) + arg_646_1.var_.shakeOldPos
			end

			if arg_646_1.time_ >= 0 + var_649_0 and arg_646_1.time_ < 0 + var_649_0 + arg_649_0 then
				manager.ui.mainCamera.transform.localPosition = arg_646_1.var_.shakeOldPos
			end

			local var_649_3 = manager.ui.mainCamera.transform

			if 0.733333333333334 < arg_646_1.time_ and arg_646_1.time_ <= 0.733333333333334 + arg_649_0 then
				arg_646_1.var_.shakeOldPos = var_649_3.localPosition
			end

			local var_649_4 = 0.766666666666666

			if 0.733333333333334 <= arg_646_1.time_ and arg_646_1.time_ < 0.733333333333334 + var_649_4 then
				local var_649_5, var_649_6 = math.modf((arg_646_1.time_ - 0.733333333333334) / 0.066)

				var_649_3.localPosition = Vector3.New(var_649_6 * 0.13, var_649_6 * 0.13, var_649_6 * 0.13) + arg_646_1.var_.shakeOldPos
			end

			if arg_646_1.time_ >= 0.733333333333334 + var_649_4 and arg_646_1.time_ < 0.733333333333334 + var_649_4 + arg_649_0 then
				var_649_3.localPosition = arg_646_1.var_.shakeOldPos
			end

			if 0.6 < arg_646_1.time_ and arg_646_1.time_ <= 0.6 + arg_649_0 then
				local var_649_7 = arg_646_1.var_.effect11501

				if not arg_646_1.var_.effect11501 then
					var_649_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_649_7.name = "11501"
					arg_646_1.var_.effect11501 = var_649_7
				else
					var_649_7.transform:SetParent(var_649_9002)
				end

				var_649_7.transform.localPosition = Vector3.New(-1.22, -0.04, 4.42)
				var_649_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.66666666666667 < arg_646_1.time_ and arg_646_1.time_ <= 1.66666666666667 + arg_649_0 then
				if arg_646_1.var_.effect11501 then
					Object.Destroy(arg_646_1.var_.effect11501)

					arg_646_1.var_.effect11501 = nil
				end
			end

			if 0.866666666666667 < arg_646_1.time_ and arg_646_1.time_ <= 0.866666666666667 + arg_649_0 then
				local var_649_10 = arg_646_1.var_.effect11502

				if not arg_646_1.var_.effect11502 then
					var_649_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_649_10.name = "11502"
					arg_646_1.var_.effect11502 = var_649_10
				else
					var_649_10.transform:SetParent(var_649_9001)
				end

				var_649_10.transform.localPosition = Vector3.New(0.61, -0.17, 1.42)
				var_649_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.66666666666667 < arg_646_1.time_ and arg_646_1.time_ <= 1.66666666666667 + arg_649_0 then
				if arg_646_1.var_.effect11502 then
					Object.Destroy(arg_646_1.var_.effect11502)

					arg_646_1.var_.effect11502 = nil
				end
			end

			if 1.1 < arg_646_1.time_ and arg_646_1.time_ <= 1.1 + arg_649_0 then
				local var_649_13 = arg_646_1.var_.effect11503

				if not arg_646_1.var_.effect11503 then
					var_649_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_649_13.name = "11503"
					arg_646_1.var_.effect11503 = var_649_13
				else
					var_649_13.transform:SetParent(var_649_9000)
				end

				var_649_13.transform.localPosition = Vector3.New(0, -0.17, 1.42)
				var_649_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.66666666666667 < arg_646_1.time_ and arg_646_1.time_ <= 1.66666666666667 + arg_649_0 then
				if arg_646_1.var_.effect11503 then
					Object.Destroy(arg_646_1.var_.effect11503)

					arg_646_1.var_.effect11503 = nil
				end
			end

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_machinegun", "")
			end

			if arg_646_1.frameCnt_ <= 1 then
				arg_646_1.dialog_:SetActive(false)
			end

			local var_649_17 = 1.5
			local var_649_18 = 1.775

			if 1.5 < arg_646_1.time_ and arg_646_1.time_ <= var_649_17 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0

				arg_646_1.dialog_:SetActive(true)

				arg_646_1.dialogCg_.alpha = 0

				local var_649_19 = LeanTween.value(arg_646_1.dialog_, 0, 1, 0.3)

				var_649_19:setOnUpdate(LuaHelper.FloatAction(function(arg_650_0)
					arg_646_1.dialogCg_.alpha = arg_650_0
				end))
				var_649_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_646_1.dialog_)
					var_649_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_646_1.duration_ = arg_646_1.duration_ + 0.3

				SetActive(arg_646_1.leftNameGo_, false)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_20 = arg_646_1:FormatText(arg_646_1:GetWordFromCfg(417221150).content)

				arg_646_1.text_.text = var_649_20

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_22 = 71 <= 0 and var_649_18 or var_649_18 * (utf8.len(var_649_20) / 71)

				if (71 <= 0 and var_649_18 or var_649_18 * (utf8.len(var_649_20) / 71)) > 0 and var_649_18 < var_649_22 then
					arg_646_1.talkMaxDuration = var_649_22
					var_649_17 = var_649_17 + 0.3

					if var_649_22 + var_649_17 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_22 + var_649_17
					end
				end

				arg_646_1.text_.text = var_649_20
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)
				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_23 = var_649_17 + 0.3
			local var_649_24 = math.max(var_649_18, arg_646_1.talkMaxDuration)

			if var_649_17 + 0.3 <= arg_646_1.time_ and arg_646_1.time_ < var_649_23 + var_649_24 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_23) / var_649_24

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_23 + var_649_24 and arg_646_1.time_ < var_649_23 + var_649_24 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {}

		arg_646_1:InitPlayNodeList()
	end,
	Play417221151 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 417221151
		arg_652_1.duration_ = 5

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play417221152(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = 1.25

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, false)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_1 = arg_652_1:FormatText(arg_652_1:GetWordFromCfg(417221151).content)

				arg_652_1.text_.text = var_655_1

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_3 = 50 <= 0 and var_655_0 or var_655_0 * (utf8.len(var_655_1) / 50)

				if (50 <= 0 and var_655_0 or var_655_0 * (utf8.len(var_655_1) / 50)) > 0 and var_655_0 < var_655_3 then
					arg_652_1.talkMaxDuration = var_655_3

					if var_655_3 + 0 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_3 + 0
					end
				end

				arg_652_1.text_.text = var_655_1
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)
				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_4 = math.max(var_655_0, arg_652_1.talkMaxDuration)

			if 0 <= arg_652_1.time_ and arg_652_1.time_ < 0 + var_655_4 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - 0) / var_655_4

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= 0 + var_655_4 and arg_652_1.time_ < 0 + var_655_4 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play417221152 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 417221152
		arg_656_1.duration_ = 5.9

		local var_656_0 = {
			zh = 5.9,
			ja = 5.7
		}
		local var_656_1 = manager.audio:GetLocalizationFlag()

		if var_656_0[var_656_1] ~= nil then
			arg_656_1.duration_ = var_656_0[var_656_1]
		end

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
			arg_656_1.auto_ = false
		end

		function arg_656_1.playNext_(arg_658_0)
			arg_656_1.onStoryFinished_()
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 and not isNil(arg_656_1.actors_["10113"]) and arg_656_1.var_.actorSpriteComps10113 == nil then
				arg_656_1.var_.actorSpriteComps10113 = arg_656_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_659_0 = 0.2

			if 0 <= arg_656_1.time_ and arg_656_1.time_ < 0 + var_659_0 and not isNil(arg_656_1.actors_["10113"]) then
				if arg_656_1.var_.actorSpriteComps10113 then
					for iter_659_0, iter_659_1 in pairs(arg_656_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_659_1 then
							if arg_656_1.isInRecall_ then
								iter_659_1.color = Color.New(Mathf.Lerp(iter_659_1.color.r, arg_656_1.hightColor1.r, (arg_656_1.time_ - 0) / var_659_0), Mathf.Lerp(iter_659_1.color.g, arg_656_1.hightColor1.g, (arg_656_1.time_ - 0) / var_659_0), (Mathf.Lerp(iter_659_1.color.b, arg_656_1.hightColor1.b, (arg_656_1.time_ - 0) / var_659_0)))
							else
								local var_659_1 = Mathf.Lerp(iter_659_1.color.r, 1, (arg_656_1.time_ - 0) / var_659_0)

								iter_659_1.color = Color.New(var_659_1, var_659_1, var_659_1)
							end
						end
					end
				end
			end

			if arg_656_1.time_ >= 0 + var_659_0 and arg_656_1.time_ < 0 + var_659_0 + arg_659_0 and not isNil(arg_656_1.actors_["10113"]) and arg_656_1.var_.actorSpriteComps10113 then
				for iter_659_2, iter_659_3 in pairs(arg_656_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_659_3 then
						iter_659_3.color = arg_656_1.isInRecall_ and (arg_656_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_656_1.var_.actorSpriteComps10113 = nil
			end

			local var_659_2 = arg_656_1.actors_["10113"].transform

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 then
				arg_656_1.var_.moveOldPos10113 = var_659_2.localPosition
				var_659_2.localScale = Vector3.New(1, 1, 1)

				arg_656_1:CheckSpriteTmpPos("10113", 3)

				for iter_659_4 = 0, var_659_2.childCount - 1 do
					local var_659_3 = var_659_2:GetChild(iter_659_4)

					if var_659_3.name == "split_3" or not string.find(var_659_3.name, "split") then
						var_659_3.gameObject:SetActive(true)
					else
						var_659_3.gameObject:SetActive(false)
					end
				end
			end

			local var_659_4 = 0.001

			if 0 <= arg_656_1.time_ and arg_656_1.time_ < 0 + var_659_4 then
				var_659_2.localPosition = Vector3.Lerp(arg_656_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_656_1.time_ - 0) / var_659_4)
			end

			if arg_656_1.time_ >= 0 + var_659_4 and arg_656_1.time_ < 0 + var_659_4 + arg_659_0 then
				var_659_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_659_5 = 0
			local var_659_6 = 0.4

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_5 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				arg_656_1.leftNameTxt_.text = arg_656_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_7 = arg_656_1:GetWordFromCfg(417221152)
				local var_659_8 = arg_656_1:FormatText(var_659_7.content)

				arg_656_1.text_.text = var_659_8

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_10 = 16 <= 0 and var_659_6 or var_659_6 * (utf8.len(var_659_8) / 16)

				if (16 <= 0 and var_659_6 or var_659_6 * (utf8.len(var_659_8) / 16)) > 0 and var_659_6 < var_659_10 then
					arg_656_1.talkMaxDuration = var_659_10

					if var_659_10 + var_659_5 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_10 + var_659_5
					end
				end

				arg_656_1.text_.text = var_659_8
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417221", "417221152", "story_v_out_417221.awb") ~= 0 then
					local var_659_11 = manager.audio:GetVoiceLength("story_v_out_417221", "417221152", "story_v_out_417221.awb") / 1000

					if var_659_11 + var_659_5 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_11 + var_659_5
					end

					if var_659_7.prefab_name ~= "" and arg_656_1.actors_[var_659_7.prefab_name] ~= nil then
						local var_659_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_656_1.actors_[var_659_7.prefab_name].transform, "story_v_out_417221", "417221152", "story_v_out_417221.awb")

						arg_656_1:RecordAudio("417221152", var_659_12)
						arg_656_1:RecordAudio("417221152", var_659_12)
					else
						arg_656_1:AudioAction("play", "voice", "story_v_out_417221", "417221152", "story_v_out_417221.awb")
					end

					arg_656_1:RecordHistoryTalkVoice("story_v_out_417221", "417221152", "story_v_out_417221.awb")
				end

				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_13 = math.max(var_659_6, arg_656_1.talkMaxDuration)

			if var_659_5 <= arg_656_1.time_ and arg_656_1.time_ < var_659_5 + var_659_13 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_5) / var_659_13

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_5 + var_659_13 and arg_656_1.time_ < var_659_5 + var_659_13 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10113",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_656_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I16f",
		"TextureConfig/Background/ST69",
		"TextureConfig/Background/I05e",
		"TextureConfig/Background/ST2106",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I07a",
		"TextureConfig/Background/ST73",
		"TextureConfig/Background/ST2104"
	},
	voices = {
		"story_v_out_417221.awb"
	}
}
