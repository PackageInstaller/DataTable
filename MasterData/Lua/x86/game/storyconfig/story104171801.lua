return {
	Play417181001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417181001
		arg_1_1.duration_ = 8.87

		local var_1_0 = {
			zh = 8.766,
			ja = 8.866
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
				arg_1_0:Play417181002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B01")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501057).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501058).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= 0 + 5 and arg_1_1.time_ < 0 + 5 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_0 = 5

			if 5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_1 = 1.2

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_1 then
				local var_4_2 = Color.New(0, 0, 0)

				var_4_2.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_0) / var_4_1)
				arg_1_1.mask_.color = var_4_2
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = 1
				arg_1_1.mask_.color = var_4_3
			end

			local var_4_4 = 6.2

			if 6.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 1.2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = "B01"

			if arg_1_1.bgs_.B01 == nil then
				local var_4_9 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_8)
				var_4_9.name = var_4_8
				var_4_9.transform.parent = arg_1_1.stage_.transform
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_8] = var_4_9
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_10 = arg_1_1.bgs_.B01

				arg_1_1.bgs_.B01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_11 = var_4_10:GetComponent("SpriteRenderer")

				if var_4_11 and var_4_11.sprite then
					local var_4_12 = 2 * (var_4_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_10.transform.localScale = Vector3.New(var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, var_4_12 / var_4_11.sprite.bounds.size.y < var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x and var_4_12 * manager.ui.mainCameraCom_.aspect / var_4_11.sprite.bounds.size.x or var_4_12 / var_4_11.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B01" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_13 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_13 + 5 and arg_1_1.time_ < var_4_13 + 5 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_14 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_15 = 1

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 5.83333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 5.83333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			local var_4_24 = 7.4
			local var_4_25 = 0.133333333333334

			if 7.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1147].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_27 = arg_1_1:GetWordFromCfg(417181001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 3 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 3)

				if (3 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 3)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181001", "story_v_out_417181.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_417181", "417181001", "story_v_out_417181.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_417181", "417181001", "story_v_out_417181.awb")

						arg_1_1:RecordAudio("417181001", var_4_32)
						arg_1_1:RecordAudio("417181001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417181", "417181001", "story_v_out_417181.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417181", "417181001", "story_v_out_417181.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
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
	Play417181002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417181002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417181003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0.566666666666667 < arg_10_1.time_ and arg_10_1.time_ <= 0.566666666666667 + arg_13_0 then
				arg_10_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_gun01", "")
			end

			local var_13_1 = 0
			local var_13_2 = 1.1

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

				local var_13_3 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(417181002).content)

				arg_10_1.text_.text = var_13_3

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_5 = 44 <= 0 and var_13_2 or var_13_2 * (utf8.len(var_13_3) / 44)

				if (44 <= 0 and var_13_2 or var_13_2 * (utf8.len(var_13_3) / 44)) > 0 and var_13_2 < var_13_5 then
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
	Play417181003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417181003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417181004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0.7

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

				local var_17_1 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(417181003).content)

				arg_14_1.text_.text = var_17_1

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_3 = 28 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 28)

				if (28 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 28)) > 0 and var_17_0 < var_17_3 then
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
	Play417181004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417181004
		arg_18_1.duration_ = 6.1

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417181005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_21_0 = 0.4

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 then
				local var_21_1, var_21_2 = math.modf((arg_18_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_21_2 * 0.13, var_21_2 * 0.13, var_21_2 * 0.13) + arg_18_1.var_.shakeOldPos
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 then
				manager.ui.mainCamera.transform.localPosition = arg_18_1.var_.shakeOldPos
			end

			local var_21_3 = manager.ui.mainCamera.transform

			if 0.533333333333333 < arg_18_1.time_ and arg_18_1.time_ <= 0.533333333333333 + arg_21_0 then
				arg_18_1.var_.shakeOldPos = var_21_3.localPosition
			end

			local var_21_4 = 0.4

			if 0.533333333333333 <= arg_18_1.time_ and arg_18_1.time_ < 0.533333333333333 + var_21_4 then
				local var_21_5, var_21_6 = math.modf((arg_18_1.time_ - 0.533333333333333) / 0.066)

				var_21_3.localPosition = Vector3.New(var_21_6 * 0.13, var_21_6 * 0.13, var_21_6 * 0.13) + arg_18_1.var_.shakeOldPos
			end

			if arg_18_1.time_ >= 0.533333333333333 + var_21_4 and arg_18_1.time_ < 0.533333333333333 + var_21_4 + arg_21_0 then
				var_21_3.localPosition = arg_18_1.var_.shakeOldPos
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_attack03", "")
			end

			if arg_18_1.frameCnt_ <= 1 then
				arg_18_1.dialog_:SetActive(false)
			end

			local var_21_8 = 1.1
			local var_21_9 = 1.55

			if 1.1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_8 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				arg_18_1.dialog_:SetActive(true)

				arg_18_1.dialogCg_.alpha = 0

				local var_21_10 = LeanTween.value(arg_18_1.dialog_, 0, 1, 0.3)

				var_21_10:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_18_1.dialogCg_.alpha = arg_22_0
				end))
				var_21_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_18_1.dialog_)
					var_21_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_18_1.duration_ = arg_18_1.duration_ + 0.3

				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_11 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(417181004).content)

				arg_18_1.text_.text = var_21_11

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_13 = 62 <= 0 and var_21_9 or var_21_9 * (utf8.len(var_21_11) / 62)

				if (62 <= 0 and var_21_9 or var_21_9 * (utf8.len(var_21_11) / 62)) > 0 and var_21_9 < var_21_13 then
					arg_18_1.talkMaxDuration = var_21_13
					var_21_8 = var_21_8 + 0.3

					if var_21_13 + var_21_8 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_13 + var_21_8
					end
				end

				arg_18_1.text_.text = var_21_11
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_14 = var_21_8 + 0.3
			local var_21_15 = math.max(var_21_9, arg_18_1.talkMaxDuration)

			if var_21_8 + 0.3 <= arg_18_1.time_ and arg_18_1.time_ < var_21_14 + var_21_15 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_14) / var_21_15

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_14 + var_21_15 and arg_18_1.time_ < var_21_14 + var_21_15 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417181005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 417181005
		arg_24_1.duration_ = 7.13

		local var_24_0 = {
			zh = 7.133,
			ja = 6
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play417181006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.266666666666667

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1147].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(417181005)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 12 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 12)

				if (12 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 12)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181005", "story_v_out_417181.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_417181", "417181005", "story_v_out_417181.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_417181", "417181005", "story_v_out_417181.awb")

						arg_24_1:RecordAudio("417181005", var_27_6)
						arg_24_1:RecordAudio("417181005", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_417181", "417181005", "story_v_out_417181.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_417181", "417181005", "story_v_out_417181.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play417181006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 417181006
		arg_28_1.duration_ = 6.83

		local var_28_0 = {
			zh = 6.466,
			ja = 6.833
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play417181007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.475

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1147].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:GetWordFromCfg(417181006)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 19 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 19)

				if (19 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 19)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181006", "story_v_out_417181.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_417181", "417181006", "story_v_out_417181.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_417181", "417181006", "story_v_out_417181.awb")

						arg_28_1:RecordAudio("417181006", var_31_6)
						arg_28_1:RecordAudio("417181006", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_417181", "417181006", "story_v_out_417181.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_417181", "417181006", "story_v_out_417181.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play417181007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 417181007
		arg_32_1.duration_ = 4.43

		local var_32_0 = {
			zh = 3.833,
			ja = 4.433
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
				arg_32_0:Play417181008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.actors_["10128"] == nil then
				local var_35_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_35_0) then
					local var_35_1 = Object.Instantiate(var_35_0, arg_32_1.canvasGo_.transform)

					var_35_1.transform:SetSiblingIndex(1)

					var_35_1.name = "10128"
					var_35_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_32_1.actors_["10128"] = var_35_1

					if arg_32_1.isInRecall_ then
						for iter_35_0, iter_35_1 in ipairs((var_35_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_35_1.color = arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_35_2 = arg_32_1.actors_["10128"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps10128 == nil then
				arg_32_1.var_.actorSpriteComps10128 = var_35_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_3 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.actorSpriteComps10128 then
					for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_35_3 then
							if arg_32_1.isInRecall_ then
								iter_35_3.color = Color.New(Mathf.Lerp(iter_35_3.color.r, arg_32_1.hightColor1.r, (arg_32_1.time_ - 0) / var_35_3), Mathf.Lerp(iter_35_3.color.g, arg_32_1.hightColor1.g, (arg_32_1.time_ - 0) / var_35_3), (Mathf.Lerp(iter_35_3.color.b, arg_32_1.hightColor1.b, (arg_32_1.time_ - 0) / var_35_3)))
							else
								local var_35_4 = Mathf.Lerp(iter_35_3.color.r, 1, (arg_32_1.time_ - 0) / var_35_3)

								iter_35_3.color = Color.New(var_35_4, var_35_4, var_35_4)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.actorSpriteComps10128 then
				for iter_35_4, iter_35_5 in pairs(arg_32_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_35_5 then
						iter_35_5.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_32_1.var_.actorSpriteComps10128 = nil
			end

			local var_35_5 = arg_32_1.actors_["10128"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10128 = var_35_5.localPosition
				var_35_5.localScale = Vector3.New(1, 1, 1)

				arg_32_1:CheckSpriteTmpPos("10128", 3)

				for iter_35_6 = 0, var_35_5.childCount - 1 do
					local var_35_6 = var_35_5:GetChild(iter_35_6)

					if var_35_6.name == "split_6" or not string.find(var_35_6.name, "split") then
						var_35_6.gameObject:SetActive(true)
					else
						var_35_6.gameObject:SetActive(false)
					end
				end
			end

			local var_35_7 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_32_1.time_ - 0) / var_35_7)
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(0, -347, -300)
			end

			local var_35_8 = 0
			local var_35_9 = 0.525

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_10 = arg_32_1:GetWordFromCfg(417181007)
				local var_35_11 = arg_32_1:FormatText(var_35_10.content)

				arg_32_1.text_.text = var_35_11

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 21 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 21)

				if (21 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_11) / 21)) > 0 and var_35_9 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_8
					end
				end

				arg_32_1.text_.text = var_35_11
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181007", "story_v_out_417181.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_out_417181", "417181007", "story_v_out_417181.awb") / 1000

					if var_35_14 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_8
					end

					if var_35_10.prefab_name ~= "" and arg_32_1.actors_[var_35_10.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_10.prefab_name].transform, "story_v_out_417181", "417181007", "story_v_out_417181.awb")

						arg_32_1:RecordAudio("417181007", var_35_15)
						arg_32_1:RecordAudio("417181007", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_417181", "417181007", "story_v_out_417181.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_417181", "417181007", "story_v_out_417181.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_9, arg_32_1.talkMaxDuration)

			if var_35_8 <= arg_32_1.time_ and arg_32_1.time_ < var_35_8 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_8) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_8 + var_35_16 and arg_32_1.time_ < var_35_8 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play417181008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 417181008
		arg_36_1.duration_ = 9.4

		local var_36_0 = {
			zh = 3.733,
			ja = 9.4
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
				arg_36_0:Play417181009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["10128"]) and arg_36_1.var_.actorSpriteComps10128 == nil then
				arg_36_1.var_.actorSpriteComps10128 = arg_36_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["10128"]) then
				if arg_36_1.var_.actorSpriteComps10128 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_39_1 then
							if arg_36_1.isInRecall_ then
								iter_39_1.color = Color.New(Mathf.Lerp(iter_39_1.color.r, arg_36_1.hightColor2.r, (arg_36_1.time_ - 0) / var_39_0), Mathf.Lerp(iter_39_1.color.g, arg_36_1.hightColor2.g, (arg_36_1.time_ - 0) / var_39_0), (Mathf.Lerp(iter_39_1.color.b, arg_36_1.hightColor2.b, (arg_36_1.time_ - 0) / var_39_0)))
							else
								local var_39_1 = Mathf.Lerp(iter_39_1.color.r, 0.5, (arg_36_1.time_ - 0) / var_39_0)

								iter_39_1.color = Color.New(var_39_1, var_39_1, var_39_1)
							end
						end
					end
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["10128"]) and arg_36_1.var_.actorSpriteComps10128 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_39_3 then
						iter_39_3.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_36_1.var_.actorSpriteComps10128 = nil
			end

			local var_39_2 = arg_36_1.actors_["10128"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10128 = var_39_2.localPosition
				var_39_2.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("10128", 7)

				for iter_39_4 = 0, var_39_2.childCount - 1 do
					local var_39_3 = var_39_2:GetChild(iter_39_4)

					if var_39_3.name == "" or not string.find(var_39_3.name, "split") then
						var_39_3.gameObject:SetActive(true)
					else
						var_39_3.gameObject:SetActive(false)
					end
				end
			end

			local var_39_4 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				var_39_2.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_36_1.time_ - 0) / var_39_4)
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				var_39_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_39_5 = 0
			local var_39_6 = 0.525

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1147].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_7 = arg_36_1:GetWordFromCfg(417181008)
				local var_39_8 = arg_36_1:FormatText(var_39_7.content)

				arg_36_1.text_.text = var_39_8

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_10 = 21 <= 0 and var_39_6 or var_39_6 * (utf8.len(var_39_8) / 21)

				if (21 <= 0 and var_39_6 or var_39_6 * (utf8.len(var_39_8) / 21)) > 0 and var_39_6 < var_39_10 then
					arg_36_1.talkMaxDuration = var_39_10

					if var_39_10 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_5
					end
				end

				arg_36_1.text_.text = var_39_8
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181008", "story_v_out_417181.awb") ~= 0 then
					local var_39_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181008", "story_v_out_417181.awb") / 1000

					if var_39_11 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_11 + var_39_5
					end

					if var_39_7.prefab_name ~= "" and arg_36_1.actors_[var_39_7.prefab_name] ~= nil then
						local var_39_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_7.prefab_name].transform, "story_v_out_417181", "417181008", "story_v_out_417181.awb")

						arg_36_1:RecordAudio("417181008", var_39_12)
						arg_36_1:RecordAudio("417181008", var_39_12)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_417181", "417181008", "story_v_out_417181.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_417181", "417181008", "story_v_out_417181.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_13 = math.max(var_39_6, arg_36_1.talkMaxDuration)

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_13 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_5) / var_39_13

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_5 + var_39_13 and arg_36_1.time_ < var_39_5 + var_39_13 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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

		arg_36_1:InitPlayNodeList()
	end,
	Play417181009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 417181009
		arg_40_1.duration_ = 9.2

		local var_40_0 = {
			zh = 9.033,
			ja = 9.2
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
				arg_40_0:Play417181010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.775

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1147].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:GetWordFromCfg(417181009)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 31 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 31)

				if (31 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 31)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181009", "story_v_out_417181.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_417181", "417181009", "story_v_out_417181.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_417181", "417181009", "story_v_out_417181.awb")

						arg_40_1:RecordAudio("417181009", var_43_6)
						arg_40_1:RecordAudio("417181009", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_417181", "417181009", "story_v_out_417181.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_417181", "417181009", "story_v_out_417181.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play417181010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 417181010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play417181011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_drop", "")
			end

			if 0.3 < arg_44_1.time_ and arg_44_1.time_ <= 0.3 + arg_47_0 then
				arg_44_1:AudioAction("play", "effect", "se_story", "se_story_alarmloop", "")
			end

			local var_47_2 = 0
			local var_47_3 = 1

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(417181010).content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_6 = 40 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_4) / 40)

				if (40 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_4) / 40)) > 0 and var_47_3 < var_47_6 then
					arg_44_1.talkMaxDuration = var_47_6

					if var_47_6 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_7 and arg_44_1.time_ < var_47_2 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play417181011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 417181011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play417181012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 1.475

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(417181011).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 59 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 59)

				if (59 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 59)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play417181012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 417181012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play417181013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.95

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(417181012).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 38 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 38)

				if (38 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 38)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play417181013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 417181013
		arg_56_1.duration_ = 7.97

		local var_56_0 = {
			zh = 7.966,
			ja = 7.633
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
				arg_56_0:Play417181014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.7

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1147].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_1 = arg_56_1:GetWordFromCfg(417181013)
				local var_59_2 = arg_56_1:FormatText(var_59_1.content)

				arg_56_1.text_.text = var_59_2

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 28 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 28)

				if (28 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 28)) > 0 and var_59_0 < var_59_4 then
					arg_56_1.talkMaxDuration = var_59_4

					if var_59_4 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_4 + 0
					end
				end

				arg_56_1.text_.text = var_59_2
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181013", "story_v_out_417181.awb") ~= 0 then
					local var_59_5 = manager.audio:GetVoiceLength("story_v_out_417181", "417181013", "story_v_out_417181.awb") / 1000

					if var_59_5 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + 0
					end

					if var_59_1.prefab_name ~= "" and arg_56_1.actors_[var_59_1.prefab_name] ~= nil then
						local var_59_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_1.prefab_name].transform, "story_v_out_417181", "417181013", "story_v_out_417181.awb")

						arg_56_1:RecordAudio("417181013", var_59_6)
						arg_56_1:RecordAudio("417181013", var_59_6)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_417181", "417181013", "story_v_out_417181.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_417181", "417181013", "story_v_out_417181.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play417181014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 417181014
		arg_60_1.duration_ = 8.23

		local var_60_0 = {
			zh = 4.966,
			ja = 8.233
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
				arg_60_0:Play417181015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["10128"]) and arg_60_1.var_.actorSpriteComps10128 == nil then
				arg_60_1.var_.actorSpriteComps10128 = arg_60_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["10128"]) then
				if arg_60_1.var_.actorSpriteComps10128 then
					for iter_63_0, iter_63_1 in pairs(arg_60_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_63_1 then
							if arg_60_1.isInRecall_ then
								iter_63_1.color = Color.New(Mathf.Lerp(iter_63_1.color.r, arg_60_1.hightColor1.r, (arg_60_1.time_ - 0) / var_63_0), Mathf.Lerp(iter_63_1.color.g, arg_60_1.hightColor1.g, (arg_60_1.time_ - 0) / var_63_0), (Mathf.Lerp(iter_63_1.color.b, arg_60_1.hightColor1.b, (arg_60_1.time_ - 0) / var_63_0)))
							else
								local var_63_1 = Mathf.Lerp(iter_63_1.color.r, 1, (arg_60_1.time_ - 0) / var_63_0)

								iter_63_1.color = Color.New(var_63_1, var_63_1, var_63_1)
							end
						end
					end
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["10128"]) and arg_60_1.var_.actorSpriteComps10128 then
				for iter_63_2, iter_63_3 in pairs(arg_60_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_63_3 then
						iter_63_3.color = arg_60_1.isInRecall_ and (arg_60_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_60_1.var_.actorSpriteComps10128 = nil
			end

			local var_63_2 = arg_60_1.actors_["10128"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos10128 = var_63_2.localPosition
				var_63_2.localScale = Vector3.New(1, 1, 1)

				arg_60_1:CheckSpriteTmpPos("10128", 3)

				for iter_63_4 = 0, var_63_2.childCount - 1 do
					local var_63_3 = var_63_2:GetChild(iter_63_4)

					if var_63_3.name == "" or not string.find(var_63_3.name, "split") then
						var_63_3.gameObject:SetActive(true)
					else
						var_63_3.gameObject:SetActive(false)
					end
				end
			end

			local var_63_4 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				var_63_2.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_60_1.time_ - 0) / var_63_4)
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				var_63_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_63_5 = 0
			local var_63_6 = 0.55

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_7 = arg_60_1:GetWordFromCfg(417181014)
				local var_63_8 = arg_60_1:FormatText(var_63_7.content)

				arg_60_1.text_.text = var_63_8

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_10 = 22 <= 0 and var_63_6 or var_63_6 * (utf8.len(var_63_8) / 22)

				if (22 <= 0 and var_63_6 or var_63_6 * (utf8.len(var_63_8) / 22)) > 0 and var_63_6 < var_63_10 then
					arg_60_1.talkMaxDuration = var_63_10

					if var_63_10 + var_63_5 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_5
					end
				end

				arg_60_1.text_.text = var_63_8
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181014", "story_v_out_417181.awb") ~= 0 then
					local var_63_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181014", "story_v_out_417181.awb") / 1000

					if var_63_11 + var_63_5 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_5
					end

					if var_63_7.prefab_name ~= "" and arg_60_1.actors_[var_63_7.prefab_name] ~= nil then
						local var_63_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_7.prefab_name].transform, "story_v_out_417181", "417181014", "story_v_out_417181.awb")

						arg_60_1:RecordAudio("417181014", var_63_12)
						arg_60_1:RecordAudio("417181014", var_63_12)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_417181", "417181014", "story_v_out_417181.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_417181", "417181014", "story_v_out_417181.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_13 = math.max(var_63_6, arg_60_1.talkMaxDuration)

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_13 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_5) / var_63_13

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_5 + var_63_13 and arg_60_1.time_ < var_63_5 + var_63_13 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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

		arg_60_1:InitPlayNodeList()
	end,
	Play417181015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 417181015
		arg_64_1.duration_ = 9

		local var_64_0 = {
			zh = 5.166,
			ja = 9
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
				arg_64_0:Play417181016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos10128 = arg_64_1.actors_["10128"].transform.localPosition
				arg_64_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("10128", 3)

				for iter_67_0 = 0, arg_64_1.actors_["10128"].transform.childCount - 1 do
					local var_67_0 = arg_64_1.actors_["10128"].transform:GetChild(iter_67_0)

					if var_67_0.name == "split_2" or not string.find(var_67_0.name, "split") then
						var_67_0.gameObject:SetActive(true)
					else
						var_67_0.gameObject:SetActive(false)
					end
				end
			end

			local var_67_1 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_1 then
				arg_64_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_64_1.time_ - 0) / var_67_1)
			end

			if arg_64_1.time_ >= 0 + var_67_1 and arg_64_1.time_ < 0 + var_67_1 + arg_67_0 then
				arg_64_1.actors_["10128"].transform.localPosition = Vector3.New(0, -347, -300)
			end

			local var_67_2 = 0
			local var_67_3 = 0.65

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_4 = arg_64_1:GetWordFromCfg(417181015)
				local var_67_5 = arg_64_1:FormatText(var_67_4.content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 26 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 26)

				if (26 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 26)) > 0 and var_67_3 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_2
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181015", "story_v_out_417181.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181015", "story_v_out_417181.awb") / 1000

					if var_67_8 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_2
					end

					if var_67_4.prefab_name ~= "" and arg_64_1.actors_[var_67_4.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_4.prefab_name].transform, "story_v_out_417181", "417181015", "story_v_out_417181.awb")

						arg_64_1:RecordAudio("417181015", var_67_9)
						arg_64_1:RecordAudio("417181015", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_417181", "417181015", "story_v_out_417181.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_417181", "417181015", "story_v_out_417181.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_3, arg_64_1.talkMaxDuration)

			if var_67_2 <= arg_64_1.time_ and arg_64_1.time_ < var_67_2 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_2) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_2 + var_67_10 and arg_64_1.time_ < var_67_2 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play417181016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 417181016
		arg_68_1.duration_ = 4.2

		local var_68_0 = {
			zh = 4.2,
			ja = 2.966
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
				arg_68_0:Play417181017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["10128"]) and arg_68_1.var_.actorSpriteComps10128 == nil then
				arg_68_1.var_.actorSpriteComps10128 = arg_68_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["10128"]) then
				if arg_68_1.var_.actorSpriteComps10128 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								iter_71_1.color = Color.New(Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor2.r, (arg_68_1.time_ - 0) / var_71_0), Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor2.g, (arg_68_1.time_ - 0) / var_71_0), (Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor2.b, (arg_68_1.time_ - 0) / var_71_0)))
							else
								local var_71_1 = Mathf.Lerp(iter_71_1.color.r, 0.5, (arg_68_1.time_ - 0) / var_71_0)

								iter_71_1.color = Color.New(var_71_1, var_71_1, var_71_1)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["10128"]) and arg_68_1.var_.actorSpriteComps10128 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_71_3 then
						iter_71_3.color = arg_68_1.isInRecall_ and (arg_68_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_68_1.var_.actorSpriteComps10128 = nil
			end

			local var_71_2 = arg_68_1.actors_["10128"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos10128 = var_71_2.localPosition
				var_71_2.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10128", 7)

				for iter_71_4 = 0, var_71_2.childCount - 1 do
					local var_71_3 = var_71_2:GetChild(iter_71_4)

					if var_71_3.name == "" or not string.find(var_71_3.name, "split") then
						var_71_3.gameObject:SetActive(true)
					else
						var_71_3.gameObject:SetActive(false)
					end
				end
			end

			local var_71_4 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				var_71_2.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_68_1.time_ - 0) / var_71_4)
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				var_71_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_71_5 = 0
			local var_71_6 = 0.375

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1147].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_7 = arg_68_1:GetWordFromCfg(417181016)
				local var_71_8 = arg_68_1:FormatText(var_71_7.content)

				arg_68_1.text_.text = var_71_8

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_10 = 15 <= 0 and var_71_6 or var_71_6 * (utf8.len(var_71_8) / 15)

				if (15 <= 0 and var_71_6 or var_71_6 * (utf8.len(var_71_8) / 15)) > 0 and var_71_6 < var_71_10 then
					arg_68_1.talkMaxDuration = var_71_10

					if var_71_10 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_5
					end
				end

				arg_68_1.text_.text = var_71_8
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181016", "story_v_out_417181.awb") ~= 0 then
					local var_71_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181016", "story_v_out_417181.awb") / 1000

					if var_71_11 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_11 + var_71_5
					end

					if var_71_7.prefab_name ~= "" and arg_68_1.actors_[var_71_7.prefab_name] ~= nil then
						local var_71_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_7.prefab_name].transform, "story_v_out_417181", "417181016", "story_v_out_417181.awb")

						arg_68_1:RecordAudio("417181016", var_71_12)
						arg_68_1:RecordAudio("417181016", var_71_12)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_417181", "417181016", "story_v_out_417181.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_417181", "417181016", "story_v_out_417181.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_13 = math.max(var_71_6, arg_68_1.talkMaxDuration)

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_13 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_5) / var_71_13

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_5 + var_71_13 and arg_68_1.time_ < var_71_5 + var_71_13 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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

		arg_68_1:InitPlayNodeList()
	end,
	Play417181017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 417181017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play417181018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0.366666666666 < arg_72_1.time_ and arg_72_1.time_ <= 0.366666666666 + arg_75_0 then
				arg_72_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_attack04", "")
			end

			local var_75_1 = 0
			local var_75_2 = 1.175

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(417181017).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 47 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 47)

				if (47 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 47)) > 0 and var_75_2 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_6 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_6 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_6

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_6 and arg_72_1.time_ < var_75_1 + var_75_6 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play417181018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 417181018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play417181019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 1.15

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

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(417181018).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 46 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 46)

				if (46 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 46)) > 0 and var_79_0 < var_79_3 then
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
	Play417181019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 417181019
		arg_80_1.duration_ = 2.5

		local var_80_0 = {
			zh = 2,
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
				arg_80_0:Play417181020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["10128"]) and arg_80_1.var_.actorSpriteComps10128 == nil then
				arg_80_1.var_.actorSpriteComps10128 = arg_80_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_0 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["10128"]) then
				if arg_80_1.var_.actorSpriteComps10128 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_83_1 then
							if arg_80_1.isInRecall_ then
								iter_83_1.color = Color.New(Mathf.Lerp(iter_83_1.color.r, arg_80_1.hightColor1.r, (arg_80_1.time_ - 0) / var_83_0), Mathf.Lerp(iter_83_1.color.g, arg_80_1.hightColor1.g, (arg_80_1.time_ - 0) / var_83_0), (Mathf.Lerp(iter_83_1.color.b, arg_80_1.hightColor1.b, (arg_80_1.time_ - 0) / var_83_0)))
							else
								local var_83_1 = Mathf.Lerp(iter_83_1.color.r, 1, (arg_80_1.time_ - 0) / var_83_0)

								iter_83_1.color = Color.New(var_83_1, var_83_1, var_83_1)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["10128"]) and arg_80_1.var_.actorSpriteComps10128 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_83_3 then
						iter_83_3.color = arg_80_1.isInRecall_ and (arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_80_1.var_.actorSpriteComps10128 = nil
			end

			local var_83_2 = arg_80_1.actors_["10128"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos10128 = var_83_2.localPosition
				var_83_2.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("10128", 3)

				for iter_83_4 = 0, var_83_2.childCount - 1 do
					local var_83_3 = var_83_2:GetChild(iter_83_4)

					if var_83_3.name == "split_6" or not string.find(var_83_3.name, "split") then
						var_83_3.gameObject:SetActive(true)
					else
						var_83_3.gameObject:SetActive(false)
					end
				end
			end

			local var_83_4 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				var_83_2.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_80_1.time_ - 0) / var_83_4)
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				var_83_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_83_5 = 0
			local var_83_6 = 0.15

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_7 = arg_80_1:GetWordFromCfg(417181019)
				local var_83_8 = arg_80_1:FormatText(var_83_7.content)

				arg_80_1.text_.text = var_83_8

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_10 = 6 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 6)

				if (6 <= 0 and var_83_6 or var_83_6 * (utf8.len(var_83_8) / 6)) > 0 and var_83_6 < var_83_10 then
					arg_80_1.talkMaxDuration = var_83_10

					if var_83_10 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_5
					end
				end

				arg_80_1.text_.text = var_83_8
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181019", "story_v_out_417181.awb") ~= 0 then
					local var_83_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181019", "story_v_out_417181.awb") / 1000

					if var_83_11 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_11 + var_83_5
					end

					if var_83_7.prefab_name ~= "" and arg_80_1.actors_[var_83_7.prefab_name] ~= nil then
						local var_83_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_7.prefab_name].transform, "story_v_out_417181", "417181019", "story_v_out_417181.awb")

						arg_80_1:RecordAudio("417181019", var_83_12)
						arg_80_1:RecordAudio("417181019", var_83_12)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_417181", "417181019", "story_v_out_417181.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_417181", "417181019", "story_v_out_417181.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_13 = math.max(var_83_6, arg_80_1.talkMaxDuration)

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_13 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_5) / var_83_13

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_5 + var_83_13 and arg_80_1.time_ < var_83_5 + var_83_13 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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

		arg_80_1:InitPlayNodeList()
	end,
	Play417181020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 417181020
		arg_84_1.duration_ = 12.43

		local var_84_0 = {
			zh = 9.3,
			ja = 12.433
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
				arg_84_0:Play417181021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["10128"]) and arg_84_1.var_.actorSpriteComps10128 == nil then
				arg_84_1.var_.actorSpriteComps10128 = arg_84_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_0 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["10128"]) then
				if arg_84_1.var_.actorSpriteComps10128 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								iter_87_1.color = Color.New(Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor2.r, (arg_84_1.time_ - 0) / var_87_0), Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor2.g, (arg_84_1.time_ - 0) / var_87_0), (Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor2.b, (arg_84_1.time_ - 0) / var_87_0)))
							else
								local var_87_1 = Mathf.Lerp(iter_87_1.color.r, 0.5, (arg_84_1.time_ - 0) / var_87_0)

								iter_87_1.color = Color.New(var_87_1, var_87_1, var_87_1)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["10128"]) and arg_84_1.var_.actorSpriteComps10128 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_87_3 then
						iter_87_3.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_84_1.var_.actorSpriteComps10128 = nil
			end

			local var_87_2 = 0
			local var_87_3 = 0.7

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_4 = arg_84_1:GetWordFromCfg(417181020)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 28 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 28)

				if (28 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 28)) > 0 and var_87_3 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181020", "story_v_out_417181.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181020", "story_v_out_417181.awb") / 1000

					if var_87_8 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_2
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_417181", "417181020", "story_v_out_417181.awb")

						arg_84_1:RecordAudio("417181020", var_87_9)
						arg_84_1:RecordAudio("417181020", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_417181", "417181020", "story_v_out_417181.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_417181", "417181020", "story_v_out_417181.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_10 and arg_84_1.time_ < var_87_2 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play417181021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 417181021
		arg_88_1.duration_ = 3

		local var_88_0 = {
			zh = 1.6,
			ja = 3
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
				arg_88_0:Play417181022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["10128"]) and arg_88_1.var_.actorSpriteComps10128 == nil then
				arg_88_1.var_.actorSpriteComps10128 = arg_88_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_0 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["10128"]) then
				if arg_88_1.var_.actorSpriteComps10128 then
					for iter_91_0, iter_91_1 in pairs(arg_88_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_91_1 then
							if arg_88_1.isInRecall_ then
								iter_91_1.color = Color.New(Mathf.Lerp(iter_91_1.color.r, arg_88_1.hightColor1.r, (arg_88_1.time_ - 0) / var_91_0), Mathf.Lerp(iter_91_1.color.g, arg_88_1.hightColor1.g, (arg_88_1.time_ - 0) / var_91_0), (Mathf.Lerp(iter_91_1.color.b, arg_88_1.hightColor1.b, (arg_88_1.time_ - 0) / var_91_0)))
							else
								local var_91_1 = Mathf.Lerp(iter_91_1.color.r, 1, (arg_88_1.time_ - 0) / var_91_0)

								iter_91_1.color = Color.New(var_91_1, var_91_1, var_91_1)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["10128"]) and arg_88_1.var_.actorSpriteComps10128 then
				for iter_91_2, iter_91_3 in pairs(arg_88_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_91_3 then
						iter_91_3.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_88_1.var_.actorSpriteComps10128 = nil
			end

			local var_91_2 = 0
			local var_91_3 = 0.225

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_4 = arg_88_1:GetWordFromCfg(417181021)
				local var_91_5 = arg_88_1:FormatText(var_91_4.content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 9 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 9)

				if (9 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 9)) > 0 and var_91_3 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181021", "story_v_out_417181.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181021", "story_v_out_417181.awb") / 1000

					if var_91_8 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_2
					end

					if var_91_4.prefab_name ~= "" and arg_88_1.actors_[var_91_4.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_4.prefab_name].transform, "story_v_out_417181", "417181021", "story_v_out_417181.awb")

						arg_88_1:RecordAudio("417181021", var_91_9)
						arg_88_1:RecordAudio("417181021", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_417181", "417181021", "story_v_out_417181.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_417181", "417181021", "story_v_out_417181.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_10 and arg_88_1.time_ < var_91_2 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play417181022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 417181022
		arg_92_1.duration_ = 20.8

		local var_92_0 = {
			zh = 12.866,
			ja = 20.8
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
				arg_92_0:Play417181023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["10128"]) and arg_92_1.var_.actorSpriteComps10128 == nil then
				arg_92_1.var_.actorSpriteComps10128 = arg_92_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_0 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["10128"]) then
				if arg_92_1.var_.actorSpriteComps10128 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								iter_95_1.color = Color.New(Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor2.r, (arg_92_1.time_ - 0) / var_95_0), Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor2.g, (arg_92_1.time_ - 0) / var_95_0), (Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor2.b, (arg_92_1.time_ - 0) / var_95_0)))
							else
								local var_95_1 = Mathf.Lerp(iter_95_1.color.r, 0.5, (arg_92_1.time_ - 0) / var_95_0)

								iter_95_1.color = Color.New(var_95_1, var_95_1, var_95_1)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["10128"]) and arg_92_1.var_.actorSpriteComps10128 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_95_3 then
						iter_95_3.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_92_1.var_.actorSpriteComps10128 = nil
			end

			local var_95_2 = 0
			local var_95_3 = 1.1

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_4 = arg_92_1:GetWordFromCfg(417181022)
				local var_95_5 = arg_92_1:FormatText(var_95_4.content)

				arg_92_1.text_.text = var_95_5

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_7 = 44 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 44)

				if (44 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 44)) > 0 and var_95_3 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_5
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181022", "story_v_out_417181.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181022", "story_v_out_417181.awb") / 1000

					if var_95_8 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_2
					end

					if var_95_4.prefab_name ~= "" and arg_92_1.actors_[var_95_4.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_4.prefab_name].transform, "story_v_out_417181", "417181022", "story_v_out_417181.awb")

						arg_92_1:RecordAudio("417181022", var_95_9)
						arg_92_1:RecordAudio("417181022", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_417181", "417181022", "story_v_out_417181.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_417181", "417181022", "story_v_out_417181.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_3, arg_92_1.talkMaxDuration)

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_2) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_2 + var_95_10 and arg_92_1.time_ < var_95_2 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play417181023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 417181023
		arg_96_1.duration_ = 2.73

		local var_96_0 = {
			zh = 2.166,
			ja = 2.733
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
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play417181024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["10128"]) and arg_96_1.var_.actorSpriteComps10128 == nil then
				arg_96_1.var_.actorSpriteComps10128 = arg_96_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_0 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["10128"]) then
				if arg_96_1.var_.actorSpriteComps10128 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								iter_99_1.color = Color.New(Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor1.r, (arg_96_1.time_ - 0) / var_99_0), Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor1.g, (arg_96_1.time_ - 0) / var_99_0), (Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor1.b, (arg_96_1.time_ - 0) / var_99_0)))
							else
								local var_99_1 = Mathf.Lerp(iter_99_1.color.r, 1, (arg_96_1.time_ - 0) / var_99_0)

								iter_99_1.color = Color.New(var_99_1, var_99_1, var_99_1)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["10128"]) and arg_96_1.var_.actorSpriteComps10128 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_99_3 then
						iter_99_3.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_96_1.var_.actorSpriteComps10128 = nil
			end

			local var_99_2 = 0
			local var_99_3 = 0.225

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:GetWordFromCfg(417181023)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 9 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 9)

				if (9 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 9)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181023", "story_v_out_417181.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181023", "story_v_out_417181.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_out_417181", "417181023", "story_v_out_417181.awb")

						arg_96_1:RecordAudio("417181023", var_99_9)
						arg_96_1:RecordAudio("417181023", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_417181", "417181023", "story_v_out_417181.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_417181", "417181023", "story_v_out_417181.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_10 and arg_96_1.time_ < var_99_2 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play417181024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 417181024
		arg_100_1.duration_ = 5

		local var_100_0 = {
			zh = 3.566,
			ja = 5
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
				arg_100_0:Play417181025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.375

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:GetWordFromCfg(417181024)
				local var_103_2 = arg_100_1:FormatText(var_103_1.content)

				arg_100_1.text_.text = var_103_2

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 15 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 15)

				if (15 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 15)) > 0 and var_103_0 < var_103_4 then
					arg_100_1.talkMaxDuration = var_103_4

					if var_103_4 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_4 + 0
					end
				end

				arg_100_1.text_.text = var_103_2
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181024", "story_v_out_417181.awb") ~= 0 then
					local var_103_5 = manager.audio:GetVoiceLength("story_v_out_417181", "417181024", "story_v_out_417181.awb") / 1000

					if var_103_5 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + 0
					end

					if var_103_1.prefab_name ~= "" and arg_100_1.actors_[var_103_1.prefab_name] ~= nil then
						local var_103_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_1.prefab_name].transform, "story_v_out_417181", "417181024", "story_v_out_417181.awb")

						arg_100_1:RecordAudio("417181024", var_103_6)
						arg_100_1:RecordAudio("417181024", var_103_6)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_417181", "417181024", "story_v_out_417181.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_417181", "417181024", "story_v_out_417181.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play417181025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 417181025
		arg_104_1.duration_ = 19.73

		local var_104_0 = {
			zh = 15.1,
			ja = 19.733
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
				arg_104_0:Play417181026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["10128"]) and arg_104_1.var_.actorSpriteComps10128 == nil then
				arg_104_1.var_.actorSpriteComps10128 = arg_104_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_0 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["10128"]) then
				if arg_104_1.var_.actorSpriteComps10128 then
					for iter_107_0, iter_107_1 in pairs(arg_104_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["10128"]) and arg_104_1.var_.actorSpriteComps10128 then
				for iter_107_2, iter_107_3 in pairs(arg_104_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_107_3 then
						iter_107_3.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_104_1.var_.actorSpriteComps10128 = nil
			end

			local var_107_2 = 0
			local var_107_3 = 1.125

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_4 = arg_104_1:GetWordFromCfg(417181025)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 45 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 45)

				if (45 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 45)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181025", "story_v_out_417181.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181025", "story_v_out_417181.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_out_417181", "417181025", "story_v_out_417181.awb")

						arg_104_1:RecordAudio("417181025", var_107_9)
						arg_104_1:RecordAudio("417181025", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_417181", "417181025", "story_v_out_417181.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_417181", "417181025", "story_v_out_417181.awb")
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
	Play417181026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 417181026
		arg_108_1.duration_ = 8.7

		local var_108_0 = {
			zh = 6.833,
			ja = 8.7
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
				arg_108_0:Play417181027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["10128"]) and arg_108_1.var_.actorSpriteComps10128 == nil then
				arg_108_1.var_.actorSpriteComps10128 = arg_108_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_0 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["10128"]) then
				if arg_108_1.var_.actorSpriteComps10128 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["10128"]) and arg_108_1.var_.actorSpriteComps10128 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_111_3 then
						iter_111_3.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_108_1.var_.actorSpriteComps10128 = nil
			end

			local var_111_2 = 0
			local var_111_3 = 0.6

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_2 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_4 = arg_108_1:GetWordFromCfg(417181026)
				local var_111_5 = arg_108_1:FormatText(var_111_4.content)

				arg_108_1.text_.text = var_111_5

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_7 = 24 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 24)

				if (24 <= 0 and var_111_3 or var_111_3 * (utf8.len(var_111_5) / 24)) > 0 and var_111_3 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_2
					end
				end

				arg_108_1.text_.text = var_111_5
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181026", "story_v_out_417181.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181026", "story_v_out_417181.awb") / 1000

					if var_111_8 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_2
					end

					if var_111_4.prefab_name ~= "" and arg_108_1.actors_[var_111_4.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_4.prefab_name].transform, "story_v_out_417181", "417181026", "story_v_out_417181.awb")

						arg_108_1:RecordAudio("417181026", var_111_9)
						arg_108_1:RecordAudio("417181026", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_417181", "417181026", "story_v_out_417181.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_417181", "417181026", "story_v_out_417181.awb")
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
	Play417181027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 417181027
		arg_112_1.duration_ = 9.5

		local var_112_0 = {
			zh = 5.1,
			ja = 9.5
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
				arg_112_0:Play417181028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["10128"]) and arg_112_1.var_.actorSpriteComps10128 == nil then
				arg_112_1.var_.actorSpriteComps10128 = arg_112_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["10128"]) then
				if arg_112_1.var_.actorSpriteComps10128 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps10128:ToTable()) do
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

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["10128"]) and arg_112_1.var_.actorSpriteComps10128 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_115_3 then
						iter_115_3.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_112_1.var_.actorSpriteComps10128 = nil
			end

			local var_115_2 = 0
			local var_115_3 = 0.3

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_4 = arg_112_1:GetWordFromCfg(417181027)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 12 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 12)

				if (12 <= 0 and var_115_3 or var_115_3 * (utf8.len(var_115_5) / 12)) > 0 and var_115_3 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_2
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181027", "story_v_out_417181.awb") ~= 0 then
					local var_115_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181027", "story_v_out_417181.awb") / 1000

					if var_115_8 + var_115_2 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_2
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_417181", "417181027", "story_v_out_417181.awb")

						arg_112_1:RecordAudio("417181027", var_115_9)
						arg_112_1:RecordAudio("417181027", var_115_9)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_417181", "417181027", "story_v_out_417181.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_417181", "417181027", "story_v_out_417181.awb")
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
	Play417181028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 417181028
		arg_116_1.duration_ = 3

		local var_116_0 = {
			zh = 3,
			ja = 2.233
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
				arg_116_0:Play417181029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["10128"]) and arg_116_1.var_.actorSpriteComps10128 == nil then
				arg_116_1.var_.actorSpriteComps10128 = arg_116_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["10128"]) then
				if arg_116_1.var_.actorSpriteComps10128 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								iter_119_1.color = Color.New(Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor1.r, (arg_116_1.time_ - 0) / var_119_0), Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor1.g, (arg_116_1.time_ - 0) / var_119_0), (Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor1.b, (arg_116_1.time_ - 0) / var_119_0)))
							else
								local var_119_1 = Mathf.Lerp(iter_119_1.color.r, 1, (arg_116_1.time_ - 0) / var_119_0)

								iter_119_1.color = Color.New(var_119_1, var_119_1, var_119_1)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["10128"]) and arg_116_1.var_.actorSpriteComps10128 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_119_3 then
						iter_119_3.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_116_1.var_.actorSpriteComps10128 = nil
			end

			local var_119_2 = 0
			local var_119_3 = 0.5

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_2 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_4 = arg_116_1:GetWordFromCfg(417181028)
				local var_119_5 = arg_116_1:FormatText(var_119_4.content)

				arg_116_1.text_.text = var_119_5

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_7 = 20 <= 0 and var_119_3 or var_119_3 * (utf8.len(var_119_5) / 20)

				if (20 <= 0 and var_119_3 or var_119_3 * (utf8.len(var_119_5) / 20)) > 0 and var_119_3 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_2 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_2
					end
				end

				arg_116_1.text_.text = var_119_5
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181028", "story_v_out_417181.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181028", "story_v_out_417181.awb") / 1000

					if var_119_8 + var_119_2 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_2
					end

					if var_119_4.prefab_name ~= "" and arg_116_1.actors_[var_119_4.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_4.prefab_name].transform, "story_v_out_417181", "417181028", "story_v_out_417181.awb")

						arg_116_1:RecordAudio("417181028", var_119_9)
						arg_116_1:RecordAudio("417181028", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_417181", "417181028", "story_v_out_417181.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_417181", "417181028", "story_v_out_417181.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_3, arg_116_1.talkMaxDuration)

			if var_119_2 <= arg_116_1.time_ and arg_116_1.time_ < var_119_2 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_2) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_2 + var_119_10 and arg_116_1.time_ < var_119_2 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play417181029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 417181029
		arg_120_1.duration_ = 5.77

		local var_120_0 = {
			zh = 4.233,
			ja = 5.766
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
				arg_120_0:Play417181030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["10128"]) and arg_120_1.var_.actorSpriteComps10128 == nil then
				arg_120_1.var_.actorSpriteComps10128 = arg_120_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["10128"]) then
				if arg_120_1.var_.actorSpriteComps10128 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								iter_123_1.color = Color.New(Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor2.r, (arg_120_1.time_ - 0) / var_123_0), Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor2.g, (arg_120_1.time_ - 0) / var_123_0), (Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor2.b, (arg_120_1.time_ - 0) / var_123_0)))
							else
								local var_123_1 = Mathf.Lerp(iter_123_1.color.r, 0.5, (arg_120_1.time_ - 0) / var_123_0)

								iter_123_1.color = Color.New(var_123_1, var_123_1, var_123_1)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["10128"]) and arg_120_1.var_.actorSpriteComps10128 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_123_3 then
						iter_123_3.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_120_1.var_.actorSpriteComps10128 = nil
			end

			local var_123_2 = 0
			local var_123_3 = 0.275

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_4 = arg_120_1:GetWordFromCfg(417181029)
				local var_123_5 = arg_120_1:FormatText(var_123_4.content)

				arg_120_1.text_.text = var_123_5

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_7 = 11 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 11)

				if (11 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 11)) > 0 and var_123_3 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_5
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181029", "story_v_out_417181.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181029", "story_v_out_417181.awb") / 1000

					if var_123_8 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_2
					end

					if var_123_4.prefab_name ~= "" and arg_120_1.actors_[var_123_4.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_4.prefab_name].transform, "story_v_out_417181", "417181029", "story_v_out_417181.awb")

						arg_120_1:RecordAudio("417181029", var_123_9)
						arg_120_1:RecordAudio("417181029", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_417181", "417181029", "story_v_out_417181.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_417181", "417181029", "story_v_out_417181.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_10 and arg_120_1.time_ < var_123_2 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play417181030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 417181030
		arg_124_1.duration_ = 3.53

		local var_124_0 = {
			zh = 2.066,
			ja = 3.533
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
				arg_124_0:Play417181031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["10128"]) and arg_124_1.var_.actorSpriteComps10128 == nil then
				arg_124_1.var_.actorSpriteComps10128 = arg_124_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["10128"]) then
				if arg_124_1.var_.actorSpriteComps10128 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								iter_127_1.color = Color.New(Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor1.r, (arg_124_1.time_ - 0) / var_127_0), Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor1.g, (arg_124_1.time_ - 0) / var_127_0), (Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor1.b, (arg_124_1.time_ - 0) / var_127_0)))
							else
								local var_127_1 = Mathf.Lerp(iter_127_1.color.r, 1, (arg_124_1.time_ - 0) / var_127_0)

								iter_127_1.color = Color.New(var_127_1, var_127_1, var_127_1)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["10128"]) and arg_124_1.var_.actorSpriteComps10128 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_127_3 then
						iter_127_3.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_124_1.var_.actorSpriteComps10128 = nil
			end

			local var_127_2 = 0
			local var_127_3 = 0.325

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_4 = arg_124_1:GetWordFromCfg(417181030)
				local var_127_5 = arg_124_1:FormatText(var_127_4.content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_7 = 13 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 13)

				if (13 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 13)) > 0 and var_127_3 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_2
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181030", "story_v_out_417181.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181030", "story_v_out_417181.awb") / 1000

					if var_127_8 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_2
					end

					if var_127_4.prefab_name ~= "" and arg_124_1.actors_[var_127_4.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_4.prefab_name].transform, "story_v_out_417181", "417181030", "story_v_out_417181.awb")

						arg_124_1:RecordAudio("417181030", var_127_9)
						arg_124_1:RecordAudio("417181030", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_417181", "417181030", "story_v_out_417181.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_417181", "417181030", "story_v_out_417181.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_3, arg_124_1.talkMaxDuration)

			if var_127_2 <= arg_124_1.time_ and arg_124_1.time_ < var_127_2 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_2) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_2 + var_127_10 and arg_124_1.time_ < var_127_2 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play417181031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 417181031
		arg_128_1.duration_ = 3.37

		local var_128_0 = {
			zh = 2.433,
			ja = 3.366
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
				arg_128_0:Play417181032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["10128"]) and arg_128_1.var_.actorSpriteComps10128 == nil then
				arg_128_1.var_.actorSpriteComps10128 = arg_128_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["10128"]) then
				if arg_128_1.var_.actorSpriteComps10128 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								iter_131_1.color = Color.New(Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor2.r, (arg_128_1.time_ - 0) / var_131_0), Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor2.g, (arg_128_1.time_ - 0) / var_131_0), (Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor2.b, (arg_128_1.time_ - 0) / var_131_0)))
							else
								local var_131_1 = Mathf.Lerp(iter_131_1.color.r, 0.5, (arg_128_1.time_ - 0) / var_131_0)

								iter_131_1.color = Color.New(var_131_1, var_131_1, var_131_1)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["10128"]) and arg_128_1.var_.actorSpriteComps10128 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_131_3 then
						iter_131_3.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_128_1.var_.actorSpriteComps10128 = nil
			end

			local var_131_2 = 0
			local var_131_3 = 0.175

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_4 = arg_128_1:GetWordFromCfg(417181031)
				local var_131_5 = arg_128_1:FormatText(var_131_4.content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_7 = 7 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 7)

				if (7 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_5) / 7)) > 0 and var_131_3 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_2
					end
				end

				arg_128_1.text_.text = var_131_5
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181031", "story_v_out_417181.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181031", "story_v_out_417181.awb") / 1000

					if var_131_8 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_2
					end

					if var_131_4.prefab_name ~= "" and arg_128_1.actors_[var_131_4.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_4.prefab_name].transform, "story_v_out_417181", "417181031", "story_v_out_417181.awb")

						arg_128_1:RecordAudio("417181031", var_131_9)
						arg_128_1:RecordAudio("417181031", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_417181", "417181031", "story_v_out_417181.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_417181", "417181031", "story_v_out_417181.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_3, arg_128_1.talkMaxDuration)

			if var_131_2 <= arg_128_1.time_ and arg_128_1.time_ < var_131_2 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_2) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_2 + var_131_10 and arg_128_1.time_ < var_131_2 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play417181032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 417181032
		arg_132_1.duration_ = 3.17

		local var_132_0 = {
			zh = 2.166,
			ja = 3.166
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
				arg_132_0:Play417181033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["10128"]) and arg_132_1.var_.actorSpriteComps10128 == nil then
				arg_132_1.var_.actorSpriteComps10128 = arg_132_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["10128"]) then
				if arg_132_1.var_.actorSpriteComps10128 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								iter_135_1.color = Color.New(Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor1.r, (arg_132_1.time_ - 0) / var_135_0), Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor1.g, (arg_132_1.time_ - 0) / var_135_0), (Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor1.b, (arg_132_1.time_ - 0) / var_135_0)))
							else
								local var_135_1 = Mathf.Lerp(iter_135_1.color.r, 1, (arg_132_1.time_ - 0) / var_135_0)

								iter_135_1.color = Color.New(var_135_1, var_135_1, var_135_1)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["10128"]) and arg_132_1.var_.actorSpriteComps10128 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_132_1.var_.actorSpriteComps10128 = nil
			end

			local var_135_2 = 0
			local var_135_3 = 0.225

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_2 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_4 = arg_132_1:GetWordFromCfg(417181032)
				local var_135_5 = arg_132_1:FormatText(var_135_4.content)

				arg_132_1.text_.text = var_135_5

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_7 = 9 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_5) / 9)

				if (9 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_5) / 9)) > 0 and var_135_3 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_2
					end
				end

				arg_132_1.text_.text = var_135_5
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181032", "story_v_out_417181.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181032", "story_v_out_417181.awb") / 1000

					if var_135_8 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_2
					end

					if var_135_4.prefab_name ~= "" and arg_132_1.actors_[var_135_4.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_4.prefab_name].transform, "story_v_out_417181", "417181032", "story_v_out_417181.awb")

						arg_132_1:RecordAudio("417181032", var_135_9)
						arg_132_1:RecordAudio("417181032", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_417181", "417181032", "story_v_out_417181.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_417181", "417181032", "story_v_out_417181.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_3, arg_132_1.talkMaxDuration)

			if var_135_2 <= arg_132_1.time_ and arg_132_1.time_ < var_135_2 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_2) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_2 + var_135_10 and arg_132_1.time_ < var_135_2 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play417181033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 417181033
		arg_136_1.duration_ = 6.73

		local var_136_0 = {
			zh = 3.333,
			ja = 6.733
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play417181034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["10128"]) and arg_136_1.var_.actorSpriteComps10128 == nil then
				arg_136_1.var_.actorSpriteComps10128 = arg_136_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["10128"]) then
				if arg_136_1.var_.actorSpriteComps10128 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								iter_139_1.color = Color.New(Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor2.r, (arg_136_1.time_ - 0) / var_139_0), Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor2.g, (arg_136_1.time_ - 0) / var_139_0), (Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor2.b, (arg_136_1.time_ - 0) / var_139_0)))
							else
								local var_139_1 = Mathf.Lerp(iter_139_1.color.r, 0.5, (arg_136_1.time_ - 0) / var_139_0)

								iter_139_1.color = Color.New(var_139_1, var_139_1, var_139_1)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["10128"]) and arg_136_1.var_.actorSpriteComps10128 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_139_3 then
						iter_139_3.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_136_1.var_.actorSpriteComps10128 = nil
			end

			local var_139_2 = 0
			local var_139_3 = 0.225

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_4 = arg_136_1:GetWordFromCfg(417181033)
				local var_139_5 = arg_136_1:FormatText(var_139_4.content)

				arg_136_1.text_.text = var_139_5

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_7 = 9 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 9)

				if (9 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 9)) > 0 and var_139_3 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_2
					end
				end

				arg_136_1.text_.text = var_139_5
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181033", "story_v_out_417181.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181033", "story_v_out_417181.awb") / 1000

					if var_139_8 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_2
					end

					if var_139_4.prefab_name ~= "" and arg_136_1.actors_[var_139_4.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_4.prefab_name].transform, "story_v_out_417181", "417181033", "story_v_out_417181.awb")

						arg_136_1:RecordAudio("417181033", var_139_9)
						arg_136_1:RecordAudio("417181033", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_417181", "417181033", "story_v_out_417181.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_417181", "417181033", "story_v_out_417181.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_3, arg_136_1.talkMaxDuration)

			if var_139_2 <= arg_136_1.time_ and arg_136_1.time_ < var_139_2 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_2) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_2 + var_139_10 and arg_136_1.time_ < var_139_2 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play417181034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 417181034
		arg_140_1.duration_ = 6.37

		local var_140_0 = {
			zh = 3.466,
			ja = 6.366
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
				arg_140_0:Play417181035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["10128"]) and arg_140_1.var_.actorSpriteComps10128 == nil then
				arg_140_1.var_.actorSpriteComps10128 = arg_140_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["10128"]) then
				if arg_140_1.var_.actorSpriteComps10128 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								iter_143_1.color = Color.New(Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor1.r, (arg_140_1.time_ - 0) / var_143_0), Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor1.g, (arg_140_1.time_ - 0) / var_143_0), (Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor1.b, (arg_140_1.time_ - 0) / var_143_0)))
							else
								local var_143_1 = Mathf.Lerp(iter_143_1.color.r, 1, (arg_140_1.time_ - 0) / var_143_0)

								iter_143_1.color = Color.New(var_143_1, var_143_1, var_143_1)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["10128"]) and arg_140_1.var_.actorSpriteComps10128 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_143_3 then
						iter_143_3.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_140_1.var_.actorSpriteComps10128 = nil
			end

			local var_143_2 = 0
			local var_143_3 = 0.55

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_4 = arg_140_1:GetWordFromCfg(417181034)
				local var_143_5 = arg_140_1:FormatText(var_143_4.content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 22 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 22)

				if (22 <= 0 and var_143_3 or var_143_3 * (utf8.len(var_143_5) / 22)) > 0 and var_143_3 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_2
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181034", "story_v_out_417181.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181034", "story_v_out_417181.awb") / 1000

					if var_143_8 + var_143_2 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_2
					end

					if var_143_4.prefab_name ~= "" and arg_140_1.actors_[var_143_4.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_4.prefab_name].transform, "story_v_out_417181", "417181034", "story_v_out_417181.awb")

						arg_140_1:RecordAudio("417181034", var_143_9)
						arg_140_1:RecordAudio("417181034", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_417181", "417181034", "story_v_out_417181.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_417181", "417181034", "story_v_out_417181.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_3, arg_140_1.talkMaxDuration)

			if var_143_2 <= arg_140_1.time_ and arg_140_1.time_ < var_143_2 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_2) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_2 + var_143_10 and arg_140_1.time_ < var_143_2 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play417181035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 417181035
		arg_144_1.duration_ = 7.77

		local var_144_0 = {
			zh = 4.933,
			ja = 7.766
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
				arg_144_0:Play417181036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["10128"]) and arg_144_1.var_.actorSpriteComps10128 == nil then
				arg_144_1.var_.actorSpriteComps10128 = arg_144_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_0 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["10128"]) then
				if arg_144_1.var_.actorSpriteComps10128 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								iter_147_1.color = Color.New(Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor2.r, (arg_144_1.time_ - 0) / var_147_0), Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor2.g, (arg_144_1.time_ - 0) / var_147_0), (Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor2.b, (arg_144_1.time_ - 0) / var_147_0)))
							else
								local var_147_1 = Mathf.Lerp(iter_147_1.color.r, 0.5, (arg_144_1.time_ - 0) / var_147_0)

								iter_147_1.color = Color.New(var_147_1, var_147_1, var_147_1)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["10128"]) and arg_144_1.var_.actorSpriteComps10128 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_147_3 then
						iter_147_3.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_144_1.var_.actorSpriteComps10128 = nil
			end

			local var_147_2 = 0
			local var_147_3 = 0.3

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1148].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_4 = arg_144_1:GetWordFromCfg(417181035)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 12 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 12)

				if (12 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 12)) > 0 and var_147_3 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181035", "story_v_out_417181.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_417181", "417181035", "story_v_out_417181.awb") / 1000

					if var_147_8 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_2
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_out_417181", "417181035", "story_v_out_417181.awb")

						arg_144_1:RecordAudio("417181035", var_147_9)
						arg_144_1:RecordAudio("417181035", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_417181", "417181035", "story_v_out_417181.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_417181", "417181035", "story_v_out_417181.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_3, arg_144_1.talkMaxDuration)

			if var_147_2 <= arg_144_1.time_ and arg_144_1.time_ < var_147_2 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_2) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_2 + var_147_10 and arg_144_1.time_ < var_147_2 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play417181036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 417181036
		arg_148_1.duration_ = 3.7

		local var_148_0 = {
			zh = 1.933,
			ja = 3.7
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
				arg_148_0:Play417181037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["10128"]) and arg_148_1.var_.actorSpriteComps10128 == nil then
				arg_148_1.var_.actorSpriteComps10128 = arg_148_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["10128"]) then
				if arg_148_1.var_.actorSpriteComps10128 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								iter_151_1.color = Color.New(Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, (arg_148_1.time_ - 0) / var_151_0), Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, (arg_148_1.time_ - 0) / var_151_0), (Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, (arg_148_1.time_ - 0) / var_151_0)))
							else
								local var_151_1 = Mathf.Lerp(iter_151_1.color.r, 1, (arg_148_1.time_ - 0) / var_151_0)

								iter_151_1.color = Color.New(var_151_1, var_151_1, var_151_1)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["10128"]) and arg_148_1.var_.actorSpriteComps10128 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_151_3 then
						iter_151_3.color = arg_148_1.isInRecall_ and (arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_148_1.var_.actorSpriteComps10128 = nil
			end

			local var_151_2 = arg_148_1.actors_["10128"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos10128 = var_151_2.localPosition
				var_151_2.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("10128", 3)

				for iter_151_4 = 0, var_151_2.childCount - 1 do
					local var_151_3 = var_151_2:GetChild(iter_151_4)

					if var_151_3.name == "split_1" or not string.find(var_151_3.name, "split") then
						var_151_3.gameObject:SetActive(true)
					else
						var_151_3.gameObject:SetActive(false)
					end
				end
			end

			local var_151_4 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				var_151_2.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_148_1.time_ - 0) / var_151_4)
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				var_151_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_151_5 = 0
			local var_151_6 = 0.225

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_7 = arg_148_1:GetWordFromCfg(417181036)
				local var_151_8 = arg_148_1:FormatText(var_151_7.content)

				arg_148_1.text_.text = var_151_8

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_10 = 9 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_8) / 9)

				if (9 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_8) / 9)) > 0 and var_151_6 < var_151_10 then
					arg_148_1.talkMaxDuration = var_151_10

					if var_151_10 + var_151_5 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_5
					end
				end

				arg_148_1.text_.text = var_151_8
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181036", "story_v_out_417181.awb") ~= 0 then
					local var_151_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181036", "story_v_out_417181.awb") / 1000

					if var_151_11 + var_151_5 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_11 + var_151_5
					end

					if var_151_7.prefab_name ~= "" and arg_148_1.actors_[var_151_7.prefab_name] ~= nil then
						local var_151_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_7.prefab_name].transform, "story_v_out_417181", "417181036", "story_v_out_417181.awb")

						arg_148_1:RecordAudio("417181036", var_151_12)
						arg_148_1:RecordAudio("417181036", var_151_12)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_417181", "417181036", "story_v_out_417181.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_417181", "417181036", "story_v_out_417181.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_13 = math.max(var_151_6, arg_148_1.talkMaxDuration)

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_13 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_5) / var_151_13

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_5 + var_151_13 and arg_148_1.time_ < var_151_5 + var_151_13 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play417181037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 417181037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play417181038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["10128"]) and arg_152_1.var_.actorSpriteComps10128 == nil then
				arg_152_1.var_.actorSpriteComps10128 = arg_152_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_0 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["10128"]) then
				if arg_152_1.var_.actorSpriteComps10128 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								iter_155_1.color = Color.New(Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor2.r, (arg_152_1.time_ - 0) / var_155_0), Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor2.g, (arg_152_1.time_ - 0) / var_155_0), (Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor2.b, (arg_152_1.time_ - 0) / var_155_0)))
							else
								local var_155_1 = Mathf.Lerp(iter_155_1.color.r, 0.5, (arg_152_1.time_ - 0) / var_155_0)

								iter_155_1.color = Color.New(var_155_1, var_155_1, var_155_1)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["10128"]) and arg_152_1.var_.actorSpriteComps10128 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_155_3 then
						iter_155_3.color = arg_152_1.isInRecall_ and (arg_152_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_152_1.var_.actorSpriteComps10128 = nil
			end

			local var_155_2 = arg_152_1.actors_["10128"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos10128 = var_155_2.localPosition
				var_155_2.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("10128", 7)

				for iter_155_4 = 0, var_155_2.childCount - 1 do
					local var_155_3 = var_155_2:GetChild(iter_155_4)

					if var_155_3.name == "" or not string.find(var_155_3.name, "split") then
						var_155_3.gameObject:SetActive(true)
					else
						var_155_3.gameObject:SetActive(false)
					end
				end
			end

			local var_155_4 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 then
				var_155_2.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_152_1.time_ - 0) / var_155_4)
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 then
				var_155_2.localPosition = Vector3.New(0, -2000, -300)
			end

			if 0.633333333333333 < arg_152_1.time_ and arg_152_1.time_ <= 0.633333333333333 + arg_155_0 then
				arg_152_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun02", "")
			end

			local var_155_6 = 0
			local var_155_7 = 1

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_8 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(417181037).content)

				arg_152_1.text_.text = var_155_8

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_10 = 40 <= 0 and var_155_7 or var_155_7 * (utf8.len(var_155_8) / 40)

				if (40 <= 0 and var_155_7 or var_155_7 * (utf8.len(var_155_8) / 40)) > 0 and var_155_7 < var_155_10 then
					arg_152_1.talkMaxDuration = var_155_10

					if var_155_10 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_8
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_11 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_11 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_11

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_11 and arg_152_1.time_ < var_155_6 + var_155_11 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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

		arg_152_1:InitPlayNodeList()
	end,
	Play417181038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 417181038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play417181039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 1.1

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_1 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(417181038).content)

				arg_156_1.text_.text = var_159_1

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_3 = 44 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 44)

				if (44 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 44)) > 0 and var_159_0 < var_159_3 then
					arg_156_1.talkMaxDuration = var_159_3

					if var_159_3 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_3 + 0
					end
				end

				arg_156_1.text_.text = var_159_1
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_4 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_4

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play417181039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 417181039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play417181040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 1.1

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(417181039).content)

				arg_160_1.text_.text = var_163_1

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_3 = 44 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 44)

				if (44 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 44)) > 0 and var_163_0 < var_163_3 then
					arg_160_1.talkMaxDuration = var_163_3

					if var_163_3 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_3 + 0
					end
				end

				arg_160_1.text_.text = var_163_1
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_4 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_4

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play417181040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 417181040
		arg_164_1.duration_ = 7.87

		local var_164_0 = {
			zh = 4.966,
			ja = 7.866
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
				arg_164_0:Play417181041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["10128"]) and arg_164_1.var_.actorSpriteComps10128 == nil then
				arg_164_1.var_.actorSpriteComps10128 = arg_164_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_0 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["10128"]) then
				if arg_164_1.var_.actorSpriteComps10128 then
					for iter_167_0, iter_167_1 in pairs(arg_164_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_167_1 then
							if arg_164_1.isInRecall_ then
								iter_167_1.color = Color.New(Mathf.Lerp(iter_167_1.color.r, arg_164_1.hightColor1.r, (arg_164_1.time_ - 0) / var_167_0), Mathf.Lerp(iter_167_1.color.g, arg_164_1.hightColor1.g, (arg_164_1.time_ - 0) / var_167_0), (Mathf.Lerp(iter_167_1.color.b, arg_164_1.hightColor1.b, (arg_164_1.time_ - 0) / var_167_0)))
							else
								local var_167_1 = Mathf.Lerp(iter_167_1.color.r, 1, (arg_164_1.time_ - 0) / var_167_0)

								iter_167_1.color = Color.New(var_167_1, var_167_1, var_167_1)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["10128"]) and arg_164_1.var_.actorSpriteComps10128 then
				for iter_167_2, iter_167_3 in pairs(arg_164_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_167_3 then
						iter_167_3.color = arg_164_1.isInRecall_ and (arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_164_1.var_.actorSpriteComps10128 = nil
			end

			local var_167_2 = arg_164_1.actors_["10128"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos10128 = var_167_2.localPosition
				var_167_2.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("10128", 3)

				for iter_167_4 = 0, var_167_2.childCount - 1 do
					local var_167_3 = var_167_2:GetChild(iter_167_4)

					if var_167_3.name == "split_6" or not string.find(var_167_3.name, "split") then
						var_167_3.gameObject:SetActive(true)
					else
						var_167_3.gameObject:SetActive(false)
					end
				end
			end

			local var_167_4 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				var_167_2.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_164_1.time_ - 0) / var_167_4)
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				var_167_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_167_5 = 0
			local var_167_6 = 0.575

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_7 = arg_164_1:GetWordFromCfg(417181040)
				local var_167_8 = arg_164_1:FormatText(var_167_7.content)

				arg_164_1.text_.text = var_167_8

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_10 = 23 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_8) / 23)

				if (23 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_8) / 23)) > 0 and var_167_6 < var_167_10 then
					arg_164_1.talkMaxDuration = var_167_10

					if var_167_10 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_5
					end
				end

				arg_164_1.text_.text = var_167_8
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181040", "story_v_out_417181.awb") ~= 0 then
					local var_167_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181040", "story_v_out_417181.awb") / 1000

					if var_167_11 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_11 + var_167_5
					end

					if var_167_7.prefab_name ~= "" and arg_164_1.actors_[var_167_7.prefab_name] ~= nil then
						local var_167_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_7.prefab_name].transform, "story_v_out_417181", "417181040", "story_v_out_417181.awb")

						arg_164_1:RecordAudio("417181040", var_167_12)
						arg_164_1:RecordAudio("417181040", var_167_12)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_417181", "417181040", "story_v_out_417181.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_417181", "417181040", "story_v_out_417181.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_13 = math.max(var_167_6, arg_164_1.talkMaxDuration)

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_13 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_5) / var_167_13

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_5 + var_167_13 and arg_164_1.time_ < var_167_5 + var_167_13 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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

		arg_164_1:InitPlayNodeList()
	end,
	Play417181041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 417181041
		arg_168_1.duration_ = 5.83

		local var_168_0 = {
			zh = 2.833,
			ja = 5.833
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
				arg_168_0:Play417181042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if arg_168_1.actors_["10115"] == nil then
				local var_171_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

				if not isNil(var_171_0) then
					local var_171_1 = Object.Instantiate(var_171_0, arg_168_1.canvasGo_.transform)

					var_171_1.transform:SetSiblingIndex(1)

					var_171_1.name = "10115"
					var_171_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_168_1.actors_["10115"] = var_171_1

					if arg_168_1.isInRecall_ then
						for iter_171_0, iter_171_1 in ipairs((var_171_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_171_1.color = arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_171_2 = arg_168_1.actors_["10115"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.actorSpriteComps10115 == nil then
				arg_168_1.var_.actorSpriteComps10115 = var_171_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_3 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_3 and not isNil(var_171_2) then
				if arg_168_1.var_.actorSpriteComps10115 then
					for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_171_3 then
							if arg_168_1.isInRecall_ then
								iter_171_3.color = Color.New(Mathf.Lerp(iter_171_3.color.r, arg_168_1.hightColor1.r, (arg_168_1.time_ - 0) / var_171_3), Mathf.Lerp(iter_171_3.color.g, arg_168_1.hightColor1.g, (arg_168_1.time_ - 0) / var_171_3), (Mathf.Lerp(iter_171_3.color.b, arg_168_1.hightColor1.b, (arg_168_1.time_ - 0) / var_171_3)))
							else
								local var_171_4 = Mathf.Lerp(iter_171_3.color.r, 1, (arg_168_1.time_ - 0) / var_171_3)

								iter_171_3.color = Color.New(var_171_4, var_171_4, var_171_4)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_3 and arg_168_1.time_ < 0 + var_171_3 + arg_171_0 and not isNil(var_171_2) and arg_168_1.var_.actorSpriteComps10115 then
				for iter_171_4, iter_171_5 in pairs(arg_168_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_171_5 then
						iter_171_5.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_168_1.var_.actorSpriteComps10115 = nil
			end

			local var_171_5 = arg_168_1.actors_["10128"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_5) and arg_168_1.var_.actorSpriteComps10128 == nil then
				arg_168_1.var_.actorSpriteComps10128 = var_171_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_6 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_6 and not isNil(var_171_5) then
				if arg_168_1.var_.actorSpriteComps10128 then
					for iter_171_6, iter_171_7 in pairs(arg_168_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_171_7 then
							if arg_168_1.isInRecall_ then
								iter_171_7.color = Color.New(Mathf.Lerp(iter_171_7.color.r, arg_168_1.hightColor2.r, (arg_168_1.time_ - 0) / var_171_6), Mathf.Lerp(iter_171_7.color.g, arg_168_1.hightColor2.g, (arg_168_1.time_ - 0) / var_171_6), (Mathf.Lerp(iter_171_7.color.b, arg_168_1.hightColor2.b, (arg_168_1.time_ - 0) / var_171_6)))
							else
								local var_171_7 = Mathf.Lerp(iter_171_7.color.r, 0.5, (arg_168_1.time_ - 0) / var_171_6)

								iter_171_7.color = Color.New(var_171_7, var_171_7, var_171_7)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= 0 + var_171_6 and arg_168_1.time_ < 0 + var_171_6 + arg_171_0 and not isNil(var_171_5) and arg_168_1.var_.actorSpriteComps10128 then
				for iter_171_8, iter_171_9 in pairs(arg_168_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_171_9 then
						iter_171_9.color = arg_168_1.isInRecall_ and (arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_168_1.var_.actorSpriteComps10128 = nil
			end

			local var_171_8 = arg_168_1.actors_["10128"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos10128 = var_171_8.localPosition
				var_171_8.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10128", 2)

				for iter_171_10 = 0, var_171_8.childCount - 1 do
					local var_171_9 = var_171_8:GetChild(iter_171_10)

					if var_171_9.name == "" or not string.find(var_171_9.name, "split") then
						var_171_9.gameObject:SetActive(true)
					else
						var_171_9.gameObject:SetActive(false)
					end
				end
			end

			local var_171_10 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_10 then
				var_171_8.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10128, Vector3.New(-390, -347, -300), (arg_168_1.time_ - 0) / var_171_10)
			end

			if arg_168_1.time_ >= 0 + var_171_10 and arg_168_1.time_ < 0 + var_171_10 + arg_171_0 then
				var_171_8.localPosition = Vector3.New(-390, -347, -300)
			end

			local var_171_11 = arg_168_1.actors_["10115"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos10115 = var_171_11.localPosition
				var_171_11.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10115", 4)

				for iter_171_11 = 0, var_171_11.childCount - 1 do
					local var_171_12 = var_171_11:GetChild(iter_171_11)

					if var_171_12.name == "split_6" or not string.find(var_171_12.name, "split") then
						var_171_12.gameObject:SetActive(true)
					else
						var_171_12.gameObject:SetActive(false)
					end
				end
			end

			local var_171_13 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_13 then
				var_171_11.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10115, Vector3.New(390, -355, -140), (arg_168_1.time_ - 0) / var_171_13)
			end

			if arg_168_1.time_ >= 0 + var_171_13 and arg_168_1.time_ < 0 + var_171_13 + arg_171_0 then
				var_171_11.localPosition = Vector3.New(390, -355, -140)
			end

			local var_171_14 = 0
			local var_171_15 = 0.375

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_14 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_16 = arg_168_1:GetWordFromCfg(417181041)
				local var_171_17 = arg_168_1:FormatText(var_171_16.content)

				arg_168_1.text_.text = var_171_17

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_19 = 15 <= 0 and var_171_15 or var_171_15 * (utf8.len(var_171_17) / 15)

				if (15 <= 0 and var_171_15 or var_171_15 * (utf8.len(var_171_17) / 15)) > 0 and var_171_15 < var_171_19 then
					arg_168_1.talkMaxDuration = var_171_19

					if var_171_19 + var_171_14 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_19 + var_171_14
					end
				end

				arg_168_1.text_.text = var_171_17
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181041", "story_v_out_417181.awb") ~= 0 then
					local var_171_20 = manager.audio:GetVoiceLength("story_v_out_417181", "417181041", "story_v_out_417181.awb") / 1000

					if var_171_20 + var_171_14 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_20 + var_171_14
					end

					if var_171_16.prefab_name ~= "" and arg_168_1.actors_[var_171_16.prefab_name] ~= nil then
						local var_171_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_16.prefab_name].transform, "story_v_out_417181", "417181041", "story_v_out_417181.awb")

						arg_168_1:RecordAudio("417181041", var_171_21)
						arg_168_1:RecordAudio("417181041", var_171_21)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_417181", "417181041", "story_v_out_417181.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_417181", "417181041", "story_v_out_417181.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_22 = math.max(var_171_15, arg_168_1.talkMaxDuration)

			if var_171_14 <= arg_168_1.time_ and arg_168_1.time_ < var_171_14 + var_171_22 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_14) / var_171_22

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_14 + var_171_22 and arg_168_1.time_ < var_171_14 + var_171_22 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_168_1:InitPlayNodeList()
	end,
	Play417181042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 417181042
		arg_172_1.duration_ = 5.2

		local var_172_0 = {
			zh = 3.433,
			ja = 5.2
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
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play417181043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["10128"]) and arg_172_1.var_.actorSpriteComps10128 == nil then
				arg_172_1.var_.actorSpriteComps10128 = arg_172_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_0 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["10128"]) then
				if arg_172_1.var_.actorSpriteComps10128 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_175_1 then
							if arg_172_1.isInRecall_ then
								iter_175_1.color = Color.New(Mathf.Lerp(iter_175_1.color.r, arg_172_1.hightColor1.r, (arg_172_1.time_ - 0) / var_175_0), Mathf.Lerp(iter_175_1.color.g, arg_172_1.hightColor1.g, (arg_172_1.time_ - 0) / var_175_0), (Mathf.Lerp(iter_175_1.color.b, arg_172_1.hightColor1.b, (arg_172_1.time_ - 0) / var_175_0)))
							else
								local var_175_1 = Mathf.Lerp(iter_175_1.color.r, 1, (arg_172_1.time_ - 0) / var_175_0)

								iter_175_1.color = Color.New(var_175_1, var_175_1, var_175_1)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["10128"]) and arg_172_1.var_.actorSpriteComps10128 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_175_3 then
						iter_175_3.color = arg_172_1.isInRecall_ and (arg_172_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_172_1.var_.actorSpriteComps10128 = nil
			end

			local var_175_2 = arg_172_1.actors_["10115"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.actorSpriteComps10115 == nil then
				arg_172_1.var_.actorSpriteComps10115 = var_175_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_3 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_3 and not isNil(var_175_2) then
				if arg_172_1.var_.actorSpriteComps10115 then
					for iter_175_4, iter_175_5 in pairs(arg_172_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_175_5 then
							if arg_172_1.isInRecall_ then
								iter_175_5.color = Color.New(Mathf.Lerp(iter_175_5.color.r, arg_172_1.hightColor2.r, (arg_172_1.time_ - 0) / var_175_3), Mathf.Lerp(iter_175_5.color.g, arg_172_1.hightColor2.g, (arg_172_1.time_ - 0) / var_175_3), (Mathf.Lerp(iter_175_5.color.b, arg_172_1.hightColor2.b, (arg_172_1.time_ - 0) / var_175_3)))
							else
								local var_175_4 = Mathf.Lerp(iter_175_5.color.r, 0.5, (arg_172_1.time_ - 0) / var_175_3)

								iter_175_5.color = Color.New(var_175_4, var_175_4, var_175_4)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= 0 + var_175_3 and arg_172_1.time_ < 0 + var_175_3 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.actorSpriteComps10115 then
				for iter_175_6, iter_175_7 in pairs(arg_172_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_175_7 then
						iter_175_7.color = arg_172_1.isInRecall_ and (arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_172_1.var_.actorSpriteComps10115 = nil
			end

			local var_175_5 = 0
			local var_175_6 = 0.425

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_7 = arg_172_1:GetWordFromCfg(417181042)
				local var_175_8 = arg_172_1:FormatText(var_175_7.content)

				arg_172_1.text_.text = var_175_8

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_10 = 17 <= 0 and var_175_6 or var_175_6 * (utf8.len(var_175_8) / 17)

				if (17 <= 0 and var_175_6 or var_175_6 * (utf8.len(var_175_8) / 17)) > 0 and var_175_6 < var_175_10 then
					arg_172_1.talkMaxDuration = var_175_10

					if var_175_10 + var_175_5 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_10 + var_175_5
					end
				end

				arg_172_1.text_.text = var_175_8
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181042", "story_v_out_417181.awb") ~= 0 then
					local var_175_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181042", "story_v_out_417181.awb") / 1000

					if var_175_11 + var_175_5 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_11 + var_175_5
					end

					if var_175_7.prefab_name ~= "" and arg_172_1.actors_[var_175_7.prefab_name] ~= nil then
						local var_175_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_7.prefab_name].transform, "story_v_out_417181", "417181042", "story_v_out_417181.awb")

						arg_172_1:RecordAudio("417181042", var_175_12)
						arg_172_1:RecordAudio("417181042", var_175_12)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_417181", "417181042", "story_v_out_417181.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_417181", "417181042", "story_v_out_417181.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_13 = math.max(var_175_6, arg_172_1.talkMaxDuration)

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_13 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_5) / var_175_13

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_5 + var_175_13 and arg_172_1.time_ < var_175_5 + var_175_13 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play417181043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 417181043
		arg_176_1.duration_ = 8.73

		local var_176_0 = {
			zh = 7.133,
			ja = 8.733
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play417181044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.85

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:GetWordFromCfg(417181043)
				local var_179_2 = arg_176_1:FormatText(var_179_1.content)

				arg_176_1.text_.text = var_179_2

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_4 = 34 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 34)

				if (34 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 34)) > 0 and var_179_0 < var_179_4 then
					arg_176_1.talkMaxDuration = var_179_4

					if var_179_4 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_4 + 0
					end
				end

				arg_176_1.text_.text = var_179_2
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181043", "story_v_out_417181.awb") ~= 0 then
					local var_179_5 = manager.audio:GetVoiceLength("story_v_out_417181", "417181043", "story_v_out_417181.awb") / 1000

					if var_179_5 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + 0
					end

					if var_179_1.prefab_name ~= "" and arg_176_1.actors_[var_179_1.prefab_name] ~= nil then
						local var_179_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_1.prefab_name].transform, "story_v_out_417181", "417181043", "story_v_out_417181.awb")

						arg_176_1:RecordAudio("417181043", var_179_6)
						arg_176_1:RecordAudio("417181043", var_179_6)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_417181", "417181043", "story_v_out_417181.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_417181", "417181043", "story_v_out_417181.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play417181044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 417181044
		arg_180_1.duration_ = 6.77

		local var_180_0 = {
			zh = 3.3,
			ja = 6.766
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play417181045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["10115"]) and arg_180_1.var_.actorSpriteComps10115 == nil then
				arg_180_1.var_.actorSpriteComps10115 = arg_180_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_0 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["10115"]) then
				if arg_180_1.var_.actorSpriteComps10115 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								iter_183_1.color = Color.New(Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor1.r, (arg_180_1.time_ - 0) / var_183_0), Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor1.g, (arg_180_1.time_ - 0) / var_183_0), (Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor1.b, (arg_180_1.time_ - 0) / var_183_0)))
							else
								local var_183_1 = Mathf.Lerp(iter_183_1.color.r, 1, (arg_180_1.time_ - 0) / var_183_0)

								iter_183_1.color = Color.New(var_183_1, var_183_1, var_183_1)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["10115"]) and arg_180_1.var_.actorSpriteComps10115 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_183_3 then
						iter_183_3.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_180_1.var_.actorSpriteComps10115 = nil
			end

			local var_183_2 = arg_180_1.actors_["10128"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.actorSpriteComps10128 == nil then
				arg_180_1.var_.actorSpriteComps10128 = var_183_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_3 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_3 and not isNil(var_183_2) then
				if arg_180_1.var_.actorSpriteComps10128 then
					for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_183_5 then
							if arg_180_1.isInRecall_ then
								iter_183_5.color = Color.New(Mathf.Lerp(iter_183_5.color.r, arg_180_1.hightColor2.r, (arg_180_1.time_ - 0) / var_183_3), Mathf.Lerp(iter_183_5.color.g, arg_180_1.hightColor2.g, (arg_180_1.time_ - 0) / var_183_3), (Mathf.Lerp(iter_183_5.color.b, arg_180_1.hightColor2.b, (arg_180_1.time_ - 0) / var_183_3)))
							else
								local var_183_4 = Mathf.Lerp(iter_183_5.color.r, 0.5, (arg_180_1.time_ - 0) / var_183_3)

								iter_183_5.color = Color.New(var_183_4, var_183_4, var_183_4)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_3 and arg_180_1.time_ < 0 + var_183_3 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.actorSpriteComps10128 then
				for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_183_7 then
						iter_183_7.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_180_1.var_.actorSpriteComps10128 = nil
			end

			local var_183_5 = 0
			local var_183_6 = 0.45

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_7 = arg_180_1:GetWordFromCfg(417181044)
				local var_183_8 = arg_180_1:FormatText(var_183_7.content)

				arg_180_1.text_.text = var_183_8

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_10 = 18 <= 0 and var_183_6 or var_183_6 * (utf8.len(var_183_8) / 18)

				if (18 <= 0 and var_183_6 or var_183_6 * (utf8.len(var_183_8) / 18)) > 0 and var_183_6 < var_183_10 then
					arg_180_1.talkMaxDuration = var_183_10

					if var_183_10 + var_183_5 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_5
					end
				end

				arg_180_1.text_.text = var_183_8
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181044", "story_v_out_417181.awb") ~= 0 then
					local var_183_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181044", "story_v_out_417181.awb") / 1000

					if var_183_11 + var_183_5 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_11 + var_183_5
					end

					if var_183_7.prefab_name ~= "" and arg_180_1.actors_[var_183_7.prefab_name] ~= nil then
						local var_183_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_7.prefab_name].transform, "story_v_out_417181", "417181044", "story_v_out_417181.awb")

						arg_180_1:RecordAudio("417181044", var_183_12)
						arg_180_1:RecordAudio("417181044", var_183_12)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_417181", "417181044", "story_v_out_417181.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_417181", "417181044", "story_v_out_417181.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_13 = math.max(var_183_6, arg_180_1.talkMaxDuration)

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_13 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_5) / var_183_13

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_5 + var_183_13 and arg_180_1.time_ < var_183_5 + var_183_13 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play417181045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 417181045
		arg_184_1.duration_ = 8.2

		local var_184_0 = {
			zh = 6.9,
			ja = 8.2
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play417181046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0.825

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_1 = arg_184_1:GetWordFromCfg(417181045)
				local var_187_2 = arg_184_1:FormatText(var_187_1.content)

				arg_184_1.text_.text = var_187_2

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_4 = 33 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_2) / 33)

				if (33 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_2) / 33)) > 0 and var_187_0 < var_187_4 then
					arg_184_1.talkMaxDuration = var_187_4

					if var_187_4 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_4 + 0
					end
				end

				arg_184_1.text_.text = var_187_2
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181045", "story_v_out_417181.awb") ~= 0 then
					local var_187_5 = manager.audio:GetVoiceLength("story_v_out_417181", "417181045", "story_v_out_417181.awb") / 1000

					if var_187_5 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + 0
					end

					if var_187_1.prefab_name ~= "" and arg_184_1.actors_[var_187_1.prefab_name] ~= nil then
						local var_187_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_1.prefab_name].transform, "story_v_out_417181", "417181045", "story_v_out_417181.awb")

						arg_184_1:RecordAudio("417181045", var_187_6)
						arg_184_1:RecordAudio("417181045", var_187_6)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_417181", "417181045", "story_v_out_417181.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_417181", "417181045", "story_v_out_417181.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_7 = math.max(var_187_0, arg_184_1.talkMaxDuration)

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_7 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - 0) / var_187_7

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= 0 + var_187_7 and arg_184_1.time_ < 0 + var_187_7 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play417181046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 417181046
		arg_188_1.duration_ = 8.9

		local var_188_0 = {
			zh = 5.233,
			ja = 8.9
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play417181047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["10128"]) and arg_188_1.var_.actorSpriteComps10128 == nil then
				arg_188_1.var_.actorSpriteComps10128 = arg_188_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_0 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["10128"]) then
				if arg_188_1.var_.actorSpriteComps10128 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								iter_191_1.color = Color.New(Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor1.r, (arg_188_1.time_ - 0) / var_191_0), Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor1.g, (arg_188_1.time_ - 0) / var_191_0), (Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor1.b, (arg_188_1.time_ - 0) / var_191_0)))
							else
								local var_191_1 = Mathf.Lerp(iter_191_1.color.r, 1, (arg_188_1.time_ - 0) / var_191_0)

								iter_191_1.color = Color.New(var_191_1, var_191_1, var_191_1)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["10128"]) and arg_188_1.var_.actorSpriteComps10128 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_191_3 then
						iter_191_3.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_188_1.var_.actorSpriteComps10128 = nil
			end

			local var_191_2 = arg_188_1.actors_["10115"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.actorSpriteComps10115 == nil then
				arg_188_1.var_.actorSpriteComps10115 = var_191_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_3 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_3 and not isNil(var_191_2) then
				if arg_188_1.var_.actorSpriteComps10115 then
					for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_191_5 then
							if arg_188_1.isInRecall_ then
								iter_191_5.color = Color.New(Mathf.Lerp(iter_191_5.color.r, arg_188_1.hightColor2.r, (arg_188_1.time_ - 0) / var_191_3), Mathf.Lerp(iter_191_5.color.g, arg_188_1.hightColor2.g, (arg_188_1.time_ - 0) / var_191_3), (Mathf.Lerp(iter_191_5.color.b, arg_188_1.hightColor2.b, (arg_188_1.time_ - 0) / var_191_3)))
							else
								local var_191_4 = Mathf.Lerp(iter_191_5.color.r, 0.5, (arg_188_1.time_ - 0) / var_191_3)

								iter_191_5.color = Color.New(var_191_4, var_191_4, var_191_4)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_3 and arg_188_1.time_ < 0 + var_191_3 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.actorSpriteComps10115 then
				for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_191_7 then
						iter_191_7.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_188_1.var_.actorSpriteComps10115 = nil
			end

			local var_191_5 = 0
			local var_191_6 = 0.7

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_7 = arg_188_1:GetWordFromCfg(417181046)
				local var_191_8 = arg_188_1:FormatText(var_191_7.content)

				arg_188_1.text_.text = var_191_8

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_10 = 28 <= 0 and var_191_6 or var_191_6 * (utf8.len(var_191_8) / 28)

				if (28 <= 0 and var_191_6 or var_191_6 * (utf8.len(var_191_8) / 28)) > 0 and var_191_6 < var_191_10 then
					arg_188_1.talkMaxDuration = var_191_10

					if var_191_10 + var_191_5 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_10 + var_191_5
					end
				end

				arg_188_1.text_.text = var_191_8
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181046", "story_v_out_417181.awb") ~= 0 then
					local var_191_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181046", "story_v_out_417181.awb") / 1000

					if var_191_11 + var_191_5 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_11 + var_191_5
					end

					if var_191_7.prefab_name ~= "" and arg_188_1.actors_[var_191_7.prefab_name] ~= nil then
						local var_191_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_7.prefab_name].transform, "story_v_out_417181", "417181046", "story_v_out_417181.awb")

						arg_188_1:RecordAudio("417181046", var_191_12)
						arg_188_1:RecordAudio("417181046", var_191_12)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_417181", "417181046", "story_v_out_417181.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_417181", "417181046", "story_v_out_417181.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_13 = math.max(var_191_6, arg_188_1.talkMaxDuration)

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_13 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_5) / var_191_13

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_5 + var_191_13 and arg_188_1.time_ < var_191_5 + var_191_13 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play417181047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 417181047
		arg_192_1.duration_ = 1.87

		local var_192_0 = {
			zh = 1.2,
			ja = 1.866
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play417181048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["10115"]) and arg_192_1.var_.actorSpriteComps10115 == nil then
				arg_192_1.var_.actorSpriteComps10115 = arg_192_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_0 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["10115"]) then
				if arg_192_1.var_.actorSpriteComps10115 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								iter_195_1.color = Color.New(Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor1.r, (arg_192_1.time_ - 0) / var_195_0), Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor1.g, (arg_192_1.time_ - 0) / var_195_0), (Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor1.b, (arg_192_1.time_ - 0) / var_195_0)))
							else
								local var_195_1 = Mathf.Lerp(iter_195_1.color.r, 1, (arg_192_1.time_ - 0) / var_195_0)

								iter_195_1.color = Color.New(var_195_1, var_195_1, var_195_1)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["10115"]) and arg_192_1.var_.actorSpriteComps10115 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_195_3 then
						iter_195_3.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_192_1.var_.actorSpriteComps10115 = nil
			end

			local var_195_2 = arg_192_1.actors_["10128"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.actorSpriteComps10128 == nil then
				arg_192_1.var_.actorSpriteComps10128 = var_195_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_3 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_3 and not isNil(var_195_2) then
				if arg_192_1.var_.actorSpriteComps10128 then
					for iter_195_4, iter_195_5 in pairs(arg_192_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_195_5 then
							if arg_192_1.isInRecall_ then
								iter_195_5.color = Color.New(Mathf.Lerp(iter_195_5.color.r, arg_192_1.hightColor2.r, (arg_192_1.time_ - 0) / var_195_3), Mathf.Lerp(iter_195_5.color.g, arg_192_1.hightColor2.g, (arg_192_1.time_ - 0) / var_195_3), (Mathf.Lerp(iter_195_5.color.b, arg_192_1.hightColor2.b, (arg_192_1.time_ - 0) / var_195_3)))
							else
								local var_195_4 = Mathf.Lerp(iter_195_5.color.r, 0.5, (arg_192_1.time_ - 0) / var_195_3)

								iter_195_5.color = Color.New(var_195_4, var_195_4, var_195_4)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_3 and arg_192_1.time_ < 0 + var_195_3 + arg_195_0 and not isNil(var_195_2) and arg_192_1.var_.actorSpriteComps10128 then
				for iter_195_6, iter_195_7 in pairs(arg_192_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_195_7 then
						iter_195_7.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_192_1.var_.actorSpriteComps10128 = nil
			end

			local var_195_5 = 0
			local var_195_6 = 0.1

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_7 = arg_192_1:GetWordFromCfg(417181047)
				local var_195_8 = arg_192_1:FormatText(var_195_7.content)

				arg_192_1.text_.text = var_195_8

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_10 = 4 <= 0 and var_195_6 or var_195_6 * (utf8.len(var_195_8) / 4)

				if (4 <= 0 and var_195_6 or var_195_6 * (utf8.len(var_195_8) / 4)) > 0 and var_195_6 < var_195_10 then
					arg_192_1.talkMaxDuration = var_195_10

					if var_195_10 + var_195_5 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_10 + var_195_5
					end
				end

				arg_192_1.text_.text = var_195_8
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181047", "story_v_out_417181.awb") ~= 0 then
					local var_195_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181047", "story_v_out_417181.awb") / 1000

					if var_195_11 + var_195_5 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_11 + var_195_5
					end

					if var_195_7.prefab_name ~= "" and arg_192_1.actors_[var_195_7.prefab_name] ~= nil then
						local var_195_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_7.prefab_name].transform, "story_v_out_417181", "417181047", "story_v_out_417181.awb")

						arg_192_1:RecordAudio("417181047", var_195_12)
						arg_192_1:RecordAudio("417181047", var_195_12)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_417181", "417181047", "story_v_out_417181.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_417181", "417181047", "story_v_out_417181.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_13 = math.max(var_195_6, arg_192_1.talkMaxDuration)

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_13 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_5) / var_195_13

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_5 + var_195_13 and arg_192_1.time_ < var_195_5 + var_195_13 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play417181048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 417181048
		arg_196_1.duration_ = 9.4

		local var_196_0 = {
			zh = 8.4,
			ja = 9.4
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
				arg_196_0:Play417181049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["10128"]) and arg_196_1.var_.actorSpriteComps10128 == nil then
				arg_196_1.var_.actorSpriteComps10128 = arg_196_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_0 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["10128"]) then
				if arg_196_1.var_.actorSpriteComps10128 then
					for iter_199_0, iter_199_1 in pairs(arg_196_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_199_1 then
							if arg_196_1.isInRecall_ then
								iter_199_1.color = Color.New(Mathf.Lerp(iter_199_1.color.r, arg_196_1.hightColor1.r, (arg_196_1.time_ - 0) / var_199_0), Mathf.Lerp(iter_199_1.color.g, arg_196_1.hightColor1.g, (arg_196_1.time_ - 0) / var_199_0), (Mathf.Lerp(iter_199_1.color.b, arg_196_1.hightColor1.b, (arg_196_1.time_ - 0) / var_199_0)))
							else
								local var_199_1 = Mathf.Lerp(iter_199_1.color.r, 1, (arg_196_1.time_ - 0) / var_199_0)

								iter_199_1.color = Color.New(var_199_1, var_199_1, var_199_1)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["10128"]) and arg_196_1.var_.actorSpriteComps10128 then
				for iter_199_2, iter_199_3 in pairs(arg_196_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_199_3 then
						iter_199_3.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_196_1.var_.actorSpriteComps10128 = nil
			end

			local var_199_2 = arg_196_1.actors_["10115"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps10115 == nil then
				arg_196_1.var_.actorSpriteComps10115 = var_199_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_3 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 and not isNil(var_199_2) then
				if arg_196_1.var_.actorSpriteComps10115 then
					for iter_199_4, iter_199_5 in pairs(arg_196_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_199_5 then
							if arg_196_1.isInRecall_ then
								iter_199_5.color = Color.New(Mathf.Lerp(iter_199_5.color.r, arg_196_1.hightColor2.r, (arg_196_1.time_ - 0) / var_199_3), Mathf.Lerp(iter_199_5.color.g, arg_196_1.hightColor2.g, (arg_196_1.time_ - 0) / var_199_3), (Mathf.Lerp(iter_199_5.color.b, arg_196_1.hightColor2.b, (arg_196_1.time_ - 0) / var_199_3)))
							else
								local var_199_4 = Mathf.Lerp(iter_199_5.color.r, 0.5, (arg_196_1.time_ - 0) / var_199_3)

								iter_199_5.color = Color.New(var_199_4, var_199_4, var_199_4)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.actorSpriteComps10115 then
				for iter_199_6, iter_199_7 in pairs(arg_196_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_199_7 then
						iter_199_7.color = arg_196_1.isInRecall_ and (arg_196_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_196_1.var_.actorSpriteComps10115 = nil
			end

			local var_199_5 = 0
			local var_199_6 = 0.7

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_7 = arg_196_1:GetWordFromCfg(417181048)
				local var_199_8 = arg_196_1:FormatText(var_199_7.content)

				arg_196_1.text_.text = var_199_8

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_10 = 28 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_8) / 28)

				if (28 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_8) / 28)) > 0 and var_199_6 < var_199_10 then
					arg_196_1.talkMaxDuration = var_199_10

					if var_199_10 + var_199_5 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_5
					end
				end

				arg_196_1.text_.text = var_199_8
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181048", "story_v_out_417181.awb") ~= 0 then
					local var_199_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181048", "story_v_out_417181.awb") / 1000

					if var_199_11 + var_199_5 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_11 + var_199_5
					end

					if var_199_7.prefab_name ~= "" and arg_196_1.actors_[var_199_7.prefab_name] ~= nil then
						local var_199_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_7.prefab_name].transform, "story_v_out_417181", "417181048", "story_v_out_417181.awb")

						arg_196_1:RecordAudio("417181048", var_199_12)
						arg_196_1:RecordAudio("417181048", var_199_12)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_417181", "417181048", "story_v_out_417181.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_417181", "417181048", "story_v_out_417181.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_13 = math.max(var_199_6, arg_196_1.talkMaxDuration)

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_13 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_5) / var_199_13

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_5 + var_199_13 and arg_196_1.time_ < var_199_5 + var_199_13 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play417181049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 417181049
		arg_200_1.duration_ = 6.23

		local var_200_0 = {
			zh = 4.366,
			ja = 6.233
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play417181050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["10115"]) and arg_200_1.var_.actorSpriteComps10115 == nil then
				arg_200_1.var_.actorSpriteComps10115 = arg_200_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_0 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["10115"]) then
				if arg_200_1.var_.actorSpriteComps10115 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								iter_203_1.color = Color.New(Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor1.r, (arg_200_1.time_ - 0) / var_203_0), Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor1.g, (arg_200_1.time_ - 0) / var_203_0), (Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor1.b, (arg_200_1.time_ - 0) / var_203_0)))
							else
								local var_203_1 = Mathf.Lerp(iter_203_1.color.r, 1, (arg_200_1.time_ - 0) / var_203_0)

								iter_203_1.color = Color.New(var_203_1, var_203_1, var_203_1)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["10115"]) and arg_200_1.var_.actorSpriteComps10115 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_203_3 then
						iter_203_3.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_200_1.var_.actorSpriteComps10115 = nil
			end

			local var_203_2 = arg_200_1.actors_["10128"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10128 == nil then
				arg_200_1.var_.actorSpriteComps10128 = var_203_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_3 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.actorSpriteComps10128 then
					for iter_203_4, iter_203_5 in pairs(arg_200_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_203_5 then
							if arg_200_1.isInRecall_ then
								iter_203_5.color = Color.New(Mathf.Lerp(iter_203_5.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 0) / var_203_3), Mathf.Lerp(iter_203_5.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 0) / var_203_3), (Mathf.Lerp(iter_203_5.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 0) / var_203_3)))
							else
								local var_203_4 = Mathf.Lerp(iter_203_5.color.r, 0.5, (arg_200_1.time_ - 0) / var_203_3)

								iter_203_5.color = Color.New(var_203_4, var_203_4, var_203_4)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps10128 then
				for iter_203_6, iter_203_7 in pairs(arg_200_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_203_7 then
						iter_203_7.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps10128 = nil
			end

			local var_203_5 = 0
			local var_203_6 = 0.5

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_5 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_7 = arg_200_1:GetWordFromCfg(417181049)
				local var_203_8 = arg_200_1:FormatText(var_203_7.content)

				arg_200_1.text_.text = var_203_8

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_10 = 20 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_8) / 20)

				if (20 <= 0 and var_203_6 or var_203_6 * (utf8.len(var_203_8) / 20)) > 0 and var_203_6 < var_203_10 then
					arg_200_1.talkMaxDuration = var_203_10

					if var_203_10 + var_203_5 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_5
					end
				end

				arg_200_1.text_.text = var_203_8
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181049", "story_v_out_417181.awb") ~= 0 then
					local var_203_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181049", "story_v_out_417181.awb") / 1000

					if var_203_11 + var_203_5 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_11 + var_203_5
					end

					if var_203_7.prefab_name ~= "" and arg_200_1.actors_[var_203_7.prefab_name] ~= nil then
						local var_203_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_7.prefab_name].transform, "story_v_out_417181", "417181049", "story_v_out_417181.awb")

						arg_200_1:RecordAudio("417181049", var_203_12)
						arg_200_1:RecordAudio("417181049", var_203_12)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_417181", "417181049", "story_v_out_417181.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_417181", "417181049", "story_v_out_417181.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_13 = math.max(var_203_6, arg_200_1.talkMaxDuration)

			if var_203_5 <= arg_200_1.time_ and arg_200_1.time_ < var_203_5 + var_203_13 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_5) / var_203_13

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_5 + var_203_13 and arg_200_1.time_ < var_203_5 + var_203_13 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play417181050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 417181050
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play417181051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["10115"]) and arg_204_1.var_.actorSpriteComps10115 == nil then
				arg_204_1.var_.actorSpriteComps10115 = arg_204_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_0 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["10115"]) then
				if arg_204_1.var_.actorSpriteComps10115 then
					for iter_207_0, iter_207_1 in pairs(arg_204_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_207_1 then
							if arg_204_1.isInRecall_ then
								iter_207_1.color = Color.New(Mathf.Lerp(iter_207_1.color.r, arg_204_1.hightColor2.r, (arg_204_1.time_ - 0) / var_207_0), Mathf.Lerp(iter_207_1.color.g, arg_204_1.hightColor2.g, (arg_204_1.time_ - 0) / var_207_0), (Mathf.Lerp(iter_207_1.color.b, arg_204_1.hightColor2.b, (arg_204_1.time_ - 0) / var_207_0)))
							else
								local var_207_1 = Mathf.Lerp(iter_207_1.color.r, 0.5, (arg_204_1.time_ - 0) / var_207_0)

								iter_207_1.color = Color.New(var_207_1, var_207_1, var_207_1)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["10115"]) and arg_204_1.var_.actorSpriteComps10115 then
				for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_207_3 then
						iter_207_3.color = arg_204_1.isInRecall_ and (arg_204_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_204_1.var_.actorSpriteComps10115 = nil
			end

			local var_207_2 = arg_204_1.actors_["10128"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10128 = var_207_2.localPosition
				var_207_2.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10128", 7)

				for iter_207_4 = 0, var_207_2.childCount - 1 do
					local var_207_3 = var_207_2:GetChild(iter_207_4)

					if var_207_3.name == "" or not string.find(var_207_3.name, "split") then
						var_207_3.gameObject:SetActive(true)
					else
						var_207_3.gameObject:SetActive(false)
					end
				end
			end

			local var_207_4 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				var_207_2.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_204_1.time_ - 0) / var_207_4)
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				var_207_2.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_207_5 = arg_204_1.actors_["10115"].transform

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10115 = var_207_5.localPosition
				var_207_5.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10115", 7)

				for iter_207_5 = 0, var_207_5.childCount - 1 do
					local var_207_6 = var_207_5:GetChild(iter_207_5)

					if var_207_6.name == "" or not string.find(var_207_6.name, "split") then
						var_207_6.gameObject:SetActive(true)
					else
						var_207_6.gameObject:SetActive(false)
					end
				end
			end

			local var_207_7 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				var_207_5.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10115, Vector3.New(0, -2000, -140), (arg_204_1.time_ - 0) / var_207_7)
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				var_207_5.localPosition = Vector3.New(0, -2000, -140)
			end

			if 0.566666666666667 < arg_204_1.time_ and arg_204_1.time_ <= 0.566666666666667 + arg_207_0 then
				arg_204_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_push01", "")
			end

			local var_207_9 = 0
			local var_207_10 = 0.875

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_9 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_11 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(417181050).content)

				arg_204_1.text_.text = var_207_11

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_13 = 35 <= 0 and var_207_10 or var_207_10 * (utf8.len(var_207_11) / 35)

				if (35 <= 0 and var_207_10 or var_207_10 * (utf8.len(var_207_11) / 35)) > 0 and var_207_10 < var_207_13 then
					arg_204_1.talkMaxDuration = var_207_13

					if var_207_13 + var_207_9 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_13 + var_207_9
					end
				end

				arg_204_1.text_.text = var_207_11
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_14 = math.max(var_207_10, arg_204_1.talkMaxDuration)

			if var_207_9 <= arg_204_1.time_ and arg_204_1.time_ < var_207_9 + var_207_14 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_9) / var_207_14

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_9 + var_207_14 and arg_204_1.time_ < var_207_9 + var_207_14 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_204_1:InitPlayNodeList()
	end,
	Play417181051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 417181051
		arg_208_1.duration_ = 5.97

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play417181052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				local var_211_0 = arg_208_1.var_.effect417181051

				if not arg_208_1.var_.effect417181051 then
					var_211_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_211_0.name = "417181051"
					arg_208_1.var_.effect417181051 = var_211_0
				else
					var_211_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_211_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_211_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.26666666666667 < arg_208_1.time_ and arg_208_1.time_ <= 1.26666666666667 + arg_211_0 then
				if arg_208_1.var_.effect417181051 then
					Object.Destroy(arg_208_1.var_.effect417181051)

					arg_208_1.var_.effect417181051 = nil
				end
			end

			local var_211_3 = manager.ui.mainCamera.transform

			if 0.0666666666666667 < arg_208_1.time_ and arg_208_1.time_ <= 0.0666666666666667 + arg_211_0 then
				arg_208_1.var_.shakeOldPos = var_211_3.localPosition
			end

			local var_211_4 = 0.4

			if 0.0666666666666667 <= arg_208_1.time_ and arg_208_1.time_ < 0.0666666666666667 + var_211_4 then
				local var_211_5, var_211_6 = math.modf((arg_208_1.time_ - 0.0666666666666667) / 0.066)

				var_211_3.localPosition = Vector3.New(var_211_6 * 0.13, var_211_6 * 0.13, var_211_6 * 0.13) + arg_208_1.var_.shakeOldPos
			end

			if arg_208_1.time_ >= 0.0666666666666667 + var_211_4 and arg_208_1.time_ < 0.0666666666666667 + var_211_4 + arg_211_0 then
				var_211_3.localPosition = arg_208_1.var_.shakeOldPos
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:AudioAction("play", "effect", "se_story_10", "se_story_10_sword02", "")
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_8 = 0.966666666666667
			local var_211_9 = 1.65

			if 0.966666666666667 < arg_208_1.time_ and arg_208_1.time_ <= var_211_8 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_10 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_10:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_11 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(417181051).content)

				arg_208_1.text_.text = var_211_11

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_13 = 66 <= 0 and var_211_9 or var_211_9 * (utf8.len(var_211_11) / 66)

				if (66 <= 0 and var_211_9 or var_211_9 * (utf8.len(var_211_11) / 66)) > 0 and var_211_9 < var_211_13 then
					arg_208_1.talkMaxDuration = var_211_13
					var_211_8 = var_211_8 + 0.3

					if var_211_13 + var_211_8 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_13 + var_211_8
					end
				end

				arg_208_1.text_.text = var_211_11
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_14 = var_211_8 + 0.3
			local var_211_15 = math.max(var_211_9, arg_208_1.talkMaxDuration)

			if var_211_8 + 0.3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_14 + var_211_15 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_14) / var_211_15

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_14 + var_211_15 and arg_208_1.time_ < var_211_14 + var_211_15 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play417181052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 417181052
		arg_214_1.duration_ = 1

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play417181053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["10115"]) and arg_214_1.var_.actorSpriteComps10115 == nil then
				arg_214_1.var_.actorSpriteComps10115 = arg_214_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_0 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["10115"]) then
				if arg_214_1.var_.actorSpriteComps10115 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps10115:ToTable()) do
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

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["10115"]) and arg_214_1.var_.actorSpriteComps10115 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_217_3 then
						iter_217_3.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_214_1.var_.actorSpriteComps10115 = nil
			end

			local var_217_2 = arg_214_1.actors_["10115"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos10115 = var_217_2.localPosition
				var_217_2.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("10115", 3)

				for iter_217_4 = 0, var_217_2.childCount - 1 do
					local var_217_3 = var_217_2:GetChild(iter_217_4)

					if var_217_3.name == "split_1" or not string.find(var_217_3.name, "split") then
						var_217_3.gameObject:SetActive(true)
					else
						var_217_3.gameObject:SetActive(false)
					end
				end
			end

			local var_217_4 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				var_217_2.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10115, Vector3.New(0, -355, -140), (arg_214_1.time_ - 0) / var_217_4)
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				var_217_2.localPosition = Vector3.New(0, -355, -140)
			end

			local var_217_5 = 0
			local var_217_6 = 0.075

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_7 = arg_214_1:GetWordFromCfg(417181052)
				local var_217_8 = arg_214_1:FormatText(var_217_7.content)

				arg_214_1.text_.text = var_217_8

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_10 = 3 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_8) / 3)

				if (3 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_8) / 3)) > 0 and var_217_6 < var_217_10 then
					arg_214_1.talkMaxDuration = var_217_10

					if var_217_10 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_5
					end
				end

				arg_214_1.text_.text = var_217_8
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181052", "story_v_out_417181.awb") ~= 0 then
					local var_217_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181052", "story_v_out_417181.awb") / 1000

					if var_217_11 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_11 + var_217_5
					end

					if var_217_7.prefab_name ~= "" and arg_214_1.actors_[var_217_7.prefab_name] ~= nil then
						local var_217_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_7.prefab_name].transform, "story_v_out_417181", "417181052", "story_v_out_417181.awb")

						arg_214_1:RecordAudio("417181052", var_217_12)
						arg_214_1:RecordAudio("417181052", var_217_12)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_417181", "417181052", "story_v_out_417181.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_417181", "417181052", "story_v_out_417181.awb")
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

		arg_214_1.nodeConfigList_ = {
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

		arg_214_1:InitPlayNodeList()
	end,
	Play417181053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 417181053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play417181054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["10115"]) and arg_218_1.var_.actorSpriteComps10115 == nil then
				arg_218_1.var_.actorSpriteComps10115 = arg_218_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_0 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["10115"]) then
				if arg_218_1.var_.actorSpriteComps10115 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								iter_221_1.color = Color.New(Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor2.r, (arg_218_1.time_ - 0) / var_221_0), Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor2.g, (arg_218_1.time_ - 0) / var_221_0), (Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor2.b, (arg_218_1.time_ - 0) / var_221_0)))
							else
								local var_221_1 = Mathf.Lerp(iter_221_1.color.r, 0.5, (arg_218_1.time_ - 0) / var_221_0)

								iter_221_1.color = Color.New(var_221_1, var_221_1, var_221_1)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["10115"]) and arg_218_1.var_.actorSpriteComps10115 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_221_3 then
						iter_221_3.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_218_1.var_.actorSpriteComps10115 = nil
			end

			local var_221_2 = arg_218_1.actors_["10115"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos10115 = var_221_2.localPosition
				var_221_2.localScale = Vector3.New(1, 1, 1)

				arg_218_1:CheckSpriteTmpPos("10115", 7)

				for iter_221_4 = 0, var_221_2.childCount - 1 do
					local var_221_3 = var_221_2:GetChild(iter_221_4)

					if var_221_3.name == "" or not string.find(var_221_3.name, "split") then
						var_221_3.gameObject:SetActive(true)
					else
						var_221_3.gameObject:SetActive(false)
					end
				end
			end

			local var_221_4 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				var_221_2.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10115, Vector3.New(0, -2000, -140), (arg_218_1.time_ - 0) / var_221_4)
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				var_221_2.localPosition = Vector3.New(0, -2000, -140)
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun02", "")
			end

			local var_221_6 = 0
			local var_221_7 = 1.175

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_6 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_8 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(417181053).content)

				arg_218_1.text_.text = var_221_8

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_10 = 47 <= 0 and var_221_7 or var_221_7 * (utf8.len(var_221_8) / 47)

				if (47 <= 0 and var_221_7 or var_221_7 * (utf8.len(var_221_8) / 47)) > 0 and var_221_7 < var_221_10 then
					arg_218_1.talkMaxDuration = var_221_10

					if var_221_10 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_6
					end
				end

				arg_218_1.text_.text = var_221_8
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_11 = math.max(var_221_7, arg_218_1.talkMaxDuration)

			if var_221_6 <= arg_218_1.time_ and arg_218_1.time_ < var_221_6 + var_221_11 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_6) / var_221_11

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_6 + var_221_11 and arg_218_1.time_ < var_221_6 + var_221_11 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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

		arg_218_1:InitPlayNodeList()
	end,
	Play417181054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 417181054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play417181055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 1.275

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(417181054).content)

				arg_222_1.text_.text = var_225_1

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_3 = 51 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 51)

				if (51 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 51)) > 0 and var_225_0 < var_225_3 then
					arg_222_1.talkMaxDuration = var_225_3

					if var_225_3 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_3 + 0
					end
				end

				arg_222_1.text_.text = var_225_1
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_4 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_4

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play417181055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 417181055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play417181056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0.6 < arg_226_1.time_ and arg_226_1.time_ <= 0.6 + arg_229_0 then
				arg_226_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_lightmagic", "")
			end

			local var_229_1 = 0
			local var_229_2 = 1.6

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_3 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(417181055).content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 64 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 64)

				if (64 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 64)) > 0 and var_229_2 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_6 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_6 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_6

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_6 and arg_226_1.time_ < var_229_1 + var_229_6 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play417181056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 417181056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play417181057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 1.23333333333333 < arg_230_1.time_ and arg_230_1.time_ <= 1.23333333333333 + arg_233_0 then
				arg_230_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_metal01", "")
			end

			local var_233_1 = 0
			local var_233_2 = 2

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_3 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(417181056).content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 80 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 80)

				if (80 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 80)) > 0 and var_233_2 < var_233_5 then
					arg_230_1.talkMaxDuration = var_233_5

					if var_233_5 + var_233_1 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + var_233_1
					end
				end

				arg_230_1.text_.text = var_233_3
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_6 = math.max(var_233_2, arg_230_1.talkMaxDuration)

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_6 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_1) / var_233_6

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_1 + var_233_6 and arg_230_1.time_ < var_233_1 + var_233_6 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play417181057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 417181057
		arg_234_1.duration_ = 2.93

		local var_234_0 = {
			zh = 2.633,
			ja = 2.933
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play417181058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_9000

			if 1 < arg_234_1.time_ and arg_234_1.time_ <= 1 + arg_237_0 and not isNil(arg_234_1.actors_["10115"]) and arg_234_1.var_.actorSpriteComps10115 == nil then
				arg_234_1.var_.actorSpriteComps10115 = arg_234_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_0 = 0.2

			if 1 <= arg_234_1.time_ and arg_234_1.time_ < 1 + var_237_0 and not isNil(arg_234_1.actors_["10115"]) then
				if arg_234_1.var_.actorSpriteComps10115 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								iter_237_1.color = Color.New(Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor1.r, (arg_234_1.time_ - 1) / var_237_0), Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor1.g, (arg_234_1.time_ - 1) / var_237_0), (Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor1.b, (arg_234_1.time_ - 1) / var_237_0)))
							else
								local var_237_1 = Mathf.Lerp(iter_237_1.color.r, 1, (arg_234_1.time_ - 1) / var_237_0)

								iter_237_1.color = Color.New(var_237_1, var_237_1, var_237_1)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 1 + var_237_0 and arg_234_1.time_ < 1 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["10115"]) and arg_234_1.var_.actorSpriteComps10115 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_237_3 then
						iter_237_3.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_234_1.var_.actorSpriteComps10115 = nil
			end

			local var_237_2 = arg_234_1.actors_["10115"].transform

			if 1 < arg_234_1.time_ and arg_234_1.time_ <= 1 + arg_237_0 then
				arg_234_1.var_.moveOldPos10115 = var_237_2.localPosition
				var_237_2.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("10115", 3)

				for iter_237_4 = 0, var_237_2.childCount - 1 do
					local var_237_3 = var_237_2:GetChild(iter_237_4)

					if var_237_3.name == "split_3" or not string.find(var_237_3.name, "split") then
						var_237_3.gameObject:SetActive(true)
					else
						var_237_3.gameObject:SetActive(false)
					end
				end
			end

			local var_237_4 = 0.001

			if 1 <= arg_234_1.time_ and arg_234_1.time_ < 1 + var_237_4 then
				var_237_2.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10115, Vector3.New(0, -355, -140), (arg_234_1.time_ - 1) / var_237_4)
			end

			if arg_234_1.time_ >= 1 + var_237_4 and arg_234_1.time_ < 1 + var_237_4 + arg_237_0 then
				var_237_2.localPosition = Vector3.New(0, -355, -140)
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				local var_237_5 = arg_234_1.var_.effect417181057

				if not arg_234_1.var_.effect417181057 then
					var_237_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_237_5.name = "417181057"
					arg_234_1.var_.effect417181057 = var_237_5
				else
					var_237_5.transform:SetParent(var_237_9000)
				end

				var_237_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_237_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_234_1.time_ and arg_234_1.time_ <= 1 + arg_237_0 then
				if arg_234_1.var_.effect417181057 then
					Object.Destroy(arg_234_1.var_.effect417181057)

					arg_234_1.var_.effect417181057 = nil
				end
			end

			local var_237_8 = manager.ui.mainCamera.transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.shakeOldPos = var_237_8.localPosition
			end

			local var_237_9 = 0.666666666666667

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_9 then
				local var_237_10, var_237_11 = math.modf((arg_234_1.time_ - 0) / 0.066)

				var_237_8.localPosition = Vector3.New(var_237_11 * 0.13, var_237_11 * 0.13, var_237_11 * 0.13) + arg_234_1.var_.shakeOldPos
			end

			if arg_234_1.time_ >= 0 + var_237_9 and arg_234_1.time_ < 0 + var_237_9 + arg_237_0 then
				var_237_8.localPosition = arg_234_1.var_.shakeOldPos
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_sword02", "")
			end

			local var_237_13 = 1
			local var_237_14 = 0.2

			if 1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_13 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_15 = arg_234_1:GetWordFromCfg(417181057)
				local var_237_16 = arg_234_1:FormatText(var_237_15.content)

				arg_234_1.text_.text = var_237_16

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_18 = 8 <= 0 and var_237_14 or var_237_14 * (utf8.len(var_237_16) / 8)

				if (8 <= 0 and var_237_14 or var_237_14 * (utf8.len(var_237_16) / 8)) > 0 and var_237_14 < var_237_18 then
					arg_234_1.talkMaxDuration = var_237_18

					if var_237_18 + var_237_13 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_18 + var_237_13
					end
				end

				arg_234_1.text_.text = var_237_16
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181057", "story_v_out_417181.awb") ~= 0 then
					local var_237_19 = manager.audio:GetVoiceLength("story_v_out_417181", "417181057", "story_v_out_417181.awb") / 1000

					if var_237_19 + var_237_13 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_19 + var_237_13
					end

					if var_237_15.prefab_name ~= "" and arg_234_1.actors_[var_237_15.prefab_name] ~= nil then
						local var_237_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_15.prefab_name].transform, "story_v_out_417181", "417181057", "story_v_out_417181.awb")

						arg_234_1:RecordAudio("417181057", var_237_20)
						arg_234_1:RecordAudio("417181057", var_237_20)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_417181", "417181057", "story_v_out_417181.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_417181", "417181057", "story_v_out_417181.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_21 = math.max(var_237_14, arg_234_1.talkMaxDuration)

			if var_237_13 <= arg_234_1.time_ and arg_234_1.time_ < var_237_13 + var_237_21 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_13) / var_237_21

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_13 + var_237_21 and arg_234_1.time_ < var_237_13 + var_237_21 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play417181058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 417181058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play417181059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos10115 = arg_238_1.actors_["10115"].transform.localPosition
				arg_238_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("10115", 7)

				for iter_241_0 = 0, arg_238_1.actors_["10115"].transform.childCount - 1 do
					local var_241_0 = arg_238_1.actors_["10115"].transform:GetChild(iter_241_0)

					if var_241_0.name == "" or not string.find(var_241_0.name, "split") then
						var_241_0.gameObject:SetActive(true)
					else
						var_241_0.gameObject:SetActive(false)
					end
				end
			end

			local var_241_1 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_1 then
				arg_238_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10115, Vector3.New(0, -2000, -140), (arg_238_1.time_ - 0) / var_241_1)
			end

			if arg_238_1.time_ >= 0 + var_241_1 and arg_238_1.time_ < 0 + var_241_1 + arg_241_0 then
				arg_238_1.actors_["10115"].transform.localPosition = Vector3.New(0, -2000, -140)
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_metal02", "")
			end

			local var_241_3 = 0
			local var_241_4 = 1.8

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_3 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0

				arg_238_1.dialog_:SetActive(true)

				arg_238_1.dialogCg_.alpha = 0

				local var_241_5 = LeanTween.value(arg_238_1.dialog_, 0, 1, 0.3)

				var_241_5:setOnUpdate(LuaHelper.FloatAction(function(arg_242_0)
					arg_238_1.dialogCg_.alpha = arg_242_0
				end))
				var_241_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_238_1.dialog_)
					var_241_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_238_1.duration_ = arg_238_1.duration_ + 0.3

				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_6 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(417181058).content)

				arg_238_1.text_.text = var_241_6

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_8 = 72 <= 0 and var_241_4 or var_241_4 * (utf8.len(var_241_6) / 72)

				if (72 <= 0 and var_241_4 or var_241_4 * (utf8.len(var_241_6) / 72)) > 0 and var_241_4 < var_241_8 then
					arg_238_1.talkMaxDuration = var_241_8
					var_241_3 = var_241_3 + 0.3

					if var_241_8 + var_241_3 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_3
					end
				end

				arg_238_1.text_.text = var_241_6
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_9 = var_241_3 + 0.3
			local var_241_10 = math.max(var_241_4, arg_238_1.talkMaxDuration)

			if var_241_3 + 0.3 <= arg_238_1.time_ and arg_238_1.time_ < var_241_9 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_9) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_9 + var_241_10 and arg_238_1.time_ < var_241_9 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
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

		arg_238_1:InitPlayNodeList()
	end,
	Play417181059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 417181059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play417181060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 1.15

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_1 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(417181059).content)

				arg_244_1.text_.text = var_247_1

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_3 = 46 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 46)

				if (46 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 46)) > 0 and var_247_0 < var_247_3 then
					arg_244_1.talkMaxDuration = var_247_3

					if var_247_3 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_3 + 0
					end
				end

				arg_244_1.text_.text = var_247_1
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_4 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_4

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play417181060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 417181060
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play417181061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0.02 < arg_248_1.time_ and arg_248_1.time_ <= 0.02 + arg_251_0 then
				arg_248_1:AudioAction("play", "effect", "se_story_16", "se_story_16_thunder02", "")
			end

			local var_251_1 = 0
			local var_251_2 = 1.725

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_3 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(417181060).content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 69 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 69)

				if (69 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 69)) > 0 and var_251_2 < var_251_5 then
					arg_248_1.talkMaxDuration = var_251_5

					if var_251_5 + var_251_1 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + var_251_1
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_6 = math.max(var_251_2, arg_248_1.talkMaxDuration)

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_6 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_1) / var_251_6

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_1 + var_251_6 and arg_248_1.time_ < var_251_1 + var_251_6 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play417181061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 417181061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play417181062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0.02 < arg_252_1.time_ and arg_252_1.time_ <= 0.02 + arg_255_0 then
				arg_252_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_blood", "")
			end

			local var_255_1 = 0
			local var_255_2 = 0.55

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_3 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(417181061).content)

				arg_252_1.text_.text = var_255_3

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 22 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 22)

				if (22 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 22)) > 0 and var_255_2 < var_255_5 then
					arg_252_1.talkMaxDuration = var_255_5

					if var_255_5 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_3
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_6 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_6 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_6

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_6 and arg_252_1.time_ < var_255_1 + var_255_6 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play417181062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 417181062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play417181063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.8

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_1 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(417181062).content)

				arg_256_1.text_.text = var_259_1

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_3 = 32 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 32)

				if (32 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 32)) > 0 and var_259_0 < var_259_3 then
					arg_256_1.talkMaxDuration = var_259_3

					if var_259_3 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_3 + 0
					end
				end

				arg_256_1.text_.text = var_259_1
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_4 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_4

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play417181063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 417181063
		arg_260_1.duration_ = 1.33

		local var_260_0 = {
			zh = 1.333,
			ja = 1.3
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
			arg_260_1.auto_ = false
		end

		function arg_260_1.playNext_(arg_262_0)
			arg_260_1.onStoryFinished_()
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["10115"]) and arg_260_1.var_.actorSpriteComps10115 == nil then
				arg_260_1.var_.actorSpriteComps10115 = arg_260_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_263_0 = 0.2

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["10115"]) then
				if arg_260_1.var_.actorSpriteComps10115 then
					for iter_263_0, iter_263_1 in pairs(arg_260_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_263_1 then
							if arg_260_1.isInRecall_ then
								iter_263_1.color = Color.New(Mathf.Lerp(iter_263_1.color.r, arg_260_1.hightColor1.r, (arg_260_1.time_ - 0) / var_263_0), Mathf.Lerp(iter_263_1.color.g, arg_260_1.hightColor1.g, (arg_260_1.time_ - 0) / var_263_0), (Mathf.Lerp(iter_263_1.color.b, arg_260_1.hightColor1.b, (arg_260_1.time_ - 0) / var_263_0)))
							else
								local var_263_1 = Mathf.Lerp(iter_263_1.color.r, 1, (arg_260_1.time_ - 0) / var_263_0)

								iter_263_1.color = Color.New(var_263_1, var_263_1, var_263_1)
							end
						end
					end
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["10115"]) and arg_260_1.var_.actorSpriteComps10115 then
				for iter_263_2, iter_263_3 in pairs(arg_260_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_263_3 then
						iter_263_3.color = arg_260_1.isInRecall_ and (arg_260_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_260_1.var_.actorSpriteComps10115 = nil
			end

			local var_263_2 = arg_260_1.actors_["10115"].transform

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos10115 = var_263_2.localPosition
				var_263_2.localScale = Vector3.New(1, 1, 1)

				arg_260_1:CheckSpriteTmpPos("10115", 3)

				for iter_263_4 = 0, var_263_2.childCount - 1 do
					local var_263_3 = var_263_2:GetChild(iter_263_4)

					if var_263_3.name == "split_6" or not string.find(var_263_3.name, "split") then
						var_263_3.gameObject:SetActive(true)
					else
						var_263_3.gameObject:SetActive(false)
					end
				end
			end

			local var_263_4 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 then
				var_263_2.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10115, Vector3.New(0, -355, -140), (arg_260_1.time_ - 0) / var_263_4)
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 then
				var_263_2.localPosition = Vector3.New(0, -355, -140)
			end

			local var_263_5 = 0
			local var_263_6 = 0.1

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_5 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_7 = arg_260_1:GetWordFromCfg(417181063)
				local var_263_8 = arg_260_1:FormatText(var_263_7.content)

				arg_260_1.text_.text = var_263_8

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_10 = 4 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_8) / 4)

				if (4 <= 0 and var_263_6 or var_263_6 * (utf8.len(var_263_8) / 4)) > 0 and var_263_6 < var_263_10 then
					arg_260_1.talkMaxDuration = var_263_10

					if var_263_10 + var_263_5 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_10 + var_263_5
					end
				end

				arg_260_1.text_.text = var_263_8
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417181", "417181063", "story_v_out_417181.awb") ~= 0 then
					local var_263_11 = manager.audio:GetVoiceLength("story_v_out_417181", "417181063", "story_v_out_417181.awb") / 1000

					if var_263_11 + var_263_5 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_11 + var_263_5
					end

					if var_263_7.prefab_name ~= "" and arg_260_1.actors_[var_263_7.prefab_name] ~= nil then
						local var_263_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_7.prefab_name].transform, "story_v_out_417181", "417181063", "story_v_out_417181.awb")

						arg_260_1:RecordAudio("417181063", var_263_12)
						arg_260_1:RecordAudio("417181063", var_263_12)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_417181", "417181063", "story_v_out_417181.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_417181", "417181063", "story_v_out_417181.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_13 = math.max(var_263_6, arg_260_1.talkMaxDuration)

			if var_263_5 <= arg_260_1.time_ and arg_260_1.time_ < var_263_5 + var_263_13 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_5) / var_263_13

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_5 + var_263_13 and arg_260_1.time_ < var_263_5 + var_263_13 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
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

		arg_260_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B01"
	},
	voices = {
		"story_v_out_417181.awb"
	}
}
