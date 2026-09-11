return {
	Play417231001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417231001
		arg_1_1.duration_ = 10.27

		local var_1_0 = {
			zh = 9.766,
			ja = 10.266
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
				arg_1_0:Play417231002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 7.4 < arg_1_1.time_ and arg_1_1.time_ <= 7.4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 7.4 + 0.0999999999999996 and arg_1_1.time_ < 7.4 + 0.0999999999999996 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST75")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501069).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501070).content)

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
				arg_1_1.mask_.raycastTarget = true

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

			local var_4_9 = "ST75"

			if arg_1_1.bgs_.ST75 == nil then
				local var_4_10 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_9)
				var_4_10.name = var_4_9
				var_4_10.transform.parent = arg_1_1.stage_.transform
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_9] = var_4_10
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_11 = arg_1_1.bgs_.ST75

				arg_1_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = 2 * (var_4_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_11.transform.localScale = Vector3.New(var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST75" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_14 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_14 + 5 and arg_1_1.time_ < var_4_14 + 5 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_15 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_16 = 1

			if var_4_15 <= arg_1_1.time_ and arg_1_1.time_ < var_4_15 + var_4_16 then
				local var_4_17 = Color.New(0, 0, 0)

				var_4_17.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_15) / var_4_16)
				arg_1_1.mask_.color = var_4_17
			end

			if arg_1_1.time_ >= var_4_15 + var_4_16 and arg_1_1.time_ < var_4_15 + var_4_16 + arg_4_0 then
				local var_4_18 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_18.a = 0
				arg_1_1.mask_.color = var_4_18
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			if 5.7 < arg_1_1.time_ and arg_1_1.time_ <= 5.7 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
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

			if 5.7 < arg_1_1.time_ and arg_1_1.time_ <= 5.7 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_truck_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_26 = 7.4
			local var_4_27 = 0.175

			if 7.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_28 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_28:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_29 = arg_1_1:GetWordFromCfg(417231001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 7 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 7)

				if (7 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 7)) > 0 and var_4_27 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32
					var_4_26 = var_4_26 + 0.3

					if var_4_32 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_26
					end
				end

				arg_1_1.text_.text = var_4_30
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231001", "story_v_out_417231.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_417231", "417231001", "story_v_out_417231.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_417231", "417231001", "story_v_out_417231.awb")

						arg_1_1:RecordAudio("417231001", var_4_34)
						arg_1_1:RecordAudio("417231001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417231", "417231001", "story_v_out_417231.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417231", "417231001", "story_v_out_417231.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_35 = var_4_26 + 0.3
			local var_4_36 = math.max(var_4_27, arg_1_1.talkMaxDuration)

			if var_4_26 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_35) / var_4_36

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417231002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417231002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417231003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_ui", "")
			end

			local var_13_1 = 0
			local var_13_2 = 0.7

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_3 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(417231002).content)

				arg_10_1.text_.text = var_13_3

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_5 = 28 <= 0 and var_13_2 or var_13_2 * (utf8.len(var_13_3) / 28)

				if (28 <= 0 and var_13_2 or var_13_2 * (utf8.len(var_13_3) / 28)) > 0 and var_13_2 < var_13_5 then
					arg_10_1.talkMaxDuration = var_13_5

					if var_13_5 + var_13_1 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_5 + var_13_1
					end
				end

				arg_10_1.text_.text = var_13_3
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_6 = math.max(var_13_2, arg_10_1.talkMaxDuration)

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_6 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_1) / var_13_6

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_1 + var_13_6 and arg_10_1.time_ < var_13_1 + var_13_6 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417231003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417231003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417231004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 1.425

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

				local var_17_1 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(417231003).content)

				arg_14_1.text_.text = var_17_1

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_3 = 57 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 57)

				if (57 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 57)) > 0 and var_17_0 < var_17_3 then
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
	Play417231004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417231004
		arg_18_1.duration_ = 9.5

		local var_18_0 = {
			zh = 5.2,
			ja = 9.5
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
				arg_18_0:Play417231005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.575

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_1 = arg_18_1:GetWordFromCfg(417231004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 23 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 23)

				if (23 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 23)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231004", "story_v_out_417231.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231004", "story_v_out_417231.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_out_417231", "417231004", "story_v_out_417231.awb")

						arg_18_1:RecordAudio("417231004", var_21_6)
						arg_18_1:RecordAudio("417231004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417231", "417231004", "story_v_out_417231.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417231", "417231004", "story_v_out_417231.awb")
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
	Play417231005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417231005
		arg_22_1.duration_ = 9.7

		local var_22_0 = {
			zh = 6.833,
			ja = 9.7
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
				arg_22_0:Play417231006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.875

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_1 = arg_22_1:GetWordFromCfg(417231005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 35 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 35)

				if (35 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 35)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231005", "story_v_out_417231.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231005", "story_v_out_417231.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_417231", "417231005", "story_v_out_417231.awb")

						arg_22_1:RecordAudio("417231005", var_25_6)
						arg_22_1:RecordAudio("417231005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417231", "417231005", "story_v_out_417231.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417231", "417231005", "story_v_out_417231.awb")
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
	Play417231006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417231006
		arg_26_1.duration_ = 4.57

		local var_26_0 = {
			zh = 2.566,
			ja = 4.566
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
				arg_26_0:Play417231007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if arg_26_1.actors_["10128"] == nil then
				local var_29_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_29_0) then
					local var_29_1 = Object.Instantiate(var_29_0, arg_26_1.canvasGo_.transform)

					var_29_1.transform:SetSiblingIndex(1)

					var_29_1.name = "10128"
					var_29_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_26_1.actors_["10128"] = var_29_1

					if arg_26_1.isInRecall_ then
						for iter_29_0, iter_29_1 in ipairs((var_29_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_29_1.color = arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_29_2 = arg_26_1.actors_["10128"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.actorSpriteComps10128 == nil then
				arg_26_1.var_.actorSpriteComps10128 = var_29_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_29_3 = 0.2

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_3 and not isNil(var_29_2) then
				if arg_26_1.var_.actorSpriteComps10128 then
					for iter_29_2, iter_29_3 in pairs(arg_26_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_29_3 then
							if arg_26_1.isInRecall_ then
								iter_29_3.color = Color.New(Mathf.Lerp(iter_29_3.color.r, arg_26_1.hightColor1.r, (arg_26_1.time_ - 0) / var_29_3), Mathf.Lerp(iter_29_3.color.g, arg_26_1.hightColor1.g, (arg_26_1.time_ - 0) / var_29_3), (Mathf.Lerp(iter_29_3.color.b, arg_26_1.hightColor1.b, (arg_26_1.time_ - 0) / var_29_3)))
							else
								local var_29_4 = Mathf.Lerp(iter_29_3.color.r, 1, (arg_26_1.time_ - 0) / var_29_3)

								iter_29_3.color = Color.New(var_29_4, var_29_4, var_29_4)
							end
						end
					end
				end
			end

			if arg_26_1.time_ >= 0 + var_29_3 and arg_26_1.time_ < 0 + var_29_3 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.actorSpriteComps10128 then
				for iter_29_4, iter_29_5 in pairs(arg_26_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_29_5 then
						iter_29_5.color = arg_26_1.isInRecall_ and (arg_26_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_26_1.var_.actorSpriteComps10128 = nil
			end

			local var_29_5 = arg_26_1.actors_["10128"].transform

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos10128 = var_29_5.localPosition
				var_29_5.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("10128", 3)

				for iter_29_6 = 0, var_29_5.childCount - 1 do
					local var_29_6 = var_29_5:GetChild(iter_29_6)

					if var_29_6.name == "" or not string.find(var_29_6.name, "split") then
						var_29_6.gameObject:SetActive(true)
					else
						var_29_6.gameObject:SetActive(false)
					end
				end
			end

			local var_29_7 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				var_29_5.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_26_1.time_ - 0) / var_29_7)
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				var_29_5.localPosition = Vector3.New(0, -347, -300)
			end

			local var_29_8 = 0
			local var_29_9 = 0.325

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_8 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_10 = arg_26_1:GetWordFromCfg(417231006)
				local var_29_11 = arg_26_1:FormatText(var_29_10.content)

				arg_26_1.text_.text = var_29_11

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_13 = 13 <= 0 and var_29_9 or var_29_9 * (utf8.len(var_29_11) / 13)

				if (13 <= 0 and var_29_9 or var_29_9 * (utf8.len(var_29_11) / 13)) > 0 and var_29_9 < var_29_13 then
					arg_26_1.talkMaxDuration = var_29_13

					if var_29_13 + var_29_8 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_13 + var_29_8
					end
				end

				arg_26_1.text_.text = var_29_11
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231006", "story_v_out_417231.awb") ~= 0 then
					local var_29_14 = manager.audio:GetVoiceLength("story_v_out_417231", "417231006", "story_v_out_417231.awb") / 1000

					if var_29_14 + var_29_8 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_14 + var_29_8
					end

					if var_29_10.prefab_name ~= "" and arg_26_1.actors_[var_29_10.prefab_name] ~= nil then
						local var_29_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_10.prefab_name].transform, "story_v_out_417231", "417231006", "story_v_out_417231.awb")

						arg_26_1:RecordAudio("417231006", var_29_15)
						arg_26_1:RecordAudio("417231006", var_29_15)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417231", "417231006", "story_v_out_417231.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417231", "417231006", "story_v_out_417231.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_16 = math.max(var_29_9, arg_26_1.talkMaxDuration)

			if var_29_8 <= arg_26_1.time_ and arg_26_1.time_ < var_29_8 + var_29_16 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_8) / var_29_16

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_8 + var_29_16 and arg_26_1.time_ < var_29_8 + var_29_16 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
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

		arg_26_1:InitPlayNodeList()
	end,
	Play417231007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417231007
		arg_30_1.duration_ = 5.13

		local var_30_0 = {
			zh = 5.1,
			ja = 5.133
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
				arg_30_0:Play417231008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["10128"]) and arg_30_1.var_.actorSpriteComps10128 == nil then
				arg_30_1.var_.actorSpriteComps10128 = arg_30_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["10128"]) then
				if arg_30_1.var_.actorSpriteComps10128 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_33_1 then
							if arg_30_1.isInRecall_ then
								iter_33_1.color = Color.New(Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor2.r, (arg_30_1.time_ - 0) / var_33_0), Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor2.g, (arg_30_1.time_ - 0) / var_33_0), (Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor2.b, (arg_30_1.time_ - 0) / var_33_0)))
							else
								local var_33_1 = Mathf.Lerp(iter_33_1.color.r, 0.5, (arg_30_1.time_ - 0) / var_33_0)

								iter_33_1.color = Color.New(var_33_1, var_33_1, var_33_1)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["10128"]) and arg_30_1.var_.actorSpriteComps10128 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_30_1.var_.actorSpriteComps10128 = nil
			end

			local var_33_2 = 0
			local var_33_3 = 0.575

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_4 = arg_30_1:GetWordFromCfg(417231007)
				local var_33_5 = arg_30_1:FormatText(var_33_4.content)

				arg_30_1.text_.text = var_33_5

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_7 = 23 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 23)

				if (23 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_5) / 23)) > 0 and var_33_3 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_2
					end
				end

				arg_30_1.text_.text = var_33_5
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231007", "story_v_out_417231.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231007", "story_v_out_417231.awb") / 1000

					if var_33_8 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_2
					end

					if var_33_4.prefab_name ~= "" and arg_30_1.actors_[var_33_4.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_4.prefab_name].transform, "story_v_out_417231", "417231007", "story_v_out_417231.awb")

						arg_30_1:RecordAudio("417231007", var_33_9)
						arg_30_1:RecordAudio("417231007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417231", "417231007", "story_v_out_417231.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417231", "417231007", "story_v_out_417231.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_3, arg_30_1.talkMaxDuration)

			if var_33_2 <= arg_30_1.time_ and arg_30_1.time_ < var_33_2 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_2) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_2 + var_33_10 and arg_30_1.time_ < var_33_2 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play417231008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417231008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417231009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos10128 = arg_34_1.actors_["10128"].transform.localPosition
				arg_34_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("10128", 7)

				for iter_37_0 = 0, arg_34_1.actors_["10128"].transform.childCount - 1 do
					local var_37_0 = arg_34_1.actors_["10128"].transform:GetChild(iter_37_0)

					if var_37_0.name == "" or not string.find(var_37_0.name, "split") then
						var_37_0.gameObject:SetActive(true)
					else
						var_37_0.gameObject:SetActive(false)
					end
				end
			end

			local var_37_1 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_1 then
				arg_34_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_34_1.time_ - 0) / var_37_1)
			end

			if arg_34_1.time_ >= 0 + var_37_1 and arg_34_1.time_ < 0 + var_37_1 + arg_37_0 then
				arg_34_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_37_2 = 0
			local var_37_3 = 1.325

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_2 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_4 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(417231008).content)

				arg_34_1.text_.text = var_37_4

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_6 = 53 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_4) / 53)

				if (53 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_4) / 53)) > 0 and var_37_3 < var_37_6 then
					arg_34_1.talkMaxDuration = var_37_6

					if var_37_6 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_6 + var_37_2
					end
				end

				arg_34_1.text_.text = var_37_4
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_3, arg_34_1.talkMaxDuration)

			if var_37_2 <= arg_34_1.time_ and arg_34_1.time_ < var_37_2 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_2) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_2 + var_37_7 and arg_34_1.time_ < var_37_2 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
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

		arg_34_1:InitPlayNodeList()
	end,
	Play417231009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417231009
		arg_38_1.duration_ = 11.33

		local var_38_0 = {
			zh = 9.233,
			ja = 11.333
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
				arg_38_0:Play417231010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.85

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_1 = arg_38_1:GetWordFromCfg(417231009)
				local var_41_2 = arg_38_1:FormatText(var_41_1.content)

				arg_38_1.text_.text = var_41_2

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 34 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 34)

				if (34 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 34)) > 0 and var_41_0 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end

				arg_38_1.text_.text = var_41_2
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231009", "story_v_out_417231.awb") ~= 0 then
					local var_41_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231009", "story_v_out_417231.awb") / 1000

					if var_41_5 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + 0
					end

					if var_41_1.prefab_name ~= "" and arg_38_1.actors_[var_41_1.prefab_name] ~= nil then
						local var_41_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_1.prefab_name].transform, "story_v_out_417231", "417231009", "story_v_out_417231.awb")

						arg_38_1:RecordAudio("417231009", var_41_6)
						arg_38_1:RecordAudio("417231009", var_41_6)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417231", "417231009", "story_v_out_417231.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417231", "417231009", "story_v_out_417231.awb")
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
	Play417231010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417231010
		arg_42_1.duration_ = 4.5

		local var_42_0 = {
			zh = 4.333,
			ja = 4.5
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
				arg_42_0:Play417231011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.5

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_1 = arg_42_1:GetWordFromCfg(417231010)
				local var_45_2 = arg_42_1:FormatText(var_45_1.content)

				arg_42_1.text_.text = var_45_2

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_4 = 20 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 20)

				if (20 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_2) / 20)) > 0 and var_45_0 < var_45_4 then
					arg_42_1.talkMaxDuration = var_45_4

					if var_45_4 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_4 + 0
					end
				end

				arg_42_1.text_.text = var_45_2
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231010", "story_v_out_417231.awb") ~= 0 then
					local var_45_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231010", "story_v_out_417231.awb") / 1000

					if var_45_5 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + 0
					end

					if var_45_1.prefab_name ~= "" and arg_42_1.actors_[var_45_1.prefab_name] ~= nil then
						local var_45_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_1.prefab_name].transform, "story_v_out_417231", "417231010", "story_v_out_417231.awb")

						arg_42_1:RecordAudio("417231010", var_45_6)
						arg_42_1:RecordAudio("417231010", var_45_6)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417231", "417231010", "story_v_out_417231.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417231", "417231010", "story_v_out_417231.awb")
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
	Play417231011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417231011
		arg_46_1.duration_ = 6.03

		local var_46_0 = {
			zh = 5,
			ja = 6.033
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
				arg_46_0:Play417231012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["10128"]) and arg_46_1.var_.actorSpriteComps10128 == nil then
				arg_46_1.var_.actorSpriteComps10128 = arg_46_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["10128"]) then
				if arg_46_1.var_.actorSpriteComps10128 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								iter_49_1.color = Color.New(Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor1.r, (arg_46_1.time_ - 0) / var_49_0), Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor1.g, (arg_46_1.time_ - 0) / var_49_0), (Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor1.b, (arg_46_1.time_ - 0) / var_49_0)))
							else
								local var_49_1 = Mathf.Lerp(iter_49_1.color.r, 1, (arg_46_1.time_ - 0) / var_49_0)

								iter_49_1.color = Color.New(var_49_1, var_49_1, var_49_1)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["10128"]) and arg_46_1.var_.actorSpriteComps10128 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_49_3 then
						iter_49_3.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_46_1.var_.actorSpriteComps10128 = nil
			end

			local var_49_2 = arg_46_1.actors_["10128"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos10128 = var_49_2.localPosition
				var_49_2.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("10128", 3)

				for iter_49_4 = 0, var_49_2.childCount - 1 do
					local var_49_3 = var_49_2:GetChild(iter_49_4)

					if var_49_3.name == "" or not string.find(var_49_3.name, "split") then
						var_49_3.gameObject:SetActive(true)
					else
						var_49_3.gameObject:SetActive(false)
					end
				end
			end

			local var_49_4 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				var_49_2.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_46_1.time_ - 0) / var_49_4)
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				var_49_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_49_5 = 0
			local var_49_6 = 0.6

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_7 = arg_46_1:GetWordFromCfg(417231011)
				local var_49_8 = arg_46_1:FormatText(var_49_7.content)

				arg_46_1.text_.text = var_49_8

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_10 = 24 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_8) / 24)

				if (24 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_8) / 24)) > 0 and var_49_6 < var_49_10 then
					arg_46_1.talkMaxDuration = var_49_10

					if var_49_10 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_10 + var_49_5
					end
				end

				arg_46_1.text_.text = var_49_8
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231011", "story_v_out_417231.awb") ~= 0 then
					local var_49_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231011", "story_v_out_417231.awb") / 1000

					if var_49_11 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_11 + var_49_5
					end

					if var_49_7.prefab_name ~= "" and arg_46_1.actors_[var_49_7.prefab_name] ~= nil then
						local var_49_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_7.prefab_name].transform, "story_v_out_417231", "417231011", "story_v_out_417231.awb")

						arg_46_1:RecordAudio("417231011", var_49_12)
						arg_46_1:RecordAudio("417231011", var_49_12)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_417231", "417231011", "story_v_out_417231.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_417231", "417231011", "story_v_out_417231.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_13 = math.max(var_49_6, arg_46_1.talkMaxDuration)

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_13 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_5) / var_49_13

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_5 + var_49_13 and arg_46_1.time_ < var_49_5 + var_49_13 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
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

		arg_46_1:InitPlayNodeList()
	end,
	Play417231012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417231012
		arg_50_1.duration_ = 7.3

		local var_50_0 = {
			zh = 4.633,
			ja = 7.3
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play417231013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["10128"]) and arg_50_1.var_.actorSpriteComps10128 == nil then
				arg_50_1.var_.actorSpriteComps10128 = arg_50_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["10128"]) then
				if arg_50_1.var_.actorSpriteComps10128 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_53_1 then
							if arg_50_1.isInRecall_ then
								iter_53_1.color = Color.New(Mathf.Lerp(iter_53_1.color.r, arg_50_1.hightColor2.r, (arg_50_1.time_ - 0) / var_53_0), Mathf.Lerp(iter_53_1.color.g, arg_50_1.hightColor2.g, (arg_50_1.time_ - 0) / var_53_0), (Mathf.Lerp(iter_53_1.color.b, arg_50_1.hightColor2.b, (arg_50_1.time_ - 0) / var_53_0)))
							else
								local var_53_1 = Mathf.Lerp(iter_53_1.color.r, 0.5, (arg_50_1.time_ - 0) / var_53_0)

								iter_53_1.color = Color.New(var_53_1, var_53_1, var_53_1)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["10128"]) and arg_50_1.var_.actorSpriteComps10128 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_53_3 then
						iter_53_3.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_50_1.var_.actorSpriteComps10128 = nil
			end

			local var_53_2 = 0
			local var_53_3 = 0.475

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_2 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_4 = arg_50_1:GetWordFromCfg(417231012)
				local var_53_5 = arg_50_1:FormatText(var_53_4.content)

				arg_50_1.text_.text = var_53_5

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_7 = 19 <= 0 and var_53_3 or var_53_3 * (utf8.len(var_53_5) / 19)

				if (19 <= 0 and var_53_3 or var_53_3 * (utf8.len(var_53_5) / 19)) > 0 and var_53_3 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_2 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_2
					end
				end

				arg_50_1.text_.text = var_53_5
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231012", "story_v_out_417231.awb") ~= 0 then
					local var_53_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231012", "story_v_out_417231.awb") / 1000

					if var_53_8 + var_53_2 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_8 + var_53_2
					end

					if var_53_4.prefab_name ~= "" and arg_50_1.actors_[var_53_4.prefab_name] ~= nil then
						local var_53_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_4.prefab_name].transform, "story_v_out_417231", "417231012", "story_v_out_417231.awb")

						arg_50_1:RecordAudio("417231012", var_53_9)
						arg_50_1:RecordAudio("417231012", var_53_9)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417231", "417231012", "story_v_out_417231.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417231", "417231012", "story_v_out_417231.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_3, arg_50_1.talkMaxDuration)

			if var_53_2 <= arg_50_1.time_ and arg_50_1.time_ < var_53_2 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_2) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_2 + var_53_10 and arg_50_1.time_ < var_53_2 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play417231013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 417231013
		arg_54_1.duration_ = 15

		local var_54_0 = {
			zh = 11.433,
			ja = 15
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
				arg_54_0:Play417231014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 1.45

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_1 = arg_54_1:GetWordFromCfg(417231013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 58 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 58)

				if (58 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 58)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231013", "story_v_out_417231.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231013", "story_v_out_417231.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_417231", "417231013", "story_v_out_417231.awb")

						arg_54_1:RecordAudio("417231013", var_57_6)
						arg_54_1:RecordAudio("417231013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_417231", "417231013", "story_v_out_417231.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_417231", "417231013", "story_v_out_417231.awb")
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
	Play417231014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 417231014
		arg_58_1.duration_ = 4.13

		local var_58_0 = {
			zh = 3.533,
			ja = 4.133
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play417231015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["10128"]) and arg_58_1.var_.actorSpriteComps10128 == nil then
				arg_58_1.var_.actorSpriteComps10128 = arg_58_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["10128"]) then
				if arg_58_1.var_.actorSpriteComps10128 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								iter_61_1.color = Color.New(Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor1.r, (arg_58_1.time_ - 0) / var_61_0), Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor1.g, (arg_58_1.time_ - 0) / var_61_0), (Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor1.b, (arg_58_1.time_ - 0) / var_61_0)))
							else
								local var_61_1 = Mathf.Lerp(iter_61_1.color.r, 1, (arg_58_1.time_ - 0) / var_61_0)

								iter_61_1.color = Color.New(var_61_1, var_61_1, var_61_1)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["10128"]) and arg_58_1.var_.actorSpriteComps10128 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_58_1.var_.actorSpriteComps10128 = nil
			end

			local var_61_2 = 0
			local var_61_3 = 0.175

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_4 = arg_58_1:GetWordFromCfg(417231014)
				local var_61_5 = arg_58_1:FormatText(var_61_4.content)

				arg_58_1.text_.text = var_61_5

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_7 = 7 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 7)

				if (7 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 7)) > 0 and var_61_3 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_5
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231014", "story_v_out_417231.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231014", "story_v_out_417231.awb") / 1000

					if var_61_8 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_2
					end

					if var_61_4.prefab_name ~= "" and arg_58_1.actors_[var_61_4.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_4.prefab_name].transform, "story_v_out_417231", "417231014", "story_v_out_417231.awb")

						arg_58_1:RecordAudio("417231014", var_61_9)
						arg_58_1:RecordAudio("417231014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_417231", "417231014", "story_v_out_417231.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_417231", "417231014", "story_v_out_417231.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_10 and arg_58_1.time_ < var_61_2 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play417231015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 417231015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play417231016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos10128 = arg_62_1.actors_["10128"].transform.localPosition
				arg_62_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_62_1:CheckSpriteTmpPos("10128", 7)

				for iter_65_0 = 0, arg_62_1.actors_["10128"].transform.childCount - 1 do
					local var_65_0 = arg_62_1.actors_["10128"].transform:GetChild(iter_65_0)

					if var_65_0.name == "" or not string.find(var_65_0.name, "split") then
						var_65_0.gameObject:SetActive(true)
					else
						var_65_0.gameObject:SetActive(false)
					end
				end
			end

			local var_65_1 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_1 then
				arg_62_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_62_1.time_ - 0) / var_65_1)
			end

			if arg_62_1.time_ >= 0 + var_65_1 and arg_62_1.time_ < 0 + var_65_1 + arg_65_0 then
				arg_62_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_65_2 = 0
			local var_65_3 = 1

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_4 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(417231015).content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_6 = 40 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_4) / 40)

				if (40 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_4) / 40)) > 0 and var_65_3 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_3, arg_62_1.talkMaxDuration)

			if var_65_2 <= arg_62_1.time_ and arg_62_1.time_ < var_65_2 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_2) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_2 + var_65_7 and arg_62_1.time_ < var_65_2 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
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

		arg_62_1:InitPlayNodeList()
	end,
	Play417231016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417231016
		arg_66_1.duration_ = 8.2

		local var_66_0 = {
			zh = 6.866,
			ja = 8.2
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
				arg_66_0:Play417231017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if arg_66_1.bgs_.I11l == nil then
				local var_69_0 = Object.Instantiate(arg_66_1.paintGo_)

				var_69_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11l")
				var_69_0.name = "I11l"
				var_69_0.transform.parent = arg_66_1.stage_.transform
				var_69_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.bgs_.I11l = var_69_0
			end

			if 2 < arg_66_1.time_ and arg_66_1.time_ <= 2 + arg_69_0 then
				local var_69_1 = arg_66_1.bgs_.I11l

				arg_66_1.bgs_.I11l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_69_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_2 = var_69_1:GetComponent("SpriteRenderer")

				if var_69_2 and var_69_2.sprite then
					local var_69_3 = 2 * (var_69_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_69_1.transform.localScale = Vector3.New(var_69_3 / var_69_2.sprite.bounds.size.y < var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x and var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x or var_69_3 / var_69_2.sprite.bounds.size.y, var_69_3 / var_69_2.sprite.bounds.size.y < var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x and var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x or var_69_3 / var_69_2.sprite.bounds.size.y, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "I11l" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_4 = 4

			if 4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			if arg_66_1.time_ >= var_69_4 + 0.3 and arg_66_1.time_ < var_69_4 + 0.3 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			local var_69_5 = 0

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_6 = 2

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 then
				local var_69_7 = Color.New(0, 0, 0)

				var_69_7.a = Mathf.Lerp(0, 1, (arg_66_1.time_ - var_69_5) / var_69_6)
				arg_66_1.mask_.color = var_69_7
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 then
				local var_69_8 = Color.New(0, 0, 0)

				var_69_8.a = 1
				arg_66_1.mask_.color = var_69_8
			end

			local var_69_9 = 2

			if 2 < arg_66_1.time_ and arg_66_1.time_ <= var_69_9 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_10 = 2

			if var_69_9 <= arg_66_1.time_ and arg_66_1.time_ < var_69_9 + var_69_10 then
				local var_69_11 = Color.New(0, 0, 0)

				var_69_11.a = Mathf.Lerp(1, 0, (arg_66_1.time_ - var_69_9) / var_69_10)
				arg_66_1.mask_.color = var_69_11
			end

			if arg_66_1.time_ >= var_69_9 + var_69_10 and arg_66_1.time_ < var_69_9 + var_69_10 + arg_69_0 then
				local var_69_12 = Color.New(0, 0, 0)

				arg_66_1.mask_.enabled = false
				var_69_12.a = 0
				arg_66_1.mask_.color = var_69_12
			end

			local var_69_13 = "1034"

			if arg_66_1.actors_["1034"] == nil then
				local var_69_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_69_14) then
					local var_69_15 = Object.Instantiate(var_69_14, arg_66_1.canvasGo_.transform)

					var_69_15.transform:SetSiblingIndex(1)

					var_69_15.name = var_69_13
					var_69_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_66_1.actors_[var_69_13] = var_69_15

					if arg_66_1.isInRecall_ then
						for iter_69_2, iter_69_3 in ipairs((var_69_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_69_3.color = arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_69_16 = arg_66_1.actors_["1034"]

			if 3.66666666666667 < arg_66_1.time_ and arg_66_1.time_ <= 3.66666666666667 + arg_69_0 and not isNil(var_69_16) and arg_66_1.var_.actorSpriteComps1034 == nil then
				arg_66_1.var_.actorSpriteComps1034 = var_69_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_17 = 0.2

			if 3.66666666666667 <= arg_66_1.time_ and arg_66_1.time_ < 3.66666666666667 + var_69_17 and not isNil(var_69_16) then
				if arg_66_1.var_.actorSpriteComps1034 then
					for iter_69_4, iter_69_5 in pairs(arg_66_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_69_5 then
							if arg_66_1.isInRecall_ then
								iter_69_5.color = Color.New(Mathf.Lerp(iter_69_5.color.r, arg_66_1.hightColor1.r, (arg_66_1.time_ - 3.66666666666667) / var_69_17), Mathf.Lerp(iter_69_5.color.g, arg_66_1.hightColor1.g, (arg_66_1.time_ - 3.66666666666667) / var_69_17), (Mathf.Lerp(iter_69_5.color.b, arg_66_1.hightColor1.b, (arg_66_1.time_ - 3.66666666666667) / var_69_17)))
							else
								local var_69_18 = Mathf.Lerp(iter_69_5.color.r, 1, (arg_66_1.time_ - 3.66666666666667) / var_69_17)

								iter_69_5.color = Color.New(var_69_18, var_69_18, var_69_18)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 3.66666666666667 + var_69_17 and arg_66_1.time_ < 3.66666666666667 + var_69_17 + arg_69_0 and not isNil(var_69_16) and arg_66_1.var_.actorSpriteComps1034 then
				for iter_69_6, iter_69_7 in pairs(arg_66_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_69_7 then
						iter_69_7.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_66_1.var_.actorSpriteComps1034 = nil
			end

			local var_69_19 = arg_66_1.actors_["1034"].transform

			if 3.66666666666667 < arg_66_1.time_ and arg_66_1.time_ <= 3.66666666666667 + arg_69_0 then
				arg_66_1.var_.moveOldPos1034 = var_69_19.localPosition
				var_69_19.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("1034", 3)

				for iter_69_8 = 0, var_69_19.childCount - 1 do
					local var_69_20 = var_69_19:GetChild(iter_69_8)

					if var_69_20.name == "split_4" or not string.find(var_69_20.name, "split") then
						var_69_20.gameObject:SetActive(true)
					else
						var_69_20.gameObject:SetActive(false)
					end
				end
			end

			local var_69_21 = 0.001

			if 3.66666666666667 <= arg_66_1.time_ and arg_66_1.time_ < 3.66666666666667 + var_69_21 then
				var_69_19.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_66_1.time_ - 3.66666666666667) / var_69_21)
			end

			if arg_66_1.time_ >= 3.66666666666667 + var_69_21 and arg_66_1.time_ < 3.66666666666667 + var_69_21 + arg_69_0 then
				var_69_19.localPosition = Vector3.New(0, -331.9, -324)
			end

			if 3.66666666666667 < arg_66_1.time_ and arg_66_1.time_ <= 3.66666666666667 + arg_69_0 then
				local var_69_22 = arg_66_1.actors_["1034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_69_22 then
					arg_66_1.var_.alphaOldValue1034 = var_69_22.alpha
					arg_66_1.var_.characterEffect1034 = var_69_22
				end

				arg_66_1.var_.alphaOldValue1034 = 0
			end

			local var_69_23 = 0.333333333333333

			if 3.66666666666667 <= arg_66_1.time_ and arg_66_1.time_ < 3.66666666666667 + var_69_23 then
				if arg_66_1.var_.characterEffect1034 then
					arg_66_1.var_.characterEffect1034.alpha = Mathf.Lerp(arg_66_1.var_.alphaOldValue1034, 1, (arg_66_1.time_ - 3.66666666666667) / var_69_23)
				end
			end

			if arg_66_1.time_ >= 3.66666666666667 + var_69_23 and arg_66_1.time_ < 3.66666666666667 + var_69_23 + arg_69_0 and arg_66_1.var_.characterEffect1034 then
				arg_66_1.var_.characterEffect1034.alpha = 1
			end

			if 0.366666666666667 < arg_66_1.time_ and arg_66_1.time_ <= 0.366666666666667 + arg_69_0 then
				arg_66_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_truck_loop", "")
			end

			if 2.86666666666667 < arg_66_1.time_ and arg_66_1.time_ <= 2.86666666666667 + arg_69_0 then
				arg_66_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_thunder02", "")
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_26 = 4
			local var_69_27 = 0.35

			if 4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_26 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_28 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_28:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_29 = arg_66_1:GetWordFromCfg(417231016)
				local var_69_30 = arg_66_1:FormatText(var_69_29.content)

				arg_66_1.text_.text = var_69_30

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_32 = 14 <= 0 and var_69_27 or var_69_27 * (utf8.len(var_69_30) / 14)

				if (14 <= 0 and var_69_27 or var_69_27 * (utf8.len(var_69_30) / 14)) > 0 and var_69_27 < var_69_32 then
					arg_66_1.talkMaxDuration = var_69_32
					var_69_26 = var_69_26 + 0.3

					if var_69_32 + var_69_26 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_32 + var_69_26
					end
				end

				arg_66_1.text_.text = var_69_30
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231016", "story_v_out_417231.awb") ~= 0 then
					local var_69_33 = manager.audio:GetVoiceLength("story_v_out_417231", "417231016", "story_v_out_417231.awb") / 1000

					if var_69_33 + var_69_26 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_33 + var_69_26
					end

					if var_69_29.prefab_name ~= "" and arg_66_1.actors_[var_69_29.prefab_name] ~= nil then
						local var_69_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_29.prefab_name].transform, "story_v_out_417231", "417231016", "story_v_out_417231.awb")

						arg_66_1:RecordAudio("417231016", var_69_34)
						arg_66_1:RecordAudio("417231016", var_69_34)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_417231", "417231016", "story_v_out_417231.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_417231", "417231016", "story_v_out_417231.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_35 = var_69_26 + 0.3
			local var_69_36 = math.max(var_69_27, arg_66_1.talkMaxDuration)

			if var_69_26 + 0.3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_35 + var_69_36 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_35) / var_69_36

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_35 + var_69_36 and arg_66_1.time_ < var_69_35 + var_69_36 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play417231017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 417231017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play417231018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1034"]) and arg_72_1.var_.actorSpriteComps1034 == nil then
				arg_72_1.var_.actorSpriteComps1034 = arg_72_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1034"]) then
				if arg_72_1.var_.actorSpriteComps1034 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								iter_75_1.color = Color.New(Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor2.r, (arg_72_1.time_ - 0) / var_75_0), Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor2.g, (arg_72_1.time_ - 0) / var_75_0), (Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor2.b, (arg_72_1.time_ - 0) / var_75_0)))
							else
								local var_75_1 = Mathf.Lerp(iter_75_1.color.r, 0.5, (arg_72_1.time_ - 0) / var_75_0)

								iter_75_1.color = Color.New(var_75_1, var_75_1, var_75_1)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1034"]) and arg_72_1.var_.actorSpriteComps1034 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_75_3 then
						iter_75_3.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_72_1.var_.actorSpriteComps1034 = nil
			end

			local var_75_2 = arg_72_1.actors_["1034"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1034 = var_75_2.localPosition
				var_75_2.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("1034", 7)

				for iter_75_4 = 0, var_75_2.childCount - 1 do
					local var_75_3 = var_75_2:GetChild(iter_75_4)

					if var_75_3.name == "" or not string.find(var_75_3.name, "split") then
						var_75_3.gameObject:SetActive(true)
					else
						var_75_3.gameObject:SetActive(false)
					end
				end
			end

			local var_75_4 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				var_75_2.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_72_1.time_ - 0) / var_75_4)
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				var_75_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.833333333333333 < arg_72_1.time_ and arg_72_1.time_ <= 0.833333333333333 + arg_75_0 then
				arg_72_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_side_1033_drink", "")
			end

			local var_75_6 = 0
			local var_75_7 = 1.275

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_8 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(417231017).content)

				arg_72_1.text_.text = var_75_8

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_10 = 51 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_8) / 51)

				if (51 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_8) / 51)) > 0 and var_75_7 < var_75_10 then
					arg_72_1.talkMaxDuration = var_75_10

					if var_75_10 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_8
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_11 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_11 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_11

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_11 and arg_72_1.time_ < var_75_6 + var_75_11 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play417231018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 417231018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play417231019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 1.65

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(417231018).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 66 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 66)

				if (66 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 66)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play417231019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 417231019
		arg_80_1.duration_ = 2.5

		local var_80_0 = {
			zh = 1.133,
			ja = 2.5
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
				arg_80_0:Play417231020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.125

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_1 = arg_80_1:GetWordFromCfg(417231019)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 5 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 5)

				if (5 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 5)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231019", "story_v_out_417231.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231019", "story_v_out_417231.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_417231", "417231019", "story_v_out_417231.awb")

						arg_80_1:RecordAudio("417231019", var_83_6)
						arg_80_1:RecordAudio("417231019", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_417231", "417231019", "story_v_out_417231.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_417231", "417231019", "story_v_out_417231.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play417231020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 417231020
		arg_84_1.duration_ = 1

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play417231021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1034"]) and arg_84_1.var_.actorSpriteComps1034 == nil then
				arg_84_1.var_.actorSpriteComps1034 = arg_84_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_0 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1034"]) then
				if arg_84_1.var_.actorSpriteComps1034 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								iter_87_1.color = Color.New(Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor1.r, (arg_84_1.time_ - 0) / var_87_0), Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor1.g, (arg_84_1.time_ - 0) / var_87_0), (Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor1.b, (arg_84_1.time_ - 0) / var_87_0)))
							else
								local var_87_1 = Mathf.Lerp(iter_87_1.color.r, 1, (arg_84_1.time_ - 0) / var_87_0)

								iter_87_1.color = Color.New(var_87_1, var_87_1, var_87_1)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1034"]) and arg_84_1.var_.actorSpriteComps1034 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_87_3 then
						iter_87_3.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_84_1.var_.actorSpriteComps1034 = nil
			end

			local var_87_2 = arg_84_1.actors_["1034"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1034 = var_87_2.localPosition
				var_87_2.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("1034", 3)

				for iter_87_4 = 0, var_87_2.childCount - 1 do
					local var_87_3 = var_87_2:GetChild(iter_87_4)

					if var_87_3.name == "split_6" or not string.find(var_87_3.name, "split") then
						var_87_3.gameObject:SetActive(true)
					else
						var_87_3.gameObject:SetActive(false)
					end
				end
			end

			local var_87_4 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				var_87_2.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_84_1.time_ - 0) / var_87_4)
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				var_87_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_87_5 = 0
			local var_87_6 = 0.133333333333333

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_7 = arg_84_1:GetWordFromCfg(417231020)
				local var_87_8 = arg_84_1:FormatText(var_87_7.content)

				arg_84_1.text_.text = var_87_8

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_10 = 3 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_8) / 3)

				if (3 <= 0 and var_87_6 or var_87_6 * (utf8.len(var_87_8) / 3)) > 0 and var_87_6 < var_87_10 then
					arg_84_1.talkMaxDuration = var_87_10

					if var_87_10 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_5
					end
				end

				arg_84_1.text_.text = var_87_8
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231020", "story_v_out_417231.awb") ~= 0 then
					local var_87_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231020", "story_v_out_417231.awb") / 1000

					if var_87_11 + var_87_5 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_11 + var_87_5
					end

					if var_87_7.prefab_name ~= "" and arg_84_1.actors_[var_87_7.prefab_name] ~= nil then
						local var_87_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_7.prefab_name].transform, "story_v_out_417231", "417231020", "story_v_out_417231.awb")

						arg_84_1:RecordAudio("417231020", var_87_12)
						arg_84_1:RecordAudio("417231020", var_87_12)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_417231", "417231020", "story_v_out_417231.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_417231", "417231020", "story_v_out_417231.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_13 = math.max(var_87_6, arg_84_1.talkMaxDuration)

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_13 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_5) / var_87_13

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_5 + var_87_13 and arg_84_1.time_ < var_87_5 + var_87_13 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play417231021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 417231021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play417231022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1034"]) and arg_88_1.var_.actorSpriteComps1034 == nil then
				arg_88_1.var_.actorSpriteComps1034 = arg_88_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_0 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1034"]) then
				if arg_88_1.var_.actorSpriteComps1034 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								iter_91_1.color = Color.New(Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor2.r, (arg_88_1.time_ - 0) / var_91_0), Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor2.g, (arg_88_1.time_ - 0) / var_91_0), (Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor2.b, (arg_88_1.time_ - 0) / var_91_0)))
							else
								local var_91_1 = Mathf.Lerp(iter_91_1.color.r, 0.5, (arg_88_1.time_ - 0) / var_91_0)

								iter_91_1.color = Color.New(var_91_1, var_91_1, var_91_1)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1034"]) and arg_88_1.var_.actorSpriteComps1034 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_91_3 then
						iter_91_3.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_88_1.var_.actorSpriteComps1034 = nil
			end

			local var_91_2 = arg_88_1.actors_["1034"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1034 = var_91_2.localPosition
				var_91_2.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("1034", 7)

				for iter_91_4 = 0, var_91_2.childCount - 1 do
					local var_91_3 = var_91_2:GetChild(iter_91_4)

					if var_91_3.name == "" or not string.find(var_91_3.name, "split") then
						var_91_3.gameObject:SetActive(true)
					else
						var_91_3.gameObject:SetActive(false)
					end
				end
			end

			local var_91_4 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				var_91_2.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_88_1.time_ - 0) / var_91_4)
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				var_91_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_91_5 = 0
			local var_91_6 = 0.95

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_7 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(417231021).content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 38 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_7) / 38)

				if (38 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_7) / 38)) > 0 and var_91_6 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_10 and arg_88_1.time_ < var_91_5 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play417231022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 417231022
		arg_92_1.duration_ = 3.23

		local var_92_0 = {
			zh = 2.733,
			ja = 3.233
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
				arg_92_0:Play417231023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.2

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:GetWordFromCfg(417231022)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 8 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 8)

				if (8 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 8)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231022", "story_v_out_417231.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231022", "story_v_out_417231.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_417231", "417231022", "story_v_out_417231.awb")

						arg_92_1:RecordAudio("417231022", var_95_6)
						arg_92_1:RecordAudio("417231022", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_417231", "417231022", "story_v_out_417231.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_417231", "417231022", "story_v_out_417231.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play417231023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 417231023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play417231024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.75

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_1 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(417231023).content)

				arg_96_1.text_.text = var_99_1

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_3 = 30 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 30)

				if (30 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 30)) > 0 and var_99_0 < var_99_3 then
					arg_96_1.talkMaxDuration = var_99_3

					if var_99_3 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_3 + 0
					end
				end

				arg_96_1.text_.text = var_99_1
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_4 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_4

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play417231024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 417231024
		arg_100_1.duration_ = 2.7

		local var_100_0 = {
			zh = 2.033,
			ja = 2.7
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play417231025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1034"]) and arg_100_1.var_.actorSpriteComps1034 == nil then
				arg_100_1.var_.actorSpriteComps1034 = arg_100_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1034"]) then
				if arg_100_1.var_.actorSpriteComps1034 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								iter_103_1.color = Color.New(Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor1.r, (arg_100_1.time_ - 0) / var_103_0), Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor1.g, (arg_100_1.time_ - 0) / var_103_0), (Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor1.b, (arg_100_1.time_ - 0) / var_103_0)))
							else
								local var_103_1 = Mathf.Lerp(iter_103_1.color.r, 1, (arg_100_1.time_ - 0) / var_103_0)

								iter_103_1.color = Color.New(var_103_1, var_103_1, var_103_1)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1034"]) and arg_100_1.var_.actorSpriteComps1034 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_103_3 then
						iter_103_3.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_100_1.var_.actorSpriteComps1034 = nil
			end

			local var_103_2 = arg_100_1.actors_["1034"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1034 = var_103_2.localPosition
				var_103_2.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("1034", 3)

				for iter_103_4 = 0, var_103_2.childCount - 1 do
					local var_103_3 = var_103_2:GetChild(iter_103_4)

					if var_103_3.name == "split_3" or not string.find(var_103_3.name, "split") then
						var_103_3.gameObject:SetActive(true)
					else
						var_103_3.gameObject:SetActive(false)
					end
				end
			end

			local var_103_4 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				var_103_2.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_100_1.time_ - 0) / var_103_4)
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				var_103_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_103_5 = 0
			local var_103_6 = 0.225

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_7 = arg_100_1:GetWordFromCfg(417231024)
				local var_103_8 = arg_100_1:FormatText(var_103_7.content)

				arg_100_1.text_.text = var_103_8

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_10 = 9 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_8) / 9)

				if (9 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_8) / 9)) > 0 and var_103_6 < var_103_10 then
					arg_100_1.talkMaxDuration = var_103_10

					if var_103_10 + var_103_5 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_5
					end
				end

				arg_100_1.text_.text = var_103_8
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231024", "story_v_out_417231.awb") ~= 0 then
					local var_103_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231024", "story_v_out_417231.awb") / 1000

					if var_103_11 + var_103_5 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_11 + var_103_5
					end

					if var_103_7.prefab_name ~= "" and arg_100_1.actors_[var_103_7.prefab_name] ~= nil then
						local var_103_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_7.prefab_name].transform, "story_v_out_417231", "417231024", "story_v_out_417231.awb")

						arg_100_1:RecordAudio("417231024", var_103_12)
						arg_100_1:RecordAudio("417231024", var_103_12)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_417231", "417231024", "story_v_out_417231.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_417231", "417231024", "story_v_out_417231.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_13 = math.max(var_103_6, arg_100_1.talkMaxDuration)

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_13 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_5) / var_103_13

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_5 + var_103_13 and arg_100_1.time_ < var_103_5 + var_103_13 + arg_103_0 then
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
	Play417231025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417231025
		arg_104_1.duration_ = 5.5

		local var_104_0 = {
			zh = 4.2,
			ja = 5.5
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
				arg_104_0:Play417231026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1034"]) and arg_104_1.var_.actorSpriteComps1034 == nil then
				arg_104_1.var_.actorSpriteComps1034 = arg_104_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_0 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1034"]) then
				if arg_104_1.var_.actorSpriteComps1034 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_107_1 then
							if arg_104_1.isInRecall_ then
								iter_107_1.color = Color.New(Mathf.Lerp(iter_107_1.color.r, arg_104_1.hightColor2.r, (arg_104_1.time_ - 0) / var_107_0), Mathf.Lerp(iter_107_1.color.g, arg_104_1.hightColor2.g, (arg_104_1.time_ - 0) / var_107_0), (Mathf.Lerp(iter_107_1.color.b, arg_104_1.hightColor2.b, (arg_104_1.time_ - 0) / var_107_0)))
							else
								local var_107_1 = Mathf.Lerp(iter_107_1.color.r, 0.5, (arg_104_1.time_ - 0) / var_107_0)

								iter_107_1.color = Color.New(var_107_1, var_107_1, var_107_1)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1034"]) and arg_104_1.var_.actorSpriteComps1034 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_107_3 then
						iter_107_3.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_104_1.var_.actorSpriteComps1034 = nil
			end

			local var_107_2 = 0
			local var_107_3 = 0.575

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1152].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_cata")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_4 = arg_104_1:GetWordFromCfg(417231025)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 23 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 23)

				if (23 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 23)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231025", "story_v_out_417231.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231025", "story_v_out_417231.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_out_417231", "417231025", "story_v_out_417231.awb")

						arg_104_1:RecordAudio("417231025", var_107_9)
						arg_104_1:RecordAudio("417231025", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_417231", "417231025", "story_v_out_417231.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_417231", "417231025", "story_v_out_417231.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_10 and arg_104_1.time_ < var_107_2 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play417231026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417231026
		arg_108_1.duration_ = 6.8

		local var_108_0 = {
			zh = 6.566,
			ja = 6.8
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
				arg_108_0:Play417231027(arg_108_1)
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

			local var_111_2 = 0
			local var_111_3 = 0.75

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_2 + arg_111_0 then
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

				local var_111_4 = arg_108_1:GetWordFromCfg(417231026)
				local var_111_5 = arg_108_1:FormatText(var_111_4.content)

				arg_108_1.text_.text = var_111_5

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_7 = 30 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 30)

				if (30 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 30)) > 0 and var_111_3 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_2
					end
				end

				arg_108_1.text_.text = var_111_5
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231026", "story_v_out_417231.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231026", "story_v_out_417231.awb") / 1000

					if var_111_8 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_2
					end

					if var_111_4.prefab_name ~= "" and arg_108_1.actors_[var_111_4.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_4.prefab_name].transform, "story_v_out_417231", "417231026", "story_v_out_417231.awb")

						arg_108_1:RecordAudio("417231026", var_111_9)
						arg_108_1:RecordAudio("417231026", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417231", "417231026", "story_v_out_417231.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417231", "417231026", "story_v_out_417231.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_3, arg_108_1.talkMaxDuration)

			if var_111_2 <= arg_108_1.time_ and arg_108_1.time_ < var_111_2 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_2) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_2 + var_111_10 and arg_108_1.time_ < var_111_2 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play417231027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417231027
		arg_112_1.duration_ = 2.9

		local var_112_0 = {
			zh = 2.5,
			ja = 2.9
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
				arg_112_0:Play417231028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1034"]) and arg_112_1.var_.actorSpriteComps1034 == nil then
				arg_112_1.var_.actorSpriteComps1034 = arg_112_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1034"]) then
				if arg_112_1.var_.actorSpriteComps1034 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								iter_115_1.color = Color.New(Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor2.r, (arg_112_1.time_ - 0) / var_115_0), Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor2.g, (arg_112_1.time_ - 0) / var_115_0), (Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor2.b, (arg_112_1.time_ - 0) / var_115_0)))
							else
								local var_115_1 = Mathf.Lerp(iter_115_1.color.r, 0.5, (arg_112_1.time_ - 0) / var_115_0)

								iter_115_1.color = Color.New(var_115_1, var_115_1, var_115_1)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1034"]) and arg_112_1.var_.actorSpriteComps1034 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_115_3 then
						iter_115_3.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_112_1.var_.actorSpriteComps1034 = nil
			end

			local var_115_2 = 0
			local var_115_3 = 0.275

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1152].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_cata")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_4 = arg_112_1:GetWordFromCfg(417231027)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 11 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 11)

				if (11 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 11)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231027", "story_v_out_417231.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231027", "story_v_out_417231.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_417231", "417231027", "story_v_out_417231.awb")

						arg_112_1:RecordAudio("417231027", var_115_9)
						arg_112_1:RecordAudio("417231027", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_417231", "417231027", "story_v_out_417231.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_417231", "417231027", "story_v_out_417231.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_10 = math.max(var_115_3, arg_112_1.talkMaxDuration)

			if var_115_2 <= arg_112_1.time_ and arg_112_1.time_ < var_115_2 + var_115_10 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_2) / var_115_10

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_2 + var_115_10 and arg_112_1.time_ < var_115_2 + var_115_10 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play417231028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417231028
		arg_116_1.duration_ = 5.7

		local var_116_0 = {
			zh = 2.8,
			ja = 5.7
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
				arg_116_0:Play417231029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.35

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1152].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_cata")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_1 = arg_116_1:GetWordFromCfg(417231028)
				local var_119_2 = arg_116_1:FormatText(var_119_1.content)

				arg_116_1.text_.text = var_119_2

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 14 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 14)

				if (14 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 14)) > 0 and var_119_0 < var_119_4 then
					arg_116_1.talkMaxDuration = var_119_4

					if var_119_4 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_4 + 0
					end
				end

				arg_116_1.text_.text = var_119_2
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231028", "story_v_out_417231.awb") ~= 0 then
					local var_119_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231028", "story_v_out_417231.awb") / 1000

					if var_119_5 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + 0
					end

					if var_119_1.prefab_name ~= "" and arg_116_1.actors_[var_119_1.prefab_name] ~= nil then
						local var_119_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_1.prefab_name].transform, "story_v_out_417231", "417231028", "story_v_out_417231.awb")

						arg_116_1:RecordAudio("417231028", var_119_6)
						arg_116_1:RecordAudio("417231028", var_119_6)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417231", "417231028", "story_v_out_417231.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417231", "417231028", "story_v_out_417231.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play417231029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417231029
		arg_120_1.duration_ = 9

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play417231030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 3.999999999999 < arg_120_1.time_ and arg_120_1.time_ <= 3.999999999999 + arg_123_0 then
				arg_120_1.allBtn_.enabled = false
			end

			if arg_120_1.time_ >= 3.999999999999 + 0.500000000001 and arg_120_1.time_ < 3.999999999999 + 0.500000000001 + arg_123_0 then
				arg_120_1.allBtn_.enabled = true
			end

			local var_123_0 = "ST01"

			if arg_120_1.bgs_.ST01 == nil then
				local var_123_1 = Object.Instantiate(arg_120_1.paintGo_)

				var_123_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_123_0)
				var_123_1.name = var_123_0
				var_123_1.transform.parent = arg_120_1.stage_.transform
				var_123_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.bgs_[var_123_0] = var_123_1
			end

			if 1.999999999999 < arg_120_1.time_ and arg_120_1.time_ <= 1.999999999999 + arg_123_0 then
				local var_123_2 = arg_120_1.bgs_.ST01

				arg_120_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_123_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_123_3 = var_123_2:GetComponent("SpriteRenderer")

				if var_123_3 and var_123_3.sprite then
					local var_123_4 = 2 * (var_123_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_123_2.transform.localScale = Vector3.New(var_123_4 / var_123_3.sprite.bounds.size.y < var_123_4 * manager.ui.mainCameraCom_.aspect / var_123_3.sprite.bounds.size.x and var_123_4 * manager.ui.mainCameraCom_.aspect / var_123_3.sprite.bounds.size.x or var_123_4 / var_123_3.sprite.bounds.size.y, var_123_4 / var_123_3.sprite.bounds.size.y < var_123_4 * manager.ui.mainCameraCom_.aspect / var_123_3.sprite.bounds.size.x and var_123_4 * manager.ui.mainCameraCom_.aspect / var_123_3.sprite.bounds.size.x or var_123_4 / var_123_3.sprite.bounds.size.y, 0)
				end

				for iter_123_0, iter_123_1 in pairs(arg_120_1.bgs_) do
					if iter_123_0 ~= "ST01" then
						iter_123_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_123_5 = 0

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_6 = 2

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_6 then
				local var_123_7 = Color.New(0, 0, 0)

				var_123_7.a = Mathf.Lerp(0, 1, (arg_120_1.time_ - var_123_5) / var_123_6)
				arg_120_1.mask_.color = var_123_7
			end

			if arg_120_1.time_ >= var_123_5 + var_123_6 and arg_120_1.time_ < var_123_5 + var_123_6 + arg_123_0 then
				local var_123_8 = Color.New(0, 0, 0)

				var_123_8.a = 1
				arg_120_1.mask_.color = var_123_8
			end

			local var_123_9 = 2

			if 2 < arg_120_1.time_ and arg_120_1.time_ <= var_123_9 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_10 = 2

			if var_123_9 <= arg_120_1.time_ and arg_120_1.time_ < var_123_9 + var_123_10 then
				local var_123_11 = Color.New(0, 0, 0)

				var_123_11.a = Mathf.Lerp(1, 0, (arg_120_1.time_ - var_123_9) / var_123_10)
				arg_120_1.mask_.color = var_123_11
			end

			if arg_120_1.time_ >= var_123_9 + var_123_10 and arg_120_1.time_ < var_123_9 + var_123_10 + arg_123_0 then
				local var_123_12 = Color.New(0, 0, 0)

				arg_120_1.mask_.enabled = false
				var_123_12.a = 0
				arg_120_1.mask_.color = var_123_12
			end

			local var_123_13 = arg_120_1.actors_["1034"].transform

			if 1.999999999999 < arg_120_1.time_ and arg_120_1.time_ <= 1.999999999999 + arg_123_0 then
				arg_120_1.var_.moveOldPos1034 = var_123_13.localPosition
				var_123_13.localScale = Vector3.New(1, 1, 1)

				arg_120_1:CheckSpriteTmpPos("1034", 7)

				for iter_123_2 = 0, var_123_13.childCount - 1 do
					local var_123_14 = var_123_13:GetChild(iter_123_2)

					if var_123_14.name == "" or not string.find(var_123_14.name, "split") then
						var_123_14.gameObject:SetActive(true)
					else
						var_123_14.gameObject:SetActive(false)
					end
				end
			end

			local var_123_15 = 0.001

			if 1.999999999999 <= arg_120_1.time_ and arg_120_1.time_ < 1.999999999999 + var_123_15 then
				var_123_13.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_120_1.time_ - 1.999999999999) / var_123_15)
			end

			if arg_120_1.time_ >= 1.999999999999 + var_123_15 and arg_120_1.time_ < 1.999999999999 + var_123_15 + arg_123_0 then
				var_123_13.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_120_1.frameCnt_ <= 1 then
				arg_120_1.dialog_:SetActive(false)
			end

			local var_123_16 = 3.999999999999
			local var_123_17 = 1.075

			if 3.999999999999 < arg_120_1.time_ and arg_120_1.time_ <= var_123_16 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				arg_120_1.dialog_:SetActive(true)

				arg_120_1.dialogCg_.alpha = 0

				local var_123_18 = LeanTween.value(arg_120_1.dialog_, 0, 1, 0.3)

				var_123_18:setOnUpdate(LuaHelper.FloatAction(function(arg_124_0)
					arg_120_1.dialogCg_.alpha = arg_124_0
				end))
				var_123_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_120_1.dialog_)
					var_123_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_120_1.duration_ = arg_120_1.duration_ + 0.3

				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_19 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(417231029).content)

				arg_120_1.text_.text = var_123_19

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_21 = 43 <= 0 and var_123_17 or var_123_17 * (utf8.len(var_123_19) / 43)

				if (43 <= 0 and var_123_17 or var_123_17 * (utf8.len(var_123_19) / 43)) > 0 and var_123_17 < var_123_21 then
					arg_120_1.talkMaxDuration = var_123_21
					var_123_16 = var_123_16 + 0.3

					if var_123_21 + var_123_16 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_21 + var_123_16
					end
				end

				arg_120_1.text_.text = var_123_19
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_22 = var_123_16 + 0.3
			local var_123_23 = math.max(var_123_17, arg_120_1.talkMaxDuration)

			if var_123_16 + 0.3 <= arg_120_1.time_ and arg_120_1.time_ < var_123_22 + var_123_23 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_22) / var_123_23

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_22 + var_123_23 and arg_120_1.time_ < var_123_22 + var_123_23 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play417231030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 417231030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play417231031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 1.4

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

				local var_129_1 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(417231030).content)

				arg_126_1.text_.text = var_129_1

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_3 = 56 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 56)

				if (56 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 56)) > 0 and var_129_0 < var_129_3 then
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
	Play417231031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 417231031
		arg_130_1.duration_ = 1.53

		local var_130_0 = {
			zh = 0.999999999999,
			ja = 1.533
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play417231032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1034"]) and arg_130_1.var_.actorSpriteComps1034 == nil then
				arg_130_1.var_.actorSpriteComps1034 = arg_130_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_133_0 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1034"]) then
				if arg_130_1.var_.actorSpriteComps1034 then
					for iter_133_0, iter_133_1 in pairs(arg_130_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_133_1 then
							if arg_130_1.isInRecall_ then
								iter_133_1.color = Color.New(Mathf.Lerp(iter_133_1.color.r, arg_130_1.hightColor1.r, (arg_130_1.time_ - 0) / var_133_0), Mathf.Lerp(iter_133_1.color.g, arg_130_1.hightColor1.g, (arg_130_1.time_ - 0) / var_133_0), (Mathf.Lerp(iter_133_1.color.b, arg_130_1.hightColor1.b, (arg_130_1.time_ - 0) / var_133_0)))
							else
								local var_133_1 = Mathf.Lerp(iter_133_1.color.r, 1, (arg_130_1.time_ - 0) / var_133_0)

								iter_133_1.color = Color.New(var_133_1, var_133_1, var_133_1)
							end
						end
					end
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1034"]) and arg_130_1.var_.actorSpriteComps1034 then
				for iter_133_2, iter_133_3 in pairs(arg_130_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_133_3 then
						iter_133_3.color = arg_130_1.isInRecall_ and (arg_130_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_130_1.var_.actorSpriteComps1034 = nil
			end

			local var_133_2 = arg_130_1.actors_["1034"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1034 = var_133_2.localPosition
				var_133_2.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("1034", 3)

				for iter_133_4 = 0, var_133_2.childCount - 1 do
					local var_133_3 = var_133_2:GetChild(iter_133_4)

					if var_133_3.name == "split_5" or not string.find(var_133_3.name, "split") then
						var_133_3.gameObject:SetActive(true)
					else
						var_133_3.gameObject:SetActive(false)
					end
				end
			end

			local var_133_4 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				var_133_2.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_130_1.time_ - 0) / var_133_4)
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				var_133_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_133_5 = 0
			local var_133_6 = 0.075

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_7 = arg_130_1:GetWordFromCfg(417231031)
				local var_133_8 = arg_130_1:FormatText(var_133_7.content)

				arg_130_1.text_.text = var_133_8

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_10 = 3 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_8) / 3)

				if (3 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_8) / 3)) > 0 and var_133_6 < var_133_10 then
					arg_130_1.talkMaxDuration = var_133_10

					if var_133_10 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_5
					end
				end

				arg_130_1.text_.text = var_133_8
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231031", "story_v_out_417231.awb") ~= 0 then
					local var_133_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231031", "story_v_out_417231.awb") / 1000

					if var_133_11 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_5
					end

					if var_133_7.prefab_name ~= "" and arg_130_1.actors_[var_133_7.prefab_name] ~= nil then
						local var_133_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_7.prefab_name].transform, "story_v_out_417231", "417231031", "story_v_out_417231.awb")

						arg_130_1:RecordAudio("417231031", var_133_12)
						arg_130_1:RecordAudio("417231031", var_133_12)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_417231", "417231031", "story_v_out_417231.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_417231", "417231031", "story_v_out_417231.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_13 = math.max(var_133_6, arg_130_1.talkMaxDuration)

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_13 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_5) / var_133_13

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_5 + var_133_13 and arg_130_1.time_ < var_133_5 + var_133_13 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
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
	Play417231032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 417231032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play417231033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1034"]) and arg_134_1.var_.actorSpriteComps1034 == nil then
				arg_134_1.var_.actorSpriteComps1034 = arg_134_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_0 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1034"]) then
				if arg_134_1.var_.actorSpriteComps1034 then
					for iter_137_0, iter_137_1 in pairs(arg_134_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_137_1 then
							if arg_134_1.isInRecall_ then
								iter_137_1.color = Color.New(Mathf.Lerp(iter_137_1.color.r, arg_134_1.hightColor2.r, (arg_134_1.time_ - 0) / var_137_0), Mathf.Lerp(iter_137_1.color.g, arg_134_1.hightColor2.g, (arg_134_1.time_ - 0) / var_137_0), (Mathf.Lerp(iter_137_1.color.b, arg_134_1.hightColor2.b, (arg_134_1.time_ - 0) / var_137_0)))
							else
								local var_137_1 = Mathf.Lerp(iter_137_1.color.r, 0.5, (arg_134_1.time_ - 0) / var_137_0)

								iter_137_1.color = Color.New(var_137_1, var_137_1, var_137_1)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1034"]) and arg_134_1.var_.actorSpriteComps1034 then
				for iter_137_2, iter_137_3 in pairs(arg_134_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_137_3 then
						iter_137_3.color = arg_134_1.isInRecall_ and (arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_134_1.var_.actorSpriteComps1034 = nil
			end

			local var_137_2 = 0
			local var_137_3 = 0.925

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_2 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_4 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(417231032).content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_6 = 37 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_4) / 37)

				if (37 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_4) / 37)) > 0 and var_137_3 < var_137_6 then
					arg_134_1.talkMaxDuration = var_137_6

					if var_137_6 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_2
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_3, arg_134_1.talkMaxDuration)

			if var_137_2 <= arg_134_1.time_ and arg_134_1.time_ < var_137_2 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_2) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_2 + var_137_7 and arg_134_1.time_ < var_137_2 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play417231033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 417231033
		arg_138_1.duration_ = 3.07

		local var_138_0 = {
			zh = 2.1,
			ja = 3.066
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play417231034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if arg_138_1.actors_["1015"] == nil then
				local var_141_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1015")

				if not isNil(var_141_0) then
					local var_141_1 = Object.Instantiate(var_141_0, arg_138_1.canvasGo_.transform)

					var_141_1.transform:SetSiblingIndex(1)

					var_141_1.name = "1015"
					var_141_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_138_1.actors_["1015"] = var_141_1

					if arg_138_1.isInRecall_ then
						for iter_141_0, iter_141_1 in ipairs((var_141_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_141_1.color = arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_141_2 = arg_138_1.actors_["1015"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.actorSpriteComps1015 == nil then
				arg_138_1.var_.actorSpriteComps1015 = var_141_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_3 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_3 and not isNil(var_141_2) then
				if arg_138_1.var_.actorSpriteComps1015 then
					for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_141_3 then
							if arg_138_1.isInRecall_ then
								iter_141_3.color = Color.New(Mathf.Lerp(iter_141_3.color.r, arg_138_1.hightColor1.r, (arg_138_1.time_ - 0) / var_141_3), Mathf.Lerp(iter_141_3.color.g, arg_138_1.hightColor1.g, (arg_138_1.time_ - 0) / var_141_3), (Mathf.Lerp(iter_141_3.color.b, arg_138_1.hightColor1.b, (arg_138_1.time_ - 0) / var_141_3)))
							else
								local var_141_4 = Mathf.Lerp(iter_141_3.color.r, 1, (arg_138_1.time_ - 0) / var_141_3)

								iter_141_3.color = Color.New(var_141_4, var_141_4, var_141_4)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_3 and arg_138_1.time_ < 0 + var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.actorSpriteComps1015 then
				for iter_141_4, iter_141_5 in pairs(arg_138_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_141_5 then
						iter_141_5.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_138_1.var_.actorSpriteComps1015 = nil
			end

			local var_141_5 = arg_138_1.actors_["1034"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1034 = var_141_5.localPosition
				var_141_5.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("1034", 2)

				for iter_141_6 = 0, var_141_5.childCount - 1 do
					local var_141_6 = var_141_5:GetChild(iter_141_6)

					if var_141_6.name == "" or not string.find(var_141_6.name, "split") then
						var_141_6.gameObject:SetActive(true)
					else
						var_141_6.gameObject:SetActive(false)
					end
				end
			end

			local var_141_7 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_7 then
				var_141_5.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_138_1.time_ - 0) / var_141_7)
			end

			if arg_138_1.time_ >= 0 + var_141_7 and arg_138_1.time_ < 0 + var_141_7 + arg_141_0 then
				var_141_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_141_8 = arg_138_1.actors_["1015"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1015 = var_141_8.localPosition
				var_141_8.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("1015", 4)

				for iter_141_7 = 0, var_141_8.childCount - 1 do
					local var_141_9 = var_141_8:GetChild(iter_141_7)

					if var_141_9.name == "split_2" or not string.find(var_141_9.name, "split") then
						var_141_9.gameObject:SetActive(true)
					else
						var_141_9.gameObject:SetActive(false)
					end
				end
			end

			local var_141_10 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_10 then
				var_141_8.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_138_1.time_ - 0) / var_141_10)
			end

			if arg_138_1.time_ >= 0 + var_141_10 and arg_138_1.time_ < 0 + var_141_10 + arg_141_0 then
				var_141_8.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_141_11 = 0
			local var_141_12 = 0.25

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_11 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_13 = arg_138_1:GetWordFromCfg(417231033)
				local var_141_14 = arg_138_1:FormatText(var_141_13.content)

				arg_138_1.text_.text = var_141_14

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_16 = 10 <= 0 and var_141_12 or var_141_12 * (utf8.len(var_141_14) / 10)

				if (10 <= 0 and var_141_12 or var_141_12 * (utf8.len(var_141_14) / 10)) > 0 and var_141_12 < var_141_16 then
					arg_138_1.talkMaxDuration = var_141_16

					if var_141_16 + var_141_11 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_16 + var_141_11
					end
				end

				arg_138_1.text_.text = var_141_14
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231033", "story_v_out_417231.awb") ~= 0 then
					local var_141_17 = manager.audio:GetVoiceLength("story_v_out_417231", "417231033", "story_v_out_417231.awb") / 1000

					if var_141_17 + var_141_11 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_17 + var_141_11
					end

					if var_141_13.prefab_name ~= "" and arg_138_1.actors_[var_141_13.prefab_name] ~= nil then
						local var_141_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_13.prefab_name].transform, "story_v_out_417231", "417231033", "story_v_out_417231.awb")

						arg_138_1:RecordAudio("417231033", var_141_18)
						arg_138_1:RecordAudio("417231033", var_141_18)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_417231", "417231033", "story_v_out_417231.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_417231", "417231033", "story_v_out_417231.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_19 = math.max(var_141_12, arg_138_1.talkMaxDuration)

			if var_141_11 <= arg_138_1.time_ and arg_138_1.time_ < var_141_11 + var_141_19 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_11) / var_141_19

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_11 + var_141_19 and arg_138_1.time_ < var_141_11 + var_141_19 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play417231034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 417231034
		arg_142_1.duration_ = 7.07

		local var_142_0 = {
			zh = 4.5,
			ja = 7.066
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
				arg_142_0:Play417231035(arg_142_1)
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

			local var_145_2 = arg_142_1.actors_["1015"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.actorSpriteComps1015 == nil then
				arg_142_1.var_.actorSpriteComps1015 = var_145_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_3 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_3 and not isNil(var_145_2) then
				if arg_142_1.var_.actorSpriteComps1015 then
					for iter_145_4, iter_145_5 in pairs(arg_142_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_145_5 then
							if arg_142_1.isInRecall_ then
								iter_145_5.color = Color.New(Mathf.Lerp(iter_145_5.color.r, arg_142_1.hightColor2.r, (arg_142_1.time_ - 0) / var_145_3), Mathf.Lerp(iter_145_5.color.g, arg_142_1.hightColor2.g, (arg_142_1.time_ - 0) / var_145_3), (Mathf.Lerp(iter_145_5.color.b, arg_142_1.hightColor2.b, (arg_142_1.time_ - 0) / var_145_3)))
							else
								local var_145_4 = Mathf.Lerp(iter_145_5.color.r, 0.5, (arg_142_1.time_ - 0) / var_145_3)

								iter_145_5.color = Color.New(var_145_4, var_145_4, var_145_4)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= 0 + var_145_3 and arg_142_1.time_ < 0 + var_145_3 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.actorSpriteComps1015 then
				for iter_145_6, iter_145_7 in pairs(arg_142_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_145_7 then
						iter_145_7.color = arg_142_1.isInRecall_ and (arg_142_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_142_1.var_.actorSpriteComps1015 = nil
			end

			local var_145_5 = 0
			local var_145_6 = 0.45

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
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

				local var_145_7 = arg_142_1:GetWordFromCfg(417231034)
				local var_145_8 = arg_142_1:FormatText(var_145_7.content)

				arg_142_1.text_.text = var_145_8

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_10 = 18 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_8) / 18)

				if (18 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_8) / 18)) > 0 and var_145_6 < var_145_10 then
					arg_142_1.talkMaxDuration = var_145_10

					if var_145_10 + var_145_5 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_5
					end
				end

				arg_142_1.text_.text = var_145_8
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231034", "story_v_out_417231.awb") ~= 0 then
					local var_145_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231034", "story_v_out_417231.awb") / 1000

					if var_145_11 + var_145_5 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_11 + var_145_5
					end

					if var_145_7.prefab_name ~= "" and arg_142_1.actors_[var_145_7.prefab_name] ~= nil then
						local var_145_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_7.prefab_name].transform, "story_v_out_417231", "417231034", "story_v_out_417231.awb")

						arg_142_1:RecordAudio("417231034", var_145_12)
						arg_142_1:RecordAudio("417231034", var_145_12)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_417231", "417231034", "story_v_out_417231.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_417231", "417231034", "story_v_out_417231.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_13 = math.max(var_145_6, arg_142_1.talkMaxDuration)

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_13 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_5) / var_145_13

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_5 + var_145_13 and arg_142_1.time_ < var_145_5 + var_145_13 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play417231035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 417231035
		arg_146_1.duration_ = 8.4

		local var_146_0 = {
			zh = 5.7,
			ja = 8.4
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play417231036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if arg_146_1.actors_["1060"] == nil then
				local var_149_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_149_0) then
					local var_149_1 = Object.Instantiate(var_149_0, arg_146_1.canvasGo_.transform)

					var_149_1.transform:SetSiblingIndex(1)

					var_149_1.name = "1060"
					var_149_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_146_1.actors_["1060"] = var_149_1

					if arg_146_1.isInRecall_ then
						for iter_149_0, iter_149_1 in ipairs((var_149_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_149_1.color = arg_146_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_149_2 = arg_146_1.actors_["1060"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.actorSpriteComps1060 == nil then
				arg_146_1.var_.actorSpriteComps1060 = var_149_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_3 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_3 and not isNil(var_149_2) then
				if arg_146_1.var_.actorSpriteComps1060 then
					for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_149_3 then
							if arg_146_1.isInRecall_ then
								iter_149_3.color = Color.New(Mathf.Lerp(iter_149_3.color.r, arg_146_1.hightColor1.r, (arg_146_1.time_ - 0) / var_149_3), Mathf.Lerp(iter_149_3.color.g, arg_146_1.hightColor1.g, (arg_146_1.time_ - 0) / var_149_3), (Mathf.Lerp(iter_149_3.color.b, arg_146_1.hightColor1.b, (arg_146_1.time_ - 0) / var_149_3)))
							else
								local var_149_4 = Mathf.Lerp(iter_149_3.color.r, 1, (arg_146_1.time_ - 0) / var_149_3)

								iter_149_3.color = Color.New(var_149_4, var_149_4, var_149_4)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= 0 + var_149_3 and arg_146_1.time_ < 0 + var_149_3 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.actorSpriteComps1060 then
				for iter_149_4, iter_149_5 in pairs(arg_146_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_149_5 then
						iter_149_5.color = arg_146_1.isInRecall_ and (arg_146_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_146_1.var_.actorSpriteComps1060 = nil
			end

			local var_149_5 = arg_146_1.actors_["1034"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_5) and arg_146_1.var_.actorSpriteComps1034 == nil then
				arg_146_1.var_.actorSpriteComps1034 = var_149_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_6 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_6 and not isNil(var_149_5) then
				if arg_146_1.var_.actorSpriteComps1034 then
					for iter_149_6, iter_149_7 in pairs(arg_146_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_149_7 then
							if arg_146_1.isInRecall_ then
								iter_149_7.color = Color.New(Mathf.Lerp(iter_149_7.color.r, arg_146_1.hightColor2.r, (arg_146_1.time_ - 0) / var_149_6), Mathf.Lerp(iter_149_7.color.g, arg_146_1.hightColor2.g, (arg_146_1.time_ - 0) / var_149_6), (Mathf.Lerp(iter_149_7.color.b, arg_146_1.hightColor2.b, (arg_146_1.time_ - 0) / var_149_6)))
							else
								local var_149_7 = Mathf.Lerp(iter_149_7.color.r, 0.5, (arg_146_1.time_ - 0) / var_149_6)

								iter_149_7.color = Color.New(var_149_7, var_149_7, var_149_7)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= 0 + var_149_6 and arg_146_1.time_ < 0 + var_149_6 + arg_149_0 and not isNil(var_149_5) and arg_146_1.var_.actorSpriteComps1034 then
				for iter_149_8, iter_149_9 in pairs(arg_146_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_149_9 then
						iter_149_9.color = arg_146_1.isInRecall_ and (arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_146_1.var_.actorSpriteComps1034 = nil
			end

			local var_149_8 = arg_146_1.actors_["1015"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1015 = var_149_8.localPosition
				var_149_8.localScale = Vector3.New(1, 1, 1)

				arg_146_1:CheckSpriteTmpPos("1015", 7)

				for iter_149_10 = 0, var_149_8.childCount - 1 do
					local var_149_9 = var_149_8:GetChild(iter_149_10)

					if var_149_9.name == "" or not string.find(var_149_9.name, "split") then
						var_149_9.gameObject:SetActive(true)
					else
						var_149_9.gameObject:SetActive(false)
					end
				end
			end

			local var_149_10 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_10 then
				var_149_8.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_146_1.time_ - 0) / var_149_10)
			end

			if arg_146_1.time_ >= 0 + var_149_10 and arg_146_1.time_ < 0 + var_149_10 + arg_149_0 then
				var_149_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_149_11 = arg_146_1.actors_["1060"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1060 = var_149_11.localPosition
				var_149_11.localScale = Vector3.New(1, 1, 1)

				arg_146_1:CheckSpriteTmpPos("1060", 4)

				for iter_149_11 = 0, var_149_11.childCount - 1 do
					local var_149_12 = var_149_11:GetChild(iter_149_11)

					if var_149_12.name == "" or not string.find(var_149_12.name, "split") then
						var_149_12.gameObject:SetActive(true)
					else
						var_149_12.gameObject:SetActive(false)
					end
				end
			end

			local var_149_13 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_13 then
				var_149_11.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_146_1.time_ - 0) / var_149_13)
			end

			if arg_146_1.time_ >= 0 + var_149_13 and arg_146_1.time_ < 0 + var_149_13 + arg_149_0 then
				var_149_11.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_149_14 = 0
			local var_149_15 = 0.7

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_16 = arg_146_1:GetWordFromCfg(417231035)
				local var_149_17 = arg_146_1:FormatText(var_149_16.content)

				arg_146_1.text_.text = var_149_17

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_19 = 28 <= 0 and var_149_15 or var_149_15 * (utf8.len(var_149_17) / 28)

				if (28 <= 0 and var_149_15 or var_149_15 * (utf8.len(var_149_17) / 28)) > 0 and var_149_15 < var_149_19 then
					arg_146_1.talkMaxDuration = var_149_19

					if var_149_19 + var_149_14 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_19 + var_149_14
					end
				end

				arg_146_1.text_.text = var_149_17
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231035", "story_v_out_417231.awb") ~= 0 then
					local var_149_20 = manager.audio:GetVoiceLength("story_v_out_417231", "417231035", "story_v_out_417231.awb") / 1000

					if var_149_20 + var_149_14 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_20 + var_149_14
					end

					if var_149_16.prefab_name ~= "" and arg_146_1.actors_[var_149_16.prefab_name] ~= nil then
						local var_149_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_16.prefab_name].transform, "story_v_out_417231", "417231035", "story_v_out_417231.awb")

						arg_146_1:RecordAudio("417231035", var_149_21)
						arg_146_1:RecordAudio("417231035", var_149_21)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_417231", "417231035", "story_v_out_417231.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_417231", "417231035", "story_v_out_417231.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_22 = math.max(var_149_15, arg_146_1.talkMaxDuration)

			if var_149_14 <= arg_146_1.time_ and arg_146_1.time_ < var_149_14 + var_149_22 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_14) / var_149_22

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_14 + var_149_22 and arg_146_1.time_ < var_149_14 + var_149_22 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
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
	Play417231036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 417231036
		arg_150_1.duration_ = 15.67

		local var_150_0 = {
			zh = 8.3,
			ja = 15.666
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
				arg_150_0:Play417231037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1015"]) and arg_150_1.var_.actorSpriteComps1015 == nil then
				arg_150_1.var_.actorSpriteComps1015 = arg_150_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_0 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1015"]) then
				if arg_150_1.var_.actorSpriteComps1015 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								iter_153_1.color = Color.New(Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor1.r, (arg_150_1.time_ - 0) / var_153_0), Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor1.g, (arg_150_1.time_ - 0) / var_153_0), (Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor1.b, (arg_150_1.time_ - 0) / var_153_0)))
							else
								local var_153_1 = Mathf.Lerp(iter_153_1.color.r, 1, (arg_150_1.time_ - 0) / var_153_0)

								iter_153_1.color = Color.New(var_153_1, var_153_1, var_153_1)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1015"]) and arg_150_1.var_.actorSpriteComps1015 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_153_3 then
						iter_153_3.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_150_1.var_.actorSpriteComps1015 = nil
			end

			local var_153_2 = arg_150_1.actors_["1060"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.actorSpriteComps1060 == nil then
				arg_150_1.var_.actorSpriteComps1060 = var_153_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_3 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 and not isNil(var_153_2) then
				if arg_150_1.var_.actorSpriteComps1060 then
					for iter_153_4, iter_153_5 in pairs(arg_150_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_153_5 then
							if arg_150_1.isInRecall_ then
								iter_153_5.color = Color.New(Mathf.Lerp(iter_153_5.color.r, arg_150_1.hightColor2.r, (arg_150_1.time_ - 0) / var_153_3), Mathf.Lerp(iter_153_5.color.g, arg_150_1.hightColor2.g, (arg_150_1.time_ - 0) / var_153_3), (Mathf.Lerp(iter_153_5.color.b, arg_150_1.hightColor2.b, (arg_150_1.time_ - 0) / var_153_3)))
							else
								local var_153_4 = Mathf.Lerp(iter_153_5.color.r, 0.5, (arg_150_1.time_ - 0) / var_153_3)

								iter_153_5.color = Color.New(var_153_4, var_153_4, var_153_4)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.actorSpriteComps1060 then
				for iter_153_6, iter_153_7 in pairs(arg_150_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_153_7 then
						iter_153_7.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_150_1.var_.actorSpriteComps1060 = nil
			end

			local var_153_5 = arg_150_1.actors_["1015"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1015 = var_153_5.localPosition
				var_153_5.localScale = Vector3.New(1, 1, 1)

				arg_150_1:CheckSpriteTmpPos("1015", 4)

				for iter_153_8 = 0, var_153_5.childCount - 1 do
					local var_153_6 = var_153_5:GetChild(iter_153_8)

					if var_153_6.name == "" or not string.find(var_153_6.name, "split") then
						var_153_6.gameObject:SetActive(true)
					else
						var_153_6.gameObject:SetActive(false)
					end
				end
			end

			local var_153_7 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				var_153_5.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_150_1.time_ - 0) / var_153_7)
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				var_153_5.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_153_8 = arg_150_1.actors_["1060"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1060 = var_153_8.localPosition
				var_153_8.localScale = Vector3.New(1, 1, 1)

				arg_150_1:CheckSpriteTmpPos("1060", 7)

				for iter_153_9 = 0, var_153_8.childCount - 1 do
					local var_153_9 = var_153_8:GetChild(iter_153_9)

					if var_153_9.name == "" or not string.find(var_153_9.name, "split") then
						var_153_9.gameObject:SetActive(true)
					else
						var_153_9.gameObject:SetActive(false)
					end
				end
			end

			local var_153_10 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_10 then
				var_153_8.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_150_1.time_ - 0) / var_153_10)
			end

			if arg_150_1.time_ >= 0 + var_153_10 and arg_150_1.time_ < 0 + var_153_10 + arg_153_0 then
				var_153_8.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_153_11 = 0
			local var_153_12 = 1.025

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_11 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_13 = arg_150_1:GetWordFromCfg(417231036)
				local var_153_14 = arg_150_1:FormatText(var_153_13.content)

				arg_150_1.text_.text = var_153_14

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_16 = 41 <= 0 and var_153_12 or var_153_12 * (utf8.len(var_153_14) / 41)

				if (41 <= 0 and var_153_12 or var_153_12 * (utf8.len(var_153_14) / 41)) > 0 and var_153_12 < var_153_16 then
					arg_150_1.talkMaxDuration = var_153_16

					if var_153_16 + var_153_11 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_16 + var_153_11
					end
				end

				arg_150_1.text_.text = var_153_14
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231036", "story_v_out_417231.awb") ~= 0 then
					local var_153_17 = manager.audio:GetVoiceLength("story_v_out_417231", "417231036", "story_v_out_417231.awb") / 1000

					if var_153_17 + var_153_11 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_17 + var_153_11
					end

					if var_153_13.prefab_name ~= "" and arg_150_1.actors_[var_153_13.prefab_name] ~= nil then
						local var_153_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_13.prefab_name].transform, "story_v_out_417231", "417231036", "story_v_out_417231.awb")

						arg_150_1:RecordAudio("417231036", var_153_18)
						arg_150_1:RecordAudio("417231036", var_153_18)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_417231", "417231036", "story_v_out_417231.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_417231", "417231036", "story_v_out_417231.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_19 = math.max(var_153_12, arg_150_1.talkMaxDuration)

			if var_153_11 <= arg_150_1.time_ and arg_150_1.time_ < var_153_11 + var_153_19 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_11) / var_153_19

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_11 + var_153_19 and arg_150_1.time_ < var_153_11 + var_153_19 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play417231037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 417231037
		arg_154_1.duration_ = 7.07

		local var_154_0 = {
			zh = 3.8,
			ja = 7.066
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play417231038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["1034"]) and arg_154_1.var_.actorSpriteComps1034 == nil then
				arg_154_1.var_.actorSpriteComps1034 = arg_154_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_0 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["1034"]) then
				if arg_154_1.var_.actorSpriteComps1034 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								iter_157_1.color = Color.New(Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor1.r, (arg_154_1.time_ - 0) / var_157_0), Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor1.g, (arg_154_1.time_ - 0) / var_157_0), (Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor1.b, (arg_154_1.time_ - 0) / var_157_0)))
							else
								local var_157_1 = Mathf.Lerp(iter_157_1.color.r, 1, (arg_154_1.time_ - 0) / var_157_0)

								iter_157_1.color = Color.New(var_157_1, var_157_1, var_157_1)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["1034"]) and arg_154_1.var_.actorSpriteComps1034 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_157_3 then
						iter_157_3.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_154_1.var_.actorSpriteComps1034 = nil
			end

			local var_157_2 = arg_154_1.actors_["1015"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.actorSpriteComps1015 == nil then
				arg_154_1.var_.actorSpriteComps1015 = var_157_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_3 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_3 and not isNil(var_157_2) then
				if arg_154_1.var_.actorSpriteComps1015 then
					for iter_157_4, iter_157_5 in pairs(arg_154_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_157_5 then
							if arg_154_1.isInRecall_ then
								iter_157_5.color = Color.New(Mathf.Lerp(iter_157_5.color.r, arg_154_1.hightColor2.r, (arg_154_1.time_ - 0) / var_157_3), Mathf.Lerp(iter_157_5.color.g, arg_154_1.hightColor2.g, (arg_154_1.time_ - 0) / var_157_3), (Mathf.Lerp(iter_157_5.color.b, arg_154_1.hightColor2.b, (arg_154_1.time_ - 0) / var_157_3)))
							else
								local var_157_4 = Mathf.Lerp(iter_157_5.color.r, 0.5, (arg_154_1.time_ - 0) / var_157_3)

								iter_157_5.color = Color.New(var_157_4, var_157_4, var_157_4)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_3 and arg_154_1.time_ < 0 + var_157_3 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.actorSpriteComps1015 then
				for iter_157_6, iter_157_7 in pairs(arg_154_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_157_7 then
						iter_157_7.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_154_1.var_.actorSpriteComps1015 = nil
			end

			local var_157_5 = arg_154_1.actors_["1034"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1034 = var_157_5.localPosition
				var_157_5.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("1034", 2)

				for iter_157_8 = 0, var_157_5.childCount - 1 do
					local var_157_6 = var_157_5:GetChild(iter_157_8)

					if var_157_6.name == "split_6" or not string.find(var_157_6.name, "split") then
						var_157_6.gameObject:SetActive(true)
					else
						var_157_6.gameObject:SetActive(false)
					end
				end
			end

			local var_157_7 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_7 then
				var_157_5.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_154_1.time_ - 0) / var_157_7)
			end

			if arg_154_1.time_ >= 0 + var_157_7 and arg_154_1.time_ < 0 + var_157_7 + arg_157_0 then
				var_157_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_157_8 = 0
			local var_157_9 = 0.325

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_8 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_10 = arg_154_1:GetWordFromCfg(417231037)
				local var_157_11 = arg_154_1:FormatText(var_157_10.content)

				arg_154_1.text_.text = var_157_11

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_13 = 13 <= 0 and var_157_9 or var_157_9 * (utf8.len(var_157_11) / 13)

				if (13 <= 0 and var_157_9 or var_157_9 * (utf8.len(var_157_11) / 13)) > 0 and var_157_9 < var_157_13 then
					arg_154_1.talkMaxDuration = var_157_13

					if var_157_13 + var_157_8 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_13 + var_157_8
					end
				end

				arg_154_1.text_.text = var_157_11
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231037", "story_v_out_417231.awb") ~= 0 then
					local var_157_14 = manager.audio:GetVoiceLength("story_v_out_417231", "417231037", "story_v_out_417231.awb") / 1000

					if var_157_14 + var_157_8 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_14 + var_157_8
					end

					if var_157_10.prefab_name ~= "" and arg_154_1.actors_[var_157_10.prefab_name] ~= nil then
						local var_157_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_10.prefab_name].transform, "story_v_out_417231", "417231037", "story_v_out_417231.awb")

						arg_154_1:RecordAudio("417231037", var_157_15)
						arg_154_1:RecordAudio("417231037", var_157_15)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_417231", "417231037", "story_v_out_417231.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_417231", "417231037", "story_v_out_417231.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_16 = math.max(var_157_9, arg_154_1.talkMaxDuration)

			if var_157_8 <= arg_154_1.time_ and arg_154_1.time_ < var_157_8 + var_157_16 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_8) / var_157_16

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_8 + var_157_16 and arg_154_1.time_ < var_157_8 + var_157_16 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
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

		arg_154_1:InitPlayNodeList()
	end,
	Play417231038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 417231038
		arg_158_1.duration_ = 11.8

		local var_158_0 = {
			zh = 7.733,
			ja = 11.8
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play417231039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1015"]) and arg_158_1.var_.actorSpriteComps1015 == nil then
				arg_158_1.var_.actorSpriteComps1015 = arg_158_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_0 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1015"]) then
				if arg_158_1.var_.actorSpriteComps1015 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_161_1 then
							if arg_158_1.isInRecall_ then
								iter_161_1.color = Color.New(Mathf.Lerp(iter_161_1.color.r, arg_158_1.hightColor1.r, (arg_158_1.time_ - 0) / var_161_0), Mathf.Lerp(iter_161_1.color.g, arg_158_1.hightColor1.g, (arg_158_1.time_ - 0) / var_161_0), (Mathf.Lerp(iter_161_1.color.b, arg_158_1.hightColor1.b, (arg_158_1.time_ - 0) / var_161_0)))
							else
								local var_161_1 = Mathf.Lerp(iter_161_1.color.r, 1, (arg_158_1.time_ - 0) / var_161_0)

								iter_161_1.color = Color.New(var_161_1, var_161_1, var_161_1)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1015"]) and arg_158_1.var_.actorSpriteComps1015 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_161_3 then
						iter_161_3.color = arg_158_1.isInRecall_ and (arg_158_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_158_1.var_.actorSpriteComps1015 = nil
			end

			local var_161_2 = arg_158_1.actors_["1034"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_2) and arg_158_1.var_.actorSpriteComps1034 == nil then
				arg_158_1.var_.actorSpriteComps1034 = var_161_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_3 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_3 and not isNil(var_161_2) then
				if arg_158_1.var_.actorSpriteComps1034 then
					for iter_161_4, iter_161_5 in pairs(arg_158_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_161_5 then
							if arg_158_1.isInRecall_ then
								iter_161_5.color = Color.New(Mathf.Lerp(iter_161_5.color.r, arg_158_1.hightColor2.r, (arg_158_1.time_ - 0) / var_161_3), Mathf.Lerp(iter_161_5.color.g, arg_158_1.hightColor2.g, (arg_158_1.time_ - 0) / var_161_3), (Mathf.Lerp(iter_161_5.color.b, arg_158_1.hightColor2.b, (arg_158_1.time_ - 0) / var_161_3)))
							else
								local var_161_4 = Mathf.Lerp(iter_161_5.color.r, 0.5, (arg_158_1.time_ - 0) / var_161_3)

								iter_161_5.color = Color.New(var_161_4, var_161_4, var_161_4)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= 0 + var_161_3 and arg_158_1.time_ < 0 + var_161_3 + arg_161_0 and not isNil(var_161_2) and arg_158_1.var_.actorSpriteComps1034 then
				for iter_161_6, iter_161_7 in pairs(arg_158_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_161_7 then
						iter_161_7.color = arg_158_1.isInRecall_ and (arg_158_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_158_1.var_.actorSpriteComps1034 = nil
			end

			local var_161_5 = 0
			local var_161_6 = 1

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_5 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_7 = arg_158_1:GetWordFromCfg(417231038)
				local var_161_8 = arg_158_1:FormatText(var_161_7.content)

				arg_158_1.text_.text = var_161_8

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_10 = 40 <= 0 and var_161_6 or var_161_6 * (utf8.len(var_161_8) / 40)

				if (40 <= 0 and var_161_6 or var_161_6 * (utf8.len(var_161_8) / 40)) > 0 and var_161_6 < var_161_10 then
					arg_158_1.talkMaxDuration = var_161_10

					if var_161_10 + var_161_5 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_10 + var_161_5
					end
				end

				arg_158_1.text_.text = var_161_8
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231038", "story_v_out_417231.awb") ~= 0 then
					local var_161_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231038", "story_v_out_417231.awb") / 1000

					if var_161_11 + var_161_5 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_11 + var_161_5
					end

					if var_161_7.prefab_name ~= "" and arg_158_1.actors_[var_161_7.prefab_name] ~= nil then
						local var_161_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_7.prefab_name].transform, "story_v_out_417231", "417231038", "story_v_out_417231.awb")

						arg_158_1:RecordAudio("417231038", var_161_12)
						arg_158_1:RecordAudio("417231038", var_161_12)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_417231", "417231038", "story_v_out_417231.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_417231", "417231038", "story_v_out_417231.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_13 = math.max(var_161_6, arg_158_1.talkMaxDuration)

			if var_161_5 <= arg_158_1.time_ and arg_158_1.time_ < var_161_5 + var_161_13 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_5) / var_161_13

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_5 + var_161_13 and arg_158_1.time_ < var_161_5 + var_161_13 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play417231039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 417231039
		arg_162_1.duration_ = 11.33

		local var_162_0 = {
			zh = 9.8,
			ja = 11.333
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play417231040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 1.275

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:GetWordFromCfg(417231039)
				local var_165_2 = arg_162_1:FormatText(var_165_1.content)

				arg_162_1.text_.text = var_165_2

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 52 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 52)

				if (52 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 52)) > 0 and var_165_0 < var_165_4 then
					arg_162_1.talkMaxDuration = var_165_4

					if var_165_4 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_4 + 0
					end
				end

				arg_162_1.text_.text = var_165_2
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231039", "story_v_out_417231.awb") ~= 0 then
					local var_165_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231039", "story_v_out_417231.awb") / 1000

					if var_165_5 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + 0
					end

					if var_165_1.prefab_name ~= "" and arg_162_1.actors_[var_165_1.prefab_name] ~= nil then
						local var_165_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_1.prefab_name].transform, "story_v_out_417231", "417231039", "story_v_out_417231.awb")

						arg_162_1:RecordAudio("417231039", var_165_6)
						arg_162_1:RecordAudio("417231039", var_165_6)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_417231", "417231039", "story_v_out_417231.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_417231", "417231039", "story_v_out_417231.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_7 and arg_162_1.time_ < 0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play417231040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 417231040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play417231041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1034 = arg_166_1.actors_["1034"].transform.localPosition
				arg_166_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("1034", 7)

				for iter_169_0 = 0, arg_166_1.actors_["1034"].transform.childCount - 1 do
					local var_169_0 = arg_166_1.actors_["1034"].transform:GetChild(iter_169_0)

					if var_169_0.name == "" or not string.find(var_169_0.name, "split") then
						var_169_0.gameObject:SetActive(true)
					else
						var_169_0.gameObject:SetActive(false)
					end
				end
			end

			local var_169_1 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_1 then
				arg_166_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_166_1.time_ - 0) / var_169_1)
			end

			if arg_166_1.time_ >= 0 + var_169_1 and arg_166_1.time_ < 0 + var_169_1 + arg_169_0 then
				arg_166_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_169_2 = arg_166_1.actors_["1015"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1015 = var_169_2.localPosition
				var_169_2.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("1015", 7)

				for iter_169_1 = 0, var_169_2.childCount - 1 do
					local var_169_3 = var_169_2:GetChild(iter_169_1)

					if var_169_3.name == "" or not string.find(var_169_3.name, "split") then
						var_169_3.gameObject:SetActive(true)
					else
						var_169_3.gameObject:SetActive(false)
					end
				end
			end

			local var_169_4 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				var_169_2.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_166_1.time_ - 0) / var_169_4)
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				var_169_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_169_5 = 0
			local var_169_6 = 1.525

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_7 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(417231040).content)

				arg_166_1.text_.text = var_169_7

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_9 = 61 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_7) / 61)

				if (61 <= 0 and var_169_6 or var_169_6 * (utf8.len(var_169_7) / 61)) > 0 and var_169_6 < var_169_9 then
					arg_166_1.talkMaxDuration = var_169_9

					if var_169_9 + var_169_5 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_9 + var_169_5
					end
				end

				arg_166_1.text_.text = var_169_7
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_6, arg_166_1.talkMaxDuration)

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_5) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_5 + var_169_10 and arg_166_1.time_ < var_169_5 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play417231041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 417231041
		arg_170_1.duration_ = 4.3

		local var_170_0 = {
			zh = 1.333,
			ja = 4.3
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play417231042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["1034"]) and arg_170_1.var_.actorSpriteComps1034 == nil then
				arg_170_1.var_.actorSpriteComps1034 = arg_170_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_0 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["1034"]) then
				if arg_170_1.var_.actorSpriteComps1034 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								iter_173_1.color = Color.New(Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor1.r, (arg_170_1.time_ - 0) / var_173_0), Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor1.g, (arg_170_1.time_ - 0) / var_173_0), (Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor1.b, (arg_170_1.time_ - 0) / var_173_0)))
							else
								local var_173_1 = Mathf.Lerp(iter_173_1.color.r, 1, (arg_170_1.time_ - 0) / var_173_0)

								iter_173_1.color = Color.New(var_173_1, var_173_1, var_173_1)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["1034"]) and arg_170_1.var_.actorSpriteComps1034 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_173_3 then
						iter_173_3.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_170_1.var_.actorSpriteComps1034 = nil
			end

			local var_173_2 = arg_170_1.actors_["1034"].transform

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1034 = var_173_2.localPosition
				var_173_2.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("1034", 3)

				for iter_173_4 = 0, var_173_2.childCount - 1 do
					local var_173_3 = var_173_2:GetChild(iter_173_4)

					if var_173_3.name == "split_6" or not string.find(var_173_3.name, "split") then
						var_173_3.gameObject:SetActive(true)
					else
						var_173_3.gameObject:SetActive(false)
					end
				end
			end

			local var_173_4 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				var_173_2.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_170_1.time_ - 0) / var_173_4)
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				var_173_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_173_5 = 0
			local var_173_6 = 0.15

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_5 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_7 = arg_170_1:GetWordFromCfg(417231041)
				local var_173_8 = arg_170_1:FormatText(var_173_7.content)

				arg_170_1.text_.text = var_173_8

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_10 = 6 <= 0 and var_173_6 or var_173_6 * (utf8.len(var_173_8) / 6)

				if (6 <= 0 and var_173_6 or var_173_6 * (utf8.len(var_173_8) / 6)) > 0 and var_173_6 < var_173_10 then
					arg_170_1.talkMaxDuration = var_173_10

					if var_173_10 + var_173_5 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_10 + var_173_5
					end
				end

				arg_170_1.text_.text = var_173_8
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231041", "story_v_out_417231.awb") ~= 0 then
					local var_173_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231041", "story_v_out_417231.awb") / 1000

					if var_173_11 + var_173_5 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_11 + var_173_5
					end

					if var_173_7.prefab_name ~= "" and arg_170_1.actors_[var_173_7.prefab_name] ~= nil then
						local var_173_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_7.prefab_name].transform, "story_v_out_417231", "417231041", "story_v_out_417231.awb")

						arg_170_1:RecordAudio("417231041", var_173_12)
						arg_170_1:RecordAudio("417231041", var_173_12)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_417231", "417231041", "story_v_out_417231.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_417231", "417231041", "story_v_out_417231.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_13 = math.max(var_173_6, arg_170_1.talkMaxDuration)

			if var_173_5 <= arg_170_1.time_ and arg_170_1.time_ < var_173_5 + var_173_13 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_5) / var_173_13

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_5 + var_173_13 and arg_170_1.time_ < var_173_5 + var_173_13 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
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

		arg_170_1:InitPlayNodeList()
	end,
	Play417231042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 417231042
		arg_174_1.duration_ = 5.23

		local var_174_0 = {
			zh = 3.9,
			ja = 5.233
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play417231043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1015"]) and arg_174_1.var_.actorSpriteComps1015 == nil then
				arg_174_1.var_.actorSpriteComps1015 = arg_174_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_0 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1015"]) then
				if arg_174_1.var_.actorSpriteComps1015 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								iter_177_1.color = Color.New(Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor1.r, (arg_174_1.time_ - 0) / var_177_0), Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor1.g, (arg_174_1.time_ - 0) / var_177_0), (Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor1.b, (arg_174_1.time_ - 0) / var_177_0)))
							else
								local var_177_1 = Mathf.Lerp(iter_177_1.color.r, 1, (arg_174_1.time_ - 0) / var_177_0)

								iter_177_1.color = Color.New(var_177_1, var_177_1, var_177_1)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1015"]) and arg_174_1.var_.actorSpriteComps1015 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_177_3 then
						iter_177_3.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_174_1.var_.actorSpriteComps1015 = nil
			end

			local var_177_2 = arg_174_1.actors_["1034"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps1034 == nil then
				arg_174_1.var_.actorSpriteComps1034 = var_177_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_3 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_3 and not isNil(var_177_2) then
				if arg_174_1.var_.actorSpriteComps1034 then
					for iter_177_4, iter_177_5 in pairs(arg_174_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_177_5 then
							if arg_174_1.isInRecall_ then
								iter_177_5.color = Color.New(Mathf.Lerp(iter_177_5.color.r, arg_174_1.hightColor2.r, (arg_174_1.time_ - 0) / var_177_3), Mathf.Lerp(iter_177_5.color.g, arg_174_1.hightColor2.g, (arg_174_1.time_ - 0) / var_177_3), (Mathf.Lerp(iter_177_5.color.b, arg_174_1.hightColor2.b, (arg_174_1.time_ - 0) / var_177_3)))
							else
								local var_177_4 = Mathf.Lerp(iter_177_5.color.r, 0.5, (arg_174_1.time_ - 0) / var_177_3)

								iter_177_5.color = Color.New(var_177_4, var_177_4, var_177_4)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_3 and arg_174_1.time_ < 0 + var_177_3 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps1034 then
				for iter_177_6, iter_177_7 in pairs(arg_174_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_177_7 then
						iter_177_7.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_174_1.var_.actorSpriteComps1034 = nil
			end

			local var_177_5 = arg_174_1.actors_["1034"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1034 = var_177_5.localPosition
				var_177_5.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1034", 2)

				for iter_177_8 = 0, var_177_5.childCount - 1 do
					local var_177_6 = var_177_5:GetChild(iter_177_8)

					if var_177_6.name == "" or not string.find(var_177_6.name, "split") then
						var_177_6.gameObject:SetActive(true)
					else
						var_177_6.gameObject:SetActive(false)
					end
				end
			end

			local var_177_7 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 then
				var_177_5.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_174_1.time_ - 0) / var_177_7)
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 then
				var_177_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_177_8 = arg_174_1.actors_["1015"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1015 = var_177_8.localPosition
				var_177_8.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1015", 4)

				for iter_177_9 = 0, var_177_8.childCount - 1 do
					local var_177_9 = var_177_8:GetChild(iter_177_9)

					if var_177_9.name == "" or not string.find(var_177_9.name, "split") then
						var_177_9.gameObject:SetActive(true)
					else
						var_177_9.gameObject:SetActive(false)
					end
				end
			end

			local var_177_10 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_10 then
				var_177_8.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_174_1.time_ - 0) / var_177_10)
			end

			if arg_174_1.time_ >= 0 + var_177_10 and arg_174_1.time_ < 0 + var_177_10 + arg_177_0 then
				var_177_8.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_177_11 = 0
			local var_177_12 = 0.4

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_11 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_13 = arg_174_1:GetWordFromCfg(417231042)
				local var_177_14 = arg_174_1:FormatText(var_177_13.content)

				arg_174_1.text_.text = var_177_14

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_16 = 16 <= 0 and var_177_12 or var_177_12 * (utf8.len(var_177_14) / 16)

				if (16 <= 0 and var_177_12 or var_177_12 * (utf8.len(var_177_14) / 16)) > 0 and var_177_12 < var_177_16 then
					arg_174_1.talkMaxDuration = var_177_16

					if var_177_16 + var_177_11 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_16 + var_177_11
					end
				end

				arg_174_1.text_.text = var_177_14
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231042", "story_v_out_417231.awb") ~= 0 then
					local var_177_17 = manager.audio:GetVoiceLength("story_v_out_417231", "417231042", "story_v_out_417231.awb") / 1000

					if var_177_17 + var_177_11 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_17 + var_177_11
					end

					if var_177_13.prefab_name ~= "" and arg_174_1.actors_[var_177_13.prefab_name] ~= nil then
						local var_177_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_13.prefab_name].transform, "story_v_out_417231", "417231042", "story_v_out_417231.awb")

						arg_174_1:RecordAudio("417231042", var_177_18)
						arg_174_1:RecordAudio("417231042", var_177_18)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_417231", "417231042", "story_v_out_417231.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_417231", "417231042", "story_v_out_417231.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_19 = math.max(var_177_12, arg_174_1.talkMaxDuration)

			if var_177_11 <= arg_174_1.time_ and arg_174_1.time_ < var_177_11 + var_177_19 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_11) / var_177_19

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_11 + var_177_19 and arg_174_1.time_ < var_177_11 + var_177_19 + arg_177_0 then
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
			},
			{
				assetPath = "",
				actorName = "1015",
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
	Play417231043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 417231043
		arg_178_1.duration_ = 3.77

		local var_178_0 = {
			zh = 2.266,
			ja = 3.766
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
				arg_178_0:Play417231044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1034"]) and arg_178_1.var_.actorSpriteComps1034 == nil then
				arg_178_1.var_.actorSpriteComps1034 = arg_178_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_0 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1034"]) then
				if arg_178_1.var_.actorSpriteComps1034 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								iter_181_1.color = Color.New(Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor1.r, (arg_178_1.time_ - 0) / var_181_0), Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor1.g, (arg_178_1.time_ - 0) / var_181_0), (Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor1.b, (arg_178_1.time_ - 0) / var_181_0)))
							else
								local var_181_1 = Mathf.Lerp(iter_181_1.color.r, 1, (arg_178_1.time_ - 0) / var_181_0)

								iter_181_1.color = Color.New(var_181_1, var_181_1, var_181_1)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1034"]) and arg_178_1.var_.actorSpriteComps1034 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_181_3 then
						iter_181_3.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_178_1.var_.actorSpriteComps1034 = nil
			end

			local var_181_2 = arg_178_1.actors_["1015"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.actorSpriteComps1015 == nil then
				arg_178_1.var_.actorSpriteComps1015 = var_181_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_3 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_3 and not isNil(var_181_2) then
				if arg_178_1.var_.actorSpriteComps1015 then
					for iter_181_4, iter_181_5 in pairs(arg_178_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_181_5 then
							if arg_178_1.isInRecall_ then
								iter_181_5.color = Color.New(Mathf.Lerp(iter_181_5.color.r, arg_178_1.hightColor2.r, (arg_178_1.time_ - 0) / var_181_3), Mathf.Lerp(iter_181_5.color.g, arg_178_1.hightColor2.g, (arg_178_1.time_ - 0) / var_181_3), (Mathf.Lerp(iter_181_5.color.b, arg_178_1.hightColor2.b, (arg_178_1.time_ - 0) / var_181_3)))
							else
								local var_181_4 = Mathf.Lerp(iter_181_5.color.r, 0.5, (arg_178_1.time_ - 0) / var_181_3)

								iter_181_5.color = Color.New(var_181_4, var_181_4, var_181_4)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_3 and arg_178_1.time_ < 0 + var_181_3 + arg_181_0 and not isNil(var_181_2) and arg_178_1.var_.actorSpriteComps1015 then
				for iter_181_6, iter_181_7 in pairs(arg_178_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_181_7 then
						iter_181_7.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_178_1.var_.actorSpriteComps1015 = nil
			end

			local var_181_5 = arg_178_1.actors_["1034"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1034 = var_181_5.localPosition
				var_181_5.localScale = Vector3.New(1, 1, 1)

				arg_178_1:CheckSpriteTmpPos("1034", 2)

				for iter_181_8 = 0, var_181_5.childCount - 1 do
					local var_181_6 = var_181_5:GetChild(iter_181_8)

					if var_181_6.name == "split_6" or not string.find(var_181_6.name, "split") then
						var_181_6.gameObject:SetActive(true)
					else
						var_181_6.gameObject:SetActive(false)
					end
				end
			end

			local var_181_7 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 then
				var_181_5.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_178_1.time_ - 0) / var_181_7)
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 then
				var_181_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_181_8 = 0
			local var_181_9 = 0.2

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_8 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_10 = arg_178_1:GetWordFromCfg(417231043)
				local var_181_11 = arg_178_1:FormatText(var_181_10.content)

				arg_178_1.text_.text = var_181_11

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_13 = 8 <= 0 and var_181_9 or var_181_9 * (utf8.len(var_181_11) / 8)

				if (8 <= 0 and var_181_9 or var_181_9 * (utf8.len(var_181_11) / 8)) > 0 and var_181_9 < var_181_13 then
					arg_178_1.talkMaxDuration = var_181_13

					if var_181_13 + var_181_8 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_13 + var_181_8
					end
				end

				arg_178_1.text_.text = var_181_11
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231043", "story_v_out_417231.awb") ~= 0 then
					local var_181_14 = manager.audio:GetVoiceLength("story_v_out_417231", "417231043", "story_v_out_417231.awb") / 1000

					if var_181_14 + var_181_8 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_14 + var_181_8
					end

					if var_181_10.prefab_name ~= "" and arg_178_1.actors_[var_181_10.prefab_name] ~= nil then
						local var_181_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_10.prefab_name].transform, "story_v_out_417231", "417231043", "story_v_out_417231.awb")

						arg_178_1:RecordAudio("417231043", var_181_15)
						arg_178_1:RecordAudio("417231043", var_181_15)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_417231", "417231043", "story_v_out_417231.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_417231", "417231043", "story_v_out_417231.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_16 = math.max(var_181_9, arg_178_1.talkMaxDuration)

			if var_181_8 <= arg_178_1.time_ and arg_178_1.time_ < var_181_8 + var_181_16 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_8) / var_181_16

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_8 + var_181_16 and arg_178_1.time_ < var_181_8 + var_181_16 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
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

		arg_178_1:InitPlayNodeList()
	end,
	Play417231044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 417231044
		arg_182_1.duration_ = 10.8

		local var_182_0 = {
			zh = 10.8,
			ja = 10.3
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play417231045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1015"]) and arg_182_1.var_.actorSpriteComps1015 == nil then
				arg_182_1.var_.actorSpriteComps1015 = arg_182_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_0 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1015"]) then
				if arg_182_1.var_.actorSpriteComps1015 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								iter_185_1.color = Color.New(Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor1.r, (arg_182_1.time_ - 0) / var_185_0), Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor1.g, (arg_182_1.time_ - 0) / var_185_0), (Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor1.b, (arg_182_1.time_ - 0) / var_185_0)))
							else
								local var_185_1 = Mathf.Lerp(iter_185_1.color.r, 1, (arg_182_1.time_ - 0) / var_185_0)

								iter_185_1.color = Color.New(var_185_1, var_185_1, var_185_1)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1015"]) and arg_182_1.var_.actorSpriteComps1015 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_185_3 then
						iter_185_3.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_182_1.var_.actorSpriteComps1015 = nil
			end

			local var_185_2 = arg_182_1.actors_["1034"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.actorSpriteComps1034 == nil then
				arg_182_1.var_.actorSpriteComps1034 = var_185_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_3 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_3 and not isNil(var_185_2) then
				if arg_182_1.var_.actorSpriteComps1034 then
					for iter_185_4, iter_185_5 in pairs(arg_182_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_185_5 then
							if arg_182_1.isInRecall_ then
								iter_185_5.color = Color.New(Mathf.Lerp(iter_185_5.color.r, arg_182_1.hightColor2.r, (arg_182_1.time_ - 0) / var_185_3), Mathf.Lerp(iter_185_5.color.g, arg_182_1.hightColor2.g, (arg_182_1.time_ - 0) / var_185_3), (Mathf.Lerp(iter_185_5.color.b, arg_182_1.hightColor2.b, (arg_182_1.time_ - 0) / var_185_3)))
							else
								local var_185_4 = Mathf.Lerp(iter_185_5.color.r, 0.5, (arg_182_1.time_ - 0) / var_185_3)

								iter_185_5.color = Color.New(var_185_4, var_185_4, var_185_4)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_3 and arg_182_1.time_ < 0 + var_185_3 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.actorSpriteComps1034 then
				for iter_185_6, iter_185_7 in pairs(arg_182_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_185_7 then
						iter_185_7.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_182_1.var_.actorSpriteComps1034 = nil
			end

			local var_185_5 = 0
			local var_185_6 = 1.475

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_7 = arg_182_1:GetWordFromCfg(417231044)
				local var_185_8 = arg_182_1:FormatText(var_185_7.content)

				arg_182_1.text_.text = var_185_8

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_10 = 59 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_8) / 59)

				if (59 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_8) / 59)) > 0 and var_185_6 < var_185_10 then
					arg_182_1.talkMaxDuration = var_185_10

					if var_185_10 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_5
					end
				end

				arg_182_1.text_.text = var_185_8
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231044", "story_v_out_417231.awb") ~= 0 then
					local var_185_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231044", "story_v_out_417231.awb") / 1000

					if var_185_11 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_11 + var_185_5
					end

					if var_185_7.prefab_name ~= "" and arg_182_1.actors_[var_185_7.prefab_name] ~= nil then
						local var_185_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_7.prefab_name].transform, "story_v_out_417231", "417231044", "story_v_out_417231.awb")

						arg_182_1:RecordAudio("417231044", var_185_12)
						arg_182_1:RecordAudio("417231044", var_185_12)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_417231", "417231044", "story_v_out_417231.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_417231", "417231044", "story_v_out_417231.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_13 = math.max(var_185_6, arg_182_1.talkMaxDuration)

			if var_185_5 <= arg_182_1.time_ and arg_182_1.time_ < var_185_5 + var_185_13 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_5) / var_185_13

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_5 + var_185_13 and arg_182_1.time_ < var_185_5 + var_185_13 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play417231045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 417231045
		arg_186_1.duration_ = 5.83

		local var_186_0 = {
			zh = 3.366,
			ja = 5.833
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play417231046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1015 = arg_186_1.actors_["1015"].transform.localPosition
				arg_186_1.actors_["1015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_186_1:CheckSpriteTmpPos("1015", 4)

				for iter_189_0 = 0, arg_186_1.actors_["1015"].transform.childCount - 1 do
					local var_189_0 = arg_186_1.actors_["1015"].transform:GetChild(iter_189_0)

					if var_189_0.name == "split_6" or not string.find(var_189_0.name, "split") then
						var_189_0.gameObject:SetActive(true)
					else
						var_189_0.gameObject:SetActive(false)
					end
				end
			end

			local var_189_1 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_1 then
				arg_186_1.actors_["1015"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_186_1.time_ - 0) / var_189_1)
			end

			if arg_186_1.time_ >= 0 + var_189_1 and arg_186_1.time_ < 0 + var_189_1 + arg_189_0 then
				arg_186_1.actors_["1015"].transform.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_189_2 = 0
			local var_189_3 = 0.4

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_4 = arg_186_1:GetWordFromCfg(417231045)
				local var_189_5 = arg_186_1:FormatText(var_189_4.content)

				arg_186_1.text_.text = var_189_5

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_7 = 16 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 16)

				if (16 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_5) / 16)) > 0 and var_189_3 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_2
					end
				end

				arg_186_1.text_.text = var_189_5
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231045", "story_v_out_417231.awb") ~= 0 then
					local var_189_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231045", "story_v_out_417231.awb") / 1000

					if var_189_8 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_8 + var_189_2
					end

					if var_189_4.prefab_name ~= "" and arg_186_1.actors_[var_189_4.prefab_name] ~= nil then
						local var_189_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_4.prefab_name].transform, "story_v_out_417231", "417231045", "story_v_out_417231.awb")

						arg_186_1:RecordAudio("417231045", var_189_9)
						arg_186_1:RecordAudio("417231045", var_189_9)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_417231", "417231045", "story_v_out_417231.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_417231", "417231045", "story_v_out_417231.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_10 = math.max(var_189_3, arg_186_1.talkMaxDuration)

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_10 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_2) / var_189_10

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_2 + var_189_10 and arg_186_1.time_ < var_189_2 + var_189_10 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play417231046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 417231046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play417231047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1015"]) and arg_190_1.var_.actorSpriteComps1015 == nil then
				arg_190_1.var_.actorSpriteComps1015 = arg_190_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_0 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1015"]) then
				if arg_190_1.var_.actorSpriteComps1015 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								iter_193_1.color = Color.New(Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor2.r, (arg_190_1.time_ - 0) / var_193_0), Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor2.g, (arg_190_1.time_ - 0) / var_193_0), (Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor2.b, (arg_190_1.time_ - 0) / var_193_0)))
							else
								local var_193_1 = Mathf.Lerp(iter_193_1.color.r, 0.5, (arg_190_1.time_ - 0) / var_193_0)

								iter_193_1.color = Color.New(var_193_1, var_193_1, var_193_1)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1015"]) and arg_190_1.var_.actorSpriteComps1015 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_193_3 then
						iter_193_3.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_190_1.var_.actorSpriteComps1015 = nil
			end

			local var_193_2 = 0
			local var_193_3 = 1.025

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_2 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, false)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_4 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(417231046).content)

				arg_190_1.text_.text = var_193_4

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_6 = 41 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_4) / 41)

				if (41 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_4) / 41)) > 0 and var_193_3 < var_193_6 then
					arg_190_1.talkMaxDuration = var_193_6

					if var_193_6 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_6 + var_193_2
					end
				end

				arg_190_1.text_.text = var_193_4
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_7 = math.max(var_193_3, arg_190_1.talkMaxDuration)

			if var_193_2 <= arg_190_1.time_ and arg_190_1.time_ < var_193_2 + var_193_7 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_2) / var_193_7

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_2 + var_193_7 and arg_190_1.time_ < var_193_2 + var_193_7 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play417231047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 417231047
		arg_194_1.duration_ = 6.2

		local var_194_0 = {
			zh = 4.933,
			ja = 6.2
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play417231048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1015"]) and arg_194_1.var_.actorSpriteComps1015 == nil then
				arg_194_1.var_.actorSpriteComps1015 = arg_194_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_0 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1015"]) then
				if arg_194_1.var_.actorSpriteComps1015 then
					for iter_197_0, iter_197_1 in pairs(arg_194_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_197_1 then
							if arg_194_1.isInRecall_ then
								iter_197_1.color = Color.New(Mathf.Lerp(iter_197_1.color.r, arg_194_1.hightColor1.r, (arg_194_1.time_ - 0) / var_197_0), Mathf.Lerp(iter_197_1.color.g, arg_194_1.hightColor1.g, (arg_194_1.time_ - 0) / var_197_0), (Mathf.Lerp(iter_197_1.color.b, arg_194_1.hightColor1.b, (arg_194_1.time_ - 0) / var_197_0)))
							else
								local var_197_1 = Mathf.Lerp(iter_197_1.color.r, 1, (arg_194_1.time_ - 0) / var_197_0)

								iter_197_1.color = Color.New(var_197_1, var_197_1, var_197_1)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1015"]) and arg_194_1.var_.actorSpriteComps1015 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_197_3 then
						iter_197_3.color = arg_194_1.isInRecall_ and (arg_194_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_194_1.var_.actorSpriteComps1015 = nil
			end

			local var_197_2 = 0
			local var_197_3 = 0.55

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_4 = arg_194_1:GetWordFromCfg(417231047)
				local var_197_5 = arg_194_1:FormatText(var_197_4.content)

				arg_194_1.text_.text = var_197_5

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_7 = 22 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 22)

				if (22 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_5) / 22)) > 0 and var_197_3 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_5
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231047", "story_v_out_417231.awb") ~= 0 then
					local var_197_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231047", "story_v_out_417231.awb") / 1000

					if var_197_8 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_8 + var_197_2
					end

					if var_197_4.prefab_name ~= "" and arg_194_1.actors_[var_197_4.prefab_name] ~= nil then
						local var_197_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_4.prefab_name].transform, "story_v_out_417231", "417231047", "story_v_out_417231.awb")

						arg_194_1:RecordAudio("417231047", var_197_9)
						arg_194_1:RecordAudio("417231047", var_197_9)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_417231", "417231047", "story_v_out_417231.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_417231", "417231047", "story_v_out_417231.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_10 = math.max(var_197_3, arg_194_1.talkMaxDuration)

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_10 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_2) / var_197_10

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_2 + var_197_10 and arg_194_1.time_ < var_197_2 + var_197_10 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play417231048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 417231048
		arg_198_1.duration_ = 5.2

		local var_198_0 = {
			zh = 2.133,
			ja = 5.2
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play417231049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1034"]) and arg_198_1.var_.actorSpriteComps1034 == nil then
				arg_198_1.var_.actorSpriteComps1034 = arg_198_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_0 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1034"]) then
				if arg_198_1.var_.actorSpriteComps1034 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								iter_201_1.color = Color.New(Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor1.r, (arg_198_1.time_ - 0) / var_201_0), Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor1.g, (arg_198_1.time_ - 0) / var_201_0), (Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor1.b, (arg_198_1.time_ - 0) / var_201_0)))
							else
								local var_201_1 = Mathf.Lerp(iter_201_1.color.r, 1, (arg_198_1.time_ - 0) / var_201_0)

								iter_201_1.color = Color.New(var_201_1, var_201_1, var_201_1)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1034"]) and arg_198_1.var_.actorSpriteComps1034 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_201_3 then
						iter_201_3.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_198_1.var_.actorSpriteComps1034 = nil
			end

			local var_201_2 = arg_198_1.actors_["1015"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.actorSpriteComps1015 == nil then
				arg_198_1.var_.actorSpriteComps1015 = var_201_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_3 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_3 and not isNil(var_201_2) then
				if arg_198_1.var_.actorSpriteComps1015 then
					for iter_201_4, iter_201_5 in pairs(arg_198_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_201_5 then
							if arg_198_1.isInRecall_ then
								iter_201_5.color = Color.New(Mathf.Lerp(iter_201_5.color.r, arg_198_1.hightColor2.r, (arg_198_1.time_ - 0) / var_201_3), Mathf.Lerp(iter_201_5.color.g, arg_198_1.hightColor2.g, (arg_198_1.time_ - 0) / var_201_3), (Mathf.Lerp(iter_201_5.color.b, arg_198_1.hightColor2.b, (arg_198_1.time_ - 0) / var_201_3)))
							else
								local var_201_4 = Mathf.Lerp(iter_201_5.color.r, 0.5, (arg_198_1.time_ - 0) / var_201_3)

								iter_201_5.color = Color.New(var_201_4, var_201_4, var_201_4)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_3 and arg_198_1.time_ < 0 + var_201_3 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.actorSpriteComps1015 then
				for iter_201_6, iter_201_7 in pairs(arg_198_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_201_7 then
						iter_201_7.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_198_1.var_.actorSpriteComps1015 = nil
			end

			local var_201_5 = 0
			local var_201_6 = 0.375

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_7 = arg_198_1:GetWordFromCfg(417231048)
				local var_201_8 = arg_198_1:FormatText(var_201_7.content)

				arg_198_1.text_.text = var_201_8

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_10 = 15 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_8) / 15)

				if (15 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_8) / 15)) > 0 and var_201_6 < var_201_10 then
					arg_198_1.talkMaxDuration = var_201_10

					if var_201_10 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_5
					end
				end

				arg_198_1.text_.text = var_201_8
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231048", "story_v_out_417231.awb") ~= 0 then
					local var_201_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231048", "story_v_out_417231.awb") / 1000

					if var_201_11 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_11 + var_201_5
					end

					if var_201_7.prefab_name ~= "" and arg_198_1.actors_[var_201_7.prefab_name] ~= nil then
						local var_201_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_7.prefab_name].transform, "story_v_out_417231", "417231048", "story_v_out_417231.awb")

						arg_198_1:RecordAudio("417231048", var_201_12)
						arg_198_1:RecordAudio("417231048", var_201_12)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_417231", "417231048", "story_v_out_417231.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_417231", "417231048", "story_v_out_417231.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_13 = math.max(var_201_6, arg_198_1.talkMaxDuration)

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_13 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_5) / var_201_13

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_5 + var_201_13 and arg_198_1.time_ < var_201_5 + var_201_13 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play417231049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 417231049
		arg_202_1.duration_ = 2.33

		local var_202_0 = {
			zh = 1.133,
			ja = 2.333
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play417231050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1060"]) and arg_202_1.var_.actorSpriteComps1060 == nil then
				arg_202_1.var_.actorSpriteComps1060 = arg_202_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_0 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1060"]) then
				if arg_202_1.var_.actorSpriteComps1060 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_205_1 then
							if arg_202_1.isInRecall_ then
								iter_205_1.color = Color.New(Mathf.Lerp(iter_205_1.color.r, arg_202_1.hightColor1.r, (arg_202_1.time_ - 0) / var_205_0), Mathf.Lerp(iter_205_1.color.g, arg_202_1.hightColor1.g, (arg_202_1.time_ - 0) / var_205_0), (Mathf.Lerp(iter_205_1.color.b, arg_202_1.hightColor1.b, (arg_202_1.time_ - 0) / var_205_0)))
							else
								local var_205_1 = Mathf.Lerp(iter_205_1.color.r, 1, (arg_202_1.time_ - 0) / var_205_0)

								iter_205_1.color = Color.New(var_205_1, var_205_1, var_205_1)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1060"]) and arg_202_1.var_.actorSpriteComps1060 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_205_3 then
						iter_205_3.color = arg_202_1.isInRecall_ and (arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_202_1.var_.actorSpriteComps1060 = nil
			end

			local var_205_2 = arg_202_1.actors_["1034"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.actorSpriteComps1034 == nil then
				arg_202_1.var_.actorSpriteComps1034 = var_205_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_3 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_3 and not isNil(var_205_2) then
				if arg_202_1.var_.actorSpriteComps1034 then
					for iter_205_4, iter_205_5 in pairs(arg_202_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_205_5 then
							if arg_202_1.isInRecall_ then
								iter_205_5.color = Color.New(Mathf.Lerp(iter_205_5.color.r, arg_202_1.hightColor2.r, (arg_202_1.time_ - 0) / var_205_3), Mathf.Lerp(iter_205_5.color.g, arg_202_1.hightColor2.g, (arg_202_1.time_ - 0) / var_205_3), (Mathf.Lerp(iter_205_5.color.b, arg_202_1.hightColor2.b, (arg_202_1.time_ - 0) / var_205_3)))
							else
								local var_205_4 = Mathf.Lerp(iter_205_5.color.r, 0.5, (arg_202_1.time_ - 0) / var_205_3)

								iter_205_5.color = Color.New(var_205_4, var_205_4, var_205_4)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= 0 + var_205_3 and arg_202_1.time_ < 0 + var_205_3 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.actorSpriteComps1034 then
				for iter_205_6, iter_205_7 in pairs(arg_202_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_205_7 then
						iter_205_7.color = arg_202_1.isInRecall_ and (arg_202_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_202_1.var_.actorSpriteComps1034 = nil
			end

			local var_205_5 = arg_202_1.actors_["1015"].transform

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1015 = var_205_5.localPosition
				var_205_5.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("1015", 7)

				for iter_205_8 = 0, var_205_5.childCount - 1 do
					local var_205_6 = var_205_5:GetChild(iter_205_8)

					if var_205_6.name == "" or not string.find(var_205_6.name, "split") then
						var_205_6.gameObject:SetActive(true)
					else
						var_205_6.gameObject:SetActive(false)
					end
				end
			end

			local var_205_7 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 then
				var_205_5.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_202_1.time_ - 0) / var_205_7)
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 then
				var_205_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_205_8 = arg_202_1.actors_["1060"].transform

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1060 = var_205_8.localPosition
				var_205_8.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("1060", 4)

				for iter_205_9 = 0, var_205_8.childCount - 1 do
					local var_205_9 = var_205_8:GetChild(iter_205_9)

					if var_205_9.name == "split_5" or not string.find(var_205_9.name, "split") then
						var_205_9.gameObject:SetActive(true)
					else
						var_205_9.gameObject:SetActive(false)
					end
				end
			end

			local var_205_10 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_10 then
				var_205_8.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_202_1.time_ - 0) / var_205_10)
			end

			if arg_202_1.time_ >= 0 + var_205_10 and arg_202_1.time_ < 0 + var_205_10 + arg_205_0 then
				var_205_8.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_205_11 = 0
			local var_205_12 = 0.075

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_11 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_13 = arg_202_1:GetWordFromCfg(417231049)
				local var_205_14 = arg_202_1:FormatText(var_205_13.content)

				arg_202_1.text_.text = var_205_14

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_16 = 3 <= 0 and var_205_12 or var_205_12 * (utf8.len(var_205_14) / 3)

				if (3 <= 0 and var_205_12 or var_205_12 * (utf8.len(var_205_14) / 3)) > 0 and var_205_12 < var_205_16 then
					arg_202_1.talkMaxDuration = var_205_16

					if var_205_16 + var_205_11 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_16 + var_205_11
					end
				end

				arg_202_1.text_.text = var_205_14
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231049", "story_v_out_417231.awb") ~= 0 then
					local var_205_17 = manager.audio:GetVoiceLength("story_v_out_417231", "417231049", "story_v_out_417231.awb") / 1000

					if var_205_17 + var_205_11 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_17 + var_205_11
					end

					if var_205_13.prefab_name ~= "" and arg_202_1.actors_[var_205_13.prefab_name] ~= nil then
						local var_205_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_13.prefab_name].transform, "story_v_out_417231", "417231049", "story_v_out_417231.awb")

						arg_202_1:RecordAudio("417231049", var_205_18)
						arg_202_1:RecordAudio("417231049", var_205_18)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_417231", "417231049", "story_v_out_417231.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_417231", "417231049", "story_v_out_417231.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_19 = math.max(var_205_12, arg_202_1.talkMaxDuration)

			if var_205_11 <= arg_202_1.time_ and arg_202_1.time_ < var_205_11 + var_205_19 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_11) / var_205_19

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_11 + var_205_19 and arg_202_1.time_ < var_205_11 + var_205_19 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play417231050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 417231050
		arg_206_1.duration_ = 4.87

		local var_206_0 = {
			zh = 4.866,
			ja = 4.766
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play417231051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1034"]) and arg_206_1.var_.actorSpriteComps1034 == nil then
				arg_206_1.var_.actorSpriteComps1034 = arg_206_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_0 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1034"]) then
				if arg_206_1.var_.actorSpriteComps1034 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								iter_209_1.color = Color.New(Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, (arg_206_1.time_ - 0) / var_209_0), Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, (arg_206_1.time_ - 0) / var_209_0), (Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, (arg_206_1.time_ - 0) / var_209_0)))
							else
								local var_209_1 = Mathf.Lerp(iter_209_1.color.r, 1, (arg_206_1.time_ - 0) / var_209_0)

								iter_209_1.color = Color.New(var_209_1, var_209_1, var_209_1)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1034"]) and arg_206_1.var_.actorSpriteComps1034 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_209_3 then
						iter_209_3.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_206_1.var_.actorSpriteComps1034 = nil
			end

			local var_209_2 = arg_206_1.actors_["1060"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps1060 == nil then
				arg_206_1.var_.actorSpriteComps1060 = var_209_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_3 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_3 and not isNil(var_209_2) then
				if arg_206_1.var_.actorSpriteComps1060 then
					for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_209_5 then
							if arg_206_1.isInRecall_ then
								iter_209_5.color = Color.New(Mathf.Lerp(iter_209_5.color.r, arg_206_1.hightColor2.r, (arg_206_1.time_ - 0) / var_209_3), Mathf.Lerp(iter_209_5.color.g, arg_206_1.hightColor2.g, (arg_206_1.time_ - 0) / var_209_3), (Mathf.Lerp(iter_209_5.color.b, arg_206_1.hightColor2.b, (arg_206_1.time_ - 0) / var_209_3)))
							else
								local var_209_4 = Mathf.Lerp(iter_209_5.color.r, 0.5, (arg_206_1.time_ - 0) / var_209_3)

								iter_209_5.color = Color.New(var_209_4, var_209_4, var_209_4)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_3 and arg_206_1.time_ < 0 + var_209_3 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps1060 then
				for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_209_7 then
						iter_209_7.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_206_1.var_.actorSpriteComps1060 = nil
			end

			local var_209_5 = arg_206_1.actors_["1015"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1015 = var_209_5.localPosition
				var_209_5.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1015", 4)

				for iter_209_8 = 0, var_209_5.childCount - 1 do
					local var_209_6 = var_209_5:GetChild(iter_209_8)

					if var_209_6.name == "" or not string.find(var_209_6.name, "split") then
						var_209_6.gameObject:SetActive(true)
					else
						var_209_6.gameObject:SetActive(false)
					end
				end
			end

			local var_209_7 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				var_209_5.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_206_1.time_ - 0) / var_209_7)
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				var_209_5.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_209_8 = arg_206_1.actors_["1060"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1060 = var_209_8.localPosition
				var_209_8.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1060", 4)

				for iter_209_9 = 0, var_209_8.childCount - 1 do
					local var_209_9 = var_209_8:GetChild(iter_209_9)

					if var_209_9.name == "" or not string.find(var_209_9.name, "split") then
						var_209_9.gameObject:SetActive(true)
					else
						var_209_9.gameObject:SetActive(false)
					end
				end
			end

			local var_209_10 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_10 then
				var_209_8.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_206_1.time_ - 0) / var_209_10)
			end

			if arg_206_1.time_ >= 0 + var_209_10 and arg_206_1.time_ < 0 + var_209_10 + arg_209_0 then
				var_209_8.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_209_11 = 0
			local var_209_12 = 0.65

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_11 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_13 = arg_206_1:GetWordFromCfg(417231050)
				local var_209_14 = arg_206_1:FormatText(var_209_13.content)

				arg_206_1.text_.text = var_209_14

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_16 = 26 <= 0 and var_209_12 or var_209_12 * (utf8.len(var_209_14) / 26)

				if (26 <= 0 and var_209_12 or var_209_12 * (utf8.len(var_209_14) / 26)) > 0 and var_209_12 < var_209_16 then
					arg_206_1.talkMaxDuration = var_209_16

					if var_209_16 + var_209_11 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_16 + var_209_11
					end
				end

				arg_206_1.text_.text = var_209_14
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231050", "story_v_out_417231.awb") ~= 0 then
					local var_209_17 = manager.audio:GetVoiceLength("story_v_out_417231", "417231050", "story_v_out_417231.awb") / 1000

					if var_209_17 + var_209_11 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_17 + var_209_11
					end

					if var_209_13.prefab_name ~= "" and arg_206_1.actors_[var_209_13.prefab_name] ~= nil then
						local var_209_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_13.prefab_name].transform, "story_v_out_417231", "417231050", "story_v_out_417231.awb")

						arg_206_1:RecordAudio("417231050", var_209_18)
						arg_206_1:RecordAudio("417231050", var_209_18)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_417231", "417231050", "story_v_out_417231.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_417231", "417231050", "story_v_out_417231.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_19 = math.max(var_209_12, arg_206_1.talkMaxDuration)

			if var_209_11 <= arg_206_1.time_ and arg_206_1.time_ < var_209_11 + var_209_19 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_11) / var_209_19

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_11 + var_209_19 and arg_206_1.time_ < var_209_11 + var_209_19 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play417231051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 417231051
		arg_210_1.duration_ = 2.4

		local var_210_0 = {
			zh = 2.4,
			ja = 1.866
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play417231052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1015"]) and arg_210_1.var_.actorSpriteComps1015 == nil then
				arg_210_1.var_.actorSpriteComps1015 = arg_210_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1015"]) then
				if arg_210_1.var_.actorSpriteComps1015 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								iter_213_1.color = Color.New(Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor1.r, (arg_210_1.time_ - 0) / var_213_0), Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor1.g, (arg_210_1.time_ - 0) / var_213_0), (Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor1.b, (arg_210_1.time_ - 0) / var_213_0)))
							else
								local var_213_1 = Mathf.Lerp(iter_213_1.color.r, 1, (arg_210_1.time_ - 0) / var_213_0)

								iter_213_1.color = Color.New(var_213_1, var_213_1, var_213_1)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1015"]) and arg_210_1.var_.actorSpriteComps1015 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_213_3 then
						iter_213_3.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_210_1.var_.actorSpriteComps1015 = nil
			end

			local var_213_2 = arg_210_1.actors_["1034"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps1034 == nil then
				arg_210_1.var_.actorSpriteComps1034 = var_213_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_3 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_3 and not isNil(var_213_2) then
				if arg_210_1.var_.actorSpriteComps1034 then
					for iter_213_4, iter_213_5 in pairs(arg_210_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_213_5 then
							if arg_210_1.isInRecall_ then
								iter_213_5.color = Color.New(Mathf.Lerp(iter_213_5.color.r, arg_210_1.hightColor2.r, (arg_210_1.time_ - 0) / var_213_3), Mathf.Lerp(iter_213_5.color.g, arg_210_1.hightColor2.g, (arg_210_1.time_ - 0) / var_213_3), (Mathf.Lerp(iter_213_5.color.b, arg_210_1.hightColor2.b, (arg_210_1.time_ - 0) / var_213_3)))
							else
								local var_213_4 = Mathf.Lerp(iter_213_5.color.r, 0.5, (arg_210_1.time_ - 0) / var_213_3)

								iter_213_5.color = Color.New(var_213_4, var_213_4, var_213_4)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_3 and arg_210_1.time_ < 0 + var_213_3 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps1034 then
				for iter_213_6, iter_213_7 in pairs(arg_210_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_213_7 then
						iter_213_7.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_210_1.var_.actorSpriteComps1034 = nil
			end

			local var_213_5 = arg_210_1.actors_["1015"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1015 = var_213_5.localPosition
				var_213_5.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("1015", 4)

				for iter_213_8 = 0, var_213_5.childCount - 1 do
					local var_213_6 = var_213_5:GetChild(iter_213_8)

					if var_213_6.name == "split_1" or not string.find(var_213_6.name, "split") then
						var_213_6.gameObject:SetActive(true)
					else
						var_213_6.gameObject:SetActive(false)
					end
				end
			end

			local var_213_7 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_7 then
				var_213_5.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1015, Vector3.New(390, -349.1, -288), (arg_210_1.time_ - 0) / var_213_7)
			end

			if arg_210_1.time_ >= 0 + var_213_7 and arg_210_1.time_ < 0 + var_213_7 + arg_213_0 then
				var_213_5.localPosition = Vector3.New(390, -349.1, -288)
			end

			local var_213_8 = 0
			local var_213_9 = 0.2

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_8 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_10 = arg_210_1:GetWordFromCfg(417231051)
				local var_213_11 = arg_210_1:FormatText(var_213_10.content)

				arg_210_1.text_.text = var_213_11

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_13 = 8 <= 0 and var_213_9 or var_213_9 * (utf8.len(var_213_11) / 8)

				if (8 <= 0 and var_213_9 or var_213_9 * (utf8.len(var_213_11) / 8)) > 0 and var_213_9 < var_213_13 then
					arg_210_1.talkMaxDuration = var_213_13

					if var_213_13 + var_213_8 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_13 + var_213_8
					end
				end

				arg_210_1.text_.text = var_213_11
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231051", "story_v_out_417231.awb") ~= 0 then
					local var_213_14 = manager.audio:GetVoiceLength("story_v_out_417231", "417231051", "story_v_out_417231.awb") / 1000

					if var_213_14 + var_213_8 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_14 + var_213_8
					end

					if var_213_10.prefab_name ~= "" and arg_210_1.actors_[var_213_10.prefab_name] ~= nil then
						local var_213_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_10.prefab_name].transform, "story_v_out_417231", "417231051", "story_v_out_417231.awb")

						arg_210_1:RecordAudio("417231051", var_213_15)
						arg_210_1:RecordAudio("417231051", var_213_15)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_417231", "417231051", "story_v_out_417231.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_417231", "417231051", "story_v_out_417231.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_16 = math.max(var_213_9, arg_210_1.talkMaxDuration)

			if var_213_8 <= arg_210_1.time_ and arg_210_1.time_ < var_213_8 + var_213_16 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_8) / var_213_16

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_8 + var_213_16 and arg_210_1.time_ < var_213_8 + var_213_16 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play417231052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417231052
		arg_214_1.duration_ = 6

		local var_214_0 = {
			zh = 3.6,
			ja = 6
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play417231053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1034"]) and arg_214_1.var_.actorSpriteComps1034 == nil then
				arg_214_1.var_.actorSpriteComps1034 = arg_214_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_0 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1034"]) then
				if arg_214_1.var_.actorSpriteComps1034 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								iter_217_1.color = Color.New(Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor1.r, (arg_214_1.time_ - 0) / var_217_0), Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor1.g, (arg_214_1.time_ - 0) / var_217_0), (Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor1.b, (arg_214_1.time_ - 0) / var_217_0)))
							else
								local var_217_1 = Mathf.Lerp(iter_217_1.color.r, 1, (arg_214_1.time_ - 0) / var_217_0)

								iter_217_1.color = Color.New(var_217_1, var_217_1, var_217_1)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1034"]) and arg_214_1.var_.actorSpriteComps1034 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_217_3 then
						iter_217_3.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_214_1.var_.actorSpriteComps1034 = nil
			end

			local var_217_2 = arg_214_1.actors_["1015"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.actorSpriteComps1015 == nil then
				arg_214_1.var_.actorSpriteComps1015 = var_217_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_3 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_3 and not isNil(var_217_2) then
				if arg_214_1.var_.actorSpriteComps1015 then
					for iter_217_4, iter_217_5 in pairs(arg_214_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_217_5 then
							if arg_214_1.isInRecall_ then
								iter_217_5.color = Color.New(Mathf.Lerp(iter_217_5.color.r, arg_214_1.hightColor2.r, (arg_214_1.time_ - 0) / var_217_3), Mathf.Lerp(iter_217_5.color.g, arg_214_1.hightColor2.g, (arg_214_1.time_ - 0) / var_217_3), (Mathf.Lerp(iter_217_5.color.b, arg_214_1.hightColor2.b, (arg_214_1.time_ - 0) / var_217_3)))
							else
								local var_217_4 = Mathf.Lerp(iter_217_5.color.r, 0.5, (arg_214_1.time_ - 0) / var_217_3)

								iter_217_5.color = Color.New(var_217_4, var_217_4, var_217_4)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_3 and arg_214_1.time_ < 0 + var_217_3 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.actorSpriteComps1015 then
				for iter_217_6, iter_217_7 in pairs(arg_214_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_217_7 then
						iter_217_7.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_214_1.var_.actorSpriteComps1015 = nil
			end

			local var_217_5 = 0
			local var_217_6 = 0.475

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_7 = arg_214_1:GetWordFromCfg(417231052)
				local var_217_8 = arg_214_1:FormatText(var_217_7.content)

				arg_214_1.text_.text = var_217_8

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_10 = 19 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_8) / 19)

				if (19 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_8) / 19)) > 0 and var_217_6 < var_217_10 then
					arg_214_1.talkMaxDuration = var_217_10

					if var_217_10 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_5
					end
				end

				arg_214_1.text_.text = var_217_8
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231052", "story_v_out_417231.awb") ~= 0 then
					local var_217_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231052", "story_v_out_417231.awb") / 1000

					if var_217_11 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_11 + var_217_5
					end

					if var_217_7.prefab_name ~= "" and arg_214_1.actors_[var_217_7.prefab_name] ~= nil then
						local var_217_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_7.prefab_name].transform, "story_v_out_417231", "417231052", "story_v_out_417231.awb")

						arg_214_1:RecordAudio("417231052", var_217_12)
						arg_214_1:RecordAudio("417231052", var_217_12)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417231", "417231052", "story_v_out_417231.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417231", "417231052", "story_v_out_417231.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_13 = math.max(var_217_6, arg_214_1.talkMaxDuration)

			if var_217_5 <= arg_214_1.time_ and arg_214_1.time_ < var_217_5 + var_217_13 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_5) / var_217_13

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_5 + var_217_13 and arg_214_1.time_ < var_217_5 + var_217_13 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play417231053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417231053
		arg_218_1.duration_ = 2.73

		local var_218_0 = {
			zh = 2.433,
			ja = 2.733
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play417231054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1015"]) and arg_218_1.var_.actorSpriteComps1015 == nil then
				arg_218_1.var_.actorSpriteComps1015 = arg_218_1.actors_["1015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_0 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1015"]) then
				if arg_218_1.var_.actorSpriteComps1015 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps1015:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								iter_221_1.color = Color.New(Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor1.r, (arg_218_1.time_ - 0) / var_221_0), Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor1.g, (arg_218_1.time_ - 0) / var_221_0), (Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor1.b, (arg_218_1.time_ - 0) / var_221_0)))
							else
								local var_221_1 = Mathf.Lerp(iter_221_1.color.r, 1, (arg_218_1.time_ - 0) / var_221_0)

								iter_221_1.color = Color.New(var_221_1, var_221_1, var_221_1)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1015"]) and arg_218_1.var_.actorSpriteComps1015 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps1015:ToTable()) do
					if iter_221_3 then
						iter_221_3.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_218_1.var_.actorSpriteComps1015 = nil
			end

			local var_221_2 = arg_218_1.actors_["1034"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.actorSpriteComps1034 == nil then
				arg_218_1.var_.actorSpriteComps1034 = var_221_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_3 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 and not isNil(var_221_2) then
				if arg_218_1.var_.actorSpriteComps1034 then
					for iter_221_4, iter_221_5 in pairs(arg_218_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_221_5 then
							if arg_218_1.isInRecall_ then
								iter_221_5.color = Color.New(Mathf.Lerp(iter_221_5.color.r, arg_218_1.hightColor2.r, (arg_218_1.time_ - 0) / var_221_3), Mathf.Lerp(iter_221_5.color.g, arg_218_1.hightColor2.g, (arg_218_1.time_ - 0) / var_221_3), (Mathf.Lerp(iter_221_5.color.b, arg_218_1.hightColor2.b, (arg_218_1.time_ - 0) / var_221_3)))
							else
								local var_221_4 = Mathf.Lerp(iter_221_5.color.r, 0.5, (arg_218_1.time_ - 0) / var_221_3)

								iter_221_5.color = Color.New(var_221_4, var_221_4, var_221_4)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.actorSpriteComps1034 then
				for iter_221_6, iter_221_7 in pairs(arg_218_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_221_7 then
						iter_221_7.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_218_1.var_.actorSpriteComps1034 = nil
			end

			local var_221_5 = 0
			local var_221_6 = 0.35

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_7 = arg_218_1:GetWordFromCfg(417231053)
				local var_221_8 = arg_218_1:FormatText(var_221_7.content)

				arg_218_1.text_.text = var_221_8

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_10 = 14 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_8) / 14)

				if (14 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_8) / 14)) > 0 and var_221_6 < var_221_10 then
					arg_218_1.talkMaxDuration = var_221_10

					if var_221_10 + var_221_5 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_5
					end
				end

				arg_218_1.text_.text = var_221_8
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231053", "story_v_out_417231.awb") ~= 0 then
					local var_221_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231053", "story_v_out_417231.awb") / 1000

					if var_221_11 + var_221_5 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_11 + var_221_5
					end

					if var_221_7.prefab_name ~= "" and arg_218_1.actors_[var_221_7.prefab_name] ~= nil then
						local var_221_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_7.prefab_name].transform, "story_v_out_417231", "417231053", "story_v_out_417231.awb")

						arg_218_1:RecordAudio("417231053", var_221_12)
						arg_218_1:RecordAudio("417231053", var_221_12)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_417231", "417231053", "story_v_out_417231.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_417231", "417231053", "story_v_out_417231.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_13 = math.max(var_221_6, arg_218_1.talkMaxDuration)

			if var_221_5 <= arg_218_1.time_ and arg_218_1.time_ < var_221_5 + var_221_13 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_5) / var_221_13

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_5 + var_221_13 and arg_218_1.time_ < var_221_5 + var_221_13 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play417231054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417231054
		arg_222_1.duration_ = 10.43

		local var_222_0 = {
			zh = 10.433,
			ja = 7.733
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play417231055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 1.2

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:GetWordFromCfg(417231054)
				local var_225_2 = arg_222_1:FormatText(var_225_1.content)

				arg_222_1.text_.text = var_225_2

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 48 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 48)

				if (48 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 48)) > 0 and var_225_0 < var_225_4 then
					arg_222_1.talkMaxDuration = var_225_4

					if var_225_4 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_4 + 0
					end
				end

				arg_222_1.text_.text = var_225_2
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231054", "story_v_out_417231.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231054", "story_v_out_417231.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_out_417231", "417231054", "story_v_out_417231.awb")

						arg_222_1:RecordAudio("417231054", var_225_6)
						arg_222_1:RecordAudio("417231054", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_417231", "417231054", "story_v_out_417231.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_417231", "417231054", "story_v_out_417231.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play417231055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417231055
		arg_226_1.duration_ = 11.5

		local var_226_0 = {
			zh = 11.5,
			ja = 11.333
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
				arg_226_0:Play417231056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 1.4

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_1 = arg_226_1:GetWordFromCfg(417231055)
				local var_229_2 = arg_226_1:FormatText(var_229_1.content)

				arg_226_1.text_.text = var_229_2

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_4 = 56 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 56)

				if (56 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 56)) > 0 and var_229_0 < var_229_4 then
					arg_226_1.talkMaxDuration = var_229_4

					if var_229_4 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_4 + 0
					end
				end

				arg_226_1.text_.text = var_229_2
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231055", "story_v_out_417231.awb") ~= 0 then
					local var_229_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231055", "story_v_out_417231.awb") / 1000

					if var_229_5 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + 0
					end

					if var_229_1.prefab_name ~= "" and arg_226_1.actors_[var_229_1.prefab_name] ~= nil then
						local var_229_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_1.prefab_name].transform, "story_v_out_417231", "417231055", "story_v_out_417231.awb")

						arg_226_1:RecordAudio("417231055", var_229_6)
						arg_226_1:RecordAudio("417231055", var_229_6)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_417231", "417231055", "story_v_out_417231.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_417231", "417231055", "story_v_out_417231.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_7 and arg_226_1.time_ < 0 + var_229_7 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play417231056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 417231056
		arg_230_1.duration_ = 8.23

		local var_230_0 = {
			zh = 8.233,
			ja = 6.366
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play417231057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.825

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:GetWordFromCfg(417231056)
				local var_233_2 = arg_230_1:FormatText(var_233_1.content)

				arg_230_1.text_.text = var_233_2

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 33 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 33)

				if (33 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 33)) > 0 and var_233_0 < var_233_4 then
					arg_230_1.talkMaxDuration = var_233_4

					if var_233_4 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_4 + 0
					end
				end

				arg_230_1.text_.text = var_233_2
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231056", "story_v_out_417231.awb") ~= 0 then
					local var_233_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231056", "story_v_out_417231.awb") / 1000

					if var_233_5 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + 0
					end

					if var_233_1.prefab_name ~= "" and arg_230_1.actors_[var_233_1.prefab_name] ~= nil then
						local var_233_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_1.prefab_name].transform, "story_v_out_417231", "417231056", "story_v_out_417231.awb")

						arg_230_1:RecordAudio("417231056", var_233_6)
						arg_230_1:RecordAudio("417231056", var_233_6)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_417231", "417231056", "story_v_out_417231.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_417231", "417231056", "story_v_out_417231.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play417231057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 417231057
		arg_234_1.duration_ = 9

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play417231058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 4 < arg_234_1.time_ and arg_234_1.time_ <= 4 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			if arg_234_1.time_ >= 4 + 0.833333333333333 and arg_234_1.time_ < 4 + 0.833333333333333 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end

			if 2 < arg_234_1.time_ and arg_234_1.time_ <= 2 + arg_237_0 then
				local var_237_0 = arg_234_1.bgs_.ST01

				arg_234_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_237_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_237_1 = var_237_0:GetComponent("SpriteRenderer")

				if var_237_1 and var_237_1.sprite then
					local var_237_2 = 2 * (var_237_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_237_0.transform.localScale = Vector3.New(var_237_2 / var_237_1.sprite.bounds.size.y < var_237_2 * manager.ui.mainCameraCom_.aspect / var_237_1.sprite.bounds.size.x and var_237_2 * manager.ui.mainCameraCom_.aspect / var_237_1.sprite.bounds.size.x or var_237_2 / var_237_1.sprite.bounds.size.y, var_237_2 / var_237_1.sprite.bounds.size.y < var_237_2 * manager.ui.mainCameraCom_.aspect / var_237_1.sprite.bounds.size.x and var_237_2 * manager.ui.mainCameraCom_.aspect / var_237_1.sprite.bounds.size.x or var_237_2 / var_237_1.sprite.bounds.size.y, 0)
				end

				for iter_237_0, iter_237_1 in pairs(arg_234_1.bgs_) do
					if iter_237_0 ~= "ST01" then
						iter_237_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_237_3 = 0

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_3 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_4 = 2

			if var_237_3 <= arg_234_1.time_ and arg_234_1.time_ < var_237_3 + var_237_4 then
				local var_237_5 = Color.New(0, 0, 0)

				var_237_5.a = Mathf.Lerp(0, 1, (arg_234_1.time_ - var_237_3) / var_237_4)
				arg_234_1.mask_.color = var_237_5
			end

			if arg_234_1.time_ >= var_237_3 + var_237_4 and arg_234_1.time_ < var_237_3 + var_237_4 + arg_237_0 then
				local var_237_6 = Color.New(0, 0, 0)

				var_237_6.a = 1
				arg_234_1.mask_.color = var_237_6
			end

			local var_237_7 = 2

			if 2 < arg_234_1.time_ and arg_234_1.time_ <= var_237_7 + arg_237_0 then
				arg_234_1.mask_.enabled = true
				arg_234_1.mask_.raycastTarget = true

				arg_234_1:SetGaussion(false)
			end

			local var_237_8 = 2

			if var_237_7 <= arg_234_1.time_ and arg_234_1.time_ < var_237_7 + var_237_8 then
				local var_237_9 = Color.New(0, 0, 0)

				var_237_9.a = Mathf.Lerp(1, 0, (arg_234_1.time_ - var_237_7) / var_237_8)
				arg_234_1.mask_.color = var_237_9
			end

			if arg_234_1.time_ >= var_237_7 + var_237_8 and arg_234_1.time_ < var_237_7 + var_237_8 + arg_237_0 then
				local var_237_10 = Color.New(0, 0, 0)

				arg_234_1.mask_.enabled = false
				var_237_10.a = 0
				arg_234_1.mask_.color = var_237_10
			end

			local var_237_11 = arg_234_1.actors_["1034"].transform

			if 2 < arg_234_1.time_ and arg_234_1.time_ <= 2 + arg_237_0 then
				arg_234_1.var_.moveOldPos1034 = var_237_11.localPosition
				var_237_11.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("1034", 7)

				for iter_237_2 = 0, var_237_11.childCount - 1 do
					local var_237_12 = var_237_11:GetChild(iter_237_2)

					if var_237_12.name == "" or not string.find(var_237_12.name, "split") then
						var_237_12.gameObject:SetActive(true)
					else
						var_237_12.gameObject:SetActive(false)
					end
				end
			end

			local var_237_13 = 0.001

			if 2 <= arg_234_1.time_ and arg_234_1.time_ < 2 + var_237_13 then
				var_237_11.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_234_1.time_ - 2) / var_237_13)
			end

			if arg_234_1.time_ >= 2 + var_237_13 and arg_234_1.time_ < 2 + var_237_13 + arg_237_0 then
				var_237_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_237_14 = arg_234_1.actors_["1015"].transform

			if 2 < arg_234_1.time_ and arg_234_1.time_ <= 2 + arg_237_0 then
				arg_234_1.var_.moveOldPos1015 = var_237_14.localPosition
				var_237_14.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("1015", 7)

				for iter_237_3 = 0, var_237_14.childCount - 1 do
					local var_237_15 = var_237_14:GetChild(iter_237_3)

					if var_237_15.name == "" or not string.find(var_237_15.name, "split") then
						var_237_15.gameObject:SetActive(true)
					else
						var_237_15.gameObject:SetActive(false)
					end
				end
			end

			local var_237_16 = 0.001

			if 2 <= arg_234_1.time_ and arg_234_1.time_ < 2 + var_237_16 then
				var_237_14.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1015, Vector3.New(0, -2000, 0), (arg_234_1.time_ - 2) / var_237_16)
			end

			if arg_234_1.time_ >= 2 + var_237_16 and arg_234_1.time_ < 2 + var_237_16 + arg_237_0 then
				var_237_14.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_237_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_234_1.bgmTxt_.text ~= var_237_19 and arg_234_1.bgmTxt_.text ~= "" then
						if arg_234_1.bgmTxt2_.text ~= "" then
							arg_234_1.bgmTxt_.text = arg_234_1.bgmTxt2_.text
						end

						arg_234_1.bgmTxt2_.text = var_237_19

						arg_234_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_234_1.bgmTxt_.text = var_237_19
						arg_234_1.bgmTxt2_.text = var_237_19
					end

					if arg_234_1.bgmTimer then
						arg_234_1.bgmTimer:Stop()

						arg_234_1.bgmTimer = nil
					end

					if arg_234_1.settingData.show_music_name == 1 then
						arg_234_1.musicController:SetSelectedState("show")
						arg_234_1.musicAnimator_:Play("open", 0, 0)

						if arg_234_1.settingData.music_time ~= 0 then
							arg_234_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_234_1.settingData.music_time), function()
								if arg_234_1 == nil or isNil(arg_234_1.bgmTxt_) then
									return
								end

								arg_234_1.musicController:SetSelectedState("hide")
								arg_234_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.53333333333333 < arg_234_1.time_ and arg_234_1.time_ <= 1.53333333333333 + arg_237_0 then
				arg_234_1:AudioAction("play", "music", "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily.awb")

				local var_237_22 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily")

				if "" ~= "" then
					if arg_234_1.bgmTxt_.text ~= var_237_22 and arg_234_1.bgmTxt_.text ~= "" then
						if arg_234_1.bgmTxt2_.text ~= "" then
							arg_234_1.bgmTxt_.text = arg_234_1.bgmTxt2_.text
						end

						arg_234_1.bgmTxt2_.text = var_237_22

						arg_234_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_234_1.bgmTxt_.text = var_237_22
						arg_234_1.bgmTxt2_.text = var_237_22
					end

					if arg_234_1.bgmTimer then
						arg_234_1.bgmTimer:Stop()

						arg_234_1.bgmTimer = nil
					end

					if arg_234_1.settingData.show_music_name == 1 then
						arg_234_1.musicController:SetSelectedState("show")
						arg_234_1.musicAnimator_:Play("open", 0, 0)

						if arg_234_1.settingData.music_time ~= 0 then
							arg_234_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_234_1.settingData.music_time), function()
								if arg_234_1 == nil or isNil(arg_234_1.bgmTxt_) then
									return
								end

								arg_234_1.musicController:SetSelectedState("hide")
								arg_234_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 3.7 < arg_234_1.time_ and arg_234_1.time_ <= 3.7 + arg_237_0 then
				arg_234_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_thunder02", "")
			end

			if arg_234_1.frameCnt_ <= 1 then
				arg_234_1.dialog_:SetActive(false)
			end

			local var_237_24 = 4
			local var_237_25 = 1.475

			if 4 < arg_234_1.time_ and arg_234_1.time_ <= var_237_24 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0

				arg_234_1.dialog_:SetActive(true)

				arg_234_1.dialogCg_.alpha = 0

				local var_237_26 = LeanTween.value(arg_234_1.dialog_, 0, 1, 0.3)

				var_237_26:setOnUpdate(LuaHelper.FloatAction(function(arg_240_0)
					arg_234_1.dialogCg_.alpha = arg_240_0
				end))
				var_237_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_234_1.dialog_)
					var_237_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_234_1.duration_ = arg_234_1.duration_ + 0.3

				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_27 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(417231057).content)

				arg_234_1.text_.text = var_237_27

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_29 = 59 <= 0 and var_237_25 or var_237_25 * (utf8.len(var_237_27) / 59)

				if (59 <= 0 and var_237_25 or var_237_25 * (utf8.len(var_237_27) / 59)) > 0 and var_237_25 < var_237_29 then
					arg_234_1.talkMaxDuration = var_237_29
					var_237_24 = var_237_24 + 0.3

					if var_237_29 + var_237_24 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_29 + var_237_24
					end
				end

				arg_234_1.text_.text = var_237_27
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_30 = var_237_24 + 0.3
			local var_237_31 = math.max(var_237_25, arg_234_1.talkMaxDuration)

			if var_237_24 + 0.3 <= arg_234_1.time_ and arg_234_1.time_ < var_237_30 + var_237_31 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_30) / var_237_31

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_30 + var_237_31 and arg_234_1.time_ < var_237_30 + var_237_31 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play417231058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 417231058
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play417231059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 1.325

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_1 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(417231058).content)

				arg_242_1.text_.text = var_245_1

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_3 = 53 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 53)

				if (53 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 53)) > 0 and var_245_0 < var_245_3 then
					arg_242_1.talkMaxDuration = var_245_3

					if var_245_3 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_3 + 0
					end
				end

				arg_242_1.text_.text = var_245_1
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_4 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_4

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play417231059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 417231059
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play417231060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 1.475

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(417231059).content)

				arg_246_1.text_.text = var_249_1

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_3 = 59 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 59)

				if (59 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_1) / 59)) > 0 and var_249_0 < var_249_3 then
					arg_246_1.talkMaxDuration = var_249_3

					if var_249_3 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_3 + 0
					end
				end

				arg_246_1.text_.text = var_249_1
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_4 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_4

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play417231060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 417231060
		arg_250_1.duration_ = 4.67

		local var_250_0 = {
			zh = 3.733,
			ja = 4.666
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play417231061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1060"]) and arg_250_1.var_.actorSpriteComps1060 == nil then
				arg_250_1.var_.actorSpriteComps1060 = arg_250_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_0 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1060"]) then
				if arg_250_1.var_.actorSpriteComps1060 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								iter_253_1.color = Color.New(Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor1.r, (arg_250_1.time_ - 0) / var_253_0), Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor1.g, (arg_250_1.time_ - 0) / var_253_0), (Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor1.b, (arg_250_1.time_ - 0) / var_253_0)))
							else
								local var_253_1 = Mathf.Lerp(iter_253_1.color.r, 1, (arg_250_1.time_ - 0) / var_253_0)

								iter_253_1.color = Color.New(var_253_1, var_253_1, var_253_1)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1060"]) and arg_250_1.var_.actorSpriteComps1060 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_253_3 then
						iter_253_3.color = arg_250_1.isInRecall_ and (arg_250_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_250_1.var_.actorSpriteComps1060 = nil
			end

			local var_253_2 = arg_250_1.actors_["1060"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1060 = var_253_2.localPosition
				var_253_2.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("1060", 3)

				for iter_253_4 = 0, var_253_2.childCount - 1 do
					local var_253_3 = var_253_2:GetChild(iter_253_4)

					if var_253_3.name == "" or not string.find(var_253_3.name, "split") then
						var_253_3.gameObject:SetActive(true)
					else
						var_253_3.gameObject:SetActive(false)
					end
				end
			end

			local var_253_4 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				var_253_2.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1060, Vector3.New(33.4, -430.8, 6.9), (arg_250_1.time_ - 0) / var_253_4)
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				var_253_2.localPosition = Vector3.New(33.4, -430.8, 6.9)
			end

			local var_253_5 = 0
			local var_253_6 = 0.475

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_7 = arg_250_1:GetWordFromCfg(417231060)
				local var_253_8 = arg_250_1:FormatText(var_253_7.content)

				arg_250_1.text_.text = var_253_8

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_10 = 19 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_8) / 19)

				if (19 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_8) / 19)) > 0 and var_253_6 < var_253_10 then
					arg_250_1.talkMaxDuration = var_253_10

					if var_253_10 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_10 + var_253_5
					end
				end

				arg_250_1.text_.text = var_253_8
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231060", "story_v_out_417231.awb") ~= 0 then
					local var_253_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231060", "story_v_out_417231.awb") / 1000

					if var_253_11 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_11 + var_253_5
					end

					if var_253_7.prefab_name ~= "" and arg_250_1.actors_[var_253_7.prefab_name] ~= nil then
						local var_253_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_7.prefab_name].transform, "story_v_out_417231", "417231060", "story_v_out_417231.awb")

						arg_250_1:RecordAudio("417231060", var_253_12)
						arg_250_1:RecordAudio("417231060", var_253_12)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_417231", "417231060", "story_v_out_417231.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_417231", "417231060", "story_v_out_417231.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_13 = math.max(var_253_6, arg_250_1.talkMaxDuration)

			if var_253_5 <= arg_250_1.time_ and arg_250_1.time_ < var_253_5 + var_253_13 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_5) / var_253_13

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_5 + var_253_13 and arg_250_1.time_ < var_253_5 + var_253_13 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play417231061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 417231061
		arg_254_1.duration_ = 6.1

		local var_254_0 = {
			zh = 2.366,
			ja = 6.1
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play417231062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1034"]) and arg_254_1.var_.actorSpriteComps1034 == nil then
				arg_254_1.var_.actorSpriteComps1034 = arg_254_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_0 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1034"]) then
				if arg_254_1.var_.actorSpriteComps1034 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								iter_257_1.color = Color.New(Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor1.r, (arg_254_1.time_ - 0) / var_257_0), Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor1.g, (arg_254_1.time_ - 0) / var_257_0), (Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor1.b, (arg_254_1.time_ - 0) / var_257_0)))
							else
								local var_257_1 = Mathf.Lerp(iter_257_1.color.r, 1, (arg_254_1.time_ - 0) / var_257_0)

								iter_257_1.color = Color.New(var_257_1, var_257_1, var_257_1)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1034"]) and arg_254_1.var_.actorSpriteComps1034 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_257_3 then
						iter_257_3.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_254_1.var_.actorSpriteComps1034 = nil
			end

			local var_257_2 = arg_254_1.actors_["1060"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_2) and arg_254_1.var_.actorSpriteComps1060 == nil then
				arg_254_1.var_.actorSpriteComps1060 = var_257_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_3 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_3 and not isNil(var_257_2) then
				if arg_254_1.var_.actorSpriteComps1060 then
					for iter_257_4, iter_257_5 in pairs(arg_254_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_257_5 then
							if arg_254_1.isInRecall_ then
								iter_257_5.color = Color.New(Mathf.Lerp(iter_257_5.color.r, arg_254_1.hightColor2.r, (arg_254_1.time_ - 0) / var_257_3), Mathf.Lerp(iter_257_5.color.g, arg_254_1.hightColor2.g, (arg_254_1.time_ - 0) / var_257_3), (Mathf.Lerp(iter_257_5.color.b, arg_254_1.hightColor2.b, (arg_254_1.time_ - 0) / var_257_3)))
							else
								local var_257_4 = Mathf.Lerp(iter_257_5.color.r, 0.5, (arg_254_1.time_ - 0) / var_257_3)

								iter_257_5.color = Color.New(var_257_4, var_257_4, var_257_4)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_3 and arg_254_1.time_ < 0 + var_257_3 + arg_257_0 and not isNil(var_257_2) and arg_254_1.var_.actorSpriteComps1060 then
				for iter_257_6, iter_257_7 in pairs(arg_254_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_257_7 then
						iter_257_7.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_254_1.var_.actorSpriteComps1060 = nil
			end

			local var_257_5 = arg_254_1.actors_["1034"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1034 = var_257_5.localPosition
				var_257_5.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("1034", 3)

				for iter_257_8 = 0, var_257_5.childCount - 1 do
					local var_257_6 = var_257_5:GetChild(iter_257_8)

					if var_257_6.name == "split_1" or not string.find(var_257_6.name, "split") then
						var_257_6.gameObject:SetActive(true)
					else
						var_257_6.gameObject:SetActive(false)
					end
				end
			end

			local var_257_7 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 then
				var_257_5.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_254_1.time_ - 0) / var_257_7)
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 then
				var_257_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_257_8 = arg_254_1.actors_["1060"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1060 = var_257_8.localPosition
				var_257_8.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("1060", 7)

				for iter_257_9 = 0, var_257_8.childCount - 1 do
					local var_257_9 = var_257_8:GetChild(iter_257_9)

					if var_257_9.name == "" or not string.find(var_257_9.name, "split") then
						var_257_9.gameObject:SetActive(true)
					else
						var_257_9.gameObject:SetActive(false)
					end
				end
			end

			local var_257_10 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_10 then
				var_257_8.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_254_1.time_ - 0) / var_257_10)
			end

			if arg_254_1.time_ >= 0 + var_257_10 and arg_254_1.time_ < 0 + var_257_10 + arg_257_0 then
				var_257_8.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_257_11 = 0
			local var_257_12 = 0.2

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_11 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_13 = arg_254_1:GetWordFromCfg(417231061)
				local var_257_14 = arg_254_1:FormatText(var_257_13.content)

				arg_254_1.text_.text = var_257_14

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_16 = 8 <= 0 and var_257_12 or var_257_12 * (utf8.len(var_257_14) / 8)

				if (8 <= 0 and var_257_12 or var_257_12 * (utf8.len(var_257_14) / 8)) > 0 and var_257_12 < var_257_16 then
					arg_254_1.talkMaxDuration = var_257_16

					if var_257_16 + var_257_11 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_16 + var_257_11
					end
				end

				arg_254_1.text_.text = var_257_14
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231061", "story_v_out_417231.awb") ~= 0 then
					local var_257_17 = manager.audio:GetVoiceLength("story_v_out_417231", "417231061", "story_v_out_417231.awb") / 1000

					if var_257_17 + var_257_11 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_17 + var_257_11
					end

					if var_257_13.prefab_name ~= "" and arg_254_1.actors_[var_257_13.prefab_name] ~= nil then
						local var_257_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_13.prefab_name].transform, "story_v_out_417231", "417231061", "story_v_out_417231.awb")

						arg_254_1:RecordAudio("417231061", var_257_18)
						arg_254_1:RecordAudio("417231061", var_257_18)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_417231", "417231061", "story_v_out_417231.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_417231", "417231061", "story_v_out_417231.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_19 = math.max(var_257_12, arg_254_1.talkMaxDuration)

			if var_257_11 <= arg_254_1.time_ and arg_254_1.time_ < var_257_11 + var_257_19 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_11) / var_257_19

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_11 + var_257_19 and arg_254_1.time_ < var_257_11 + var_257_19 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play417231062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 417231062
		arg_258_1.duration_ = 3.6

		local var_258_0 = {
			zh = 2.633,
			ja = 3.6
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play417231063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["1060"]) and arg_258_1.var_.actorSpriteComps1060 == nil then
				arg_258_1.var_.actorSpriteComps1060 = arg_258_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_0 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["1060"]) then
				if arg_258_1.var_.actorSpriteComps1060 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_261_1 then
							if arg_258_1.isInRecall_ then
								iter_261_1.color = Color.New(Mathf.Lerp(iter_261_1.color.r, arg_258_1.hightColor1.r, (arg_258_1.time_ - 0) / var_261_0), Mathf.Lerp(iter_261_1.color.g, arg_258_1.hightColor1.g, (arg_258_1.time_ - 0) / var_261_0), (Mathf.Lerp(iter_261_1.color.b, arg_258_1.hightColor1.b, (arg_258_1.time_ - 0) / var_261_0)))
							else
								local var_261_1 = Mathf.Lerp(iter_261_1.color.r, 1, (arg_258_1.time_ - 0) / var_261_0)

								iter_261_1.color = Color.New(var_261_1, var_261_1, var_261_1)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["1060"]) and arg_258_1.var_.actorSpriteComps1060 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_261_3 then
						iter_261_3.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_258_1.var_.actorSpriteComps1060 = nil
			end

			local var_261_2 = arg_258_1.actors_["1034"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_2) and arg_258_1.var_.actorSpriteComps1034 == nil then
				arg_258_1.var_.actorSpriteComps1034 = var_261_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_3 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_3 and not isNil(var_261_2) then
				if arg_258_1.var_.actorSpriteComps1034 then
					for iter_261_4, iter_261_5 in pairs(arg_258_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_261_5 then
							if arg_258_1.isInRecall_ then
								iter_261_5.color = Color.New(Mathf.Lerp(iter_261_5.color.r, arg_258_1.hightColor2.r, (arg_258_1.time_ - 0) / var_261_3), Mathf.Lerp(iter_261_5.color.g, arg_258_1.hightColor2.g, (arg_258_1.time_ - 0) / var_261_3), (Mathf.Lerp(iter_261_5.color.b, arg_258_1.hightColor2.b, (arg_258_1.time_ - 0) / var_261_3)))
							else
								local var_261_4 = Mathf.Lerp(iter_261_5.color.r, 0.5, (arg_258_1.time_ - 0) / var_261_3)

								iter_261_5.color = Color.New(var_261_4, var_261_4, var_261_4)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 0 + var_261_3 and arg_258_1.time_ < 0 + var_261_3 + arg_261_0 and not isNil(var_261_2) and arg_258_1.var_.actorSpriteComps1034 then
				for iter_261_6, iter_261_7 in pairs(arg_258_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_261_7 then
						iter_261_7.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_258_1.var_.actorSpriteComps1034 = nil
			end

			local var_261_5 = arg_258_1.actors_["1034"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1034 = var_261_5.localPosition
				var_261_5.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1034", 2)

				for iter_261_8 = 0, var_261_5.childCount - 1 do
					local var_261_6 = var_261_5:GetChild(iter_261_8)

					if var_261_6.name == "" or not string.find(var_261_6.name, "split") then
						var_261_6.gameObject:SetActive(true)
					else
						var_261_6.gameObject:SetActive(false)
					end
				end
			end

			local var_261_7 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				var_261_5.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_258_1.time_ - 0) / var_261_7)
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				var_261_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_261_8 = arg_258_1.actors_["1060"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1060 = var_261_8.localPosition
				var_261_8.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1060", 4)

				for iter_261_9 = 0, var_261_8.childCount - 1 do
					local var_261_9 = var_261_8:GetChild(iter_261_9)

					if var_261_9.name == "" or not string.find(var_261_9.name, "split") then
						var_261_9.gameObject:SetActive(true)
					else
						var_261_9.gameObject:SetActive(false)
					end
				end
			end

			local var_261_10 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_10 then
				var_261_8.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_258_1.time_ - 0) / var_261_10)
			end

			if arg_258_1.time_ >= 0 + var_261_10 and arg_258_1.time_ < 0 + var_261_10 + arg_261_0 then
				var_261_8.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_261_11 = 0
			local var_261_12 = 0.375

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_11 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_13 = arg_258_1:GetWordFromCfg(417231062)
				local var_261_14 = arg_258_1:FormatText(var_261_13.content)

				arg_258_1.text_.text = var_261_14

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_16 = 15 <= 0 and var_261_12 or var_261_12 * (utf8.len(var_261_14) / 15)

				if (15 <= 0 and var_261_12 or var_261_12 * (utf8.len(var_261_14) / 15)) > 0 and var_261_12 < var_261_16 then
					arg_258_1.talkMaxDuration = var_261_16

					if var_261_16 + var_261_11 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_16 + var_261_11
					end
				end

				arg_258_1.text_.text = var_261_14
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231062", "story_v_out_417231.awb") ~= 0 then
					local var_261_17 = manager.audio:GetVoiceLength("story_v_out_417231", "417231062", "story_v_out_417231.awb") / 1000

					if var_261_17 + var_261_11 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_17 + var_261_11
					end

					if var_261_13.prefab_name ~= "" and arg_258_1.actors_[var_261_13.prefab_name] ~= nil then
						local var_261_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_13.prefab_name].transform, "story_v_out_417231", "417231062", "story_v_out_417231.awb")

						arg_258_1:RecordAudio("417231062", var_261_18)
						arg_258_1:RecordAudio("417231062", var_261_18)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_417231", "417231062", "story_v_out_417231.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_417231", "417231062", "story_v_out_417231.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_19 = math.max(var_261_12, arg_258_1.talkMaxDuration)

			if var_261_11 <= arg_258_1.time_ and arg_258_1.time_ < var_261_11 + var_261_19 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_11) / var_261_19

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_11 + var_261_19 and arg_258_1.time_ < var_261_11 + var_261_19 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play417231063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 417231063
		arg_262_1.duration_ = 10.87

		local var_262_0 = {
			zh = 6.933,
			ja = 10.866
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play417231064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1034"]) and arg_262_1.var_.actorSpriteComps1034 == nil then
				arg_262_1.var_.actorSpriteComps1034 = arg_262_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_0 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1034"]) then
				if arg_262_1.var_.actorSpriteComps1034 then
					for iter_265_0, iter_265_1 in pairs(arg_262_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_265_1 then
							if arg_262_1.isInRecall_ then
								iter_265_1.color = Color.New(Mathf.Lerp(iter_265_1.color.r, arg_262_1.hightColor1.r, (arg_262_1.time_ - 0) / var_265_0), Mathf.Lerp(iter_265_1.color.g, arg_262_1.hightColor1.g, (arg_262_1.time_ - 0) / var_265_0), (Mathf.Lerp(iter_265_1.color.b, arg_262_1.hightColor1.b, (arg_262_1.time_ - 0) / var_265_0)))
							else
								local var_265_1 = Mathf.Lerp(iter_265_1.color.r, 1, (arg_262_1.time_ - 0) / var_265_0)

								iter_265_1.color = Color.New(var_265_1, var_265_1, var_265_1)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1034"]) and arg_262_1.var_.actorSpriteComps1034 then
				for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_265_3 then
						iter_265_3.color = arg_262_1.isInRecall_ and (arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_262_1.var_.actorSpriteComps1034 = nil
			end

			local var_265_2 = arg_262_1.actors_["1060"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.actorSpriteComps1060 == nil then
				arg_262_1.var_.actorSpriteComps1060 = var_265_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_3 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_3 and not isNil(var_265_2) then
				if arg_262_1.var_.actorSpriteComps1060 then
					for iter_265_4, iter_265_5 in pairs(arg_262_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_265_5 then
							if arg_262_1.isInRecall_ then
								iter_265_5.color = Color.New(Mathf.Lerp(iter_265_5.color.r, arg_262_1.hightColor2.r, (arg_262_1.time_ - 0) / var_265_3), Mathf.Lerp(iter_265_5.color.g, arg_262_1.hightColor2.g, (arg_262_1.time_ - 0) / var_265_3), (Mathf.Lerp(iter_265_5.color.b, arg_262_1.hightColor2.b, (arg_262_1.time_ - 0) / var_265_3)))
							else
								local var_265_4 = Mathf.Lerp(iter_265_5.color.r, 0.5, (arg_262_1.time_ - 0) / var_265_3)

								iter_265_5.color = Color.New(var_265_4, var_265_4, var_265_4)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= 0 + var_265_3 and arg_262_1.time_ < 0 + var_265_3 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.actorSpriteComps1060 then
				for iter_265_6, iter_265_7 in pairs(arg_262_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_265_7 then
						iter_265_7.color = arg_262_1.isInRecall_ and (arg_262_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_262_1.var_.actorSpriteComps1060 = nil
			end

			local var_265_5 = 0
			local var_265_6 = 0.825

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_5 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_7 = arg_262_1:GetWordFromCfg(417231063)
				local var_265_8 = arg_262_1:FormatText(var_265_7.content)

				arg_262_1.text_.text = var_265_8

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_10 = 33 <= 0 and var_265_6 or var_265_6 * (utf8.len(var_265_8) / 33)

				if (33 <= 0 and var_265_6 or var_265_6 * (utf8.len(var_265_8) / 33)) > 0 and var_265_6 < var_265_10 then
					arg_262_1.talkMaxDuration = var_265_10

					if var_265_10 + var_265_5 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_10 + var_265_5
					end
				end

				arg_262_1.text_.text = var_265_8
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231063", "story_v_out_417231.awb") ~= 0 then
					local var_265_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231063", "story_v_out_417231.awb") / 1000

					if var_265_11 + var_265_5 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_11 + var_265_5
					end

					if var_265_7.prefab_name ~= "" and arg_262_1.actors_[var_265_7.prefab_name] ~= nil then
						local var_265_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_7.prefab_name].transform, "story_v_out_417231", "417231063", "story_v_out_417231.awb")

						arg_262_1:RecordAudio("417231063", var_265_12)
						arg_262_1:RecordAudio("417231063", var_265_12)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_417231", "417231063", "story_v_out_417231.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_417231", "417231063", "story_v_out_417231.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_13 = math.max(var_265_6, arg_262_1.talkMaxDuration)

			if var_265_5 <= arg_262_1.time_ and arg_262_1.time_ < var_265_5 + var_265_13 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_5) / var_265_13

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_5 + var_265_13 and arg_262_1.time_ < var_265_5 + var_265_13 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play417231064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 417231064
		arg_266_1.duration_ = 6.47

		local var_266_0 = {
			zh = 6.466,
			ja = 5.566
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play417231065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1060"]) and arg_266_1.var_.actorSpriteComps1060 == nil then
				arg_266_1.var_.actorSpriteComps1060 = arg_266_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_0 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1060"]) then
				if arg_266_1.var_.actorSpriteComps1060 then
					for iter_269_0, iter_269_1 in pairs(arg_266_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_269_1 then
							if arg_266_1.isInRecall_ then
								iter_269_1.color = Color.New(Mathf.Lerp(iter_269_1.color.r, arg_266_1.hightColor1.r, (arg_266_1.time_ - 0) / var_269_0), Mathf.Lerp(iter_269_1.color.g, arg_266_1.hightColor1.g, (arg_266_1.time_ - 0) / var_269_0), (Mathf.Lerp(iter_269_1.color.b, arg_266_1.hightColor1.b, (arg_266_1.time_ - 0) / var_269_0)))
							else
								local var_269_1 = Mathf.Lerp(iter_269_1.color.r, 1, (arg_266_1.time_ - 0) / var_269_0)

								iter_269_1.color = Color.New(var_269_1, var_269_1, var_269_1)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1060"]) and arg_266_1.var_.actorSpriteComps1060 then
				for iter_269_2, iter_269_3 in pairs(arg_266_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_269_3 then
						iter_269_3.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_266_1.var_.actorSpriteComps1060 = nil
			end

			local var_269_2 = arg_266_1.actors_["1034"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.actorSpriteComps1034 == nil then
				arg_266_1.var_.actorSpriteComps1034 = var_269_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_3 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_3 and not isNil(var_269_2) then
				if arg_266_1.var_.actorSpriteComps1034 then
					for iter_269_4, iter_269_5 in pairs(arg_266_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_269_5 then
							if arg_266_1.isInRecall_ then
								iter_269_5.color = Color.New(Mathf.Lerp(iter_269_5.color.r, arg_266_1.hightColor2.r, (arg_266_1.time_ - 0) / var_269_3), Mathf.Lerp(iter_269_5.color.g, arg_266_1.hightColor2.g, (arg_266_1.time_ - 0) / var_269_3), (Mathf.Lerp(iter_269_5.color.b, arg_266_1.hightColor2.b, (arg_266_1.time_ - 0) / var_269_3)))
							else
								local var_269_4 = Mathf.Lerp(iter_269_5.color.r, 0.5, (arg_266_1.time_ - 0) / var_269_3)

								iter_269_5.color = Color.New(var_269_4, var_269_4, var_269_4)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= 0 + var_269_3 and arg_266_1.time_ < 0 + var_269_3 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.actorSpriteComps1034 then
				for iter_269_6, iter_269_7 in pairs(arg_266_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_269_7 then
						iter_269_7.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_266_1.var_.actorSpriteComps1034 = nil
			end

			local var_269_5 = 0
			local var_269_6 = 0.8

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_5 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_7 = arg_266_1:GetWordFromCfg(417231064)
				local var_269_8 = arg_266_1:FormatText(var_269_7.content)

				arg_266_1.text_.text = var_269_8

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_10 = 32 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_8) / 32)

				if (32 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_8) / 32)) > 0 and var_269_6 < var_269_10 then
					arg_266_1.talkMaxDuration = var_269_10

					if var_269_10 + var_269_5 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_5
					end
				end

				arg_266_1.text_.text = var_269_8
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231064", "story_v_out_417231.awb") ~= 0 then
					local var_269_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231064", "story_v_out_417231.awb") / 1000

					if var_269_11 + var_269_5 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_11 + var_269_5
					end

					if var_269_7.prefab_name ~= "" and arg_266_1.actors_[var_269_7.prefab_name] ~= nil then
						local var_269_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_7.prefab_name].transform, "story_v_out_417231", "417231064", "story_v_out_417231.awb")

						arg_266_1:RecordAudio("417231064", var_269_12)
						arg_266_1:RecordAudio("417231064", var_269_12)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_417231", "417231064", "story_v_out_417231.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_417231", "417231064", "story_v_out_417231.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_13 = math.max(var_269_6, arg_266_1.talkMaxDuration)

			if var_269_5 <= arg_266_1.time_ and arg_266_1.time_ < var_269_5 + var_269_13 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_5) / var_269_13

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_5 + var_269_13 and arg_266_1.time_ < var_269_5 + var_269_13 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play417231065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 417231065
		arg_270_1.duration_ = 9.83

		local var_270_0 = {
			zh = 8.5,
			ja = 9.833
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play417231066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1034"]) and arg_270_1.var_.actorSpriteComps1034 == nil then
				arg_270_1.var_.actorSpriteComps1034 = arg_270_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_0 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1034"]) then
				if arg_270_1.var_.actorSpriteComps1034 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_273_1 then
							if arg_270_1.isInRecall_ then
								iter_273_1.color = Color.New(Mathf.Lerp(iter_273_1.color.r, arg_270_1.hightColor1.r, (arg_270_1.time_ - 0) / var_273_0), Mathf.Lerp(iter_273_1.color.g, arg_270_1.hightColor1.g, (arg_270_1.time_ - 0) / var_273_0), (Mathf.Lerp(iter_273_1.color.b, arg_270_1.hightColor1.b, (arg_270_1.time_ - 0) / var_273_0)))
							else
								local var_273_1 = Mathf.Lerp(iter_273_1.color.r, 1, (arg_270_1.time_ - 0) / var_273_0)

								iter_273_1.color = Color.New(var_273_1, var_273_1, var_273_1)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1034"]) and arg_270_1.var_.actorSpriteComps1034 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_273_3 then
						iter_273_3.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_270_1.var_.actorSpriteComps1034 = nil
			end

			local var_273_2 = arg_270_1.actors_["1060"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps1060 == nil then
				arg_270_1.var_.actorSpriteComps1060 = var_273_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_3 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 and not isNil(var_273_2) then
				if arg_270_1.var_.actorSpriteComps1060 then
					for iter_273_4, iter_273_5 in pairs(arg_270_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_273_5 then
							if arg_270_1.isInRecall_ then
								iter_273_5.color = Color.New(Mathf.Lerp(iter_273_5.color.r, arg_270_1.hightColor2.r, (arg_270_1.time_ - 0) / var_273_3), Mathf.Lerp(iter_273_5.color.g, arg_270_1.hightColor2.g, (arg_270_1.time_ - 0) / var_273_3), (Mathf.Lerp(iter_273_5.color.b, arg_270_1.hightColor2.b, (arg_270_1.time_ - 0) / var_273_3)))
							else
								local var_273_4 = Mathf.Lerp(iter_273_5.color.r, 0.5, (arg_270_1.time_ - 0) / var_273_3)

								iter_273_5.color = Color.New(var_273_4, var_273_4, var_273_4)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps1060 then
				for iter_273_6, iter_273_7 in pairs(arg_270_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_273_7 then
						iter_273_7.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_270_1.var_.actorSpriteComps1060 = nil
			end

			local var_273_5 = 0
			local var_273_6 = 0.925

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_7 = arg_270_1:GetWordFromCfg(417231065)
				local var_273_8 = arg_270_1:FormatText(var_273_7.content)

				arg_270_1.text_.text = var_273_8

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_10 = 37 <= 0 and var_273_6 or var_273_6 * (utf8.len(var_273_8) / 37)

				if (37 <= 0 and var_273_6 or var_273_6 * (utf8.len(var_273_8) / 37)) > 0 and var_273_6 < var_273_10 then
					arg_270_1.talkMaxDuration = var_273_10

					if var_273_10 + var_273_5 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_5
					end
				end

				arg_270_1.text_.text = var_273_8
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231065", "story_v_out_417231.awb") ~= 0 then
					local var_273_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231065", "story_v_out_417231.awb") / 1000

					if var_273_11 + var_273_5 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_11 + var_273_5
					end

					if var_273_7.prefab_name ~= "" and arg_270_1.actors_[var_273_7.prefab_name] ~= nil then
						local var_273_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_7.prefab_name].transform, "story_v_out_417231", "417231065", "story_v_out_417231.awb")

						arg_270_1:RecordAudio("417231065", var_273_12)
						arg_270_1:RecordAudio("417231065", var_273_12)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_417231", "417231065", "story_v_out_417231.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_417231", "417231065", "story_v_out_417231.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_13 = math.max(var_273_6, arg_270_1.talkMaxDuration)

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_13 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_5) / var_273_13

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_5 + var_273_13 and arg_270_1.time_ < var_273_5 + var_273_13 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play417231066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 417231066
		arg_274_1.duration_ = 12.43

		local var_274_0 = {
			zh = 8.433,
			ja = 12.433
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play417231067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 1.075

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_1 = arg_274_1:GetWordFromCfg(417231066)
				local var_277_2 = arg_274_1:FormatText(var_277_1.content)

				arg_274_1.text_.text = var_277_2

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_4 = 43 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 43)

				if (43 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 43)) > 0 and var_277_0 < var_277_4 then
					arg_274_1.talkMaxDuration = var_277_4

					if var_277_4 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_4 + 0
					end
				end

				arg_274_1.text_.text = var_277_2
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231066", "story_v_out_417231.awb") ~= 0 then
					local var_277_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231066", "story_v_out_417231.awb") / 1000

					if var_277_5 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + 0
					end

					if var_277_1.prefab_name ~= "" and arg_274_1.actors_[var_277_1.prefab_name] ~= nil then
						local var_277_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_1.prefab_name].transform, "story_v_out_417231", "417231066", "story_v_out_417231.awb")

						arg_274_1:RecordAudio("417231066", var_277_6)
						arg_274_1:RecordAudio("417231066", var_277_6)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_417231", "417231066", "story_v_out_417231.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_417231", "417231066", "story_v_out_417231.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_7 and arg_274_1.time_ < 0 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play417231067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 417231067
		arg_278_1.duration_ = 16.97

		local var_278_0 = {
			zh = 10.766,
			ja = 16.966
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play417231068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 1.325

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_1 = arg_278_1:GetWordFromCfg(417231067)
				local var_281_2 = arg_278_1:FormatText(var_281_1.content)

				arg_278_1.text_.text = var_281_2

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 53 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 53)

				if (53 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 53)) > 0 and var_281_0 < var_281_4 then
					arg_278_1.talkMaxDuration = var_281_4

					if var_281_4 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_4 + 0
					end
				end

				arg_278_1.text_.text = var_281_2
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231067", "story_v_out_417231.awb") ~= 0 then
					local var_281_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231067", "story_v_out_417231.awb") / 1000

					if var_281_5 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + 0
					end

					if var_281_1.prefab_name ~= "" and arg_278_1.actors_[var_281_1.prefab_name] ~= nil then
						local var_281_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_1.prefab_name].transform, "story_v_out_417231", "417231067", "story_v_out_417231.awb")

						arg_278_1:RecordAudio("417231067", var_281_6)
						arg_278_1:RecordAudio("417231067", var_281_6)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_417231", "417231067", "story_v_out_417231.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_417231", "417231067", "story_v_out_417231.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_7 and arg_278_1.time_ < 0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play417231068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 417231068
		arg_282_1.duration_ = 11.77

		local var_282_0 = {
			zh = 11.2,
			ja = 11.766
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play417231069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 1.225

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_1 = arg_282_1:GetWordFromCfg(417231068)
				local var_285_2 = arg_282_1:FormatText(var_285_1.content)

				arg_282_1.text_.text = var_285_2

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_4 = 49 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_2) / 49)

				if (49 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_2) / 49)) > 0 and var_285_0 < var_285_4 then
					arg_282_1.talkMaxDuration = var_285_4

					if var_285_4 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_4 + 0
					end
				end

				arg_282_1.text_.text = var_285_2
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231068", "story_v_out_417231.awb") ~= 0 then
					local var_285_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231068", "story_v_out_417231.awb") / 1000

					if var_285_5 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + 0
					end

					if var_285_1.prefab_name ~= "" and arg_282_1.actors_[var_285_1.prefab_name] ~= nil then
						local var_285_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_1.prefab_name].transform, "story_v_out_417231", "417231068", "story_v_out_417231.awb")

						arg_282_1:RecordAudio("417231068", var_285_6)
						arg_282_1:RecordAudio("417231068", var_285_6)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_417231", "417231068", "story_v_out_417231.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_417231", "417231068", "story_v_out_417231.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_7 and arg_282_1.time_ < 0 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play417231069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 417231069
		arg_286_1.duration_ = 2.1

		local var_286_0 = {
			zh = 1,
			ja = 2.1
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play417231070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["1060"]) and arg_286_1.var_.actorSpriteComps1060 == nil then
				arg_286_1.var_.actorSpriteComps1060 = arg_286_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_0 = 0.2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["1060"]) then
				if arg_286_1.var_.actorSpriteComps1060 then
					for iter_289_0, iter_289_1 in pairs(arg_286_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_289_1 then
							if arg_286_1.isInRecall_ then
								iter_289_1.color = Color.New(Mathf.Lerp(iter_289_1.color.r, arg_286_1.hightColor1.r, (arg_286_1.time_ - 0) / var_289_0), Mathf.Lerp(iter_289_1.color.g, arg_286_1.hightColor1.g, (arg_286_1.time_ - 0) / var_289_0), (Mathf.Lerp(iter_289_1.color.b, arg_286_1.hightColor1.b, (arg_286_1.time_ - 0) / var_289_0)))
							else
								local var_289_1 = Mathf.Lerp(iter_289_1.color.r, 1, (arg_286_1.time_ - 0) / var_289_0)

								iter_289_1.color = Color.New(var_289_1, var_289_1, var_289_1)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["1060"]) and arg_286_1.var_.actorSpriteComps1060 then
				for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_289_3 then
						iter_289_3.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_286_1.var_.actorSpriteComps1060 = nil
			end

			local var_289_2 = arg_286_1.actors_["1034"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.actorSpriteComps1034 == nil then
				arg_286_1.var_.actorSpriteComps1034 = var_289_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_3 = 0.2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_3 and not isNil(var_289_2) then
				if arg_286_1.var_.actorSpriteComps1034 then
					for iter_289_4, iter_289_5 in pairs(arg_286_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_289_5 then
							if arg_286_1.isInRecall_ then
								iter_289_5.color = Color.New(Mathf.Lerp(iter_289_5.color.r, arg_286_1.hightColor2.r, (arg_286_1.time_ - 0) / var_289_3), Mathf.Lerp(iter_289_5.color.g, arg_286_1.hightColor2.g, (arg_286_1.time_ - 0) / var_289_3), (Mathf.Lerp(iter_289_5.color.b, arg_286_1.hightColor2.b, (arg_286_1.time_ - 0) / var_289_3)))
							else
								local var_289_4 = Mathf.Lerp(iter_289_5.color.r, 0.5, (arg_286_1.time_ - 0) / var_289_3)

								iter_289_5.color = Color.New(var_289_4, var_289_4, var_289_4)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_3 and arg_286_1.time_ < 0 + var_289_3 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.actorSpriteComps1034 then
				for iter_289_6, iter_289_7 in pairs(arg_286_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_289_7 then
						iter_289_7.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_286_1.var_.actorSpriteComps1034 = nil
			end

			local var_289_5 = arg_286_1.actors_["1060"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos1060 = var_289_5.localPosition
				var_289_5.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("1060", 4)

				for iter_289_8 = 0, var_289_5.childCount - 1 do
					local var_289_6 = var_289_5:GetChild(iter_289_8)

					if var_289_6.name == "split_3" or not string.find(var_289_6.name, "split") then
						var_289_6.gameObject:SetActive(true)
					else
						var_289_6.gameObject:SetActive(false)
					end
				end
			end

			local var_289_7 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_7 then
				var_289_5.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_286_1.time_ - 0) / var_289_7)
			end

			if arg_286_1.time_ >= 0 + var_289_7 and arg_286_1.time_ < 0 + var_289_7 + arg_289_0 then
				var_289_5.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_289_8 = 0
			local var_289_9 = 0.05

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_8 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_10 = arg_286_1:GetWordFromCfg(417231069)
				local var_289_11 = arg_286_1:FormatText(var_289_10.content)

				arg_286_1.text_.text = var_289_11

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_13 = 2 <= 0 and var_289_9 or var_289_9 * (utf8.len(var_289_11) / 2)

				if (2 <= 0 and var_289_9 or var_289_9 * (utf8.len(var_289_11) / 2)) > 0 and var_289_9 < var_289_13 then
					arg_286_1.talkMaxDuration = var_289_13

					if var_289_13 + var_289_8 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_13 + var_289_8
					end
				end

				arg_286_1.text_.text = var_289_11
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231069", "story_v_out_417231.awb") ~= 0 then
					local var_289_14 = manager.audio:GetVoiceLength("story_v_out_417231", "417231069", "story_v_out_417231.awb") / 1000

					if var_289_14 + var_289_8 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_14 + var_289_8
					end

					if var_289_10.prefab_name ~= "" and arg_286_1.actors_[var_289_10.prefab_name] ~= nil then
						local var_289_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_10.prefab_name].transform, "story_v_out_417231", "417231069", "story_v_out_417231.awb")

						arg_286_1:RecordAudio("417231069", var_289_15)
						arg_286_1:RecordAudio("417231069", var_289_15)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_417231", "417231069", "story_v_out_417231.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_417231", "417231069", "story_v_out_417231.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_16 = math.max(var_289_9, arg_286_1.talkMaxDuration)

			if var_289_8 <= arg_286_1.time_ and arg_286_1.time_ < var_289_8 + var_289_16 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_8) / var_289_16

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_8 + var_289_16 and arg_286_1.time_ < var_289_8 + var_289_16 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play417231070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 417231070
		arg_290_1.duration_ = 3.57

		local var_290_0 = {
			zh = 2.533,
			ja = 3.566
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play417231071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1034"]) and arg_290_1.var_.actorSpriteComps1034 == nil then
				arg_290_1.var_.actorSpriteComps1034 = arg_290_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_0 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1034"]) then
				if arg_290_1.var_.actorSpriteComps1034 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								iter_293_1.color = Color.New(Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor1.r, (arg_290_1.time_ - 0) / var_293_0), Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor1.g, (arg_290_1.time_ - 0) / var_293_0), (Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor1.b, (arg_290_1.time_ - 0) / var_293_0)))
							else
								local var_293_1 = Mathf.Lerp(iter_293_1.color.r, 1, (arg_290_1.time_ - 0) / var_293_0)

								iter_293_1.color = Color.New(var_293_1, var_293_1, var_293_1)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1034"]) and arg_290_1.var_.actorSpriteComps1034 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_293_3 then
						iter_293_3.color = arg_290_1.isInRecall_ and (arg_290_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_290_1.var_.actorSpriteComps1034 = nil
			end

			local var_293_2 = arg_290_1.actors_["1060"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_2) and arg_290_1.var_.actorSpriteComps1060 == nil then
				arg_290_1.var_.actorSpriteComps1060 = var_293_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_3 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_3 and not isNil(var_293_2) then
				if arg_290_1.var_.actorSpriteComps1060 then
					for iter_293_4, iter_293_5 in pairs(arg_290_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_293_5 then
							if arg_290_1.isInRecall_ then
								iter_293_5.color = Color.New(Mathf.Lerp(iter_293_5.color.r, arg_290_1.hightColor2.r, (arg_290_1.time_ - 0) / var_293_3), Mathf.Lerp(iter_293_5.color.g, arg_290_1.hightColor2.g, (arg_290_1.time_ - 0) / var_293_3), (Mathf.Lerp(iter_293_5.color.b, arg_290_1.hightColor2.b, (arg_290_1.time_ - 0) / var_293_3)))
							else
								local var_293_4 = Mathf.Lerp(iter_293_5.color.r, 0.5, (arg_290_1.time_ - 0) / var_293_3)

								iter_293_5.color = Color.New(var_293_4, var_293_4, var_293_4)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= 0 + var_293_3 and arg_290_1.time_ < 0 + var_293_3 + arg_293_0 and not isNil(var_293_2) and arg_290_1.var_.actorSpriteComps1060 then
				for iter_293_6, iter_293_7 in pairs(arg_290_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_293_7 then
						iter_293_7.color = arg_290_1.isInRecall_ and (arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_290_1.var_.actorSpriteComps1060 = nil
			end

			local var_293_5 = 0
			local var_293_6 = 0.25

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_7 = arg_290_1:GetWordFromCfg(417231070)
				local var_293_8 = arg_290_1:FormatText(var_293_7.content)

				arg_290_1.text_.text = var_293_8

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_10 = 10 <= 0 and var_293_6 or var_293_6 * (utf8.len(var_293_8) / 10)

				if (10 <= 0 and var_293_6 or var_293_6 * (utf8.len(var_293_8) / 10)) > 0 and var_293_6 < var_293_10 then
					arg_290_1.talkMaxDuration = var_293_10

					if var_293_10 + var_293_5 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_5
					end
				end

				arg_290_1.text_.text = var_293_8
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231070", "story_v_out_417231.awb") ~= 0 then
					local var_293_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231070", "story_v_out_417231.awb") / 1000

					if var_293_11 + var_293_5 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_11 + var_293_5
					end

					if var_293_7.prefab_name ~= "" and arg_290_1.actors_[var_293_7.prefab_name] ~= nil then
						local var_293_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_7.prefab_name].transform, "story_v_out_417231", "417231070", "story_v_out_417231.awb")

						arg_290_1:RecordAudio("417231070", var_293_12)
						arg_290_1:RecordAudio("417231070", var_293_12)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_417231", "417231070", "story_v_out_417231.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_417231", "417231070", "story_v_out_417231.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_13 = math.max(var_293_6, arg_290_1.talkMaxDuration)

			if var_293_5 <= arg_290_1.time_ and arg_290_1.time_ < var_293_5 + var_293_13 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_5) / var_293_13

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_5 + var_293_13 and arg_290_1.time_ < var_293_5 + var_293_13 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play417231071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 417231071
		arg_294_1.duration_ = 7.23

		local var_294_0 = {
			zh = 7.233,
			ja = 4.566
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play417231072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["1060"]) and arg_294_1.var_.actorSpriteComps1060 == nil then
				arg_294_1.var_.actorSpriteComps1060 = arg_294_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_0 = 0.2

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["1060"]) then
				if arg_294_1.var_.actorSpriteComps1060 then
					for iter_297_0, iter_297_1 in pairs(arg_294_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_297_1 then
							if arg_294_1.isInRecall_ then
								iter_297_1.color = Color.New(Mathf.Lerp(iter_297_1.color.r, arg_294_1.hightColor1.r, (arg_294_1.time_ - 0) / var_297_0), Mathf.Lerp(iter_297_1.color.g, arg_294_1.hightColor1.g, (arg_294_1.time_ - 0) / var_297_0), (Mathf.Lerp(iter_297_1.color.b, arg_294_1.hightColor1.b, (arg_294_1.time_ - 0) / var_297_0)))
							else
								local var_297_1 = Mathf.Lerp(iter_297_1.color.r, 1, (arg_294_1.time_ - 0) / var_297_0)

								iter_297_1.color = Color.New(var_297_1, var_297_1, var_297_1)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["1060"]) and arg_294_1.var_.actorSpriteComps1060 then
				for iter_297_2, iter_297_3 in pairs(arg_294_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_297_3 then
						iter_297_3.color = arg_294_1.isInRecall_ and (arg_294_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_294_1.var_.actorSpriteComps1060 = nil
			end

			local var_297_2 = arg_294_1.actors_["1034"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_2) and arg_294_1.var_.actorSpriteComps1034 == nil then
				arg_294_1.var_.actorSpriteComps1034 = var_297_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_3 = 0.2

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_3 and not isNil(var_297_2) then
				if arg_294_1.var_.actorSpriteComps1034 then
					for iter_297_4, iter_297_5 in pairs(arg_294_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_297_5 then
							if arg_294_1.isInRecall_ then
								iter_297_5.color = Color.New(Mathf.Lerp(iter_297_5.color.r, arg_294_1.hightColor2.r, (arg_294_1.time_ - 0) / var_297_3), Mathf.Lerp(iter_297_5.color.g, arg_294_1.hightColor2.g, (arg_294_1.time_ - 0) / var_297_3), (Mathf.Lerp(iter_297_5.color.b, arg_294_1.hightColor2.b, (arg_294_1.time_ - 0) / var_297_3)))
							else
								local var_297_4 = Mathf.Lerp(iter_297_5.color.r, 0.5, (arg_294_1.time_ - 0) / var_297_3)

								iter_297_5.color = Color.New(var_297_4, var_297_4, var_297_4)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= 0 + var_297_3 and arg_294_1.time_ < 0 + var_297_3 + arg_297_0 and not isNil(var_297_2) and arg_294_1.var_.actorSpriteComps1034 then
				for iter_297_6, iter_297_7 in pairs(arg_294_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_297_7 then
						iter_297_7.color = arg_294_1.isInRecall_ and (arg_294_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_294_1.var_.actorSpriteComps1034 = nil
			end

			local var_297_5 = arg_294_1.actors_["1060"].transform

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos1060 = var_297_5.localPosition
				var_297_5.localScale = Vector3.New(1, 1, 1)

				arg_294_1:CheckSpriteTmpPos("1060", 4)

				for iter_297_8 = 0, var_297_5.childCount - 1 do
					local var_297_6 = var_297_5:GetChild(iter_297_8)

					if var_297_6.name == "split_1" or not string.find(var_297_6.name, "split") then
						var_297_6.gameObject:SetActive(true)
					else
						var_297_6.gameObject:SetActive(false)
					end
				end
			end

			local var_297_7 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				var_297_5.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_294_1.time_ - 0) / var_297_7)
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				var_297_5.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_297_8 = 0
			local var_297_9 = 0.625

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_8 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_10 = arg_294_1:GetWordFromCfg(417231071)
				local var_297_11 = arg_294_1:FormatText(var_297_10.content)

				arg_294_1.text_.text = var_297_11

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_13 = 25 <= 0 and var_297_9 or var_297_9 * (utf8.len(var_297_11) / 25)

				if (25 <= 0 and var_297_9 or var_297_9 * (utf8.len(var_297_11) / 25)) > 0 and var_297_9 < var_297_13 then
					arg_294_1.talkMaxDuration = var_297_13

					if var_297_13 + var_297_8 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_13 + var_297_8
					end
				end

				arg_294_1.text_.text = var_297_11
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231071", "story_v_out_417231.awb") ~= 0 then
					local var_297_14 = manager.audio:GetVoiceLength("story_v_out_417231", "417231071", "story_v_out_417231.awb") / 1000

					if var_297_14 + var_297_8 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_14 + var_297_8
					end

					if var_297_10.prefab_name ~= "" and arg_294_1.actors_[var_297_10.prefab_name] ~= nil then
						local var_297_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_10.prefab_name].transform, "story_v_out_417231", "417231071", "story_v_out_417231.awb")

						arg_294_1:RecordAudio("417231071", var_297_15)
						arg_294_1:RecordAudio("417231071", var_297_15)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_417231", "417231071", "story_v_out_417231.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_417231", "417231071", "story_v_out_417231.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_16 = math.max(var_297_9, arg_294_1.talkMaxDuration)

			if var_297_8 <= arg_294_1.time_ and arg_294_1.time_ < var_297_8 + var_297_16 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_8) / var_297_16

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_8 + var_297_16 and arg_294_1.time_ < var_297_8 + var_297_16 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play417231072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 417231072
		arg_298_1.duration_ = 14.53

		local var_298_0 = {
			zh = 13.566,
			ja = 14.533
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play417231073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 1.7

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:GetWordFromCfg(417231072)
				local var_301_2 = arg_298_1:FormatText(var_301_1.content)

				arg_298_1.text_.text = var_301_2

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 68 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 68)

				if (68 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 68)) > 0 and var_301_0 < var_301_4 then
					arg_298_1.talkMaxDuration = var_301_4

					if var_301_4 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_4 + 0
					end
				end

				arg_298_1.text_.text = var_301_2
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231072", "story_v_out_417231.awb") ~= 0 then
					local var_301_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231072", "story_v_out_417231.awb") / 1000

					if var_301_5 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_5 + 0
					end

					if var_301_1.prefab_name ~= "" and arg_298_1.actors_[var_301_1.prefab_name] ~= nil then
						local var_301_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_1.prefab_name].transform, "story_v_out_417231", "417231072", "story_v_out_417231.awb")

						arg_298_1:RecordAudio("417231072", var_301_6)
						arg_298_1:RecordAudio("417231072", var_301_6)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_417231", "417231072", "story_v_out_417231.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_417231", "417231072", "story_v_out_417231.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_7 and arg_298_1.time_ < 0 + var_301_7 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play417231073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 417231073
		arg_302_1.duration_ = 4.43

		local var_302_0 = {
			zh = 3.566,
			ja = 4.433
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play417231074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["1034"]) and arg_302_1.var_.actorSpriteComps1034 == nil then
				arg_302_1.var_.actorSpriteComps1034 = arg_302_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_0 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["1034"]) then
				if arg_302_1.var_.actorSpriteComps1034 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								iter_305_1.color = Color.New(Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor1.r, (arg_302_1.time_ - 0) / var_305_0), Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor1.g, (arg_302_1.time_ - 0) / var_305_0), (Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor1.b, (arg_302_1.time_ - 0) / var_305_0)))
							else
								local var_305_1 = Mathf.Lerp(iter_305_1.color.r, 1, (arg_302_1.time_ - 0) / var_305_0)

								iter_305_1.color = Color.New(var_305_1, var_305_1, var_305_1)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["1034"]) and arg_302_1.var_.actorSpriteComps1034 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_305_3 then
						iter_305_3.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_302_1.var_.actorSpriteComps1034 = nil
			end

			local var_305_2 = arg_302_1.actors_["1060"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_2) and arg_302_1.var_.actorSpriteComps1060 == nil then
				arg_302_1.var_.actorSpriteComps1060 = var_305_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_3 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_3 and not isNil(var_305_2) then
				if arg_302_1.var_.actorSpriteComps1060 then
					for iter_305_4, iter_305_5 in pairs(arg_302_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_305_5 then
							if arg_302_1.isInRecall_ then
								iter_305_5.color = Color.New(Mathf.Lerp(iter_305_5.color.r, arg_302_1.hightColor2.r, (arg_302_1.time_ - 0) / var_305_3), Mathf.Lerp(iter_305_5.color.g, arg_302_1.hightColor2.g, (arg_302_1.time_ - 0) / var_305_3), (Mathf.Lerp(iter_305_5.color.b, arg_302_1.hightColor2.b, (arg_302_1.time_ - 0) / var_305_3)))
							else
								local var_305_4 = Mathf.Lerp(iter_305_5.color.r, 0.5, (arg_302_1.time_ - 0) / var_305_3)

								iter_305_5.color = Color.New(var_305_4, var_305_4, var_305_4)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_3 and arg_302_1.time_ < 0 + var_305_3 + arg_305_0 and not isNil(var_305_2) and arg_302_1.var_.actorSpriteComps1060 then
				for iter_305_6, iter_305_7 in pairs(arg_302_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_305_7 then
						iter_305_7.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_302_1.var_.actorSpriteComps1060 = nil
			end

			local var_305_5 = arg_302_1.actors_["1034"].transform

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1034 = var_305_5.localPosition
				var_305_5.localScale = Vector3.New(1, 1, 1)

				arg_302_1:CheckSpriteTmpPos("1034", 2)

				for iter_305_8 = 0, var_305_5.childCount - 1 do
					local var_305_6 = var_305_5:GetChild(iter_305_8)

					if var_305_6.name == "split_6" or not string.find(var_305_6.name, "split") then
						var_305_6.gameObject:SetActive(true)
					else
						var_305_6.gameObject:SetActive(false)
					end
				end
			end

			local var_305_7 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_7 then
				var_305_5.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_302_1.time_ - 0) / var_305_7)
			end

			if arg_302_1.time_ >= 0 + var_305_7 and arg_302_1.time_ < 0 + var_305_7 + arg_305_0 then
				var_305_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_305_8 = 0
			local var_305_9 = 0.4

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_8 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_10 = arg_302_1:GetWordFromCfg(417231073)
				local var_305_11 = arg_302_1:FormatText(var_305_10.content)

				arg_302_1.text_.text = var_305_11

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_13 = 16 <= 0 and var_305_9 or var_305_9 * (utf8.len(var_305_11) / 16)

				if (16 <= 0 and var_305_9 or var_305_9 * (utf8.len(var_305_11) / 16)) > 0 and var_305_9 < var_305_13 then
					arg_302_1.talkMaxDuration = var_305_13

					if var_305_13 + var_305_8 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_13 + var_305_8
					end
				end

				arg_302_1.text_.text = var_305_11
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231073", "story_v_out_417231.awb") ~= 0 then
					local var_305_14 = manager.audio:GetVoiceLength("story_v_out_417231", "417231073", "story_v_out_417231.awb") / 1000

					if var_305_14 + var_305_8 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_14 + var_305_8
					end

					if var_305_10.prefab_name ~= "" and arg_302_1.actors_[var_305_10.prefab_name] ~= nil then
						local var_305_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_10.prefab_name].transform, "story_v_out_417231", "417231073", "story_v_out_417231.awb")

						arg_302_1:RecordAudio("417231073", var_305_15)
						arg_302_1:RecordAudio("417231073", var_305_15)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_417231", "417231073", "story_v_out_417231.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_417231", "417231073", "story_v_out_417231.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_16 = math.max(var_305_9, arg_302_1.talkMaxDuration)

			if var_305_8 <= arg_302_1.time_ and arg_302_1.time_ < var_305_8 + var_305_16 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_8) / var_305_16

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_8 + var_305_16 and arg_302_1.time_ < var_305_8 + var_305_16 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
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

		arg_302_1:InitPlayNodeList()
	end,
	Play417231074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 417231074
		arg_306_1.duration_ = 12.7

		local var_306_0 = {
			zh = 9.4,
			ja = 12.7
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
				arg_306_0:Play417231075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1060"]) and arg_306_1.var_.actorSpriteComps1060 == nil then
				arg_306_1.var_.actorSpriteComps1060 = arg_306_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_0 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1060"]) then
				if arg_306_1.var_.actorSpriteComps1060 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_309_1 then
							if arg_306_1.isInRecall_ then
								iter_309_1.color = Color.New(Mathf.Lerp(iter_309_1.color.r, arg_306_1.hightColor1.r, (arg_306_1.time_ - 0) / var_309_0), Mathf.Lerp(iter_309_1.color.g, arg_306_1.hightColor1.g, (arg_306_1.time_ - 0) / var_309_0), (Mathf.Lerp(iter_309_1.color.b, arg_306_1.hightColor1.b, (arg_306_1.time_ - 0) / var_309_0)))
							else
								local var_309_1 = Mathf.Lerp(iter_309_1.color.r, 1, (arg_306_1.time_ - 0) / var_309_0)

								iter_309_1.color = Color.New(var_309_1, var_309_1, var_309_1)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1060"]) and arg_306_1.var_.actorSpriteComps1060 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_309_3 then
						iter_309_3.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_306_1.var_.actorSpriteComps1060 = nil
			end

			local var_309_2 = arg_306_1.actors_["1034"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.actorSpriteComps1034 == nil then
				arg_306_1.var_.actorSpriteComps1034 = var_309_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_3 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_3 and not isNil(var_309_2) then
				if arg_306_1.var_.actorSpriteComps1034 then
					for iter_309_4, iter_309_5 in pairs(arg_306_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_309_5 then
							if arg_306_1.isInRecall_ then
								iter_309_5.color = Color.New(Mathf.Lerp(iter_309_5.color.r, arg_306_1.hightColor2.r, (arg_306_1.time_ - 0) / var_309_3), Mathf.Lerp(iter_309_5.color.g, arg_306_1.hightColor2.g, (arg_306_1.time_ - 0) / var_309_3), (Mathf.Lerp(iter_309_5.color.b, arg_306_1.hightColor2.b, (arg_306_1.time_ - 0) / var_309_3)))
							else
								local var_309_4 = Mathf.Lerp(iter_309_5.color.r, 0.5, (arg_306_1.time_ - 0) / var_309_3)

								iter_309_5.color = Color.New(var_309_4, var_309_4, var_309_4)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= 0 + var_309_3 and arg_306_1.time_ < 0 + var_309_3 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.actorSpriteComps1034 then
				for iter_309_6, iter_309_7 in pairs(arg_306_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_309_7 then
						iter_309_7.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_306_1.var_.actorSpriteComps1034 = nil
			end

			local var_309_5 = 0
			local var_309_6 = 0.95

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_5 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_7 = arg_306_1:GetWordFromCfg(417231074)
				local var_309_8 = arg_306_1:FormatText(var_309_7.content)

				arg_306_1.text_.text = var_309_8

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_10 = 38 <= 0 and var_309_6 or var_309_6 * (utf8.len(var_309_8) / 38)

				if (38 <= 0 and var_309_6 or var_309_6 * (utf8.len(var_309_8) / 38)) > 0 and var_309_6 < var_309_10 then
					arg_306_1.talkMaxDuration = var_309_10

					if var_309_10 + var_309_5 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_10 + var_309_5
					end
				end

				arg_306_1.text_.text = var_309_8
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231074", "story_v_out_417231.awb") ~= 0 then
					local var_309_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231074", "story_v_out_417231.awb") / 1000

					if var_309_11 + var_309_5 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_11 + var_309_5
					end

					if var_309_7.prefab_name ~= "" and arg_306_1.actors_[var_309_7.prefab_name] ~= nil then
						local var_309_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_7.prefab_name].transform, "story_v_out_417231", "417231074", "story_v_out_417231.awb")

						arg_306_1:RecordAudio("417231074", var_309_12)
						arg_306_1:RecordAudio("417231074", var_309_12)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_417231", "417231074", "story_v_out_417231.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_417231", "417231074", "story_v_out_417231.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_13 = math.max(var_309_6, arg_306_1.talkMaxDuration)

			if var_309_5 <= arg_306_1.time_ and arg_306_1.time_ < var_309_5 + var_309_13 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_5) / var_309_13

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_5 + var_309_13 and arg_306_1.time_ < var_309_5 + var_309_13 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play417231075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 417231075
		arg_310_1.duration_ = 11.13

		local var_310_0 = {
			zh = 9.566,
			ja = 11.133
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
				arg_310_0:Play417231076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 1.225

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_1 = arg_310_1:GetWordFromCfg(417231075)
				local var_313_2 = arg_310_1:FormatText(var_313_1.content)

				arg_310_1.text_.text = var_313_2

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_4 = 50 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_2) / 50)

				if (50 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_2) / 50)) > 0 and var_313_0 < var_313_4 then
					arg_310_1.talkMaxDuration = var_313_4

					if var_313_4 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_4 + 0
					end
				end

				arg_310_1.text_.text = var_313_2
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231075", "story_v_out_417231.awb") ~= 0 then
					local var_313_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231075", "story_v_out_417231.awb") / 1000

					if var_313_5 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_5 + 0
					end

					if var_313_1.prefab_name ~= "" and arg_310_1.actors_[var_313_1.prefab_name] ~= nil then
						local var_313_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_1.prefab_name].transform, "story_v_out_417231", "417231075", "story_v_out_417231.awb")

						arg_310_1:RecordAudio("417231075", var_313_6)
						arg_310_1:RecordAudio("417231075", var_313_6)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_417231", "417231075", "story_v_out_417231.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_417231", "417231075", "story_v_out_417231.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_7 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_7 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_7

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_7 and arg_310_1.time_ < 0 + var_313_7 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play417231076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 417231076
		arg_314_1.duration_ = 10.4

		local var_314_0 = {
			zh = 7.166,
			ja = 10.4
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
				arg_314_0:Play417231077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["1034"]) and arg_314_1.var_.actorSpriteComps1034 == nil then
				arg_314_1.var_.actorSpriteComps1034 = arg_314_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_0 = 0.2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["1034"]) then
				if arg_314_1.var_.actorSpriteComps1034 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								iter_317_1.color = Color.New(Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor1.r, (arg_314_1.time_ - 0) / var_317_0), Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor1.g, (arg_314_1.time_ - 0) / var_317_0), (Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor1.b, (arg_314_1.time_ - 0) / var_317_0)))
							else
								local var_317_1 = Mathf.Lerp(iter_317_1.color.r, 1, (arg_314_1.time_ - 0) / var_317_0)

								iter_317_1.color = Color.New(var_317_1, var_317_1, var_317_1)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["1034"]) and arg_314_1.var_.actorSpriteComps1034 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_317_3 then
						iter_317_3.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_314_1.var_.actorSpriteComps1034 = nil
			end

			local var_317_2 = arg_314_1.actors_["1060"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.actorSpriteComps1060 == nil then
				arg_314_1.var_.actorSpriteComps1060 = var_317_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_3 = 0.2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_3 and not isNil(var_317_2) then
				if arg_314_1.var_.actorSpriteComps1060 then
					for iter_317_4, iter_317_5 in pairs(arg_314_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_317_5 then
							if arg_314_1.isInRecall_ then
								iter_317_5.color = Color.New(Mathf.Lerp(iter_317_5.color.r, arg_314_1.hightColor2.r, (arg_314_1.time_ - 0) / var_317_3), Mathf.Lerp(iter_317_5.color.g, arg_314_1.hightColor2.g, (arg_314_1.time_ - 0) / var_317_3), (Mathf.Lerp(iter_317_5.color.b, arg_314_1.hightColor2.b, (arg_314_1.time_ - 0) / var_317_3)))
							else
								local var_317_4 = Mathf.Lerp(iter_317_5.color.r, 0.5, (arg_314_1.time_ - 0) / var_317_3)

								iter_317_5.color = Color.New(var_317_4, var_317_4, var_317_4)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_3 and arg_314_1.time_ < 0 + var_317_3 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.actorSpriteComps1060 then
				for iter_317_6, iter_317_7 in pairs(arg_314_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_317_7 then
						iter_317_7.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_314_1.var_.actorSpriteComps1060 = nil
			end

			local var_317_5 = 0
			local var_317_6 = 0.95

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_7 = arg_314_1:GetWordFromCfg(417231076)
				local var_317_8 = arg_314_1:FormatText(var_317_7.content)

				arg_314_1.text_.text = var_317_8

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_10 = 38 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_8) / 38)

				if (38 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_8) / 38)) > 0 and var_317_6 < var_317_10 then
					arg_314_1.talkMaxDuration = var_317_10

					if var_317_10 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_10 + var_317_5
					end
				end

				arg_314_1.text_.text = var_317_8
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231076", "story_v_out_417231.awb") ~= 0 then
					local var_317_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231076", "story_v_out_417231.awb") / 1000

					if var_317_11 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_11 + var_317_5
					end

					if var_317_7.prefab_name ~= "" and arg_314_1.actors_[var_317_7.prefab_name] ~= nil then
						local var_317_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_7.prefab_name].transform, "story_v_out_417231", "417231076", "story_v_out_417231.awb")

						arg_314_1:RecordAudio("417231076", var_317_12)
						arg_314_1:RecordAudio("417231076", var_317_12)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_417231", "417231076", "story_v_out_417231.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_417231", "417231076", "story_v_out_417231.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_13 = math.max(var_317_6, arg_314_1.talkMaxDuration)

			if var_317_5 <= arg_314_1.time_ and arg_314_1.time_ < var_317_5 + var_317_13 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_5) / var_317_13

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_5 + var_317_13 and arg_314_1.time_ < var_317_5 + var_317_13 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play417231077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 417231077
		arg_318_1.duration_ = 7

		local var_318_0 = {
			zh = 6.633,
			ja = 7
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play417231078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["1060"]) and arg_318_1.var_.actorSpriteComps1060 == nil then
				arg_318_1.var_.actorSpriteComps1060 = arg_318_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_0 = 0.2

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["1060"]) then
				if arg_318_1.var_.actorSpriteComps1060 then
					for iter_321_0, iter_321_1 in pairs(arg_318_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_321_1 then
							if arg_318_1.isInRecall_ then
								iter_321_1.color = Color.New(Mathf.Lerp(iter_321_1.color.r, arg_318_1.hightColor1.r, (arg_318_1.time_ - 0) / var_321_0), Mathf.Lerp(iter_321_1.color.g, arg_318_1.hightColor1.g, (arg_318_1.time_ - 0) / var_321_0), (Mathf.Lerp(iter_321_1.color.b, arg_318_1.hightColor1.b, (arg_318_1.time_ - 0) / var_321_0)))
							else
								local var_321_1 = Mathf.Lerp(iter_321_1.color.r, 1, (arg_318_1.time_ - 0) / var_321_0)

								iter_321_1.color = Color.New(var_321_1, var_321_1, var_321_1)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["1060"]) and arg_318_1.var_.actorSpriteComps1060 then
				for iter_321_2, iter_321_3 in pairs(arg_318_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_321_3 then
						iter_321_3.color = arg_318_1.isInRecall_ and (arg_318_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_318_1.var_.actorSpriteComps1060 = nil
			end

			local var_321_2 = arg_318_1.actors_["1034"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.actorSpriteComps1034 == nil then
				arg_318_1.var_.actorSpriteComps1034 = var_321_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_3 = 0.2

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_3 and not isNil(var_321_2) then
				if arg_318_1.var_.actorSpriteComps1034 then
					for iter_321_4, iter_321_5 in pairs(arg_318_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_321_5 then
							if arg_318_1.isInRecall_ then
								iter_321_5.color = Color.New(Mathf.Lerp(iter_321_5.color.r, arg_318_1.hightColor2.r, (arg_318_1.time_ - 0) / var_321_3), Mathf.Lerp(iter_321_5.color.g, arg_318_1.hightColor2.g, (arg_318_1.time_ - 0) / var_321_3), (Mathf.Lerp(iter_321_5.color.b, arg_318_1.hightColor2.b, (arg_318_1.time_ - 0) / var_321_3)))
							else
								local var_321_4 = Mathf.Lerp(iter_321_5.color.r, 0.5, (arg_318_1.time_ - 0) / var_321_3)

								iter_321_5.color = Color.New(var_321_4, var_321_4, var_321_4)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= 0 + var_321_3 and arg_318_1.time_ < 0 + var_321_3 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.actorSpriteComps1034 then
				for iter_321_6, iter_321_7 in pairs(arg_318_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_321_7 then
						iter_321_7.color = arg_318_1.isInRecall_ and (arg_318_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_318_1.var_.actorSpriteComps1034 = nil
			end

			local var_321_5 = arg_318_1.actors_["1060"].transform

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.var_.moveOldPos1060 = var_321_5.localPosition
				var_321_5.localScale = Vector3.New(1, 1, 1)

				arg_318_1:CheckSpriteTmpPos("1060", 4)

				for iter_321_8 = 0, var_321_5.childCount - 1 do
					local var_321_6 = var_321_5:GetChild(iter_321_8)

					if var_321_6.name == "split_2" or not string.find(var_321_6.name, "split") then
						var_321_6.gameObject:SetActive(true)
					else
						var_321_6.gameObject:SetActive(false)
					end
				end
			end

			local var_321_7 = 0.001

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_7 then
				var_321_5.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_318_1.time_ - 0) / var_321_7)
			end

			if arg_318_1.time_ >= 0 + var_321_7 and arg_318_1.time_ < 0 + var_321_7 + arg_321_0 then
				var_321_5.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_321_8 = 0
			local var_321_9 = 0.75

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_8 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_10 = arg_318_1:GetWordFromCfg(417231077)
				local var_321_11 = arg_318_1:FormatText(var_321_10.content)

				arg_318_1.text_.text = var_321_11

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_13 = 30 <= 0 and var_321_9 or var_321_9 * (utf8.len(var_321_11) / 30)

				if (30 <= 0 and var_321_9 or var_321_9 * (utf8.len(var_321_11) / 30)) > 0 and var_321_9 < var_321_13 then
					arg_318_1.talkMaxDuration = var_321_13

					if var_321_13 + var_321_8 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_13 + var_321_8
					end
				end

				arg_318_1.text_.text = var_321_11
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231077", "story_v_out_417231.awb") ~= 0 then
					local var_321_14 = manager.audio:GetVoiceLength("story_v_out_417231", "417231077", "story_v_out_417231.awb") / 1000

					if var_321_14 + var_321_8 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_14 + var_321_8
					end

					if var_321_10.prefab_name ~= "" and arg_318_1.actors_[var_321_10.prefab_name] ~= nil then
						local var_321_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_10.prefab_name].transform, "story_v_out_417231", "417231077", "story_v_out_417231.awb")

						arg_318_1:RecordAudio("417231077", var_321_15)
						arg_318_1:RecordAudio("417231077", var_321_15)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_417231", "417231077", "story_v_out_417231.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_417231", "417231077", "story_v_out_417231.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_16 = math.max(var_321_9, arg_318_1.talkMaxDuration)

			if var_321_8 <= arg_318_1.time_ and arg_318_1.time_ < var_321_8 + var_321_16 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_8) / var_321_16

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_8 + var_321_16 and arg_318_1.time_ < var_321_8 + var_321_16 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play417231078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 417231078
		arg_322_1.duration_ = 13.47

		local var_322_0 = {
			zh = 9.6,
			ja = 13.466
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
				arg_322_0:Play417231079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 1.225

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_1 = arg_322_1:GetWordFromCfg(417231078)
				local var_325_2 = arg_322_1:FormatText(var_325_1.content)

				arg_322_1.text_.text = var_325_2

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 49 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 49)

				if (49 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 49)) > 0 and var_325_0 < var_325_4 then
					arg_322_1.talkMaxDuration = var_325_4

					if var_325_4 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_4 + 0
					end
				end

				arg_322_1.text_.text = var_325_2
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231078", "story_v_out_417231.awb") ~= 0 then
					local var_325_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231078", "story_v_out_417231.awb") / 1000

					if var_325_5 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + 0
					end

					if var_325_1.prefab_name ~= "" and arg_322_1.actors_[var_325_1.prefab_name] ~= nil then
						local var_325_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_1.prefab_name].transform, "story_v_out_417231", "417231078", "story_v_out_417231.awb")

						arg_322_1:RecordAudio("417231078", var_325_6)
						arg_322_1:RecordAudio("417231078", var_325_6)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_417231", "417231078", "story_v_out_417231.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_417231", "417231078", "story_v_out_417231.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_7 and arg_322_1.time_ < 0 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play417231079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 417231079
		arg_326_1.duration_ = 12.57

		local var_326_0 = {
			zh = 10.766,
			ja = 12.566
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play417231080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos1060 = arg_326_1.actors_["1060"].transform.localPosition
				arg_326_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_326_1:CheckSpriteTmpPos("1060", 4)

				for iter_329_0 = 0, arg_326_1.actors_["1060"].transform.childCount - 1 do
					local var_329_0 = arg_326_1.actors_["1060"].transform:GetChild(iter_329_0)

					if var_329_0.name == "split_5" or not string.find(var_329_0.name, "split") then
						var_329_0.gameObject:SetActive(true)
					else
						var_329_0.gameObject:SetActive(false)
					end
				end
			end

			local var_329_1 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_1 then
				arg_326_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_326_1.time_ - 0) / var_329_1)
			end

			if arg_326_1.time_ >= 0 + var_329_1 and arg_326_1.time_ < 0 + var_329_1 + arg_329_0 then
				arg_326_1.actors_["1060"].transform.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_329_2 = 0
			local var_329_3 = 1.3

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_2 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_4 = arg_326_1:GetWordFromCfg(417231079)
				local var_329_5 = arg_326_1:FormatText(var_329_4.content)

				arg_326_1.text_.text = var_329_5

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_7 = 52 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_5) / 52)

				if (52 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_5) / 52)) > 0 and var_329_3 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_2
					end
				end

				arg_326_1.text_.text = var_329_5
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231079", "story_v_out_417231.awb") ~= 0 then
					local var_329_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231079", "story_v_out_417231.awb") / 1000

					if var_329_8 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_8 + var_329_2
					end

					if var_329_4.prefab_name ~= "" and arg_326_1.actors_[var_329_4.prefab_name] ~= nil then
						local var_329_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_4.prefab_name].transform, "story_v_out_417231", "417231079", "story_v_out_417231.awb")

						arg_326_1:RecordAudio("417231079", var_329_9)
						arg_326_1:RecordAudio("417231079", var_329_9)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_417231", "417231079", "story_v_out_417231.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_417231", "417231079", "story_v_out_417231.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_10 = math.max(var_329_3, arg_326_1.talkMaxDuration)

			if var_329_2 <= arg_326_1.time_ and arg_326_1.time_ < var_329_2 + var_329_10 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_2) / var_329_10

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_2 + var_329_10 and arg_326_1.time_ < var_329_2 + var_329_10 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play417231080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 417231080
		arg_330_1.duration_ = 4.27

		local var_330_0 = {
			zh = 1.333,
			ja = 4.266
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play417231081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["1034"]) and arg_330_1.var_.actorSpriteComps1034 == nil then
				arg_330_1.var_.actorSpriteComps1034 = arg_330_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_0 = 0.2

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["1034"]) then
				if arg_330_1.var_.actorSpriteComps1034 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								iter_333_1.color = Color.New(Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor1.r, (arg_330_1.time_ - 0) / var_333_0), Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor1.g, (arg_330_1.time_ - 0) / var_333_0), (Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor1.b, (arg_330_1.time_ - 0) / var_333_0)))
							else
								local var_333_1 = Mathf.Lerp(iter_333_1.color.r, 1, (arg_330_1.time_ - 0) / var_333_0)

								iter_333_1.color = Color.New(var_333_1, var_333_1, var_333_1)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["1034"]) and arg_330_1.var_.actorSpriteComps1034 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_333_3 then
						iter_333_3.color = arg_330_1.isInRecall_ and (arg_330_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_330_1.var_.actorSpriteComps1034 = nil
			end

			local var_333_2 = arg_330_1.actors_["1060"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_2) and arg_330_1.var_.actorSpriteComps1060 == nil then
				arg_330_1.var_.actorSpriteComps1060 = var_333_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_3 = 0.2

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_3 and not isNil(var_333_2) then
				if arg_330_1.var_.actorSpriteComps1060 then
					for iter_333_4, iter_333_5 in pairs(arg_330_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_333_5 then
							if arg_330_1.isInRecall_ then
								iter_333_5.color = Color.New(Mathf.Lerp(iter_333_5.color.r, arg_330_1.hightColor2.r, (arg_330_1.time_ - 0) / var_333_3), Mathf.Lerp(iter_333_5.color.g, arg_330_1.hightColor2.g, (arg_330_1.time_ - 0) / var_333_3), (Mathf.Lerp(iter_333_5.color.b, arg_330_1.hightColor2.b, (arg_330_1.time_ - 0) / var_333_3)))
							else
								local var_333_4 = Mathf.Lerp(iter_333_5.color.r, 0.5, (arg_330_1.time_ - 0) / var_333_3)

								iter_333_5.color = Color.New(var_333_4, var_333_4, var_333_4)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= 0 + var_333_3 and arg_330_1.time_ < 0 + var_333_3 + arg_333_0 and not isNil(var_333_2) and arg_330_1.var_.actorSpriteComps1060 then
				for iter_333_6, iter_333_7 in pairs(arg_330_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_333_7 then
						iter_333_7.color = arg_330_1.isInRecall_ and (arg_330_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_330_1.var_.actorSpriteComps1060 = nil
			end

			local var_333_5 = 0
			local var_333_6 = 0.125

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_5 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_7 = arg_330_1:GetWordFromCfg(417231080)
				local var_333_8 = arg_330_1:FormatText(var_333_7.content)

				arg_330_1.text_.text = var_333_8

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_10 = 5 <= 0 and var_333_6 or var_333_6 * (utf8.len(var_333_8) / 5)

				if (5 <= 0 and var_333_6 or var_333_6 * (utf8.len(var_333_8) / 5)) > 0 and var_333_6 < var_333_10 then
					arg_330_1.talkMaxDuration = var_333_10

					if var_333_10 + var_333_5 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_10 + var_333_5
					end
				end

				arg_330_1.text_.text = var_333_8
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231080", "story_v_out_417231.awb") ~= 0 then
					local var_333_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231080", "story_v_out_417231.awb") / 1000

					if var_333_11 + var_333_5 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_11 + var_333_5
					end

					if var_333_7.prefab_name ~= "" and arg_330_1.actors_[var_333_7.prefab_name] ~= nil then
						local var_333_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_7.prefab_name].transform, "story_v_out_417231", "417231080", "story_v_out_417231.awb")

						arg_330_1:RecordAudio("417231080", var_333_12)
						arg_330_1:RecordAudio("417231080", var_333_12)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_417231", "417231080", "story_v_out_417231.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_417231", "417231080", "story_v_out_417231.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_13 = math.max(var_333_6, arg_330_1.talkMaxDuration)

			if var_333_5 <= arg_330_1.time_ and arg_330_1.time_ < var_333_5 + var_333_13 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_5) / var_333_13

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_5 + var_333_13 and arg_330_1.time_ < var_333_5 + var_333_13 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play417231081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 417231081
		arg_334_1.duration_ = 4.9

		local var_334_0 = {
			zh = 4.9,
			ja = 4
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play417231082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["1060"]) and arg_334_1.var_.actorSpriteComps1060 == nil then
				arg_334_1.var_.actorSpriteComps1060 = arg_334_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_0 = 0.2

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["1060"]) then
				if arg_334_1.var_.actorSpriteComps1060 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								iter_337_1.color = Color.New(Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor1.r, (arg_334_1.time_ - 0) / var_337_0), Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor1.g, (arg_334_1.time_ - 0) / var_337_0), (Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor1.b, (arg_334_1.time_ - 0) / var_337_0)))
							else
								local var_337_1 = Mathf.Lerp(iter_337_1.color.r, 1, (arg_334_1.time_ - 0) / var_337_0)

								iter_337_1.color = Color.New(var_337_1, var_337_1, var_337_1)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["1060"]) and arg_334_1.var_.actorSpriteComps1060 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_337_3 then
						iter_337_3.color = arg_334_1.isInRecall_ and (arg_334_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_334_1.var_.actorSpriteComps1060 = nil
			end

			local var_337_2 = arg_334_1.actors_["1034"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_2) and arg_334_1.var_.actorSpriteComps1034 == nil then
				arg_334_1.var_.actorSpriteComps1034 = var_337_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_3 = 0.2

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_3 and not isNil(var_337_2) then
				if arg_334_1.var_.actorSpriteComps1034 then
					for iter_337_4, iter_337_5 in pairs(arg_334_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_337_5 then
							if arg_334_1.isInRecall_ then
								iter_337_5.color = Color.New(Mathf.Lerp(iter_337_5.color.r, arg_334_1.hightColor2.r, (arg_334_1.time_ - 0) / var_337_3), Mathf.Lerp(iter_337_5.color.g, arg_334_1.hightColor2.g, (arg_334_1.time_ - 0) / var_337_3), (Mathf.Lerp(iter_337_5.color.b, arg_334_1.hightColor2.b, (arg_334_1.time_ - 0) / var_337_3)))
							else
								local var_337_4 = Mathf.Lerp(iter_337_5.color.r, 0.5, (arg_334_1.time_ - 0) / var_337_3)

								iter_337_5.color = Color.New(var_337_4, var_337_4, var_337_4)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= 0 + var_337_3 and arg_334_1.time_ < 0 + var_337_3 + arg_337_0 and not isNil(var_337_2) and arg_334_1.var_.actorSpriteComps1034 then
				for iter_337_6, iter_337_7 in pairs(arg_334_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_337_7 then
						iter_337_7.color = arg_334_1.isInRecall_ and (arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_334_1.var_.actorSpriteComps1034 = nil
			end

			local var_337_5 = 0
			local var_337_6 = 0.55

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_7 = arg_334_1:GetWordFromCfg(417231081)
				local var_337_8 = arg_334_1:FormatText(var_337_7.content)

				arg_334_1.text_.text = var_337_8

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_10 = 22 <= 0 and var_337_6 or var_337_6 * (utf8.len(var_337_8) / 22)

				if (22 <= 0 and var_337_6 or var_337_6 * (utf8.len(var_337_8) / 22)) > 0 and var_337_6 < var_337_10 then
					arg_334_1.talkMaxDuration = var_337_10

					if var_337_10 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_10 + var_337_5
					end
				end

				arg_334_1.text_.text = var_337_8
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231081", "story_v_out_417231.awb") ~= 0 then
					local var_337_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231081", "story_v_out_417231.awb") / 1000

					if var_337_11 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_11 + var_337_5
					end

					if var_337_7.prefab_name ~= "" and arg_334_1.actors_[var_337_7.prefab_name] ~= nil then
						local var_337_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_7.prefab_name].transform, "story_v_out_417231", "417231081", "story_v_out_417231.awb")

						arg_334_1:RecordAudio("417231081", var_337_12)
						arg_334_1:RecordAudio("417231081", var_337_12)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_417231", "417231081", "story_v_out_417231.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_417231", "417231081", "story_v_out_417231.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_13 = math.max(var_337_6, arg_334_1.talkMaxDuration)

			if var_337_5 <= arg_334_1.time_ and arg_334_1.time_ < var_337_5 + var_337_13 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_5) / var_337_13

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_5 + var_337_13 and arg_334_1.time_ < var_337_5 + var_337_13 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play417231082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 417231082
		arg_338_1.duration_ = 8.33

		local var_338_0 = {
			zh = 8.033,
			ja = 8.333
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play417231083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.975

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_1 = arg_338_1:GetWordFromCfg(417231082)
				local var_341_2 = arg_338_1:FormatText(var_341_1.content)

				arg_338_1.text_.text = var_341_2

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_4 = 39 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_2) / 39)

				if (39 <= 0 and var_341_0 or var_341_0 * (utf8.len(var_341_2) / 39)) > 0 and var_341_0 < var_341_4 then
					arg_338_1.talkMaxDuration = var_341_4

					if var_341_4 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_4 + 0
					end
				end

				arg_338_1.text_.text = var_341_2
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231082", "story_v_out_417231.awb") ~= 0 then
					local var_341_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231082", "story_v_out_417231.awb") / 1000

					if var_341_5 + 0 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_5 + 0
					end

					if var_341_1.prefab_name ~= "" and arg_338_1.actors_[var_341_1.prefab_name] ~= nil then
						local var_341_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_1.prefab_name].transform, "story_v_out_417231", "417231082", "story_v_out_417231.awb")

						arg_338_1:RecordAudio("417231082", var_341_6)
						arg_338_1:RecordAudio("417231082", var_341_6)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_417231", "417231082", "story_v_out_417231.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_417231", "417231082", "story_v_out_417231.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_7 = math.max(var_341_0, arg_338_1.talkMaxDuration)

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_7 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - 0) / var_341_7

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= 0 + var_341_7 and arg_338_1.time_ < 0 + var_341_7 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play417231083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 417231083
		arg_342_1.duration_ = 12.47

		local var_342_0 = {
			zh = 6.333,
			ja = 12.466
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play417231084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1034"]) and arg_342_1.var_.actorSpriteComps1034 == nil then
				arg_342_1.var_.actorSpriteComps1034 = arg_342_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_0 = 0.2

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1034"]) then
				if arg_342_1.var_.actorSpriteComps1034 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								iter_345_1.color = Color.New(Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor1.r, (arg_342_1.time_ - 0) / var_345_0), Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor1.g, (arg_342_1.time_ - 0) / var_345_0), (Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor1.b, (arg_342_1.time_ - 0) / var_345_0)))
							else
								local var_345_1 = Mathf.Lerp(iter_345_1.color.r, 1, (arg_342_1.time_ - 0) / var_345_0)

								iter_345_1.color = Color.New(var_345_1, var_345_1, var_345_1)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1034"]) and arg_342_1.var_.actorSpriteComps1034 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_345_3 then
						iter_345_3.color = arg_342_1.isInRecall_ and (arg_342_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_342_1.var_.actorSpriteComps1034 = nil
			end

			local var_345_2 = arg_342_1.actors_["1060"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_2) and arg_342_1.var_.actorSpriteComps1060 == nil then
				arg_342_1.var_.actorSpriteComps1060 = var_345_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_3 = 0.2

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_3 and not isNil(var_345_2) then
				if arg_342_1.var_.actorSpriteComps1060 then
					for iter_345_4, iter_345_5 in pairs(arg_342_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_345_5 then
							if arg_342_1.isInRecall_ then
								iter_345_5.color = Color.New(Mathf.Lerp(iter_345_5.color.r, arg_342_1.hightColor2.r, (arg_342_1.time_ - 0) / var_345_3), Mathf.Lerp(iter_345_5.color.g, arg_342_1.hightColor2.g, (arg_342_1.time_ - 0) / var_345_3), (Mathf.Lerp(iter_345_5.color.b, arg_342_1.hightColor2.b, (arg_342_1.time_ - 0) / var_345_3)))
							else
								local var_345_4 = Mathf.Lerp(iter_345_5.color.r, 0.5, (arg_342_1.time_ - 0) / var_345_3)

								iter_345_5.color = Color.New(var_345_4, var_345_4, var_345_4)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= 0 + var_345_3 and arg_342_1.time_ < 0 + var_345_3 + arg_345_0 and not isNil(var_345_2) and arg_342_1.var_.actorSpriteComps1060 then
				for iter_345_6, iter_345_7 in pairs(arg_342_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_345_7 then
						iter_345_7.color = arg_342_1.isInRecall_ and (arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_342_1.var_.actorSpriteComps1060 = nil
			end

			local var_345_5 = arg_342_1.actors_["1034"].transform

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos1034 = var_345_5.localPosition
				var_345_5.localScale = Vector3.New(1, 1, 1)

				arg_342_1:CheckSpriteTmpPos("1034", 2)

				for iter_345_8 = 0, var_345_5.childCount - 1 do
					local var_345_6 = var_345_5:GetChild(iter_345_8)

					if var_345_6.name == "split_4" or not string.find(var_345_6.name, "split") then
						var_345_6.gameObject:SetActive(true)
					else
						var_345_6.gameObject:SetActive(false)
					end
				end
			end

			local var_345_7 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_7 then
				var_345_5.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_342_1.time_ - 0) / var_345_7)
			end

			if arg_342_1.time_ >= 0 + var_345_7 and arg_342_1.time_ < 0 + var_345_7 + arg_345_0 then
				var_345_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_345_8 = 0
			local var_345_9 = 0.925

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_8 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_10 = arg_342_1:GetWordFromCfg(417231083)
				local var_345_11 = arg_342_1:FormatText(var_345_10.content)

				arg_342_1.text_.text = var_345_11

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_13 = 37 <= 0 and var_345_9 or var_345_9 * (utf8.len(var_345_11) / 37)

				if (37 <= 0 and var_345_9 or var_345_9 * (utf8.len(var_345_11) / 37)) > 0 and var_345_9 < var_345_13 then
					arg_342_1.talkMaxDuration = var_345_13

					if var_345_13 + var_345_8 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_13 + var_345_8
					end
				end

				arg_342_1.text_.text = var_345_11
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231083", "story_v_out_417231.awb") ~= 0 then
					local var_345_14 = manager.audio:GetVoiceLength("story_v_out_417231", "417231083", "story_v_out_417231.awb") / 1000

					if var_345_14 + var_345_8 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_14 + var_345_8
					end

					if var_345_10.prefab_name ~= "" and arg_342_1.actors_[var_345_10.prefab_name] ~= nil then
						local var_345_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_10.prefab_name].transform, "story_v_out_417231", "417231083", "story_v_out_417231.awb")

						arg_342_1:RecordAudio("417231083", var_345_15)
						arg_342_1:RecordAudio("417231083", var_345_15)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_417231", "417231083", "story_v_out_417231.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_417231", "417231083", "story_v_out_417231.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_16 = math.max(var_345_9, arg_342_1.talkMaxDuration)

			if var_345_8 <= arg_342_1.time_ and arg_342_1.time_ < var_345_8 + var_345_16 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_8) / var_345_16

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_8 + var_345_16 and arg_342_1.time_ < var_345_8 + var_345_16 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
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

		arg_342_1:InitPlayNodeList()
	end,
	Play417231084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 417231084
		arg_346_1.duration_ = 5.4

		local var_346_0 = {
			zh = 3.533,
			ja = 5.4
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play417231085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1060"]) and arg_346_1.var_.actorSpriteComps1060 == nil then
				arg_346_1.var_.actorSpriteComps1060 = arg_346_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_0 = 0.2

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1060"]) then
				if arg_346_1.var_.actorSpriteComps1060 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								iter_349_1.color = Color.New(Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor1.r, (arg_346_1.time_ - 0) / var_349_0), Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor1.g, (arg_346_1.time_ - 0) / var_349_0), (Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor1.b, (arg_346_1.time_ - 0) / var_349_0)))
							else
								local var_349_1 = Mathf.Lerp(iter_349_1.color.r, 1, (arg_346_1.time_ - 0) / var_349_0)

								iter_349_1.color = Color.New(var_349_1, var_349_1, var_349_1)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1060"]) and arg_346_1.var_.actorSpriteComps1060 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_349_3 then
						iter_349_3.color = arg_346_1.isInRecall_ and (arg_346_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_346_1.var_.actorSpriteComps1060 = nil
			end

			local var_349_2 = arg_346_1.actors_["1034"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_2) and arg_346_1.var_.actorSpriteComps1034 == nil then
				arg_346_1.var_.actorSpriteComps1034 = var_349_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_3 = 0.2

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_3 and not isNil(var_349_2) then
				if arg_346_1.var_.actorSpriteComps1034 then
					for iter_349_4, iter_349_5 in pairs(arg_346_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_349_5 then
							if arg_346_1.isInRecall_ then
								iter_349_5.color = Color.New(Mathf.Lerp(iter_349_5.color.r, arg_346_1.hightColor2.r, (arg_346_1.time_ - 0) / var_349_3), Mathf.Lerp(iter_349_5.color.g, arg_346_1.hightColor2.g, (arg_346_1.time_ - 0) / var_349_3), (Mathf.Lerp(iter_349_5.color.b, arg_346_1.hightColor2.b, (arg_346_1.time_ - 0) / var_349_3)))
							else
								local var_349_4 = Mathf.Lerp(iter_349_5.color.r, 0.5, (arg_346_1.time_ - 0) / var_349_3)

								iter_349_5.color = Color.New(var_349_4, var_349_4, var_349_4)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= 0 + var_349_3 and arg_346_1.time_ < 0 + var_349_3 + arg_349_0 and not isNil(var_349_2) and arg_346_1.var_.actorSpriteComps1034 then
				for iter_349_6, iter_349_7 in pairs(arg_346_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_349_7 then
						iter_349_7.color = arg_346_1.isInRecall_ and (arg_346_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_346_1.var_.actorSpriteComps1034 = nil
			end

			local var_349_5 = 0
			local var_349_6 = 0.5

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_5 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_7 = arg_346_1:GetWordFromCfg(417231084)
				local var_349_8 = arg_346_1:FormatText(var_349_7.content)

				arg_346_1.text_.text = var_349_8

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_10 = 21 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_8) / 21)

				if (21 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_8) / 21)) > 0 and var_349_6 < var_349_10 then
					arg_346_1.talkMaxDuration = var_349_10

					if var_349_10 + var_349_5 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_5
					end
				end

				arg_346_1.text_.text = var_349_8
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231084", "story_v_out_417231.awb") ~= 0 then
					local var_349_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231084", "story_v_out_417231.awb") / 1000

					if var_349_11 + var_349_5 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_11 + var_349_5
					end

					if var_349_7.prefab_name ~= "" and arg_346_1.actors_[var_349_7.prefab_name] ~= nil then
						local var_349_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_7.prefab_name].transform, "story_v_out_417231", "417231084", "story_v_out_417231.awb")

						arg_346_1:RecordAudio("417231084", var_349_12)
						arg_346_1:RecordAudio("417231084", var_349_12)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_417231", "417231084", "story_v_out_417231.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_417231", "417231084", "story_v_out_417231.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_13 = math.max(var_349_6, arg_346_1.talkMaxDuration)

			if var_349_5 <= arg_346_1.time_ and arg_346_1.time_ < var_349_5 + var_349_13 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_5) / var_349_13

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_5 + var_349_13 and arg_346_1.time_ < var_349_5 + var_349_13 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play417231085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 417231085
		arg_350_1.duration_ = 4.63

		local var_350_0 = {
			zh = 2.4,
			ja = 4.633
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play417231086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1034"]) and arg_350_1.var_.actorSpriteComps1034 == nil then
				arg_350_1.var_.actorSpriteComps1034 = arg_350_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_0 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1034"]) then
				if arg_350_1.var_.actorSpriteComps1034 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								iter_353_1.color = Color.New(Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor1.r, (arg_350_1.time_ - 0) / var_353_0), Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor1.g, (arg_350_1.time_ - 0) / var_353_0), (Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor1.b, (arg_350_1.time_ - 0) / var_353_0)))
							else
								local var_353_1 = Mathf.Lerp(iter_353_1.color.r, 1, (arg_350_1.time_ - 0) / var_353_0)

								iter_353_1.color = Color.New(var_353_1, var_353_1, var_353_1)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1034"]) and arg_350_1.var_.actorSpriteComps1034 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_353_3 then
						iter_353_3.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_350_1.var_.actorSpriteComps1034 = nil
			end

			local var_353_2 = arg_350_1.actors_["1060"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.actorSpriteComps1060 == nil then
				arg_350_1.var_.actorSpriteComps1060 = var_353_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_3 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_3 and not isNil(var_353_2) then
				if arg_350_1.var_.actorSpriteComps1060 then
					for iter_353_4, iter_353_5 in pairs(arg_350_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_353_5 then
							if arg_350_1.isInRecall_ then
								iter_353_5.color = Color.New(Mathf.Lerp(iter_353_5.color.r, arg_350_1.hightColor2.r, (arg_350_1.time_ - 0) / var_353_3), Mathf.Lerp(iter_353_5.color.g, arg_350_1.hightColor2.g, (arg_350_1.time_ - 0) / var_353_3), (Mathf.Lerp(iter_353_5.color.b, arg_350_1.hightColor2.b, (arg_350_1.time_ - 0) / var_353_3)))
							else
								local var_353_4 = Mathf.Lerp(iter_353_5.color.r, 0.5, (arg_350_1.time_ - 0) / var_353_3)

								iter_353_5.color = Color.New(var_353_4, var_353_4, var_353_4)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_3 and arg_350_1.time_ < 0 + var_353_3 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.actorSpriteComps1060 then
				for iter_353_6, iter_353_7 in pairs(arg_350_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_353_7 then
						iter_353_7.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_350_1.var_.actorSpriteComps1060 = nil
			end

			local var_353_5 = 0
			local var_353_6 = 0.175

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_5 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_7 = arg_350_1:GetWordFromCfg(417231085)
				local var_353_8 = arg_350_1:FormatText(var_353_7.content)

				arg_350_1.text_.text = var_353_8

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_10 = 7 <= 0 and var_353_6 or var_353_6 * (utf8.len(var_353_8) / 7)

				if (7 <= 0 and var_353_6 or var_353_6 * (utf8.len(var_353_8) / 7)) > 0 and var_353_6 < var_353_10 then
					arg_350_1.talkMaxDuration = var_353_10

					if var_353_10 + var_353_5 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_10 + var_353_5
					end
				end

				arg_350_1.text_.text = var_353_8
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231085", "story_v_out_417231.awb") ~= 0 then
					local var_353_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231085", "story_v_out_417231.awb") / 1000

					if var_353_11 + var_353_5 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_11 + var_353_5
					end

					if var_353_7.prefab_name ~= "" and arg_350_1.actors_[var_353_7.prefab_name] ~= nil then
						local var_353_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_7.prefab_name].transform, "story_v_out_417231", "417231085", "story_v_out_417231.awb")

						arg_350_1:RecordAudio("417231085", var_353_12)
						arg_350_1:RecordAudio("417231085", var_353_12)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_417231", "417231085", "story_v_out_417231.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_417231", "417231085", "story_v_out_417231.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_13 = math.max(var_353_6, arg_350_1.talkMaxDuration)

			if var_353_5 <= arg_350_1.time_ and arg_350_1.time_ < var_353_5 + var_353_13 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_5) / var_353_13

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_5 + var_353_13 and arg_350_1.time_ < var_353_5 + var_353_13 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play417231086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 417231086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play417231087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos1034 = arg_354_1.actors_["1034"].transform.localPosition
				arg_354_1.actors_["1034"].transform.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("1034", 7)

				for iter_357_0 = 0, arg_354_1.actors_["1034"].transform.childCount - 1 do
					local var_357_0 = arg_354_1.actors_["1034"].transform:GetChild(iter_357_0)

					if var_357_0.name == "" or not string.find(var_357_0.name, "split") then
						var_357_0.gameObject:SetActive(true)
					else
						var_357_0.gameObject:SetActive(false)
					end
				end
			end

			local var_357_1 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_1 then
				arg_354_1.actors_["1034"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_354_1.time_ - 0) / var_357_1)
			end

			if arg_354_1.time_ >= 0 + var_357_1 and arg_354_1.time_ < 0 + var_357_1 + arg_357_0 then
				arg_354_1.actors_["1034"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_357_2 = arg_354_1.actors_["1060"].transform

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos1060 = var_357_2.localPosition
				var_357_2.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("1060", 7)

				for iter_357_1 = 0, var_357_2.childCount - 1 do
					local var_357_3 = var_357_2:GetChild(iter_357_1)

					if var_357_3.name == "" or not string.find(var_357_3.name, "split") then
						var_357_3.gameObject:SetActive(true)
					else
						var_357_3.gameObject:SetActive(false)
					end
				end
			end

			local var_357_4 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				var_357_2.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_354_1.time_ - 0) / var_357_4)
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				var_357_2.localPosition = Vector3.New(0, -2000, -40)
			end

			if 0.02 < arg_354_1.time_ and arg_354_1.time_ <= 0.02 + arg_357_0 then
				arg_354_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_side_1033_drink", "")
			end

			local var_357_6 = 0
			local var_357_7 = 0.95

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_6 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_8 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(417231086).content)

				arg_354_1.text_.text = var_357_8

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_10 = 38 <= 0 and var_357_7 or var_357_7 * (utf8.len(var_357_8) / 38)

				if (38 <= 0 and var_357_7 or var_357_7 * (utf8.len(var_357_8) / 38)) > 0 and var_357_7 < var_357_10 then
					arg_354_1.talkMaxDuration = var_357_10

					if var_357_10 + var_357_6 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_10 + var_357_6
					end
				end

				arg_354_1.text_.text = var_357_8
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_11 = math.max(var_357_7, arg_354_1.talkMaxDuration)

			if var_357_6 <= arg_354_1.time_ and arg_354_1.time_ < var_357_6 + var_357_11 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_6) / var_357_11

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_6 + var_357_11 and arg_354_1.time_ < var_357_6 + var_357_11 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play417231087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 417231087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play417231088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 1.2

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_1 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(417231087).content)

				arg_358_1.text_.text = var_361_1

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_3 = 48 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 48)

				if (48 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 48)) > 0 and var_361_0 < var_361_3 then
					arg_358_1.talkMaxDuration = var_361_3

					if var_361_3 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_3 + 0
					end
				end

				arg_358_1.text_.text = var_361_1
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_4 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_4

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play417231088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 417231088
		arg_362_1.duration_ = 2.57

		local var_362_0 = {
			zh = 0.999999999999,
			ja = 2.566
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
				arg_362_0:Play417231089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["1034"]) and arg_362_1.var_.actorSpriteComps1034 == nil then
				arg_362_1.var_.actorSpriteComps1034 = arg_362_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_0 = 0.2

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["1034"]) then
				if arg_362_1.var_.actorSpriteComps1034 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_365_1 then
							if arg_362_1.isInRecall_ then
								iter_365_1.color = Color.New(Mathf.Lerp(iter_365_1.color.r, arg_362_1.hightColor1.r, (arg_362_1.time_ - 0) / var_365_0), Mathf.Lerp(iter_365_1.color.g, arg_362_1.hightColor1.g, (arg_362_1.time_ - 0) / var_365_0), (Mathf.Lerp(iter_365_1.color.b, arg_362_1.hightColor1.b, (arg_362_1.time_ - 0) / var_365_0)))
							else
								local var_365_1 = Mathf.Lerp(iter_365_1.color.r, 1, (arg_362_1.time_ - 0) / var_365_0)

								iter_365_1.color = Color.New(var_365_1, var_365_1, var_365_1)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["1034"]) and arg_362_1.var_.actorSpriteComps1034 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_365_3 then
						iter_365_3.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_362_1.var_.actorSpriteComps1034 = nil
			end

			local var_365_2 = arg_362_1.actors_["1034"].transform

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos1034 = var_365_2.localPosition
				var_365_2.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("1034", 3)

				for iter_365_4 = 0, var_365_2.childCount - 1 do
					local var_365_3 = var_365_2:GetChild(iter_365_4)

					if var_365_3.name == "split_5" or not string.find(var_365_3.name, "split") then
						var_365_3.gameObject:SetActive(true)
					else
						var_365_3.gameObject:SetActive(false)
					end
				end
			end

			local var_365_4 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_4 then
				var_365_2.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_362_1.time_ - 0) / var_365_4)
			end

			if arg_362_1.time_ >= 0 + var_365_4 and arg_362_1.time_ < 0 + var_365_4 + arg_365_0 then
				var_365_2.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_365_5 = 0
			local var_365_6 = 0.125

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_5 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_7 = arg_362_1:GetWordFromCfg(417231088)
				local var_365_8 = arg_362_1:FormatText(var_365_7.content)

				arg_362_1.text_.text = var_365_8

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_10 = 5 <= 0 and var_365_6 or var_365_6 * (utf8.len(var_365_8) / 5)

				if (5 <= 0 and var_365_6 or var_365_6 * (utf8.len(var_365_8) / 5)) > 0 and var_365_6 < var_365_10 then
					arg_362_1.talkMaxDuration = var_365_10

					if var_365_10 + var_365_5 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_10 + var_365_5
					end
				end

				arg_362_1.text_.text = var_365_8
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231088", "story_v_out_417231.awb") ~= 0 then
					local var_365_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231088", "story_v_out_417231.awb") / 1000

					if var_365_11 + var_365_5 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_11 + var_365_5
					end

					if var_365_7.prefab_name ~= "" and arg_362_1.actors_[var_365_7.prefab_name] ~= nil then
						local var_365_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_7.prefab_name].transform, "story_v_out_417231", "417231088", "story_v_out_417231.awb")

						arg_362_1:RecordAudio("417231088", var_365_12)
						arg_362_1:RecordAudio("417231088", var_365_12)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_417231", "417231088", "story_v_out_417231.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_417231", "417231088", "story_v_out_417231.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_13 = math.max(var_365_6, arg_362_1.talkMaxDuration)

			if var_365_5 <= arg_362_1.time_ and arg_362_1.time_ < var_365_5 + var_365_13 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_5) / var_365_13

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_5 + var_365_13 and arg_362_1.time_ < var_365_5 + var_365_13 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
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

		arg_362_1:InitPlayNodeList()
	end,
	Play417231089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 417231089
		arg_366_1.duration_ = 9.33

		local var_366_0 = {
			zh = 6.833,
			ja = 9.333
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
				arg_366_0:Play417231090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if arg_366_1.actors_["10111"] == nil then
				local var_369_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10111")

				if not isNil(var_369_0) then
					local var_369_1 = Object.Instantiate(var_369_0, arg_366_1.canvasGo_.transform)

					var_369_1.transform:SetSiblingIndex(1)

					var_369_1.name = "10111"
					var_369_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_366_1.actors_["10111"] = var_369_1

					if arg_366_1.isInRecall_ then
						for iter_369_0, iter_369_1 in ipairs((var_369_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_369_1.color = arg_366_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_369_2 = arg_366_1.actors_["10111"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps10111 == nil then
				arg_366_1.var_.actorSpriteComps10111 = var_369_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_3 = 0.2

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_3 and not isNil(var_369_2) then
				if arg_366_1.var_.actorSpriteComps10111 then
					for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_369_3 then
							if arg_366_1.isInRecall_ then
								iter_369_3.color = Color.New(Mathf.Lerp(iter_369_3.color.r, arg_366_1.hightColor1.r, (arg_366_1.time_ - 0) / var_369_3), Mathf.Lerp(iter_369_3.color.g, arg_366_1.hightColor1.g, (arg_366_1.time_ - 0) / var_369_3), (Mathf.Lerp(iter_369_3.color.b, arg_366_1.hightColor1.b, (arg_366_1.time_ - 0) / var_369_3)))
							else
								local var_369_4 = Mathf.Lerp(iter_369_3.color.r, 1, (arg_366_1.time_ - 0) / var_369_3)

								iter_369_3.color = Color.New(var_369_4, var_369_4, var_369_4)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= 0 + var_369_3 and arg_366_1.time_ < 0 + var_369_3 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps10111 then
				for iter_369_4, iter_369_5 in pairs(arg_366_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_369_5 then
						iter_369_5.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_366_1.var_.actorSpriteComps10111 = nil
			end

			local var_369_5 = arg_366_1.actors_["10111"].transform

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos10111 = var_369_5.localPosition
				var_369_5.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("10111", 3)

				for iter_369_6 = 0, var_369_5.childCount - 1 do
					local var_369_6 = var_369_5:GetChild(iter_369_6)

					if var_369_6.name == "" or not string.find(var_369_6.name, "split") then
						var_369_6.gameObject:SetActive(true)
					else
						var_369_6.gameObject:SetActive(false)
					end
				end
			end

			local var_369_7 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_7 then
				var_369_5.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos10111, Vector3.New(0, -361.1, -274.6), (arg_366_1.time_ - 0) / var_369_7)
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 then
				var_369_5.localPosition = Vector3.New(0, -361.1, -274.6)
			end

			local var_369_8 = 0
			local var_369_9 = 0.775

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_8 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_10 = arg_366_1:GetWordFromCfg(417231089)
				local var_369_11 = arg_366_1:FormatText(var_369_10.content)

				arg_366_1.text_.text = var_369_11

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_13 = 31 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_11) / 31)

				if (31 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_11) / 31)) > 0 and var_369_9 < var_369_13 then
					arg_366_1.talkMaxDuration = var_369_13

					if var_369_13 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_13 + var_369_8
					end
				end

				arg_366_1.text_.text = var_369_11
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231089", "story_v_out_417231.awb") ~= 0 then
					local var_369_14 = manager.audio:GetVoiceLength("story_v_out_417231", "417231089", "story_v_out_417231.awb") / 1000

					if var_369_14 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_14 + var_369_8
					end

					if var_369_10.prefab_name ~= "" and arg_366_1.actors_[var_369_10.prefab_name] ~= nil then
						local var_369_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_10.prefab_name].transform, "story_v_out_417231", "417231089", "story_v_out_417231.awb")

						arg_366_1:RecordAudio("417231089", var_369_15)
						arg_366_1:RecordAudio("417231089", var_369_15)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_417231", "417231089", "story_v_out_417231.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_417231", "417231089", "story_v_out_417231.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_16 = math.max(var_369_9, arg_366_1.talkMaxDuration)

			if var_369_8 <= arg_366_1.time_ and arg_366_1.time_ < var_369_8 + var_369_16 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_8) / var_369_16

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_8 + var_369_16 and arg_366_1.time_ < var_369_8 + var_369_16 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play417231090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 417231090
		arg_370_1.duration_ = 4.67

		local var_370_0 = {
			zh = 3.766,
			ja = 4.666
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
				arg_370_0:Play417231091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1060"]) and arg_370_1.var_.actorSpriteComps1060 == nil then
				arg_370_1.var_.actorSpriteComps1060 = arg_370_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_0 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1060"]) then
				if arg_370_1.var_.actorSpriteComps1060 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_373_1 then
							if arg_370_1.isInRecall_ then
								iter_373_1.color = Color.New(Mathf.Lerp(iter_373_1.color.r, arg_370_1.hightColor1.r, (arg_370_1.time_ - 0) / var_373_0), Mathf.Lerp(iter_373_1.color.g, arg_370_1.hightColor1.g, (arg_370_1.time_ - 0) / var_373_0), (Mathf.Lerp(iter_373_1.color.b, arg_370_1.hightColor1.b, (arg_370_1.time_ - 0) / var_373_0)))
							else
								local var_373_1 = Mathf.Lerp(iter_373_1.color.r, 1, (arg_370_1.time_ - 0) / var_373_0)

								iter_373_1.color = Color.New(var_373_1, var_373_1, var_373_1)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1060"]) and arg_370_1.var_.actorSpriteComps1060 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_373_3 then
						iter_373_3.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_370_1.var_.actorSpriteComps1060 = nil
			end

			local var_373_2 = arg_370_1.actors_["10111"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps10111 == nil then
				arg_370_1.var_.actorSpriteComps10111 = var_373_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_3 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_3 and not isNil(var_373_2) then
				if arg_370_1.var_.actorSpriteComps10111 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_373_5 then
							if arg_370_1.isInRecall_ then
								iter_373_5.color = Color.New(Mathf.Lerp(iter_373_5.color.r, arg_370_1.hightColor2.r, (arg_370_1.time_ - 0) / var_373_3), Mathf.Lerp(iter_373_5.color.g, arg_370_1.hightColor2.g, (arg_370_1.time_ - 0) / var_373_3), (Mathf.Lerp(iter_373_5.color.b, arg_370_1.hightColor2.b, (arg_370_1.time_ - 0) / var_373_3)))
							else
								local var_373_4 = Mathf.Lerp(iter_373_5.color.r, 0.5, (arg_370_1.time_ - 0) / var_373_3)

								iter_373_5.color = Color.New(var_373_4, var_373_4, var_373_4)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= 0 + var_373_3 and arg_370_1.time_ < 0 + var_373_3 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps10111 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_373_7 then
						iter_373_7.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_370_1.var_.actorSpriteComps10111 = nil
			end

			local var_373_5 = arg_370_1.actors_["1060"].transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos1060 = var_373_5.localPosition
				var_373_5.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("1060", 4)

				for iter_373_8 = 0, var_373_5.childCount - 1 do
					local var_373_6 = var_373_5:GetChild(iter_373_8)

					if var_373_6.name == "" or not string.find(var_373_6.name, "split") then
						var_373_6.gameObject:SetActive(true)
					else
						var_373_6.gameObject:SetActive(false)
					end
				end
			end

			local var_373_7 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_7 then
				var_373_5.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1060, Vector3.New(420.9, -430.8, 6.9), (arg_370_1.time_ - 0) / var_373_7)
			end

			if arg_370_1.time_ >= 0 + var_373_7 and arg_370_1.time_ < 0 + var_373_7 + arg_373_0 then
				var_373_5.localPosition = Vector3.New(420.9, -430.8, 6.9)
			end

			local var_373_8 = arg_370_1.actors_["10111"].transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos10111 = var_373_8.localPosition
				var_373_8.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("10111", 2)

				for iter_373_9 = 0, var_373_8.childCount - 1 do
					local var_373_9 = var_373_8:GetChild(iter_373_9)

					if var_373_9.name == "" or not string.find(var_373_9.name, "split") then
						var_373_9.gameObject:SetActive(true)
					else
						var_373_9.gameObject:SetActive(false)
					end
				end
			end

			local var_373_10 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_10 then
				var_373_8.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos10111, Vector3.New(-390, -361.1, -274.6), (arg_370_1.time_ - 0) / var_373_10)
			end

			if arg_370_1.time_ >= 0 + var_373_10 and arg_370_1.time_ < 0 + var_373_10 + arg_373_0 then
				var_373_8.localPosition = Vector3.New(-390, -361.1, -274.6)
			end

			local var_373_11 = 0
			local var_373_12 = 0.275

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_11 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_13 = arg_370_1:GetWordFromCfg(417231090)
				local var_373_14 = arg_370_1:FormatText(var_373_13.content)

				arg_370_1.text_.text = var_373_14

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_16 = 11 <= 0 and var_373_12 or var_373_12 * (utf8.len(var_373_14) / 11)

				if (11 <= 0 and var_373_12 or var_373_12 * (utf8.len(var_373_14) / 11)) > 0 and var_373_12 < var_373_16 then
					arg_370_1.talkMaxDuration = var_373_16

					if var_373_16 + var_373_11 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_16 + var_373_11
					end
				end

				arg_370_1.text_.text = var_373_14
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231090", "story_v_out_417231.awb") ~= 0 then
					local var_373_17 = manager.audio:GetVoiceLength("story_v_out_417231", "417231090", "story_v_out_417231.awb") / 1000

					if var_373_17 + var_373_11 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_17 + var_373_11
					end

					if var_373_13.prefab_name ~= "" and arg_370_1.actors_[var_373_13.prefab_name] ~= nil then
						local var_373_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_13.prefab_name].transform, "story_v_out_417231", "417231090", "story_v_out_417231.awb")

						arg_370_1:RecordAudio("417231090", var_373_18)
						arg_370_1:RecordAudio("417231090", var_373_18)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_417231", "417231090", "story_v_out_417231.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_417231", "417231090", "story_v_out_417231.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_19 = math.max(var_373_12, arg_370_1.talkMaxDuration)

			if var_373_11 <= arg_370_1.time_ and arg_370_1.time_ < var_373_11 + var_373_19 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_11) / var_373_19

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_11 + var_373_19 and arg_370_1.time_ < var_373_11 + var_373_19 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
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
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play417231091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 417231091
		arg_374_1.duration_ = 8.17

		local var_374_0 = {
			zh = 5.733,
			ja = 8.166
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
				arg_374_0:Play417231092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["10111"]) and arg_374_1.var_.actorSpriteComps10111 == nil then
				arg_374_1.var_.actorSpriteComps10111 = arg_374_1.actors_["10111"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_0 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["10111"]) then
				if arg_374_1.var_.actorSpriteComps10111 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps10111:ToTable()) do
						if iter_377_1 then
							if arg_374_1.isInRecall_ then
								iter_377_1.color = Color.New(Mathf.Lerp(iter_377_1.color.r, arg_374_1.hightColor1.r, (arg_374_1.time_ - 0) / var_377_0), Mathf.Lerp(iter_377_1.color.g, arg_374_1.hightColor1.g, (arg_374_1.time_ - 0) / var_377_0), (Mathf.Lerp(iter_377_1.color.b, arg_374_1.hightColor1.b, (arg_374_1.time_ - 0) / var_377_0)))
							else
								local var_377_1 = Mathf.Lerp(iter_377_1.color.r, 1, (arg_374_1.time_ - 0) / var_377_0)

								iter_377_1.color = Color.New(var_377_1, var_377_1, var_377_1)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["10111"]) and arg_374_1.var_.actorSpriteComps10111 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps10111:ToTable()) do
					if iter_377_3 then
						iter_377_3.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_374_1.var_.actorSpriteComps10111 = nil
			end

			local var_377_2 = arg_374_1.actors_["1060"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.actorSpriteComps1060 == nil then
				arg_374_1.var_.actorSpriteComps1060 = var_377_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_3 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_3 and not isNil(var_377_2) then
				if arg_374_1.var_.actorSpriteComps1060 then
					for iter_377_4, iter_377_5 in pairs(arg_374_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_377_5 then
							if arg_374_1.isInRecall_ then
								iter_377_5.color = Color.New(Mathf.Lerp(iter_377_5.color.r, arg_374_1.hightColor2.r, (arg_374_1.time_ - 0) / var_377_3), Mathf.Lerp(iter_377_5.color.g, arg_374_1.hightColor2.g, (arg_374_1.time_ - 0) / var_377_3), (Mathf.Lerp(iter_377_5.color.b, arg_374_1.hightColor2.b, (arg_374_1.time_ - 0) / var_377_3)))
							else
								local var_377_4 = Mathf.Lerp(iter_377_5.color.r, 0.5, (arg_374_1.time_ - 0) / var_377_3)

								iter_377_5.color = Color.New(var_377_4, var_377_4, var_377_4)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= 0 + var_377_3 and arg_374_1.time_ < 0 + var_377_3 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.actorSpriteComps1060 then
				for iter_377_6, iter_377_7 in pairs(arg_374_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_377_7 then
						iter_377_7.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_374_1.var_.actorSpriteComps1060 = nil
			end

			local var_377_5 = 0
			local var_377_6 = 0.525

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_5 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_7 = arg_374_1:GetWordFromCfg(417231091)
				local var_377_8 = arg_374_1:FormatText(var_377_7.content)

				arg_374_1.text_.text = var_377_8

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_10 = 21 <= 0 and var_377_6 or var_377_6 * (utf8.len(var_377_8) / 21)

				if (21 <= 0 and var_377_6 or var_377_6 * (utf8.len(var_377_8) / 21)) > 0 and var_377_6 < var_377_10 then
					arg_374_1.talkMaxDuration = var_377_10

					if var_377_10 + var_377_5 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_10 + var_377_5
					end
				end

				arg_374_1.text_.text = var_377_8
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231091", "story_v_out_417231.awb") ~= 0 then
					local var_377_11 = manager.audio:GetVoiceLength("story_v_out_417231", "417231091", "story_v_out_417231.awb") / 1000

					if var_377_11 + var_377_5 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_11 + var_377_5
					end

					if var_377_7.prefab_name ~= "" and arg_374_1.actors_[var_377_7.prefab_name] ~= nil then
						local var_377_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_7.prefab_name].transform, "story_v_out_417231", "417231091", "story_v_out_417231.awb")

						arg_374_1:RecordAudio("417231091", var_377_12)
						arg_374_1:RecordAudio("417231091", var_377_12)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_417231", "417231091", "story_v_out_417231.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_417231", "417231091", "story_v_out_417231.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_13 = math.max(var_377_6, arg_374_1.talkMaxDuration)

			if var_377_5 <= arg_374_1.time_ and arg_374_1.time_ < var_377_5 + var_377_13 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_5) / var_377_13

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_5 + var_377_13 and arg_374_1.time_ < var_377_5 + var_377_13 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play417231092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 417231092
		arg_378_1.duration_ = 4.4

		local var_378_0 = {
			zh = 4.4,
			ja = 3.533
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
				arg_378_0:Play417231093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0.425

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_1 = arg_378_1:GetWordFromCfg(417231092)
				local var_381_2 = arg_378_1:FormatText(var_381_1.content)

				arg_378_1.text_.text = var_381_2

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 17 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 17)

				if (17 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 17)) > 0 and var_381_0 < var_381_4 then
					arg_378_1.talkMaxDuration = var_381_4

					if var_381_4 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_4 + 0
					end
				end

				arg_378_1.text_.text = var_381_2
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231092", "story_v_out_417231.awb") ~= 0 then
					local var_381_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231092", "story_v_out_417231.awb") / 1000

					if var_381_5 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + 0
					end

					if var_381_1.prefab_name ~= "" and arg_378_1.actors_[var_381_1.prefab_name] ~= nil then
						local var_381_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_1.prefab_name].transform, "story_v_out_417231", "417231092", "story_v_out_417231.awb")

						arg_378_1:RecordAudio("417231092", var_381_6)
						arg_378_1:RecordAudio("417231092", var_381_6)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_417231", "417231092", "story_v_out_417231.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_417231", "417231092", "story_v_out_417231.awb")
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
	Play417231093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 417231093
		arg_382_1.duration_ = 5.83

		local var_382_0 = {
			zh = 5.066,
			ja = 5.833
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
				arg_382_0:Play417231094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if arg_382_1.bgs_.ST2102 == nil then
				local var_385_0 = Object.Instantiate(arg_382_1.paintGo_)

				var_385_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2102")
				var_385_0.name = "ST2102"
				var_385_0.transform.parent = arg_382_1.stage_.transform
				var_385_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_382_1.bgs_.ST2102 = var_385_0
			end

			if 2 < arg_382_1.time_ and arg_382_1.time_ <= 2 + arg_385_0 then
				local var_385_1 = arg_382_1.bgs_.ST2102

				arg_382_1.bgs_.ST2102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_385_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_385_2 = var_385_1:GetComponent("SpriteRenderer")

				if var_385_2 and var_385_2.sprite then
					local var_385_3 = 2 * (var_385_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_385_1.transform.localScale = Vector3.New(var_385_3 / var_385_2.sprite.bounds.size.y < var_385_3 * manager.ui.mainCameraCom_.aspect / var_385_2.sprite.bounds.size.x and var_385_3 * manager.ui.mainCameraCom_.aspect / var_385_2.sprite.bounds.size.x or var_385_3 / var_385_2.sprite.bounds.size.y, var_385_3 / var_385_2.sprite.bounds.size.y < var_385_3 * manager.ui.mainCameraCom_.aspect / var_385_2.sprite.bounds.size.x and var_385_3 * manager.ui.mainCameraCom_.aspect / var_385_2.sprite.bounds.size.x or var_385_3 / var_385_2.sprite.bounds.size.y, 0)
				end

				for iter_385_0, iter_385_1 in pairs(arg_382_1.bgs_) do
					if iter_385_0 ~= "ST2102" then
						iter_385_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_385_4 = 0

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_4 + arg_385_0 then
				arg_382_1.mask_.enabled = true
				arg_382_1.mask_.raycastTarget = true

				arg_382_1:SetGaussion(false)
			end

			local var_385_5 = 2

			if var_385_4 <= arg_382_1.time_ and arg_382_1.time_ < var_385_4 + var_385_5 then
				local var_385_6 = Color.New(0, 0, 0)

				var_385_6.a = Mathf.Lerp(0, 1, (arg_382_1.time_ - var_385_4) / var_385_5)
				arg_382_1.mask_.color = var_385_6
			end

			if arg_382_1.time_ >= var_385_4 + var_385_5 and arg_382_1.time_ < var_385_4 + var_385_5 + arg_385_0 then
				local var_385_7 = Color.New(0, 0, 0)

				var_385_7.a = 1
				arg_382_1.mask_.color = var_385_7
			end

			local var_385_8 = 2

			if 2 < arg_382_1.time_ and arg_382_1.time_ <= var_385_8 + arg_385_0 then
				arg_382_1.mask_.enabled = true
				arg_382_1.mask_.raycastTarget = true

				arg_382_1:SetGaussion(false)
			end

			local var_385_9 = 2

			if var_385_8 <= arg_382_1.time_ and arg_382_1.time_ < var_385_8 + var_385_9 then
				local var_385_10 = Color.New(0, 0, 0)

				var_385_10.a = Mathf.Lerp(1, 0, (arg_382_1.time_ - var_385_8) / var_385_9)
				arg_382_1.mask_.color = var_385_10
			end

			if arg_382_1.time_ >= var_385_8 + var_385_9 and arg_382_1.time_ < var_385_8 + var_385_9 + arg_385_0 then
				local var_385_11 = Color.New(0, 0, 0)

				arg_382_1.mask_.enabled = false
				var_385_11.a = 0
				arg_382_1.mask_.color = var_385_11
			end

			local var_385_12 = arg_382_1.actors_["10111"].transform

			if 2 < arg_382_1.time_ and arg_382_1.time_ <= 2 + arg_385_0 then
				arg_382_1.var_.moveOldPos10111 = var_385_12.localPosition
				var_385_12.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("10111", 7)

				for iter_385_2 = 0, var_385_12.childCount - 1 do
					local var_385_13 = var_385_12:GetChild(iter_385_2)

					if var_385_13.name == "" or not string.find(var_385_13.name, "split") then
						var_385_13.gameObject:SetActive(true)
					else
						var_385_13.gameObject:SetActive(false)
					end
				end
			end

			local var_385_14 = 0.001

			if 2 <= arg_382_1.time_ and arg_382_1.time_ < 2 + var_385_14 then
				var_385_12.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos10111, Vector3.New(0, -2000, 0), (arg_382_1.time_ - 2) / var_385_14)
			end

			if arg_382_1.time_ >= 2 + var_385_14 and arg_382_1.time_ < 2 + var_385_14 + arg_385_0 then
				var_385_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_385_15 = arg_382_1.actors_["1060"].transform

			if 2 < arg_382_1.time_ and arg_382_1.time_ <= 2 + arg_385_0 then
				arg_382_1.var_.moveOldPos1060 = var_385_15.localPosition
				var_385_15.localScale = Vector3.New(1, 1, 1)

				arg_382_1:CheckSpriteTmpPos("1060", 7)

				for iter_385_3 = 0, var_385_15.childCount - 1 do
					local var_385_16 = var_385_15:GetChild(iter_385_3)

					if var_385_16.name == "" or not string.find(var_385_16.name, "split") then
						var_385_16.gameObject:SetActive(true)
					else
						var_385_16.gameObject:SetActive(false)
					end
				end
			end

			local var_385_17 = 0.001

			if 2 <= arg_382_1.time_ and arg_382_1.time_ < 2 + var_385_17 then
				var_385_15.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_382_1.time_ - 2) / var_385_17)
			end

			if arg_382_1.time_ >= 2 + var_385_17 and arg_382_1.time_ < 2 + var_385_17 + arg_385_0 then
				var_385_15.localPosition = Vector3.New(0, -2000, -40)
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_385_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_382_1.bgmTxt_.text ~= var_385_20 and arg_382_1.bgmTxt_.text ~= "" then
						if arg_382_1.bgmTxt2_.text ~= "" then
							arg_382_1.bgmTxt_.text = arg_382_1.bgmTxt2_.text
						end

						arg_382_1.bgmTxt2_.text = var_385_20

						arg_382_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_382_1.bgmTxt_.text = var_385_20
						arg_382_1.bgmTxt2_.text = var_385_20
					end

					if arg_382_1.bgmTimer then
						arg_382_1.bgmTimer:Stop()

						arg_382_1.bgmTimer = nil
					end

					if arg_382_1.settingData.show_music_name == 1 then
						arg_382_1.musicController:SetSelectedState("show")
						arg_382_1.musicAnimator_:Play("open", 0, 0)

						if arg_382_1.settingData.music_time ~= 0 then
							arg_382_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_382_1.settingData.music_time), function()
								if arg_382_1 == nil or isNil(arg_382_1.bgmTxt_) then
									return
								end

								arg_382_1.musicController:SetSelectedState("hide")
								arg_382_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.53333333333333 < arg_382_1.time_ and arg_382_1.time_ <= 1.53333333333333 + arg_385_0 then
				arg_382_1:AudioAction("play", "music", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard.awb")

				local var_385_23 = manager.audio:GetAudioName("bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard")

				if "" ~= "" then
					if arg_382_1.bgmTxt_.text ~= var_385_23 and arg_382_1.bgmTxt_.text ~= "" then
						if arg_382_1.bgmTxt2_.text ~= "" then
							arg_382_1.bgmTxt_.text = arg_382_1.bgmTxt2_.text
						end

						arg_382_1.bgmTxt2_.text = var_385_23

						arg_382_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_382_1.bgmTxt_.text = var_385_23
						arg_382_1.bgmTxt2_.text = var_385_23
					end

					if arg_382_1.bgmTimer then
						arg_382_1.bgmTimer:Stop()

						arg_382_1.bgmTimer = nil
					end

					if arg_382_1.settingData.show_music_name == 1 then
						arg_382_1.musicController:SetSelectedState("show")
						arg_382_1.musicAnimator_:Play("open", 0, 0)

						if arg_382_1.settingData.music_time ~= 0 then
							arg_382_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_382_1.settingData.music_time), function()
								if arg_382_1 == nil or isNil(arg_382_1.bgmTxt_) then
									return
								end

								arg_382_1.musicController:SetSelectedState("hide")
								arg_382_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.53333333333333 < arg_382_1.time_ and arg_382_1.time_ <= 1.53333333333333 + arg_385_0 then
				arg_382_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind", "")
			end

			if arg_382_1.frameCnt_ <= 1 then
				arg_382_1.dialog_:SetActive(false)
			end

			local var_385_25 = 4
			local var_385_26 = 0.05

			if 4 < arg_382_1.time_ and arg_382_1.time_ <= var_385_25 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0

				arg_382_1.dialog_:SetActive(true)

				arg_382_1.dialogCg_.alpha = 0

				local var_385_27 = LeanTween.value(arg_382_1.dialog_, 0, 1, 0.3)

				var_385_27:setOnUpdate(LuaHelper.FloatAction(function(arg_388_0)
					arg_382_1.dialogCg_.alpha = arg_388_0
				end))
				var_385_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_382_1.dialog_)
					var_385_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_382_1.duration_ = arg_382_1.duration_ + 0.3

				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_28 = arg_382_1:GetWordFromCfg(417231093)
				local var_385_29 = arg_382_1:FormatText(var_385_28.content)

				arg_382_1.text_.text = var_385_29

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_31 = 2 <= 0 and var_385_26 or var_385_26 * (utf8.len(var_385_29) / 2)

				if (2 <= 0 and var_385_26 or var_385_26 * (utf8.len(var_385_29) / 2)) > 0 and var_385_26 < var_385_31 then
					arg_382_1.talkMaxDuration = var_385_31
					var_385_25 = var_385_25 + 0.3

					if var_385_31 + var_385_25 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_31 + var_385_25
					end
				end

				arg_382_1.text_.text = var_385_29
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231093", "story_v_out_417231.awb") ~= 0 then
					local var_385_32 = manager.audio:GetVoiceLength("story_v_out_417231", "417231093", "story_v_out_417231.awb") / 1000

					if var_385_32 + var_385_25 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_32 + var_385_25
					end

					if var_385_28.prefab_name ~= "" and arg_382_1.actors_[var_385_28.prefab_name] ~= nil then
						local var_385_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_28.prefab_name].transform, "story_v_out_417231", "417231093", "story_v_out_417231.awb")

						arg_382_1:RecordAudio("417231093", var_385_33)
						arg_382_1:RecordAudio("417231093", var_385_33)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_417231", "417231093", "story_v_out_417231.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_417231", "417231093", "story_v_out_417231.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_34 = var_385_25 + 0.3
			local var_385_35 = math.max(var_385_26, arg_382_1.talkMaxDuration)

			if var_385_25 + 0.3 <= arg_382_1.time_ and arg_382_1.time_ < var_385_34 + var_385_35 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_34) / var_385_35

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_34 + var_385_35 and arg_382_1.time_ < var_385_34 + var_385_35 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10111",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play417231094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 417231094
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play417231095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0.266666666666667 < arg_390_1.time_ and arg_390_1.time_ <= 0.266666666666667 + arg_393_0 then
				arg_390_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_thunder01", "")
			end

			local var_393_1 = 0
			local var_393_2 = 0.9

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

				local var_393_3 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(417231094).content)

				arg_390_1.text_.text = var_393_3

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 36 <= 0 and var_393_2 or var_393_2 * (utf8.len(var_393_3) / 36)

				if (36 <= 0 and var_393_2 or var_393_2 * (utf8.len(var_393_3) / 36)) > 0 and var_393_2 < var_393_5 then
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
	Play417231095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 417231095
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play417231096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 1.275

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_1 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(417231095).content)

				arg_394_1.text_.text = var_397_1

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_3 = 51 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 51)

				if (51 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 51)) > 0 and var_397_0 < var_397_3 then
					arg_394_1.talkMaxDuration = var_397_3

					if var_397_3 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_3 + 0
					end
				end

				arg_394_1.text_.text = var_397_1
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_4 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_4 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_4

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_4 and arg_394_1.time_ < 0 + var_397_4 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play417231096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 417231096
		arg_398_1.duration_ = 9.3

		local var_398_0 = {
			zh = 9.3,
			ja = 8.2
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play417231097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if arg_398_1.actors_["10113"] == nil then
				local var_401_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_401_0) then
					local var_401_1 = Object.Instantiate(var_401_0, arg_398_1.canvasGo_.transform)

					var_401_1.transform:SetSiblingIndex(1)

					var_401_1.name = "10113"
					var_401_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_398_1.actors_["10113"] = var_401_1

					if arg_398_1.isInRecall_ then
						for iter_401_0, iter_401_1 in ipairs((var_401_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_401_1.color = arg_398_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_401_2 = arg_398_1.actors_["10113"]

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(var_401_2) and arg_398_1.var_.actorSpriteComps10113 == nil then
				arg_398_1.var_.actorSpriteComps10113 = var_401_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_401_3 = 0.2

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_3 and not isNil(var_401_2) then
				if arg_398_1.var_.actorSpriteComps10113 then
					for iter_401_2, iter_401_3 in pairs(arg_398_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_401_3 then
							if arg_398_1.isInRecall_ then
								iter_401_3.color = Color.New(Mathf.Lerp(iter_401_3.color.r, arg_398_1.hightColor1.r, (arg_398_1.time_ - 0) / var_401_3), Mathf.Lerp(iter_401_3.color.g, arg_398_1.hightColor1.g, (arg_398_1.time_ - 0) / var_401_3), (Mathf.Lerp(iter_401_3.color.b, arg_398_1.hightColor1.b, (arg_398_1.time_ - 0) / var_401_3)))
							else
								local var_401_4 = Mathf.Lerp(iter_401_3.color.r, 1, (arg_398_1.time_ - 0) / var_401_3)

								iter_401_3.color = Color.New(var_401_4, var_401_4, var_401_4)
							end
						end
					end
				end
			end

			if arg_398_1.time_ >= 0 + var_401_3 and arg_398_1.time_ < 0 + var_401_3 + arg_401_0 and not isNil(var_401_2) and arg_398_1.var_.actorSpriteComps10113 then
				for iter_401_4, iter_401_5 in pairs(arg_398_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_401_5 then
						iter_401_5.color = arg_398_1.isInRecall_ and (arg_398_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_398_1.var_.actorSpriteComps10113 = nil
			end

			local var_401_5 = arg_398_1.actors_["10113"].transform

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos10113 = var_401_5.localPosition
				var_401_5.localScale = Vector3.New(1, 1, 1)

				arg_398_1:CheckSpriteTmpPos("10113", 3)

				for iter_401_6 = 0, var_401_5.childCount - 1 do
					local var_401_6 = var_401_5:GetChild(iter_401_6)

					if var_401_6.name == "" or not string.find(var_401_6.name, "split") then
						var_401_6.gameObject:SetActive(true)
					else
						var_401_6.gameObject:SetActive(false)
					end
				end
			end

			local var_401_7 = 0.001

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_7 then
				var_401_5.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_398_1.time_ - 0) / var_401_7)
			end

			if arg_398_1.time_ >= 0 + var_401_7 and arg_398_1.time_ < 0 + var_401_7 + arg_401_0 then
				var_401_5.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_401_8 = 0
			local var_401_9 = 1.025

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_8 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_10 = arg_398_1:GetWordFromCfg(417231096)
				local var_401_11 = arg_398_1:FormatText(var_401_10.content)

				arg_398_1.text_.text = var_401_11

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_13 = 41 <= 0 and var_401_9 or var_401_9 * (utf8.len(var_401_11) / 41)

				if (41 <= 0 and var_401_9 or var_401_9 * (utf8.len(var_401_11) / 41)) > 0 and var_401_9 < var_401_13 then
					arg_398_1.talkMaxDuration = var_401_13

					if var_401_13 + var_401_8 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_13 + var_401_8
					end
				end

				arg_398_1.text_.text = var_401_11
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231096", "story_v_out_417231.awb") ~= 0 then
					local var_401_14 = manager.audio:GetVoiceLength("story_v_out_417231", "417231096", "story_v_out_417231.awb") / 1000

					if var_401_14 + var_401_8 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_14 + var_401_8
					end

					if var_401_10.prefab_name ~= "" and arg_398_1.actors_[var_401_10.prefab_name] ~= nil then
						local var_401_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_10.prefab_name].transform, "story_v_out_417231", "417231096", "story_v_out_417231.awb")

						arg_398_1:RecordAudio("417231096", var_401_15)
						arg_398_1:RecordAudio("417231096", var_401_15)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_417231", "417231096", "story_v_out_417231.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_417231", "417231096", "story_v_out_417231.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_16 = math.max(var_401_9, arg_398_1.talkMaxDuration)

			if var_401_8 <= arg_398_1.time_ and arg_398_1.time_ < var_401_8 + var_401_16 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_8) / var_401_16

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_8 + var_401_16 and arg_398_1.time_ < var_401_8 + var_401_16 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
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

		arg_398_1:InitPlayNodeList()
	end,
	Play417231097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 417231097
		arg_402_1.duration_ = 6.23

		local var_402_0 = {
			zh = 6.233,
			ja = 5.233
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play417231098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(arg_402_1.actors_["10113"]) and arg_402_1.var_.actorSpriteComps10113 == nil then
				arg_402_1.var_.actorSpriteComps10113 = arg_402_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_405_0 = 0.2

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_0 and not isNil(arg_402_1.actors_["10113"]) then
				if arg_402_1.var_.actorSpriteComps10113 then
					for iter_405_0, iter_405_1 in pairs(arg_402_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_405_1 then
							if arg_402_1.isInRecall_ then
								iter_405_1.color = Color.New(Mathf.Lerp(iter_405_1.color.r, arg_402_1.hightColor2.r, (arg_402_1.time_ - 0) / var_405_0), Mathf.Lerp(iter_405_1.color.g, arg_402_1.hightColor2.g, (arg_402_1.time_ - 0) / var_405_0), (Mathf.Lerp(iter_405_1.color.b, arg_402_1.hightColor2.b, (arg_402_1.time_ - 0) / var_405_0)))
							else
								local var_405_1 = Mathf.Lerp(iter_405_1.color.r, 0.5, (arg_402_1.time_ - 0) / var_405_0)

								iter_405_1.color = Color.New(var_405_1, var_405_1, var_405_1)
							end
						end
					end
				end
			end

			if arg_402_1.time_ >= 0 + var_405_0 and arg_402_1.time_ < 0 + var_405_0 + arg_405_0 and not isNil(arg_402_1.actors_["10113"]) and arg_402_1.var_.actorSpriteComps10113 then
				for iter_405_2, iter_405_3 in pairs(arg_402_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_405_3 then
						iter_405_3.color = arg_402_1.isInRecall_ and (arg_402_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_402_1.var_.actorSpriteComps10113 = nil
			end

			local var_405_2 = 0
			local var_405_3 = 0.45

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_2 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_4 = arg_402_1:GetWordFromCfg(417231097)
				local var_405_5 = arg_402_1:FormatText(var_405_4.content)

				arg_402_1.text_.text = var_405_5

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_7 = 18 <= 0 and var_405_3 or var_405_3 * (utf8.len(var_405_5) / 18)

				if (18 <= 0 and var_405_3 or var_405_3 * (utf8.len(var_405_5) / 18)) > 0 and var_405_3 < var_405_7 then
					arg_402_1.talkMaxDuration = var_405_7

					if var_405_7 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_2
					end
				end

				arg_402_1.text_.text = var_405_5
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231097", "story_v_out_417231.awb") ~= 0 then
					local var_405_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231097", "story_v_out_417231.awb") / 1000

					if var_405_8 + var_405_2 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_2
					end

					if var_405_4.prefab_name ~= "" and arg_402_1.actors_[var_405_4.prefab_name] ~= nil then
						local var_405_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_4.prefab_name].transform, "story_v_out_417231", "417231097", "story_v_out_417231.awb")

						arg_402_1:RecordAudio("417231097", var_405_9)
						arg_402_1:RecordAudio("417231097", var_405_9)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_417231", "417231097", "story_v_out_417231.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_417231", "417231097", "story_v_out_417231.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_10 = math.max(var_405_3, arg_402_1.talkMaxDuration)

			if var_405_2 <= arg_402_1.time_ and arg_402_1.time_ < var_405_2 + var_405_10 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_2) / var_405_10

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_2 + var_405_10 and arg_402_1.time_ < var_405_2 + var_405_10 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play417231098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 417231098
		arg_406_1.duration_ = 7.03

		local var_406_0 = {
			zh = 4.4,
			ja = 7.033
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play417231099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.45

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_1 = arg_406_1:GetWordFromCfg(417231098)
				local var_409_2 = arg_406_1:FormatText(var_409_1.content)

				arg_406_1.text_.text = var_409_2

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 18 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 18)

				if (18 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 18)) > 0 and var_409_0 < var_409_4 then
					arg_406_1.talkMaxDuration = var_409_4

					if var_409_4 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_4 + 0
					end
				end

				arg_406_1.text_.text = var_409_2
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231098", "story_v_out_417231.awb") ~= 0 then
					local var_409_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231098", "story_v_out_417231.awb") / 1000

					if var_409_5 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + 0
					end

					if var_409_1.prefab_name ~= "" and arg_406_1.actors_[var_409_1.prefab_name] ~= nil then
						local var_409_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_1.prefab_name].transform, "story_v_out_417231", "417231098", "story_v_out_417231.awb")

						arg_406_1:RecordAudio("417231098", var_409_6)
						arg_406_1:RecordAudio("417231098", var_409_6)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_417231", "417231098", "story_v_out_417231.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_417231", "417231098", "story_v_out_417231.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_7 = math.max(var_409_0, arg_406_1.talkMaxDuration)

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_7 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - 0) / var_409_7

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= 0 + var_409_7 and arg_406_1.time_ < 0 + var_409_7 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play417231099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 417231099
		arg_410_1.duration_ = 10.97

		local var_410_0 = {
			zh = 6.5,
			ja = 10.966
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play417231100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["10113"]) and arg_410_1.var_.actorSpriteComps10113 == nil then
				arg_410_1.var_.actorSpriteComps10113 = arg_410_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_413_0 = 0.2

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["10113"]) then
				if arg_410_1.var_.actorSpriteComps10113 then
					for iter_413_0, iter_413_1 in pairs(arg_410_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_413_1 then
							if arg_410_1.isInRecall_ then
								iter_413_1.color = Color.New(Mathf.Lerp(iter_413_1.color.r, arg_410_1.hightColor1.r, (arg_410_1.time_ - 0) / var_413_0), Mathf.Lerp(iter_413_1.color.g, arg_410_1.hightColor1.g, (arg_410_1.time_ - 0) / var_413_0), (Mathf.Lerp(iter_413_1.color.b, arg_410_1.hightColor1.b, (arg_410_1.time_ - 0) / var_413_0)))
							else
								local var_413_1 = Mathf.Lerp(iter_413_1.color.r, 1, (arg_410_1.time_ - 0) / var_413_0)

								iter_413_1.color = Color.New(var_413_1, var_413_1, var_413_1)
							end
						end
					end
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["10113"]) and arg_410_1.var_.actorSpriteComps10113 then
				for iter_413_2, iter_413_3 in pairs(arg_410_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_413_3 then
						iter_413_3.color = arg_410_1.isInRecall_ and (arg_410_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_410_1.var_.actorSpriteComps10113 = nil
			end

			local var_413_2 = 0
			local var_413_3 = 0.75

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_2 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_4 = arg_410_1:GetWordFromCfg(417231099)
				local var_413_5 = arg_410_1:FormatText(var_413_4.content)

				arg_410_1.text_.text = var_413_5

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_7 = 30 <= 0 and var_413_3 or var_413_3 * (utf8.len(var_413_5) / 30)

				if (30 <= 0 and var_413_3 or var_413_3 * (utf8.len(var_413_5) / 30)) > 0 and var_413_3 < var_413_7 then
					arg_410_1.talkMaxDuration = var_413_7

					if var_413_7 + var_413_2 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_7 + var_413_2
					end
				end

				arg_410_1.text_.text = var_413_5
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231099", "story_v_out_417231.awb") ~= 0 then
					local var_413_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231099", "story_v_out_417231.awb") / 1000

					if var_413_8 + var_413_2 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_8 + var_413_2
					end

					if var_413_4.prefab_name ~= "" and arg_410_1.actors_[var_413_4.prefab_name] ~= nil then
						local var_413_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_4.prefab_name].transform, "story_v_out_417231", "417231099", "story_v_out_417231.awb")

						arg_410_1:RecordAudio("417231099", var_413_9)
						arg_410_1:RecordAudio("417231099", var_413_9)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_417231", "417231099", "story_v_out_417231.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_417231", "417231099", "story_v_out_417231.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_10 = math.max(var_413_3, arg_410_1.talkMaxDuration)

			if var_413_2 <= arg_410_1.time_ and arg_410_1.time_ < var_413_2 + var_413_10 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_2) / var_413_10

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_2 + var_413_10 and arg_410_1.time_ < var_413_2 + var_413_10 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play417231100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 417231100
		arg_414_1.duration_ = 5.23

		local var_414_0 = {
			zh = 3.9,
			ja = 5.233
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play417231101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.425

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_1 = arg_414_1:GetWordFromCfg(417231100)
				local var_417_2 = arg_414_1:FormatText(var_417_1.content)

				arg_414_1.text_.text = var_417_2

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_4 = 17 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 17)

				if (17 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 17)) > 0 and var_417_0 < var_417_4 then
					arg_414_1.talkMaxDuration = var_417_4

					if var_417_4 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_4 + 0
					end
				end

				arg_414_1.text_.text = var_417_2
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231100", "story_v_out_417231.awb") ~= 0 then
					local var_417_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231100", "story_v_out_417231.awb") / 1000

					if var_417_5 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_5 + 0
					end

					if var_417_1.prefab_name ~= "" and arg_414_1.actors_[var_417_1.prefab_name] ~= nil then
						local var_417_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_1.prefab_name].transform, "story_v_out_417231", "417231100", "story_v_out_417231.awb")

						arg_414_1:RecordAudio("417231100", var_417_6)
						arg_414_1:RecordAudio("417231100", var_417_6)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_417231", "417231100", "story_v_out_417231.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_417231", "417231100", "story_v_out_417231.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_7 and arg_414_1.time_ < 0 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play417231101 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 417231101
		arg_418_1.duration_ = 2.73

		local var_418_0 = {
			zh = 2.1,
			ja = 2.733
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play417231102(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["10113"]) and arg_418_1.var_.actorSpriteComps10113 == nil then
				arg_418_1.var_.actorSpriteComps10113 = arg_418_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_421_0 = 0.2

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["10113"]) then
				if arg_418_1.var_.actorSpriteComps10113 then
					for iter_421_0, iter_421_1 in pairs(arg_418_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_421_1 then
							if arg_418_1.isInRecall_ then
								iter_421_1.color = Color.New(Mathf.Lerp(iter_421_1.color.r, arg_418_1.hightColor2.r, (arg_418_1.time_ - 0) / var_421_0), Mathf.Lerp(iter_421_1.color.g, arg_418_1.hightColor2.g, (arg_418_1.time_ - 0) / var_421_0), (Mathf.Lerp(iter_421_1.color.b, arg_418_1.hightColor2.b, (arg_418_1.time_ - 0) / var_421_0)))
							else
								local var_421_1 = Mathf.Lerp(iter_421_1.color.r, 0.5, (arg_418_1.time_ - 0) / var_421_0)

								iter_421_1.color = Color.New(var_421_1, var_421_1, var_421_1)
							end
						end
					end
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["10113"]) and arg_418_1.var_.actorSpriteComps10113 then
				for iter_421_2, iter_421_3 in pairs(arg_418_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_421_3 then
						iter_421_3.color = arg_418_1.isInRecall_ and (arg_418_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_418_1.var_.actorSpriteComps10113 = nil
			end

			local var_421_2 = 0
			local var_421_3 = 0.125

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_2 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_4 = arg_418_1:GetWordFromCfg(417231101)
				local var_421_5 = arg_418_1:FormatText(var_421_4.content)

				arg_418_1.text_.text = var_421_5

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_7 = 5 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 5)

				if (5 <= 0 and var_421_3 or var_421_3 * (utf8.len(var_421_5) / 5)) > 0 and var_421_3 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_2
					end
				end

				arg_418_1.text_.text = var_421_5
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231101", "story_v_out_417231.awb") ~= 0 then
					local var_421_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231101", "story_v_out_417231.awb") / 1000

					if var_421_8 + var_421_2 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_8 + var_421_2
					end

					if var_421_4.prefab_name ~= "" and arg_418_1.actors_[var_421_4.prefab_name] ~= nil then
						local var_421_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_4.prefab_name].transform, "story_v_out_417231", "417231101", "story_v_out_417231.awb")

						arg_418_1:RecordAudio("417231101", var_421_9)
						arg_418_1:RecordAudio("417231101", var_421_9)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_417231", "417231101", "story_v_out_417231.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_417231", "417231101", "story_v_out_417231.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_10 = math.max(var_421_3, arg_418_1.talkMaxDuration)

			if var_421_2 <= arg_418_1.time_ and arg_418_1.time_ < var_421_2 + var_421_10 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_2) / var_421_10

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_2 + var_421_10 and arg_418_1.time_ < var_421_2 + var_421_10 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play417231102 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 417231102
		arg_422_1.duration_ = 11.9

		local var_422_0 = {
			zh = 11.9,
			ja = 10.433
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play417231103(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["10113"]) and arg_422_1.var_.actorSpriteComps10113 == nil then
				arg_422_1.var_.actorSpriteComps10113 = arg_422_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_425_0 = 0.2

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["10113"]) then
				if arg_422_1.var_.actorSpriteComps10113 then
					for iter_425_0, iter_425_1 in pairs(arg_422_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_425_1 then
							if arg_422_1.isInRecall_ then
								iter_425_1.color = Color.New(Mathf.Lerp(iter_425_1.color.r, arg_422_1.hightColor1.r, (arg_422_1.time_ - 0) / var_425_0), Mathf.Lerp(iter_425_1.color.g, arg_422_1.hightColor1.g, (arg_422_1.time_ - 0) / var_425_0), (Mathf.Lerp(iter_425_1.color.b, arg_422_1.hightColor1.b, (arg_422_1.time_ - 0) / var_425_0)))
							else
								local var_425_1 = Mathf.Lerp(iter_425_1.color.r, 1, (arg_422_1.time_ - 0) / var_425_0)

								iter_425_1.color = Color.New(var_425_1, var_425_1, var_425_1)
							end
						end
					end
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["10113"]) and arg_422_1.var_.actorSpriteComps10113 then
				for iter_425_2, iter_425_3 in pairs(arg_422_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_425_3 then
						iter_425_3.color = arg_422_1.isInRecall_ and (arg_422_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_422_1.var_.actorSpriteComps10113 = nil
			end

			local var_425_2 = 0
			local var_425_3 = 1.225

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_2 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_4 = arg_422_1:GetWordFromCfg(417231102)
				local var_425_5 = arg_422_1:FormatText(var_425_4.content)

				arg_422_1.text_.text = var_425_5

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_7 = 49 <= 0 and var_425_3 or var_425_3 * (utf8.len(var_425_5) / 49)

				if (49 <= 0 and var_425_3 or var_425_3 * (utf8.len(var_425_5) / 49)) > 0 and var_425_3 < var_425_7 then
					arg_422_1.talkMaxDuration = var_425_7

					if var_425_7 + var_425_2 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_2
					end
				end

				arg_422_1.text_.text = var_425_5
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231102", "story_v_out_417231.awb") ~= 0 then
					local var_425_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231102", "story_v_out_417231.awb") / 1000

					if var_425_8 + var_425_2 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_8 + var_425_2
					end

					if var_425_4.prefab_name ~= "" and arg_422_1.actors_[var_425_4.prefab_name] ~= nil then
						local var_425_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_4.prefab_name].transform, "story_v_out_417231", "417231102", "story_v_out_417231.awb")

						arg_422_1:RecordAudio("417231102", var_425_9)
						arg_422_1:RecordAudio("417231102", var_425_9)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_417231", "417231102", "story_v_out_417231.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_417231", "417231102", "story_v_out_417231.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_10 = math.max(var_425_3, arg_422_1.talkMaxDuration)

			if var_425_2 <= arg_422_1.time_ and arg_422_1.time_ < var_425_2 + var_425_10 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_2) / var_425_10

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_2 + var_425_10 and arg_422_1.time_ < var_425_2 + var_425_10 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play417231103 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 417231103
		arg_426_1.duration_ = 8.53

		local var_426_0 = {
			zh = 4.933,
			ja = 8.533
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play417231104(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos10113 = arg_426_1.actors_["10113"].transform.localPosition
				arg_426_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_426_1:CheckSpriteTmpPos("10113", 3)

				for iter_429_0 = 0, arg_426_1.actors_["10113"].transform.childCount - 1 do
					local var_429_0 = arg_426_1.actors_["10113"].transform:GetChild(iter_429_0)

					if var_429_0.name == "split_6" or not string.find(var_429_0.name, "split") then
						var_429_0.gameObject:SetActive(true)
					else
						var_429_0.gameObject:SetActive(false)
					end
				end
			end

			local var_429_1 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_1 then
				arg_426_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_426_1.time_ - 0) / var_429_1)
			end

			if arg_426_1.time_ >= 0 + var_429_1 and arg_426_1.time_ < 0 + var_429_1 + arg_429_0 then
				arg_426_1.actors_["10113"].transform.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			local var_429_2 = 0
			local var_429_3 = 0.525

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_2 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_4 = arg_426_1:GetWordFromCfg(417231103)
				local var_429_5 = arg_426_1:FormatText(var_429_4.content)

				arg_426_1.text_.text = var_429_5

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_7 = 21 <= 0 and var_429_3 or var_429_3 * (utf8.len(var_429_5) / 21)

				if (21 <= 0 and var_429_3 or var_429_3 * (utf8.len(var_429_5) / 21)) > 0 and var_429_3 < var_429_7 then
					arg_426_1.talkMaxDuration = var_429_7

					if var_429_7 + var_429_2 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_7 + var_429_2
					end
				end

				arg_426_1.text_.text = var_429_5
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231103", "story_v_out_417231.awb") ~= 0 then
					local var_429_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231103", "story_v_out_417231.awb") / 1000

					if var_429_8 + var_429_2 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_8 + var_429_2
					end

					if var_429_4.prefab_name ~= "" and arg_426_1.actors_[var_429_4.prefab_name] ~= nil then
						local var_429_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_4.prefab_name].transform, "story_v_out_417231", "417231103", "story_v_out_417231.awb")

						arg_426_1:RecordAudio("417231103", var_429_9)
						arg_426_1:RecordAudio("417231103", var_429_9)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_417231", "417231103", "story_v_out_417231.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_417231", "417231103", "story_v_out_417231.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_10 = math.max(var_429_3, arg_426_1.talkMaxDuration)

			if var_429_2 <= arg_426_1.time_ and arg_426_1.time_ < var_429_2 + var_429_10 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_2) / var_429_10

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_2 + var_429_10 and arg_426_1.time_ < var_429_2 + var_429_10 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
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

		arg_426_1:InitPlayNodeList()
	end,
	Play417231104 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 417231104
		arg_430_1.duration_ = 14.3

		local var_430_0 = {
			zh = 8.733,
			ja = 14.3
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play417231105(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(arg_430_1.actors_["10113"]) and arg_430_1.var_.actorSpriteComps10113 == nil then
				arg_430_1.var_.actorSpriteComps10113 = arg_430_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_433_0 = 0.2

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 and not isNil(arg_430_1.actors_["10113"]) then
				if arg_430_1.var_.actorSpriteComps10113 then
					for iter_433_0, iter_433_1 in pairs(arg_430_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_433_1 then
							if arg_430_1.isInRecall_ then
								iter_433_1.color = Color.New(Mathf.Lerp(iter_433_1.color.r, arg_430_1.hightColor2.r, (arg_430_1.time_ - 0) / var_433_0), Mathf.Lerp(iter_433_1.color.g, arg_430_1.hightColor2.g, (arg_430_1.time_ - 0) / var_433_0), (Mathf.Lerp(iter_433_1.color.b, arg_430_1.hightColor2.b, (arg_430_1.time_ - 0) / var_433_0)))
							else
								local var_433_1 = Mathf.Lerp(iter_433_1.color.r, 0.5, (arg_430_1.time_ - 0) / var_433_0)

								iter_433_1.color = Color.New(var_433_1, var_433_1, var_433_1)
							end
						end
					end
				end
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 and not isNil(arg_430_1.actors_["10113"]) and arg_430_1.var_.actorSpriteComps10113 then
				for iter_433_2, iter_433_3 in pairs(arg_430_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_433_3 then
						iter_433_3.color = arg_430_1.isInRecall_ and (arg_430_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_430_1.var_.actorSpriteComps10113 = nil
			end

			local var_433_2 = 0
			local var_433_3 = 0.9

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_2 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_4 = arg_430_1:GetWordFromCfg(417231104)
				local var_433_5 = arg_430_1:FormatText(var_433_4.content)

				arg_430_1.text_.text = var_433_5

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_7 = 36 <= 0 and var_433_3 or var_433_3 * (utf8.len(var_433_5) / 36)

				if (36 <= 0 and var_433_3 or var_433_3 * (utf8.len(var_433_5) / 36)) > 0 and var_433_3 < var_433_7 then
					arg_430_1.talkMaxDuration = var_433_7

					if var_433_7 + var_433_2 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_7 + var_433_2
					end
				end

				arg_430_1.text_.text = var_433_5
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231104", "story_v_out_417231.awb") ~= 0 then
					local var_433_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231104", "story_v_out_417231.awb") / 1000

					if var_433_8 + var_433_2 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_8 + var_433_2
					end

					if var_433_4.prefab_name ~= "" and arg_430_1.actors_[var_433_4.prefab_name] ~= nil then
						local var_433_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_4.prefab_name].transform, "story_v_out_417231", "417231104", "story_v_out_417231.awb")

						arg_430_1:RecordAudio("417231104", var_433_9)
						arg_430_1:RecordAudio("417231104", var_433_9)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_417231", "417231104", "story_v_out_417231.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_417231", "417231104", "story_v_out_417231.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_10 = math.max(var_433_3, arg_430_1.talkMaxDuration)

			if var_433_2 <= arg_430_1.time_ and arg_430_1.time_ < var_433_2 + var_433_10 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_2) / var_433_10

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_2 + var_433_10 and arg_430_1.time_ < var_433_2 + var_433_10 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play417231105 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 417231105
		arg_434_1.duration_ = 11.47

		local var_434_0 = {
			zh = 10.533,
			ja = 11.466
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
				arg_434_0:Play417231106(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0.7

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_1 = arg_434_1:GetWordFromCfg(417231105)
				local var_437_2 = arg_434_1:FormatText(var_437_1.content)

				arg_434_1.text_.text = var_437_2

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_4 = 28 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 28)

				if (28 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_2) / 28)) > 0 and var_437_0 < var_437_4 then
					arg_434_1.talkMaxDuration = var_437_4

					if var_437_4 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_4 + 0
					end
				end

				arg_434_1.text_.text = var_437_2
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231105", "story_v_out_417231.awb") ~= 0 then
					local var_437_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231105", "story_v_out_417231.awb") / 1000

					if var_437_5 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + 0
					end

					if var_437_1.prefab_name ~= "" and arg_434_1.actors_[var_437_1.prefab_name] ~= nil then
						local var_437_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_1.prefab_name].transform, "story_v_out_417231", "417231105", "story_v_out_417231.awb")

						arg_434_1:RecordAudio("417231105", var_437_6)
						arg_434_1:RecordAudio("417231105", var_437_6)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_417231", "417231105", "story_v_out_417231.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_417231", "417231105", "story_v_out_417231.awb")
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
	Play417231106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 417231106
		arg_438_1.duration_ = 10.6

		local var_438_0 = {
			zh = 7.666,
			ja = 10.6
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
				arg_438_0:Play417231107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(arg_438_1.actors_["10113"]) and arg_438_1.var_.actorSpriteComps10113 == nil then
				arg_438_1.var_.actorSpriteComps10113 = arg_438_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_0 = 0.2

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 and not isNil(arg_438_1.actors_["10113"]) then
				if arg_438_1.var_.actorSpriteComps10113 then
					for iter_441_0, iter_441_1 in pairs(arg_438_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_441_1 then
							if arg_438_1.isInRecall_ then
								iter_441_1.color = Color.New(Mathf.Lerp(iter_441_1.color.r, arg_438_1.hightColor1.r, (arg_438_1.time_ - 0) / var_441_0), Mathf.Lerp(iter_441_1.color.g, arg_438_1.hightColor1.g, (arg_438_1.time_ - 0) / var_441_0), (Mathf.Lerp(iter_441_1.color.b, arg_438_1.hightColor1.b, (arg_438_1.time_ - 0) / var_441_0)))
							else
								local var_441_1 = Mathf.Lerp(iter_441_1.color.r, 1, (arg_438_1.time_ - 0) / var_441_0)

								iter_441_1.color = Color.New(var_441_1, var_441_1, var_441_1)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 and not isNil(arg_438_1.actors_["10113"]) and arg_438_1.var_.actorSpriteComps10113 then
				for iter_441_2, iter_441_3 in pairs(arg_438_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_441_3 then
						iter_441_3.color = arg_438_1.isInRecall_ and (arg_438_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_438_1.var_.actorSpriteComps10113 = nil
			end

			local var_441_2 = 0
			local var_441_3 = 0.725

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_2 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_4 = arg_438_1:GetWordFromCfg(417231106)
				local var_441_5 = arg_438_1:FormatText(var_441_4.content)

				arg_438_1.text_.text = var_441_5

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_7 = 29 <= 0 and var_441_3 or var_441_3 * (utf8.len(var_441_5) / 29)

				if (29 <= 0 and var_441_3 or var_441_3 * (utf8.len(var_441_5) / 29)) > 0 and var_441_3 < var_441_7 then
					arg_438_1.talkMaxDuration = var_441_7

					if var_441_7 + var_441_2 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_7 + var_441_2
					end
				end

				arg_438_1.text_.text = var_441_5
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231106", "story_v_out_417231.awb") ~= 0 then
					local var_441_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231106", "story_v_out_417231.awb") / 1000

					if var_441_8 + var_441_2 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_8 + var_441_2
					end

					if var_441_4.prefab_name ~= "" and arg_438_1.actors_[var_441_4.prefab_name] ~= nil then
						local var_441_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_4.prefab_name].transform, "story_v_out_417231", "417231106", "story_v_out_417231.awb")

						arg_438_1:RecordAudio("417231106", var_441_9)
						arg_438_1:RecordAudio("417231106", var_441_9)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_417231", "417231106", "story_v_out_417231.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_417231", "417231106", "story_v_out_417231.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_10 = math.max(var_441_3, arg_438_1.talkMaxDuration)

			if var_441_2 <= arg_438_1.time_ and arg_438_1.time_ < var_441_2 + var_441_10 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_2) / var_441_10

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_2 + var_441_10 and arg_438_1.time_ < var_441_2 + var_441_10 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play417231107 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 417231107
		arg_442_1.duration_ = 13.47

		local var_442_0 = {
			zh = 12.366,
			ja = 13.466
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play417231108(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 1.475

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_1 = arg_442_1:GetWordFromCfg(417231107)
				local var_445_2 = arg_442_1:FormatText(var_445_1.content)

				arg_442_1.text_.text = var_445_2

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_4 = 59 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 59)

				if (59 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 59)) > 0 and var_445_0 < var_445_4 then
					arg_442_1.talkMaxDuration = var_445_4

					if var_445_4 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_4 + 0
					end
				end

				arg_442_1.text_.text = var_445_2
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231107", "story_v_out_417231.awb") ~= 0 then
					local var_445_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231107", "story_v_out_417231.awb") / 1000

					if var_445_5 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_5 + 0
					end

					if var_445_1.prefab_name ~= "" and arg_442_1.actors_[var_445_1.prefab_name] ~= nil then
						local var_445_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_1.prefab_name].transform, "story_v_out_417231", "417231107", "story_v_out_417231.awb")

						arg_442_1:RecordAudio("417231107", var_445_6)
						arg_442_1:RecordAudio("417231107", var_445_6)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_417231", "417231107", "story_v_out_417231.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_417231", "417231107", "story_v_out_417231.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_7 = math.max(var_445_0, arg_442_1.talkMaxDuration)

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_7 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - 0) / var_445_7

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= 0 + var_445_7 and arg_442_1.time_ < 0 + var_445_7 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play417231108 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 417231108
		arg_446_1.duration_ = 8.83

		local var_446_0 = {
			zh = 7.033,
			ja = 8.833
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play417231109(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0.7

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_1 = arg_446_1:GetWordFromCfg(417231108)
				local var_449_2 = arg_446_1:FormatText(var_449_1.content)

				arg_446_1.text_.text = var_449_2

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_4 = 28 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_2) / 28)

				if (28 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_2) / 28)) > 0 and var_449_0 < var_449_4 then
					arg_446_1.talkMaxDuration = var_449_4

					if var_449_4 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_4 + 0
					end
				end

				arg_446_1.text_.text = var_449_2
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231108", "story_v_out_417231.awb") ~= 0 then
					local var_449_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231108", "story_v_out_417231.awb") / 1000

					if var_449_5 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_5 + 0
					end

					if var_449_1.prefab_name ~= "" and arg_446_1.actors_[var_449_1.prefab_name] ~= nil then
						local var_449_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_1.prefab_name].transform, "story_v_out_417231", "417231108", "story_v_out_417231.awb")

						arg_446_1:RecordAudio("417231108", var_449_6)
						arg_446_1:RecordAudio("417231108", var_449_6)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_417231", "417231108", "story_v_out_417231.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_417231", "417231108", "story_v_out_417231.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_7 = math.max(var_449_0, arg_446_1.talkMaxDuration)

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_7 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - 0) / var_449_7

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= 0 + var_449_7 and arg_446_1.time_ < 0 + var_449_7 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play417231109 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 417231109
		arg_450_1.duration_ = 4.43

		local var_450_0 = {
			zh = 2.066,
			ja = 4.433
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play417231110(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(arg_450_1.actors_["10113"]) and arg_450_1.var_.actorSpriteComps10113 == nil then
				arg_450_1.var_.actorSpriteComps10113 = arg_450_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_0 = 0.2

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 and not isNil(arg_450_1.actors_["10113"]) then
				if arg_450_1.var_.actorSpriteComps10113 then
					for iter_453_0, iter_453_1 in pairs(arg_450_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_453_1 then
							if arg_450_1.isInRecall_ then
								iter_453_1.color = Color.New(Mathf.Lerp(iter_453_1.color.r, arg_450_1.hightColor2.r, (arg_450_1.time_ - 0) / var_453_0), Mathf.Lerp(iter_453_1.color.g, arg_450_1.hightColor2.g, (arg_450_1.time_ - 0) / var_453_0), (Mathf.Lerp(iter_453_1.color.b, arg_450_1.hightColor2.b, (arg_450_1.time_ - 0) / var_453_0)))
							else
								local var_453_1 = Mathf.Lerp(iter_453_1.color.r, 0.5, (arg_450_1.time_ - 0) / var_453_0)

								iter_453_1.color = Color.New(var_453_1, var_453_1, var_453_1)
							end
						end
					end
				end
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 and not isNil(arg_450_1.actors_["10113"]) and arg_450_1.var_.actorSpriteComps10113 then
				for iter_453_2, iter_453_3 in pairs(arg_450_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_453_3 then
						iter_453_3.color = arg_450_1.isInRecall_ and (arg_450_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_450_1.var_.actorSpriteComps10113 = nil
			end

			local var_453_2 = 0
			local var_453_3 = 0.175

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_2 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_4 = arg_450_1:GetWordFromCfg(417231109)
				local var_453_5 = arg_450_1:FormatText(var_453_4.content)

				arg_450_1.text_.text = var_453_5

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_7 = 7 <= 0 and var_453_3 or var_453_3 * (utf8.len(var_453_5) / 7)

				if (7 <= 0 and var_453_3 or var_453_3 * (utf8.len(var_453_5) / 7)) > 0 and var_453_3 < var_453_7 then
					arg_450_1.talkMaxDuration = var_453_7

					if var_453_7 + var_453_2 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_7 + var_453_2
					end
				end

				arg_450_1.text_.text = var_453_5
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231109", "story_v_out_417231.awb") ~= 0 then
					local var_453_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231109", "story_v_out_417231.awb") / 1000

					if var_453_8 + var_453_2 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_8 + var_453_2
					end

					if var_453_4.prefab_name ~= "" and arg_450_1.actors_[var_453_4.prefab_name] ~= nil then
						local var_453_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_4.prefab_name].transform, "story_v_out_417231", "417231109", "story_v_out_417231.awb")

						arg_450_1:RecordAudio("417231109", var_453_9)
						arg_450_1:RecordAudio("417231109", var_453_9)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_417231", "417231109", "story_v_out_417231.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_417231", "417231109", "story_v_out_417231.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_10 = math.max(var_453_3, arg_450_1.talkMaxDuration)

			if var_453_2 <= arg_450_1.time_ and arg_450_1.time_ < var_453_2 + var_453_10 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_2) / var_453_10

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_2 + var_453_10 and arg_450_1.time_ < var_453_2 + var_453_10 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play417231110 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 417231110
		arg_454_1.duration_ = 13.3

		local var_454_0 = {
			zh = 9.466,
			ja = 13.3
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play417231111(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(arg_454_1.actors_["10113"]) and arg_454_1.var_.actorSpriteComps10113 == nil then
				arg_454_1.var_.actorSpriteComps10113 = arg_454_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_457_0 = 0.2

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 and not isNil(arg_454_1.actors_["10113"]) then
				if arg_454_1.var_.actorSpriteComps10113 then
					for iter_457_0, iter_457_1 in pairs(arg_454_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_457_1 then
							if arg_454_1.isInRecall_ then
								iter_457_1.color = Color.New(Mathf.Lerp(iter_457_1.color.r, arg_454_1.hightColor1.r, (arg_454_1.time_ - 0) / var_457_0), Mathf.Lerp(iter_457_1.color.g, arg_454_1.hightColor1.g, (arg_454_1.time_ - 0) / var_457_0), (Mathf.Lerp(iter_457_1.color.b, arg_454_1.hightColor1.b, (arg_454_1.time_ - 0) / var_457_0)))
							else
								local var_457_1 = Mathf.Lerp(iter_457_1.color.r, 1, (arg_454_1.time_ - 0) / var_457_0)

								iter_457_1.color = Color.New(var_457_1, var_457_1, var_457_1)
							end
						end
					end
				end
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 and not isNil(arg_454_1.actors_["10113"]) and arg_454_1.var_.actorSpriteComps10113 then
				for iter_457_2, iter_457_3 in pairs(arg_454_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_457_3 then
						iter_457_3.color = arg_454_1.isInRecall_ and (arg_454_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_454_1.var_.actorSpriteComps10113 = nil
			end

			local var_457_2 = 0
			local var_457_3 = 0.975

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_2 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_4 = arg_454_1:GetWordFromCfg(417231110)
				local var_457_5 = arg_454_1:FormatText(var_457_4.content)

				arg_454_1.text_.text = var_457_5

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_7 = 39 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 39)

				if (39 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 39)) > 0 and var_457_3 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_2
					end
				end

				arg_454_1.text_.text = var_457_5
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231110", "story_v_out_417231.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231110", "story_v_out_417231.awb") / 1000

					if var_457_8 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_2
					end

					if var_457_4.prefab_name ~= "" and arg_454_1.actors_[var_457_4.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_4.prefab_name].transform, "story_v_out_417231", "417231110", "story_v_out_417231.awb")

						arg_454_1:RecordAudio("417231110", var_457_9)
						arg_454_1:RecordAudio("417231110", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_417231", "417231110", "story_v_out_417231.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_417231", "417231110", "story_v_out_417231.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_10 = math.max(var_457_3, arg_454_1.talkMaxDuration)

			if var_457_2 <= arg_454_1.time_ and arg_454_1.time_ < var_457_2 + var_457_10 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_2) / var_457_10

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_2 + var_457_10 and arg_454_1.time_ < var_457_2 + var_457_10 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play417231111 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 417231111
		arg_458_1.duration_ = 3.3

		local var_458_0 = {
			zh = 3.033,
			ja = 3.3
		}
		local var_458_1 = manager.audio:GetLocalizationFlag()

		if var_458_0[var_458_1] ~= nil then
			arg_458_1.duration_ = var_458_0[var_458_1]
		end

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play417231112(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0.02 < arg_458_1.time_ and arg_458_1.time_ <= 0.02 + arg_461_0 then
				arg_458_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_thunder02", "")
			end

			local var_461_1 = 0
			local var_461_2 = 0.3

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_3 = arg_458_1:GetWordFromCfg(417231111)
				local var_461_4 = arg_458_1:FormatText(var_461_3.content)

				arg_458_1.text_.text = var_461_4

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_6 = 12 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_4) / 12)

				if (12 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_4) / 12)) > 0 and var_461_2 < var_461_6 then
					arg_458_1.talkMaxDuration = var_461_6

					if var_461_6 + var_461_1 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_6 + var_461_1
					end
				end

				arg_458_1.text_.text = var_461_4
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231111", "story_v_out_417231.awb") ~= 0 then
					local var_461_7 = manager.audio:GetVoiceLength("story_v_out_417231", "417231111", "story_v_out_417231.awb") / 1000

					if var_461_7 + var_461_1 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_7 + var_461_1
					end

					if var_461_3.prefab_name ~= "" and arg_458_1.actors_[var_461_3.prefab_name] ~= nil then
						local var_461_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_458_1.actors_[var_461_3.prefab_name].transform, "story_v_out_417231", "417231111", "story_v_out_417231.awb")

						arg_458_1:RecordAudio("417231111", var_461_8)
						arg_458_1:RecordAudio("417231111", var_461_8)
					else
						arg_458_1:AudioAction("play", "voice", "story_v_out_417231", "417231111", "story_v_out_417231.awb")
					end

					arg_458_1:RecordHistoryTalkVoice("story_v_out_417231", "417231111", "story_v_out_417231.awb")
				end

				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_9 = math.max(var_461_2, arg_458_1.talkMaxDuration)

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_9 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_1) / var_461_9

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_1 + var_461_9 and arg_458_1.time_ < var_461_1 + var_461_9 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play417231112 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 417231112
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play417231113(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.var_.moveOldPos10113 = arg_462_1.actors_["10113"].transform.localPosition
				arg_462_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_462_1:CheckSpriteTmpPos("10113", 7)

				for iter_465_0 = 0, arg_462_1.actors_["10113"].transform.childCount - 1 do
					local var_465_0 = arg_462_1.actors_["10113"].transform:GetChild(iter_465_0)

					if var_465_0.name == "" or not string.find(var_465_0.name, "split") then
						var_465_0.gameObject:SetActive(true)
					else
						var_465_0.gameObject:SetActive(false)
					end
				end
			end

			local var_465_1 = 0.001

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_1 then
				arg_462_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_462_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_462_1.time_ - 0) / var_465_1)
			end

			if arg_462_1.time_ >= 0 + var_465_1 and arg_462_1.time_ < 0 + var_465_1 + arg_465_0 then
				arg_462_1.actors_["10113"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_465_2 = 0
			local var_465_3 = 1.35

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_2 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, false)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_4 = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(417231112).content)

				arg_462_1.text_.text = var_465_4

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_6 = 54 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_4) / 54)

				if (54 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_4) / 54)) > 0 and var_465_3 < var_465_6 then
					arg_462_1.talkMaxDuration = var_465_6

					if var_465_6 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_6 + var_465_2
					end
				end

				arg_462_1.text_.text = var_465_4
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_7 = math.max(var_465_3, arg_462_1.talkMaxDuration)

			if var_465_2 <= arg_462_1.time_ and arg_462_1.time_ < var_465_2 + var_465_7 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_2) / var_465_7

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_2 + var_465_7 and arg_462_1.time_ < var_465_2 + var_465_7 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {
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

		arg_462_1:InitPlayNodeList()
	end,
	Play417231113 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 417231113
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play417231114(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0.725

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, false)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_1 = arg_466_1:FormatText(arg_466_1:GetWordFromCfg(417231113).content)

				arg_466_1.text_.text = var_469_1

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_3 = 29 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_1) / 29)

				if (29 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_1) / 29)) > 0 and var_469_0 < var_469_3 then
					arg_466_1.talkMaxDuration = var_469_3

					if var_469_3 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_3 + 0
					end
				end

				arg_466_1.text_.text = var_469_1
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_4 = math.max(var_469_0, arg_466_1.talkMaxDuration)

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_4 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - 0) / var_469_4

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= 0 + var_469_4 and arg_466_1.time_ < 0 + var_469_4 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play417231114 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 417231114
		arg_470_1.duration_ = 4.53

		local var_470_0 = {
			zh = 4.533,
			ja = 2.466
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
				arg_470_0:Play417231115(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0.275

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, true)
				arg_470_1.iconController_:SetSelectedState("hero")

				arg_470_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10049")

				arg_470_1.callingController_:SetSelectedState("normal")

				arg_470_1.keyicon_.color = Color.New(1, 1, 1)
				arg_470_1.icon_.color = Color.New(1, 1, 1)

				local var_473_1 = arg_470_1:GetWordFromCfg(417231114)
				local var_473_2 = arg_470_1:FormatText(var_473_1.content)

				arg_470_1.text_.text = var_473_2

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_4 = 11 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 11)

				if (11 <= 0 and var_473_0 or var_473_0 * (utf8.len(var_473_2) / 11)) > 0 and var_473_0 < var_473_4 then
					arg_470_1.talkMaxDuration = var_473_4

					if var_473_4 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_4 + 0
					end
				end

				arg_470_1.text_.text = var_473_2
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231114", "story_v_out_417231.awb") ~= 0 then
					local var_473_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231114", "story_v_out_417231.awb") / 1000

					if var_473_5 + 0 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_5 + 0
					end

					if var_473_1.prefab_name ~= "" and arg_470_1.actors_[var_473_1.prefab_name] ~= nil then
						local var_473_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_1.prefab_name].transform, "story_v_out_417231", "417231114", "story_v_out_417231.awb")

						arg_470_1:RecordAudio("417231114", var_473_6)
						arg_470_1:RecordAudio("417231114", var_473_6)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_417231", "417231114", "story_v_out_417231.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_417231", "417231114", "story_v_out_417231.awb")
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
	Play417231115 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 417231115
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play417231116(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0.6 < arg_474_1.time_ and arg_474_1.time_ <= 0.6 + arg_477_0 then
				arg_474_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_clock", "")
			end

			local var_477_1 = 0
			local var_477_2 = 1.1

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_3 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(417231115).content)

				arg_474_1.text_.text = var_477_3

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_5 = 44 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_3) / 44)

				if (44 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_3) / 44)) > 0 and var_477_2 < var_477_5 then
					arg_474_1.talkMaxDuration = var_477_5

					if var_477_5 + var_477_1 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_5 + var_477_1
					end
				end

				arg_474_1.text_.text = var_477_3
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_6 = math.max(var_477_2, arg_474_1.talkMaxDuration)

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_6 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_1) / var_477_6

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_1 + var_477_6 and arg_474_1.time_ < var_477_1 + var_477_6 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play417231116 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 417231116
		arg_478_1.duration_ = 3

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play417231117(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if arg_478_1.bgs_.STblack == nil then
				local var_481_0 = Object.Instantiate(arg_478_1.paintGo_)

				var_481_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_481_0.name = "STblack"
				var_481_0.transform.parent = arg_478_1.stage_.transform
				var_481_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_478_1.bgs_.STblack = var_481_0
			end

			if 1 < arg_478_1.time_ and arg_478_1.time_ <= 1 + arg_481_0 then
				local var_481_1 = arg_478_1.bgs_.STblack

				arg_478_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_481_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_481_2 = var_481_1:GetComponent("SpriteRenderer")

				if var_481_2 and var_481_2.sprite then
					local var_481_3 = 2 * (var_481_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_481_1.transform.localScale = Vector3.New(var_481_3 / var_481_2.sprite.bounds.size.y < var_481_3 * manager.ui.mainCameraCom_.aspect / var_481_2.sprite.bounds.size.x and var_481_3 * manager.ui.mainCameraCom_.aspect / var_481_2.sprite.bounds.size.x or var_481_3 / var_481_2.sprite.bounds.size.y, var_481_3 / var_481_2.sprite.bounds.size.y < var_481_3 * manager.ui.mainCameraCom_.aspect / var_481_2.sprite.bounds.size.x and var_481_3 * manager.ui.mainCameraCom_.aspect / var_481_2.sprite.bounds.size.x or var_481_3 / var_481_2.sprite.bounds.size.y, 0)
				end

				for iter_481_0, iter_481_1 in pairs(arg_478_1.bgs_) do
					if iter_481_0 ~= "STblack" then
						iter_481_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1 < arg_478_1.time_ and arg_478_1.time_ <= 1 + arg_481_0 then
				arg_478_1.cswbg_:SetActive(true)

				local var_481_4 = arg_478_1.cswt_:GetComponent("RectTransform")

				arg_478_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_481_4.offsetMin = Vector2.New(0, 0)
				var_481_4.offsetMax = Vector2.New(0, 0)
				arg_478_1.cswt_.text = arg_478_1:FormatText(arg_478_1:GetWordFromCfg(419119).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.cswt_)

				arg_478_1.cswt_.fontSize = 120
				arg_478_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_478_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_478_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_481_5 = 0

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_5 + arg_481_0 then
				arg_478_1.mask_.enabled = true
				arg_478_1.mask_.raycastTarget = false

				arg_478_1:SetGaussion(false)
			end

			local var_481_6 = 1

			if var_481_5 <= arg_478_1.time_ and arg_478_1.time_ < var_481_5 + var_481_6 then
				local var_481_7 = Color.New(0, 0, 0)

				var_481_7.a = Mathf.Lerp(0, 1, (arg_478_1.time_ - var_481_5) / var_481_6)
				arg_478_1.mask_.color = var_481_7
			end

			if arg_478_1.time_ >= var_481_5 + var_481_6 and arg_478_1.time_ < var_481_5 + var_481_6 + arg_481_0 then
				local var_481_8 = Color.New(0, 0, 0)

				var_481_8.a = 1
				arg_478_1.mask_.color = var_481_8
			end

			local var_481_9 = 1

			if 1 < arg_478_1.time_ and arg_478_1.time_ <= var_481_9 + arg_481_0 then
				arg_478_1.mask_.enabled = true
				arg_478_1.mask_.raycastTarget = false

				arg_478_1:SetGaussion(false)
			end

			local var_481_10 = 1

			if var_481_9 <= arg_478_1.time_ and arg_478_1.time_ < var_481_9 + var_481_10 then
				local var_481_11 = Color.New(0, 0, 0)

				var_481_11.a = Mathf.Lerp(1, 0, (arg_478_1.time_ - var_481_9) / var_481_10)
				arg_478_1.mask_.color = var_481_11
			end

			if arg_478_1.time_ >= var_481_9 + var_481_10 and arg_478_1.time_ < var_481_9 + var_481_10 + arg_481_0 then
				local var_481_12 = Color.New(0, 0, 0)

				arg_478_1.mask_.enabled = false
				var_481_12.a = 0
				arg_478_1.mask_.color = var_481_12
			end

			if 0.966666666666667 < arg_478_1.time_ and arg_478_1.time_ <= 0.966666666666667 + arg_481_0 then
				arg_478_1.fswbg_:SetActive(false)
				arg_478_1.dialog_:SetActive(false)
				SetActive(arg_478_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_478_1:ShowNextGo(false)
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_wind", "")
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_481_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_478_1.bgmTxt_.text ~= var_481_16 and arg_478_1.bgmTxt_.text ~= "" then
						if arg_478_1.bgmTxt2_.text ~= "" then
							arg_478_1.bgmTxt_.text = arg_478_1.bgmTxt2_.text
						end

						arg_478_1.bgmTxt2_.text = var_481_16

						arg_478_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_478_1.bgmTxt_.text = var_481_16
						arg_478_1.bgmTxt2_.text = var_481_16
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

			if 0.333333333333333 < arg_478_1.time_ and arg_478_1.time_ <= 0.333333333333333 + arg_481_0 then
				arg_478_1:AudioAction("stop", "music", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard.awb")

				local var_481_19 = manager.audio:GetAudioName("bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard")

				if "" ~= "" then
					if arg_478_1.bgmTxt_.text ~= var_481_19 and arg_478_1.bgmTxt_.text ~= "" then
						if arg_478_1.bgmTxt2_.text ~= "" then
							arg_478_1.bgmTxt_.text = arg_478_1.bgmTxt2_.text
						end

						arg_478_1.bgmTxt2_.text = var_481_19

						arg_478_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_478_1.bgmTxt_.text = var_481_19
						arg_478_1.bgmTxt2_.text = var_481_19
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
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play417231117 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 417231117
		arg_484_1.duration_ = 2

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play417231118(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.cswbg_:SetActive(true)

				local var_487_0 = arg_484_1.cswt_:GetComponent("RectTransform")

				arg_484_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_487_0.offsetMin = Vector2.New(0, 0)
				var_487_0.offsetMax = Vector2.New(0, 0)
				arg_484_1.cswt_.text = arg_484_1:FormatText(arg_484_1:GetWordFromCfg(419120).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.cswt_)

				arg_484_1.cswt_.fontSize = 120
				arg_484_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_484_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_484_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play417231118 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 417231118
		arg_488_1.duration_ = 7.37

		local var_488_0 = {
			zh = 6.76633333333333,
			ja = 7.36633333333333
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
				arg_488_0:Play417231119(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.mask_.enabled = true
				arg_488_1.mask_.raycastTarget = false

				arg_488_1:SetGaussion(false)
			end

			local var_491_0 = 1.23333333333333

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_0 then
				local var_491_1 = Color.New(0, 0, 0)

				var_491_1.a = Mathf.Lerp(0, 1, (arg_488_1.time_ - 0) / var_491_0)
				arg_488_1.mask_.color = var_491_1
			end

			if arg_488_1.time_ >= 0 + var_491_0 and arg_488_1.time_ < 0 + var_491_0 + arg_491_0 then
				local var_491_2 = Color.New(0, 0, 0)

				var_491_2.a = 1
				arg_488_1.mask_.color = var_491_2
			end

			local var_491_3 = 1.23333333333333

			if 1.23333333333333 < arg_488_1.time_ and arg_488_1.time_ <= var_491_3 + arg_491_0 then
				arg_488_1.mask_.enabled = true
				arg_488_1.mask_.raycastTarget = false

				arg_488_1:SetGaussion(false)
			end

			local var_491_4 = 2

			if var_491_3 <= arg_488_1.time_ and arg_488_1.time_ < var_491_3 + var_491_4 then
				local var_491_5 = Color.New(0, 0, 0)

				var_491_5.a = Mathf.Lerp(1, 0, (arg_488_1.time_ - var_491_3) / var_491_4)
				arg_488_1.mask_.color = var_491_5
			end

			if arg_488_1.time_ >= var_491_3 + var_491_4 and arg_488_1.time_ < var_491_3 + var_491_4 + arg_491_0 then
				local var_491_6 = Color.New(0, 0, 0)

				arg_488_1.mask_.enabled = false
				var_491_6.a = 0
				arg_488_1.mask_.color = var_491_6
			end

			if 1.23333333333333 < arg_488_1.time_ and arg_488_1.time_ <= 1.23333333333333 + arg_491_0 then
				local var_491_7 = arg_488_1.bgs_.ST75

				arg_488_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_491_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_491_8 = var_491_7:GetComponent("SpriteRenderer")

				if var_491_8 and var_491_8.sprite then
					local var_491_9 = 2 * (var_491_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_491_7.transform.localScale = Vector3.New(var_491_9 / var_491_8.sprite.bounds.size.y < var_491_9 * manager.ui.mainCameraCom_.aspect / var_491_8.sprite.bounds.size.x and var_491_9 * manager.ui.mainCameraCom_.aspect / var_491_8.sprite.bounds.size.x or var_491_9 / var_491_8.sprite.bounds.size.y, var_491_9 / var_491_8.sprite.bounds.size.y < var_491_9 * manager.ui.mainCameraCom_.aspect / var_491_8.sprite.bounds.size.x and var_491_9 * manager.ui.mainCameraCom_.aspect / var_491_8.sprite.bounds.size.x or var_491_9 / var_491_8.sprite.bounds.size.y, 0)
				end

				for iter_491_0, iter_491_1 in pairs(arg_488_1.bgs_) do
					if iter_491_0 ~= "ST75" then
						iter_491_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2.9 < arg_488_1.time_ and arg_488_1.time_ <= 2.9 + arg_491_0 then
				local var_491_10 = arg_488_1.actors_["10128"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_491_10 then
					arg_488_1.var_.alphaOldValue10128 = var_491_10.alpha
					arg_488_1.var_.characterEffect10128 = var_491_10
				end

				arg_488_1.var_.alphaOldValue10128 = 0
			end

			local var_491_11 = 0.333333333333333

			if 2.9 <= arg_488_1.time_ and arg_488_1.time_ < 2.9 + var_491_11 then
				if arg_488_1.var_.characterEffect10128 then
					arg_488_1.var_.characterEffect10128.alpha = Mathf.Lerp(arg_488_1.var_.alphaOldValue10128, 1, (arg_488_1.time_ - 2.9) / var_491_11)
				end
			end

			if arg_488_1.time_ >= 2.9 + var_491_11 and arg_488_1.time_ < 2.9 + var_491_11 + arg_491_0 and arg_488_1.var_.characterEffect10128 then
				arg_488_1.var_.characterEffect10128.alpha = 1
			end

			local var_491_12 = arg_488_1.actors_["10128"]

			if 2.9 < arg_488_1.time_ and arg_488_1.time_ <= 2.9 + arg_491_0 and not isNil(var_491_12) and arg_488_1.var_.actorSpriteComps10128 == nil then
				arg_488_1.var_.actorSpriteComps10128 = var_491_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_491_13 = 0.2

			if 2.9 <= arg_488_1.time_ and arg_488_1.time_ < 2.9 + var_491_13 and not isNil(var_491_12) then
				if arg_488_1.var_.actorSpriteComps10128 then
					for iter_491_2, iter_491_3 in pairs(arg_488_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_491_3 then
							if arg_488_1.isInRecall_ then
								iter_491_3.color = Color.New(Mathf.Lerp(iter_491_3.color.r, arg_488_1.hightColor1.r, (arg_488_1.time_ - 2.9) / var_491_13), Mathf.Lerp(iter_491_3.color.g, arg_488_1.hightColor1.g, (arg_488_1.time_ - 2.9) / var_491_13), (Mathf.Lerp(iter_491_3.color.b, arg_488_1.hightColor1.b, (arg_488_1.time_ - 2.9) / var_491_13)))
							else
								local var_491_14 = Mathf.Lerp(iter_491_3.color.r, 1, (arg_488_1.time_ - 2.9) / var_491_13)

								iter_491_3.color = Color.New(var_491_14, var_491_14, var_491_14)
							end
						end
					end
				end
			end

			if arg_488_1.time_ >= 2.9 + var_491_13 and arg_488_1.time_ < 2.9 + var_491_13 + arg_491_0 and not isNil(var_491_12) and arg_488_1.var_.actorSpriteComps10128 then
				for iter_491_4, iter_491_5 in pairs(arg_488_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_491_5 then
						iter_491_5.color = arg_488_1.isInRecall_ and (arg_488_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_488_1.var_.actorSpriteComps10128 = nil
			end

			local var_491_15 = arg_488_1.actors_["10128"].transform

			if 2.9 < arg_488_1.time_ and arg_488_1.time_ <= 2.9 + arg_491_0 then
				arg_488_1.var_.moveOldPos10128 = var_491_15.localPosition
				var_491_15.localScale = Vector3.New(1, 1, 1)

				arg_488_1:CheckSpriteTmpPos("10128", 3)

				for iter_491_6 = 0, var_491_15.childCount - 1 do
					local var_491_16 = var_491_15:GetChild(iter_491_6)

					if var_491_16.name == "" or not string.find(var_491_16.name, "split") then
						var_491_16.gameObject:SetActive(true)
					else
						var_491_16.gameObject:SetActive(false)
					end
				end
			end

			local var_491_17 = 0.001

			if 2.9 <= arg_488_1.time_ and arg_488_1.time_ < 2.9 + var_491_17 then
				var_491_15.localPosition = Vector3.Lerp(arg_488_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_488_1.time_ - 2.9) / var_491_17)
			end

			if arg_488_1.time_ >= 2.9 + var_491_17 and arg_488_1.time_ < 2.9 + var_491_17 + arg_491_0 then
				var_491_15.localPosition = Vector3.New(0, -347, -300)
			end

			if 1.03333333333333 < arg_488_1.time_ and arg_488_1.time_ <= 1.03333333333333 + arg_491_0 then
				arg_488_1.cswbg_:SetActive(false)
			end

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_491_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_488_1.bgmTxt_.text ~= var_491_20 and arg_488_1.bgmTxt_.text ~= "" then
						if arg_488_1.bgmTxt2_.text ~= "" then
							arg_488_1.bgmTxt_.text = arg_488_1.bgmTxt2_.text
						end

						arg_488_1.bgmTxt2_.text = var_491_20

						arg_488_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_488_1.bgmTxt_.text = var_491_20
						arg_488_1.bgmTxt2_.text = var_491_20
					end

					if arg_488_1.bgmTimer then
						arg_488_1.bgmTimer:Stop()

						arg_488_1.bgmTimer = nil
					end

					if arg_488_1.settingData.show_music_name == 1 then
						arg_488_1.musicController:SetSelectedState("show")
						arg_488_1.musicAnimator_:Play("open", 0, 0)

						if arg_488_1.settingData.music_time ~= 0 then
							arg_488_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_488_1.settingData.music_time), function()
								if arg_488_1 == nil or isNil(arg_488_1.bgmTxt_) then
									return
								end

								arg_488_1.musicController:SetSelectedState("hide")
								arg_488_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.766666666666667 < arg_488_1.time_ and arg_488_1.time_ <= 0.766666666666667 + arg_491_0 then
				arg_488_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_491_23 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

				if "" ~= "" then
					if arg_488_1.bgmTxt_.text ~= var_491_23 and arg_488_1.bgmTxt_.text ~= "" then
						if arg_488_1.bgmTxt2_.text ~= "" then
							arg_488_1.bgmTxt_.text = arg_488_1.bgmTxt2_.text
						end

						arg_488_1.bgmTxt2_.text = var_491_23

						arg_488_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_488_1.bgmTxt_.text = var_491_23
						arg_488_1.bgmTxt2_.text = var_491_23
					end

					if arg_488_1.bgmTimer then
						arg_488_1.bgmTimer:Stop()

						arg_488_1.bgmTimer = nil
					end

					if arg_488_1.settingData.show_music_name == 1 then
						arg_488_1.musicController:SetSelectedState("show")
						arg_488_1.musicAnimator_:Play("open", 0, 0)

						if arg_488_1.settingData.music_time ~= 0 then
							arg_488_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_488_1.settingData.music_time), function()
								if arg_488_1 == nil or isNil(arg_488_1.bgmTxt_) then
									return
								end

								arg_488_1.musicController:SetSelectedState("hide")
								arg_488_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.766666666666667 < arg_488_1.time_ and arg_488_1.time_ <= 0.766666666666667 + arg_491_0 then
				arg_488_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_truck_loop", "")
			end

			if arg_488_1.frameCnt_ <= 1 then
				arg_488_1.dialog_:SetActive(false)
			end

			local var_491_25 = 3.23333333333333
			local var_491_26 = 0.725

			if 3.23333333333333 < arg_488_1.time_ and arg_488_1.time_ <= var_491_25 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0

				arg_488_1.dialog_:SetActive(true)

				arg_488_1.dialogCg_.alpha = 0

				local var_491_27 = LeanTween.value(arg_488_1.dialog_, 0, 1, 0.3)

				var_491_27:setOnUpdate(LuaHelper.FloatAction(function(arg_494_0)
					arg_488_1.dialogCg_.alpha = arg_494_0
				end))
				var_491_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_488_1.dialog_)
					var_491_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_488_1.duration_ = arg_488_1.duration_ + 0.3

				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_28 = arg_488_1:GetWordFromCfg(417231118)
				local var_491_29 = arg_488_1:FormatText(var_491_28.content)

				arg_488_1.text_.text = var_491_29

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_31 = 7 <= 0 and var_491_26 or var_491_26 * (utf8.len(var_491_29) / 7)

				if (7 <= 0 and var_491_26 or var_491_26 * (utf8.len(var_491_29) / 7)) > 0 and var_491_26 < var_491_31 then
					arg_488_1.talkMaxDuration = var_491_31
					var_491_25 = var_491_25 + 0.3

					if var_491_31 + var_491_25 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_31 + var_491_25
					end
				end

				arg_488_1.text_.text = var_491_29
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231118", "story_v_out_417231.awb") ~= 0 then
					local var_491_32 = manager.audio:GetVoiceLength("story_v_out_417231", "417231118", "story_v_out_417231.awb") / 1000

					if var_491_32 + var_491_25 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_32 + var_491_25
					end

					if var_491_28.prefab_name ~= "" and arg_488_1.actors_[var_491_28.prefab_name] ~= nil then
						local var_491_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_28.prefab_name].transform, "story_v_out_417231", "417231118", "story_v_out_417231.awb")

						arg_488_1:RecordAudio("417231118", var_491_33)
						arg_488_1:RecordAudio("417231118", var_491_33)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_417231", "417231118", "story_v_out_417231.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_417231", "417231118", "story_v_out_417231.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_34 = var_491_25 + 0.3
			local var_491_35 = math.max(var_491_26, arg_488_1.talkMaxDuration)

			if var_491_25 + 0.3 <= arg_488_1.time_ and arg_488_1.time_ < var_491_34 + var_491_35 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_34) / var_491_35

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_34 + var_491_35 and arg_488_1.time_ < var_491_34 + var_491_35 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_488_1:InitPlayNodeList()
	end,
	Play417231119 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 417231119
		arg_496_1.duration_ = 3.07

		local var_496_0 = {
			zh = 3.066,
			ja = 1.9
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
				arg_496_0:Play417231120(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(arg_496_1.actors_["10128"]) and arg_496_1.var_.actorSpriteComps10128 == nil then
				arg_496_1.var_.actorSpriteComps10128 = arg_496_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_499_0 = 0.2

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_0 and not isNil(arg_496_1.actors_["10128"]) then
				if arg_496_1.var_.actorSpriteComps10128 then
					for iter_499_0, iter_499_1 in pairs(arg_496_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_499_1 then
							if arg_496_1.isInRecall_ then
								iter_499_1.color = Color.New(Mathf.Lerp(iter_499_1.color.r, arg_496_1.hightColor2.r, (arg_496_1.time_ - 0) / var_499_0), Mathf.Lerp(iter_499_1.color.g, arg_496_1.hightColor2.g, (arg_496_1.time_ - 0) / var_499_0), (Mathf.Lerp(iter_499_1.color.b, arg_496_1.hightColor2.b, (arg_496_1.time_ - 0) / var_499_0)))
							else
								local var_499_1 = Mathf.Lerp(iter_499_1.color.r, 0.5, (arg_496_1.time_ - 0) / var_499_0)

								iter_499_1.color = Color.New(var_499_1, var_499_1, var_499_1)
							end
						end
					end
				end
			end

			if arg_496_1.time_ >= 0 + var_499_0 and arg_496_1.time_ < 0 + var_499_0 + arg_499_0 and not isNil(arg_496_1.actors_["10128"]) and arg_496_1.var_.actorSpriteComps10128 then
				for iter_499_2, iter_499_3 in pairs(arg_496_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_499_3 then
						iter_499_3.color = arg_496_1.isInRecall_ and (arg_496_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_496_1.var_.actorSpriteComps10128 = nil
			end

			local var_499_2 = 0
			local var_499_3 = 0.2

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_2 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_4 = arg_496_1:GetWordFromCfg(417231119)
				local var_499_5 = arg_496_1:FormatText(var_499_4.content)

				arg_496_1.text_.text = var_499_5

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_7 = 8 <= 0 and var_499_3 or var_499_3 * (utf8.len(var_499_5) / 8)

				if (8 <= 0 and var_499_3 or var_499_3 * (utf8.len(var_499_5) / 8)) > 0 and var_499_3 < var_499_7 then
					arg_496_1.talkMaxDuration = var_499_7

					if var_499_7 + var_499_2 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_7 + var_499_2
					end
				end

				arg_496_1.text_.text = var_499_5
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231119", "story_v_out_417231.awb") ~= 0 then
					local var_499_8 = manager.audio:GetVoiceLength("story_v_out_417231", "417231119", "story_v_out_417231.awb") / 1000

					if var_499_8 + var_499_2 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_8 + var_499_2
					end

					if var_499_4.prefab_name ~= "" and arg_496_1.actors_[var_499_4.prefab_name] ~= nil then
						local var_499_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_4.prefab_name].transform, "story_v_out_417231", "417231119", "story_v_out_417231.awb")

						arg_496_1:RecordAudio("417231119", var_499_9)
						arg_496_1:RecordAudio("417231119", var_499_9)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_417231", "417231119", "story_v_out_417231.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_417231", "417231119", "story_v_out_417231.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_10 = math.max(var_499_3, arg_496_1.talkMaxDuration)

			if var_499_2 <= arg_496_1.time_ and arg_496_1.time_ < var_499_2 + var_499_10 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_2) / var_499_10

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_2 + var_499_10 and arg_496_1.time_ < var_499_2 + var_499_10 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play417231120 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 417231120
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play417231121(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.var_.moveOldPos10128 = arg_500_1.actors_["10128"].transform.localPosition
				arg_500_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_500_1:CheckSpriteTmpPos("10128", 7)

				for iter_503_0 = 0, arg_500_1.actors_["10128"].transform.childCount - 1 do
					local var_503_0 = arg_500_1.actors_["10128"].transform:GetChild(iter_503_0)

					if var_503_0.name == "" or not string.find(var_503_0.name, "split") then
						var_503_0.gameObject:SetActive(true)
					else
						var_503_0.gameObject:SetActive(false)
					end
				end
			end

			local var_503_1 = 0.001

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_1 then
				arg_500_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_500_1.time_ - 0) / var_503_1)
			end

			if arg_500_1.time_ >= 0 + var_503_1 and arg_500_1.time_ < 0 + var_503_1 + arg_503_0 then
				arg_500_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_503_2 = 0
			local var_503_3 = 0.725

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_2 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_4 = arg_500_1:FormatText(arg_500_1:GetWordFromCfg(417231120).content)

				arg_500_1.text_.text = var_503_4

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_6 = 29 <= 0 and var_503_3 or var_503_3 * (utf8.len(var_503_4) / 29)

				if (29 <= 0 and var_503_3 or var_503_3 * (utf8.len(var_503_4) / 29)) > 0 and var_503_3 < var_503_6 then
					arg_500_1.talkMaxDuration = var_503_6

					if var_503_6 + var_503_2 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_6 + var_503_2
					end
				end

				arg_500_1.text_.text = var_503_4
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_7 = math.max(var_503_3, arg_500_1.talkMaxDuration)

			if var_503_2 <= arg_500_1.time_ and arg_500_1.time_ < var_503_2 + var_503_7 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_2) / var_503_7

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_2 + var_503_7 and arg_500_1.time_ < var_503_2 + var_503_7 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {
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

		arg_500_1:InitPlayNodeList()
	end,
	Play417231121 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 417231121
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play417231122(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			if 1.03333333333333 < arg_504_1.time_ and arg_504_1.time_ <= 1.03333333333333 + arg_507_0 then
				arg_504_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_truck03", "")
			end

			if 0.133333333333333 < arg_504_1.time_ and arg_504_1.time_ <= 0.133333333333333 + arg_507_0 then
				arg_504_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_truck_loop", "")
			end

			local var_507_2 = 0
			local var_507_3 = 1.375

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_2 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0

				arg_504_1.dialog_:SetActive(true)

				arg_504_1.dialogCg_.alpha = 0

				local var_507_4 = LeanTween.value(arg_504_1.dialog_, 0, 1, 0.3)

				var_507_4:setOnUpdate(LuaHelper.FloatAction(function(arg_508_0)
					arg_504_1.dialogCg_.alpha = arg_508_0
				end))
				var_507_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_504_1.dialog_)
					var_507_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_504_1.duration_ = arg_504_1.duration_ + 0.3

				SetActive(arg_504_1.leftNameGo_, false)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_5 = arg_504_1:FormatText(arg_504_1:GetWordFromCfg(417231121).content)

				arg_504_1.text_.text = var_507_5

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_7 = 55 <= 0 and var_507_3 or var_507_3 * (utf8.len(var_507_5) / 55)

				if (55 <= 0 and var_507_3 or var_507_3 * (utf8.len(var_507_5) / 55)) > 0 and var_507_3 < var_507_7 then
					arg_504_1.talkMaxDuration = var_507_7
					var_507_2 = var_507_2 + 0.3

					if var_507_7 + var_507_2 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_7 + var_507_2
					end
				end

				arg_504_1.text_.text = var_507_5
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_8 = var_507_2 + 0.3
			local var_507_9 = math.max(var_507_3, arg_504_1.talkMaxDuration)

			if var_507_2 + 0.3 <= arg_504_1.time_ and arg_504_1.time_ < var_507_8 + var_507_9 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_8) / var_507_9

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_8 + var_507_9 and arg_504_1.time_ < var_507_8 + var_507_9 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play417231122 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 417231122
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play417231123(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 1.06666666666667 < arg_510_1.time_ and arg_510_1.time_ <= 1.06666666666667 + arg_513_0 then
				arg_510_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_explosion", "")
			end

			local var_513_1 = 0
			local var_513_2 = 1.225

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_3 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(417231122).content)

				arg_510_1.text_.text = var_513_3

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_5 = 49 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 49)

				if (49 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 49)) > 0 and var_513_2 < var_513_5 then
					arg_510_1.talkMaxDuration = var_513_5

					if var_513_5 + var_513_1 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_5 + var_513_1
					end
				end

				arg_510_1.text_.text = var_513_3
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_6 = math.max(var_513_2, arg_510_1.talkMaxDuration)

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_6 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_1) / var_513_6

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_1 + var_513_6 and arg_510_1.time_ < var_513_1 + var_513_6 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play417231123 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 417231123
		arg_514_1.duration_ = 11.5

		local var_514_0 = {
			zh = 8.5,
			ja = 11.5
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play417231124(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_9000

			if 4 < arg_514_1.time_ and arg_514_1.time_ <= 4 + arg_517_0 then
				arg_514_1.allBtn_.enabled = false
			end

			if arg_514_1.time_ >= 4 + 0.3 and arg_514_1.time_ < 4 + 0.3 + arg_517_0 then
				arg_514_1.allBtn_.enabled = true
			end

			local var_517_0 = "SS1708"

			if arg_514_1.bgs_.SS1708 == nil then
				local var_517_1 = Object.Instantiate(arg_514_1.paintGo_)

				var_517_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_517_0)
				var_517_1.name = var_517_0
				var_517_1.transform.parent = arg_514_1.stage_.transform
				var_517_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_514_1.bgs_[var_517_0] = var_517_1
			end

			if 2 < arg_514_1.time_ and arg_514_1.time_ <= 2 + arg_517_0 then
				local var_517_2 = arg_514_1.bgs_.SS1708

				arg_514_1.bgs_.SS1708.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_517_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_517_3 = var_517_2:GetComponent("SpriteRenderer")

				if var_517_3 and var_517_3.sprite then
					local var_517_4 = 2 * (var_517_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_517_2.transform.localScale = Vector3.New(var_517_4 / var_517_3.sprite.bounds.size.y < var_517_4 * manager.ui.mainCameraCom_.aspect / var_517_3.sprite.bounds.size.x and var_517_4 * manager.ui.mainCameraCom_.aspect / var_517_3.sprite.bounds.size.x or var_517_4 / var_517_3.sprite.bounds.size.y, var_517_4 / var_517_3.sprite.bounds.size.y < var_517_4 * manager.ui.mainCameraCom_.aspect / var_517_3.sprite.bounds.size.x and var_517_4 * manager.ui.mainCameraCom_.aspect / var_517_3.sprite.bounds.size.x or var_517_4 / var_517_3.sprite.bounds.size.y, 0)
				end

				for iter_517_0, iter_517_1 in pairs(arg_514_1.bgs_) do
					if iter_517_0 ~= "SS1708" then
						iter_517_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_517_5 = 0

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_5 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_6 = 2

			if var_517_5 <= arg_514_1.time_ and arg_514_1.time_ < var_517_5 + var_517_6 then
				local var_517_7 = Color.New(0, 0, 0)

				var_517_7.a = Mathf.Lerp(0, 1, (arg_514_1.time_ - var_517_5) / var_517_6)
				arg_514_1.mask_.color = var_517_7
			end

			if arg_514_1.time_ >= var_517_5 + var_517_6 and arg_514_1.time_ < var_517_5 + var_517_6 + arg_517_0 then
				local var_517_8 = Color.New(0, 0, 0)

				var_517_8.a = 1
				arg_514_1.mask_.color = var_517_8
			end

			local var_517_9 = 2

			if 2 < arg_514_1.time_ and arg_514_1.time_ <= var_517_9 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_10 = 2

			if var_517_9 <= arg_514_1.time_ and arg_514_1.time_ < var_517_9 + var_517_10 then
				local var_517_11 = Color.New(0, 0, 0)

				var_517_11.a = Mathf.Lerp(1, 0, (arg_514_1.time_ - var_517_9) / var_517_10)
				arg_514_1.mask_.color = var_517_11
			end

			if arg_514_1.time_ >= var_517_9 + var_517_10 and arg_514_1.time_ < var_517_9 + var_517_10 + arg_517_0 then
				local var_517_12 = Color.New(0, 0, 0)

				arg_514_1.mask_.enabled = false
				var_517_12.a = 0
				arg_514_1.mask_.color = var_517_12
			end

			local var_517_13 = arg_514_1.bgs_.SS1708.transform

			if 2 < arg_514_1.time_ and arg_514_1.time_ <= 2 + arg_517_0 then
				arg_514_1.var_.moveOldPosSS1708 = var_517_13.localPosition
			end

			local var_517_14 = 0.0666666666666668

			if 2 <= arg_514_1.time_ and arg_514_1.time_ < 2 + var_517_14 then
				var_517_13.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPosSS1708, Vector3.New(0, 1, 10), (arg_514_1.time_ - 2) / var_517_14)
			end

			if arg_514_1.time_ >= 2 + var_517_14 and arg_514_1.time_ < 2 + var_517_14 + arg_517_0 then
				var_517_13.localPosition = Vector3.New(0, 1, 10)
			end

			local var_517_15 = arg_514_1.bgs_.SS1708.transform

			if 2.06666666666667 < arg_514_1.time_ and arg_514_1.time_ <= 2.06666666666667 + arg_517_0 then
				arg_514_1.var_.moveOldPosSS1708 = var_517_15.localPosition
			end

			local var_517_16 = 1.93333333333333

			if 2.06666666666667 <= arg_514_1.time_ and arg_514_1.time_ < 2.06666666666667 + var_517_16 then
				var_517_15.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPosSS1708, Vector3.New(0, 1, 9.5), (arg_514_1.time_ - 2.06666666666667) / var_517_16)
			end

			if arg_514_1.time_ >= 2.06666666666667 + var_517_16 and arg_514_1.time_ < 2.06666666666667 + var_517_16 + arg_517_0 then
				var_517_15.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 2 < arg_514_1.time_ and arg_514_1.time_ <= 2 + arg_517_0 then
				local var_517_17 = arg_514_1.var_.effect11231

				if not arg_514_1.var_.effect11231 then
					var_517_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in_ui"), manager.ui.mainCamera.transform)
					var_517_17.name = "11231"
					arg_514_1.var_.effect11231 = var_517_17
				else
					var_517_17.transform:SetParent(var_517_9000)
				end

				var_517_17.transform.localPosition = Vector3.New(0, 0, -1.08)
				var_517_17.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_517_19 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_517_2, iter_517_3 in ipairs((var_517_17.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_517_3.transform.localScale = Vector3.New(iter_517_3.transform.localScale.x / var_517_19 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_517_3.transform.localScale.y / var_517_19, iter_517_3.transform.localScale.z)
				end
			end

			if arg_514_1.frameCnt_ <= 1 then
				arg_514_1.dialog_:SetActive(false)
			end

			local var_517_21 = 4
			local var_517_22 = 0.475

			if 4 < arg_514_1.time_ and arg_514_1.time_ <= var_517_21 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0

				arg_514_1.dialog_:SetActive(true)

				arg_514_1.dialogCg_.alpha = 0

				local var_517_23 = LeanTween.value(arg_514_1.dialog_, 0, 1, 0.3)

				var_517_23:setOnUpdate(LuaHelper.FloatAction(function(arg_518_0)
					arg_514_1.dialogCg_.alpha = arg_518_0
				end))
				var_517_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_514_1.dialog_)
					var_517_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_514_1.duration_ = arg_514_1.duration_ + 0.3

				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_24 = arg_514_1:GetWordFromCfg(417231123)
				local var_517_25 = arg_514_1:FormatText(var_517_24.content)

				arg_514_1.text_.text = var_517_25

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_27 = 19 <= 0 and var_517_22 or var_517_22 * (utf8.len(var_517_25) / 19)

				if (19 <= 0 and var_517_22 or var_517_22 * (utf8.len(var_517_25) / 19)) > 0 and var_517_22 < var_517_27 then
					arg_514_1.talkMaxDuration = var_517_27
					var_517_21 = var_517_21 + 0.3

					if var_517_27 + var_517_21 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_27 + var_517_21
					end
				end

				arg_514_1.text_.text = var_517_25
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231123", "story_v_out_417231.awb") ~= 0 then
					local var_517_28 = manager.audio:GetVoiceLength("story_v_out_417231", "417231123", "story_v_out_417231.awb") / 1000

					if var_517_28 + var_517_21 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_28 + var_517_21
					end

					if var_517_24.prefab_name ~= "" and arg_514_1.actors_[var_517_24.prefab_name] ~= nil then
						local var_517_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_24.prefab_name].transform, "story_v_out_417231", "417231123", "story_v_out_417231.awb")

						arg_514_1:RecordAudio("417231123", var_517_29)
						arg_514_1:RecordAudio("417231123", var_517_29)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_417231", "417231123", "story_v_out_417231.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_417231", "417231123", "story_v_out_417231.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_30 = var_517_21 + 0.3
			local var_517_31 = math.max(var_517_22, arg_514_1.talkMaxDuration)

			if var_517_21 + 0.3 <= arg_514_1.time_ and arg_514_1.time_ < var_517_30 + var_517_31 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_30) / var_517_31

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_30 + var_517_31 and arg_514_1.time_ < var_517_30 + var_517_31 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1708",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0666666666666668,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1708",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.93333333333333,
				className = "StoryMoveNode",
				startTime = 2.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play417231124 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 417231124
		arg_520_1.duration_ = 5.8

		local var_520_0 = {
			zh = 5.1,
			ja = 5.8
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play417231125(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0.8

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, true)
				arg_520_1.iconController_:SetSelectedState("hero")

				arg_520_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_520_1.callingController_:SetSelectedState("normal")

				arg_520_1.keyicon_.color = Color.New(1, 1, 1)
				arg_520_1.icon_.color = Color.New(1, 1, 1)

				local var_523_1 = arg_520_1:GetWordFromCfg(417231124)
				local var_523_2 = arg_520_1:FormatText(var_523_1.content)

				arg_520_1.text_.text = var_523_2

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_4 = 8 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_2) / 8)

				if (8 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_2) / 8)) > 0 and var_523_0 < var_523_4 then
					arg_520_1.talkMaxDuration = var_523_4

					if var_523_4 + 0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_4 + 0
					end
				end

				arg_520_1.text_.text = var_523_2
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231124", "story_v_out_417231.awb") ~= 0 then
					local var_523_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231124", "story_v_out_417231.awb") / 1000

					if var_523_5 + 0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_5 + 0
					end

					if var_523_1.prefab_name ~= "" and arg_520_1.actors_[var_523_1.prefab_name] ~= nil then
						local var_523_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_1.prefab_name].transform, "story_v_out_417231", "417231124", "story_v_out_417231.awb")

						arg_520_1:RecordAudio("417231124", var_523_6)
						arg_520_1:RecordAudio("417231124", var_523_6)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_out_417231", "417231124", "story_v_out_417231.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_out_417231", "417231124", "story_v_out_417231.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_7 = math.max(var_523_0, arg_520_1.talkMaxDuration)

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_7 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - 0) / var_523_7

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= 0 + var_523_7 and arg_520_1.time_ < 0 + var_523_7 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play417231125 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 417231125
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play417231126(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0.02 < arg_524_1.time_ and arg_524_1.time_ <= 0.02 + arg_527_0 then
				arg_524_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_cardoor02", "")
			end

			local var_527_1 = 0
			local var_527_2 = 1.075

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_3 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(417231125).content)

				arg_524_1.text_.text = var_527_3

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_5 = 47 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_3) / 47)

				if (47 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_3) / 47)) > 0 and var_527_2 < var_527_5 then
					arg_524_1.talkMaxDuration = var_527_5

					if var_527_5 + var_527_1 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_5 + var_527_1
					end
				end

				arg_524_1.text_.text = var_527_3
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_6 = math.max(var_527_2, arg_524_1.talkMaxDuration)

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_6 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_1) / var_527_6

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_1 + var_527_6 and arg_524_1.time_ < var_527_1 + var_527_6 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play417231126 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 417231126
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play417231127(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0.775

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, false)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_1 = arg_528_1:FormatText(arg_528_1:GetWordFromCfg(417231126).content)

				arg_528_1.text_.text = var_531_1

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_3 = 32 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 32)

				if (32 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_1) / 32)) > 0 and var_531_0 < var_531_3 then
					arg_528_1.talkMaxDuration = var_531_3

					if var_531_3 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_3 + 0
					end
				end

				arg_528_1.text_.text = var_531_1
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_4 = math.max(var_531_0, arg_528_1.talkMaxDuration)

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_4 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - 0) / var_531_4

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= 0 + var_531_4 and arg_528_1.time_ < 0 + var_531_4 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play417231127 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 417231127
		arg_532_1.duration_ = 10.17

		local var_532_0 = {
			zh = 8.533,
			ja = 10.166
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play417231128(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0.8

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_1 = arg_532_1:GetWordFromCfg(417231127)
				local var_535_2 = arg_532_1:FormatText(var_535_1.content)

				arg_532_1.text_.text = var_535_2

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_4 = 43 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_2) / 43)

				if (43 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_2) / 43)) > 0 and var_535_0 < var_535_4 then
					arg_532_1.talkMaxDuration = var_535_4

					if var_535_4 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_4 + 0
					end
				end

				arg_532_1.text_.text = var_535_2
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231127", "story_v_out_417231.awb") ~= 0 then
					local var_535_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231127", "story_v_out_417231.awb") / 1000

					if var_535_5 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_5 + 0
					end

					if var_535_1.prefab_name ~= "" and arg_532_1.actors_[var_535_1.prefab_name] ~= nil then
						local var_535_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_1.prefab_name].transform, "story_v_out_417231", "417231127", "story_v_out_417231.awb")

						arg_532_1:RecordAudio("417231127", var_535_6)
						arg_532_1:RecordAudio("417231127", var_535_6)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_out_417231", "417231127", "story_v_out_417231.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_out_417231", "417231127", "story_v_out_417231.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_7 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_7 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_7

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_7 and arg_532_1.time_ < 0 + var_535_7 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play417231128 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 417231128
		arg_536_1.duration_ = 10.23

		local var_536_0 = {
			zh = 6.8,
			ja = 10.233
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play417231129(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0.9

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_1 = arg_536_1:GetWordFromCfg(417231128)
				local var_539_2 = arg_536_1:FormatText(var_539_1.content)

				arg_536_1.text_.text = var_539_2

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_4 = 31 <= 0 and var_539_0 or var_539_0 * (utf8.len(var_539_2) / 31)

				if (31 <= 0 and var_539_0 or var_539_0 * (utf8.len(var_539_2) / 31)) > 0 and var_539_0 < var_539_4 then
					arg_536_1.talkMaxDuration = var_539_4

					if var_539_4 + 0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_4 + 0
					end
				end

				arg_536_1.text_.text = var_539_2
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231128", "story_v_out_417231.awb") ~= 0 then
					local var_539_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231128", "story_v_out_417231.awb") / 1000

					if var_539_5 + 0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_5 + 0
					end

					if var_539_1.prefab_name ~= "" and arg_536_1.actors_[var_539_1.prefab_name] ~= nil then
						local var_539_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_1.prefab_name].transform, "story_v_out_417231", "417231128", "story_v_out_417231.awb")

						arg_536_1:RecordAudio("417231128", var_539_6)
						arg_536_1:RecordAudio("417231128", var_539_6)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_out_417231", "417231128", "story_v_out_417231.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_out_417231", "417231128", "story_v_out_417231.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_7 = math.max(var_539_0, arg_536_1.talkMaxDuration)

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_7 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - 0) / var_539_7

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= 0 + var_539_7 and arg_536_1.time_ < 0 + var_539_7 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play417231129 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 417231129
		arg_540_1.duration_ = 10.3

		local var_540_0 = {
			zh = 5.5,
			ja = 10.3
		}
		local var_540_1 = manager.audio:GetLocalizationFlag()

		if var_540_0[var_540_1] ~= nil then
			arg_540_1.duration_ = var_540_0[var_540_1]
		end

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play417231130(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0.75

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10128_split_1")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_1 = arg_540_1:GetWordFromCfg(417231129)
				local var_543_2 = arg_540_1:FormatText(var_543_1.content)

				arg_540_1.text_.text = var_543_2

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_4 = 32 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_2) / 32)

				if (32 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_2) / 32)) > 0 and var_543_0 < var_543_4 then
					arg_540_1.talkMaxDuration = var_543_4

					if var_543_4 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_4 + 0
					end
				end

				arg_540_1.text_.text = var_543_2
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231129", "story_v_out_417231.awb") ~= 0 then
					local var_543_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231129", "story_v_out_417231.awb") / 1000

					if var_543_5 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_5 + 0
					end

					if var_543_1.prefab_name ~= "" and arg_540_1.actors_[var_543_1.prefab_name] ~= nil then
						local var_543_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_1.prefab_name].transform, "story_v_out_417231", "417231129", "story_v_out_417231.awb")

						arg_540_1:RecordAudio("417231129", var_543_6)
						arg_540_1:RecordAudio("417231129", var_543_6)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_417231", "417231129", "story_v_out_417231.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_417231", "417231129", "story_v_out_417231.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_7 = math.max(var_543_0, arg_540_1.talkMaxDuration)

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_7 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - 0) / var_543_7

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= 0 + var_543_7 and arg_540_1.time_ < 0 + var_543_7 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play417231130 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 417231130
		arg_544_1.duration_ = 8.97

		local var_544_0 = {
			zh = 8.966,
			ja = 7.6
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play417231131(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0.45

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_1 = arg_544_1:GetWordFromCfg(417231130)
				local var_547_2 = arg_544_1:FormatText(var_547_1.content)

				arg_544_1.text_.text = var_547_2

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_4 = 36 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_2) / 36)

				if (36 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_2) / 36)) > 0 and var_547_0 < var_547_4 then
					arg_544_1.talkMaxDuration = var_547_4

					if var_547_4 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_4 + 0
					end
				end

				arg_544_1.text_.text = var_547_2
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231130", "story_v_out_417231.awb") ~= 0 then
					local var_547_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231130", "story_v_out_417231.awb") / 1000

					if var_547_5 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_5 + 0
					end

					if var_547_1.prefab_name ~= "" and arg_544_1.actors_[var_547_1.prefab_name] ~= nil then
						local var_547_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_1.prefab_name].transform, "story_v_out_417231", "417231130", "story_v_out_417231.awb")

						arg_544_1:RecordAudio("417231130", var_547_6)
						arg_544_1:RecordAudio("417231130", var_547_6)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_417231", "417231130", "story_v_out_417231.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_417231", "417231130", "story_v_out_417231.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_7 = math.max(var_547_0, arg_544_1.talkMaxDuration)

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_7 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - 0) / var_547_7

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= 0 + var_547_7 and arg_544_1.time_ < 0 + var_547_7 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play417231131 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 417231131
		arg_548_1.duration_ = 7.3

		local var_548_0 = {
			zh = 5.933,
			ja = 7.3
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play417231132(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0.275

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_1 = arg_548_1:GetWordFromCfg(417231131)
				local var_551_2 = arg_548_1:FormatText(var_551_1.content)

				arg_548_1.text_.text = var_551_2

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_4 = 30 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_2) / 30)

				if (30 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_2) / 30)) > 0 and var_551_0 < var_551_4 then
					arg_548_1.talkMaxDuration = var_551_4

					if var_551_4 + 0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_4 + 0
					end
				end

				arg_548_1.text_.text = var_551_2
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231131", "story_v_out_417231.awb") ~= 0 then
					local var_551_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231131", "story_v_out_417231.awb") / 1000

					if var_551_5 + 0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_5 + 0
					end

					if var_551_1.prefab_name ~= "" and arg_548_1.actors_[var_551_1.prefab_name] ~= nil then
						local var_551_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_1.prefab_name].transform, "story_v_out_417231", "417231131", "story_v_out_417231.awb")

						arg_548_1:RecordAudio("417231131", var_551_6)
						arg_548_1:RecordAudio("417231131", var_551_6)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_out_417231", "417231131", "story_v_out_417231.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_out_417231", "417231131", "story_v_out_417231.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_7 = math.max(var_551_0, arg_548_1.talkMaxDuration)

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_7 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - 0) / var_551_7

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= 0 + var_551_7 and arg_548_1.time_ < 0 + var_551_7 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play417231132 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 417231132
		arg_552_1.duration_ = 3.8

		local var_552_0 = {
			zh = 3.8,
			ja = 3.633
		}
		local var_552_1 = manager.audio:GetLocalizationFlag()

		if var_552_0[var_552_1] ~= nil then
			arg_552_1.duration_ = var_552_0[var_552_1]
		end

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play417231133(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0.45

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, false)
				arg_552_1.callingController_:SetSelectedState("normal")

				local var_555_1 = arg_552_1:GetWordFromCfg(417231132)
				local var_555_2 = arg_552_1:FormatText(var_555_1.content)

				arg_552_1.text_.text = var_555_2

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_4 = 18 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 18)

				if (18 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 18)) > 0 and var_555_0 < var_555_4 then
					arg_552_1.talkMaxDuration = var_555_4

					if var_555_4 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_4 + 0
					end
				end

				arg_552_1.text_.text = var_555_2
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231132", "story_v_out_417231.awb") ~= 0 then
					local var_555_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231132", "story_v_out_417231.awb") / 1000

					if var_555_5 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_5 + 0
					end

					if var_555_1.prefab_name ~= "" and arg_552_1.actors_[var_555_1.prefab_name] ~= nil then
						local var_555_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_1.prefab_name].transform, "story_v_out_417231", "417231132", "story_v_out_417231.awb")

						arg_552_1:RecordAudio("417231132", var_555_6)
						arg_552_1:RecordAudio("417231132", var_555_6)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_out_417231", "417231132", "story_v_out_417231.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_out_417231", "417231132", "story_v_out_417231.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_7 = math.max(var_555_0, arg_552_1.talkMaxDuration)

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_7 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - 0) / var_555_7

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= 0 + var_555_7 and arg_552_1.time_ < 0 + var_555_7 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play417231133 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 417231133
		arg_556_1.duration_ = 3.93

		local var_556_0 = {
			zh = 2.866,
			ja = 3.933
		}
		local var_556_1 = manager.audio:GetLocalizationFlag()

		if var_556_0[var_556_1] ~= nil then
			arg_556_1.duration_ = var_556_0[var_556_1]
		end

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
			arg_556_1.auto_ = false
		end

		function arg_556_1.playNext_(arg_558_0)
			arg_556_1.onStoryFinished_()
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0.275

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, true)

				arg_556_1.leftNameTxt_.text = arg_556_1:FormatText(StoryNameCfg[1125].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_556_1.leftNameTxt_.transform)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1.leftNameTxt_.text)
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_1 = arg_556_1:GetWordFromCfg(417231133)
				local var_559_2 = arg_556_1:FormatText(var_559_1.content)

				arg_556_1.text_.text = var_559_2

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_4 = 11 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_2) / 11)

				if (11 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_2) / 11)) > 0 and var_559_0 < var_559_4 then
					arg_556_1.talkMaxDuration = var_559_4

					if var_559_4 + 0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_4 + 0
					end
				end

				arg_556_1.text_.text = var_559_2
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417231", "417231133", "story_v_out_417231.awb") ~= 0 then
					local var_559_5 = manager.audio:GetVoiceLength("story_v_out_417231", "417231133", "story_v_out_417231.awb") / 1000

					if var_559_5 + 0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_5 + 0
					end

					if var_559_1.prefab_name ~= "" and arg_556_1.actors_[var_559_1.prefab_name] ~= nil then
						local var_559_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_556_1.actors_[var_559_1.prefab_name].transform, "story_v_out_417231", "417231133", "story_v_out_417231.awb")

						arg_556_1:RecordAudio("417231133", var_559_6)
						arg_556_1:RecordAudio("417231133", var_559_6)
					else
						arg_556_1:AudioAction("play", "voice", "story_v_out_417231", "417231133", "story_v_out_417231.awb")
					end

					arg_556_1:RecordHistoryTalkVoice("story_v_out_417231", "417231133", "story_v_out_417231.awb")
				end

				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_7 = math.max(var_559_0, arg_556_1.talkMaxDuration)

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_7 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - 0) / var_559_7

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= 0 + var_559_7 and arg_556_1.time_ < 0 + var_559_7 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST75",
		"TextureConfig/Background/I11l",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/ST2102",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SS1708"
	},
	voices = {
		"story_v_out_417231.awb"
	}
}
