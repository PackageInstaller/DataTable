return {
	Play318281001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318281001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318281002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K16h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K16h")
				var_4_0.name = "K16h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K16h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K16h

				arg_1_1.bgs_.K16h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K16h" then
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

			if 0.8 < arg_1_1.time_ and arg_1_1.time_ <= 0.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_10_battle_sasanami_photonrail", "bgm_activity_2_10_battle_sasanami_photonrail", "bgm_activity_2_10_battle_sasanami_photonrail.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_10_battle_sasanami_photonrail", "bgm_activity_2_10_battle_sasanami_photonrail")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 2
			local var_4_15 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(318281001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 32)

				if (32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 32)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play318281002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318281002
		arg_9_1.duration_ = 6.63

		local var_9_0 = {
			zh = 6.633,
			ja = 1.933
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
				arg_9_0:Play318281003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.075

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[648].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(318281002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 43 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 43)

				if (43 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 43)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281002", "story_v_out_318281.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_318281", "318281002", "story_v_out_318281.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_318281", "318281002", "story_v_out_318281.awb")

						arg_9_1:RecordAudio("318281002", var_12_6)
						arg_9_1:RecordAudio("318281002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_318281", "318281002", "story_v_out_318281.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_318281", "318281002", "story_v_out_318281.awb")
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
	Play318281003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318281003
		arg_13_1.duration_ = 4.93

		local var_13_0 = {
			zh = 4.933,
			ja = 3.766
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play318281004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.425

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[660].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(318281003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 17 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 17)

				if (17 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 17)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281003", "story_v_out_318281.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_318281", "318281003", "story_v_out_318281.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_318281", "318281003", "story_v_out_318281.awb")

						arg_13_1:RecordAudio("318281003", var_16_6)
						arg_13_1:RecordAudio("318281003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_318281", "318281003", "story_v_out_318281.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_318281", "318281003", "story_v_out_318281.awb")
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
	Play318281004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318281004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play318281005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.05

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(318281004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 42 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 42)

				if (42 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 42)) > 0 and var_20_0 < var_20_3 then
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
	Play318281005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318281005
		arg_21_1.duration_ = 9

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play318281006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.bgs_.K16i == nil then
				local var_24_0 = Object.Instantiate(arg_21_1.paintGo_)

				var_24_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K16i")
				var_24_0.name = "K16i"
				var_24_0.transform.parent = arg_21_1.stage_.transform
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_.K16i = var_24_0
			end

			if 2 < arg_21_1.time_ and arg_21_1.time_ <= 2 + arg_24_0 then
				local var_24_1 = arg_21_1.bgs_.K16i

				arg_21_1.bgs_.K16i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_24_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_2 = var_24_1:GetComponent("SpriteRenderer")

				if var_24_2 and var_24_2.sprite then
					local var_24_3 = 2 * (var_24_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_24_1.transform.localScale = Vector3.New(var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "K16i" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_4 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_5 = 2

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_5 then
				local var_24_6 = Color.New(0, 0, 0)

				var_24_6.a = Mathf.Lerp(0, 1, (arg_21_1.time_ - var_24_4) / var_24_5)
				arg_21_1.mask_.color = var_24_6
			end

			if arg_21_1.time_ >= var_24_4 + var_24_5 and arg_21_1.time_ < var_24_4 + var_24_5 + arg_24_0 then
				local var_24_7 = Color.New(0, 0, 0)

				var_24_7.a = 1
				arg_21_1.mask_.color = var_24_7
			end

			local var_24_8 = 2

			if 2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_9 = 2

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 then
				local var_24_10 = Color.New(0, 0, 0)

				var_24_10.a = Mathf.Lerp(1, 0, (arg_21_1.time_ - var_24_8) / var_24_9)
				arg_21_1.mask_.color = var_24_10
			end

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 then
				local var_24_11 = Color.New(0, 0, 0)

				arg_21_1.mask_.enabled = false
				var_24_11.a = 0
				arg_21_1.mask_.color = var_24_11
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_12 = 4
			local var_24_13 = 1

			if 4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_14 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_14:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_15 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(318281005).content)

				arg_21_1.text_.text = var_24_15

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_17 = 40 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_15) / 40)

				if (40 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_15) / 40)) > 0 and var_24_13 < var_24_17 then
					arg_21_1.talkMaxDuration = var_24_17
					var_24_12 = var_24_12 + 0.3

					if var_24_17 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_12
					end
				end

				arg_21_1.text_.text = var_24_15
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_18 = var_24_12 + 0.3
			local var_24_19 = math.max(var_24_13, arg_21_1.talkMaxDuration)

			if var_24_12 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_18 + var_24_19 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_18) / var_24_19

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_18 + var_24_19 and arg_21_1.time_ < var_24_18 + var_24_19 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play318281006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 318281006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play318281007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_explosion", "")
			end

			local var_30_1 = 0
			local var_30_2 = 1.25

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_3 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(318281006).content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 50 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 50)

				if (50 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 50)) > 0 and var_30_2 < var_30_5 then
					arg_27_1.talkMaxDuration = var_30_5

					if var_30_5 + var_30_1 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + var_30_1
					end
				end

				arg_27_1.text_.text = var_30_3
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_6 = math.max(var_30_2, arg_27_1.talkMaxDuration)

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_6 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_1) / var_30_6

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_1 + var_30_6 and arg_27_1.time_ < var_30_1 + var_30_6 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play318281007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 318281007
		arg_31_1.duration_ = 8

		local var_31_0 = {
			zh = 3.466,
			ja = 8
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
				arg_31_0:Play318281008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if arg_31_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_34_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_31_1.stage_.transform)

				var_34_0.name = "10066ui_story"
				var_34_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["10066ui_story"] = var_34_0

				local var_34_1 = var_34_0:GetComponentInChildren(typeof(CharacterEffect))

				var_34_1.enabled = true

				local var_34_2 = GameObjectTools.GetOrAddComponent(var_34_0, typeof(DynamicBoneHelper))

				if var_34_2 then
					var_34_2:EnableDynamicBone(false)
				end

				arg_31_1:ShowWeapon(var_34_1.transform, false)

				arg_31_1.var_["10066ui_story" .. "Animator"] = var_34_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_31_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_31_1.var_["10066ui_story" .. "LipSync"] = var_34_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_34_3 = arg_31_1.actors_["10066ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos10066ui_story = var_34_3.localPosition
			end

			local var_34_4 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				var_34_3.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_31_1.time_ - 0) / var_34_4)
				var_34_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_3.position).x, (manager.ui.mainCamera.transform.position - var_34_3.position).y, (manager.ui.mainCamera.transform.position - var_34_3.position).z)
				var_34_3.localEulerAngles.z = 0
				var_34_3.localEulerAngles.x = 0
				var_34_3.localEulerAngles = var_34_3.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				var_34_3.localPosition = Vector3.New(0, -0.99, -5.83)
				var_34_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_3.position).x, (manager.ui.mainCamera.transform.position - var_34_3.position).y, (manager.ui.mainCamera.transform.position - var_34_3.position).z)
				var_34_3.localEulerAngles.z = 0
				var_34_3.localEulerAngles.x = 0
				var_34_3.localEulerAngles = var_34_3.localEulerAngles
			end

			local var_34_5 = arg_31_1.actors_["10066ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect10066ui_story == nil then
				arg_31_1.var_.characterEffect10066ui_story = var_34_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_6 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_6 and not isNil(var_34_5) then
				if arg_31_1.var_.characterEffect10066ui_story and not isNil(var_34_5) then
					arg_31_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_6 and arg_31_1.time_ < 0 + var_34_6 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect10066ui_story then
				arg_31_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_34_8 = 0
			local var_34_9 = 0.35

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_10 = arg_31_1:GetWordFromCfg(318281007)
				local var_34_11 = arg_31_1:FormatText(var_34_10.content)

				arg_31_1.text_.text = var_34_11

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_13 = 14 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 14)

				if (14 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 14)) > 0 and var_34_9 < var_34_13 then
					arg_31_1.talkMaxDuration = var_34_13

					if var_34_13 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_13 + var_34_8
					end
				end

				arg_31_1.text_.text = var_34_11
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281007", "story_v_out_318281.awb") ~= 0 then
					local var_34_14 = manager.audio:GetVoiceLength("story_v_out_318281", "318281007", "story_v_out_318281.awb") / 1000

					if var_34_14 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_14 + var_34_8
					end

					if var_34_10.prefab_name ~= "" and arg_31_1.actors_[var_34_10.prefab_name] ~= nil then
						local var_34_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_10.prefab_name].transform, "story_v_out_318281", "318281007", "story_v_out_318281.awb")

						arg_31_1:RecordAudio("318281007", var_34_15)
						arg_31_1:RecordAudio("318281007", var_34_15)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_318281", "318281007", "story_v_out_318281.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_318281", "318281007", "story_v_out_318281.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_16 = math.max(var_34_9, arg_31_1.talkMaxDuration)

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_16 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_8) / var_34_16

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_8 + var_34_16 and arg_31_1.time_ < var_34_8 + var_34_16 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play318281008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 318281008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play318281009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10066ui_story = arg_35_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10066ui_story"].transform.position).z)
				arg_35_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["10066ui_story"].transform.localEulerAngles = arg_35_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["10066ui_story"].transform.position).z)
				arg_35_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["10066ui_story"].transform.localEulerAngles = arg_35_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["10066ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect10066ui_story == nil then
				arg_35_1.var_.characterEffect10066ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect10066ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_35_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_2)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect10066ui_story then
				arg_35_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_35_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_38_3 = 0
			local var_38_4 = 0.55

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_3 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_5 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(318281008).content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 22 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 22)

				if (22 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 22)) > 0 and var_38_4 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_3 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_3
					end
				end

				arg_35_1.text_.text = var_38_5
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_8 = math.max(var_38_4, arg_35_1.talkMaxDuration)

			if var_38_3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_3 + var_38_8 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_3) / var_38_8

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_3 + var_38_8 and arg_35_1.time_ < var_38_3 + var_38_8 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play318281009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 318281009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play318281010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.7

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(318281009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 28 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 28)

				if (28 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 28)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play318281010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 318281010
		arg_43_1.duration_ = 8

		local var_43_0 = {
			zh = 5.633,
			ja = 8
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
				arg_43_0:Play318281011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_46_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_43_1.stage_.transform)

				var_46_0.name = "1015ui_story"
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["1015ui_story"] = var_46_0

				local var_46_1 = var_46_0:GetComponentInChildren(typeof(CharacterEffect))

				var_46_1.enabled = true

				local var_46_2 = GameObjectTools.GetOrAddComponent(var_46_0, typeof(DynamicBoneHelper))

				if var_46_2 then
					var_46_2:EnableDynamicBone(false)
				end

				arg_43_1:ShowWeapon(var_46_1.transform, false)

				arg_43_1.var_["1015ui_story" .. "Animator"] = var_46_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_43_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_43_1.var_["1015ui_story" .. "LipSync"] = var_46_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_46_3 = arg_43_1.actors_["1015ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1015ui_story = var_46_3.localPosition
			end

			local var_46_4 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				var_46_3.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_43_1.time_ - 0) / var_46_4)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				var_46_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles
			end

			local var_46_5 = arg_43_1.actors_["1015ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.characterEffect1015ui_story == nil then
				arg_43_1.var_.characterEffect1015ui_story = var_46_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_6 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_6 and not isNil(var_46_5) then
				if arg_43_1.var_.characterEffect1015ui_story and not isNil(var_46_5) then
					arg_43_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_6 and arg_43_1.time_ < 0 + var_46_6 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.characterEffect1015ui_story then
				arg_43_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_8 = 0
			local var_46_9 = 0.625

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_10 = arg_43_1:GetWordFromCfg(318281010)
				local var_46_11 = arg_43_1:FormatText(var_46_10.content)

				arg_43_1.text_.text = var_46_11

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_13 = 25 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 25)

				if (25 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 25)) > 0 and var_46_9 < var_46_13 then
					arg_43_1.talkMaxDuration = var_46_13

					if var_46_13 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_13 + var_46_8
					end
				end

				arg_43_1.text_.text = var_46_11
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281010", "story_v_out_318281.awb") ~= 0 then
					local var_46_14 = manager.audio:GetVoiceLength("story_v_out_318281", "318281010", "story_v_out_318281.awb") / 1000

					if var_46_14 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_14 + var_46_8
					end

					if var_46_10.prefab_name ~= "" and arg_43_1.actors_[var_46_10.prefab_name] ~= nil then
						local var_46_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_10.prefab_name].transform, "story_v_out_318281", "318281010", "story_v_out_318281.awb")

						arg_43_1:RecordAudio("318281010", var_46_15)
						arg_43_1:RecordAudio("318281010", var_46_15)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_318281", "318281010", "story_v_out_318281.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_318281", "318281010", "story_v_out_318281.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_16 = math.max(var_46_9, arg_43_1.talkMaxDuration)

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_16 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_8) / var_46_16

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_8 + var_46_16 and arg_43_1.time_ < var_46_8 + var_46_16 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play318281011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 318281011
		arg_47_1.duration_ = 4.4

		local var_47_0 = {
			zh = 3.033,
			ja = 4.4
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
				arg_47_0:Play318281012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10066ui_story = arg_47_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10066ui_story"].transform.position).z)
				arg_47_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10066ui_story"].transform.localEulerAngles = arg_47_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_47_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10066ui_story"].transform.position).z)
				arg_47_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10066ui_story"].transform.localEulerAngles = arg_47_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["10066ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10066ui_story == nil then
				arg_47_1.var_.characterEffect10066ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect10066ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10066ui_story then
				arg_47_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_2")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_50_4 = arg_47_1.actors_["1015ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1015ui_story = var_50_4.localPosition
			end

			local var_50_5 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 then
				var_50_4.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_5)
				var_50_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_4.position).x, (manager.ui.mainCamera.transform.position - var_50_4.position).y, (manager.ui.mainCamera.transform.position - var_50_4.position).z)
				var_50_4.localEulerAngles.z = 0
				var_50_4.localEulerAngles.x = 0
				var_50_4.localEulerAngles = var_50_4.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 then
				var_50_4.localPosition = Vector3.New(0, 100, 0)
				var_50_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_4.position).x, (manager.ui.mainCamera.transform.position - var_50_4.position).y, (manager.ui.mainCamera.transform.position - var_50_4.position).z)
				var_50_4.localEulerAngles.z = 0
				var_50_4.localEulerAngles.x = 0
				var_50_4.localEulerAngles = var_50_4.localEulerAngles
			end

			local var_50_6 = arg_47_1.actors_["1015ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect1015ui_story == nil then
				arg_47_1.var_.characterEffect1015ui_story = var_50_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_7 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 and not isNil(var_50_6) then
				if arg_47_1.var_.characterEffect1015ui_story and not isNil(var_50_6) then
					arg_47_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_7)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 and not isNil(var_50_6) and arg_47_1.var_.characterEffect1015ui_story then
				arg_47_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_50_8 = 0
			local var_50_9 = 0.3

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:GetWordFromCfg(318281011)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 12 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 12)

				if (12 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 12)) > 0 and var_50_9 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281011", "story_v_out_318281.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_out_318281", "318281011", "story_v_out_318281.awb") / 1000

					if var_50_14 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_8
					end

					if var_50_10.prefab_name ~= "" and arg_47_1.actors_[var_50_10.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_10.prefab_name].transform, "story_v_out_318281", "318281011", "story_v_out_318281.awb")

						arg_47_1:RecordAudio("318281011", var_50_15)
						arg_47_1:RecordAudio("318281011", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_318281", "318281011", "story_v_out_318281.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_318281", "318281011", "story_v_out_318281.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_16 and arg_47_1.time_ < var_50_8 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_47_1:InitPlayNodeList()
	end,
	Play318281012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 318281012
		arg_51_1.duration_ = 6.77

		local var_51_0 = {
			zh = 4.066,
			ja = 6.766
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play318281013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1015ui_story"]) and arg_51_1.var_.characterEffect1015ui_story == nil then
				arg_51_1.var_.characterEffect1015ui_story = arg_51_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1015ui_story"]) then
				if arg_51_1.var_.characterEffect1015ui_story and not isNil(arg_51_1.actors_["1015ui_story"]) then
					arg_51_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1015ui_story"]) and arg_51_1.var_.characterEffect1015ui_story then
				arg_51_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_54_2 = arg_51_1.actors_["10066ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10066ui_story = var_54_2.localPosition
			end

			local var_54_3 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 then
				var_54_2.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_3)
				var_54_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_2.position).x, (manager.ui.mainCamera.transform.position - var_54_2.position).y, (manager.ui.mainCamera.transform.position - var_54_2.position).z)
				var_54_2.localEulerAngles.z = 0
				var_54_2.localEulerAngles.x = 0
				var_54_2.localEulerAngles = var_54_2.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 then
				var_54_2.localPosition = Vector3.New(0, 100, 0)
				var_54_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_2.position).x, (manager.ui.mainCamera.transform.position - var_54_2.position).y, (manager.ui.mainCamera.transform.position - var_54_2.position).z)
				var_54_2.localEulerAngles.z = 0
				var_54_2.localEulerAngles.x = 0
				var_54_2.localEulerAngles = var_54_2.localEulerAngles
			end

			local var_54_4 = arg_51_1.actors_["10066ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.characterEffect10066ui_story == nil then
				arg_51_1.var_.characterEffect10066ui_story = var_54_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_5 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_5 and not isNil(var_54_4) then
				if arg_51_1.var_.characterEffect10066ui_story and not isNil(var_54_4) then
					arg_51_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_51_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_5)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_5 and arg_51_1.time_ < 0 + var_54_5 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.characterEffect10066ui_story then
				arg_51_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_51_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_54_6 = arg_51_1.actors_["1015ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1015ui_story = var_54_6.localPosition
			end

			local var_54_7 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				var_54_6.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_51_1.time_ - 0) / var_54_7)
				var_54_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_6.position).x, (manager.ui.mainCamera.transform.position - var_54_6.position).y, (manager.ui.mainCamera.transform.position - var_54_6.position).z)
				var_54_6.localEulerAngles.z = 0
				var_54_6.localEulerAngles.x = 0
				var_54_6.localEulerAngles = var_54_6.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				var_54_6.localPosition = Vector3.New(0, -1.15, -6.2)
				var_54_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_6.position).x, (manager.ui.mainCamera.transform.position - var_54_6.position).y, (manager.ui.mainCamera.transform.position - var_54_6.position).z)
				var_54_6.localEulerAngles.z = 0
				var_54_6.localEulerAngles.x = 0
				var_54_6.localEulerAngles = var_54_6.localEulerAngles
			end

			local var_54_8 = 0
			local var_54_9 = 0.4

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_10 = arg_51_1:GetWordFromCfg(318281012)
				local var_54_11 = arg_51_1:FormatText(var_54_10.content)

				arg_51_1.text_.text = var_54_11

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_13 = 16 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 16)

				if (16 <= 0 and var_54_9 or var_54_9 * (utf8.len(var_54_11) / 16)) > 0 and var_54_9 < var_54_13 then
					arg_51_1.talkMaxDuration = var_54_13

					if var_54_13 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_13 + var_54_8
					end
				end

				arg_51_1.text_.text = var_54_11
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281012", "story_v_out_318281.awb") ~= 0 then
					local var_54_14 = manager.audio:GetVoiceLength("story_v_out_318281", "318281012", "story_v_out_318281.awb") / 1000

					if var_54_14 + var_54_8 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_14 + var_54_8
					end

					if var_54_10.prefab_name ~= "" and arg_51_1.actors_[var_54_10.prefab_name] ~= nil then
						local var_54_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_10.prefab_name].transform, "story_v_out_318281", "318281012", "story_v_out_318281.awb")

						arg_51_1:RecordAudio("318281012", var_54_15)
						arg_51_1:RecordAudio("318281012", var_54_15)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_318281", "318281012", "story_v_out_318281.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_318281", "318281012", "story_v_out_318281.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_16 = math.max(var_54_9, arg_51_1.talkMaxDuration)

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_16 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_8) / var_54_16

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_8 + var_54_16 and arg_51_1.time_ < var_54_8 + var_54_16 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_51_1:InitPlayNodeList()
	end,
	Play318281013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 318281013
		arg_55_1.duration_ = 5.47

		local var_55_0 = {
			zh = 4.1,
			ja = 5.466
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
				arg_55_0:Play318281014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_0 = 0
			local var_58_1 = 0.6

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_2 = arg_55_1:GetWordFromCfg(318281013)
				local var_58_3 = arg_55_1:FormatText(var_58_2.content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 24 <= 0 and var_58_1 or var_58_1 * (utf8.len(var_58_3) / 24)

				if (24 <= 0 and var_58_1 or var_58_1 * (utf8.len(var_58_3) / 24)) > 0 and var_58_1 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281013", "story_v_out_318281.awb") ~= 0 then
					local var_58_6 = manager.audio:GetVoiceLength("story_v_out_318281", "318281013", "story_v_out_318281.awb") / 1000

					if var_58_6 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_0
					end

					if var_58_2.prefab_name ~= "" and arg_55_1.actors_[var_58_2.prefab_name] ~= nil then
						local var_58_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_2.prefab_name].transform, "story_v_out_318281", "318281013", "story_v_out_318281.awb")

						arg_55_1:RecordAudio("318281013", var_58_7)
						arg_55_1:RecordAudio("318281013", var_58_7)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_318281", "318281013", "story_v_out_318281.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_318281", "318281013", "story_v_out_318281.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_8 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_8 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_8

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_8 and arg_55_1.time_ < var_58_0 + var_58_8 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play318281014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 318281014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play318281015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1015ui_story"]) and arg_59_1.var_.characterEffect1015ui_story == nil then
				arg_59_1.var_.characterEffect1015ui_story = arg_59_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1015ui_story"]) then
				if arg_59_1.var_.characterEffect1015ui_story and not isNil(arg_59_1.actors_["1015ui_story"]) then
					arg_59_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1015ui_story"]) and arg_59_1.var_.characterEffect1015ui_story then
				arg_59_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_62_1 = 0
			local var_62_2 = 0.325

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(318281014).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 13 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 13)

				if (13 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 13)) > 0 and var_62_2 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_6 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_6 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_6

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_6 and arg_59_1.time_ < var_62_1 + var_62_6 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play318281015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 318281015
		arg_63_1.duration_ = 3.3

		local var_63_0 = {
			zh = 3.3,
			ja = 3.166
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
				arg_63_0:Play318281016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1015ui_story"]) and arg_63_1.var_.characterEffect1015ui_story == nil then
				arg_63_1.var_.characterEffect1015ui_story = arg_63_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1015ui_story"]) then
				if arg_63_1.var_.characterEffect1015ui_story and not isNil(arg_63_1.actors_["1015ui_story"]) then
					arg_63_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1015ui_story"]) and arg_63_1.var_.characterEffect1015ui_story then
				arg_63_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_66_2 = 0
			local var_66_3 = 0.35

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_4 = arg_63_1:GetWordFromCfg(318281015)
				local var_66_5 = arg_63_1:FormatText(var_66_4.content)

				arg_63_1.text_.text = var_66_5

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_7 = 14 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_5) / 14)

				if (14 <= 0 and var_66_3 or var_66_3 * (utf8.len(var_66_5) / 14)) > 0 and var_66_3 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_2
					end
				end

				arg_63_1.text_.text = var_66_5
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281015", "story_v_out_318281.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_318281", "318281015", "story_v_out_318281.awb") / 1000

					if var_66_8 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_2
					end

					if var_66_4.prefab_name ~= "" and arg_63_1.actors_[var_66_4.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_4.prefab_name].transform, "story_v_out_318281", "318281015", "story_v_out_318281.awb")

						arg_63_1:RecordAudio("318281015", var_66_9)
						arg_63_1:RecordAudio("318281015", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_318281", "318281015", "story_v_out_318281.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_318281", "318281015", "story_v_out_318281.awb")
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
	Play318281016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 318281016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play318281017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1015ui_story = arg_67_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1015ui_story"].transform.position).z)
				arg_67_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1015ui_story"].transform.localEulerAngles = arg_67_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1015ui_story"].transform.position).z)
				arg_67_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1015ui_story"].transform.localEulerAngles = arg_67_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1015ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1015ui_story == nil then
				arg_67_1.var_.characterEffect1015ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1015ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_2)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1015ui_story then
				arg_67_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_70_3 = 0
			local var_70_4 = 1.3

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_3 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_5 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(318281016).content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 52 <= 0 and var_70_4 or var_70_4 * (utf8.len(var_70_5) / 52)

				if (52 <= 0 and var_70_4 or var_70_4 * (utf8.len(var_70_5) / 52)) > 0 and var_70_4 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_3 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_3
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_8 = math.max(var_70_4, arg_67_1.talkMaxDuration)

			if var_70_3 <= arg_67_1.time_ and arg_67_1.time_ < var_70_3 + var_70_8 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_3) / var_70_8

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_3 + var_70_8 and arg_67_1.time_ < var_70_3 + var_70_8 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play318281017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 318281017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play318281018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.725

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(318281017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 29 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 29)

				if (29 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 29)) > 0 and var_74_0 < var_74_3 then
					arg_71_1.talkMaxDuration = var_74_3

					if var_74_3 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_3 + 0
					end
				end

				arg_71_1.text_.text = var_74_1
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_4 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_4

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play318281018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 318281018
		arg_75_1.duration_ = 11.27

		local var_75_0 = {
			zh = 7,
			ja = 11.266
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
				arg_75_0:Play318281019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if arg_75_1.actors_["10065ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10065ui_story"))) then
				local var_78_0 = Object.Instantiate(Asset.Load("Char/" .. "10065ui_story"), arg_75_1.stage_.transform)

				var_78_0.name = "10065ui_story"
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["10065ui_story"] = var_78_0

				local var_78_1 = var_78_0:GetComponentInChildren(typeof(CharacterEffect))

				var_78_1.enabled = true

				local var_78_2 = GameObjectTools.GetOrAddComponent(var_78_0, typeof(DynamicBoneHelper))

				if var_78_2 then
					var_78_2:EnableDynamicBone(false)
				end

				arg_75_1:ShowWeapon(var_78_1.transform, false)

				arg_75_1.var_["10065ui_story" .. "Animator"] = var_78_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_75_1.var_["10065ui_story" .. "Animator"].applyRootMotion = true
				arg_75_1.var_["10065ui_story" .. "LipSync"] = var_78_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_78_3 = arg_75_1.actors_["10065ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10065ui_story = var_78_3.localPosition
			end

			local var_78_4 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				var_78_3.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_75_1.time_ - 0) / var_78_4)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				var_78_3.localPosition = Vector3.New(0, -0.81, -6.19)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			local var_78_5 = arg_75_1.actors_["10065ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect10065ui_story == nil then
				arg_75_1.var_.characterEffect10065ui_story = var_78_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_6 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_6 and not isNil(var_78_5) then
				if arg_75_1.var_.characterEffect10065ui_story and not isNil(var_78_5) then
					arg_75_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_6 and arg_75_1.time_ < 0 + var_78_6 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect10065ui_story then
				arg_75_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story4016/story4016action/4016action1_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action1_1")
			end

			local var_78_8 = 0
			local var_78_9 = 0.475

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_10 = arg_75_1:GetWordFromCfg(318281018)
				local var_78_11 = arg_75_1:FormatText(var_78_10.content)

				arg_75_1.text_.text = var_78_11

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_13 = 19 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 19)

				if (19 <= 0 and var_78_9 or var_78_9 * (utf8.len(var_78_11) / 19)) > 0 and var_78_9 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_8
					end
				end

				arg_75_1.text_.text = var_78_11
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281018", "story_v_out_318281.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_out_318281", "318281018", "story_v_out_318281.awb") / 1000

					if var_78_14 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_8
					end

					if var_78_10.prefab_name ~= "" and arg_75_1.actors_[var_78_10.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_10.prefab_name].transform, "story_v_out_318281", "318281018", "story_v_out_318281.awb")

						arg_75_1:RecordAudio("318281018", var_78_15)
						arg_75_1:RecordAudio("318281018", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_318281", "318281018", "story_v_out_318281.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_318281", "318281018", "story_v_out_318281.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_9, arg_75_1.talkMaxDuration)

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_8) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_8 + var_78_16 and arg_75_1.time_ < var_78_8 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
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
	Play318281019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 318281019
		arg_79_1.duration_ = 5.8

		local var_79_0 = {
			zh = 5.8,
			ja = 3.633
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
				arg_79_0:Play318281020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if arg_79_1.actors_["10053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10053ui_story"))) then
				local var_82_0 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_79_1.stage_.transform)

				var_82_0.name = "10053ui_story"
				var_82_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.actors_["10053ui_story"] = var_82_0

				local var_82_1 = var_82_0:GetComponentInChildren(typeof(CharacterEffect))

				var_82_1.enabled = true

				local var_82_2 = GameObjectTools.GetOrAddComponent(var_82_0, typeof(DynamicBoneHelper))

				if var_82_2 then
					var_82_2:EnableDynamicBone(false)
				end

				arg_79_1:ShowWeapon(var_82_1.transform, false)

				arg_79_1.var_["10053ui_story" .. "Animator"] = var_82_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_79_1.var_["10053ui_story" .. "Animator"].applyRootMotion = true
				arg_79_1.var_["10053ui_story" .. "LipSync"] = var_82_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_82_3 = arg_79_1.actors_["10053ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10053ui_story = var_82_3.localPosition
			end

			local var_82_4 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				var_82_3.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_79_1.time_ - 0) / var_82_4)
				var_82_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_3.position).x, (manager.ui.mainCamera.transform.position - var_82_3.position).y, (manager.ui.mainCamera.transform.position - var_82_3.position).z)
				var_82_3.localEulerAngles.z = 0
				var_82_3.localEulerAngles.x = 0
				var_82_3.localEulerAngles = var_82_3.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				var_82_3.localPosition = Vector3.New(0, -1.12, -5.99)
				var_82_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_3.position).x, (manager.ui.mainCamera.transform.position - var_82_3.position).y, (manager.ui.mainCamera.transform.position - var_82_3.position).z)
				var_82_3.localEulerAngles.z = 0
				var_82_3.localEulerAngles.x = 0
				var_82_3.localEulerAngles = var_82_3.localEulerAngles
			end

			local var_82_5 = arg_79_1.actors_["10053ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_5) and arg_79_1.var_.characterEffect10053ui_story == nil then
				arg_79_1.var_.characterEffect10053ui_story = var_82_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_6 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_6 and not isNil(var_82_5) then
				if arg_79_1.var_.characterEffect10053ui_story and not isNil(var_82_5) then
					arg_79_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_6 and arg_79_1.time_ < 0 + var_82_6 + arg_82_0 and not isNil(var_82_5) and arg_79_1.var_.characterEffect10053ui_story then
				arg_79_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_8 = arg_79_1.actors_["10065ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10065ui_story = var_82_8.localPosition
			end

			local var_82_9 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_9 then
				var_82_8.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_9)
				var_82_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_8.position).x, (manager.ui.mainCamera.transform.position - var_82_8.position).y, (manager.ui.mainCamera.transform.position - var_82_8.position).z)
				var_82_8.localEulerAngles.z = 0
				var_82_8.localEulerAngles.x = 0
				var_82_8.localEulerAngles = var_82_8.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_9 and arg_79_1.time_ < 0 + var_82_9 + arg_82_0 then
				var_82_8.localPosition = Vector3.New(0, 100, 0)
				var_82_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_8.position).x, (manager.ui.mainCamera.transform.position - var_82_8.position).y, (manager.ui.mainCamera.transform.position - var_82_8.position).z)
				var_82_8.localEulerAngles.z = 0
				var_82_8.localEulerAngles.x = 0
				var_82_8.localEulerAngles = var_82_8.localEulerAngles
			end

			local var_82_10 = 0
			local var_82_11 = 0.575

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_12 = arg_79_1:GetWordFromCfg(318281019)
				local var_82_13 = arg_79_1:FormatText(var_82_12.content)

				arg_79_1.text_.text = var_82_13

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_15 = 23 <= 0 and var_82_11 or var_82_11 * (utf8.len(var_82_13) / 23)

				if (23 <= 0 and var_82_11 or var_82_11 * (utf8.len(var_82_13) / 23)) > 0 and var_82_11 < var_82_15 then
					arg_79_1.talkMaxDuration = var_82_15

					if var_82_15 + var_82_10 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_15 + var_82_10
					end
				end

				arg_79_1.text_.text = var_82_13
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281019", "story_v_out_318281.awb") ~= 0 then
					local var_82_16 = manager.audio:GetVoiceLength("story_v_out_318281", "318281019", "story_v_out_318281.awb") / 1000

					if var_82_16 + var_82_10 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_16 + var_82_10
					end

					if var_82_12.prefab_name ~= "" and arg_79_1.actors_[var_82_12.prefab_name] ~= nil then
						local var_82_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_12.prefab_name].transform, "story_v_out_318281", "318281019", "story_v_out_318281.awb")

						arg_79_1:RecordAudio("318281019", var_82_17)
						arg_79_1:RecordAudio("318281019", var_82_17)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_318281", "318281019", "story_v_out_318281.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_318281", "318281019", "story_v_out_318281.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_18 = math.max(var_82_11, arg_79_1.talkMaxDuration)

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_18 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_10) / var_82_18

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_10 + var_82_18 and arg_79_1.time_ < var_82_10 + var_82_18 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play318281020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 318281020
		arg_83_1.duration_ = 8.3

		local var_83_0 = {
			zh = 8.3,
			ja = 6.633
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
				arg_83_0:Play318281021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_86_0 = 0
			local var_86_1 = 0.875

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:GetWordFromCfg(318281020)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 35 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_3) / 35)

				if (35 <= 0 and var_86_1 or var_86_1 * (utf8.len(var_86_3) / 35)) > 0 and var_86_1 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281020", "story_v_out_318281.awb") ~= 0 then
					local var_86_6 = manager.audio:GetVoiceLength("story_v_out_318281", "318281020", "story_v_out_318281.awb") / 1000

					if var_86_6 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_0
					end

					if var_86_2.prefab_name ~= "" and arg_83_1.actors_[var_86_2.prefab_name] ~= nil then
						local var_86_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_2.prefab_name].transform, "story_v_out_318281", "318281020", "story_v_out_318281.awb")

						arg_83_1:RecordAudio("318281020", var_86_7)
						arg_83_1:RecordAudio("318281020", var_86_7)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_318281", "318281020", "story_v_out_318281.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_318281", "318281020", "story_v_out_318281.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_8 and arg_83_1.time_ < var_86_0 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play318281021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 318281021
		arg_87_1.duration_ = 20

		local var_87_0 = {
			zh = 5.466,
			ja = 20
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
				arg_87_0:Play318281022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["10065ui_story"]) and arg_87_1.var_.characterEffect10065ui_story == nil then
				arg_87_1.var_.characterEffect10065ui_story = arg_87_1.actors_["10065ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["10065ui_story"]) then
				if arg_87_1.var_.characterEffect10065ui_story and not isNil(arg_87_1.actors_["10065ui_story"]) then
					arg_87_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["10065ui_story"]) and arg_87_1.var_.characterEffect10065ui_story then
				arg_87_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action5_1")
			end

			local var_90_2 = arg_87_1.actors_["10053ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10053ui_story = var_90_2.localPosition
			end

			local var_90_3 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 then
				var_90_2.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_3)
				var_90_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_2.position).x, (manager.ui.mainCamera.transform.position - var_90_2.position).y, (manager.ui.mainCamera.transform.position - var_90_2.position).z)
				var_90_2.localEulerAngles.z = 0
				var_90_2.localEulerAngles.x = 0
				var_90_2.localEulerAngles = var_90_2.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 then
				var_90_2.localPosition = Vector3.New(0, 100, 0)
				var_90_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_2.position).x, (manager.ui.mainCamera.transform.position - var_90_2.position).y, (manager.ui.mainCamera.transform.position - var_90_2.position).z)
				var_90_2.localEulerAngles.z = 0
				var_90_2.localEulerAngles.x = 0
				var_90_2.localEulerAngles = var_90_2.localEulerAngles
			end

			local var_90_4 = arg_87_1.actors_["10053ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.characterEffect10053ui_story == nil then
				arg_87_1.var_.characterEffect10053ui_story = var_90_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_5 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_5 and not isNil(var_90_4) then
				if arg_87_1.var_.characterEffect10053ui_story and not isNil(var_90_4) then
					arg_87_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_5)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_5 and arg_87_1.time_ < 0 + var_90_5 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.characterEffect10053ui_story then
				arg_87_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_90_6 = arg_87_1.actors_["10065ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10065ui_story = var_90_6.localPosition
			end

			local var_90_7 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				var_90_6.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_87_1.time_ - 0) / var_90_7)
				var_90_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_6.position).x, (manager.ui.mainCamera.transform.position - var_90_6.position).y, (manager.ui.mainCamera.transform.position - var_90_6.position).z)
				var_90_6.localEulerAngles.z = 0
				var_90_6.localEulerAngles.x = 0
				var_90_6.localEulerAngles = var_90_6.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				var_90_6.localPosition = Vector3.New(0, -0.81, -6.19)
				var_90_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_6.position).x, (manager.ui.mainCamera.transform.position - var_90_6.position).y, (manager.ui.mainCamera.transform.position - var_90_6.position).z)
				var_90_6.localEulerAngles.z = 0
				var_90_6.localEulerAngles.x = 0
				var_90_6.localEulerAngles = var_90_6.localEulerAngles
			end

			local var_90_8 = 0
			local var_90_9 = 0.45

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_10 = arg_87_1:GetWordFromCfg(318281021)
				local var_90_11 = arg_87_1:FormatText(var_90_10.content)

				arg_87_1.text_.text = var_90_11

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 18 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 18)

				if (18 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 18)) > 0 and var_90_9 < var_90_13 then
					arg_87_1.talkMaxDuration = var_90_13

					if var_90_13 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_8
					end
				end

				arg_87_1.text_.text = var_90_11
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281021", "story_v_out_318281.awb") ~= 0 then
					local var_90_14 = manager.audio:GetVoiceLength("story_v_out_318281", "318281021", "story_v_out_318281.awb") / 1000

					if var_90_14 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_14 + var_90_8
					end

					if var_90_10.prefab_name ~= "" and arg_87_1.actors_[var_90_10.prefab_name] ~= nil then
						local var_90_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_10.prefab_name].transform, "story_v_out_318281", "318281021", "story_v_out_318281.awb")

						arg_87_1:RecordAudio("318281021", var_90_15)
						arg_87_1:RecordAudio("318281021", var_90_15)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_318281", "318281021", "story_v_out_318281.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_318281", "318281021", "story_v_out_318281.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_16 = math.max(var_90_9, arg_87_1.talkMaxDuration)

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_16 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_8) / var_90_16

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_8 + var_90_16 and arg_87_1.time_ < var_90_8 + var_90_16 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play318281022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 318281022
		arg_91_1.duration_ = 7.7

		local var_91_0 = {
			zh = 7.7,
			ja = 7.666
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
				arg_91_0:Play318281023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10053ui_story = arg_91_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10053ui_story"].transform.position).z)
				arg_91_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10053ui_story"].transform.localEulerAngles = arg_91_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, -1.12, -5.99)
				arg_91_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10053ui_story"].transform.position).z)
				arg_91_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10053ui_story"].transform.localEulerAngles = arg_91_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["10053ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10053ui_story == nil then
				arg_91_1.var_.characterEffect10053ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect10053ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10053ui_story then
				arg_91_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_94_4 = arg_91_1.actors_["10065ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10065ui_story = var_94_4.localPosition
			end

			local var_94_5 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_5 then
				var_94_4.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_5)
				var_94_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_4.position).x, (manager.ui.mainCamera.transform.position - var_94_4.position).y, (manager.ui.mainCamera.transform.position - var_94_4.position).z)
				var_94_4.localEulerAngles.z = 0
				var_94_4.localEulerAngles.x = 0
				var_94_4.localEulerAngles = var_94_4.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_5 and arg_91_1.time_ < 0 + var_94_5 + arg_94_0 then
				var_94_4.localPosition = Vector3.New(0, 100, 0)
				var_94_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_4.position).x, (manager.ui.mainCamera.transform.position - var_94_4.position).y, (manager.ui.mainCamera.transform.position - var_94_4.position).z)
				var_94_4.localEulerAngles.z = 0
				var_94_4.localEulerAngles.x = 0
				var_94_4.localEulerAngles = var_94_4.localEulerAngles
			end

			local var_94_6 = arg_91_1.actors_["10065ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_6) and arg_91_1.var_.characterEffect10065ui_story == nil then
				arg_91_1.var_.characterEffect10065ui_story = var_94_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_7 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 and not isNil(var_94_6) then
				if arg_91_1.var_.characterEffect10065ui_story and not isNil(var_94_6) then
					arg_91_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_91_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_7)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 and not isNil(var_94_6) and arg_91_1.var_.characterEffect10065ui_story then
				arg_91_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_91_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_94_8 = 0
			local var_94_9 = 0.75

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_10 = arg_91_1:GetWordFromCfg(318281022)
				local var_94_11 = arg_91_1:FormatText(var_94_10.content)

				arg_91_1.text_.text = var_94_11

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_13 = 30 <= 0 and var_94_9 or var_94_9 * (utf8.len(var_94_11) / 30)

				if (30 <= 0 and var_94_9 or var_94_9 * (utf8.len(var_94_11) / 30)) > 0 and var_94_9 < var_94_13 then
					arg_91_1.talkMaxDuration = var_94_13

					if var_94_13 + var_94_8 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_8
					end
				end

				arg_91_1.text_.text = var_94_11
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281022", "story_v_out_318281.awb") ~= 0 then
					local var_94_14 = manager.audio:GetVoiceLength("story_v_out_318281", "318281022", "story_v_out_318281.awb") / 1000

					if var_94_14 + var_94_8 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_14 + var_94_8
					end

					if var_94_10.prefab_name ~= "" and arg_91_1.actors_[var_94_10.prefab_name] ~= nil then
						local var_94_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_10.prefab_name].transform, "story_v_out_318281", "318281022", "story_v_out_318281.awb")

						arg_91_1:RecordAudio("318281022", var_94_15)
						arg_91_1:RecordAudio("318281022", var_94_15)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_318281", "318281022", "story_v_out_318281.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_318281", "318281022", "story_v_out_318281.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_16 = math.max(var_94_9, arg_91_1.talkMaxDuration)

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_16 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_8) / var_94_16

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_8 + var_94_16 and arg_91_1.time_ < var_94_8 + var_94_16 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10065ui_story",
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
	Play318281023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 318281023
		arg_95_1.duration_ = 6.93

		local var_95_0 = {
			zh = 4.633,
			ja = 6.933
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
				arg_95_0:Play318281024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10065ui_story = arg_95_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10065ui_story"].transform.position).z)
				arg_95_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10065ui_story"].transform.localEulerAngles = arg_95_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, -0.81, -6.19)
				arg_95_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10065ui_story"].transform.position).z)
				arg_95_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10065ui_story"].transform.localEulerAngles = arg_95_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["10065ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect10065ui_story == nil then
				arg_95_1.var_.characterEffect10065ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect10065ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect10065ui_story then
				arg_95_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action6_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_98_4 = arg_95_1.actors_["10053ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10053ui_story = var_98_4.localPosition
			end

			local var_98_5 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_5 then
				var_98_4.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_5)
				var_98_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_4.position).x, (manager.ui.mainCamera.transform.position - var_98_4.position).y, (manager.ui.mainCamera.transform.position - var_98_4.position).z)
				var_98_4.localEulerAngles.z = 0
				var_98_4.localEulerAngles.x = 0
				var_98_4.localEulerAngles = var_98_4.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_5 and arg_95_1.time_ < 0 + var_98_5 + arg_98_0 then
				var_98_4.localPosition = Vector3.New(0, 100, 0)
				var_98_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_4.position).x, (manager.ui.mainCamera.transform.position - var_98_4.position).y, (manager.ui.mainCamera.transform.position - var_98_4.position).z)
				var_98_4.localEulerAngles.z = 0
				var_98_4.localEulerAngles.x = 0
				var_98_4.localEulerAngles = var_98_4.localEulerAngles
			end

			local var_98_6 = arg_95_1.actors_["10053ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_6) and arg_95_1.var_.characterEffect10053ui_story == nil then
				arg_95_1.var_.characterEffect10053ui_story = var_98_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_7 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 and not isNil(var_98_6) then
				if arg_95_1.var_.characterEffect10053ui_story and not isNil(var_98_6) then
					arg_95_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_95_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_7)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 and not isNil(var_98_6) and arg_95_1.var_.characterEffect10053ui_story then
				arg_95_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_95_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_98_8 = 0
			local var_98_9 = 0.3

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_8 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_10 = arg_95_1:GetWordFromCfg(318281023)
				local var_98_11 = arg_95_1:FormatText(var_98_10.content)

				arg_95_1.text_.text = var_98_11

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_13 = 12 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_11) / 12)

				if (12 <= 0 and var_98_9 or var_98_9 * (utf8.len(var_98_11) / 12)) > 0 and var_98_9 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_8
					end
				end

				arg_95_1.text_.text = var_98_11
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281023", "story_v_out_318281.awb") ~= 0 then
					local var_98_14 = manager.audio:GetVoiceLength("story_v_out_318281", "318281023", "story_v_out_318281.awb") / 1000

					if var_98_14 + var_98_8 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_8
					end

					if var_98_10.prefab_name ~= "" and arg_95_1.actors_[var_98_10.prefab_name] ~= nil then
						local var_98_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_10.prefab_name].transform, "story_v_out_318281", "318281023", "story_v_out_318281.awb")

						arg_95_1:RecordAudio("318281023", var_98_15)
						arg_95_1:RecordAudio("318281023", var_98_15)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_318281", "318281023", "story_v_out_318281.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_318281", "318281023", "story_v_out_318281.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_9, arg_95_1.talkMaxDuration)

			if var_98_8 <= arg_95_1.time_ and arg_95_1.time_ < var_98_8 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_8) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_8 + var_98_16 and arg_95_1.time_ < var_98_8 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play318281024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 318281024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play318281025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10065ui_story = arg_99_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10065ui_story"].transform.position).z)
				arg_99_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10065ui_story"].transform.localEulerAngles = arg_99_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10065ui_story"].transform.position).z)
				arg_99_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10065ui_story"].transform.localEulerAngles = arg_99_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["10065ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10065ui_story == nil then
				arg_99_1.var_.characterEffect10065ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect10065ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_99_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_2)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10065ui_story then
				arg_99_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_99_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_102_3 = 0
			local var_102_4 = 1.1

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_5 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(318281024).content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 44 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 44)

				if (44 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 44)) > 0 and var_102_4 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_3 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_3
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_4, arg_99_1.talkMaxDuration)

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_3) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_3 + var_102_8 and arg_99_1.time_ < var_102_3 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
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
	Play318281025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 318281025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play318281026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:AudioAction("play", "effect", "se_story_127", "se_story_127_bomb", "")
			end

			local var_106_1 = 0
			local var_106_2 = 1.075

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(318281025).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 43 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 43)

				if (43 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 43)) > 0 and var_106_2 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_1
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_6 = math.max(var_106_2, arg_103_1.talkMaxDuration)

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_6 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_1) / var_106_6

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_1 + var_106_6 and arg_103_1.time_ < var_106_1 + var_106_6 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play318281026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 318281026
		arg_107_1.duration_ = 4.17

		local var_107_0 = {
			zh = 2.033,
			ja = 4.166
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
				arg_107_0:Play318281027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10065ui_story"]) and arg_107_1.var_.characterEffect10065ui_story == nil then
				arg_107_1.var_.characterEffect10065ui_story = arg_107_1.actors_["10065ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10065ui_story"]) then
				if arg_107_1.var_.characterEffect10065ui_story and not isNil(arg_107_1.actors_["10065ui_story"]) then
					arg_107_1.var_.characterEffect10065ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10065ui_story"]) and arg_107_1.var_.characterEffect10065ui_story then
				arg_107_1.var_.characterEffect10065ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10065ui_story", "StoryTimeline/CharAction/story10065/story10065action/10065action3_1")
			end

			local var_110_2 = arg_107_1.actors_["10065ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10065ui_story = var_110_2.localPosition
			end

			local var_110_3 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 then
				var_110_2.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10065ui_story, Vector3.New(0, -0.81, -6.19), (arg_107_1.time_ - 0) / var_110_3)
				var_110_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_2.position).x, (manager.ui.mainCamera.transform.position - var_110_2.position).y, (manager.ui.mainCamera.transform.position - var_110_2.position).z)
				var_110_2.localEulerAngles.z = 0
				var_110_2.localEulerAngles.x = 0
				var_110_2.localEulerAngles = var_110_2.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 then
				var_110_2.localPosition = Vector3.New(0, -0.81, -6.19)
				var_110_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_2.position).x, (manager.ui.mainCamera.transform.position - var_110_2.position).y, (manager.ui.mainCamera.transform.position - var_110_2.position).z)
				var_110_2.localEulerAngles.z = 0
				var_110_2.localEulerAngles.x = 0
				var_110_2.localEulerAngles = var_110_2.localEulerAngles
			end

			local var_110_4 = 0
			local var_110_5 = 0.125

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(318281026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 5 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 5)

				if (5 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 5)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281026", "story_v_out_318281.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_out_318281", "318281026", "story_v_out_318281.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_out_318281", "318281026", "story_v_out_318281.awb")

						arg_107_1:RecordAudio("318281026", var_110_11)
						arg_107_1:RecordAudio("318281026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_318281", "318281026", "story_v_out_318281.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_318281", "318281026", "story_v_out_318281.awb")
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
				actorName = "10065ui_story",
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
	Play318281027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 318281027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play318281028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10065ui_story = arg_111_1.actors_["10065ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["10065ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10065ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10065ui_story"].transform.position).z)
				arg_111_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["10065ui_story"].transform.localEulerAngles = arg_111_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["10065ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["10065ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["10065ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10065ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["10065ui_story"].transform.position).z)
				arg_111_1.actors_["10065ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["10065ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["10065ui_story"].transform.localEulerAngles = arg_111_1.actors_["10065ui_story"].transform.localEulerAngles
			end

			local var_114_1 = arg_111_1.actors_["10065ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect10065ui_story == nil then
				arg_111_1.var_.characterEffect10065ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect10065ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect10065ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10065ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_2)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect10065ui_story then
				arg_111_1.var_.characterEffect10065ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10065ui_story.fillRatio = 0.5
			end

			local var_114_3 = 0
			local var_114_4 = 1.375

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_3 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_5 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(318281027).content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 55 <= 0 and var_114_4 or var_114_4 * (utf8.len(var_114_5) / 55)

				if (55 <= 0 and var_114_4 or var_114_4 * (utf8.len(var_114_5) / 55)) > 0 and var_114_4 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_3 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_3
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_8 = math.max(var_114_4, arg_111_1.talkMaxDuration)

			if var_114_3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_3 + var_114_8 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_3) / var_114_8

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_3 + var_114_8 and arg_111_1.time_ < var_114_3 + var_114_8 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10065ui_story",
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
	Play318281028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 318281028
		arg_115_1.duration_ = 7

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play318281029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if arg_115_1.bgs_.LX0208 == nil then
				local var_118_0 = Object.Instantiate(arg_115_1.paintGo_)

				var_118_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "LX0208")
				var_118_0.name = "LX0208"
				var_118_0.transform.parent = arg_115_1.stage_.transform
				var_118_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.bgs_.LX0208 = var_118_0
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				local var_118_1 = arg_115_1.bgs_.LX0208

				arg_115_1.bgs_.LX0208.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_118_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_118_2 = var_118_1:GetComponent("SpriteRenderer")

				if var_118_2 and var_118_2.sprite then
					local var_118_3 = 2 * (var_118_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_118_1.transform.localScale = Vector3.New(var_118_3 / var_118_2.sprite.bounds.size.y < var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x and var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x or var_118_3 / var_118_2.sprite.bounds.size.y, var_118_3 / var_118_2.sprite.bounds.size.y < var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x and var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x or var_118_3 / var_118_2.sprite.bounds.size.y, 0)
				end

				for iter_118_0, iter_118_1 in pairs(arg_115_1.bgs_) do
					if iter_118_0 ~= "LX0208" then
						iter_118_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_118_4 = 0

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_5 = 2

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_5 then
				local var_118_6 = Color.New(1, 1, 1)

				var_118_6.a = Mathf.Lerp(1, 0, (arg_115_1.time_ - var_118_4) / var_118_5)
				arg_115_1.mask_.color = var_118_6
			end

			if arg_115_1.time_ >= var_118_4 + var_118_5 and arg_115_1.time_ < var_118_4 + var_118_5 + arg_118_0 then
				local var_118_7 = Color.New(1, 1, 1)

				arg_115_1.mask_.enabled = false
				var_118_7.a = 0
				arg_115_1.mask_.color = var_118_7
			end

			local var_118_8 = manager.ui.mainCamera.transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.shakeOldPos = var_118_8.localPosition
			end

			local var_118_9 = 1

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_9 then
				local var_118_10, var_118_11 = math.modf((arg_115_1.time_ - 0) / 0.066)

				var_118_8.localPosition = Vector3.New(var_118_11 * 0.13, var_118_11 * 0.13, var_118_11 * 0.13) + arg_115_1.var_.shakeOldPos
			end

			if arg_115_1.time_ >= 0 + var_118_9 and arg_115_1.time_ < 0 + var_118_9 + arg_118_0 then
				var_118_8.localPosition = arg_115_1.var_.shakeOldPos
			end

			local var_118_12 = arg_115_1.bgs_.LX0208.transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPosLX0208 = var_118_12.localPosition
			end

			local var_118_13 = 2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_13 then
				var_118_12.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPosLX0208, Vector3.New(0, 1, 9.5), (arg_115_1.time_ - 0) / var_118_13)
			end

			if arg_115_1.time_ >= 0 + var_118_13 and arg_115_1.time_ < 0 + var_118_13 + arg_118_0 then
				var_118_12.localPosition = Vector3.New(0, 1, 9.5)
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_14 = 2
			local var_118_15 = 0.825

			if 2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_16 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_16:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_17 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(318281028).content)

				arg_115_1.text_.text = var_118_17

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_19 = 33 <= 0 and var_118_15 or var_118_15 * (utf8.len(var_118_17) / 33)

				if (33 <= 0 and var_118_15 or var_118_15 * (utf8.len(var_118_17) / 33)) > 0 and var_118_15 < var_118_19 then
					arg_115_1.talkMaxDuration = var_118_19
					var_118_14 = var_118_14 + 0.3

					if var_118_19 + var_118_14 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_19 + var_118_14
					end
				end

				arg_115_1.text_.text = var_118_17
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_20 = var_118_14 + 0.3
			local var_118_21 = math.max(var_118_15, arg_115_1.talkMaxDuration)

			if var_118_14 + 0.3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_20 + var_118_21 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_20) / var_118_21

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_20 + var_118_21 and arg_115_1.time_ < var_118_20 + var_118_21 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "LX0208",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play318281029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 318281029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play318281030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.225

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(318281029).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 9 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 9)

				if (9 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 9)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play318281030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 318281030
		arg_125_1.duration_ = 4.33

		local var_125_0 = {
			zh = 3.6,
			ja = 4.333
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play318281031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.325

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10066")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:GetWordFromCfg(318281030)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 13 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 13)

				if (13 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 13)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281030", "story_v_out_318281.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_318281", "318281030", "story_v_out_318281.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_318281", "318281030", "story_v_out_318281.awb")

						arg_125_1:RecordAudio("318281030", var_128_6)
						arg_125_1:RecordAudio("318281030", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_318281", "318281030", "story_v_out_318281.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_318281", "318281030", "story_v_out_318281.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play318281031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 318281031
		arg_129_1.duration_ = 2.8

		local var_129_0 = {
			zh = 2.6,
			ja = 2.8
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play318281032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0.35

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(318281031)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 14 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 14)

				if (14 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 14)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281031", "story_v_out_318281.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_318281", "318281031", "story_v_out_318281.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_318281", "318281031", "story_v_out_318281.awb")

						arg_129_1:RecordAudio("318281031", var_132_6)
						arg_129_1:RecordAudio("318281031", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_318281", "318281031", "story_v_out_318281.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_318281", "318281031", "story_v_out_318281.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play318281032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 318281032
		arg_133_1.duration_ = 3.33

		local var_133_0 = {
			zh = 2.233,
			ja = 3.333
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
				arg_133_0:Play318281033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.275

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(318281032)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 11 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 11)

				if (11 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 11)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281032", "story_v_out_318281.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_318281", "318281032", "story_v_out_318281.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_318281", "318281032", "story_v_out_318281.awb")

						arg_133_1:RecordAudio("318281032", var_136_6)
						arg_133_1:RecordAudio("318281032", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_318281", "318281032", "story_v_out_318281.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_318281", "318281032", "story_v_out_318281.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play318281033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 318281033
		arg_137_1.duration_ = 4.07

		local var_137_0 = {
			zh = 4.066,
			ja = 3.4
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
				arg_137_0:Play318281034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.45

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(318281033)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 18 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 18)

				if (18 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 18)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281033", "story_v_out_318281.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_318281", "318281033", "story_v_out_318281.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_318281", "318281033", "story_v_out_318281.awb")

						arg_137_1:RecordAudio("318281033", var_140_6)
						arg_137_1:RecordAudio("318281033", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_318281", "318281033", "story_v_out_318281.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_318281", "318281033", "story_v_out_318281.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play318281034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 318281034
		arg_141_1.duration_ = 4.37

		local var_141_0 = {
			zh = 4.366,
			ja = 2.9
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
				arg_141_0:Play318281035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.45

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(318281034)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 18 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 18)

				if (18 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 18)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281034", "story_v_out_318281.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_318281", "318281034", "story_v_out_318281.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_318281", "318281034", "story_v_out_318281.awb")

						arg_141_1:RecordAudio("318281034", var_144_6)
						arg_141_1:RecordAudio("318281034", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_318281", "318281034", "story_v_out_318281.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_318281", "318281034", "story_v_out_318281.awb")
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
	Play318281035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 318281035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play318281036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.125

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(318281035).content)

				arg_145_1.text_.text = var_148_1

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_3 = 5 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 5)

				if (5 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_1) / 5)) > 0 and var_148_0 < var_148_3 then
					arg_145_1.talkMaxDuration = var_148_3

					if var_148_3 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_3 + 0
					end
				end

				arg_145_1.text_.text = var_148_1
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_4 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_4 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_4

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_4 and arg_145_1.time_ < 0 + var_148_4 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play318281036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 318281036
		arg_149_1.duration_ = 4.5

		local var_149_0 = {
			zh = 1.6,
			ja = 4.5
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
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play318281037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.2

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:GetWordFromCfg(318281036)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 8 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 8)

				if (8 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 8)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281036", "story_v_out_318281.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_318281", "318281036", "story_v_out_318281.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_318281", "318281036", "story_v_out_318281.awb")

						arg_149_1:RecordAudio("318281036", var_152_6)
						arg_149_1:RecordAudio("318281036", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_318281", "318281036", "story_v_out_318281.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_318281", "318281036", "story_v_out_318281.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play318281037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 318281037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play318281038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.975

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(318281037).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 39 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 39)

				if (39 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 39)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play318281038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 318281038
		arg_157_1.duration_ = 2.77

		local var_157_0 = {
			zh = 1.4,
			ja = 2.766
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play318281039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.15

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:GetWordFromCfg(318281038)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 6 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 6)

				if (6 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 6)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281038", "story_v_out_318281.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_318281", "318281038", "story_v_out_318281.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_318281", "318281038", "story_v_out_318281.awb")

						arg_157_1:RecordAudio("318281038", var_160_6)
						arg_157_1:RecordAudio("318281038", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_318281", "318281038", "story_v_out_318281.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_318281", "318281038", "story_v_out_318281.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play318281039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 318281039
		arg_161_1.duration_ = 9

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play318281040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 2 < arg_161_1.time_ and arg_161_1.time_ <= 2 + arg_164_0 then
				local var_164_0 = arg_161_1.bgs_.K16i

				arg_161_1.bgs_.K16i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_164_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_164_1 = var_164_0:GetComponent("SpriteRenderer")

				if var_164_1 and var_164_1.sprite then
					local var_164_2 = 2 * (var_164_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_164_0.transform.localScale = Vector3.New(var_164_2 / var_164_1.sprite.bounds.size.y < var_164_2 * manager.ui.mainCameraCom_.aspect / var_164_1.sprite.bounds.size.x and var_164_2 * manager.ui.mainCameraCom_.aspect / var_164_1.sprite.bounds.size.x or var_164_2 / var_164_1.sprite.bounds.size.y, var_164_2 / var_164_1.sprite.bounds.size.y < var_164_2 * manager.ui.mainCameraCom_.aspect / var_164_1.sprite.bounds.size.x and var_164_2 * manager.ui.mainCameraCom_.aspect / var_164_1.sprite.bounds.size.x or var_164_2 / var_164_1.sprite.bounds.size.y, 0)
				end

				for iter_164_0, iter_164_1 in pairs(arg_161_1.bgs_) do
					if iter_164_0 ~= "K16i" then
						iter_164_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_164_3 = 0

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_4 = 2

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_4 then
				local var_164_5 = Color.New(0, 0, 0)

				var_164_5.a = Mathf.Lerp(0, 1, (arg_161_1.time_ - var_164_3) / var_164_4)
				arg_161_1.mask_.color = var_164_5
			end

			if arg_161_1.time_ >= var_164_3 + var_164_4 and arg_161_1.time_ < var_164_3 + var_164_4 + arg_164_0 then
				local var_164_6 = Color.New(0, 0, 0)

				var_164_6.a = 1
				arg_161_1.mask_.color = var_164_6
			end

			local var_164_7 = 2

			if 2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_7 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_8 = 2

			if var_164_7 <= arg_161_1.time_ and arg_161_1.time_ < var_164_7 + var_164_8 then
				local var_164_9 = Color.New(0, 0, 0)

				var_164_9.a = Mathf.Lerp(1, 0, (arg_161_1.time_ - var_164_7) / var_164_8)
				arg_161_1.mask_.color = var_164_9
			end

			if arg_161_1.time_ >= var_164_7 + var_164_8 and arg_161_1.time_ < var_164_7 + var_164_8 + arg_164_0 then
				local var_164_10 = Color.New(0, 0, 0)

				arg_161_1.mask_.enabled = false
				var_164_10.a = 0
				arg_161_1.mask_.color = var_164_10
			end

			if arg_161_1.frameCnt_ <= 1 then
				arg_161_1.dialog_:SetActive(false)
			end

			local var_164_11 = 4
			local var_164_12 = 0.8

			if 4 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				arg_161_1.dialog_:SetActive(true)

				arg_161_1.dialogCg_.alpha = 0

				local var_164_13 = LeanTween.value(arg_161_1.dialog_, 0, 1, 0.3)

				var_164_13:setOnUpdate(LuaHelper.FloatAction(function(arg_165_0)
					arg_161_1.dialogCg_.alpha = arg_165_0
				end))
				var_164_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_161_1.dialog_)
					var_164_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_161_1.duration_ = arg_161_1.duration_ + 0.3

				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_14 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(318281039).content)

				arg_161_1.text_.text = var_164_14

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_16 = 32 <= 0 and var_164_12 or var_164_12 * (utf8.len(var_164_14) / 32)

				if (32 <= 0 and var_164_12 or var_164_12 * (utf8.len(var_164_14) / 32)) > 0 and var_164_12 < var_164_16 then
					arg_161_1.talkMaxDuration = var_164_16
					var_164_11 = var_164_11 + 0.3

					if var_164_16 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_16 + var_164_11
					end
				end

				arg_161_1.text_.text = var_164_14
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_17 = var_164_11 + 0.3
			local var_164_18 = math.max(var_164_12, arg_161_1.talkMaxDuration)

			if var_164_11 + 0.3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_17 + var_164_18 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_17) / var_164_18

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_17 + var_164_18 and arg_161_1.time_ < var_164_17 + var_164_18 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play318281040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 318281040
		arg_167_1.duration_ = 2

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play318281041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if arg_167_1.actors_["1199ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1199ui_story"))) then
				local var_170_0 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_167_1.stage_.transform)

				var_170_0.name = "1199ui_story"
				var_170_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.actors_["1199ui_story"] = var_170_0

				local var_170_1 = var_170_0:GetComponentInChildren(typeof(CharacterEffect))

				var_170_1.enabled = true

				local var_170_2 = GameObjectTools.GetOrAddComponent(var_170_0, typeof(DynamicBoneHelper))

				if var_170_2 then
					var_170_2:EnableDynamicBone(false)
				end

				arg_167_1:ShowWeapon(var_170_1.transform, false)

				arg_167_1.var_["1199ui_story" .. "Animator"] = var_170_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_167_1.var_["1199ui_story" .. "Animator"].applyRootMotion = true
				arg_167_1.var_["1199ui_story" .. "LipSync"] = var_170_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_170_3 = arg_167_1.actors_["1199ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1199ui_story = var_170_3.localPosition
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_3.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_167_1.time_ - 0) / var_170_4)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			local var_170_5 = arg_167_1.actors_["1199ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1199ui_story == nil then
				arg_167_1.var_.characterEffect1199ui_story = var_170_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_6 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 and not isNil(var_170_5) then
				if arg_167_1.var_.characterEffect1199ui_story and not isNil(var_170_5) then
					arg_167_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1199ui_story then
				arg_167_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_8 = 0
			local var_170_9 = 0.125

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(318281040)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 5 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 5)

				if (5 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 5)) > 0 and var_170_9 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281040", "story_v_out_318281.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_318281", "318281040", "story_v_out_318281.awb") / 1000

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_318281", "318281040", "story_v_out_318281.awb")

						arg_167_1:RecordAudio("318281040", var_170_15)
						arg_167_1:RecordAudio("318281040", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_318281", "318281040", "story_v_out_318281.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_318281", "318281040", "story_v_out_318281.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_16 = math.max(var_170_9, arg_167_1.talkMaxDuration)

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_16 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_8) / var_170_16

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_8 + var_170_16 and arg_167_1.time_ < var_170_8 + var_170_16 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318281041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 318281041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play318281042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1199ui_story"]) and arg_171_1.var_.characterEffect1199ui_story == nil then
				arg_171_1.var_.characterEffect1199ui_story = arg_171_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1199ui_story"]) then
				if arg_171_1.var_.characterEffect1199ui_story and not isNil(arg_171_1.actors_["1199ui_story"]) then
					arg_171_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1199ui_story"]) and arg_171_1.var_.characterEffect1199ui_story then
				arg_171_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_174_1 = 0
			local var_174_2 = 0.625

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(318281041).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 25 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 25)

				if (25 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 25)) > 0 and var_174_2 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_6 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_6 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_6

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_6 and arg_171_1.time_ < var_174_1 + var_174_6 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play318281042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 318281042
		arg_175_1.duration_ = 10

		local var_175_0 = {
			zh = 7.133,
			ja = 10
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
				arg_175_0:Play318281043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1199ui_story = arg_175_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1199ui_story"].transform.position).z)
				arg_175_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1199ui_story"].transform.localEulerAngles = arg_175_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_175_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1199ui_story"].transform.position).z)
				arg_175_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1199ui_story"].transform.localEulerAngles = arg_175_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1199ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1199ui_story == nil then
				arg_175_1.var_.characterEffect1199ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1199ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1199ui_story then
				arg_175_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1199/story1199action/1199action1_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_178_4 = 0
			local var_178_5 = 0.775

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(318281042)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 31 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 31)

				if (31 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 31)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281042", "story_v_out_318281.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_out_318281", "318281042", "story_v_out_318281.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_318281", "318281042", "story_v_out_318281.awb")

						arg_175_1:RecordAudio("318281042", var_178_11)
						arg_175_1:RecordAudio("318281042", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_318281", "318281042", "story_v_out_318281.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_318281", "318281042", "story_v_out_318281.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318281043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 318281043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play318281044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1199ui_story = arg_179_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1199ui_story"].transform.position).z)
				arg_179_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1199ui_story"].transform.localEulerAngles = arg_179_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1199ui_story"].transform.position).z)
				arg_179_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1199ui_story"].transform.localEulerAngles = arg_179_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1199ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1199ui_story == nil then
				arg_179_1.var_.characterEffect1199ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1199ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_2)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1199ui_story then
				arg_179_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_182_3 = 0
			local var_182_4 = 0.95

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_3 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_5 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(318281043).content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 38 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_5) / 38)

				if (38 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_5) / 38)) > 0 and var_182_4 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_3 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_3
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_4, arg_179_1.talkMaxDuration)

			if var_182_3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_3 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_3) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_3 + var_182_8 and arg_179_1.time_ < var_182_3 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
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
	Play318281044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 318281044
		arg_183_1.duration_ = 2

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play318281045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if arg_183_1.actors_["1150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1150ui_story"))) then
				local var_186_0 = Object.Instantiate(Asset.Load("Char/" .. "1150ui_story"), arg_183_1.stage_.transform)

				var_186_0.name = "1150ui_story"
				var_186_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["1150ui_story"] = var_186_0

				local var_186_1 = var_186_0:GetComponentInChildren(typeof(CharacterEffect))

				var_186_1.enabled = true

				local var_186_2 = GameObjectTools.GetOrAddComponent(var_186_0, typeof(DynamicBoneHelper))

				if var_186_2 then
					var_186_2:EnableDynamicBone(false)
				end

				arg_183_1:ShowWeapon(var_186_1.transform, false)

				arg_183_1.var_["1150ui_story" .. "Animator"] = var_186_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_183_1.var_["1150ui_story" .. "Animator"].applyRootMotion = true
				arg_183_1.var_["1150ui_story" .. "LipSync"] = var_186_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_186_3 = arg_183_1.actors_["1150ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1150ui_story = var_186_3.localPosition

				arg_183_1:ShowWeapon(arg_183_1.var_["1150ui_story" .. "Animator"].transform, true)
			end

			local var_186_4 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				var_186_3.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_183_1.time_ - 0) / var_186_4)
				var_186_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_3.position).x, (manager.ui.mainCamera.transform.position - var_186_3.position).y, (manager.ui.mainCamera.transform.position - var_186_3.position).z)
				var_186_3.localEulerAngles.z = 0
				var_186_3.localEulerAngles.x = 0
				var_186_3.localEulerAngles = var_186_3.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				var_186_3.localPosition = Vector3.New(0, -1.01, -6.2)
				var_186_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_3.position).x, (manager.ui.mainCamera.transform.position - var_186_3.position).y, (manager.ui.mainCamera.transform.position - var_186_3.position).z)
				var_186_3.localEulerAngles.z = 0
				var_186_3.localEulerAngles.x = 0
				var_186_3.localEulerAngles = var_186_3.localEulerAngles
			end

			local var_186_5 = arg_183_1.actors_["1150ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.characterEffect1150ui_story == nil then
				arg_183_1.var_.characterEffect1150ui_story = var_186_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_6 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_6 and not isNil(var_186_5) then
				if arg_183_1.var_.characterEffect1150ui_story and not isNil(var_186_5) then
					arg_183_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_6 and arg_183_1.time_ < 0 + var_186_6 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.characterEffect1150ui_story then
				arg_183_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action6_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_186_8 = 0
			local var_186_9 = 0.1

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_8 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_10 = arg_183_1:GetWordFromCfg(318281044)
				local var_186_11 = arg_183_1:FormatText(var_186_10.content)

				arg_183_1.text_.text = var_186_11

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_13 = 4 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 4)

				if (4 <= 0 and var_186_9 or var_186_9 * (utf8.len(var_186_11) / 4)) > 0 and var_186_9 < var_186_13 then
					arg_183_1.talkMaxDuration = var_186_13

					if var_186_13 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_13 + var_186_8
					end
				end

				arg_183_1.text_.text = var_186_11
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281044", "story_v_out_318281.awb") ~= 0 then
					local var_186_14 = manager.audio:GetVoiceLength("story_v_out_318281", "318281044", "story_v_out_318281.awb") / 1000

					if var_186_14 + var_186_8 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_14 + var_186_8
					end

					if var_186_10.prefab_name ~= "" and arg_183_1.actors_[var_186_10.prefab_name] ~= nil then
						local var_186_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_10.prefab_name].transform, "story_v_out_318281", "318281044", "story_v_out_318281.awb")

						arg_183_1:RecordAudio("318281044", var_186_15)
						arg_183_1:RecordAudio("318281044", var_186_15)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_318281", "318281044", "story_v_out_318281.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_318281", "318281044", "story_v_out_318281.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_16 = math.max(var_186_9, arg_183_1.talkMaxDuration)

			if var_186_8 <= arg_183_1.time_ and arg_183_1.time_ < var_186_8 + var_186_16 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_8) / var_186_16

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_8 + var_186_16 and arg_183_1.time_ < var_186_8 + var_186_16 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318281045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 318281045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play318281046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1150ui_story = arg_187_1.actors_["1150ui_story"].transform.localPosition

				arg_187_1:ShowWeapon(arg_187_1.var_["1150ui_story" .. "Animator"].transform, false)
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1150ui_story"].transform.position).z)
				arg_187_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1150ui_story"].transform.localEulerAngles = arg_187_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_187_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1150ui_story"].transform.position).z)
				arg_187_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1150ui_story"].transform.localEulerAngles = arg_187_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["1150ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1150ui_story == nil then
				arg_187_1.var_.characterEffect1150ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect1150ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_2)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1150ui_story then
				arg_187_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_190_3 = 0
			local var_190_4 = 1.15

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_3 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_5 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(318281045).content)

				arg_187_1.text_.text = var_190_5

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_7 = 46 <= 0 and var_190_4 or var_190_4 * (utf8.len(var_190_5) / 46)

				if (46 <= 0 and var_190_4 or var_190_4 * (utf8.len(var_190_5) / 46)) > 0 and var_190_4 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_3 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_3
					end
				end

				arg_187_1.text_.text = var_190_5
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_8 = math.max(var_190_4, arg_187_1.talkMaxDuration)

			if var_190_3 <= arg_187_1.time_ and arg_187_1.time_ < var_190_3 + var_190_8 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_3) / var_190_8

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_3 + var_190_8 and arg_187_1.time_ < var_190_3 + var_190_8 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	Play318281046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 318281046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play318281047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.2

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(318281046).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 8 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 8)

				if (8 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 8)) > 0 and var_194_0 < var_194_3 then
					arg_191_1.talkMaxDuration = var_194_3

					if var_194_3 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_3 + 0
					end
				end

				arg_191_1.text_.text = var_194_1
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_4 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_4

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play318281047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 318281047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play318281048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 1.225

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(318281047).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 49 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 49)

				if (49 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 49)) > 0 and var_198_0 < var_198_3 then
					arg_195_1.talkMaxDuration = var_198_3

					if var_198_3 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_3 + 0
					end
				end

				arg_195_1.text_.text = var_198_1
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_4 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_4

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play318281048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 318281048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play318281049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 1.075

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(318281048).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 43 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 43)

				if (43 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 43)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play318281049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 318281049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play318281050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.25

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(318281049).content)

				arg_203_1.text_.text = var_206_1

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_3 = 10 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 10)

				if (10 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 10)) > 0 and var_206_0 < var_206_3 then
					arg_203_1.talkMaxDuration = var_206_3

					if var_206_3 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_3 + 0
					end
				end

				arg_203_1.text_.text = var_206_1
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_4 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_4

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play318281050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 318281050
		arg_207_1.duration_ = 2.67

		local var_207_0 = {
			zh = 2.033,
			ja = 2.666
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play318281051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if arg_207_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_210_0 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_207_1.stage_.transform)

				var_210_0.name = "1058ui_story"
				var_210_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["1058ui_story"] = var_210_0

				local var_210_1 = var_210_0:GetComponentInChildren(typeof(CharacterEffect))

				var_210_1.enabled = true

				local var_210_2 = GameObjectTools.GetOrAddComponent(var_210_0, typeof(DynamicBoneHelper))

				if var_210_2 then
					var_210_2:EnableDynamicBone(false)
				end

				arg_207_1:ShowWeapon(var_210_1.transform, false)

				arg_207_1.var_["1058ui_story" .. "Animator"] = var_210_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_207_1.var_["1058ui_story" .. "Animator"].applyRootMotion = true
				arg_207_1.var_["1058ui_story" .. "LipSync"] = var_210_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_210_3 = arg_207_1.actors_["1058ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1058ui_story = var_210_3.localPosition
			end

			local var_210_4 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				var_210_3.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_207_1.time_ - 0) / var_210_4)
				var_210_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_3.position).x, (manager.ui.mainCamera.transform.position - var_210_3.position).y, (manager.ui.mainCamera.transform.position - var_210_3.position).z)
				var_210_3.localEulerAngles.z = 0
				var_210_3.localEulerAngles.x = 0
				var_210_3.localEulerAngles = var_210_3.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				var_210_3.localPosition = Vector3.New(0, -0.95, -5.88)
				var_210_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_3.position).x, (manager.ui.mainCamera.transform.position - var_210_3.position).y, (manager.ui.mainCamera.transform.position - var_210_3.position).z)
				var_210_3.localEulerAngles.z = 0
				var_210_3.localEulerAngles.x = 0
				var_210_3.localEulerAngles = var_210_3.localEulerAngles
			end

			local var_210_5 = arg_207_1.actors_["1058ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect1058ui_story == nil then
				arg_207_1.var_.characterEffect1058ui_story = var_210_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_6 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_6 and not isNil(var_210_5) then
				if arg_207_1.var_.characterEffect1058ui_story and not isNil(var_210_5) then
					arg_207_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_6 and arg_207_1.time_ < 0 + var_210_6 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect1058ui_story then
				arg_207_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_210_8 = 0
			local var_210_9 = 0.275

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_10 = arg_207_1:GetWordFromCfg(318281050)
				local var_210_11 = arg_207_1:FormatText(var_210_10.content)

				arg_207_1.text_.text = var_210_11

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_13 = 11 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 11)

				if (11 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 11)) > 0 and var_210_9 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_11
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318281", "318281050", "story_v_out_318281.awb") ~= 0 then
					local var_210_14 = manager.audio:GetVoiceLength("story_v_out_318281", "318281050", "story_v_out_318281.awb") / 1000

					if var_210_14 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_8
					end

					if var_210_10.prefab_name ~= "" and arg_207_1.actors_[var_210_10.prefab_name] ~= nil then
						local var_210_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_10.prefab_name].transform, "story_v_out_318281", "318281050", "story_v_out_318281.awb")

						arg_207_1:RecordAudio("318281050", var_210_15)
						arg_207_1:RecordAudio("318281050", var_210_15)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_318281", "318281050", "story_v_out_318281.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_318281", "318281050", "story_v_out_318281.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_16 = math.max(var_210_9, arg_207_1.talkMaxDuration)

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_16 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_8) / var_210_16

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_8 + var_210_16 and arg_207_1.time_ < var_210_8 + var_210_16 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play318281051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 318281051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play318281052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1058ui_story = arg_211_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).z)
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles = arg_211_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).z)
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles = arg_211_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1058ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1058ui_story == nil then
				arg_211_1.var_.characterEffect1058ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1058ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_2)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1058ui_story then
				arg_211_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_214_3 = 0
			local var_214_4 = 0.5

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

				local var_214_5 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(318281051).content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 20 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 20)

				if (20 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 20)) > 0 and var_214_4 < var_214_7 then
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
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play318281052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 318281052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play318281053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 1.05

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(318281052).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 42 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 42)

				if (42 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 42)) > 0 and var_218_0 < var_218_3 then
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
	Play318281053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 318281053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
			arg_219_1.auto_ = false
		end

		function arg_219_1.playNext_(arg_221_0)
			arg_219_1.onStoryFinished_()
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.475

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_1 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(318281053).content)

				arg_219_1.text_.text = var_222_1

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_3 = 19 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 19)

				if (19 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 19)) > 0 and var_222_0 < var_222_3 then
					arg_219_1.talkMaxDuration = var_222_3

					if var_222_3 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_3 + 0
					end
				end

				arg_219_1.text_.text = var_222_1
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_4 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_4

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K16h",
		"TextureConfig/Background/K16i",
		"TextureConfig/Background/LX0208"
	},
	voices = {
		"story_v_out_318281.awb"
	}
}
