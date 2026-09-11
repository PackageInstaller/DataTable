return {
	Play421071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421071001
		arg_1_1.duration_ = 13.4

		local var_1_0 = {
			zh = 9.066,
			ja = 13.4
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
				arg_1_0:Play421071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I08a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I08a")
				var_4_0.name = "I08a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I08a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I08a

				arg_1_1.bgs_.I08a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I08a" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drain_p2", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = 2
			local var_4_17 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(421071001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 32 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 32)

				if (32 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 32)) > 0 and var_4_17 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_16 = var_4_16 + 0.3

					if var_4_22 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071001", "story_v_out_421071.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_421071", "421071001", "story_v_out_421071.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_421071", "421071001", "story_v_out_421071.awb")

						arg_1_1:RecordAudio("421071001", var_4_24)
						arg_1_1:RecordAudio("421071001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_421071", "421071001", "story_v_out_421071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_421071", "421071001", "story_v_out_421071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_16 + 0.3
			local var_4_26 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play421071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421071002
		arg_9_1.duration_ = 12.4

		local var_9_0 = {
			zh = 8.8,
			ja = 12.4
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
				arg_9_0:Play421071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.975

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(421071002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 39 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 39)

				if (39 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 39)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071002", "story_v_out_421071.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071002", "story_v_out_421071.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_421071", "421071002", "story_v_out_421071.awb")

						arg_9_1:RecordAudio("421071002", var_12_6)
						arg_9_1:RecordAudio("421071002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_421071", "421071002", "story_v_out_421071.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_421071", "421071002", "story_v_out_421071.awb")
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
	Play421071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421071003
		arg_13_1.duration_ = 6.4

		local var_13_0 = {
			zh = 4.233,
			ja = 6.4
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
				arg_13_0:Play421071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.5

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2030")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(421071003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 20 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 20)

				if (20 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 20)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071003", "story_v_out_421071.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071003", "story_v_out_421071.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_421071", "421071003", "story_v_out_421071.awb")

						arg_13_1:RecordAudio("421071003", var_16_6)
						arg_13_1:RecordAudio("421071003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_421071", "421071003", "story_v_out_421071.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_421071", "421071003", "story_v_out_421071.awb")
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
	Play421071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421071004
		arg_17_1.duration_ = 6.63

		local var_17_0 = {
			zh = 3.1,
			ja = 6.633
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
				arg_17_0:Play421071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.35

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(421071004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 14 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 14)

				if (14 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 14)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071004", "story_v_out_421071.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071004", "story_v_out_421071.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_421071", "421071004", "story_v_out_421071.awb")

						arg_17_1:RecordAudio("421071004", var_20_6)
						arg_17_1:RecordAudio("421071004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_421071", "421071004", "story_v_out_421071.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_421071", "421071004", "story_v_out_421071.awb")
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
	Play421071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 421071005
		arg_21_1.duration_ = 4.27

		local var_21_0 = {
			zh = 3.866,
			ja = 4.266
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
				arg_21_0:Play421071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.35

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2030")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(421071005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 14 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 14)

				if (14 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 14)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071005", "story_v_out_421071.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071005", "story_v_out_421071.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_421071", "421071005", "story_v_out_421071.awb")

						arg_21_1:RecordAudio("421071005", var_24_6)
						arg_21_1:RecordAudio("421071005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_421071", "421071005", "story_v_out_421071.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_421071", "421071005", "story_v_out_421071.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play421071006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 421071006
		arg_25_1.duration_ = 5.03

		local var_25_0 = {
			zh = 3.966,
			ja = 5.033
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
				arg_25_0:Play421071007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.475

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(421071006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 19 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 19)

				if (19 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 19)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071006", "story_v_out_421071.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071006", "story_v_out_421071.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_421071", "421071006", "story_v_out_421071.awb")

						arg_25_1:RecordAudio("421071006", var_28_6)
						arg_25_1:RecordAudio("421071006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_421071", "421071006", "story_v_out_421071.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_421071", "421071006", "story_v_out_421071.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play421071007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 421071007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play421071008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.15

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2030")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(421071007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 6 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 6)

				if (6 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 6)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play421071008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 421071008
		arg_33_1.duration_ = 9.4

		local var_33_0 = {
			zh = 4.3,
			ja = 9.4
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
				arg_33_0:Play421071009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(421071008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 21 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 21)

				if (21 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 21)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071008", "story_v_out_421071.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071008", "story_v_out_421071.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_421071", "421071008", "story_v_out_421071.awb")

						arg_33_1:RecordAudio("421071008", var_36_6)
						arg_33_1:RecordAudio("421071008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_421071", "421071008", "story_v_out_421071.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_421071", "421071008", "story_v_out_421071.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play421071009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 421071009
		arg_37_1.duration_ = 9.77

		local var_37_0 = {
			zh = 7.5,
			ja = 9.766
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
				arg_37_0:Play421071010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.975

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2030")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(421071009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 39 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 39)

				if (39 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 39)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071009", "story_v_out_421071.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071009", "story_v_out_421071.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_421071", "421071009", "story_v_out_421071.awb")

						arg_37_1:RecordAudio("421071009", var_40_6)
						arg_37_1:RecordAudio("421071009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_421071", "421071009", "story_v_out_421071.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_421071", "421071009", "story_v_out_421071.awb")
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
	Play421071010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 421071010
		arg_41_1.duration_ = 8.23

		local var_41_0 = {
			zh = 6.966,
			ja = 8.233
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
				arg_41_0:Play421071011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.75

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(421071010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 30 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 30)

				if (30 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 30)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071010", "story_v_out_421071.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071010", "story_v_out_421071.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_421071", "421071010", "story_v_out_421071.awb")

						arg_41_1:RecordAudio("421071010", var_44_6)
						arg_41_1:RecordAudio("421071010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_421071", "421071010", "story_v_out_421071.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_421071", "421071010", "story_v_out_421071.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play421071011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 421071011
		arg_45_1.duration_ = 4.6

		local var_45_0 = {
			zh = 3.433,
			ja = 4.6
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play421071012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.35

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(421071011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 14 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 14)

				if (14 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 14)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071011", "story_v_out_421071.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071011", "story_v_out_421071.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_421071", "421071011", "story_v_out_421071.awb")

						arg_45_1:RecordAudio("421071011", var_48_6)
						arg_45_1:RecordAudio("421071011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_421071", "421071011", "story_v_out_421071.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_421071", "421071011", "story_v_out_421071.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play421071012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 421071012
		arg_49_1.duration_ = 6.23

		local var_49_0 = {
			zh = 3.8,
			ja = 6.233
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
				arg_49_0:Play421071013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.4

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2030")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(421071012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 16 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 16)

				if (16 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 16)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071012", "story_v_out_421071.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071012", "story_v_out_421071.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_421071", "421071012", "story_v_out_421071.awb")

						arg_49_1:RecordAudio("421071012", var_52_6)
						arg_49_1:RecordAudio("421071012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_421071", "421071012", "story_v_out_421071.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_421071", "421071012", "story_v_out_421071.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play421071013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 421071013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play421071014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0.1 < arg_53_1.time_ and arg_53_1.time_ <= 0.1 + arg_56_0 then
				arg_53_1:AudioAction("play", "effect", "se_story_143", "se_story_143_elevator", "")
			end

			local var_56_1 = 0
			local var_56_2 = 0.875

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(421071013).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 35 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 35)

				if (35 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 35)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play421071014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 421071014
		arg_57_1.duration_ = 5.63

		local var_57_0 = {
			zh = 3.6,
			ja = 5.633
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
				arg_57_0:Play421071015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.45

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(421071014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 18 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 18)

				if (18 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 18)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071014", "story_v_out_421071.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071014", "story_v_out_421071.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_421071", "421071014", "story_v_out_421071.awb")

						arg_57_1:RecordAudio("421071014", var_60_6)
						arg_57_1:RecordAudio("421071014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_421071", "421071014", "story_v_out_421071.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_421071", "421071014", "story_v_out_421071.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play421071015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 421071015
		arg_61_1.duration_ = 1.33

		local var_61_0 = {
			zh = 1.2,
			ja = 1.333
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
				arg_61_0:Play421071016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.05

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2030")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(421071015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 2 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 2)

				if (2 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 2)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071015", "story_v_out_421071.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071015", "story_v_out_421071.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_421071", "421071015", "story_v_out_421071.awb")

						arg_61_1:RecordAudio("421071015", var_64_6)
						arg_61_1:RecordAudio("421071015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_421071", "421071015", "story_v_out_421071.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_421071", "421071015", "story_v_out_421071.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play421071016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 421071016
		arg_65_1.duration_ = 7.8

		local var_65_0 = {
			zh = 7.266,
			ja = 7.8
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play421071017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if arg_65_1.bgs_.D10 == nil then
				local var_68_0 = Object.Instantiate(arg_65_1.paintGo_)

				var_68_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D10")
				var_68_0.name = "D10"
				var_68_0.transform.parent = arg_65_1.stage_.transform
				var_68_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.bgs_.D10 = var_68_0
			end

			if 2 < arg_65_1.time_ and arg_65_1.time_ <= 2 + arg_68_0 then
				local var_68_1 = arg_65_1.bgs_.D10

				arg_65_1.bgs_.D10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_68_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_2 = var_68_1:GetComponent("SpriteRenderer")

				if var_68_2 and var_68_2.sprite then
					local var_68_3 = 2 * (var_68_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_68_1.transform.localScale = Vector3.New(var_68_3 / var_68_2.sprite.bounds.size.y < var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x and var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x or var_68_3 / var_68_2.sprite.bounds.size.y, var_68_3 / var_68_2.sprite.bounds.size.y < var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x and var_68_3 * manager.ui.mainCameraCom_.aspect / var_68_2.sprite.bounds.size.x or var_68_3 / var_68_2.sprite.bounds.size.y, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "D10" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_4 = 4

			if 4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.allBtn_.enabled = false
			end

			if arg_65_1.time_ >= var_68_4 + 0.166666666666667 and arg_65_1.time_ < var_68_4 + 0.166666666666667 + arg_68_0 then
				arg_65_1.allBtn_.enabled = true
			end

			local var_68_5 = 0

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_6 = 2

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_6 then
				local var_68_7 = Color.New(0, 0, 0)

				var_68_7.a = Mathf.Lerp(0, 1, (arg_65_1.time_ - var_68_5) / var_68_6)
				arg_65_1.mask_.color = var_68_7
			end

			if arg_65_1.time_ >= var_68_5 + var_68_6 and arg_65_1.time_ < var_68_5 + var_68_6 + arg_68_0 then
				local var_68_8 = Color.New(0, 0, 0)

				var_68_8.a = 1
				arg_65_1.mask_.color = var_68_8
			end

			local var_68_9 = 2

			if 2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_10 = 2

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 then
				local var_68_11 = Color.New(0, 0, 0)

				var_68_11.a = Mathf.Lerp(1, 0, (arg_65_1.time_ - var_68_9) / var_68_10)
				arg_65_1.mask_.color = var_68_11
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 then
				local var_68_12 = Color.New(0, 0, 0)

				arg_65_1.mask_.enabled = false
				var_68_12.a = 0
				arg_65_1.mask_.color = var_68_12
			end

			if 0.1 < arg_65_1.time_ and arg_65_1.time_ <= 0.1 + arg_68_0 then
				arg_65_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drain_p2", "")
			end

			if 1.6 < arg_65_1.time_ and arg_65_1.time_ <= 1.6 + arg_68_0 then
				arg_65_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_15 = 4
			local var_68_16 = 0.275

			if 4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_17 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_17:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_18 = arg_65_1:GetWordFromCfg(421071016)
				local var_68_19 = arg_65_1:FormatText(var_68_18.content)

				arg_65_1.text_.text = var_68_19

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 11 <= 0 and var_68_16 or var_68_16 * (utf8.len(var_68_19) / 11)

				if (11 <= 0 and var_68_16 or var_68_16 * (utf8.len(var_68_19) / 11)) > 0 and var_68_16 < var_68_21 then
					arg_65_1.talkMaxDuration = var_68_21
					var_68_15 = var_68_15 + 0.3

					if var_68_21 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_21 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_19
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071016", "story_v_out_421071.awb") ~= 0 then
					local var_68_22 = manager.audio:GetVoiceLength("story_v_out_421071", "421071016", "story_v_out_421071.awb") / 1000

					if var_68_22 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_22 + var_68_15
					end

					if var_68_18.prefab_name ~= "" and arg_65_1.actors_[var_68_18.prefab_name] ~= nil then
						local var_68_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_18.prefab_name].transform, "story_v_out_421071", "421071016", "story_v_out_421071.awb")

						arg_65_1:RecordAudio("421071016", var_68_23)
						arg_65_1:RecordAudio("421071016", var_68_23)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_421071", "421071016", "story_v_out_421071.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_421071", "421071016", "story_v_out_421071.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_24 = var_68_15 + 0.3
			local var_68_25 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 + 0.3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_24 + var_68_25 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_24) / var_68_25

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_24 + var_68_25 and arg_65_1.time_ < var_68_24 + var_68_25 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play421071017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 421071017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play421071018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 1.7

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

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(421071017).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 68 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 68)

				if (68 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 68)) > 0 and var_74_0 < var_74_3 then
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
	Play421071018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 421071018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play421071019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.675

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(421071018).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 27 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 27)

				if (27 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 27)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play421071019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 421071019
		arg_79_1.duration_ = 7.47

		local var_79_0 = {
			zh = 6.2,
			ja = 7.466
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
				arg_79_0:Play421071020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.5

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1305].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_1 = arg_79_1:GetWordFromCfg(421071019)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.text_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 20 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 20)

				if (20 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 20)) > 0 and var_82_0 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end

				arg_79_1.text_.text = var_82_2
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071019", "story_v_out_421071.awb") ~= 0 then
					local var_82_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071019", "story_v_out_421071.awb") / 1000

					if var_82_5 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + 0
					end

					if var_82_1.prefab_name ~= "" and arg_79_1.actors_[var_82_1.prefab_name] ~= nil then
						local var_82_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_1.prefab_name].transform, "story_v_out_421071", "421071019", "story_v_out_421071.awb")

						arg_79_1:RecordAudio("421071019", var_82_6)
						arg_79_1:RecordAudio("421071019", var_82_6)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_421071", "421071019", "story_v_out_421071.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_421071", "421071019", "story_v_out_421071.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play421071020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 421071020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play421071021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1.35

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(421071020).content)

				arg_83_1.text_.text = var_86_1

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_3 = 54 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 54)

				if (54 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_1) / 54)) > 0 and var_86_0 < var_86_3 then
					arg_83_1.talkMaxDuration = var_86_3

					if var_86_3 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_3 + 0
					end
				end

				arg_83_1.text_.text = var_86_1
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_4 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_4

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play421071021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 421071021
		arg_87_1.duration_ = 2.03

		local var_87_0 = {
			zh = 1.5,
			ja = 2.033
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
				arg_87_0:Play421071022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.175

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10102")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_1 = arg_87_1:GetWordFromCfg(421071021)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 7 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 7)

				if (7 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 7)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071021", "story_v_out_421071.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071021", "story_v_out_421071.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_421071", "421071021", "story_v_out_421071.awb")

						arg_87_1:RecordAudio("421071021", var_90_6)
						arg_87_1:RecordAudio("421071021", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_421071", "421071021", "story_v_out_421071.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_421071", "421071021", "story_v_out_421071.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play421071022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 421071022
		arg_91_1.duration_ = 5.52

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play421071023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				local var_94_0 = arg_91_1.var_.effect1020

				if not arg_91_1.var_.effect1020 then
					var_94_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_94_0.name = "1020"
					arg_91_1.var_.effect1020 = var_94_0
				else
					var_94_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_94_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_94_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_94_2 = manager.ui.mainCamera.transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.shakeOldPos = var_94_2.localPosition
			end

			local var_94_3 = 0.283333333333333

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 then
				local var_94_4, var_94_5 = math.modf((arg_91_1.time_ - 0) / 0.066)

				var_94_2.localPosition = Vector3.New(var_94_5 * 0.13, var_94_5 * 0.13, var_94_5 * 0.13) + arg_91_1.var_.shakeOldPos
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 then
				var_94_2.localPosition = arg_91_1.var_.shakeOldPos
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:AudioAction("play", "effect", "se_story_140", "se_story_140_hit02", "")
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_7 = 0.521758601302281
			local var_94_8 = 1.075

			if 0.521758601302281 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_9 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_9:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_10 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(421071022).content)

				arg_91_1.text_.text = var_94_10

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_12 = 43 <= 0 and var_94_8 or var_94_8 * (utf8.len(var_94_10) / 43)

				if (43 <= 0 and var_94_8 or var_94_8 * (utf8.len(var_94_10) / 43)) > 0 and var_94_8 < var_94_12 then
					arg_91_1.talkMaxDuration = var_94_12
					var_94_7 = var_94_7 + 0.3

					if var_94_12 + var_94_7 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_7
					end
				end

				arg_91_1.text_.text = var_94_10
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_13 = var_94_7 + 0.3
			local var_94_14 = math.max(var_94_8, arg_91_1.talkMaxDuration)

			if var_94_7 + 0.3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_13 + var_94_14 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_13) / var_94_14

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_13 + var_94_14 and arg_91_1.time_ < var_94_13 + var_94_14 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play421071023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 421071023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play421071024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.725

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

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(421071023).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 29 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 29)

				if (29 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 29)) > 0 and var_100_0 < var_100_3 then
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
	Play421071024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 421071024
		arg_101_1.duration_ = 3.1

		local var_101_0 = {
			zh = 2.1,
			ja = 3.1
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
				arg_101_0:Play421071025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.225

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(421071024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 9 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 9)

				if (9 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 9)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071024", "story_v_out_421071.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_421071", "421071024", "story_v_out_421071.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_421071", "421071024", "story_v_out_421071.awb")

						arg_101_1:RecordAudio("421071024", var_104_6)
						arg_101_1:RecordAudio("421071024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_421071", "421071024", "story_v_out_421071.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_421071", "421071024", "story_v_out_421071.awb")
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
	Play421071025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 421071025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play421071026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.5

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(421071025).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 20 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 20)

				if (20 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 20)) > 0 and var_108_0 < var_108_3 then
					arg_105_1.talkMaxDuration = var_108_3

					if var_108_3 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_3 + 0
					end
				end

				arg_105_1.text_.text = var_108_1
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_4 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_4

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play421071026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 421071026
		arg_109_1.duration_ = 9

		local var_109_0 = {
			zh = 8.133,
			ja = 9
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
				arg_109_0:Play421071027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 1 < arg_109_1.time_ and arg_109_1.time_ <= 1 + arg_112_0 then
				local var_112_0 = arg_109_1.bgs_.D10

				arg_109_1.bgs_.D10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_1 = var_112_0:GetComponent("SpriteRenderer")

				if var_112_1 and var_112_1.sprite then
					local var_112_2 = 2 * (var_112_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_0.transform.localScale = Vector3.New(var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "D10" then
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

			local var_112_4 = 1

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

			local var_112_7 = 1

			if 1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 then
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

			local var_112_11 = 2
			local var_112_12 = 0.625

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_11 + arg_112_0 then
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

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Jackson")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_14 = arg_109_1:GetWordFromCfg(421071026)
				local var_112_15 = arg_109_1:FormatText(var_112_14.content)

				arg_109_1.text_.text = var_112_15

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_17 = 25 <= 0 and var_112_12 or var_112_12 * (utf8.len(var_112_15) / 25)

				if (25 <= 0 and var_112_12 or var_112_12 * (utf8.len(var_112_15) / 25)) > 0 and var_112_12 < var_112_17 then
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

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071026", "story_v_out_421071.awb") ~= 0 then
					local var_112_18 = manager.audio:GetVoiceLength("story_v_out_421071", "421071026", "story_v_out_421071.awb") / 1000

					if var_112_18 + var_112_11 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_18 + var_112_11
					end

					if var_112_14.prefab_name ~= "" and arg_109_1.actors_[var_112_14.prefab_name] ~= nil then
						local var_112_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_14.prefab_name].transform, "story_v_out_421071", "421071026", "story_v_out_421071.awb")

						arg_109_1:RecordAudio("421071026", var_112_19)
						arg_109_1:RecordAudio("421071026", var_112_19)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_421071", "421071026", "story_v_out_421071.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_421071", "421071026", "story_v_out_421071.awb")
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
	Play421071027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 421071027
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play421071028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.175

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(421071027).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 7 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 7)

				if (7 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 7)) > 0 and var_118_0 < var_118_3 then
					arg_115_1.talkMaxDuration = var_118_3

					if var_118_3 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_3 + 0
					end
				end

				arg_115_1.text_.text = var_118_1
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_4 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_4

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play421071028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 421071028
		arg_119_1.duration_ = 2.5

		local var_119_0 = {
			zh = 2.466,
			ja = 2.5
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
				arg_119_0:Play421071029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if arg_119_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_122_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_119_1.stage_.transform)

				var_122_0.name = "10102ui_story"
				var_122_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_["10102ui_story"] = var_122_0

				local var_122_1 = var_122_0:GetComponentInChildren(typeof(CharacterEffect))

				var_122_1.enabled = true

				local var_122_2 = GameObjectTools.GetOrAddComponent(var_122_0, typeof(DynamicBoneHelper))

				if var_122_2 then
					var_122_2:EnableDynamicBone(false)
				end

				arg_119_1:ShowWeapon(var_122_1.transform, false)

				arg_119_1.var_["10102ui_story" .. "Animator"] = var_122_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_119_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_119_1.var_["10102ui_story" .. "LipSync"] = var_122_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_122_3 = arg_119_1.actors_["10102ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10102ui_story = var_122_3.localPosition
			end

			local var_122_4 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				var_122_3.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_119_1.time_ - 0) / var_122_4)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				var_122_3.localPosition = Vector3.New(0, -0.985, -6.275)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			local var_122_5 = arg_119_1.actors_["10102ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect10102ui_story == nil then
				arg_119_1.var_.characterEffect10102ui_story = var_122_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_6 and not isNil(var_122_5) then
				if arg_119_1.var_.characterEffect10102ui_story and not isNil(var_122_5) then
					arg_119_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_6 and arg_119_1.time_ < 0 + var_122_6 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect10102ui_story then
				arg_119_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_122_8 = 0
			local var_122_9 = 0.25

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_10 = arg_119_1:GetWordFromCfg(421071028)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 10 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 10)

				if (10 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 10)) > 0 and var_122_9 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071028", "story_v_out_421071.awb") ~= 0 then
					local var_122_14 = manager.audio:GetVoiceLength("story_v_out_421071", "421071028", "story_v_out_421071.awb") / 1000

					if var_122_14 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_8
					end

					if var_122_10.prefab_name ~= "" and arg_119_1.actors_[var_122_10.prefab_name] ~= nil then
						local var_122_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_10.prefab_name].transform, "story_v_out_421071", "421071028", "story_v_out_421071.awb")

						arg_119_1:RecordAudio("421071028", var_122_15)
						arg_119_1:RecordAudio("421071028", var_122_15)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_421071", "421071028", "story_v_out_421071.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_421071", "421071028", "story_v_out_421071.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_16 = math.max(var_122_9, arg_119_1.talkMaxDuration)

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_16 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_8) / var_122_16

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_8 + var_122_16 and arg_119_1.time_ < var_122_8 + var_122_16 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421071029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 421071029
		arg_123_1.duration_ = 8.63

		local var_123_0 = {
			zh = 5.8,
			ja = 8.633
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
				arg_123_0:Play421071030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.actors_["10145ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10145ui_story"))) then
				local var_126_0 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_123_1.stage_.transform)

				var_126_0.name = "10145ui_story"
				var_126_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["10145ui_story"] = var_126_0

				local var_126_1 = var_126_0:GetComponentInChildren(typeof(CharacterEffect))

				var_126_1.enabled = true

				local var_126_2 = GameObjectTools.GetOrAddComponent(var_126_0, typeof(DynamicBoneHelper))

				if var_126_2 then
					var_126_2:EnableDynamicBone(false)
				end

				arg_123_1:ShowWeapon(var_126_1.transform, false)

				arg_123_1.var_["10145ui_story" .. "Animator"] = var_126_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_123_1.var_["10145ui_story" .. "Animator"].applyRootMotion = true
				arg_123_1.var_["10145ui_story" .. "LipSync"] = var_126_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_126_3 = arg_123_1.actors_["10145ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10145ui_story = var_126_3.localPosition
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_3.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_123_1.time_ - 0) / var_126_4)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_3.localPosition = Vector3.New(0.78, -1, -6.2)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles
			end

			local var_126_5 = arg_123_1.actors_["10102ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10102ui_story = var_126_5.localPosition
			end

			local var_126_6 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 then
				var_126_5.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_123_1.time_ - 0) / var_126_6)
				var_126_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_5.position).x, (manager.ui.mainCamera.transform.position - var_126_5.position).y, (manager.ui.mainCamera.transform.position - var_126_5.position).z)
				var_126_5.localEulerAngles.z = 0
				var_126_5.localEulerAngles.x = 0
				var_126_5.localEulerAngles = var_126_5.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 then
				var_126_5.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				var_126_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_5.position).x, (manager.ui.mainCamera.transform.position - var_126_5.position).y, (manager.ui.mainCamera.transform.position - var_126_5.position).z)
				var_126_5.localEulerAngles.z = 0
				var_126_5.localEulerAngles.x = 0
				var_126_5.localEulerAngles = var_126_5.localEulerAngles
			end

			local var_126_7 = arg_123_1.actors_["10145ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.characterEffect10145ui_story == nil then
				arg_123_1.var_.characterEffect10145ui_story = var_126_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_8 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_8 and not isNil(var_126_7) then
				if arg_123_1.var_.characterEffect10145ui_story and not isNil(var_126_7) then
					arg_123_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_8 and arg_123_1.time_ < 0 + var_126_8 + arg_126_0 and not isNil(var_126_7) and arg_123_1.var_.characterEffect10145ui_story then
				arg_123_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_126_10 = arg_123_1.actors_["10102ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_10) and arg_123_1.var_.characterEffect10102ui_story == nil then
				arg_123_1.var_.characterEffect10102ui_story = var_126_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_11 and not isNil(var_126_10) then
				if arg_123_1.var_.characterEffect10102ui_story and not isNil(var_126_10) then
					arg_123_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_11)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_11 and arg_123_1.time_ < 0 + var_126_11 + arg_126_0 and not isNil(var_126_10) and arg_123_1.var_.characterEffect10102ui_story then
				arg_123_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_126_12 = 0
			local var_126_13 = 0.75

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_12 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_14 = arg_123_1:GetWordFromCfg(421071029)
				local var_126_15 = arg_123_1:FormatText(var_126_14.content)

				arg_123_1.text_.text = var_126_15

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_17 = 30 <= 0 and var_126_13 or var_126_13 * (utf8.len(var_126_15) / 30)

				if (30 <= 0 and var_126_13 or var_126_13 * (utf8.len(var_126_15) / 30)) > 0 and var_126_13 < var_126_17 then
					arg_123_1.talkMaxDuration = var_126_17

					if var_126_17 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_17 + var_126_12
					end
				end

				arg_123_1.text_.text = var_126_15
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071029", "story_v_out_421071.awb") ~= 0 then
					local var_126_18 = manager.audio:GetVoiceLength("story_v_out_421071", "421071029", "story_v_out_421071.awb") / 1000

					if var_126_18 + var_126_12 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_18 + var_126_12
					end

					if var_126_14.prefab_name ~= "" and arg_123_1.actors_[var_126_14.prefab_name] ~= nil then
						local var_126_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_14.prefab_name].transform, "story_v_out_421071", "421071029", "story_v_out_421071.awb")

						arg_123_1:RecordAudio("421071029", var_126_19)
						arg_123_1:RecordAudio("421071029", var_126_19)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_421071", "421071029", "story_v_out_421071.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_421071", "421071029", "story_v_out_421071.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_20 = math.max(var_126_13, arg_123_1.talkMaxDuration)

			if var_126_12 <= arg_123_1.time_ and arg_123_1.time_ < var_126_12 + var_126_20 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_12) / var_126_20

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_12 + var_126_20 and arg_123_1.time_ < var_126_12 + var_126_20 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421071030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 421071030
		arg_127_1.duration_ = 3.57

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play421071031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10102ui_story = arg_127_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["10102ui_story"].transform.position).z)
				arg_127_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["10102ui_story"].transform.localEulerAngles = arg_127_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_127_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["10102ui_story"].transform.position).z)
				arg_127_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["10102ui_story"].transform.localEulerAngles = arg_127_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["10102ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10102ui_story == nil then
				arg_127_1.var_.characterEffect10102ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect10102ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10102ui_story then
				arg_127_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_130_4 = arg_127_1.actors_["10145ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect10145ui_story == nil then
				arg_127_1.var_.characterEffect10145ui_story = var_130_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_5 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_5 and not isNil(var_130_4) then
				if arg_127_1.var_.characterEffect10145ui_story and not isNil(var_130_4) then
					arg_127_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_5)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_5 and arg_127_1.time_ < 0 + var_130_5 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect10145ui_story then
				arg_127_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_130_6 = 0
			local var_130_7 = 0.35

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:GetWordFromCfg(421071030)
				local var_130_9 = arg_127_1:FormatText(var_130_8.content)

				arg_127_1.text_.text = var_130_9

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 14 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 14)

				if (14 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 14)) > 0 and var_130_7 < var_130_11 then
					arg_127_1.talkMaxDuration = var_130_11

					if var_130_11 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_9
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071030", "story_v_out_421071.awb") ~= 0 then
					local var_130_12 = manager.audio:GetVoiceLength("story_v_out_421071", "421071030", "story_v_out_421071.awb") / 1000

					if var_130_12 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_6
					end

					if var_130_8.prefab_name ~= "" and arg_127_1.actors_[var_130_8.prefab_name] ~= nil then
						local var_130_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_8.prefab_name].transform, "story_v_out_421071", "421071030", "story_v_out_421071.awb")

						arg_127_1:RecordAudio("421071030", var_130_13)
						arg_127_1:RecordAudio("421071030", var_130_13)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_421071", "421071030", "story_v_out_421071.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_421071", "421071030", "story_v_out_421071.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play421071031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 421071031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play421071032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["10102ui_story"]) and arg_131_1.var_.characterEffect10102ui_story == nil then
				arg_131_1.var_.characterEffect10102ui_story = arg_131_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["10102ui_story"]) then
				if arg_131_1.var_.characterEffect10102ui_story and not isNil(arg_131_1.actors_["10102ui_story"]) then
					arg_131_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["10102ui_story"]) and arg_131_1.var_.characterEffect10102ui_story then
				arg_131_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_134_1 = 0
			local var_134_2 = 0.625

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(421071031).content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 25 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 25)

				if (25 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 25)) > 0 and var_134_2 < var_134_5 then
					arg_131_1.talkMaxDuration = var_134_5

					if var_134_5 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + var_134_1
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_6 = math.max(var_134_2, arg_131_1.talkMaxDuration)

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_6 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_1) / var_134_6

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_1 + var_134_6 and arg_131_1.time_ < var_134_1 + var_134_6 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play421071032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 421071032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play421071033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10102ui_story = arg_135_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10102ui_story"].transform.position).z)
				arg_135_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10102ui_story"].transform.localEulerAngles = arg_135_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10102ui_story"].transform.position).z)
				arg_135_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10102ui_story"].transform.localEulerAngles = arg_135_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["10145ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10145ui_story = var_138_1.localPosition
			end

			local var_138_2 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 then
				var_138_1.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_2)
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
			local var_138_4 = 0.8

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

				local var_138_5 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(421071032).content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 32 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_5) / 32)

				if (32 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_5) / 32)) > 0 and var_138_4 < var_138_7 then
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
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421071033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 421071033
		arg_139_1.duration_ = 9.23

		local var_139_0 = {
			zh = 8.1,
			ja = 9.233
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
				arg_139_0:Play421071034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10145ui_story = arg_139_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10145ui_story"].transform.position).z)
				arg_139_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10145ui_story"].transform.localEulerAngles = arg_139_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_139_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10145ui_story"].transform.position).z)
				arg_139_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10145ui_story"].transform.localEulerAngles = arg_139_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["10145ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10145ui_story == nil then
				arg_139_1.var_.characterEffect10145ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect10145ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10145ui_story then
				arg_139_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_142_4 = 0
			local var_142_5 = 0.775

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(421071033)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 31 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 31)

				if (31 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 31)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071033", "story_v_out_421071.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_out_421071", "421071033", "story_v_out_421071.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_out_421071", "421071033", "story_v_out_421071.awb")

						arg_139_1:RecordAudio("421071033", var_142_11)
						arg_139_1:RecordAudio("421071033", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_421071", "421071033", "story_v_out_421071.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_421071", "421071033", "story_v_out_421071.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_12 and arg_139_1.time_ < var_142_4 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421071034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 421071034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play421071035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10145ui_story = arg_143_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10145ui_story"].transform.position).z)
				arg_143_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10145ui_story"].transform.localEulerAngles = arg_143_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10145ui_story"].transform.position).z)
				arg_143_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10145ui_story"].transform.localEulerAngles = arg_143_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["10145ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10145ui_story == nil then
				arg_143_1.var_.characterEffect10145ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect10145ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_2)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10145ui_story then
				arg_143_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_146_3 = 0
			local var_146_4 = 1.425

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_3 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_5 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(421071034).content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 57 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_5) / 57)

				if (57 <= 0 and var_146_4 or var_146_4 * (utf8.len(var_146_5) / 57)) > 0 and var_146_4 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_3 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_3
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_4, arg_143_1.talkMaxDuration)

			if var_146_3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_3 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_3) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_3 + var_146_8 and arg_143_1.time_ < var_146_3 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421071035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 421071035
		arg_147_1.duration_ = 2

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play421071036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10145ui_story = arg_147_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10145ui_story"].transform.position).z)
				arg_147_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["10145ui_story"].transform.localEulerAngles = arg_147_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_147_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10145ui_story"].transform.position).z)
				arg_147_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["10145ui_story"].transform.localEulerAngles = arg_147_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["10145ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect10145ui_story == nil then
				arg_147_1.var_.characterEffect10145ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect10145ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect10145ui_story then
				arg_147_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_2")
			end

			local var_150_4 = 0
			local var_150_5 = 0.325

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(421071035)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 13 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 13)

				if (13 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 13)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071035", "story_v_out_421071.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_421071", "421071035", "story_v_out_421071.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_out_421071", "421071035", "story_v_out_421071.awb")

						arg_147_1:RecordAudio("421071035", var_150_11)
						arg_147_1:RecordAudio("421071035", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_421071", "421071035", "story_v_out_421071.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_421071", "421071035", "story_v_out_421071.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421071036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 421071036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play421071037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10145ui_story = arg_151_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10145ui_story"].transform.position).z)
				arg_151_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10145ui_story"].transform.localEulerAngles = arg_151_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10145ui_story"].transform.position).z)
				arg_151_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10145ui_story"].transform.localEulerAngles = arg_151_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["10145ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10145ui_story == nil then
				arg_151_1.var_.characterEffect10145ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect10145ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_2)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10145ui_story then
				arg_151_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_154_3 = 0
			local var_154_4 = 1.6

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_3 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_5 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(421071036).content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 64 <= 0 and var_154_4 or var_154_4 * (utf8.len(var_154_5) / 64)

				if (64 <= 0 and var_154_4 or var_154_4 * (utf8.len(var_154_5) / 64)) > 0 and var_154_4 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_3 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_3
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_8 = math.max(var_154_4, arg_151_1.talkMaxDuration)

			if var_154_3 <= arg_151_1.time_ and arg_151_1.time_ < var_154_3 + var_154_8 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_3) / var_154_8

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_3 + var_154_8 and arg_151_1.time_ < var_154_3 + var_154_8 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421071037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 421071037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play421071038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10145ui_story"]) and arg_155_1.var_.characterEffect10145ui_story == nil then
				arg_155_1.var_.characterEffect10145ui_story = arg_155_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10145ui_story"]) then
				if arg_155_1.var_.characterEffect10145ui_story and not isNil(arg_155_1.actors_["10145ui_story"]) then
					arg_155_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10145ui_story"]) and arg_155_1.var_.characterEffect10145ui_story then
				arg_155_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_158_1 = 0
			local var_158_2 = 0.075

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(421071037).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 3 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 3)

				if (3 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 3)) > 0 and var_158_2 < var_158_5 then
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
	Play421071038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 421071038
		arg_159_1.duration_ = 5.07

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play421071039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_9000

			if 1.23333333333333 < arg_159_1.time_ and arg_159_1.time_ <= 1.23333333333333 + arg_162_0 then
				local var_162_0 = arg_159_1.var_.effect1038

				if not arg_159_1.var_.effect1038 then
					var_162_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xdaoguang"), manager.ui.mainCamera.transform)
					var_162_0.name = "1038"
					arg_159_1.var_.effect1038 = var_162_0
				else
					var_162_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_162_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_162_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.7 < arg_159_1.time_ and arg_159_1.time_ <= 4.7 + arg_162_0 then
				if arg_159_1.var_.effect1038 then
					Object.Destroy(arg_159_1.var_.effect1038)

					arg_159_1.var_.effect1038 = nil
				end
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:AudioAction("play", "effect", "se_story_143", "se_story_143_gun", "")
			end

			if 1.83333333333333 < arg_159_1.time_ and arg_159_1.time_ <= 1.83333333333333 + arg_162_0 then
				local var_162_4 = arg_159_1.var_.effect10381

				if not arg_159_1.var_.effect10381 then
					var_162_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_162_4.name = "10381"
					arg_159_1.var_.effect10381 = var_162_4
				else
					var_162_4.transform:SetParent(var_162_9000)
				end

				var_162_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_162_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.7 < arg_159_1.time_ and arg_159_1.time_ <= 4.7 + arg_162_0 then
				if arg_159_1.var_.effect10381 then
					Object.Destroy(arg_159_1.var_.effect10381)

					arg_159_1.var_.effect10381 = nil
				end
			end

			local var_162_7 = 0
			local var_162_8 = 1.425

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_9 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(421071038).content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 57 <= 0 and var_162_8 or var_162_8 * (utf8.len(var_162_9) / 57)

				if (57 <= 0 and var_162_8 or var_162_8 * (utf8.len(var_162_9) / 57)) > 0 and var_162_8 < var_162_11 then
					arg_159_1.talkMaxDuration = var_162_11

					if var_162_11 + var_162_7 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_7
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_8, arg_159_1.talkMaxDuration)

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_7) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_7 + var_162_12 and arg_159_1.time_ < var_162_7 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play421071039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 421071039
		arg_163_1.duration_ = 6.3

		local var_163_0 = {
			zh = 5.266,
			ja = 6.3
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play421071040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if arg_163_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_166_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_163_1.stage_.transform)

				var_166_0.name = "1047ui_story"
				var_166_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["1047ui_story"] = var_166_0

				local var_166_1 = var_166_0:GetComponentInChildren(typeof(CharacterEffect))

				var_166_1.enabled = true

				local var_166_2 = GameObjectTools.GetOrAddComponent(var_166_0, typeof(DynamicBoneHelper))

				if var_166_2 then
					var_166_2:EnableDynamicBone(false)
				end

				arg_163_1:ShowWeapon(var_166_1.transform, false)

				arg_163_1.var_["1047ui_story" .. "Animator"] = var_166_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_163_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_163_1.var_["1047ui_story" .. "LipSync"] = var_166_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_166_3 = arg_163_1.actors_["1047ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1047ui_story = var_166_3.localPosition
			end

			local var_166_4 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				var_166_3.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_163_1.time_ - 0) / var_166_4)
				var_166_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_3.position).x, (manager.ui.mainCamera.transform.position - var_166_3.position).y, (manager.ui.mainCamera.transform.position - var_166_3.position).z)
				var_166_3.localEulerAngles.z = 0
				var_166_3.localEulerAngles.x = 0
				var_166_3.localEulerAngles = var_166_3.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				var_166_3.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_166_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_3.position).x, (manager.ui.mainCamera.transform.position - var_166_3.position).y, (manager.ui.mainCamera.transform.position - var_166_3.position).z)
				var_166_3.localEulerAngles.z = 0
				var_166_3.localEulerAngles.x = 0
				var_166_3.localEulerAngles = var_166_3.localEulerAngles
			end

			local var_166_5 = arg_163_1.actors_["1047ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.characterEffect1047ui_story == nil then
				arg_163_1.var_.characterEffect1047ui_story = var_166_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_6 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_6 and not isNil(var_166_5) then
				if arg_163_1.var_.characterEffect1047ui_story and not isNil(var_166_5) then
					arg_163_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_6 and arg_163_1.time_ < 0 + var_166_6 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.characterEffect1047ui_story then
				arg_163_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_166_8 = 0
			local var_166_9 = 0.6

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(421071039)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 24 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 24)

				if (24 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 24)) > 0 and var_166_9 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071039", "story_v_out_421071.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_421071", "421071039", "story_v_out_421071.awb") / 1000

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end

					if var_166_10.prefab_name ~= "" and arg_163_1.actors_[var_166_10.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_10.prefab_name].transform, "story_v_out_421071", "421071039", "story_v_out_421071.awb")

						arg_163_1:RecordAudio("421071039", var_166_15)
						arg_163_1:RecordAudio("421071039", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_421071", "421071039", "story_v_out_421071.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_421071", "421071039", "story_v_out_421071.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_9, arg_163_1.talkMaxDuration)

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_8) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_8 + var_166_16 and arg_163_1.time_ < var_166_8 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play421071040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 421071040
		arg_167_1.duration_ = 2

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
			arg_167_1.auto_ = false
		end

		function arg_167_1.playNext_(arg_169_0)
			arg_167_1.onStoryFinished_()
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if arg_167_1.actors_["10143ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10143ui_story"))) then
				local var_170_0 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_167_1.stage_.transform)

				var_170_0.name = "10143ui_story"
				var_170_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.actors_["10143ui_story"] = var_170_0

				local var_170_1 = var_170_0:GetComponentInChildren(typeof(CharacterEffect))

				var_170_1.enabled = true

				local var_170_2 = GameObjectTools.GetOrAddComponent(var_170_0, typeof(DynamicBoneHelper))

				if var_170_2 then
					var_170_2:EnableDynamicBone(false)
				end

				arg_167_1:ShowWeapon(var_170_1.transform, false)

				arg_167_1.var_["10143ui_story" .. "Animator"] = var_170_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_167_1.var_["10143ui_story" .. "Animator"].applyRootMotion = true
				arg_167_1.var_["10143ui_story" .. "LipSync"] = var_170_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_170_3 = arg_167_1.actors_["10143ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10143ui_story = var_170_3.localPosition
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_3.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_167_1.time_ - 0) / var_170_4)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_3.localPosition = Vector3.New(0.78, -1.06, -6)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			local var_170_5 = arg_167_1.actors_["10143ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect10143ui_story == nil then
				arg_167_1.var_.characterEffect10143ui_story = var_170_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_6 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 and not isNil(var_170_5) then
				if arg_167_1.var_.characterEffect10143ui_story and not isNil(var_170_5) then
					arg_167_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect10143ui_story then
				arg_167_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_170_8 = arg_167_1.actors_["1047ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.characterEffect1047ui_story == nil then
				arg_167_1.var_.characterEffect1047ui_story = var_170_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_9 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_9 and not isNil(var_170_8) then
				if arg_167_1.var_.characterEffect1047ui_story and not isNil(var_170_8) then
					arg_167_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_9)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_9 and arg_167_1.time_ < 0 + var_170_9 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.characterEffect1047ui_story then
				arg_167_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action1_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_170_10 = 0
			local var_170_11 = 0.1

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_12 = arg_167_1:GetWordFromCfg(421071040)
				local var_170_13 = arg_167_1:FormatText(var_170_12.content)

				arg_167_1.text_.text = var_170_13

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_15 = 4 <= 0 and var_170_11 or var_170_11 * (utf8.len(var_170_13) / 4)

				if (4 <= 0 and var_170_11 or var_170_11 * (utf8.len(var_170_13) / 4)) > 0 and var_170_11 < var_170_15 then
					arg_167_1.talkMaxDuration = var_170_15

					if var_170_15 + var_170_10 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_15 + var_170_10
					end
				end

				arg_167_1.text_.text = var_170_13
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421071", "421071040", "story_v_out_421071.awb") ~= 0 then
					local var_170_16 = manager.audio:GetVoiceLength("story_v_out_421071", "421071040", "story_v_out_421071.awb") / 1000

					if var_170_16 + var_170_10 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_16 + var_170_10
					end

					if var_170_12.prefab_name ~= "" and arg_167_1.actors_[var_170_12.prefab_name] ~= nil then
						local var_170_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_12.prefab_name].transform, "story_v_out_421071", "421071040", "story_v_out_421071.awb")

						arg_167_1:RecordAudio("421071040", var_170_17)
						arg_167_1:RecordAudio("421071040", var_170_17)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_421071", "421071040", "story_v_out_421071.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_421071", "421071040", "story_v_out_421071.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_18 = math.max(var_170_11, arg_167_1.talkMaxDuration)

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_18 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_10) / var_170_18

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_10 + var_170_18 and arg_167_1.time_ < var_170_10 + var_170_18 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
	assets = {
		"TextureConfig/Background/I08a",
		"TextureConfig/Background/D10"
	},
	voices = {
		"story_v_out_421071.awb"
	}
}
