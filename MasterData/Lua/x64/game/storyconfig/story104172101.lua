return {
	Play417211001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417211001
		arg_1_1.duration_ = 12.4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417211002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 7.4 < arg_1_1.time_ and arg_1_1.time_ <= 7.4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 7.4 + 0.500000000001 and arg_1_1.time_ < 7.4 + 0.500000000001 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "B02c"

			if arg_1_1.bgs_.B02c == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_2 = arg_1_1.bgs_.B02c

				arg_1_1.bgs_.B02c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_3 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_3 and var_4_3.sprite then
					local var_4_4 = 2 * (var_4_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_2.transform.localScale = Vector3.New(var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B02c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B02c")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501063).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501064).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_5 + 5 and arg_1_1.time_ < var_4_5 + 5 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_6 = 5

			if 5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_7 = 1.2

			if var_4_6 <= arg_1_1.time_ and arg_1_1.time_ < var_4_6 + var_4_7 then
				local var_4_8 = Color.New(0, 0, 0)

				var_4_8.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_6) / var_4_7)
				arg_1_1.mask_.color = var_4_8
			end

			if arg_1_1.time_ >= var_4_6 + var_4_7 and arg_1_1.time_ < var_4_6 + var_4_7 + arg_4_0 then
				local var_4_9 = Color.New(0, 0, 0)

				var_4_9.a = 1
				arg_1_1.mask_.color = var_4_9
			end

			local var_4_10 = 6.2

			if 6.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_11 = 1.2

			if var_4_10 <= arg_1_1.time_ and arg_1_1.time_ < var_4_10 + var_4_11 then
				local var_4_12 = Color.New(0, 0, 0)

				var_4_12.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_10) / var_4_11)
				arg_1_1.mask_.color = var_4_12
			end

			if arg_1_1.time_ >= var_4_10 + var_4_11 and arg_1_1.time_ < var_4_10 + var_4_11 + arg_4_0 then
				local var_4_13 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_13.a = 0
				arg_1_1.mask_.color = var_4_13
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

			if 5.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 5.73333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 7.4
			local var_4_26 = 0.825

			if 7.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
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

				local var_4_28 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(417211001).content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 33 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_28) / 33)

				if (33 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_28) / 33)) > 0 and var_4_26 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_25 = var_4_25 + 0.3

					if var_4_30 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_25 + 0.3
			local var_4_32 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417211002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417211002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417211003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 1.125

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

				local var_13_1 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(417211002).content)

				arg_10_1.text_.text = var_13_1

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_3 = 45 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_1) / 45)

				if (45 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_1) / 45)) > 0 and var_13_0 < var_13_3 then
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
	Play417211003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417211003
		arg_14_1.duration_ = 4.23

		local var_14_0 = {
			zh = 3.3,
			ja = 4.233
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417211004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0.375

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[1120].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_1 = arg_14_1:GetWordFromCfg(417211003)
				local var_17_2 = arg_14_1:FormatText(var_17_1.content)

				arg_14_1.text_.text = var_17_2

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 15 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 15)

				if (15 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 15)) > 0 and var_17_0 < var_17_4 then
					arg_14_1.talkMaxDuration = var_17_4

					if var_17_4 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_4 + 0
					end
				end

				arg_14_1.text_.text = var_17_2
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211003", "story_v_out_417211.awb") ~= 0 then
					local var_17_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211003", "story_v_out_417211.awb") / 1000

					if var_17_5 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_5 + 0
					end

					if var_17_1.prefab_name ~= "" and arg_14_1.actors_[var_17_1.prefab_name] ~= nil then
						local var_17_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_1.prefab_name].transform, "story_v_out_417211", "417211003", "story_v_out_417211.awb")

						arg_14_1:RecordAudio("417211003", var_17_6)
						arg_14_1:RecordAudio("417211003", var_17_6)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417211", "417211003", "story_v_out_417211.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417211", "417211003", "story_v_out_417211.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_7 and arg_14_1.time_ < 0 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417211004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417211004
		arg_18_1.duration_ = 2.07

		local var_18_0 = {
			zh = 1.466,
			ja = 2.066
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
				arg_18_0:Play417211005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if arg_18_1.actors_["10113"] == nil then
				local var_21_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10113")

				if not isNil(var_21_0) then
					local var_21_1 = Object.Instantiate(var_21_0, arg_18_1.canvasGo_.transform)

					var_21_1.transform:SetSiblingIndex(1)

					var_21_1.name = "10113"
					var_21_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_18_1.actors_["10113"] = var_21_1

					if arg_18_1.isInRecall_ then
						for iter_21_0, iter_21_1 in ipairs((var_21_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_21_1.color = arg_18_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_21_2 = arg_18_1.actors_["10113"].transform

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos10113 = var_21_2.localPosition
				var_21_2.localScale = Vector3.New(1, 1, 1)

				arg_18_1:CheckSpriteTmpPos("10113", 3)

				for iter_21_2 = 0, var_21_2.childCount - 1 do
					local var_21_3 = var_21_2:GetChild(iter_21_2)

					if var_21_3.name == "split_3" or not string.find(var_21_3.name, "split") then
						var_21_3.gameObject:SetActive(true)
					else
						var_21_3.gameObject:SetActive(false)
					end
				end
			end

			local var_21_4 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_4 then
				var_21_2.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10113, Vector3.New(-30.38, -328.4, -517.4), (arg_18_1.time_ - 0) / var_21_4)
			end

			if arg_18_1.time_ >= 0 + var_21_4 and arg_18_1.time_ < 0 + var_21_4 + arg_21_0 then
				var_21_2.localPosition = Vector3.New(-30.38, -328.4, -517.4)
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				local var_21_5 = arg_18_1.actors_["10113"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_21_5 then
					arg_18_1.var_.alphaOldValue10113 = var_21_5.alpha
					arg_18_1.var_.characterEffect10113 = var_21_5
				end
			end

			local var_21_6 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_6 then
				if arg_18_1.var_.characterEffect10113 then
					arg_18_1.var_.characterEffect10113.alpha = Mathf.Lerp(arg_18_1.var_.alphaOldValue10113, 0.6, (arg_18_1.time_ - 0) / var_21_6)
				end
			end

			if arg_18_1.time_ >= 0 + var_21_6 and arg_18_1.time_ < 0 + var_21_6 + arg_21_0 and arg_18_1.var_.characterEffect10113 then
				arg_18_1.var_.characterEffect10113.alpha = 0.6
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:SetSpriteNiuquEffect("10113", true)
			end

			local var_21_8 = 0
			local var_21_9 = 0.125

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_8 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_10 = arg_18_1:GetWordFromCfg(417211004)
				local var_21_11 = arg_18_1:FormatText(var_21_10.content)

				arg_18_1.text_.text = var_21_11

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_13 = 5 <= 0 and var_21_9 or var_21_9 * (utf8.len(var_21_11) / 5)

				if (5 <= 0 and var_21_9 or var_21_9 * (utf8.len(var_21_11) / 5)) > 0 and var_21_9 < var_21_13 then
					arg_18_1.talkMaxDuration = var_21_13

					if var_21_13 + var_21_8 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_13 + var_21_8
					end
				end

				arg_18_1.text_.text = var_21_11
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211004", "story_v_out_417211.awb") ~= 0 then
					local var_21_14 = manager.audio:GetVoiceLength("story_v_out_417211", "417211004", "story_v_out_417211.awb") / 1000

					if var_21_14 + var_21_8 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_14 + var_21_8
					end

					if var_21_10.prefab_name ~= "" and arg_18_1.actors_[var_21_10.prefab_name] ~= nil then
						local var_21_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_10.prefab_name].transform, "story_v_out_417211", "417211004", "story_v_out_417211.awb")

						arg_18_1:RecordAudio("417211004", var_21_15)
						arg_18_1:RecordAudio("417211004", var_21_15)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_417211", "417211004", "story_v_out_417211.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_417211", "417211004", "story_v_out_417211.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_16 = math.max(var_21_9, arg_18_1.talkMaxDuration)

			if var_21_8 <= arg_18_1.time_ and arg_18_1.time_ < var_21_8 + var_21_16 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_8) / var_21_16

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_8 + var_21_16 and arg_18_1.time_ < var_21_8 + var_21_16 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
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

		arg_18_1:InitPlayNodeList()
	end,
	Play417211005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417211005
		arg_22_1.duration_ = 4.73

		local var_22_0 = {
			zh = 2.7,
			ja = 4.733
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
				arg_22_0:Play417211006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(arg_22_1.actors_["10113"]) and arg_22_1.var_.actorSpriteComps10113 == nil then
				arg_22_1.var_.actorSpriteComps10113 = arg_22_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_0 = 0.2

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 and not isNil(arg_22_1.actors_["10113"]) then
				if arg_22_1.var_.actorSpriteComps10113 then
					for iter_25_0, iter_25_1 in pairs(arg_22_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_25_1 then
							if arg_22_1.isInRecall_ then
								iter_25_1.color = Color.New(Mathf.Lerp(iter_25_1.color.r, arg_22_1.hightColor2.r, (arg_22_1.time_ - 0) / var_25_0), Mathf.Lerp(iter_25_1.color.g, arg_22_1.hightColor2.g, (arg_22_1.time_ - 0) / var_25_0), (Mathf.Lerp(iter_25_1.color.b, arg_22_1.hightColor2.b, (arg_22_1.time_ - 0) / var_25_0)))
							else
								local var_25_1 = Mathf.Lerp(iter_25_1.color.r, 0.5, (arg_22_1.time_ - 0) / var_25_0)

								iter_25_1.color = Color.New(var_25_1, var_25_1, var_25_1)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 and not isNil(arg_22_1.actors_["10113"]) and arg_22_1.var_.actorSpriteComps10113 then
				for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_25_3 then
						iter_25_3.color = arg_22_1.isInRecall_ and (arg_22_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_22_1.var_.actorSpriteComps10113 = nil
			end

			local var_25_2 = 0
			local var_25_3 = 0.3

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1120].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_4 = arg_22_1:GetWordFromCfg(417211005)
				local var_25_5 = arg_22_1:FormatText(var_25_4.content)

				arg_22_1.text_.text = var_25_5

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_7 = 12 <= 0 and var_25_3 or var_25_3 * (utf8.len(var_25_5) / 12)

				if (12 <= 0 and var_25_3 or var_25_3 * (utf8.len(var_25_5) / 12)) > 0 and var_25_3 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_2 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_2
					end
				end

				arg_22_1.text_.text = var_25_5
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211005", "story_v_out_417211.awb") ~= 0 then
					local var_25_8 = manager.audio:GetVoiceLength("story_v_out_417211", "417211005", "story_v_out_417211.awb") / 1000

					if var_25_8 + var_25_2 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_8 + var_25_2
					end

					if var_25_4.prefab_name ~= "" and arg_22_1.actors_[var_25_4.prefab_name] ~= nil then
						local var_25_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_4.prefab_name].transform, "story_v_out_417211", "417211005", "story_v_out_417211.awb")

						arg_22_1:RecordAudio("417211005", var_25_9)
						arg_22_1:RecordAudio("417211005", var_25_9)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417211", "417211005", "story_v_out_417211.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417211", "417211005", "story_v_out_417211.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_10 = math.max(var_25_3, arg_22_1.talkMaxDuration)

			if var_25_2 <= arg_22_1.time_ and arg_22_1.time_ < var_25_2 + var_25_10 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_2) / var_25_10

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_2 + var_25_10 and arg_22_1.time_ < var_25_2 + var_25_10 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play417211006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417211006
		arg_26_1.duration_ = 9.4

		local var_26_0 = {
			zh = 7.1,
			ja = 9.4
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
				arg_26_0:Play417211007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 1

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1120].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_1 = arg_26_1:GetWordFromCfg(417211006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 40 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 40)

				if (40 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 40)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211006", "story_v_out_417211.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211006", "story_v_out_417211.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_417211", "417211006", "story_v_out_417211.awb")

						arg_26_1:RecordAudio("417211006", var_29_6)
						arg_26_1:RecordAudio("417211006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417211", "417211006", "story_v_out_417211.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417211", "417211006", "story_v_out_417211.awb")
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
	Play417211007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417211007
		arg_30_1.duration_ = 3.67

		local var_30_0 = {
			zh = 3.133,
			ja = 3.666
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
				arg_30_0:Play417211008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				local var_33_0 = arg_30_1.actors_["10113"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_33_0 then
					arg_30_1.var_.alphaOldValue10113 = var_33_0.alpha
					arg_30_1.var_.characterEffect10113 = var_33_0
				end
			end

			local var_33_1 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_1 then
				if arg_30_1.var_.characterEffect10113 then
					arg_30_1.var_.characterEffect10113.alpha = Mathf.Lerp(arg_30_1.var_.alphaOldValue10113, 0.6, (arg_30_1.time_ - 0) / var_33_1)
				end
			end

			if arg_30_1.time_ >= 0 + var_33_1 and arg_30_1.time_ < 0 + var_33_1 + arg_33_0 and arg_30_1.var_.characterEffect10113 then
				arg_30_1.var_.characterEffect10113.alpha = 0.6
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:SetSpriteNiuquEffect("10113", true)
			end

			local var_33_3 = 0
			local var_33_4 = 0.4

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_3 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_5 = arg_30_1:GetWordFromCfg(417211007)
				local var_33_6 = arg_30_1:FormatText(var_33_5.content)

				arg_30_1.text_.text = var_33_6

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_8 = 16 <= 0 and var_33_4 or var_33_4 * (utf8.len(var_33_6) / 16)

				if (16 <= 0 and var_33_4 or var_33_4 * (utf8.len(var_33_6) / 16)) > 0 and var_33_4 < var_33_8 then
					arg_30_1.talkMaxDuration = var_33_8

					if var_33_8 + var_33_3 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_3
					end
				end

				arg_30_1.text_.text = var_33_6
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211007", "story_v_out_417211.awb") ~= 0 then
					local var_33_9 = manager.audio:GetVoiceLength("story_v_out_417211", "417211007", "story_v_out_417211.awb") / 1000

					if var_33_9 + var_33_3 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_9 + var_33_3
					end

					if var_33_5.prefab_name ~= "" and arg_30_1.actors_[var_33_5.prefab_name] ~= nil then
						local var_33_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_5.prefab_name].transform, "story_v_out_417211", "417211007", "story_v_out_417211.awb")

						arg_30_1:RecordAudio("417211007", var_33_10)
						arg_30_1:RecordAudio("417211007", var_33_10)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417211", "417211007", "story_v_out_417211.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417211", "417211007", "story_v_out_417211.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_11 = math.max(var_33_4, arg_30_1.talkMaxDuration)

			if var_33_3 <= arg_30_1.time_ and arg_30_1.time_ < var_33_3 + var_33_11 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_3) / var_33_11

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_3 + var_33_11 and arg_30_1.time_ < var_33_3 + var_33_11 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play417211008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417211008
		arg_34_1.duration_ = 1.4

		local var_34_0 = {
			zh = 1.4,
			ja = 1.3
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
				arg_34_0:Play417211009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["10113"]) and arg_34_1.var_.actorSpriteComps10113 == nil then
				arg_34_1.var_.actorSpriteComps10113 = arg_34_1.actors_["10113"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_0 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["10113"]) then
				if arg_34_1.var_.actorSpriteComps10113 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps10113:ToTable()) do
						if iter_37_1 then
							if arg_34_1.isInRecall_ then
								iter_37_1.color = Color.New(Mathf.Lerp(iter_37_1.color.r, arg_34_1.hightColor2.r, (arg_34_1.time_ - 0) / var_37_0), Mathf.Lerp(iter_37_1.color.g, arg_34_1.hightColor2.g, (arg_34_1.time_ - 0) / var_37_0), (Mathf.Lerp(iter_37_1.color.b, arg_34_1.hightColor2.b, (arg_34_1.time_ - 0) / var_37_0)))
							else
								local var_37_1 = Mathf.Lerp(iter_37_1.color.r, 0.5, (arg_34_1.time_ - 0) / var_37_0)

								iter_37_1.color = Color.New(var_37_1, var_37_1, var_37_1)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["10113"]) and arg_34_1.var_.actorSpriteComps10113 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps10113:ToTable()) do
					if iter_37_3 then
						iter_37_3.color = arg_34_1.isInRecall_ and (arg_34_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_34_1.var_.actorSpriteComps10113 = nil
			end

			local var_37_2 = 0
			local var_37_3 = 0.1

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_2 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1120].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerma")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_4 = arg_34_1:GetWordFromCfg(417211008)
				local var_37_5 = arg_34_1:FormatText(var_37_4.content)

				arg_34_1.text_.text = var_37_5

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_7 = 4 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 4)

				if (4 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 4)) > 0 and var_37_3 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_2
					end
				end

				arg_34_1.text_.text = var_37_5
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211008", "story_v_out_417211.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_417211", "417211008", "story_v_out_417211.awb") / 1000

					if var_37_8 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_2
					end

					if var_37_4.prefab_name ~= "" and arg_34_1.actors_[var_37_4.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_4.prefab_name].transform, "story_v_out_417211", "417211008", "story_v_out_417211.awb")

						arg_34_1:RecordAudio("417211008", var_37_9)
						arg_34_1:RecordAudio("417211008", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417211", "417211008", "story_v_out_417211.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417211", "417211008", "story_v_out_417211.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_3, arg_34_1.talkMaxDuration)

			if var_37_2 <= arg_34_1.time_ and arg_34_1.time_ < var_37_2 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_2) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_2 + var_37_10 and arg_34_1.time_ < var_37_2 + var_37_10 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play417211009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417211009
		arg_38_1.duration_ = 8.9

		local var_38_0 = {
			zh = 5.766,
			ja = 8.9
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
				arg_38_0:Play417211010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				local var_41_0 = arg_38_1.actors_["10113"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_41_0 then
					arg_38_1.var_.alphaOldValue10113 = var_41_0.alpha
					arg_38_1.var_.characterEffect10113 = var_41_0
				end
			end

			local var_41_1 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_1 then
				if arg_38_1.var_.characterEffect10113 then
					arg_38_1.var_.characterEffect10113.alpha = Mathf.Lerp(arg_38_1.var_.alphaOldValue10113, 0.6, (arg_38_1.time_ - 0) / var_41_1)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_1 and arg_38_1.time_ < 0 + var_41_1 + arg_41_0 and arg_38_1.var_.characterEffect10113 then
				arg_38_1.var_.characterEffect10113.alpha = 0.6
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:SetSpriteNiuquEffect("10113", true)
			end

			local var_41_3 = 0
			local var_41_4 = 0.8

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_3 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1117].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_5 = arg_38_1:GetWordFromCfg(417211009)
				local var_41_6 = arg_38_1:FormatText(var_41_5.content)

				arg_38_1.text_.text = var_41_6

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_8 = 32 <= 0 and var_41_4 or var_41_4 * (utf8.len(var_41_6) / 32)

				if (32 <= 0 and var_41_4 or var_41_4 * (utf8.len(var_41_6) / 32)) > 0 and var_41_4 < var_41_8 then
					arg_38_1.talkMaxDuration = var_41_8

					if var_41_8 + var_41_3 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_8 + var_41_3
					end
				end

				arg_38_1.text_.text = var_41_6
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211009", "story_v_out_417211.awb") ~= 0 then
					local var_41_9 = manager.audio:GetVoiceLength("story_v_out_417211", "417211009", "story_v_out_417211.awb") / 1000

					if var_41_9 + var_41_3 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_3
					end

					if var_41_5.prefab_name ~= "" and arg_38_1.actors_[var_41_5.prefab_name] ~= nil then
						local var_41_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_5.prefab_name].transform, "story_v_out_417211", "417211009", "story_v_out_417211.awb")

						arg_38_1:RecordAudio("417211009", var_41_10)
						arg_38_1:RecordAudio("417211009", var_41_10)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417211", "417211009", "story_v_out_417211.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417211", "417211009", "story_v_out_417211.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_11 = math.max(var_41_4, arg_38_1.talkMaxDuration)

			if var_41_3 <= arg_38_1.time_ and arg_38_1.time_ < var_41_3 + var_41_11 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_3) / var_41_11

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_3 + var_41_11 and arg_38_1.time_ < var_41_3 + var_41_11 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play417211010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417211010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play417211011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10113 = arg_42_1.actors_["10113"].transform.localPosition
				arg_42_1.actors_["10113"].transform.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10113", 7)

				for iter_45_0 = 0, arg_42_1.actors_["10113"].transform.childCount - 1 do
					local var_45_0 = arg_42_1.actors_["10113"].transform:GetChild(iter_45_0)

					if var_45_0.name == "" or not string.find(var_45_0.name, "split") then
						var_45_0.gameObject:SetActive(true)
					else
						var_45_0.gameObject:SetActive(false)
					end
				end
			end

			local var_45_1 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_1 then
				arg_42_1.actors_["10113"].transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10113, Vector3.New(0, -2000, 0), (arg_42_1.time_ - 0) / var_45_1)
			end

			if arg_42_1.time_ >= 0 + var_45_1 and arg_42_1.time_ < 0 + var_45_1 + arg_45_0 then
				arg_42_1.actors_["10113"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_45_2 = 0
			local var_45_3 = 0.775

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_4 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(417211010).content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_6 = 31 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_4) / 31)

				if (31 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_4) / 31)) > 0 and var_45_3 < var_45_6 then
					arg_42_1.talkMaxDuration = var_45_6

					if var_45_6 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_6 + var_45_2
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_7 = math.max(var_45_3, arg_42_1.talkMaxDuration)

			if var_45_2 <= arg_42_1.time_ and arg_42_1.time_ < var_45_2 + var_45_7 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_2) / var_45_7

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_2 + var_45_7 and arg_42_1.time_ < var_45_2 + var_45_7 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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

		arg_42_1:InitPlayNodeList()
	end,
	Play417211011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417211011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417211012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.875

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(417211011).content)

				arg_46_1.text_.text = var_49_1

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_3 = 35 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 35)

				if (35 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 35)) > 0 and var_49_0 < var_49_3 then
					arg_46_1.talkMaxDuration = var_49_3

					if var_49_3 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_3 + 0
					end
				end

				arg_46_1.text_.text = var_49_1
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_4 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_4

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play417211012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417211012
		arg_50_1.duration_ = 7

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play417211013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 2 < arg_50_1.time_ and arg_50_1.time_ <= 2 + arg_53_0 then
				arg_50_1.allBtn_.enabled = false
			end

			if arg_50_1.time_ >= 2 + 0.666666666666667 and arg_50_1.time_ < 2 + 0.666666666666667 + arg_53_0 then
				arg_50_1.allBtn_.enabled = true
			end

			local var_53_0 = "ST75"

			if arg_50_1.bgs_.ST75 == nil then
				local var_53_1 = Object.Instantiate(arg_50_1.paintGo_)

				var_53_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_53_0)
				var_53_1.name = var_53_0
				var_53_1.transform.parent = arg_50_1.stage_.transform
				var_53_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.bgs_[var_53_0] = var_53_1
			end

			if 1.06666666666667 < arg_50_1.time_ and arg_50_1.time_ <= 1.06666666666667 + arg_53_0 then
				local var_53_2 = arg_50_1.bgs_.ST75

				arg_50_1.bgs_.ST75.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_53_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_53_3 = var_53_2:GetComponent("SpriteRenderer")

				if var_53_3 and var_53_3.sprite then
					local var_53_4 = 2 * (var_53_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_53_2.transform.localScale = Vector3.New(var_53_4 / var_53_3.sprite.bounds.size.y < var_53_4 * manager.ui.mainCameraCom_.aspect / var_53_3.sprite.bounds.size.x and var_53_4 * manager.ui.mainCameraCom_.aspect / var_53_3.sprite.bounds.size.x or var_53_4 / var_53_3.sprite.bounds.size.y, var_53_4 / var_53_3.sprite.bounds.size.y < var_53_4 * manager.ui.mainCameraCom_.aspect / var_53_3.sprite.bounds.size.x and var_53_4 * manager.ui.mainCameraCom_.aspect / var_53_3.sprite.bounds.size.x or var_53_4 / var_53_3.sprite.bounds.size.y, 0)
				end

				for iter_53_0, iter_53_1 in pairs(arg_50_1.bgs_) do
					if iter_53_0 ~= "ST75" then
						iter_53_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_53_5 = 0

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_6 = 1.06666666666667

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_6 then
				local var_53_7 = Color.New(0, 0, 0)

				var_53_7.a = Mathf.Lerp(0, 1, (arg_50_1.time_ - var_53_5) / var_53_6)
				arg_50_1.mask_.color = var_53_7
			end

			if arg_50_1.time_ >= var_53_5 + var_53_6 and arg_50_1.time_ < var_53_5 + var_53_6 + arg_53_0 then
				local var_53_8 = Color.New(0, 0, 0)

				var_53_8.a = 1
				arg_50_1.mask_.color = var_53_8
			end

			local var_53_9 = 1.06666666666667

			if 1.06666666666667 < arg_50_1.time_ and arg_50_1.time_ <= var_53_9 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_10 = 0.933333333333333

			if var_53_9 <= arg_50_1.time_ and arg_50_1.time_ < var_53_9 + var_53_10 then
				local var_53_11 = Color.New(0, 0, 0)

				var_53_11.a = Mathf.Lerp(1, 0, (arg_50_1.time_ - var_53_9) / var_53_10)
				arg_50_1.mask_.color = var_53_11
			end

			if arg_50_1.time_ >= var_53_9 + var_53_10 and arg_50_1.time_ < var_53_9 + var_53_10 + arg_53_0 then
				local var_53_12 = Color.New(0, 0, 0)

				arg_50_1.mask_.enabled = false
				var_53_12.a = 0
				arg_50_1.mask_.color = var_53_12
			end

			if 0.766666666666667 < arg_50_1.time_ and arg_50_1.time_ <= 0.766666666666667 + arg_53_0 then
				arg_50_1:AudioAction("play", "effect", "se_story_138", "se_story_138_carloop", "")
			end

			if arg_50_1.frameCnt_ <= 1 then
				arg_50_1.dialog_:SetActive(false)
			end

			local var_53_14 = 2
			local var_53_15 = 1.375

			if 2 < arg_50_1.time_ and arg_50_1.time_ <= var_53_14 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				arg_50_1.dialog_:SetActive(true)

				arg_50_1.dialogCg_.alpha = 0

				local var_53_16 = LeanTween.value(arg_50_1.dialog_, 0, 1, 0.3)

				var_53_16:setOnUpdate(LuaHelper.FloatAction(function(arg_54_0)
					arg_50_1.dialogCg_.alpha = arg_54_0
				end))
				var_53_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_50_1.dialog_)
					var_53_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_50_1.duration_ = arg_50_1.duration_ + 0.3

				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_17 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(417211012).content)

				arg_50_1.text_.text = var_53_17

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_19 = 55 <= 0 and var_53_15 or var_53_15 * (utf8.len(var_53_17) / 55)

				if (55 <= 0 and var_53_15 or var_53_15 * (utf8.len(var_53_17) / 55)) > 0 and var_53_15 < var_53_19 then
					arg_50_1.talkMaxDuration = var_53_19
					var_53_14 = var_53_14 + 0.3

					if var_53_19 + var_53_14 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_19 + var_53_14
					end
				end

				arg_50_1.text_.text = var_53_17
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_20 = var_53_14 + 0.3
			local var_53_21 = math.max(var_53_15, arg_50_1.talkMaxDuration)

			if var_53_14 + 0.3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_20 + var_53_21 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_20) / var_53_21

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_20 + var_53_21 and arg_50_1.time_ < var_53_20 + var_53_21 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play417211013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 417211013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play417211014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 1.125

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(417211013).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 45 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 45)

				if (45 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 45)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play417211014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 417211014
		arg_60_1.duration_ = 7

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play417211015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 2 < arg_60_1.time_ and arg_60_1.time_ <= 2 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			if arg_60_1.time_ >= 2 + 0.7 and arg_60_1.time_ < 2 + 0.7 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			local var_63_0 = "I16f"

			if arg_60_1.bgs_.I16f == nil then
				local var_63_1 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_63_0)
				var_63_1.name = var_63_0
				var_63_1.transform.parent = arg_60_1.stage_.transform
				var_63_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_[var_63_0] = var_63_1
			end

			if 1 < arg_60_1.time_ and arg_60_1.time_ <= 1 + arg_63_0 then
				local var_63_2 = arg_60_1.bgs_.I16f

				arg_60_1.bgs_.I16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_63_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_3 = var_63_2:GetComponent("SpriteRenderer")

				if var_63_3 and var_63_3.sprite then
					local var_63_4 = 2 * (var_63_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_63_2.transform.localScale = Vector3.New(var_63_4 / var_63_3.sprite.bounds.size.y < var_63_4 * manager.ui.mainCameraCom_.aspect / var_63_3.sprite.bounds.size.x and var_63_4 * manager.ui.mainCameraCom_.aspect / var_63_3.sprite.bounds.size.x or var_63_4 / var_63_3.sprite.bounds.size.y, var_63_4 / var_63_3.sprite.bounds.size.y < var_63_4 * manager.ui.mainCameraCom_.aspect / var_63_3.sprite.bounds.size.x and var_63_4 * manager.ui.mainCameraCom_.aspect / var_63_3.sprite.bounds.size.x or var_63_4 / var_63_3.sprite.bounds.size.y, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "I16f" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_5 = 0

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_6 = 1

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 then
				local var_63_7 = Color.New(0, 0, 0)

				var_63_7.a = Mathf.Lerp(0, 1, (arg_60_1.time_ - var_63_5) / var_63_6)
				arg_60_1.mask_.color = var_63_7
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 then
				local var_63_8 = Color.New(0, 0, 0)

				var_63_8.a = 1
				arg_60_1.mask_.color = var_63_8
			end

			local var_63_9 = 1

			if 1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_10 = 1

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_10 then
				local var_63_11 = Color.New(0, 0, 0)

				var_63_11.a = Mathf.Lerp(1, 0, (arg_60_1.time_ - var_63_9) / var_63_10)
				arg_60_1.mask_.color = var_63_11
			end

			if arg_60_1.time_ >= var_63_9 + var_63_10 and arg_60_1.time_ < var_63_9 + var_63_10 + arg_63_0 then
				local var_63_12 = Color.New(0, 0, 0)

				arg_60_1.mask_.enabled = false
				var_63_12.a = 0
				arg_60_1.mask_.color = var_63_12
			end

			if 0.6 < arg_60_1.time_ and arg_60_1.time_ <= 0.6 + arg_63_0 then
				arg_60_1:AudioAction("stop", "effect", "se_story_138", "se_story_138_carloop", "")
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_14 = 2
			local var_63_15 = 1.4

			if 2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_14 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_16 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_16:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_17 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(417211014).content)

				arg_60_1.text_.text = var_63_17

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_19 = 56 <= 0 and var_63_15 or var_63_15 * (utf8.len(var_63_17) / 56)

				if (56 <= 0 and var_63_15 or var_63_15 * (utf8.len(var_63_17) / 56)) > 0 and var_63_15 < var_63_19 then
					arg_60_1.talkMaxDuration = var_63_19
					var_63_14 = var_63_14 + 0.3

					if var_63_19 + var_63_14 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_14
					end
				end

				arg_60_1.text_.text = var_63_17
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_20 = var_63_14 + 0.3
			local var_63_21 = math.max(var_63_15, arg_60_1.talkMaxDuration)

			if var_63_14 + 0.3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_20 + var_63_21 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_20) / var_63_21

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_20 + var_63_21 and arg_60_1.time_ < var_63_20 + var_63_21 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play417211015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 417211015
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play417211016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0.05 < arg_66_1.time_ and arg_66_1.time_ <= 0.05 + arg_69_0 then
				arg_66_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_throw", "")
			end

			local var_69_1 = 0
			local var_69_2 = 1.25

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_3 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(417211015).content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 50 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 50)

				if (50 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 50)) > 0 and var_69_2 < var_69_5 then
					arg_66_1.talkMaxDuration = var_69_5

					if var_69_5 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + var_69_1
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_6 = math.max(var_69_2, arg_66_1.talkMaxDuration)

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_6 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_1) / var_69_6

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_1 + var_69_6 and arg_66_1.time_ < var_69_1 + var_69_6 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play417211016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 417211016
		arg_70_1.duration_ = 9.4

		local var_70_0 = {
			zh = 9.1,
			ja = 9.4
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
				arg_70_0:Play417211017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 7.4 < arg_70_1.time_ and arg_70_1.time_ <= 7.4 + arg_73_0 then
				arg_70_1.allBtn_.enabled = false
			end

			if arg_70_1.time_ >= 7.4 + 0.2 and arg_70_1.time_ < 7.4 + 0.2 + arg_73_0 then
				arg_70_1.allBtn_.enabled = true
			end

			local var_73_0 = 3.10862446895044e-15

			if 3.10862446895044e-15 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.timestampController_:SetSelectedState("show")
				arg_70_1.timestampAni_:Play("in")

				arg_70_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2106")

				arg_70_1.timestampColorController_:SetSelectedState("cold")
				arg_70_1.timeColdImg_:SetAlpha(0.031)

				arg_70_1.text_timeText_.text = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(501065).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_timeText_)

				arg_70_1.text_siteText_.text = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(501066).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_siteText_)
			end

			if arg_70_1.time_ >= var_73_0 + 5 and arg_70_1.time_ < var_73_0 + 5 + arg_73_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_70_1.timestampAni_, "out", function()
					arg_70_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_73_1 = 5

			if 5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = false

				arg_70_1:SetGaussion(false)
			end

			local var_73_2 = 1.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 then
				local var_73_3 = Color.New(0, 0, 0)

				var_73_3.a = Mathf.Lerp(0, 1, (arg_70_1.time_ - var_73_1) / var_73_2)
				arg_70_1.mask_.color = var_73_3
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 then
				local var_73_4 = Color.New(0, 0, 0)

				var_73_4.a = 1
				arg_70_1.mask_.color = var_73_4
			end

			local var_73_5 = 6.2

			if 6.2 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = false

				arg_70_1:SetGaussion(false)
			end

			local var_73_6 = 1.2

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 then
				local var_73_7 = Color.New(0, 0, 0)

				var_73_7.a = Mathf.Lerp(1, 0, (arg_70_1.time_ - var_73_5) / var_73_6)
				arg_70_1.mask_.color = var_73_7
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 then
				local var_73_8 = Color.New(0, 0, 0)

				arg_70_1.mask_.enabled = false
				var_73_8.a = 0
				arg_70_1.mask_.color = var_73_8
			end

			local var_73_9 = "ST2106"

			if arg_70_1.bgs_.ST2106 == nil then
				local var_73_10 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_73_9)
				var_73_10.name = var_73_9
				var_73_10.transform.parent = arg_70_1.stage_.transform
				var_73_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_[var_73_9] = var_73_10
			end

			if 3.10862446895044e-15 < arg_70_1.time_ and arg_70_1.time_ <= 3.10862446895044e-15 + arg_73_0 then
				local var_73_11 = arg_70_1.bgs_.ST2106

				arg_70_1.bgs_.ST2106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_73_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_12 = var_73_11:GetComponent("SpriteRenderer")

				if var_73_12 and var_73_12.sprite then
					local var_73_13 = 2 * (var_73_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_73_11.transform.localScale = Vector3.New(var_73_13 / var_73_12.sprite.bounds.size.y < var_73_13 * manager.ui.mainCameraCom_.aspect / var_73_12.sprite.bounds.size.x and var_73_13 * manager.ui.mainCameraCom_.aspect / var_73_12.sprite.bounds.size.x or var_73_13 / var_73_12.sprite.bounds.size.y, var_73_13 / var_73_12.sprite.bounds.size.y < var_73_13 * manager.ui.mainCameraCom_.aspect / var_73_12.sprite.bounds.size.x and var_73_13 * manager.ui.mainCameraCom_.aspect / var_73_12.sprite.bounds.size.x or var_73_13 / var_73_12.sprite.bounds.size.y, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "ST2106" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_14 = 0

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_14 + arg_73_0 then
				arg_70_1.allBtn_.enabled = false
			end

			if arg_70_1.time_ >= var_73_14 + 5 and arg_70_1.time_ < var_73_14 + 5 + arg_73_0 then
				arg_70_1.allBtn_.enabled = true
			end

			local var_73_15 = 0

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_15 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = false

				arg_70_1:SetGaussion(false)
			end

			local var_73_16 = 1

			if var_73_15 <= arg_70_1.time_ and arg_70_1.time_ < var_73_15 + var_73_16 then
				local var_73_17 = Color.New(0, 0, 0)

				var_73_17.a = Mathf.Lerp(1, 0, (arg_70_1.time_ - var_73_15) / var_73_16)
				arg_70_1.mask_.color = var_73_17
			end

			if arg_70_1.time_ >= var_73_15 + var_73_16 and arg_70_1.time_ < var_73_15 + var_73_16 + arg_73_0 then
				local var_73_18 = Color.New(0, 0, 0)

				arg_70_1.mask_.enabled = false
				var_73_18.a = 0
				arg_70_1.mask_.color = var_73_18
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_19 = 7.4
			local var_73_20 = 0.2

			if 7.4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_19 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_21 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_21:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_70_1.dialogCg_.alpha = arg_75_0
				end))
				var_73_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_22 = arg_70_1:GetWordFromCfg(417211016)
				local var_73_23 = arg_70_1:FormatText(var_73_22.content)

				arg_70_1.text_.text = var_73_23

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_25 = 8 <= 0 and var_73_20 or var_73_20 * (utf8.len(var_73_23) / 8)

				if (8 <= 0 and var_73_20 or var_73_20 * (utf8.len(var_73_23) / 8)) > 0 and var_73_20 < var_73_25 then
					arg_70_1.talkMaxDuration = var_73_25
					var_73_19 = var_73_19 + 0.3

					if var_73_25 + var_73_19 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_25 + var_73_19
					end
				end

				arg_70_1.text_.text = var_73_23
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211016", "story_v_out_417211.awb") ~= 0 then
					local var_73_26 = manager.audio:GetVoiceLength("story_v_out_417211", "417211016", "story_v_out_417211.awb") / 1000

					if var_73_26 + var_73_19 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_26 + var_73_19
					end

					if var_73_22.prefab_name ~= "" and arg_70_1.actors_[var_73_22.prefab_name] ~= nil then
						local var_73_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_22.prefab_name].transform, "story_v_out_417211", "417211016", "story_v_out_417211.awb")

						arg_70_1:RecordAudio("417211016", var_73_27)
						arg_70_1:RecordAudio("417211016", var_73_27)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_417211", "417211016", "story_v_out_417211.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_417211", "417211016", "story_v_out_417211.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_28 = var_73_19 + 0.3
			local var_73_29 = math.max(var_73_20, arg_70_1.talkMaxDuration)

			if var_73_19 + 0.3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_28 + var_73_29 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_28) / var_73_29

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_28 + var_73_29 and arg_70_1.time_ < var_73_28 + var_73_29 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play417211017 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 417211017
		arg_77_1.duration_ = 2.87

		local var_77_0 = {
			zh = 1.833,
			ja = 2.866
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play417211018(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.175

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1112].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(417211017)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 7 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 7)

				if (7 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 7)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211017", "story_v_out_417211.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211017", "story_v_out_417211.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_417211", "417211017", "story_v_out_417211.awb")

						arg_77_1:RecordAudio("417211017", var_80_6)
						arg_77_1:RecordAudio("417211017", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_417211", "417211017", "story_v_out_417211.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_417211", "417211017", "story_v_out_417211.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play417211018 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 417211018
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play417211019(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.425

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(417211018).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 57 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 57)

				if (57 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 57)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play417211019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 417211019
		arg_85_1.duration_ = 3.6

		local var_85_0 = {
			zh = 2.866,
			ja = 3.6
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play417211020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.225

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1112].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:GetWordFromCfg(417211019)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 9 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 9)

				if (9 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 9)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211019", "story_v_out_417211.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211019", "story_v_out_417211.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_417211", "417211019", "story_v_out_417211.awb")

						arg_85_1:RecordAudio("417211019", var_88_6)
						arg_85_1:RecordAudio("417211019", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_417211", "417211019", "story_v_out_417211.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_417211", "417211019", "story_v_out_417211.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play417211020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 417211020
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play417211021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0.925 < arg_89_1.time_ and arg_89_1.time_ <= 0.925 + arg_92_0 then
				arg_89_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_tip", "")
			end

			local var_92_1 = 0
			local var_92_2 = 0.925

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(417211020).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 37 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 37)

				if (37 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 37)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play417211021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 417211021
		arg_93_1.duration_ = 4.1

		local var_93_0 = {
			zh = 2.633,
			ja = 4.1
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play417211022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.225

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1112].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(417211021)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 9 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 9)

				if (9 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 9)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211021", "story_v_out_417211.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211021", "story_v_out_417211.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_417211", "417211021", "story_v_out_417211.awb")

						arg_93_1:RecordAudio("417211021", var_96_6)
						arg_93_1:RecordAudio("417211021", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_417211", "417211021", "story_v_out_417211.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_417211", "417211021", "story_v_out_417211.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play417211022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 417211022
		arg_97_1.duration_ = 5.67

		local var_97_0 = {
			zh = 3.166,
			ja = 5.666
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play417211023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.35

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1112].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:GetWordFromCfg(417211022)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 14 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 14)

				if (14 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 14)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211022", "story_v_out_417211.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211022", "story_v_out_417211.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_417211", "417211022", "story_v_out_417211.awb")

						arg_97_1:RecordAudio("417211022", var_100_6)
						arg_97_1:RecordAudio("417211022", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_417211", "417211022", "story_v_out_417211.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_417211", "417211022", "story_v_out_417211.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play417211023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 417211023
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play417211024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.775

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(417211023).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 31 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 31)

				if (31 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 31)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play417211024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 417211024
		arg_105_1.duration_ = 2.87

		local var_105_0 = {
			zh = 2.266,
			ja = 2.866
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
				arg_105_0:Play417211025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.125

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1112].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(417211024)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 5 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 5)

				if (5 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 5)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211024", "story_v_out_417211.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211024", "story_v_out_417211.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_417211", "417211024", "story_v_out_417211.awb")

						arg_105_1:RecordAudio("417211024", var_108_6)
						arg_105_1:RecordAudio("417211024", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_417211", "417211024", "story_v_out_417211.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_417211", "417211024", "story_v_out_417211.awb")
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
	Play417211025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 417211025
		arg_109_1.duration_ = 3.86

		local var_109_0 = {
			zh = 3.02985614351828,
			ja = 3.86285614351828
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play417211026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 1.02985614351928 < arg_109_1.time_ and arg_109_1.time_ <= 1.02985614351928 + arg_112_0 then
				local var_112_0 = arg_109_1.bgs_.ST2106

				arg_109_1.bgs_.ST2106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_1 = var_112_0:GetComponent("SpriteRenderer")

				if var_112_1 and var_112_1.sprite then
					local var_112_2 = 2 * (var_112_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_0.transform.localScale = Vector3.New(var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "ST2106" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_3 = 0

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_4 = 1.02985614351928

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_4 then
				local var_112_5 = Color.New(0, 0, 0)

				var_112_5.a = Mathf.Lerp(0, 1, (arg_109_1.time_ - var_112_3) / var_112_4)
				arg_109_1.mask_.color = var_112_5
			end

			if arg_109_1.time_ >= var_112_3 + var_112_4 and arg_109_1.time_ < var_112_3 + var_112_4 + arg_112_0 then
				local var_112_6 = Color.New(0, 0, 0)

				var_112_6.a = 1
				arg_109_1.mask_.color = var_112_6
			end

			local var_112_7 = 1.02985614351928

			if 1.02985614351928 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_8 = 1

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_8 then
				local var_112_9 = Color.New(0, 0, 0)

				var_112_9.a = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_7) / var_112_8)
				arg_109_1.mask_.color = var_112_9
			end

			if arg_109_1.time_ >= var_112_7 + var_112_8 and arg_109_1.time_ < var_112_7 + var_112_8 + arg_112_0 then
				local var_112_10 = Color.New(0, 0, 0)

				arg_109_1.mask_.enabled = false
				var_112_10.a = 0
				arg_109_1.mask_.color = var_112_10
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_11 = 2.02985614351828
			local var_112_12 = 0.05

			if 2.02985614351828 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_13 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_13:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_14 = arg_109_1:GetWordFromCfg(417211025)
				local var_112_15 = arg_109_1:FormatText(var_112_14.content)

				arg_109_1.text_.text = var_112_15

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_17 = 2 <= 0 and var_112_12 or var_112_12 * (utf8.len(var_112_15) / 2)

				if (2 <= 0 and var_112_12 or var_112_12 * (utf8.len(var_112_15) / 2)) > 0 and var_112_12 < var_112_17 then
					arg_109_1.talkMaxDuration = var_112_17
					var_112_11 = var_112_11 + 0.3

					if var_112_17 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_17 + var_112_11
					end
				end

				arg_109_1.text_.text = var_112_15
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211025", "story_v_out_417211.awb") ~= 0 then
					local var_112_18 = manager.audio:GetVoiceLength("story_v_out_417211", "417211025", "story_v_out_417211.awb") / 1000

					if var_112_18 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_18 + var_112_11
					end

					if var_112_14.prefab_name ~= "" and arg_109_1.actors_[var_112_14.prefab_name] ~= nil then
						local var_112_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_14.prefab_name].transform, "story_v_out_417211", "417211025", "story_v_out_417211.awb")

						arg_109_1:RecordAudio("417211025", var_112_19)
						arg_109_1:RecordAudio("417211025", var_112_19)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_417211", "417211025", "story_v_out_417211.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_417211", "417211025", "story_v_out_417211.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_20 = var_112_11 + 0.3
			local var_112_21 = math.max(var_112_12, arg_109_1.talkMaxDuration)

			if var_112_11 + 0.3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_20 + var_112_21 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_20) / var_112_21

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_20 + var_112_21 and arg_109_1.time_ < var_112_20 + var_112_21 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play417211026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 417211026
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play417211027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0.766666666666667 < arg_115_1.time_ and arg_115_1.time_ <= 0.766666666666667 + arg_118_0 then
				arg_115_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_magnet", "")
			end

			local var_118_1 = 0
			local var_118_2 = 1.175

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(417211026).content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 47 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 47)

				if (47 <= 0 and var_118_2 or var_118_2 * (utf8.len(var_118_3) / 47)) > 0 and var_118_2 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_1 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_1
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_6 = math.max(var_118_2, arg_115_1.talkMaxDuration)

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_6 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_1) / var_118_6

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_1 + var_118_6 and arg_115_1.time_ < var_118_1 + var_118_6 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play417211027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 417211027
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play417211028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.9

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(417211027).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 36 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 36)

				if (36 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 36)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play417211028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 417211028
		arg_123_1.duration_ = 4.27

		local var_123_0 = {
			zh = 3.6,
			ja = 4.266
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
				arg_123_0:Play417211029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.actors_["10128"] == nil then
				local var_126_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_126_0) then
					local var_126_1 = Object.Instantiate(var_126_0, arg_123_1.canvasGo_.transform)

					var_126_1.transform:SetSiblingIndex(1)

					var_126_1.name = "10128"
					var_126_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_123_1.actors_["10128"] = var_126_1

					if arg_123_1.isInRecall_ then
						for iter_126_0, iter_126_1 in ipairs((var_126_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_126_1.color = arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_126_2 = arg_123_1.actors_["10128"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10128 == nil then
				arg_123_1.var_.actorSpriteComps10128 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps10128 then
					for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_126_3 then
							if arg_123_1.isInRecall_ then
								iter_126_3.color = Color.New(Mathf.Lerp(iter_126_3.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_3), Mathf.Lerp(iter_126_3.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_3), (Mathf.Lerp(iter_126_3.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_3)))
							else
								local var_126_4 = Mathf.Lerp(iter_126_3.color.r, 1, (arg_123_1.time_ - 0) / var_126_3)

								iter_126_3.color = Color.New(var_126_4, var_126_4, var_126_4)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10128 then
				for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_126_5 then
						iter_126_5.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps10128 = nil
			end

			local var_126_5 = arg_123_1.actors_["10128"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10128 = var_126_5.localPosition
				var_126_5.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10128", 3)

				for iter_126_6 = 0, var_126_5.childCount - 1 do
					local var_126_6 = var_126_5:GetChild(iter_126_6)

					if var_126_6.name == "" or not string.find(var_126_6.name, "split") then
						var_126_6.gameObject:SetActive(true)
					else
						var_126_6.gameObject:SetActive(false)
					end
				end
			end

			local var_126_7 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				var_126_5.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_123_1.time_ - 0) / var_126_7)
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				var_126_5.localPosition = Vector3.New(0, -347, -300)
			end

			local var_126_8 = 0
			local var_126_9 = 0.475

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(417211028)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 19 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 19)

				if (19 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 19)) > 0 and var_126_9 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211028", "story_v_out_417211.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_417211", "417211028", "story_v_out_417211.awb") / 1000

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_417211", "417211028", "story_v_out_417211.awb")

						arg_123_1:RecordAudio("417211028", var_126_15)
						arg_123_1:RecordAudio("417211028", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_417211", "417211028", "story_v_out_417211.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_417211", "417211028", "story_v_out_417211.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_16 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_16

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_16 and arg_123_1.time_ < var_126_8 + var_126_16 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play417211029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 417211029
		arg_127_1.duration_ = 5.7

		local var_127_0 = {
			zh = 2.933,
			ja = 5.7
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
				arg_127_0:Play417211030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.475

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:GetWordFromCfg(417211029)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 19 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 19)

				if (19 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 19)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211029", "story_v_out_417211.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211029", "story_v_out_417211.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_417211", "417211029", "story_v_out_417211.awb")

						arg_127_1:RecordAudio("417211029", var_130_6)
						arg_127_1:RecordAudio("417211029", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_417211", "417211029", "story_v_out_417211.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_417211", "417211029", "story_v_out_417211.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play417211030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 417211030
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play417211031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10128 = arg_131_1.actors_["10128"].transform.localPosition
				arg_131_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10128", 7)

				for iter_134_0 = 0, arg_131_1.actors_["10128"].transform.childCount - 1 do
					local var_134_0 = arg_131_1.actors_["10128"].transform:GetChild(iter_134_0)

					if var_134_0.name == "" or not string.find(var_134_0.name, "split") then
						var_134_0.gameObject:SetActive(true)
					else
						var_134_0.gameObject:SetActive(false)
					end
				end
			end

			local var_134_1 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_1 then
				arg_131_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_131_1.time_ - 0) / var_134_1)
			end

			if arg_131_1.time_ >= 0 + var_134_1 and arg_131_1.time_ < 0 + var_134_1 + arg_134_0 then
				arg_131_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_134_2 = 0
			local var_134_3 = 1.05

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_4 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(417211030).content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_6 = 42 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_4) / 42)

				if (42 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_4) / 42)) > 0 and var_134_3 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_7 and arg_131_1.time_ < var_134_2 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play417211031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 417211031
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play417211032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_tip", "")
			end

			local var_138_1 = 0
			local var_138_2 = 1.325

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(417211031).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 53 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 53)

				if (53 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 53)) > 0 and var_138_2 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_6 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_6 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_6

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_6 and arg_135_1.time_ < var_138_1 + var_138_6 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play417211032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 417211032
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play417211033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 1.8

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

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(417211032).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 72 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 72)

				if (72 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 72)) > 0 and var_142_0 < var_142_3 then
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
	Play417211033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 417211033
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play417211034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.9

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(417211033).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 36 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 36)

				if (36 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 36)) > 0 and var_146_0 < var_146_3 then
					arg_143_1.talkMaxDuration = var_146_3

					if var_146_3 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_3 + 0
					end
				end

				arg_143_1.text_.text = var_146_1
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_4 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_4

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play417211034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 417211034
		arg_147_1.duration_ = 3

		local var_147_0 = {
			zh = 1.933,
			ja = 3
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
				arg_147_0:Play417211035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.25

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_1 = arg_147_1:GetWordFromCfg(417211034)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 10 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 10)

				if (10 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 10)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211034", "story_v_out_417211.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211034", "story_v_out_417211.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_417211", "417211034", "story_v_out_417211.awb")

						arg_147_1:RecordAudio("417211034", var_150_6)
						arg_147_1:RecordAudio("417211034", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_417211", "417211034", "story_v_out_417211.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_417211", "417211034", "story_v_out_417211.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play417211035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 417211035
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play417211036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.925

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(417211035).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 37 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 37)

				if (37 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 37)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play417211036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 417211036
		arg_155_1.duration_ = 6.73

		local var_155_0 = {
			zh = 3.533,
			ja = 6.733
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
				arg_155_0:Play417211037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.5

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:GetWordFromCfg(417211036)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 20 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 20)

				if (20 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 20)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211036", "story_v_out_417211.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211036", "story_v_out_417211.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_417211", "417211036", "story_v_out_417211.awb")

						arg_155_1:RecordAudio("417211036", var_158_6)
						arg_155_1:RecordAudio("417211036", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_417211", "417211036", "story_v_out_417211.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_417211", "417211036", "story_v_out_417211.awb")
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
	Play417211037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 417211037
		arg_159_1.duration_ = 10.63

		local var_159_0 = {
			zh = 6.233,
			ja = 10.633
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
				arg_159_0:Play417211038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.925

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:GetWordFromCfg(417211037)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 37 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 37)

				if (37 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 37)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211037", "story_v_out_417211.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211037", "story_v_out_417211.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_417211", "417211037", "story_v_out_417211.awb")

						arg_159_1:RecordAudio("417211037", var_162_6)
						arg_159_1:RecordAudio("417211037", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_417211", "417211037", "story_v_out_417211.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_417211", "417211037", "story_v_out_417211.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play417211038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 417211038
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play417211039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 1

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(417211038).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 40 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 40)

				if (40 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 40)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play417211039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 417211039
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play417211040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 1.15

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(417211039).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 46 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 46)

				if (46 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 46)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play417211040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 417211040
		arg_171_1.duration_ = 4.13

		local var_171_0 = {
			zh = 4.133,
			ja = 3.7
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
				arg_171_0:Play417211041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10128"]) and arg_171_1.var_.actorSpriteComps10128 == nil then
				arg_171_1.var_.actorSpriteComps10128 = arg_171_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10128"]) then
				if arg_171_1.var_.actorSpriteComps10128 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								iter_174_1.color = Color.New(Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_0), Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_0), (Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_0)))
							else
								local var_174_1 = Mathf.Lerp(iter_174_1.color.r, 1, (arg_171_1.time_ - 0) / var_174_0)

								iter_174_1.color = Color.New(var_174_1, var_174_1, var_174_1)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10128"]) and arg_171_1.var_.actorSpriteComps10128 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps10128 = nil
			end

			local var_174_2 = arg_171_1.actors_["10128"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10128 = var_174_2.localPosition
				var_174_2.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10128", 3)

				for iter_174_4 = 0, var_174_2.childCount - 1 do
					local var_174_3 = var_174_2:GetChild(iter_174_4)

					if var_174_3.name == "split_6" or not string.find(var_174_3.name, "split") then
						var_174_3.gameObject:SetActive(true)
					else
						var_174_3.gameObject:SetActive(false)
					end
				end
			end

			local var_174_4 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				var_174_2.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_171_1.time_ - 0) / var_174_4)
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				var_174_2.localPosition = Vector3.New(0, -347, -300)
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_174_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_171_1.bgmTxt_.text ~= var_174_7 and arg_171_1.bgmTxt_.text ~= "" then
						if arg_171_1.bgmTxt2_.text ~= "" then
							arg_171_1.bgmTxt_.text = arg_171_1.bgmTxt2_.text
						end

						arg_171_1.bgmTxt2_.text = var_174_7

						arg_171_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_171_1.bgmTxt_.text = var_174_7
						arg_171_1.bgmTxt2_.text = var_174_7
					end

					if arg_171_1.bgmTimer then
						arg_171_1.bgmTimer:Stop()

						arg_171_1.bgmTimer = nil
					end

					if arg_171_1.settingData.show_music_name == 1 then
						arg_171_1.musicController:SetSelectedState("show")
						arg_171_1.musicAnimator_:Play("open", 0, 0)

						if arg_171_1.settingData.music_time ~= 0 then
							arg_171_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_171_1.settingData.music_time), function()
								if arg_171_1 == nil or isNil(arg_171_1.bgmTxt_) then
									return
								end

								arg_171_1.musicController:SetSelectedState("hide")
								arg_171_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_171_1.time_ and arg_171_1.time_ <= 0.433333333333333 + arg_174_0 then
				arg_171_1:AudioAction("stop", "music", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_174_10 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

				if "" ~= "" then
					if arg_171_1.bgmTxt_.text ~= var_174_10 and arg_171_1.bgmTxt_.text ~= "" then
						if arg_171_1.bgmTxt2_.text ~= "" then
							arg_171_1.bgmTxt_.text = arg_171_1.bgmTxt2_.text
						end

						arg_171_1.bgmTxt2_.text = var_174_10

						arg_171_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_171_1.bgmTxt_.text = var_174_10
						arg_171_1.bgmTxt2_.text = var_174_10
					end

					if arg_171_1.bgmTimer then
						arg_171_1.bgmTimer:Stop()

						arg_171_1.bgmTimer = nil
					end

					if arg_171_1.settingData.show_music_name == 1 then
						arg_171_1.musicController:SetSelectedState("show")
						arg_171_1.musicAnimator_:Play("open", 0, 0)

						if arg_171_1.settingData.music_time ~= 0 then
							arg_171_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_171_1.settingData.music_time), function()
								if arg_171_1 == nil or isNil(arg_171_1.bgmTxt_) then
									return
								end

								arg_171_1.musicController:SetSelectedState("hide")
								arg_171_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_174_11 = 0
			local var_174_12 = 0.525

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_11 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_13 = arg_171_1:GetWordFromCfg(417211040)
				local var_174_14 = arg_171_1:FormatText(var_174_13.content)

				arg_171_1.text_.text = var_174_14

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_16 = 21 <= 0 and var_174_12 or var_174_12 * (utf8.len(var_174_14) / 21)

				if (21 <= 0 and var_174_12 or var_174_12 * (utf8.len(var_174_14) / 21)) > 0 and var_174_12 < var_174_16 then
					arg_171_1.talkMaxDuration = var_174_16

					if var_174_16 + var_174_11 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_16 + var_174_11
					end
				end

				arg_171_1.text_.text = var_174_14
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211040", "story_v_out_417211.awb") ~= 0 then
					local var_174_17 = manager.audio:GetVoiceLength("story_v_out_417211", "417211040", "story_v_out_417211.awb") / 1000

					if var_174_17 + var_174_11 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_17 + var_174_11
					end

					if var_174_13.prefab_name ~= "" and arg_171_1.actors_[var_174_13.prefab_name] ~= nil then
						local var_174_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_13.prefab_name].transform, "story_v_out_417211", "417211040", "story_v_out_417211.awb")

						arg_171_1:RecordAudio("417211040", var_174_18)
						arg_171_1:RecordAudio("417211040", var_174_18)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_417211", "417211040", "story_v_out_417211.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_417211", "417211040", "story_v_out_417211.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_19 = math.max(var_174_12, arg_171_1.talkMaxDuration)

			if var_174_11 <= arg_171_1.time_ and arg_171_1.time_ < var_174_11 + var_174_19 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_11) / var_174_19

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_11 + var_174_19 and arg_171_1.time_ < var_174_11 + var_174_19 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play417211041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 417211041
		arg_177_1.duration_ = 9

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play417211042(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_9000

			if arg_177_1.bgs_.I16g == nil then
				local var_180_0 = Object.Instantiate(arg_177_1.paintGo_)

				var_180_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I16g")
				var_180_0.name = "I16g"
				var_180_0.transform.parent = arg_177_1.stage_.transform
				var_180_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_177_1.bgs_.I16g = var_180_0
			end

			if 2 < arg_177_1.time_ and arg_177_1.time_ <= 2 + arg_180_0 then
				local var_180_1 = arg_177_1.bgs_.I16g

				arg_177_1.bgs_.I16g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_180_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_180_2 = var_180_1:GetComponent("SpriteRenderer")

				if var_180_2 and var_180_2.sprite then
					local var_180_3 = 2 * (var_180_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_180_1.transform.localScale = Vector3.New(var_180_3 / var_180_2.sprite.bounds.size.y < var_180_3 * manager.ui.mainCameraCom_.aspect / var_180_2.sprite.bounds.size.x and var_180_3 * manager.ui.mainCameraCom_.aspect / var_180_2.sprite.bounds.size.x or var_180_3 / var_180_2.sprite.bounds.size.y, var_180_3 / var_180_2.sprite.bounds.size.y < var_180_3 * manager.ui.mainCameraCom_.aspect / var_180_2.sprite.bounds.size.x and var_180_3 * manager.ui.mainCameraCom_.aspect / var_180_2.sprite.bounds.size.x or var_180_3 / var_180_2.sprite.bounds.size.y, 0)
				end

				for iter_180_0, iter_180_1 in pairs(arg_177_1.bgs_) do
					if iter_180_0 ~= "I16g" then
						iter_180_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_180_4 = 3.999999999999

			if 3.999999999999 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.allBtn_.enabled = false
			end

			if arg_177_1.time_ >= var_180_4 + 0.533333333334333 and arg_177_1.time_ < var_180_4 + 0.533333333334333 + arg_180_0 then
				arg_177_1.allBtn_.enabled = true
			end

			local var_180_5 = 0

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_6 = 2

			if var_180_5 <= arg_177_1.time_ and arg_177_1.time_ < var_180_5 + var_180_6 then
				local var_180_7 = Color.New(0, 0, 0)

				var_180_7.a = Mathf.Lerp(0, 1, (arg_177_1.time_ - var_180_5) / var_180_6)
				arg_177_1.mask_.color = var_180_7
			end

			if arg_177_1.time_ >= var_180_5 + var_180_6 and arg_177_1.time_ < var_180_5 + var_180_6 + arg_180_0 then
				local var_180_8 = Color.New(0, 0, 0)

				var_180_8.a = 1
				arg_177_1.mask_.color = var_180_8
			end

			local var_180_9 = 2

			if 2 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_10 = 2

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_10 then
				local var_180_11 = Color.New(0, 0, 0)

				var_180_11.a = Mathf.Lerp(1, 0, (arg_177_1.time_ - var_180_9) / var_180_10)
				arg_177_1.mask_.color = var_180_11
			end

			if arg_177_1.time_ >= var_180_9 + var_180_10 and arg_177_1.time_ < var_180_9 + var_180_10 + arg_180_0 then
				local var_180_12 = Color.New(0, 0, 0)

				arg_177_1.mask_.enabled = false
				var_180_12.a = 0
				arg_177_1.mask_.color = var_180_12
			end

			local var_180_13 = arg_177_1.actors_["10128"].transform

			if 1.966 < arg_177_1.time_ and arg_177_1.time_ <= 1.966 + arg_180_0 then
				arg_177_1.var_.moveOldPos10128 = var_180_13.localPosition
				var_180_13.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10128", 7)

				for iter_180_2 = 0, var_180_13.childCount - 1 do
					local var_180_14 = var_180_13:GetChild(iter_180_2)

					if var_180_14.name == "" or not string.find(var_180_14.name, "split") then
						var_180_14.gameObject:SetActive(true)
					else
						var_180_14.gameObject:SetActive(false)
					end
				end
			end

			local var_180_15 = 0.001

			if 1.966 <= arg_177_1.time_ and arg_177_1.time_ < 1.966 + var_180_15 then
				var_180_13.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_177_1.time_ - 1.966) / var_180_15)
			end

			if arg_177_1.time_ >= 1.966 + var_180_15 and arg_177_1.time_ < 1.966 + var_180_15 + arg_180_0 then
				var_180_13.localPosition = Vector3.New(0, -2000, -300)
			end

			if 3.16666666666667 < arg_177_1.time_ and arg_177_1.time_ <= 3.16666666666667 + arg_180_0 then
				local var_180_16 = arg_177_1.var_.effect10411

				if not arg_177_1.var_.effect10411 then
					var_180_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_180_16.name = "10411"
					arg_177_1.var_.effect10411 = var_180_16
				else
					var_180_16.transform:SetParent(var_180_9000)
				end

				var_180_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_180_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_180_18 = manager.ui.mainCamera.transform

			if 3.33333333333333 < arg_177_1.time_ and arg_177_1.time_ <= 3.33333333333333 + arg_180_0 then
				arg_177_1.var_.shakeOldPos = var_180_18.localPosition
			end

			local var_180_19 = 0.635169367368023

			if 3.33333333333333 <= arg_177_1.time_ and arg_177_1.time_ < 3.33333333333333 + var_180_19 then
				local var_180_20, var_180_21 = math.modf((arg_177_1.time_ - 3.33333333333333) / 0.066)

				var_180_18.localPosition = Vector3.New(var_180_21 * 0.13, var_180_21 * 0.13, var_180_21 * 0.13) + arg_177_1.var_.shakeOldPos
			end

			if arg_177_1.time_ >= 3.33333333333333 + var_180_19 and arg_177_1.time_ < 3.33333333333333 + var_180_19 + arg_180_0 then
				var_180_18.localPosition = arg_177_1.var_.shakeOldPos
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_180_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_177_1.bgmTxt_.text ~= var_180_24 and arg_177_1.bgmTxt_.text ~= "" then
						if arg_177_1.bgmTxt2_.text ~= "" then
							arg_177_1.bgmTxt_.text = arg_177_1.bgmTxt2_.text
						end

						arg_177_1.bgmTxt2_.text = var_180_24

						arg_177_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_177_1.bgmTxt_.text = var_180_24
						arg_177_1.bgmTxt2_.text = var_180_24
					end

					if arg_177_1.bgmTimer then
						arg_177_1.bgmTimer:Stop()

						arg_177_1.bgmTimer = nil
					end

					if arg_177_1.settingData.show_music_name == 1 then
						arg_177_1.musicController:SetSelectedState("show")
						arg_177_1.musicAnimator_:Play("open", 0, 0)

						if arg_177_1.settingData.music_time ~= 0 then
							arg_177_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_177_1.settingData.music_time), function()
								if arg_177_1 == nil or isNil(arg_177_1.bgmTxt_) then
									return
								end

								arg_177_1.musicController:SetSelectedState("hide")
								arg_177_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.66666666666667 < arg_177_1.time_ and arg_177_1.time_ <= 1.66666666666667 + arg_180_0 then
				arg_177_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2.awb")

				local var_180_27 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_2", "bgm_activity_3_10_story_scheme_2")

				if "" ~= "" then
					if arg_177_1.bgmTxt_.text ~= var_180_27 and arg_177_1.bgmTxt_.text ~= "" then
						if arg_177_1.bgmTxt2_.text ~= "" then
							arg_177_1.bgmTxt_.text = arg_177_1.bgmTxt2_.text
						end

						arg_177_1.bgmTxt2_.text = var_180_27

						arg_177_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_177_1.bgmTxt_.text = var_180_27
						arg_177_1.bgmTxt2_.text = var_180_27
					end

					if arg_177_1.bgmTimer then
						arg_177_1.bgmTimer:Stop()

						arg_177_1.bgmTimer = nil
					end

					if arg_177_1.settingData.show_music_name == 1 then
						arg_177_1.musicController:SetSelectedState("show")
						arg_177_1.musicAnimator_:Play("open", 0, 0)

						if arg_177_1.settingData.music_time ~= 0 then
							arg_177_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_177_1.settingData.music_time), function()
								if arg_177_1 == nil or isNil(arg_177_1.bgmTxt_) then
									return
								end

								arg_177_1.musicController:SetSelectedState("hide")
								arg_177_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 3.83333333333333 < arg_177_1.time_ and arg_177_1.time_ <= 3.83333333333333 + arg_180_0 then
				arg_177_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_collapse", "")
			end

			if 3.08 < arg_177_1.time_ and arg_177_1.time_ <= 3.08 + arg_180_0 then
				arg_177_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_sword", "")
			end

			if arg_177_1.frameCnt_ <= 1 then
				arg_177_1.dialog_:SetActive(false)
			end

			local var_180_30 = 3.999999999999
			local var_180_31 = 1.175

			if 3.999999999999 < arg_177_1.time_ and arg_177_1.time_ <= var_180_30 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				arg_177_1.dialog_:SetActive(true)

				arg_177_1.dialogCg_.alpha = 0

				local var_180_32 = LeanTween.value(arg_177_1.dialog_, 0, 1, 0.3)

				var_180_32:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_177_1.dialogCg_.alpha = arg_183_0
				end))
				var_180_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_177_1.dialog_)
					var_180_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_177_1.duration_ = arg_177_1.duration_ + 0.3

				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_33 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(417211041).content)

				arg_177_1.text_.text = var_180_33

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_35 = 47 <= 0 and var_180_31 or var_180_31 * (utf8.len(var_180_33) / 47)

				if (47 <= 0 and var_180_31 or var_180_31 * (utf8.len(var_180_33) / 47)) > 0 and var_180_31 < var_180_35 then
					arg_177_1.talkMaxDuration = var_180_35
					var_180_30 = var_180_30 + 0.3

					if var_180_35 + var_180_30 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_35 + var_180_30
					end
				end

				arg_177_1.text_.text = var_180_33
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_36 = var_180_30 + 0.3
			local var_180_37 = math.max(var_180_31, arg_177_1.talkMaxDuration)

			if var_180_30 + 0.3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_36 + var_180_37 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_36) / var_180_37

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_36 + var_180_37 and arg_177_1.time_ < var_180_36 + var_180_37 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play417211042 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 417211042
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play417211043(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_roll", "")
			end

			local var_188_1 = 0
			local var_188_2 = 1.025

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(417211042).content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 41 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 41)

				if (41 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 41)) > 0 and var_188_2 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_6 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_6 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_6

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_6 and arg_185_1.time_ < var_188_1 + var_188_6 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play417211043 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 417211043
		arg_189_1.duration_ = 2.2

		local var_189_0 = {
			zh = 1.933,
			ja = 2.2
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play417211044(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.275

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1146].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:GetWordFromCfg(417211043)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 11 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 11)

				if (11 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 11)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211043", "story_v_out_417211.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211043", "story_v_out_417211.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_417211", "417211043", "story_v_out_417211.awb")

						arg_189_1:RecordAudio("417211043", var_192_6)
						arg_189_1:RecordAudio("417211043", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_417211", "417211043", "story_v_out_417211.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_417211", "417211043", "story_v_out_417211.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play417211044 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 417211044
		arg_193_1.duration_ = 4.13

		local var_193_0 = {
			zh = 2.6,
			ja = 4.133
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
				arg_193_0:Play417211045(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.35

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1146].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:GetWordFromCfg(417211044)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 14 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 14)

				if (14 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 14)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211044", "story_v_out_417211.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211044", "story_v_out_417211.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_417211", "417211044", "story_v_out_417211.awb")

						arg_193_1:RecordAudio("417211044", var_196_6)
						arg_193_1:RecordAudio("417211044", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_417211", "417211044", "story_v_out_417211.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_417211", "417211044", "story_v_out_417211.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play417211045 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 417211045
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play417211046(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0.7 < arg_197_1.time_ and arg_197_1.time_ <= 0.7 + arg_200_0 then
				arg_197_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_surround", "")
			end

			local var_200_1 = 0
			local var_200_2 = 0.875

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_3 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(417211045).content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 35 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 35)

				if (35 <= 0 and var_200_2 or var_200_2 * (utf8.len(var_200_3) / 35)) > 0 and var_200_2 < var_200_5 then
					arg_197_1.talkMaxDuration = var_200_5

					if var_200_5 + var_200_1 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + var_200_1
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_6 = math.max(var_200_2, arg_197_1.talkMaxDuration)

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_6 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_1) / var_200_6

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_1 + var_200_6 and arg_197_1.time_ < var_200_1 + var_200_6 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play417211046 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 417211046
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play417211047(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.425

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(417211046).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 57 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 57)

				if (57 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 57)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play417211047 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 417211047
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play417211048(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0.466666666666667 < arg_205_1.time_ and arg_205_1.time_ <= 0.466666666666667 + arg_208_0 then
				arg_205_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_run", "")
			end

			local var_208_1 = 0
			local var_208_2 = 0.675

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(417211047).content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 27 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 27)

				if (27 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 27)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_6 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_6 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_6

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_6 and arg_205_1.time_ < var_208_1 + var_208_6 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play417211048 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 417211048
		arg_209_1.duration_ = 2.2

		local var_209_0 = {
			zh = 1.366,
			ja = 2.2
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
				arg_209_0:Play417211049(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.125

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1134].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3051")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:GetWordFromCfg(417211048)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 5 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 5)

				if (5 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 5)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211048", "story_v_out_417211.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_out_417211", "417211048", "story_v_out_417211.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_out_417211", "417211048", "story_v_out_417211.awb")

						arg_209_1:RecordAudio("417211048", var_212_6)
						arg_209_1:RecordAudio("417211048", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_417211", "417211048", "story_v_out_417211.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_417211", "417211048", "story_v_out_417211.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play417211049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 417211049
		arg_213_1.duration_ = 1.7

		local var_213_0 = {
			zh = 1.266,
			ja = 1.7
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play417211050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["10128"]) and arg_213_1.var_.actorSpriteComps10128 == nil then
				arg_213_1.var_.actorSpriteComps10128 = arg_213_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_0 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["10128"]) then
				if arg_213_1.var_.actorSpriteComps10128 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								iter_216_1.color = Color.New(Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_0), Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_0), (Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_0)))
							else
								local var_216_1 = Mathf.Lerp(iter_216_1.color.r, 1, (arg_213_1.time_ - 0) / var_216_0)

								iter_216_1.color = Color.New(var_216_1, var_216_1, var_216_1)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["10128"]) and arg_213_1.var_.actorSpriteComps10128 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_216_3 then
						iter_216_3.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps10128 = nil
			end

			local var_216_2 = arg_213_1.actors_["10128"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10128 = var_216_2.localPosition
				var_216_2.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10128", 3)

				for iter_216_4 = 0, var_216_2.childCount - 1 do
					local var_216_3 = var_216_2:GetChild(iter_216_4)

					if var_216_3.name == "split_6" or not string.find(var_216_3.name, "split") then
						var_216_3.gameObject:SetActive(true)
					else
						var_216_3.gameObject:SetActive(false)
					end
				end
			end

			local var_216_4 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				var_216_2.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_213_1.time_ - 0) / var_216_4)
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				var_216_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_216_5 = 0
			local var_216_6 = 0.15

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:GetWordFromCfg(417211049)
				local var_216_8 = arg_213_1:FormatText(var_216_7.content)

				arg_213_1.text_.text = var_216_8

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_10 = 6 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 6)

				if (6 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 6)) > 0 and var_216_6 < var_216_10 then
					arg_213_1.talkMaxDuration = var_216_10

					if var_216_10 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_8
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211049", "story_v_out_417211.awb") ~= 0 then
					local var_216_11 = manager.audio:GetVoiceLength("story_v_out_417211", "417211049", "story_v_out_417211.awb") / 1000

					if var_216_11 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_5
					end

					if var_216_7.prefab_name ~= "" and arg_213_1.actors_[var_216_7.prefab_name] ~= nil then
						local var_216_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_7.prefab_name].transform, "story_v_out_417211", "417211049", "story_v_out_417211.awb")

						arg_213_1:RecordAudio("417211049", var_216_12)
						arg_213_1:RecordAudio("417211049", var_216_12)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_417211", "417211049", "story_v_out_417211.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_417211", "417211049", "story_v_out_417211.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_13 = math.max(var_216_6, arg_213_1.talkMaxDuration)

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_13 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_5) / var_216_13

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_5 + var_216_13 and arg_213_1.time_ < var_216_5 + var_216_13 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play417211050 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 417211050
		arg_217_1.duration_ = 2.2

		local var_217_0 = {
			zh = 1.366,
			ja = 2.2
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play417211051(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["10128"]) and arg_217_1.var_.actorSpriteComps10128 == nil then
				arg_217_1.var_.actorSpriteComps10128 = arg_217_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_0 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["10128"]) then
				if arg_217_1.var_.actorSpriteComps10128 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								iter_220_1.color = Color.New(Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor2.r, (arg_217_1.time_ - 0) / var_220_0), Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor2.g, (arg_217_1.time_ - 0) / var_220_0), (Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor2.b, (arg_217_1.time_ - 0) / var_220_0)))
							else
								local var_220_1 = Mathf.Lerp(iter_220_1.color.r, 0.5, (arg_217_1.time_ - 0) / var_220_0)

								iter_220_1.color = Color.New(var_220_1, var_220_1, var_220_1)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["10128"]) and arg_217_1.var_.actorSpriteComps10128 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_220_3 then
						iter_220_3.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_217_1.var_.actorSpriteComps10128 = nil
			end

			local var_220_2 = 0
			local var_220_3 = 0.125

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1134].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3051")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_4 = arg_217_1:GetWordFromCfg(417211048)
				local var_220_5 = arg_217_1:FormatText(var_220_4.content)

				arg_217_1.text_.text = var_220_5

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_7 = 5 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 5)

				if (5 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 5)) > 0 and var_220_3 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_2
					end
				end

				arg_217_1.text_.text = var_220_5
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211048", "story_v_out_417211.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_417211", "417211048", "story_v_out_417211.awb") / 1000

					if var_220_8 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_2
					end

					if var_220_4.prefab_name ~= "" and arg_217_1.actors_[var_220_4.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_4.prefab_name].transform, "story_v_out_417211", "417211048", "story_v_out_417211.awb")

						arg_217_1:RecordAudio("417211048", var_220_9)
						arg_217_1:RecordAudio("417211048", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_417211", "417211048", "story_v_out_417211.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_417211", "417211048", "story_v_out_417211.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_3, arg_217_1.talkMaxDuration)

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_2) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_2 + var_220_10 and arg_217_1.time_ < var_220_2 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play417211051 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 417211051
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play417211052(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10128 = arg_221_1.actors_["10128"].transform.localPosition
				arg_221_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10128", 7)

				for iter_224_0 = 0, arg_221_1.actors_["10128"].transform.childCount - 1 do
					local var_224_0 = arg_221_1.actors_["10128"].transform:GetChild(iter_224_0)

					if var_224_0.name == "" or not string.find(var_224_0.name, "split") then
						var_224_0.gameObject:SetActive(true)
					else
						var_224_0.gameObject:SetActive(false)
					end
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10128, Vector3.New(0, -2000, 0), (arg_221_1.time_ - 0) / var_224_1)
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_224_2 = 0
			local var_224_3 = 0.15

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_4 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(417211051).content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_6 = 30 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_4) / 30)

				if (30 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_4) / 30)) > 0 and var_224_3 < var_224_6 then
					arg_221_1.talkMaxDuration = var_224_6

					if var_224_6 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_7 and arg_221_1.time_ < var_224_2 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play417211052 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 417211052
		arg_225_1.duration_ = 5.87

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play417211053(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_228_0 = 0.666666666666667

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				local var_228_1, var_228_2 = math.modf((arg_225_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_228_2 * 0.13, var_228_2 * 0.13, var_228_2 * 0.13) + arg_225_1.var_.shakeOldPos
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				manager.ui.mainCamera.transform.localPosition = arg_225_1.var_.shakeOldPos
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_hit01", "")
			end

			local var_228_4 = 0.866666666666667
			local var_228_5 = 1.425

			if 0.866666666666667 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(417211052).content)

				arg_225_1.text_.text = var_228_6

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_8 = 57 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_6) / 57)

				if (57 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_6) / 57)) > 0 and var_228_5 < var_228_8 then
					arg_225_1.talkMaxDuration = var_228_8

					if var_228_8 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_6
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_9 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_9 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_9

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_9 and arg_225_1.time_ < var_228_4 + var_228_9 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play417211053 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 417211053
		arg_229_1.duration_ = 4.7

		local var_229_0 = {
			zh = 4.7,
			ja = 4.4
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play417211054(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["10128"]) and arg_229_1.var_.actorSpriteComps10128 == nil then
				arg_229_1.var_.actorSpriteComps10128 = arg_229_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["10128"]) then
				if arg_229_1.var_.actorSpriteComps10128 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								iter_232_1.color = Color.New(Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor1.r, (arg_229_1.time_ - 0) / var_232_0), Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor1.g, (arg_229_1.time_ - 0) / var_232_0), (Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor1.b, (arg_229_1.time_ - 0) / var_232_0)))
							else
								local var_232_1 = Mathf.Lerp(iter_232_1.color.r, 1, (arg_229_1.time_ - 0) / var_232_0)

								iter_232_1.color = Color.New(var_232_1, var_232_1, var_232_1)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["10128"]) and arg_229_1.var_.actorSpriteComps10128 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_232_3 then
						iter_232_3.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_229_1.var_.actorSpriteComps10128 = nil
			end

			local var_232_2 = arg_229_1.actors_["10128"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos10128 = var_232_2.localPosition
				var_232_2.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("10128", 3)

				for iter_232_4 = 0, var_232_2.childCount - 1 do
					local var_232_3 = var_232_2:GetChild(iter_232_4)

					if var_232_3.name == "split_4" or not string.find(var_232_3.name, "split") then
						var_232_3.gameObject:SetActive(true)
					else
						var_232_3.gameObject:SetActive(false)
					end
				end
			end

			local var_232_4 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				var_232_2.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_229_1.time_ - 0) / var_232_4)
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				var_232_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_232_5 = 0
			local var_232_6 = 0.325

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_7 = arg_229_1:GetWordFromCfg(417211053)
				local var_232_8 = arg_229_1:FormatText(var_232_7.content)

				arg_229_1.text_.text = var_232_8

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_10 = 13 <= 0 and var_232_6 or var_232_6 * (utf8.len(var_232_8) / 13)

				if (13 <= 0 and var_232_6 or var_232_6 * (utf8.len(var_232_8) / 13)) > 0 and var_232_6 < var_232_10 then
					arg_229_1.talkMaxDuration = var_232_10

					if var_232_10 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_5
					end
				end

				arg_229_1.text_.text = var_232_8
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211053", "story_v_out_417211.awb") ~= 0 then
					local var_232_11 = manager.audio:GetVoiceLength("story_v_out_417211", "417211053", "story_v_out_417211.awb") / 1000

					if var_232_11 + var_232_5 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_11 + var_232_5
					end

					if var_232_7.prefab_name ~= "" and arg_229_1.actors_[var_232_7.prefab_name] ~= nil then
						local var_232_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_7.prefab_name].transform, "story_v_out_417211", "417211053", "story_v_out_417211.awb")

						arg_229_1:RecordAudio("417211053", var_232_12)
						arg_229_1:RecordAudio("417211053", var_232_12)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_417211", "417211053", "story_v_out_417211.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_417211", "417211053", "story_v_out_417211.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_13 = math.max(var_232_6, arg_229_1.talkMaxDuration)

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_13 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_5) / var_232_13

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_5 + var_232_13 and arg_229_1.time_ < var_232_5 + var_232_13 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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

		arg_229_1:InitPlayNodeList()
	end,
	Play417211054 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 417211054
		arg_233_1.duration_ = 3.87

		local var_233_0 = {
			zh = 3.866,
			ja = 3.4
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
				arg_233_0:Play417211055(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["10128"]) and arg_233_1.var_.actorSpriteComps10128 == nil then
				arg_233_1.var_.actorSpriteComps10128 = arg_233_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_0 = 0.2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["10128"]) then
				if arg_233_1.var_.actorSpriteComps10128 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								iter_236_1.color = Color.New(Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor2.r, (arg_233_1.time_ - 0) / var_236_0), Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor2.g, (arg_233_1.time_ - 0) / var_236_0), (Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor2.b, (arg_233_1.time_ - 0) / var_236_0)))
							else
								local var_236_1 = Mathf.Lerp(iter_236_1.color.r, 0.5, (arg_233_1.time_ - 0) / var_236_0)

								iter_236_1.color = Color.New(var_236_1, var_236_1, var_236_1)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["10128"]) and arg_233_1.var_.actorSpriteComps10128 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_236_3 then
						iter_236_3.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_233_1.var_.actorSpriteComps10128 = nil
			end

			local var_236_2 = 0
			local var_236_3 = 0.35

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1134].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3051")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_4 = arg_233_1:GetWordFromCfg(417211054)
				local var_236_5 = arg_233_1:FormatText(var_236_4.content)

				arg_233_1.text_.text = var_236_5

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_7 = 14 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 14)

				if (14 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 14)) > 0 and var_236_3 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_2
					end
				end

				arg_233_1.text_.text = var_236_5
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417211", "417211054", "story_v_out_417211.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_417211", "417211054", "story_v_out_417211.awb") / 1000

					if var_236_8 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_2
					end

					if var_236_4.prefab_name ~= "" and arg_233_1.actors_[var_236_4.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_4.prefab_name].transform, "story_v_out_417211", "417211054", "story_v_out_417211.awb")

						arg_233_1:RecordAudio("417211054", var_236_9)
						arg_233_1:RecordAudio("417211054", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_417211", "417211054", "story_v_out_417211.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_417211", "417211054", "story_v_out_417211.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_3, arg_233_1.talkMaxDuration)

			if var_236_2 <= arg_233_1.time_ and arg_233_1.time_ < var_236_2 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_2) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_2 + var_236_10 and arg_233_1.time_ < var_236_2 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play417211055 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 417211055
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play417211056(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10128 = arg_237_1.actors_["10128"].transform.localPosition
				arg_237_1.actors_["10128"].transform.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10128", 7)

				for iter_240_0 = 0, arg_237_1.actors_["10128"].transform.childCount - 1 do
					local var_240_0 = arg_237_1.actors_["10128"].transform:GetChild(iter_240_0)

					if var_240_0.name == "" or not string.find(var_240_0.name, "split") then
						var_240_0.gameObject:SetActive(true)
					else
						var_240_0.gameObject:SetActive(false)
					end
				end
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				arg_237_1.actors_["10128"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10128, Vector3.New(0, -2000, 0), (arg_237_1.time_ - 0) / var_240_1)
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				arg_237_1.actors_["10128"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_240_2 = 0
			local var_240_3 = 0.75

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_2 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_4 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(417211055).content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_6 = 30 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_4) / 30)

				if (30 <= 0 and var_240_3 or var_240_3 * (utf8.len(var_240_4) / 30)) > 0 and var_240_3 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_2 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_2
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_7 = math.max(var_240_3, arg_237_1.talkMaxDuration)

			if var_240_2 <= arg_237_1.time_ and arg_237_1.time_ < var_240_2 + var_240_7 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_2) / var_240_7

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_2 + var_240_7 and arg_237_1.time_ < var_240_2 + var_240_7 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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

		arg_237_1:InitPlayNodeList()
	end,
	Play417211056 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 417211056
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
			arg_241_1.auto_ = false
		end

		function arg_241_1.playNext_(arg_243_0)
			arg_241_1.onStoryFinished_()
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 1

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

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(417211056).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 40 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 40)

				if (40 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 40)) > 0 and var_244_0 < var_244_3 then
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
	assets = {
		"TextureConfig/Background/B02c",
		"TextureConfig/Background/ST75",
		"TextureConfig/Background/I16f",
		"TextureConfig/Background/ST2106",
		"TextureConfig/Background/I16g"
	},
	voices = {
		"story_v_out_417211.awb"
	}
}
