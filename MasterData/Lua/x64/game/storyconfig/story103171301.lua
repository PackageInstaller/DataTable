return {
	Play317131001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317131001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317131002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K09f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K09f")
				var_4_0.name = "K09f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K09f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K09f

				arg_1_1.bgs_.K09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K09f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 0.6 < arg_1_1.time_ and arg_1_1.time_ <= 0.6 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_tokoyo", "bgm_activity_2_6_story_karasugo_tokoyo")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_fight_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.975

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(317131001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 39 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 39)

				if (39 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 39)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play317131002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317131002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play317131003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.325

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(317131002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 53 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 53)

				if (53 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 53)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play317131003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317131003
		arg_13_1.duration_ = 2.6

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play317131004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.325

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[550].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(317131003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 13 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 13)

				if (13 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 13)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131003", "story_v_out_317131.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_317131", "317131003", "story_v_out_317131.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_317131", "317131003", "story_v_out_317131.awb")

						arg_13_1:RecordAudio("317131003", var_16_6)
						arg_13_1:RecordAudio("317131003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_317131", "317131003", "story_v_out_317131.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_317131", "317131003", "story_v_out_317131.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play317131004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317131004
		arg_17_1.duration_ = 5.67

		local var_17_0 = {
			zh = 4.2,
			ja = 5.666
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play317131005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.475

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[550].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(317131004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 19 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 19)

				if (19 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 19)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131004", "story_v_out_317131.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_317131", "317131004", "story_v_out_317131.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_317131", "317131004", "story_v_out_317131.awb")

						arg_17_1:RecordAudio("317131004", var_20_6)
						arg_17_1:RecordAudio("317131004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_317131", "317131004", "story_v_out_317131.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_317131", "317131004", "story_v_out_317131.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play317131005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317131005
		arg_21_1.duration_ = 6.97

		local var_21_0 = {
			zh = 5.266,
			ja = 6.966
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
				arg_21_0:Play317131006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "2079ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["2079ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["2079ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["2079ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["2079ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["2079ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos2079ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["2079ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect2079ui_story == nil then
				arg_21_1.var_.characterEffect2079ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect2079ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect2079ui_story then
				arg_21_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_24_8 = 0
			local var_24_9 = 0.5

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(317131005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 20 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 20)

				if (20 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 20)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131005", "story_v_out_317131.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_317131", "317131005", "story_v_out_317131.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_317131", "317131005", "story_v_out_317131.awb")

						arg_21_1:RecordAudio("317131005", var_24_15)
						arg_21_1:RecordAudio("317131005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_317131", "317131005", "story_v_out_317131.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_317131", "317131005", "story_v_out_317131.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play317131006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317131006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play317131007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["2079ui_story"]) and arg_25_1.var_.characterEffect2079ui_story == nil then
				arg_25_1.var_.characterEffect2079ui_story = arg_25_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["2079ui_story"]) then
				if arg_25_1.var_.characterEffect2079ui_story and not isNil(arg_25_1.actors_["2079ui_story"]) then
					arg_25_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_25_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["2079ui_story"]) and arg_25_1.var_.characterEffect2079ui_story then
				arg_25_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_25_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_gun", "")
			end

			local var_28_2 = 0
			local var_28_3 = 1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(317131006).content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 40 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 40)

				if (40 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 40)) > 0 and var_28_3 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_7 and arg_25_1.time_ < var_28_2 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play317131007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317131007
		arg_29_1.duration_ = 2.3

		local var_29_0 = {
			zh = 1.633,
			ja = 2.3
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
				arg_29_0:Play317131008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["2079ui_story"]) and arg_29_1.var_.characterEffect2079ui_story == nil then
				arg_29_1.var_.characterEffect2079ui_story = arg_29_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["2079ui_story"]) then
				if arg_29_1.var_.characterEffect2079ui_story and not isNil(arg_29_1.actors_["2079ui_story"]) then
					arg_29_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["2079ui_story"]) and arg_29_1.var_.characterEffect2079ui_story then
				arg_29_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_32_2 = 0
			local var_32_3 = 0.1

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(317131007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 4 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 4)

				if (4 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 4)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131007", "story_v_out_317131.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_317131", "317131007", "story_v_out_317131.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_317131", "317131007", "story_v_out_317131.awb")

						arg_29_1:RecordAudio("317131007", var_32_9)
						arg_29_1:RecordAudio("317131007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_317131", "317131007", "story_v_out_317131.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_317131", "317131007", "story_v_out_317131.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play317131008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317131008
		arg_33_1.duration_ = 5.1

		local var_33_0 = {
			zh = 3.7,
			ja = 5.1
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
				arg_33_0:Play317131009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["2079ui_story"]) and arg_33_1.var_.characterEffect2079ui_story == nil then
				arg_33_1.var_.characterEffect2079ui_story = arg_33_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["2079ui_story"]) then
				if arg_33_1.var_.characterEffect2079ui_story and not isNil(arg_33_1.actors_["2079ui_story"]) then
					arg_33_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_33_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["2079ui_story"]) and arg_33_1.var_.characterEffect2079ui_story then
				arg_33_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_33_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.55

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[550].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(317131008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 22 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 22)

				if (22 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 22)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131008", "story_v_out_317131.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_317131", "317131008", "story_v_out_317131.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_317131", "317131008", "story_v_out_317131.awb")

						arg_33_1:RecordAudio("317131008", var_36_8)
						arg_33_1:RecordAudio("317131008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_317131", "317131008", "story_v_out_317131.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_317131", "317131008", "story_v_out_317131.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_9 and arg_33_1.time_ < var_36_1 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play317131009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317131009
		arg_37_1.duration_ = 2.63

		local var_37_0 = {
			zh = 2.633,
			ja = 2.4
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
				arg_37_0:Play317131010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.275

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[550].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(317131009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 11 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 11)

				if (11 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 11)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131009", "story_v_out_317131.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_317131", "317131009", "story_v_out_317131.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_317131", "317131009", "story_v_out_317131.awb")

						arg_37_1:RecordAudio("317131009", var_40_6)
						arg_37_1:RecordAudio("317131009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_317131", "317131009", "story_v_out_317131.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_317131", "317131009", "story_v_out_317131.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play317131010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317131010
		arg_41_1.duration_ = 4.27

		local var_41_0 = {
			zh = 3.233,
			ja = 4.266
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play317131011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["2079ui_story"]) and arg_41_1.var_.characterEffect2079ui_story == nil then
				arg_41_1.var_.characterEffect2079ui_story = arg_41_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["2079ui_story"]) then
				if arg_41_1.var_.characterEffect2079ui_story and not isNil(arg_41_1.actors_["2079ui_story"]) then
					arg_41_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["2079ui_story"]) and arg_41_1.var_.characterEffect2079ui_story then
				arg_41_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_44_2 = 0
			local var_44_3 = 0.25

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(317131010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 10 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 10)

				if (10 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 10)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131010", "story_v_out_317131.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_317131", "317131010", "story_v_out_317131.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_317131", "317131010", "story_v_out_317131.awb")

						arg_41_1:RecordAudio("317131010", var_44_9)
						arg_41_1:RecordAudio("317131010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_317131", "317131010", "story_v_out_317131.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_317131", "317131010", "story_v_out_317131.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play317131011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 317131011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play317131012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos2079ui_story = arg_45_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["2079ui_story"].transform.position).z)
				arg_45_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["2079ui_story"].transform.localEulerAngles = arg_45_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["2079ui_story"].transform.position).z)
				arg_45_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["2079ui_story"].transform.localEulerAngles = arg_45_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["2079ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect2079ui_story == nil then
				arg_45_1.var_.characterEffect2079ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect2079ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_45_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_2)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect2079ui_story then
				arg_45_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_45_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_48_3 = 0
			local var_48_4 = 1.025

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_5 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(317131011).content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 41 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 41)

				if (41 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 41)) > 0 and var_48_4 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_3 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_3
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_4, arg_45_1.talkMaxDuration)

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_3) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_3 + var_48_8 and arg_45_1.time_ < var_48_3 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play317131012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 317131012
		arg_49_1.duration_ = 9

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play317131013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.bgs_.K09g == nil then
				local var_52_0 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K09g")
				var_52_0.name = "K09g"
				var_52_0.transform.parent = arg_49_1.stage_.transform
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_.K09g = var_52_0
			end

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 then
				local var_52_1 = arg_49_1.bgs_.K09g

				arg_49_1.bgs_.K09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_52_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_2 = var_52_1:GetComponent("SpriteRenderer")

				if var_52_2 and var_52_2.sprite then
					local var_52_3 = 2 * (var_52_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_52_1.transform.localScale = Vector3.New(var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "K09g" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_4 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.allBtn_.enabled = false
			end

			if arg_49_1.time_ >= var_52_4 + 0.3 and arg_49_1.time_ < var_52_4 + 0.3 + arg_52_0 then
				arg_49_1.allBtn_.enabled = true
			end

			local var_52_5 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_6 = 2

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 then
				local var_52_7 = Color.New(0, 0, 0)

				var_52_7.a = Mathf.Lerp(0, 1, (arg_49_1.time_ - var_52_5) / var_52_6)
				arg_49_1.mask_.color = var_52_7
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 then
				local var_52_8 = Color.New(0, 0, 0)

				var_52_8.a = 1
				arg_49_1.mask_.color = var_52_8
			end

			local var_52_9 = 2

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_10 = 2

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_10 then
				local var_52_11 = Color.New(0, 0, 0)

				var_52_11.a = Mathf.Lerp(1, 0, (arg_49_1.time_ - var_52_9) / var_52_10)
				arg_49_1.mask_.color = var_52_11
			end

			if arg_49_1.time_ >= var_52_9 + var_52_10 and arg_49_1.time_ < var_52_9 + var_52_10 + arg_52_0 then
				local var_52_12 = Color.New(0, 0, 0)

				arg_49_1.mask_.enabled = false
				var_52_12.a = 0
				arg_49_1.mask_.color = var_52_12
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_fastshot", "")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:AudioAction("stop", "effect", "se_story_126_01", "se_story_126_01_fight_loop", "")
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_15 = 4
			local var_52_16 = 0.7

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_17 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_17:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_18 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(317131012).content)

				arg_49_1.text_.text = var_52_18

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_20 = 28 <= 0 and var_52_16 or var_52_16 * (utf8.len(var_52_18) / 28)

				if (28 <= 0 and var_52_16 or var_52_16 * (utf8.len(var_52_18) / 28)) > 0 and var_52_16 < var_52_20 then
					arg_49_1.talkMaxDuration = var_52_20
					var_52_15 = var_52_15 + 0.3

					if var_52_20 + var_52_15 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_15
					end
				end

				arg_49_1.text_.text = var_52_18
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_21 = var_52_15 + 0.3
			local var_52_22 = math.max(var_52_16, arg_49_1.talkMaxDuration)

			if var_52_15 + 0.3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_21 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_21) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_21 + var_52_22 and arg_49_1.time_ < var_52_21 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play317131013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 317131013
		arg_55_1.duration_ = 2.77

		local var_55_0 = {
			zh = 0.999999999999,
			ja = 2.766
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
				arg_55_0:Play317131014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos2079ui_story = arg_55_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["2079ui_story"].transform.position).z)
				arg_55_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["2079ui_story"].transform.localEulerAngles = arg_55_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_55_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["2079ui_story"].transform.position).z)
				arg_55_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["2079ui_story"].transform.localEulerAngles = arg_55_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["2079ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect2079ui_story == nil then
				arg_55_1.var_.characterEffect2079ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect2079ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect2079ui_story then
				arg_55_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_4 = 0
			local var_58_5 = 0.05

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(317131013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 2 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 2)

				if (2 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 2)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131013", "story_v_out_317131.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_317131", "317131013", "story_v_out_317131.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_317131", "317131013", "story_v_out_317131.awb")

						arg_55_1:RecordAudio("317131013", var_58_11)
						arg_55_1:RecordAudio("317131013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_317131", "317131013", "story_v_out_317131.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_317131", "317131013", "story_v_out_317131.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play317131014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 317131014
		arg_59_1.duration_ = 2.9

		local var_59_0 = {
			zh = 2.9,
			ja = 2.733
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
				arg_59_0:Play317131015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["2079ui_story"]) and arg_59_1.var_.characterEffect2079ui_story == nil then
				arg_59_1.var_.characterEffect2079ui_story = arg_59_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["2079ui_story"]) then
				if arg_59_1.var_.characterEffect2079ui_story and not isNil(arg_59_1.actors_["2079ui_story"]) then
					arg_59_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_59_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["2079ui_story"]) and arg_59_1.var_.characterEffect2079ui_story then
				arg_59_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_59_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_62_1 = 0
			local var_62_2 = 0.275

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[557].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(317131014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_6 = 11 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_4) / 11)

				if (11 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_4) / 11)) > 0 and var_62_2 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131014", "story_v_out_317131.awb") ~= 0 then
					local var_62_7 = manager.audio:GetVoiceLength("story_v_out_317131", "317131014", "story_v_out_317131.awb") / 1000

					if var_62_7 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_1
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_317131", "317131014", "story_v_out_317131.awb")

						arg_59_1:RecordAudio("317131014", var_62_8)
						arg_59_1:RecordAudio("317131014", var_62_8)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_317131", "317131014", "story_v_out_317131.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_317131", "317131014", "story_v_out_317131.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_9 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_9 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_9

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_9 and arg_59_1.time_ < var_62_1 + var_62_9 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play317131015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 317131015
		arg_63_1.duration_ = 1.6

		local var_63_0 = {
			zh = 0.999999999999,
			ja = 1.6
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
				arg_63_0:Play317131016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["2079ui_story"]) and arg_63_1.var_.characterEffect2079ui_story == nil then
				arg_63_1.var_.characterEffect2079ui_story = arg_63_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["2079ui_story"]) then
				if arg_63_1.var_.characterEffect2079ui_story and not isNil(arg_63_1.actors_["2079ui_story"]) then
					arg_63_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["2079ui_story"]) and arg_63_1.var_.characterEffect2079ui_story then
				arg_63_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_66_2 = 0
			local var_66_3 = 0.2

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_4 = arg_63_1:GetWordFromCfg(317131015)
				local var_66_5 = arg_63_1:FormatText(var_66_4.content)

				arg_63_1.text_.text = var_66_5

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_7 = 8 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_5) / 8)

				if (8 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_5) / 8)) > 0 and var_66_3 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_2
					end
				end

				arg_63_1.text_.text = var_66_5
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131015", "story_v_out_317131.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_317131", "317131015", "story_v_out_317131.awb") / 1000

					if var_66_8 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_2
					end

					if var_66_4.prefab_name ~= "" and arg_63_1.actors_[var_66_4.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_4.prefab_name].transform, "story_v_out_317131", "317131015", "story_v_out_317131.awb")

						arg_63_1:RecordAudio("317131015", var_66_9)
						arg_63_1:RecordAudio("317131015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_317131", "317131015", "story_v_out_317131.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_317131", "317131015", "story_v_out_317131.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_3, arg_63_1.talkMaxDuration)

			if var_66_2 <= arg_63_1.time_ and arg_63_1.time_ < var_66_2 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_2) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_2 + var_66_10 and arg_63_1.time_ < var_66_2 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play317131016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 317131016
		arg_67_1.duration_ = 4.17

		local var_67_0 = {
			zh = 4.166,
			ja = 2.933
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
				arg_67_0:Play317131017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["2079ui_story"]) and arg_67_1.var_.characterEffect2079ui_story == nil then
				arg_67_1.var_.characterEffect2079ui_story = arg_67_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["2079ui_story"]) then
				if arg_67_1.var_.characterEffect2079ui_story and not isNil(arg_67_1.actors_["2079ui_story"]) then
					arg_67_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_67_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["2079ui_story"]) and arg_67_1.var_.characterEffect2079ui_story then
				arg_67_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_67_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_70_1 = 0
			local var_70_2 = 0.225

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[557].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(317131016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_6 = 9 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 9)

				if (9 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_4) / 9)) > 0 and var_70_2 < var_70_6 then
					arg_67_1.talkMaxDuration = var_70_6

					if var_70_6 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_6 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131016", "story_v_out_317131.awb") ~= 0 then
					local var_70_7 = manager.audio:GetVoiceLength("story_v_out_317131", "317131016", "story_v_out_317131.awb") / 1000

					if var_70_7 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_1
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_317131", "317131016", "story_v_out_317131.awb")

						arg_67_1:RecordAudio("317131016", var_70_8)
						arg_67_1:RecordAudio("317131016", var_70_8)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_317131", "317131016", "story_v_out_317131.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_317131", "317131016", "story_v_out_317131.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_9 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_9 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_9

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_9 and arg_67_1.time_ < var_70_1 + var_70_9 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play317131017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 317131017
		arg_71_1.duration_ = 5.87

		local var_71_0 = {
			zh = 4.8,
			ja = 5.866
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
				arg_71_0:Play317131018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["2079ui_story"]) and arg_71_1.var_.characterEffect2079ui_story == nil then
				arg_71_1.var_.characterEffect2079ui_story = arg_71_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["2079ui_story"]) then
				if arg_71_1.var_.characterEffect2079ui_story and not isNil(arg_71_1.actors_["2079ui_story"]) then
					arg_71_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["2079ui_story"]) and arg_71_1.var_.characterEffect2079ui_story then
				arg_71_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_74_2 = 0
			local var_74_3 = 0.625

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_4 = arg_71_1:GetWordFromCfg(317131017)
				local var_74_5 = arg_71_1:FormatText(var_74_4.content)

				arg_71_1.text_.text = var_74_5

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_7 = 25 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_5) / 25)

				if (25 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_5) / 25)) > 0 and var_74_3 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_2 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_2
					end
				end

				arg_71_1.text_.text = var_74_5
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131017", "story_v_out_317131.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_317131", "317131017", "story_v_out_317131.awb") / 1000

					if var_74_8 + var_74_2 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_2
					end

					if var_74_4.prefab_name ~= "" and arg_71_1.actors_[var_74_4.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_4.prefab_name].transform, "story_v_out_317131", "317131017", "story_v_out_317131.awb")

						arg_71_1:RecordAudio("317131017", var_74_9)
						arg_71_1:RecordAudio("317131017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_317131", "317131017", "story_v_out_317131.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_317131", "317131017", "story_v_out_317131.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_3, arg_71_1.talkMaxDuration)

			if var_74_2 <= arg_71_1.time_ and arg_71_1.time_ < var_74_2 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_2) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_2 + var_74_10 and arg_71_1.time_ < var_74_2 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play317131018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 317131018
		arg_75_1.duration_ = 2.63

		local var_75_0 = {
			zh = 1.5,
			ja = 2.633
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
				arg_75_0:Play317131019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["2079ui_story"]) and arg_75_1.var_.characterEffect2079ui_story == nil then
				arg_75_1.var_.characterEffect2079ui_story = arg_75_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["2079ui_story"]) then
				if arg_75_1.var_.characterEffect2079ui_story and not isNil(arg_75_1.actors_["2079ui_story"]) then
					arg_75_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_75_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["2079ui_story"]) and arg_75_1.var_.characterEffect2079ui_story then
				arg_75_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_75_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 0.175

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[557].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:GetWordFromCfg(317131018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_6 = 7 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_4) / 7)

				if (7 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_4) / 7)) > 0 and var_78_2 < var_78_6 then
					arg_75_1.talkMaxDuration = var_78_6

					if var_78_6 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131018", "story_v_out_317131.awb") ~= 0 then
					local var_78_7 = manager.audio:GetVoiceLength("story_v_out_317131", "317131018", "story_v_out_317131.awb") / 1000

					if var_78_7 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_1
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_317131", "317131018", "story_v_out_317131.awb")

						arg_75_1:RecordAudio("317131018", var_78_8)
						arg_75_1:RecordAudio("317131018", var_78_8)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_317131", "317131018", "story_v_out_317131.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_317131", "317131018", "story_v_out_317131.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_9 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_9 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_9

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_9 and arg_75_1.time_ < var_78_1 + var_78_9 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play317131019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 317131019
		arg_79_1.duration_ = 10.2

		local var_79_0 = {
			zh = 6.866,
			ja = 10.2
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
				arg_79_0:Play317131020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["2079ui_story"]) and arg_79_1.var_.characterEffect2079ui_story == nil then
				arg_79_1.var_.characterEffect2079ui_story = arg_79_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["2079ui_story"]) then
				if arg_79_1.var_.characterEffect2079ui_story and not isNil(arg_79_1.actors_["2079ui_story"]) then
					arg_79_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["2079ui_story"]) and arg_79_1.var_.characterEffect2079ui_story then
				arg_79_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_82_2 = 0
			local var_82_3 = 0.9

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:GetWordFromCfg(317131019)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 36 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 36)

				if (36 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 36)) > 0 and var_82_3 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131019", "story_v_out_317131.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_317131", "317131019", "story_v_out_317131.awb") / 1000

					if var_82_8 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_2
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_out_317131", "317131019", "story_v_out_317131.awb")

						arg_79_1:RecordAudio("317131019", var_82_9)
						arg_79_1:RecordAudio("317131019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_317131", "317131019", "story_v_out_317131.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_317131", "317131019", "story_v_out_317131.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_10 and arg_79_1.time_ < var_82_2 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play317131020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 317131020
		arg_83_1.duration_ = 4.3

		local var_83_0 = {
			zh = 4.3,
			ja = 2.333
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
				arg_83_0:Play317131021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["2079ui_story"]) and arg_83_1.var_.characterEffect2079ui_story == nil then
				arg_83_1.var_.characterEffect2079ui_story = arg_83_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["2079ui_story"]) then
				if arg_83_1.var_.characterEffect2079ui_story and not isNil(arg_83_1.actors_["2079ui_story"]) then
					arg_83_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_83_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["2079ui_story"]) and arg_83_1.var_.characterEffect2079ui_story then
				arg_83_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_83_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.15

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[557].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(317131020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 6 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 6)

				if (6 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 6)) > 0 and var_86_2 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131020", "story_v_out_317131.awb") ~= 0 then
					local var_86_7 = manager.audio:GetVoiceLength("story_v_out_317131", "317131020", "story_v_out_317131.awb") / 1000

					if var_86_7 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_1
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_317131", "317131020", "story_v_out_317131.awb")

						arg_83_1:RecordAudio("317131020", var_86_8)
						arg_83_1:RecordAudio("317131020", var_86_8)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_317131", "317131020", "story_v_out_317131.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_317131", "317131020", "story_v_out_317131.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_9 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_9 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_9

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_9 and arg_83_1.time_ < var_86_1 + var_86_9 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play317131021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 317131021
		arg_87_1.duration_ = 4.2

		local var_87_0 = {
			zh = 3.4,
			ja = 4.2
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
				arg_87_0:Play317131022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["2079ui_story"]) and arg_87_1.var_.characterEffect2079ui_story == nil then
				arg_87_1.var_.characterEffect2079ui_story = arg_87_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["2079ui_story"]) then
				if arg_87_1.var_.characterEffect2079ui_story and not isNil(arg_87_1.actors_["2079ui_story"]) then
					arg_87_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["2079ui_story"]) and arg_87_1.var_.characterEffect2079ui_story then
				arg_87_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_90_2 = 0
			local var_90_3 = 0.525

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_4 = arg_87_1:GetWordFromCfg(317131021)
				local var_90_5 = arg_87_1:FormatText(var_90_4.content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_7 = 21 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 21)

				if (21 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 21)) > 0 and var_90_3 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_2
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131021", "story_v_out_317131.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_317131", "317131021", "story_v_out_317131.awb") / 1000

					if var_90_8 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_2
					end

					if var_90_4.prefab_name ~= "" and arg_87_1.actors_[var_90_4.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_4.prefab_name].transform, "story_v_out_317131", "317131021", "story_v_out_317131.awb")

						arg_87_1:RecordAudio("317131021", var_90_9)
						arg_87_1:RecordAudio("317131021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_317131", "317131021", "story_v_out_317131.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_317131", "317131021", "story_v_out_317131.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_3, arg_87_1.talkMaxDuration)

			if var_90_2 <= arg_87_1.time_ and arg_87_1.time_ < var_90_2 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_2) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_2 + var_90_10 and arg_87_1.time_ < var_90_2 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play317131022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 317131022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play317131023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos2079ui_story = arg_91_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["2079ui_story"].transform.position).z)
				arg_91_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["2079ui_story"].transform.localEulerAngles = arg_91_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["2079ui_story"].transform.position).z)
				arg_91_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["2079ui_story"].transform.localEulerAngles = arg_91_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["2079ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect2079ui_story == nil then
				arg_91_1.var_.characterEffect2079ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect2079ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_91_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_2)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect2079ui_story then
				arg_91_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_91_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_94_3 = 0
			local var_94_4 = 1.2

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_3 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_5 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(317131022).content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 48 <= 0 and var_94_4 or var_94_4 * (utf8.len(var_94_5) / 48)

				if (48 <= 0 and var_94_4 or var_94_4 * (utf8.len(var_94_5) / 48)) > 0 and var_94_4 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_3 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_3
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_4, arg_91_1.talkMaxDuration)

			if var_94_3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_3 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_3) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_3 + var_94_8 and arg_91_1.time_ < var_94_3 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play317131023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 317131023
		arg_95_1.duration_ = 9.17

		local var_95_0 = {
			zh = 6.3,
			ja = 9.166
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
				arg_95_0:Play317131024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.525

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[557].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_1 = arg_95_1:GetWordFromCfg(317131023)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 21 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 21)

				if (21 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 21)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131023", "story_v_out_317131.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_317131", "317131023", "story_v_out_317131.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_317131", "317131023", "story_v_out_317131.awb")

						arg_95_1:RecordAudio("317131023", var_98_6)
						arg_95_1:RecordAudio("317131023", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_317131", "317131023", "story_v_out_317131.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_317131", "317131023", "story_v_out_317131.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play317131024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 317131024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play317131025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(317131024).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 40 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 40)

				if (40 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 40)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play317131025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 317131025
		arg_103_1.duration_ = 11.2

		local var_103_0 = {
			zh = 7.6,
			ja = 11.2
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
				arg_103_0:Play317131026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos2079ui_story = arg_103_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["2079ui_story"].transform.position).z)
				arg_103_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["2079ui_story"].transform.localEulerAngles = arg_103_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_103_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["2079ui_story"].transform.position).z)
				arg_103_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["2079ui_story"].transform.localEulerAngles = arg_103_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["2079ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect2079ui_story == nil then
				arg_103_1.var_.characterEffect2079ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect2079ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect2079ui_story then
				arg_103_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_106_4 = 0
			local var_106_5 = 0.975

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(317131025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 39 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 39)

				if (39 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 39)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131025", "story_v_out_317131.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_317131", "317131025", "story_v_out_317131.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_out_317131", "317131025", "story_v_out_317131.awb")

						arg_103_1:RecordAudio("317131025", var_106_11)
						arg_103_1:RecordAudio("317131025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_317131", "317131025", "story_v_out_317131.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_317131", "317131025", "story_v_out_317131.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_12 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_12 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_12

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_12 and arg_103_1.time_ < var_106_4 + var_106_12 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play317131026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 317131026
		arg_107_1.duration_ = 6.7

		local var_107_0 = {
			zh = 6.7,
			ja = 4.733
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
				arg_107_0:Play317131027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["2079ui_story"]) and arg_107_1.var_.characterEffect2079ui_story == nil then
				arg_107_1.var_.characterEffect2079ui_story = arg_107_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["2079ui_story"]) then
				if arg_107_1.var_.characterEffect2079ui_story and not isNil(arg_107_1.actors_["2079ui_story"]) then
					arg_107_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_107_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["2079ui_story"]) and arg_107_1.var_.characterEffect2079ui_story then
				arg_107_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_107_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0
			local var_110_2 = 0.15

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[557].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:GetWordFromCfg(317131026)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 6 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_4) / 6)

				if (6 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_4) / 6)) > 0 and var_110_2 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131026", "story_v_out_317131.awb") ~= 0 then
					local var_110_7 = manager.audio:GetVoiceLength("story_v_out_317131", "317131026", "story_v_out_317131.awb") / 1000

					if var_110_7 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_1
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_317131", "317131026", "story_v_out_317131.awb")

						arg_107_1:RecordAudio("317131026", var_110_8)
						arg_107_1:RecordAudio("317131026", var_110_8)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_317131", "317131026", "story_v_out_317131.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_317131", "317131026", "story_v_out_317131.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_9 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_9 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_9

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_9 and arg_107_1.time_ < var_110_1 + var_110_9 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play317131027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 317131027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play317131028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.625

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(317131027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 25 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 25)

				if (25 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 25)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play317131028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 317131028
		arg_115_1.duration_ = 9.43

		local var_115_0 = {
			zh = 9.433,
			ja = 7.9
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
				arg_115_0:Play317131029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["2079ui_story"]) and arg_115_1.var_.characterEffect2079ui_story == nil then
				arg_115_1.var_.characterEffect2079ui_story = arg_115_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["2079ui_story"]) then
				if arg_115_1.var_.characterEffect2079ui_story and not isNil(arg_115_1.actors_["2079ui_story"]) then
					arg_115_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["2079ui_story"]) and arg_115_1.var_.characterEffect2079ui_story then
				arg_115_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_118_2 = 0
			local var_118_3 = 0.85

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_4 = arg_115_1:GetWordFromCfg(317131028)
				local var_118_5 = arg_115_1:FormatText(var_118_4.content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 34 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 34)

				if (34 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 34)) > 0 and var_118_3 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131028", "story_v_out_317131.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_317131", "317131028", "story_v_out_317131.awb") / 1000

					if var_118_8 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_2
					end

					if var_118_4.prefab_name ~= "" and arg_115_1.actors_[var_118_4.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_4.prefab_name].transform, "story_v_out_317131", "317131028", "story_v_out_317131.awb")

						arg_115_1:RecordAudio("317131028", var_118_9)
						arg_115_1:RecordAudio("317131028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_317131", "317131028", "story_v_out_317131.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_317131", "317131028", "story_v_out_317131.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_3, arg_115_1.talkMaxDuration)

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_2) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_2 + var_118_10 and arg_115_1.time_ < var_118_2 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play317131029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 317131029
		arg_119_1.duration_ = 9

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play317131030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 2 < arg_119_1.time_ and arg_119_1.time_ <= 2 + arg_122_0 then
				local var_122_0 = arg_119_1.bgs_.K09g

				arg_119_1.bgs_.K09g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_122_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_1 = var_122_0:GetComponent("SpriteRenderer")

				if var_122_1 and var_122_1.sprite then
					local var_122_2 = 2 * (var_122_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_122_0.transform.localScale = Vector3.New(var_122_2 / var_122_1.sprite.bounds.size.y < var_122_2 * manager.ui.mainCameraCom_.aspect / var_122_1.sprite.bounds.size.x and var_122_2 * manager.ui.mainCameraCom_.aspect / var_122_1.sprite.bounds.size.x or var_122_2 / var_122_1.sprite.bounds.size.y, var_122_2 / var_122_1.sprite.bounds.size.y < var_122_2 * manager.ui.mainCameraCom_.aspect / var_122_1.sprite.bounds.size.x and var_122_2 * manager.ui.mainCameraCom_.aspect / var_122_1.sprite.bounds.size.x or var_122_2 / var_122_1.sprite.bounds.size.y, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "K09g" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_122_3 = 0

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_3 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_4 = 2

			if var_122_3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_3 + var_122_4 then
				local var_122_5 = Color.New(0, 0, 0)

				var_122_5.a = Mathf.Lerp(0, 1, (arg_119_1.time_ - var_122_3) / var_122_4)
				arg_119_1.mask_.color = var_122_5
			end

			if arg_119_1.time_ >= var_122_3 + var_122_4 and arg_119_1.time_ < var_122_3 + var_122_4 + arg_122_0 then
				local var_122_6 = Color.New(0, 0, 0)

				var_122_6.a = 1
				arg_119_1.mask_.color = var_122_6
			end

			local var_122_7 = 2

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_7 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_8 = 2

			if var_122_7 <= arg_119_1.time_ and arg_119_1.time_ < var_122_7 + var_122_8 then
				local var_122_9 = Color.New(0, 0, 0)

				var_122_9.a = Mathf.Lerp(1, 0, (arg_119_1.time_ - var_122_7) / var_122_8)
				arg_119_1.mask_.color = var_122_9
			end

			if arg_119_1.time_ >= var_122_7 + var_122_8 and arg_119_1.time_ < var_122_7 + var_122_8 + arg_122_0 then
				local var_122_10 = Color.New(0, 0, 0)

				arg_119_1.mask_.enabled = false
				var_122_10.a = 0
				arg_119_1.mask_.color = var_122_10
			end

			local var_122_11 = arg_119_1.actors_["2079ui_story"].transform

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= 2 + arg_122_0 then
				arg_119_1.var_.moveOldPos2079ui_story = var_122_11.localPosition
			end

			local var_122_12 = 0.001

			if 2 <= arg_119_1.time_ and arg_119_1.time_ < 2 + var_122_12 then
				var_122_11.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 2) / var_122_12)
				var_122_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_11.position).x, (manager.ui.mainCamera.transform.position - var_122_11.position).y, (manager.ui.mainCamera.transform.position - var_122_11.position).z)
				var_122_11.localEulerAngles.z = 0
				var_122_11.localEulerAngles.x = 0
				var_122_11.localEulerAngles = var_122_11.localEulerAngles
			end

			if arg_119_1.time_ >= 2 + var_122_12 and arg_119_1.time_ < 2 + var_122_12 + arg_122_0 then
				var_122_11.localPosition = Vector3.New(0, 100, 0)
				var_122_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_11.position).x, (manager.ui.mainCamera.transform.position - var_122_11.position).y, (manager.ui.mainCamera.transform.position - var_122_11.position).z)
				var_122_11.localEulerAngles.z = 0
				var_122_11.localEulerAngles.x = 0
				var_122_11.localEulerAngles = var_122_11.localEulerAngles
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_13 = 4
			local var_122_14 = 1.125

			if 4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_13 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_15 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_15:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_16 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(317131029).content)

				arg_119_1.text_.text = var_122_16

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_18 = 45 <= 0 and var_122_14 or var_122_14 * (utf8.len(var_122_16) / 45)

				if (45 <= 0 and var_122_14 or var_122_14 * (utf8.len(var_122_16) / 45)) > 0 and var_122_14 < var_122_18 then
					arg_119_1.talkMaxDuration = var_122_18
					var_122_13 = var_122_13 + 0.3

					if var_122_18 + var_122_13 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_18 + var_122_13
					end
				end

				arg_119_1.text_.text = var_122_16
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_19 = var_122_13 + 0.3
			local var_122_20 = math.max(var_122_14, arg_119_1.talkMaxDuration)

			if var_122_13 + 0.3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_19 + var_122_20 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_19) / var_122_20

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_19 + var_122_20 and arg_119_1.time_ < var_122_19 + var_122_20 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play317131030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 317131030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play317131031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 1.4

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(317131030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 56 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 56)

				if (56 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 56)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play317131031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 317131031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play317131032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun", "")
			end

			local var_132_1 = 0
			local var_132_2 = 0.675

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(317131031).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 27 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 27)

				if (27 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 27)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play317131032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 317131032
		arg_133_1.duration_ = 2.93

		local var_133_0 = {
			zh = 2.233,
			ja = 2.933
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play317131033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if arg_133_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_136_0 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_133_1.stage_.transform)

				var_136_0.name = "2078ui_story"
				var_136_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_["2078ui_story"] = var_136_0

				local var_136_1 = var_136_0:GetComponentInChildren(typeof(CharacterEffect))

				var_136_1.enabled = true

				local var_136_2 = GameObjectTools.GetOrAddComponent(var_136_0, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(false)
				end

				arg_133_1:ShowWeapon(var_136_1.transform, false)

				arg_133_1.var_["2078ui_story" .. "Animator"] = var_136_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_133_1.var_["2078ui_story" .. "Animator"].applyRootMotion = true
				arg_133_1.var_["2078ui_story" .. "LipSync"] = var_136_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_136_3 = arg_133_1.actors_["2078ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos2078ui_story = var_136_3.localPosition
			end

			local var_136_4 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				var_136_3.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_133_1.time_ - 0) / var_136_4)
				var_136_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_3.position).x, (manager.ui.mainCamera.transform.position - var_136_3.position).y, (manager.ui.mainCamera.transform.position - var_136_3.position).z)
				var_136_3.localEulerAngles.z = 0
				var_136_3.localEulerAngles.x = 0
				var_136_3.localEulerAngles = var_136_3.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				var_136_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_136_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_3.position).x, (manager.ui.mainCamera.transform.position - var_136_3.position).y, (manager.ui.mainCamera.transform.position - var_136_3.position).z)
				var_136_3.localEulerAngles.z = 0
				var_136_3.localEulerAngles.x = 0
				var_136_3.localEulerAngles = var_136_3.localEulerAngles
			end

			local var_136_5 = arg_133_1.actors_["2078ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.characterEffect2078ui_story == nil then
				arg_133_1.var_.characterEffect2078ui_story = var_136_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_6 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_6 and not isNil(var_136_5) then
				if arg_133_1.var_.characterEffect2078ui_story and not isNil(var_136_5) then
					arg_133_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_6 and arg_133_1.time_ < 0 + var_136_6 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.characterEffect2078ui_story then
				arg_133_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_136_8 = 0
			local var_136_9 = 0.25

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_10 = arg_133_1:GetWordFromCfg(317131032)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 10 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 10)

				if (10 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 10)) > 0 and var_136_9 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131032", "story_v_out_317131.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_317131", "317131032", "story_v_out_317131.awb") / 1000

					if var_136_14 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_8
					end

					if var_136_10.prefab_name ~= "" and arg_133_1.actors_[var_136_10.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_10.prefab_name].transform, "story_v_out_317131", "317131032", "story_v_out_317131.awb")

						arg_133_1:RecordAudio("317131032", var_136_15)
						arg_133_1:RecordAudio("317131032", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_317131", "317131032", "story_v_out_317131.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_317131", "317131032", "story_v_out_317131.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_16 and arg_133_1.time_ < var_136_8 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play317131033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 317131033
		arg_137_1.duration_ = 2.4

		local var_137_0 = {
			zh = 2,
			ja = 2.4
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play317131034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos2079ui_story = arg_137_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["2079ui_story"].transform.position).z)
				arg_137_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["2079ui_story"].transform.localEulerAngles = arg_137_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_137_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["2079ui_story"].transform.position).z)
				arg_137_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["2079ui_story"].transform.localEulerAngles = arg_137_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["2079ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect2079ui_story == nil then
				arg_137_1.var_.characterEffect2079ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect2079ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect2079ui_story then
				arg_137_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_140_4 = arg_137_1.actors_["2078ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos2078ui_story = var_140_4.localPosition
			end

			local var_140_5 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 then
				var_140_4.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_5)
				var_140_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_4.position).x, (manager.ui.mainCamera.transform.position - var_140_4.position).y, (manager.ui.mainCamera.transform.position - var_140_4.position).z)
				var_140_4.localEulerAngles.z = 0
				var_140_4.localEulerAngles.x = 0
				var_140_4.localEulerAngles = var_140_4.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 then
				var_140_4.localPosition = Vector3.New(0, 100, 0)
				var_140_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_4.position).x, (manager.ui.mainCamera.transform.position - var_140_4.position).y, (manager.ui.mainCamera.transform.position - var_140_4.position).z)
				var_140_4.localEulerAngles.z = 0
				var_140_4.localEulerAngles.x = 0
				var_140_4.localEulerAngles = var_140_4.localEulerAngles
			end

			local var_140_6 = 0
			local var_140_7 = 0.25

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(317131033)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 10 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 10)

				if (10 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 10)) > 0 and var_140_7 < var_140_11 then
					arg_137_1.talkMaxDuration = var_140_11

					if var_140_11 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131033", "story_v_out_317131.awb") ~= 0 then
					local var_140_12 = manager.audio:GetVoiceLength("story_v_out_317131", "317131033", "story_v_out_317131.awb") / 1000

					if var_140_12 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_6
					end

					if var_140_8.prefab_name ~= "" and arg_137_1.actors_[var_140_8.prefab_name] ~= nil then
						local var_140_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_8.prefab_name].transform, "story_v_out_317131", "317131033", "story_v_out_317131.awb")

						arg_137_1:RecordAudio("317131033", var_140_13)
						arg_137_1:RecordAudio("317131033", var_140_13)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_317131", "317131033", "story_v_out_317131.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_317131", "317131033", "story_v_out_317131.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play317131034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 317131034
		arg_141_1.duration_ = 7.4

		local var_141_0 = {
			zh = 7.4,
			ja = 4.733
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play317131035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 1

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(317131034)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 40 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 40)

				if (40 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 40)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131034", "story_v_out_317131.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_317131", "317131034", "story_v_out_317131.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_317131", "317131034", "story_v_out_317131.awb")

						arg_141_1:RecordAudio("317131034", var_144_6)
						arg_141_1:RecordAudio("317131034", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_317131", "317131034", "story_v_out_317131.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_317131", "317131034", "story_v_out_317131.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play317131035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 317131035
		arg_145_1.duration_ = 4.9

		local var_145_0 = {
			zh = 1.999999999999,
			ja = 4.9
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play317131036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if arg_145_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_148_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_145_1.stage_.transform)

				var_148_0.name = "1093ui_story"
				var_148_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1093ui_story"] = var_148_0

				local var_148_1 = var_148_0:GetComponentInChildren(typeof(CharacterEffect))

				var_148_1.enabled = true

				local var_148_2 = GameObjectTools.GetOrAddComponent(var_148_0, typeof(DynamicBoneHelper))

				if var_148_2 then
					var_148_2:EnableDynamicBone(false)
				end

				arg_145_1:ShowWeapon(var_148_1.transform, false)

				arg_145_1.var_["1093ui_story" .. "Animator"] = var_148_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_145_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_145_1.var_["1093ui_story" .. "LipSync"] = var_148_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_148_3 = arg_145_1.actors_["1093ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1093ui_story = var_148_3.localPosition
			end

			local var_148_4 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				var_148_3.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_145_1.time_ - 0) / var_148_4)
				var_148_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_3.position).x, (manager.ui.mainCamera.transform.position - var_148_3.position).y, (manager.ui.mainCamera.transform.position - var_148_3.position).z)
				var_148_3.localEulerAngles.z = 0
				var_148_3.localEulerAngles.x = 0
				var_148_3.localEulerAngles = var_148_3.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				var_148_3.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_148_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_3.position).x, (manager.ui.mainCamera.transform.position - var_148_3.position).y, (manager.ui.mainCamera.transform.position - var_148_3.position).z)
				var_148_3.localEulerAngles.z = 0
				var_148_3.localEulerAngles.x = 0
				var_148_3.localEulerAngles = var_148_3.localEulerAngles
			end

			local var_148_5 = arg_145_1.actors_["1093ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect1093ui_story == nil then
				arg_145_1.var_.characterEffect1093ui_story = var_148_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_6 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 and not isNil(var_148_5) then
				if arg_145_1.var_.characterEffect1093ui_story and not isNil(var_148_5) then
					arg_145_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.characterEffect1093ui_story then
				arg_145_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_8 = arg_145_1.actors_["2079ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos2079ui_story = var_148_8.localPosition
			end

			local var_148_9 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_9 then
				var_148_8.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_9)
				var_148_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_8.position).x, (manager.ui.mainCamera.transform.position - var_148_8.position).y, (manager.ui.mainCamera.transform.position - var_148_8.position).z)
				var_148_8.localEulerAngles.z = 0
				var_148_8.localEulerAngles.x = 0
				var_148_8.localEulerAngles = var_148_8.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_9 and arg_145_1.time_ < 0 + var_148_9 + arg_148_0 then
				var_148_8.localPosition = Vector3.New(0, 100, 0)
				var_148_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_8.position).x, (manager.ui.mainCamera.transform.position - var_148_8.position).y, (manager.ui.mainCamera.transform.position - var_148_8.position).z)
				var_148_8.localEulerAngles.z = 0
				var_148_8.localEulerAngles.x = 0
				var_148_8.localEulerAngles = var_148_8.localEulerAngles
			end

			local var_148_10 = 0
			local var_148_11 = 0.25

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_12 = arg_145_1:GetWordFromCfg(317131035)
				local var_148_13 = arg_145_1:FormatText(var_148_12.content)

				arg_145_1.text_.text = var_148_13

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_15 = 10 <= 0 and var_148_11 or var_148_11 * (utf8.len(var_148_13) / 10)

				if (10 <= 0 and var_148_11 or var_148_11 * (utf8.len(var_148_13) / 10)) > 0 and var_148_11 < var_148_15 then
					arg_145_1.talkMaxDuration = var_148_15

					if var_148_15 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_15 + var_148_10
					end
				end

				arg_145_1.text_.text = var_148_13
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131035", "story_v_out_317131.awb") ~= 0 then
					local var_148_16 = manager.audio:GetVoiceLength("story_v_out_317131", "317131035", "story_v_out_317131.awb") / 1000

					if var_148_16 + var_148_10 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_16 + var_148_10
					end

					if var_148_12.prefab_name ~= "" and arg_145_1.actors_[var_148_12.prefab_name] ~= nil then
						local var_148_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_12.prefab_name].transform, "story_v_out_317131", "317131035", "story_v_out_317131.awb")

						arg_145_1:RecordAudio("317131035", var_148_17)
						arg_145_1:RecordAudio("317131035", var_148_17)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_317131", "317131035", "story_v_out_317131.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_317131", "317131035", "story_v_out_317131.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_18 = math.max(var_148_11, arg_145_1.talkMaxDuration)

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_18 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_10) / var_148_18

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_10 + var_148_18 and arg_145_1.time_ < var_148_10 + var_148_18 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play317131036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 317131036
		arg_149_1.duration_ = 4.9

		local var_149_0 = {
			zh = 4.9,
			ja = 4.266
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
			arg_149_1.auto_ = false
		end

		function arg_149_1.playNext_(arg_151_0)
			arg_149_1.onStoryFinished_()
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if arg_149_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_152_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_149_1.stage_.transform)

				var_152_0.name = "1015ui_story"
				var_152_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_["1015ui_story"] = var_152_0

				local var_152_1 = var_152_0:GetComponentInChildren(typeof(CharacterEffect))

				var_152_1.enabled = true

				local var_152_2 = GameObjectTools.GetOrAddComponent(var_152_0, typeof(DynamicBoneHelper))

				if var_152_2 then
					var_152_2:EnableDynamicBone(false)
				end

				arg_149_1:ShowWeapon(var_152_1.transform, false)

				arg_149_1.var_["1015ui_story" .. "Animator"] = var_152_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_149_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_149_1.var_["1015ui_story" .. "LipSync"] = var_152_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_152_3 = arg_149_1.actors_["1015ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1015ui_story = var_152_3.localPosition
			end

			local var_152_4 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				var_152_3.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_149_1.time_ - 0) / var_152_4)
				var_152_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_3.position).x, (manager.ui.mainCamera.transform.position - var_152_3.position).y, (manager.ui.mainCamera.transform.position - var_152_3.position).z)
				var_152_3.localEulerAngles.z = 0
				var_152_3.localEulerAngles.x = 0
				var_152_3.localEulerAngles = var_152_3.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				var_152_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_152_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_3.position).x, (manager.ui.mainCamera.transform.position - var_152_3.position).y, (manager.ui.mainCamera.transform.position - var_152_3.position).z)
				var_152_3.localEulerAngles.z = 0
				var_152_3.localEulerAngles.x = 0
				var_152_3.localEulerAngles = var_152_3.localEulerAngles
			end

			local var_152_5 = arg_149_1.actors_["1015ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect1015ui_story == nil then
				arg_149_1.var_.characterEffect1015ui_story = var_152_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_6 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_6 and not isNil(var_152_5) then
				if arg_149_1.var_.characterEffect1015ui_story and not isNil(var_152_5) then
					arg_149_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_6 and arg_149_1.time_ < 0 + var_152_6 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect1015ui_story then
				arg_149_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_8 = arg_149_1.actors_["1093ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.characterEffect1093ui_story == nil then
				arg_149_1.var_.characterEffect1093ui_story = var_152_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_9 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_9 and not isNil(var_152_8) then
				if arg_149_1.var_.characterEffect1093ui_story and not isNil(var_152_8) then
					arg_149_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_9)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_9 and arg_149_1.time_ < 0 + var_152_9 + arg_152_0 and not isNil(var_152_8) and arg_149_1.var_.characterEffect1093ui_story then
				arg_149_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_152_10 = 0
			local var_152_11 = 0.55

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_12 = arg_149_1:GetWordFromCfg(317131036)
				local var_152_13 = arg_149_1:FormatText(var_152_12.content)

				arg_149_1.text_.text = var_152_13

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_15 = 22 <= 0 and var_152_11 or var_152_11 * (utf8.len(var_152_13) / 22)

				if (22 <= 0 and var_152_11 or var_152_11 * (utf8.len(var_152_13) / 22)) > 0 and var_152_11 < var_152_15 then
					arg_149_1.talkMaxDuration = var_152_15

					if var_152_15 + var_152_10 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_15 + var_152_10
					end
				end

				arg_149_1.text_.text = var_152_13
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317131", "317131036", "story_v_out_317131.awb") ~= 0 then
					local var_152_16 = manager.audio:GetVoiceLength("story_v_out_317131", "317131036", "story_v_out_317131.awb") / 1000

					if var_152_16 + var_152_10 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_16 + var_152_10
					end

					if var_152_12.prefab_name ~= "" and arg_149_1.actors_[var_152_12.prefab_name] ~= nil then
						local var_152_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_12.prefab_name].transform, "story_v_out_317131", "317131036", "story_v_out_317131.awb")

						arg_149_1:RecordAudio("317131036", var_152_17)
						arg_149_1:RecordAudio("317131036", var_152_17)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_317131", "317131036", "story_v_out_317131.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_317131", "317131036", "story_v_out_317131.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_18 = math.max(var_152_11, arg_149_1.talkMaxDuration)

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_18 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_10) / var_152_18

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_10 + var_152_18 and arg_149_1.time_ < var_152_10 + var_152_18 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K09f",
		"TextureConfig/Background/K09g"
	},
	voices = {
		"story_v_out_317131.awb"
	}
}
