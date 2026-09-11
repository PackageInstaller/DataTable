return {
	Play421111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421111001
		arg_1_1.duration_ = 8.63

		local var_1_0 = {
			zh = 6,
			ja = 8.633
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
				arg_1_0:Play421111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0110a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0110a")
				var_4_0.name = "ST0110a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0110a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0110a

				arg_1_1.bgs_.ST0110a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0110a" then
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
				arg_1_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_city_street", "")
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_4_3_story_city", "bgm_activity_4_3_story_city")

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
			local var_4_17 = 0.575

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1315].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow20302")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(421111001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 23 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 23)

				if (23 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 23)) > 0 and var_4_17 < var_4_22 then
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

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111001", "story_v_out_421111.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_421111", "421111001", "story_v_out_421111.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_421111", "421111001", "story_v_out_421111.awb")

						arg_1_1:RecordAudio("421111001", var_4_24)
						arg_1_1:RecordAudio("421111001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_421111", "421111001", "story_v_out_421111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_421111", "421111001", "story_v_out_421111.awb")
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
	Play421111002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421111002
		arg_9_1.duration_ = 7.97

		local var_9_0 = {
			zh = 4.233,
			ja = 7.966
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
				arg_9_0:Play421111003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.55

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1313].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_shadowcitizenma")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(421111002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 22 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 22)

				if (22 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 22)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111002", "story_v_out_421111.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_421111", "421111002", "story_v_out_421111.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_421111", "421111002", "story_v_out_421111.awb")

						arg_9_1:RecordAudio("421111002", var_12_6)
						arg_9_1:RecordAudio("421111002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_421111", "421111002", "story_v_out_421111.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_421111", "421111002", "story_v_out_421111.awb")
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
	Play421111003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421111003
		arg_13_1.duration_ = 5.13

		local var_13_0 = {
			zh = 2.833,
			ja = 5.133
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
				arg_13_0:Play421111004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.3

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1315].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow20302")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(421111003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 12 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 12)

				if (12 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 12)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111003", "story_v_out_421111.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_421111", "421111003", "story_v_out_421111.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_421111", "421111003", "story_v_out_421111.awb")

						arg_13_1:RecordAudio("421111003", var_16_6)
						arg_13_1:RecordAudio("421111003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_421111", "421111003", "story_v_out_421111.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_421111", "421111003", "story_v_out_421111.awb")
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
	Play421111004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421111004
		arg_17_1.duration_ = 3.47

		local var_17_0 = {
			zh = 2.433,
			ja = 3.466
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
				arg_17_0:Play421111005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1313].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_shadowcitizenma")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(421111004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 10 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 10)

				if (10 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 10)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111004", "story_v_out_421111.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_421111", "421111004", "story_v_out_421111.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_421111", "421111004", "story_v_out_421111.awb")

						arg_17_1:RecordAudio("421111004", var_20_6)
						arg_17_1:RecordAudio("421111004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_421111", "421111004", "story_v_out_421111.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_421111", "421111004", "story_v_out_421111.awb")
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
	Play421111005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 421111005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play421111006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.2

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(421111005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 8 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 8)

				if (8 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 8)) > 0 and var_24_0 < var_24_3 then
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
	Play421111006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 421111006
		arg_25_1.duration_ = 5.27

		local var_25_0 = {
			zh = 2.533,
			ja = 5.266
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
				arg_25_0:Play421111007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.325

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1315].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_shadowcitizenma")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(421111006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 13 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 13)

				if (13 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 13)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111006", "story_v_out_421111.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_421111", "421111006", "story_v_out_421111.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_421111", "421111006", "story_v_out_421111.awb")

						arg_25_1:RecordAudio("421111006", var_28_6)
						arg_25_1:RecordAudio("421111006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_421111", "421111006", "story_v_out_421111.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_421111", "421111006", "story_v_out_421111.awb")
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
	Play421111007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 421111007
		arg_29_1.duration_ = 3.67

		local var_29_0 = {
			zh = 3.233,
			ja = 3.666
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
				arg_29_0:Play421111008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1047ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1047ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1047ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1047ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["1047ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1047ui_story = var_32_3.localPosition

				arg_29_1:ShowWeapon(arg_29_1.var_["1047ui_story" .. "Animator"].transform, false)
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["1047ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1047ui_story == nil then
				arg_29_1.var_.characterEffect1047ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect1047ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1047ui_story then
				arg_29_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_32_8 = 0
			local var_32_9 = 0.25

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(421111007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 10 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 10)

				if (10 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 10)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111007", "story_v_out_421111.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_421111", "421111007", "story_v_out_421111.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_421111", "421111007", "story_v_out_421111.awb")

						arg_29_1:RecordAudio("421111007", var_32_15)
						arg_29_1:RecordAudio("421111007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_421111", "421111007", "story_v_out_421111.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_421111", "421111007", "story_v_out_421111.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play421111008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 421111008
		arg_33_1.duration_ = 5.23

		local var_33_0 = {
			zh = 4.233,
			ja = 5.233
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
				arg_33_0:Play421111009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1047ui_story"]) and arg_33_1.var_.characterEffect1047ui_story == nil then
				arg_33_1.var_.characterEffect1047ui_story = arg_33_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1047ui_story"]) then
				if arg_33_1.var_.characterEffect1047ui_story and not isNil(arg_33_1.actors_["1047ui_story"]) then
					arg_33_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1047ui_story"]) and arg_33_1.var_.characterEffect1047ui_story then
				arg_33_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.425

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1313].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_shadowcitizenma")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(421111008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 17 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 17)

				if (17 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 17)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111008", "story_v_out_421111.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_421111", "421111008", "story_v_out_421111.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_421111", "421111008", "story_v_out_421111.awb")

						arg_33_1:RecordAudio("421111008", var_36_8)
						arg_33_1:RecordAudio("421111008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_421111", "421111008", "story_v_out_421111.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_421111", "421111008", "story_v_out_421111.awb")
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
	Play421111009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 421111009
		arg_37_1.duration_ = 4.9

		local var_37_0 = {
			zh = 3.4,
			ja = 4.9
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
				arg_37_0:Play421111010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1047ui_story = arg_37_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).z)
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles = arg_37_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_37_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).z)
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles = arg_37_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1047ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1047ui_story == nil then
				arg_37_1.var_.characterEffect1047ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1047ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1047ui_story then
				arg_37_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_40_4 = 0
			local var_40_5 = 0.4

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(421111009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 16 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 16)

				if (16 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 16)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111009", "story_v_out_421111.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111009", "story_v_out_421111.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_421111", "421111009", "story_v_out_421111.awb")

						arg_37_1:RecordAudio("421111009", var_40_11)
						arg_37_1:RecordAudio("421111009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_421111", "421111009", "story_v_out_421111.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_421111", "421111009", "story_v_out_421111.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play421111010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 421111010
		arg_41_1.duration_ = 8.2

		local var_41_0 = {
			zh = 4.7,
			ja = 8.2
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
				arg_41_0:Play421111011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1047ui_story = arg_41_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1047ui_story"].transform.position).z)
				arg_41_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1047ui_story"].transform.localEulerAngles = arg_41_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1047ui_story"].transform.position).z)
				arg_41_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1047ui_story"].transform.localEulerAngles = arg_41_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_44_1 = 0
			local var_44_2 = 0.675

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(421111010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 27 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 27)

				if (27 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 27)) > 0 and var_44_2 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111010", "story_v_out_421111.awb") ~= 0 then
					local var_44_7 = manager.audio:GetVoiceLength("story_v_out_421111", "421111010", "story_v_out_421111.awb") / 1000

					if var_44_7 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_1
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_421111", "421111010", "story_v_out_421111.awb")

						arg_41_1:RecordAudio("421111010", var_44_8)
						arg_41_1:RecordAudio("421111010", var_44_8)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_421111", "421111010", "story_v_out_421111.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_421111", "421111010", "story_v_out_421111.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_9 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_9 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_9

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_9 and arg_41_1.time_ < var_44_1 + var_44_9 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play421111011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 421111011
		arg_45_1.duration_ = 5.7

		local var_45_0 = {
			zh = 2.133,
			ja = 5.7
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
				arg_45_0:Play421111012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.2

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(421111011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 8 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 8)

				if (8 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 8)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111011", "story_v_out_421111.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_421111", "421111011", "story_v_out_421111.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_421111", "421111011", "story_v_out_421111.awb")

						arg_45_1:RecordAudio("421111011", var_48_6)
						arg_45_1:RecordAudio("421111011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_421111", "421111011", "story_v_out_421111.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_421111", "421111011", "story_v_out_421111.awb")
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
	Play421111012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 421111012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play421111013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0.1 < arg_49_1.time_ and arg_49_1.time_ <= 0.1 + arg_52_0 then
				arg_49_1:AudioAction("play", "effect", "se_story_140", "se_story_140_surround", "")
			end

			local var_52_1 = 0
			local var_52_2 = 1.525

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(421111012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 61 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 61)

				if (61 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 61)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play421111013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 421111013
		arg_53_1.duration_ = 4.9

		local var_53_0 = {
			zh = 3.766,
			ja = 4.9
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play421111014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if arg_53_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_56_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_53_1.stage_.transform)

				var_56_0.name = "10102ui_story"
				var_56_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["10102ui_story"] = var_56_0

				local var_56_1 = var_56_0:GetComponentInChildren(typeof(CharacterEffect))

				var_56_1.enabled = true

				local var_56_2 = GameObjectTools.GetOrAddComponent(var_56_0, typeof(DynamicBoneHelper))

				if var_56_2 then
					var_56_2:EnableDynamicBone(false)
				end

				arg_53_1:ShowWeapon(var_56_1.transform, false)

				arg_53_1.var_["10102ui_story" .. "Animator"] = var_56_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_53_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_53_1.var_["10102ui_story" .. "LipSync"] = var_56_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_56_3 = arg_53_1.actors_["10102ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10102ui_story = var_56_3.localPosition
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_3.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_53_1.time_ - 0) / var_56_4)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_3.localPosition = Vector3.New(0, -0.985, -6.275)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			local var_56_5 = arg_53_1.actors_["10102ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect10102ui_story == nil then
				arg_53_1.var_.characterEffect10102ui_story = var_56_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_6 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.characterEffect10102ui_story and not isNil(var_56_5) then
					arg_53_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect10102ui_story then
				arg_53_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_56_8 = 0
			local var_56_9 = 0.35

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(421111013)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 14 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 14)

				if (14 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 14)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111013", "story_v_out_421111.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_421111", "421111013", "story_v_out_421111.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_421111", "421111013", "story_v_out_421111.awb")

						arg_53_1:RecordAudio("421111013", var_56_15)
						arg_53_1:RecordAudio("421111013", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_421111", "421111013", "story_v_out_421111.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_421111", "421111013", "story_v_out_421111.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_16 and arg_53_1.time_ < var_56_8 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play421111014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 421111014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play421111015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10102ui_story"]) and arg_57_1.var_.characterEffect10102ui_story == nil then
				arg_57_1.var_.characterEffect10102ui_story = arg_57_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10102ui_story"]) then
				if arg_57_1.var_.characterEffect10102ui_story and not isNil(arg_57_1.actors_["10102ui_story"]) then
					arg_57_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10102ui_story"]) and arg_57_1.var_.characterEffect10102ui_story then
				arg_57_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.275

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(421111014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 11 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 11)

				if (11 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 11)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play421111015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 421111015
		arg_61_1.duration_ = 3.03

		local var_61_0 = {
			zh = 3.033,
			ja = 2.8
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
				arg_61_0:Play421111016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10102ui_story = arg_61_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).z)
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles = arg_61_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_61_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10102ui_story"].transform.position).z)
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10102ui_story"].transform.localEulerAngles = arg_61_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["10102ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10102ui_story == nil then
				arg_61_1.var_.characterEffect10102ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect10102ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10102ui_story then
				arg_61_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action4_2")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_64_4 = 0
			local var_64_5 = 0.425

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(421111015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 17 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 17)

				if (17 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 17)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111015", "story_v_out_421111.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111015", "story_v_out_421111.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_421111", "421111015", "story_v_out_421111.awb")

						arg_61_1:RecordAudio("421111015", var_64_11)
						arg_61_1:RecordAudio("421111015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_421111", "421111015", "story_v_out_421111.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_421111", "421111015", "story_v_out_421111.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play421111016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 421111016
		arg_65_1.duration_ = 12.8

		local var_65_0 = {
			zh = 9.033,
			ja = 12.8
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
				arg_65_0:Play421111017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10102ui_story = arg_65_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10102ui_story"].transform.position).z)
				arg_65_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10102ui_story"].transform.localEulerAngles = arg_65_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10102ui_story"].transform.position).z)
				arg_65_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10102ui_story"].transform.localEulerAngles = arg_65_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_68_1 = 0
			local var_68_2 = 0.675

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:GetWordFromCfg(421111016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_6 = 27 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_4) / 27)

				if (27 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_4) / 27)) > 0 and var_68_2 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111016", "story_v_out_421111.awb") ~= 0 then
					local var_68_7 = manager.audio:GetVoiceLength("story_v_out_421111", "421111016", "story_v_out_421111.awb") / 1000

					if var_68_7 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_1
					end

					if var_68_3.prefab_name ~= "" and arg_65_1.actors_[var_68_3.prefab_name] ~= nil then
						local var_68_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_3.prefab_name].transform, "story_v_out_421111", "421111016", "story_v_out_421111.awb")

						arg_65_1:RecordAudio("421111016", var_68_8)
						arg_65_1:RecordAudio("421111016", var_68_8)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_421111", "421111016", "story_v_out_421111.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_421111", "421111016", "story_v_out_421111.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_9 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_9 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_9

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_9 and arg_65_1.time_ < var_68_1 + var_68_9 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play421111017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 421111017
		arg_69_1.duration_ = 2.03

		local var_69_0 = {
			zh = 2.033,
			ja = 1.966
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
				arg_69_0:Play421111018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.2

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1313].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_shadowcitizenma")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:GetWordFromCfg(421111017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 8 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 8)

				if (8 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 8)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111017", "story_v_out_421111.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_421111", "421111017", "story_v_out_421111.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_421111", "421111017", "story_v_out_421111.awb")

						arg_69_1:RecordAudio("421111017", var_72_6)
						arg_69_1:RecordAudio("421111017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_421111", "421111017", "story_v_out_421111.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_421111", "421111017", "story_v_out_421111.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play421111018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 421111018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play421111019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.775

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(421111018).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 31 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 31)

				if (31 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 31)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play421111019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 421111019
		arg_77_1.duration_ = 14.53

		local var_77_0 = {
			zh = 10.566,
			ja = 14.533
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
				arg_77_0:Play421111020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.95

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1324].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(421111019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 38 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 38)

				if (38 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 38)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111019", "story_v_out_421111.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_421111", "421111019", "story_v_out_421111.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_421111", "421111019", "story_v_out_421111.awb")

						arg_77_1:RecordAudio("421111019", var_80_6)
						arg_77_1:RecordAudio("421111019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_421111", "421111019", "story_v_out_421111.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_421111", "421111019", "story_v_out_421111.awb")
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
	Play421111020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 421111020
		arg_81_1.duration_ = 4.6

		local var_81_0 = {
			zh = 4.166,
			ja = 4.6
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play421111021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.375

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1324].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:GetWordFromCfg(421111020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 15 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 15)

				if (15 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 15)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111020", "story_v_out_421111.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_421111", "421111020", "story_v_out_421111.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_421111", "421111020", "story_v_out_421111.awb")

						arg_81_1:RecordAudio("421111020", var_84_6)
						arg_81_1:RecordAudio("421111020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_421111", "421111020", "story_v_out_421111.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_421111", "421111020", "story_v_out_421111.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play421111021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 421111021
		arg_85_1.duration_ = 4.77

		local var_85_0 = {
			zh = 4.766,
			ja = 4.466
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
				arg_85_0:Play421111022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.35

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1324].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:GetWordFromCfg(421111021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 14 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 14)

				if (14 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 14)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111021", "story_v_out_421111.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_421111", "421111021", "story_v_out_421111.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_421111", "421111021", "story_v_out_421111.awb")

						arg_85_1:RecordAudio("421111021", var_88_6)
						arg_85_1:RecordAudio("421111021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_421111", "421111021", "story_v_out_421111.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_421111", "421111021", "story_v_out_421111.awb")
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
	Play421111022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 421111022
		arg_89_1.duration_ = 3.73

		local var_89_0 = {
			zh = 2.2,
			ja = 3.733
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play421111023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.2

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(421111022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 8 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 8)

				if (8 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 8)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111022", "story_v_out_421111.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_421111", "421111022", "story_v_out_421111.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_421111", "421111022", "story_v_out_421111.awb")

						arg_89_1:RecordAudio("421111022", var_92_6)
						arg_89_1:RecordAudio("421111022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_421111", "421111022", "story_v_out_421111.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_421111", "421111022", "story_v_out_421111.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play421111023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 421111023
		arg_93_1.duration_ = 16.97

		local var_93_0 = {
			zh = 14.1,
			ja = 16.966
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
				arg_93_0:Play421111024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.125

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(421111023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 46 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 46)

				if (46 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 46)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111023", "story_v_out_421111.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_421111", "421111023", "story_v_out_421111.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_421111", "421111023", "story_v_out_421111.awb")

						arg_93_1:RecordAudio("421111023", var_96_6)
						arg_93_1:RecordAudio("421111023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_421111", "421111023", "story_v_out_421111.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_421111", "421111023", "story_v_out_421111.awb")
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
	Play421111024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 421111024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play421111025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0.833333333333333 < arg_97_1.time_ and arg_97_1.time_ <= 0.833333333333333 + arg_100_0 then
				arg_97_1:AudioAction("play", "effect", "se_story_141", "se_story_141_footstep_back", "")
			end

			local var_100_1 = 0
			local var_100_2 = 1.15

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(421111024).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 46 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 46)

				if (46 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 46)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play421111025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 421111025
		arg_101_1.duration_ = 16.37

		local var_101_0 = {
			zh = 6.566,
			ja = 16.366
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
				arg_101_0:Play421111026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.55

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(421111025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 22 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 22)

				if (22 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 22)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111025", "story_v_out_421111.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_421111", "421111025", "story_v_out_421111.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_421111", "421111025", "story_v_out_421111.awb")

						arg_101_1:RecordAudio("421111025", var_104_6)
						arg_101_1:RecordAudio("421111025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_421111", "421111025", "story_v_out_421111.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_421111", "421111025", "story_v_out_421111.awb")
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
	Play421111026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 421111026
		arg_105_1.duration_ = 5.87

		local var_105_0 = {
			zh = 5.866,
			ja = 5.833
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
				arg_105_0:Play421111027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1047ui_story = arg_105_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1047ui_story"].transform.position).z)
				arg_105_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1047ui_story"].transform.localEulerAngles = arg_105_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_105_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1047ui_story"].transform.position).z)
				arg_105_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1047ui_story"].transform.localEulerAngles = arg_105_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1047ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1047ui_story == nil then
				arg_105_1.var_.characterEffect1047ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1047ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1047ui_story then
				arg_105_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_108_4 = 0
			local var_108_5 = 0.475

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(421111026)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 19 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 19)

				if (19 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 19)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111026", "story_v_out_421111.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111026", "story_v_out_421111.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_421111", "421111026", "story_v_out_421111.awb")

						arg_105_1:RecordAudio("421111026", var_108_11)
						arg_105_1:RecordAudio("421111026", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_421111", "421111026", "story_v_out_421111.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_421111", "421111026", "story_v_out_421111.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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

		arg_105_1:InitPlayNodeList()
	end,
	Play421111027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 421111027
		arg_109_1.duration_ = 7

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play421111028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 2 < arg_109_1.time_ and arg_109_1.time_ <= 2 + arg_112_0 then
				arg_109_1.allBtn_.enabled = false
			end

			if arg_109_1.time_ >= 2 + 0.3 and arg_109_1.time_ < 2 + 0.3 + arg_112_0 then
				arg_109_1.allBtn_.enabled = true
			end

			if 1 < arg_109_1.time_ and arg_109_1.time_ <= 1 + arg_112_0 then
				local var_112_0 = arg_109_1.bgs_.ST0110a

				arg_109_1.bgs_.ST0110a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_1 = var_112_0:GetComponent("SpriteRenderer")

				if var_112_1 and var_112_1.sprite then
					local var_112_2 = 2 * (var_112_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_0.transform.localScale = Vector3.New(var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, var_112_2 / var_112_1.sprite.bounds.size.y < var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x and var_112_2 * manager.ui.mainCameraCom_.aspect / var_112_1.sprite.bounds.size.x or var_112_2 / var_112_1.sprite.bounds.size.y, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "ST0110a" then
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

			local var_112_11 = arg_109_1.actors_["1047ui_story"].transform

			if 0.965999998152256 < arg_109_1.time_ and arg_109_1.time_ <= 0.965999998152256 + arg_112_0 then
				arg_109_1.var_.moveOldPos1047ui_story = var_112_11.localPosition
			end

			local var_112_12 = 0.001

			if 0.965999998152256 <= arg_109_1.time_ and arg_109_1.time_ < 0.965999998152256 + var_112_12 then
				var_112_11.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0.965999998152256) / var_112_12)
				var_112_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_11.position).x, (manager.ui.mainCamera.transform.position - var_112_11.position).y, (manager.ui.mainCamera.transform.position - var_112_11.position).z)
				var_112_11.localEulerAngles.z = 0
				var_112_11.localEulerAngles.x = 0
				var_112_11.localEulerAngles = var_112_11.localEulerAngles
			end

			if arg_109_1.time_ >= 0.965999998152256 + var_112_12 and arg_109_1.time_ < 0.965999998152256 + var_112_12 + arg_112_0 then
				var_112_11.localPosition = Vector3.New(0, 100, 0)
				var_112_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_11.position).x, (manager.ui.mainCamera.transform.position - var_112_11.position).y, (manager.ui.mainCamera.transform.position - var_112_11.position).z)
				var_112_11.localEulerAngles.z = 0
				var_112_11.localEulerAngles.x = 0
				var_112_11.localEulerAngles = var_112_11.localEulerAngles
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 0.6 < arg_109_1.time_ and arg_109_1.time_ <= 0.6 + arg_112_0 then
				arg_109_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_street_loop", "")
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_15 = 2
			local var_112_16 = 0.35

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_17 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_17:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_18 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(421111027).content)

				arg_109_1.text_.text = var_112_18

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_20 = 14 <= 0 and var_112_16 or var_112_16 * (utf8.len(var_112_18) / 14)

				if (14 <= 0 and var_112_16 or var_112_16 * (utf8.len(var_112_18) / 14)) > 0 and var_112_16 < var_112_20 then
					arg_109_1.talkMaxDuration = var_112_20
					var_112_15 = var_112_15 + 0.3

					if var_112_20 + var_112_15 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_20 + var_112_15
					end
				end

				arg_109_1.text_.text = var_112_18
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_21 = var_112_15 + 0.3
			local var_112_22 = math.max(var_112_16, arg_109_1.talkMaxDuration)

			if var_112_15 + 0.3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_21 + var_112_22 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_21) / var_112_22

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_21 + var_112_22 and arg_109_1.time_ < var_112_21 + var_112_22 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.965999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play421111028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 421111028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play421111029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.725

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(421111028).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 29 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 29)

				if (29 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 29)) > 0 and var_118_0 < var_118_3 then
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
	Play421111029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 421111029
		arg_119_1.duration_ = 3.93

		local var_119_0 = {
			zh = 2.666,
			ja = 3.933
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
				arg_119_0:Play421111030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10102ui_story = arg_119_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10102ui_story"].transform.position).z)
				arg_119_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10102ui_story"].transform.localEulerAngles = arg_119_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_119_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10102ui_story"].transform.position).z)
				arg_119_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10102ui_story"].transform.localEulerAngles = arg_119_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["10102ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10102ui_story == nil then
				arg_119_1.var_.characterEffect10102ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect10102ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10102ui_story then
				arg_119_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_122_4 = 0
			local var_122_5 = 0.375

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
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

				local var_122_6 = arg_119_1:GetWordFromCfg(421111029)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 15 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 15)

				if (15 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 15)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111029", "story_v_out_421111.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111029", "story_v_out_421111.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_out_421111", "421111029", "story_v_out_421111.awb")

						arg_119_1:RecordAudio("421111029", var_122_11)
						arg_119_1:RecordAudio("421111029", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_421111", "421111029", "story_v_out_421111.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_421111", "421111029", "story_v_out_421111.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
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
	Play421111030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 421111030
		arg_123_1.duration_ = 6.7

		local var_123_0 = {
			zh = 5,
			ja = 6.7
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
				arg_123_0:Play421111031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.actors_["10143ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10143ui_story"))) then
				local var_126_0 = Object.Instantiate(Asset.Load("Char/" .. "10143ui_story"), arg_123_1.stage_.transform)

				var_126_0.name = "10143ui_story"
				var_126_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["10143ui_story"] = var_126_0

				local var_126_1 = var_126_0:GetComponentInChildren(typeof(CharacterEffect))

				var_126_1.enabled = true

				local var_126_2 = GameObjectTools.GetOrAddComponent(var_126_0, typeof(DynamicBoneHelper))

				if var_126_2 then
					var_126_2:EnableDynamicBone(false)
				end

				arg_123_1:ShowWeapon(var_126_1.transform, false)

				arg_123_1.var_["10143ui_story" .. "Animator"] = var_126_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_123_1.var_["10143ui_story" .. "Animator"].applyRootMotion = true
				arg_123_1.var_["10143ui_story" .. "LipSync"] = var_126_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_126_3 = arg_123_1.actors_["10143ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10143ui_story = var_126_3.localPosition
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_3.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_123_1.time_ - 0) / var_126_4)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_3.localPosition = Vector3.New(0.78, -1.06, -6)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles
			end

			local var_126_5 = arg_123_1.actors_["10143ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect10143ui_story == nil then
				arg_123_1.var_.characterEffect10143ui_story = var_126_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_6 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 and not isNil(var_126_5) then
				if arg_123_1.var_.characterEffect10143ui_story and not isNil(var_126_5) then
					arg_123_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect10143ui_story then
				arg_123_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_126_8 = arg_123_1.actors_["10102ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.characterEffect10102ui_story == nil then
				arg_123_1.var_.characterEffect10102ui_story = var_126_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_9 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_9 and not isNil(var_126_8) then
				if arg_123_1.var_.characterEffect10102ui_story and not isNil(var_126_8) then
					arg_123_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_9)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_9 and arg_123_1.time_ < 0 + var_126_9 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.characterEffect10102ui_story then
				arg_123_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_126_10 = 0
			local var_126_11 = 0.65

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_12 = arg_123_1:GetWordFromCfg(421111030)
				local var_126_13 = arg_123_1:FormatText(var_126_12.content)

				arg_123_1.text_.text = var_126_13

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_15 = 26 <= 0 and var_126_11 or var_126_11 * (utf8.len(var_126_13) / 26)

				if (26 <= 0 and var_126_11 or var_126_11 * (utf8.len(var_126_13) / 26)) > 0 and var_126_11 < var_126_15 then
					arg_123_1.talkMaxDuration = var_126_15

					if var_126_15 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_10
					end
				end

				arg_123_1.text_.text = var_126_13
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111030", "story_v_out_421111.awb") ~= 0 then
					local var_126_16 = manager.audio:GetVoiceLength("story_v_out_421111", "421111030", "story_v_out_421111.awb") / 1000

					if var_126_16 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_16 + var_126_10
					end

					if var_126_12.prefab_name ~= "" and arg_123_1.actors_[var_126_12.prefab_name] ~= nil then
						local var_126_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_12.prefab_name].transform, "story_v_out_421111", "421111030", "story_v_out_421111.awb")

						arg_123_1:RecordAudio("421111030", var_126_17)
						arg_123_1:RecordAudio("421111030", var_126_17)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_421111", "421111030", "story_v_out_421111.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_421111", "421111030", "story_v_out_421111.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_18 = math.max(var_126_11, arg_123_1.talkMaxDuration)

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_18 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_10) / var_126_18

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_10 + var_126_18 and arg_123_1.time_ < var_126_10 + var_126_18 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play421111031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 421111031
		arg_127_1.duration_ = 10.2

		local var_127_0 = {
			zh = 6.433,
			ja = 10.2
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
				arg_127_0:Play421111032(arg_127_1)
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

			local var_130_4 = arg_127_1.actors_["10143ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect10143ui_story == nil then
				arg_127_1.var_.characterEffect10143ui_story = var_130_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_5 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_5 and not isNil(var_130_4) then
				if arg_127_1.var_.characterEffect10143ui_story and not isNil(var_130_4) then
					arg_127_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_5)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_5 and arg_127_1.time_ < 0 + var_130_5 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect10143ui_story then
				arg_127_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_130_6 = 0
			local var_130_7 = 0.85

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

				local var_130_8 = arg_127_1:GetWordFromCfg(421111031)
				local var_130_9 = arg_127_1:FormatText(var_130_8.content)

				arg_127_1.text_.text = var_130_9

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 34 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 34)

				if (34 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 34)) > 0 and var_130_7 < var_130_11 then
					arg_127_1.talkMaxDuration = var_130_11

					if var_130_11 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_9
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111031", "story_v_out_421111.awb") ~= 0 then
					local var_130_12 = manager.audio:GetVoiceLength("story_v_out_421111", "421111031", "story_v_out_421111.awb") / 1000

					if var_130_12 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_6
					end

					if var_130_8.prefab_name ~= "" and arg_127_1.actors_[var_130_8.prefab_name] ~= nil then
						local var_130_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_8.prefab_name].transform, "story_v_out_421111", "421111031", "story_v_out_421111.awb")

						arg_127_1:RecordAudio("421111031", var_130_13)
						arg_127_1:RecordAudio("421111031", var_130_13)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_421111", "421111031", "story_v_out_421111.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_421111", "421111031", "story_v_out_421111.awb")
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
	Play421111032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 421111032
		arg_131_1.duration_ = 2.9

		local var_131_0 = {
			zh = 2.3,
			ja = 2.9
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
				arg_131_0:Play421111033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10143ui_story = arg_131_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10143ui_story"].transform.position).z)
				arg_131_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["10143ui_story"].transform.localEulerAngles = arg_131_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_131_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["10143ui_story"].transform.position).z)
				arg_131_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["10143ui_story"].transform.localEulerAngles = arg_131_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["10143ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10143ui_story == nil then
				arg_131_1.var_.characterEffect10143ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect10143ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect10143ui_story then
				arg_131_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_134_4 = arg_131_1.actors_["10102ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect10102ui_story == nil then
				arg_131_1.var_.characterEffect10102ui_story = var_134_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_5 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_5 and not isNil(var_134_4) then
				if arg_131_1.var_.characterEffect10102ui_story and not isNil(var_134_4) then
					arg_131_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_5)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_5 and arg_131_1.time_ < 0 + var_134_5 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect10102ui_story then
				arg_131_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_2")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_134_6 = 0
			local var_134_7 = 0.3

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(421111032)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 12 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 12)

				if (12 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 12)) > 0 and var_134_7 < var_134_11 then
					arg_131_1.talkMaxDuration = var_134_11

					if var_134_11 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111032", "story_v_out_421111.awb") ~= 0 then
					local var_134_12 = manager.audio:GetVoiceLength("story_v_out_421111", "421111032", "story_v_out_421111.awb") / 1000

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end

					if var_134_8.prefab_name ~= "" and arg_131_1.actors_[var_134_8.prefab_name] ~= nil then
						local var_134_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_8.prefab_name].transform, "story_v_out_421111", "421111032", "story_v_out_421111.awb")

						arg_131_1:RecordAudio("421111032", var_134_13)
						arg_131_1:RecordAudio("421111032", var_134_13)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_421111", "421111032", "story_v_out_421111.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_421111", "421111032", "story_v_out_421111.awb")
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
				actorName = "10143ui_story",
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
	Play421111033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 421111033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play421111034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10143ui_story"]) and arg_135_1.var_.characterEffect10143ui_story == nil then
				arg_135_1.var_.characterEffect10143ui_story = arg_135_1.actors_["10143ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10143ui_story"]) then
				if arg_135_1.var_.characterEffect10143ui_story and not isNil(arg_135_1.actors_["10143ui_story"]) then
					arg_135_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10143ui_story"]) and arg_135_1.var_.characterEffect10143ui_story then
				arg_135_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_138_1 = 0
			local var_138_2 = 0.325

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(421111033).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 13 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 13)

				if (13 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 13)) > 0 and var_138_2 < var_138_5 then
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
	Play421111034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 421111034
		arg_139_1.duration_ = 6.3

		local var_139_0 = {
			zh = 4.866,
			ja = 6.3
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
				arg_139_0:Play421111035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10143ui_story = arg_139_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10143ui_story"].transform.position).z)
				arg_139_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10143ui_story"].transform.localEulerAngles = arg_139_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10143ui_story"].transform.position).z)
				arg_139_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10143ui_story"].transform.localEulerAngles = arg_139_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["10102ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10102ui_story = var_142_1.localPosition
			end

			local var_142_2 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 then
				var_142_1.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_2)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 then
				var_142_1.localPosition = Vector3.New(0, 100, 0)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			local var_142_3 = arg_139_1.actors_["1047ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1047ui_story = var_142_3.localPosition
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_3.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_139_1.time_ - 0) / var_142_4)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			local var_142_5 = arg_139_1.actors_["1047ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1047ui_story == nil then
				arg_139_1.var_.characterEffect1047ui_story = var_142_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_6 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 and not isNil(var_142_5) then
				if arg_139_1.var_.characterEffect1047ui_story and not isNil(var_142_5) then
					arg_139_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1047ui_story then
				arg_139_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_142_8 = arg_139_1.actors_["10143ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.characterEffect10143ui_story == nil then
				arg_139_1.var_.characterEffect10143ui_story = var_142_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_9 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_9 and not isNil(var_142_8) then
				if arg_139_1.var_.characterEffect10143ui_story and not isNil(var_142_8) then
					arg_139_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_9)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_9 and arg_139_1.time_ < 0 + var_142_9 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.characterEffect10143ui_story then
				arg_139_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_142_10 = 0
			local var_142_11 = 0.475

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_12 = arg_139_1:GetWordFromCfg(421111034)
				local var_142_13 = arg_139_1:FormatText(var_142_12.content)

				arg_139_1.text_.text = var_142_13

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_15 = 19 <= 0 and var_142_11 or var_142_11 * (utf8.len(var_142_13) / 19)

				if (19 <= 0 and var_142_11 or var_142_11 * (utf8.len(var_142_13) / 19)) > 0 and var_142_11 < var_142_15 then
					arg_139_1.talkMaxDuration = var_142_15

					if var_142_15 + var_142_10 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_15 + var_142_10
					end
				end

				arg_139_1.text_.text = var_142_13
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111034", "story_v_out_421111.awb") ~= 0 then
					local var_142_16 = manager.audio:GetVoiceLength("story_v_out_421111", "421111034", "story_v_out_421111.awb") / 1000

					if var_142_16 + var_142_10 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_16 + var_142_10
					end

					if var_142_12.prefab_name ~= "" and arg_139_1.actors_[var_142_12.prefab_name] ~= nil then
						local var_142_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_12.prefab_name].transform, "story_v_out_421111", "421111034", "story_v_out_421111.awb")

						arg_139_1:RecordAudio("421111034", var_142_17)
						arg_139_1:RecordAudio("421111034", var_142_17)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_421111", "421111034", "story_v_out_421111.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_421111", "421111034", "story_v_out_421111.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_18 = math.max(var_142_11, arg_139_1.talkMaxDuration)

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_18 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_10) / var_142_18

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_10 + var_142_18 and arg_139_1.time_ < var_142_10 + var_142_18 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
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
			},
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

		arg_139_1:InitPlayNodeList()
	end,
	Play421111035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 421111035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play421111036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1047ui_story"]) and arg_143_1.var_.characterEffect1047ui_story == nil then
				arg_143_1.var_.characterEffect1047ui_story = arg_143_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1047ui_story"]) then
				if arg_143_1.var_.characterEffect1047ui_story and not isNil(arg_143_1.actors_["1047ui_story"]) then
					arg_143_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1047ui_story"]) and arg_143_1.var_.characterEffect1047ui_story then
				arg_143_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 0.2

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(421111035).content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 8 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 8)

				if (8 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 8)) > 0 and var_146_2 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_6 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_6 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_6

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_6 and arg_143_1.time_ < var_146_1 + var_146_6 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play421111036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 421111036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play421111037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1047ui_story = arg_147_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).z)
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles = arg_147_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1047ui_story"].transform.position).z)
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1047ui_story"].transform.localEulerAngles = arg_147_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_150_1 = 0
			local var_150_2 = 0.775

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(421111036).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 31 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 31)

				if (31 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 31)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play421111037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 421111037
		arg_151_1.duration_ = 2

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play421111038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1047ui_story = arg_151_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1047ui_story"].transform.position).z)
				arg_151_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1047ui_story"].transform.localEulerAngles = arg_151_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_151_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1047ui_story"].transform.position).z)
				arg_151_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1047ui_story"].transform.localEulerAngles = arg_151_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1047ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1047ui_story == nil then
				arg_151_1.var_.characterEffect1047ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1047ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1047ui_story then
				arg_151_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_154_4 = 0
			local var_154_5 = 0.075

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(421111037)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 3 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 3)

				if (3 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 3)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111037", "story_v_out_421111.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111037", "story_v_out_421111.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_out_421111", "421111037", "story_v_out_421111.awb")

						arg_151_1:RecordAudio("421111037", var_154_11)
						arg_151_1:RecordAudio("421111037", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_421111", "421111037", "story_v_out_421111.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_421111", "421111037", "story_v_out_421111.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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

		arg_151_1:InitPlayNodeList()
	end,
	Play421111038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 421111038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play421111039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1047ui_story"]) and arg_155_1.var_.characterEffect1047ui_story == nil then
				arg_155_1.var_.characterEffect1047ui_story = arg_155_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1047ui_story"]) then
				if arg_155_1.var_.characterEffect1047ui_story and not isNil(arg_155_1.actors_["1047ui_story"]) then
					arg_155_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1047ui_story"]) and arg_155_1.var_.characterEffect1047ui_story then
				arg_155_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_158_1 = 0
			local var_158_2 = 0.2

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

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(421111038).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 8 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 8)

				if (8 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 8)) > 0 and var_158_2 < var_158_5 then
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
	Play421111039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 421111039
		arg_159_1.duration_ = 7.27

		local var_159_0 = {
			zh = 5.933,
			ja = 7.266
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
				arg_159_0:Play421111040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1047ui_story = arg_159_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1047ui_story"].transform.position).z)
				arg_159_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1047ui_story"].transform.localEulerAngles = arg_159_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_159_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1047ui_story"].transform.position).z)
				arg_159_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1047ui_story"].transform.localEulerAngles = arg_159_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1047ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1047ui_story == nil then
				arg_159_1.var_.characterEffect1047ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1047ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1047ui_story then
				arg_159_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_162_4 = 0
			local var_162_5 = 0.675

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(421111039)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 28 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 28)

				if (28 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 28)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111039", "story_v_out_421111.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111039", "story_v_out_421111.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_421111", "421111039", "story_v_out_421111.awb")

						arg_159_1:RecordAudio("421111039", var_162_11)
						arg_159_1:RecordAudio("421111039", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_421111", "421111039", "story_v_out_421111.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_421111", "421111039", "story_v_out_421111.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_12 and arg_159_1.time_ < var_162_4 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play421111040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 421111040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play421111041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1047ui_story"]) and arg_163_1.var_.characterEffect1047ui_story == nil then
				arg_163_1.var_.characterEffect1047ui_story = arg_163_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1047ui_story"]) then
				if arg_163_1.var_.characterEffect1047ui_story and not isNil(arg_163_1.actors_["1047ui_story"]) then
					arg_163_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1047ui_story"]) and arg_163_1.var_.characterEffect1047ui_story then
				arg_163_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 1.275

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(421111040).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 51 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 51)

				if (51 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 51)) > 0 and var_166_2 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_6 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_6 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_6

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_6 and arg_163_1.time_ < var_166_1 + var_166_6 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play421111041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 421111041
		arg_167_1.duration_ = 12.17

		local var_167_0 = {
			zh = 6.533,
			ja = 12.166
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
				arg_167_0:Play421111042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1047ui_story = arg_167_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1047ui_story"].transform.position).z)
				arg_167_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1047ui_story"].transform.localEulerAngles = arg_167_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_167_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1047ui_story"].transform.position).z)
				arg_167_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1047ui_story"].transform.localEulerAngles = arg_167_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1047ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1047ui_story == nil then
				arg_167_1.var_.characterEffect1047ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1047ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1047ui_story then
				arg_167_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_170_4 = 0
			local var_170_5 = 0.675

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(421111041)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 27 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 27)

				if (27 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 27)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111041", "story_v_out_421111.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111041", "story_v_out_421111.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_421111", "421111041", "story_v_out_421111.awb")

						arg_167_1:RecordAudio("421111041", var_170_11)
						arg_167_1:RecordAudio("421111041", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_421111", "421111041", "story_v_out_421111.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_421111", "421111041", "story_v_out_421111.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_12 and arg_167_1.time_ < var_170_4 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play421111042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 421111042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play421111043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1047ui_story = arg_171_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1047ui_story"].transform.position).z)
				arg_171_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1047ui_story"].transform.localEulerAngles = arg_171_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1047ui_story"].transform.position).z)
				arg_171_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1047ui_story"].transform.localEulerAngles = arg_171_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_174_1 = 0
			local var_174_2 = 1.275

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(421111042).content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 51 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 51)

				if (51 <= 0 and var_174_2 or var_174_2 * (utf8.len(var_174_3) / 51)) > 0 and var_174_2 < var_174_5 then
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

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play421111043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 421111043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play421111044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.075

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(421111043).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 3 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 3)

				if (3 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 3)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play421111044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 421111044
		arg_179_1.duration_ = 11.97

		local var_179_0 = {
			zh = 8.4,
			ja = 11.966
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
				arg_179_0:Play421111045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if arg_179_1.actors_["10145ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10145ui_story"))) then
				local var_182_0 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_179_1.stage_.transform)

				var_182_0.name = "10145ui_story"
				var_182_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.actors_["10145ui_story"] = var_182_0

				local var_182_1 = var_182_0:GetComponentInChildren(typeof(CharacterEffect))

				var_182_1.enabled = true

				local var_182_2 = GameObjectTools.GetOrAddComponent(var_182_0, typeof(DynamicBoneHelper))

				if var_182_2 then
					var_182_2:EnableDynamicBone(false)
				end

				arg_179_1:ShowWeapon(var_182_1.transform, false)

				arg_179_1.var_["10145ui_story" .. "Animator"] = var_182_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_179_1.var_["10145ui_story" .. "Animator"].applyRootMotion = true
				arg_179_1.var_["10145ui_story" .. "LipSync"] = var_182_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_182_3 = arg_179_1.actors_["10145ui_story"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10145ui_story = var_182_3.localPosition
			end

			local var_182_4 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				var_182_3.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_179_1.time_ - 0) / var_182_4)
				var_182_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_3.position).x, (manager.ui.mainCamera.transform.position - var_182_3.position).y, (manager.ui.mainCamera.transform.position - var_182_3.position).z)
				var_182_3.localEulerAngles.z = 0
				var_182_3.localEulerAngles.x = 0
				var_182_3.localEulerAngles = var_182_3.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				var_182_3.localPosition = Vector3.New(0, -1, -6.2)
				var_182_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_3.position).x, (manager.ui.mainCamera.transform.position - var_182_3.position).y, (manager.ui.mainCamera.transform.position - var_182_3.position).z)
				var_182_3.localEulerAngles.z = 0
				var_182_3.localEulerAngles.x = 0
				var_182_3.localEulerAngles = var_182_3.localEulerAngles
			end

			local var_182_5 = arg_179_1.actors_["10145ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.characterEffect10145ui_story == nil then
				arg_179_1.var_.characterEffect10145ui_story = var_182_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_6 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_6 and not isNil(var_182_5) then
				if arg_179_1.var_.characterEffect10145ui_story and not isNil(var_182_5) then
					arg_179_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_6 and arg_179_1.time_ < 0 + var_182_6 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.characterEffect10145ui_story then
				arg_179_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_182_8 = 0
			local var_182_9 = 1.25

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_8 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_10 = arg_179_1:GetWordFromCfg(421111044)
				local var_182_11 = arg_179_1:FormatText(var_182_10.content)

				arg_179_1.text_.text = var_182_11

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_13 = 50 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 50)

				if (50 <= 0 and var_182_9 or var_182_9 * (utf8.len(var_182_11) / 50)) > 0 and var_182_9 < var_182_13 then
					arg_179_1.talkMaxDuration = var_182_13

					if var_182_13 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_13 + var_182_8
					end
				end

				arg_179_1.text_.text = var_182_11
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111044", "story_v_out_421111.awb") ~= 0 then
					local var_182_14 = manager.audio:GetVoiceLength("story_v_out_421111", "421111044", "story_v_out_421111.awb") / 1000

					if var_182_14 + var_182_8 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_14 + var_182_8
					end

					if var_182_10.prefab_name ~= "" and arg_179_1.actors_[var_182_10.prefab_name] ~= nil then
						local var_182_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_10.prefab_name].transform, "story_v_out_421111", "421111044", "story_v_out_421111.awb")

						arg_179_1:RecordAudio("421111044", var_182_15)
						arg_179_1:RecordAudio("421111044", var_182_15)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_421111", "421111044", "story_v_out_421111.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_421111", "421111044", "story_v_out_421111.awb")
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
				actorName = "10145ui_story",
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
	Play421111045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 421111045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play421111046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["10145ui_story"]) and arg_183_1.var_.characterEffect10145ui_story == nil then
				arg_183_1.var_.characterEffect10145ui_story = arg_183_1.actors_["10145ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["10145ui_story"]) then
				if arg_183_1.var_.characterEffect10145ui_story and not isNil(arg_183_1.actors_["10145ui_story"]) then
					arg_183_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_183_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["10145ui_story"]) and arg_183_1.var_.characterEffect10145ui_story then
				arg_183_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_183_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 0.525

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(421111045).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 21 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 21)

				if (21 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 21)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play421111046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 421111046
		arg_187_1.duration_ = 5.63

		local var_187_0 = {
			zh = 5.5,
			ja = 5.633
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
				arg_187_0:Play421111047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10145ui_story = arg_187_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10145ui_story"].transform.position).z)
				arg_187_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["10145ui_story"].transform.localEulerAngles = arg_187_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_187_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10145ui_story"].transform.position).z)
				arg_187_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["10145ui_story"].transform.localEulerAngles = arg_187_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["10145ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10145ui_story == nil then
				arg_187_1.var_.characterEffect10145ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect10145ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10145ui_story then
				arg_187_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action2_2")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_190_4 = 0
			local var_190_5 = 0.5

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(421111046)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 20 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 20)

				if (20 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 20)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111046", "story_v_out_421111.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111046", "story_v_out_421111.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_421111", "421111046", "story_v_out_421111.awb")

						arg_187_1:RecordAudio("421111046", var_190_11)
						arg_187_1:RecordAudio("421111046", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_421111", "421111046", "story_v_out_421111.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_421111", "421111046", "story_v_out_421111.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_12 and arg_187_1.time_ < var_190_4 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play421111047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 421111047
		arg_191_1.duration_ = 4.37

		local var_191_0 = {
			zh = 3.833,
			ja = 4.366
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play421111048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1047ui_story = arg_191_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1047ui_story"].transform.position).z)
				arg_191_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1047ui_story"].transform.localEulerAngles = arg_191_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_191_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1047ui_story"].transform.position).z)
				arg_191_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1047ui_story"].transform.localEulerAngles = arg_191_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["10145ui_story"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10145ui_story = var_194_1.localPosition
			end

			local var_194_2 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 then
				var_194_1.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_191_1.time_ - 0) / var_194_2)
				var_194_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_1.position).x, (manager.ui.mainCamera.transform.position - var_194_1.position).y, (manager.ui.mainCamera.transform.position - var_194_1.position).z)
				var_194_1.localEulerAngles.z = 0
				var_194_1.localEulerAngles.x = 0
				var_194_1.localEulerAngles = var_194_1.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 then
				var_194_1.localPosition = Vector3.New(-0.65, -1, -6.2)
				var_194_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_1.position).x, (manager.ui.mainCamera.transform.position - var_194_1.position).y, (manager.ui.mainCamera.transform.position - var_194_1.position).z)
				var_194_1.localEulerAngles.z = 0
				var_194_1.localEulerAngles.x = 0
				var_194_1.localEulerAngles = var_194_1.localEulerAngles
			end

			local var_194_3 = arg_191_1.actors_["1047ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect1047ui_story == nil then
				arg_191_1.var_.characterEffect1047ui_story = var_194_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_4 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 and not isNil(var_194_3) then
				if arg_191_1.var_.characterEffect1047ui_story and not isNil(var_194_3) then
					arg_191_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 and not isNil(var_194_3) and arg_191_1.var_.characterEffect1047ui_story then
				arg_191_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_194_6 = arg_191_1.actors_["10145ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_6) and arg_191_1.var_.characterEffect10145ui_story == nil then
				arg_191_1.var_.characterEffect10145ui_story = var_194_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_7 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 and not isNil(var_194_6) then
				if arg_191_1.var_.characterEffect10145ui_story and not isNil(var_194_6) then
					arg_191_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_7)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 and not isNil(var_194_6) and arg_191_1.var_.characterEffect10145ui_story then
				arg_191_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_194_8 = 0
			local var_194_9 = 0.4

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_10 = arg_191_1:GetWordFromCfg(421111047)
				local var_194_11 = arg_191_1:FormatText(var_194_10.content)

				arg_191_1.text_.text = var_194_11

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_13 = 16 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 16)

				if (16 <= 0 and var_194_9 or var_194_9 * (utf8.len(var_194_11) / 16)) > 0 and var_194_9 < var_194_13 then
					arg_191_1.talkMaxDuration = var_194_13

					if var_194_13 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_13 + var_194_8
					end
				end

				arg_191_1.text_.text = var_194_11
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111047", "story_v_out_421111.awb") ~= 0 then
					local var_194_14 = manager.audio:GetVoiceLength("story_v_out_421111", "421111047", "story_v_out_421111.awb") / 1000

					if var_194_14 + var_194_8 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_14 + var_194_8
					end

					if var_194_10.prefab_name ~= "" and arg_191_1.actors_[var_194_10.prefab_name] ~= nil then
						local var_194_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_10.prefab_name].transform, "story_v_out_421111", "421111047", "story_v_out_421111.awb")

						arg_191_1:RecordAudio("421111047", var_194_15)
						arg_191_1:RecordAudio("421111047", var_194_15)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_421111", "421111047", "story_v_out_421111.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_421111", "421111047", "story_v_out_421111.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_16 = math.max(var_194_9, arg_191_1.talkMaxDuration)

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_16 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_8) / var_194_16

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_8 + var_194_16 and arg_191_1.time_ < var_194_8 + var_194_16 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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

		arg_191_1:InitPlayNodeList()
	end,
	Play421111048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 421111048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play421111049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1047ui_story = arg_195_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1047ui_story"].transform.position).z)
				arg_195_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1047ui_story"].transform.localEulerAngles = arg_195_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1047ui_story"].transform.position).z)
				arg_195_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1047ui_story"].transform.localEulerAngles = arg_195_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["10145ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10145ui_story = var_198_1.localPosition
			end

			local var_198_2 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 then
				var_198_1.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_2)
				var_198_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_1.position).x, (manager.ui.mainCamera.transform.position - var_198_1.position).y, (manager.ui.mainCamera.transform.position - var_198_1.position).z)
				var_198_1.localEulerAngles.z = 0
				var_198_1.localEulerAngles.x = 0
				var_198_1.localEulerAngles = var_198_1.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 then
				var_198_1.localPosition = Vector3.New(0, 100, 0)
				var_198_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_1.position).x, (manager.ui.mainCamera.transform.position - var_198_1.position).y, (manager.ui.mainCamera.transform.position - var_198_1.position).z)
				var_198_1.localEulerAngles.z = 0
				var_198_1.localEulerAngles.x = 0
				var_198_1.localEulerAngles = var_198_1.localEulerAngles
			end

			local var_198_3 = 0
			local var_198_4 = 0.225

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_3 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_5 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(421111048).content)

				arg_195_1.text_.text = var_198_5

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_7 = 9 <= 0 and var_198_4 or var_198_4 * (utf8.len(var_198_5) / 9)

				if (9 <= 0 and var_198_4 or var_198_4 * (utf8.len(var_198_5) / 9)) > 0 and var_198_4 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_3 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_3
					end
				end

				arg_195_1.text_.text = var_198_5
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_4, arg_195_1.talkMaxDuration)

			if var_198_3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_3 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_3) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_3 + var_198_8 and arg_195_1.time_ < var_198_3 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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

		arg_195_1:InitPlayNodeList()
	end,
	Play421111049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 421111049
		arg_199_1.duration_ = 6.97

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play421111050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if arg_199_1.bgs_.I11r == nil then
				local var_202_0 = Object.Instantiate(arg_199_1.paintGo_)

				var_202_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11r")
				var_202_0.name = "I11r"
				var_202_0.transform.parent = arg_199_1.stage_.transform
				var_202_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.bgs_.I11r = var_202_0
			end

			if 0.966666666666667 < arg_199_1.time_ and arg_199_1.time_ <= 0.966666666666667 + arg_202_0 then
				local var_202_1 = arg_199_1.bgs_.I11r

				arg_199_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_202_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_202_2 = var_202_1:GetComponent("SpriteRenderer")

				if var_202_2 and var_202_2.sprite then
					local var_202_3 = 2 * (var_202_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_202_1.transform.localScale = Vector3.New(var_202_3 / var_202_2.sprite.bounds.size.y < var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x and var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x or var_202_3 / var_202_2.sprite.bounds.size.y, var_202_3 / var_202_2.sprite.bounds.size.y < var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x and var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x or var_202_3 / var_202_2.sprite.bounds.size.y, 0)
				end

				for iter_202_0, iter_202_1 in pairs(arg_199_1.bgs_) do
					if iter_202_0 ~= "I11r" then
						iter_202_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_202_4 = 0

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_5 = 0.966666666666667

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_5 then
				local var_202_6 = Color.New(0, 0, 0)

				var_202_6.a = Mathf.Lerp(0, 1, (arg_199_1.time_ - var_202_4) / var_202_5)
				arg_199_1.mask_.color = var_202_6
			end

			if arg_199_1.time_ >= var_202_4 + var_202_5 and arg_199_1.time_ < var_202_4 + var_202_5 + arg_202_0 then
				local var_202_7 = Color.New(0, 0, 0)

				var_202_7.a = 1
				arg_199_1.mask_.color = var_202_7
			end

			local var_202_8 = 0.966666666666667

			if 0.966666666666667 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_9 = 1

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_9 then
				local var_202_10 = Color.New(0, 0, 0)

				var_202_10.a = Mathf.Lerp(1, 0, (arg_199_1.time_ - var_202_8) / var_202_9)
				arg_199_1.mask_.color = var_202_10
			end

			if arg_199_1.time_ >= var_202_8 + var_202_9 and arg_199_1.time_ < var_202_8 + var_202_9 + arg_202_0 then
				local var_202_11 = Color.New(0, 0, 0)

				arg_199_1.mask_.enabled = false
				var_202_11.a = 0
				arg_199_1.mask_.color = var_202_11
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_12 = 1.96666666666667
			local var_202_13 = 0.575

			if 1.96666666666667 < arg_199_1.time_ and arg_199_1.time_ <= var_202_12 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_14 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_14:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_15 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(421111049).content)

				arg_199_1.text_.text = var_202_15

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_17 = 23 <= 0 and var_202_13 or var_202_13 * (utf8.len(var_202_15) / 23)

				if (23 <= 0 and var_202_13 or var_202_13 * (utf8.len(var_202_15) / 23)) > 0 and var_202_13 < var_202_17 then
					arg_199_1.talkMaxDuration = var_202_17
					var_202_12 = var_202_12 + 0.3

					if var_202_17 + var_202_12 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_17 + var_202_12
					end
				end

				arg_199_1.text_.text = var_202_15
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_18 = var_202_12 + 0.3
			local var_202_19 = math.max(var_202_13, arg_199_1.talkMaxDuration)

			if var_202_12 + 0.3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_18 + var_202_19 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_18) / var_202_19

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_18 + var_202_19 and arg_199_1.time_ < var_202_18 + var_202_19 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play421111050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 421111050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play421111051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.275

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(421111050).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 11 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 11)

				if (11 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 11)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play421111051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 421111051
		arg_209_1.duration_ = 4.97

		local var_209_0 = {
			zh = 3.8,
			ja = 4.966
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
				arg_209_0:Play421111052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1047ui_story = arg_209_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).z)
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles = arg_209_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_209_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1047ui_story"].transform.position).z)
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1047ui_story"].transform.localEulerAngles = arg_209_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1047ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1047ui_story == nil then
				arg_209_1.var_.characterEffect1047ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1047ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1047ui_story then
				arg_209_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_212_4 = 0
			local var_212_5 = 0.3

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(421111051)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 12 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 12)

				if (12 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 12)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111051", "story_v_out_421111.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111051", "story_v_out_421111.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_out_421111", "421111051", "story_v_out_421111.awb")

						arg_209_1:RecordAudio("421111051", var_212_11)
						arg_209_1:RecordAudio("421111051", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_421111", "421111051", "story_v_out_421111.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_421111", "421111051", "story_v_out_421111.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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

		arg_209_1:InitPlayNodeList()
	end,
	Play421111052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 421111052
		arg_213_1.duration_ = 2

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play421111053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10145ui_story = arg_213_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10145ui_story"].transform.position).z)
				arg_213_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["10145ui_story"].transform.localEulerAngles = arg_213_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_213_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10145ui_story"].transform.position).z)
				arg_213_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["10145ui_story"].transform.localEulerAngles = arg_213_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["10145ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect10145ui_story == nil then
				arg_213_1.var_.characterEffect10145ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect10145ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect10145ui_story then
				arg_213_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_216_4 = arg_213_1.actors_["1047ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.characterEffect1047ui_story == nil then
				arg_213_1.var_.characterEffect1047ui_story = var_216_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_5 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_5 and not isNil(var_216_4) then
				if arg_213_1.var_.characterEffect1047ui_story and not isNil(var_216_4) then
					arg_213_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_5)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_5 and arg_213_1.time_ < 0 + var_216_5 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.characterEffect1047ui_story then
				arg_213_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_216_6 = 0
			local var_216_7 = 0.1

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_8 = arg_213_1:GetWordFromCfg(421111052)
				local var_216_9 = arg_213_1:FormatText(var_216_8.content)

				arg_213_1.text_.text = var_216_9

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 4 <= 0 and var_216_7 or var_216_7 * (utf8.len(var_216_9) / 4)

				if (4 <= 0 and var_216_7 or var_216_7 * (utf8.len(var_216_9) / 4)) > 0 and var_216_7 < var_216_11 then
					arg_213_1.talkMaxDuration = var_216_11

					if var_216_11 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_6
					end
				end

				arg_213_1.text_.text = var_216_9
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111052", "story_v_out_421111.awb") ~= 0 then
					local var_216_12 = manager.audio:GetVoiceLength("story_v_out_421111", "421111052", "story_v_out_421111.awb") / 1000

					if var_216_12 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_12 + var_216_6
					end

					if var_216_8.prefab_name ~= "" and arg_213_1.actors_[var_216_8.prefab_name] ~= nil then
						local var_216_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_8.prefab_name].transform, "story_v_out_421111", "421111052", "story_v_out_421111.awb")

						arg_213_1:RecordAudio("421111052", var_216_13)
						arg_213_1:RecordAudio("421111052", var_216_13)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_421111", "421111052", "story_v_out_421111.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_421111", "421111052", "story_v_out_421111.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_14 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_14 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_14

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_14 and arg_213_1.time_ < var_216_6 + var_216_14 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play421111053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 421111053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play421111054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1047ui_story = arg_217_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1047ui_story"].transform.position).z)
				arg_217_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1047ui_story"].transform.localEulerAngles = arg_217_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1047ui_story"].transform.position).z)
				arg_217_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1047ui_story"].transform.localEulerAngles = arg_217_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["10145ui_story"].transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos10145ui_story = var_220_1.localPosition
			end

			local var_220_2 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 then
				var_220_1.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_217_1.time_ - 0) / var_220_2)
				var_220_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_1.position).x, (manager.ui.mainCamera.transform.position - var_220_1.position).y, (manager.ui.mainCamera.transform.position - var_220_1.position).z)
				var_220_1.localEulerAngles.z = 0
				var_220_1.localEulerAngles.x = 0
				var_220_1.localEulerAngles = var_220_1.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 then
				var_220_1.localPosition = Vector3.New(0, 100, 0)
				var_220_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_1.position).x, (manager.ui.mainCamera.transform.position - var_220_1.position).y, (manager.ui.mainCamera.transform.position - var_220_1.position).z)
				var_220_1.localEulerAngles.z = 0
				var_220_1.localEulerAngles.x = 0
				var_220_1.localEulerAngles = var_220_1.localEulerAngles
			end

			local var_220_3 = 0
			local var_220_4 = 0.2

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_5 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(421111053).content)

				arg_217_1.text_.text = var_220_5

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_7 = 8 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_5) / 8)

				if (8 <= 0 and var_220_4 or var_220_4 * (utf8.len(var_220_5) / 8)) > 0 and var_220_4 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_3 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_3
					end
				end

				arg_217_1.text_.text = var_220_5
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_4, arg_217_1.talkMaxDuration)

			if var_220_3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_3 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_3) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_3 + var_220_8 and arg_217_1.time_ < var_220_3 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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

		arg_217_1:InitPlayNodeList()
	end,
	Play421111054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 421111054
		arg_221_1.duration_ = 8.4

		local var_221_0 = {
			zh = 7.1,
			ja = 8.4
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play421111055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10102ui_story = arg_221_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10102ui_story"].transform.position).z)
				arg_221_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["10102ui_story"].transform.localEulerAngles = arg_221_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_221_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10102ui_story"].transform.position).z)
				arg_221_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["10102ui_story"].transform.localEulerAngles = arg_221_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["10102ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect10102ui_story == nil then
				arg_221_1.var_.characterEffect10102ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect10102ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect10102ui_story then
				arg_221_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_224_4 = 0
			local var_224_5 = 0.85

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(421111054)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 34 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 34)

				if (34 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 34)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111054", "story_v_out_421111.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111054", "story_v_out_421111.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_out_421111", "421111054", "story_v_out_421111.awb")

						arg_221_1:RecordAudio("421111054", var_224_11)
						arg_221_1:RecordAudio("421111054", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_421111", "421111054", "story_v_out_421111.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_421111", "421111054", "story_v_out_421111.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_12 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_12 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_12

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_12 and arg_221_1.time_ < var_224_4 + var_224_12 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play421111055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 421111055
		arg_225_1.duration_ = 4.97

		local var_225_0 = {
			zh = 3.866,
			ja = 4.966
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play421111056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1047ui_story = arg_225_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).z)
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles = arg_225_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_225_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).z)
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles = arg_225_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["1047ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1047ui_story == nil then
				arg_225_1.var_.characterEffect1047ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1047ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1047ui_story then
				arg_225_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_228_4 = arg_225_1.actors_["10102ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.characterEffect10102ui_story == nil then
				arg_225_1.var_.characterEffect10102ui_story = var_228_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_5 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_5 and not isNil(var_228_4) then
				if arg_225_1.var_.characterEffect10102ui_story and not isNil(var_228_4) then
					arg_225_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_5)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_5 and arg_225_1.time_ < 0 + var_228_5 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.characterEffect10102ui_story then
				arg_225_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_2")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_228_6 = 0
			local var_228_7 = 0.425

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_8 = arg_225_1:GetWordFromCfg(421111055)
				local var_228_9 = arg_225_1:FormatText(var_228_8.content)

				arg_225_1.text_.text = var_228_9

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 17 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_9) / 17)

				if (17 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_9) / 17)) > 0 and var_228_7 < var_228_11 then
					arg_225_1.talkMaxDuration = var_228_11

					if var_228_11 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_9
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111055", "story_v_out_421111.awb") ~= 0 then
					local var_228_12 = manager.audio:GetVoiceLength("story_v_out_421111", "421111055", "story_v_out_421111.awb") / 1000

					if var_228_12 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_6
					end

					if var_228_8.prefab_name ~= "" and arg_225_1.actors_[var_228_8.prefab_name] ~= nil then
						local var_228_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_8.prefab_name].transform, "story_v_out_421111", "421111055", "story_v_out_421111.awb")

						arg_225_1:RecordAudio("421111055", var_228_13)
						arg_225_1:RecordAudio("421111055", var_228_13)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_421111", "421111055", "story_v_out_421111.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_421111", "421111055", "story_v_out_421111.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
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

		arg_225_1:InitPlayNodeList()
	end,
	Play421111056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 421111056
		arg_229_1.duration_ = 2

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play421111057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos10102ui_story = arg_229_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10102ui_story"].transform.position).z)
				arg_229_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["10102ui_story"].transform.localEulerAngles = arg_229_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_229_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10102ui_story"].transform.position).z)
				arg_229_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["10102ui_story"].transform.localEulerAngles = arg_229_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["10102ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect10102ui_story == nil then
				arg_229_1.var_.characterEffect10102ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect10102ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect10102ui_story then
				arg_229_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_232_4 = arg_229_1.actors_["1047ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect1047ui_story == nil then
				arg_229_1.var_.characterEffect1047ui_story = var_232_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_5 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_5 and not isNil(var_232_4) then
				if arg_229_1.var_.characterEffect1047ui_story and not isNil(var_232_4) then
					arg_229_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_5)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_5 and arg_229_1.time_ < 0 + var_232_5 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect1047ui_story then
				arg_229_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action6_2")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_232_6 = 0
			local var_232_7 = 0.15

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_8 = arg_229_1:GetWordFromCfg(421111056)
				local var_232_9 = arg_229_1:FormatText(var_232_8.content)

				arg_229_1.text_.text = var_232_9

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 6 <= 0 and var_232_7 or var_232_7 * (utf8.len(var_232_9) / 6)

				if (6 <= 0 and var_232_7 or var_232_7 * (utf8.len(var_232_9) / 6)) > 0 and var_232_7 < var_232_11 then
					arg_229_1.talkMaxDuration = var_232_11

					if var_232_11 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_11 + var_232_6
					end
				end

				arg_229_1.text_.text = var_232_9
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111056", "story_v_out_421111.awb") ~= 0 then
					local var_232_12 = manager.audio:GetVoiceLength("story_v_out_421111", "421111056", "story_v_out_421111.awb") / 1000

					if var_232_12 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_12 + var_232_6
					end

					if var_232_8.prefab_name ~= "" and arg_229_1.actors_[var_232_8.prefab_name] ~= nil then
						local var_232_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_8.prefab_name].transform, "story_v_out_421111", "421111056", "story_v_out_421111.awb")

						arg_229_1:RecordAudio("421111056", var_232_13)
						arg_229_1:RecordAudio("421111056", var_232_13)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_421111", "421111056", "story_v_out_421111.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_421111", "421111056", "story_v_out_421111.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_14 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 <= arg_229_1.time_ and arg_229_1.time_ < var_232_6 + var_232_14 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_6) / var_232_14

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_6 + var_232_14 and arg_229_1.time_ < var_232_6 + var_232_14 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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

		arg_229_1:InitPlayNodeList()
	end,
	Play421111057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 421111057
		arg_233_1.duration_ = 4.1

		local var_233_0 = {
			zh = 2.233,
			ja = 4.1
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
				arg_233_0:Play421111058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10143ui_story = arg_233_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10143ui_story"].transform.position).z)
				arg_233_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["10143ui_story"].transform.localEulerAngles = arg_233_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_233_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10143ui_story"].transform.position).z)
				arg_233_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["10143ui_story"].transform.localEulerAngles = arg_233_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1047ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1047ui_story = var_236_1.localPosition
			end

			local var_236_2 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 then
				var_236_1.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_2)
				var_236_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_1.position).x, (manager.ui.mainCamera.transform.position - var_236_1.position).y, (manager.ui.mainCamera.transform.position - var_236_1.position).z)
				var_236_1.localEulerAngles.z = 0
				var_236_1.localEulerAngles.x = 0
				var_236_1.localEulerAngles = var_236_1.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 then
				var_236_1.localPosition = Vector3.New(0, 100, 0)
				var_236_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_1.position).x, (manager.ui.mainCamera.transform.position - var_236_1.position).y, (manager.ui.mainCamera.transform.position - var_236_1.position).z)
				var_236_1.localEulerAngles.z = 0
				var_236_1.localEulerAngles.x = 0
				var_236_1.localEulerAngles = var_236_1.localEulerAngles
			end

			local var_236_3 = arg_233_1.actors_["10143ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_3) and arg_233_1.var_.characterEffect10143ui_story == nil then
				arg_233_1.var_.characterEffect10143ui_story = var_236_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_4 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 and not isNil(var_236_3) then
				if arg_233_1.var_.characterEffect10143ui_story and not isNil(var_236_3) then
					arg_233_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 and not isNil(var_236_3) and arg_233_1.var_.characterEffect10143ui_story then
				arg_233_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_236_6 = arg_233_1.actors_["10102ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_6) and arg_233_1.var_.characterEffect10102ui_story == nil then
				arg_233_1.var_.characterEffect10102ui_story = var_236_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_7 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 and not isNil(var_236_6) then
				if arg_233_1.var_.characterEffect10102ui_story and not isNil(var_236_6) then
					arg_233_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_233_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_7)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 and not isNil(var_236_6) and arg_233_1.var_.characterEffect10102ui_story then
				arg_233_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_233_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_236_8 = 0
			local var_236_9 = 0.325

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_10 = arg_233_1:GetWordFromCfg(421111057)
				local var_236_11 = arg_233_1:FormatText(var_236_10.content)

				arg_233_1.text_.text = var_236_11

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_13 = 13 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 13)

				if (13 <= 0 and var_236_9 or var_236_9 * (utf8.len(var_236_11) / 13)) > 0 and var_236_9 < var_236_13 then
					arg_233_1.talkMaxDuration = var_236_13

					if var_236_13 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_13 + var_236_8
					end
				end

				arg_233_1.text_.text = var_236_11
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111057", "story_v_out_421111.awb") ~= 0 then
					local var_236_14 = manager.audio:GetVoiceLength("story_v_out_421111", "421111057", "story_v_out_421111.awb") / 1000

					if var_236_14 + var_236_8 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_14 + var_236_8
					end

					if var_236_10.prefab_name ~= "" and arg_233_1.actors_[var_236_10.prefab_name] ~= nil then
						local var_236_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_10.prefab_name].transform, "story_v_out_421111", "421111057", "story_v_out_421111.awb")

						arg_233_1:RecordAudio("421111057", var_236_15)
						arg_233_1:RecordAudio("421111057", var_236_15)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_421111", "421111057", "story_v_out_421111.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_421111", "421111057", "story_v_out_421111.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_16 = math.max(var_236_9, arg_233_1.talkMaxDuration)

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_16 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_8) / var_236_16

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_8 + var_236_16 and arg_233_1.time_ < var_236_8 + var_236_16 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_233_1:InitPlayNodeList()
	end,
	Play421111058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 421111058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play421111059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["10143ui_story"]) and arg_237_1.var_.characterEffect10143ui_story == nil then
				arg_237_1.var_.characterEffect10143ui_story = arg_237_1.actors_["10143ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["10143ui_story"]) then
				if arg_237_1.var_.characterEffect10143ui_story and not isNil(arg_237_1.actors_["10143ui_story"]) then
					arg_237_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_237_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["10143ui_story"]) and arg_237_1.var_.characterEffect10143ui_story then
				arg_237_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_237_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.4

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(421111058).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 16 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 16)

				if (16 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 16)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play421111059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 421111059
		arg_241_1.duration_ = 5.27

		local var_241_0 = {
			zh = 3.033,
			ja = 5.266
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play421111060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos10143ui_story = arg_241_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10143ui_story"].transform.position).z)
				arg_241_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["10143ui_story"].transform.localEulerAngles = arg_241_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_241_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10143ui_story"].transform.position).z)
				arg_241_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["10143ui_story"].transform.localEulerAngles = arg_241_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["10143ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect10143ui_story == nil then
				arg_241_1.var_.characterEffect10143ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect10143ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect10143ui_story then
				arg_241_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action4_2")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_244_4 = 0
			local var_244_5 = 0.375

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(421111059)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 15 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 15)

				if (15 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 15)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111059", "story_v_out_421111.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111059", "story_v_out_421111.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_out_421111", "421111059", "story_v_out_421111.awb")

						arg_241_1:RecordAudio("421111059", var_244_11)
						arg_241_1:RecordAudio("421111059", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_421111", "421111059", "story_v_out_421111.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_421111", "421111059", "story_v_out_421111.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_12 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_12 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_12

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_12 and arg_241_1.time_ < var_244_4 + var_244_12 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
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

		arg_241_1:InitPlayNodeList()
	end,
	Play421111060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 421111060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play421111061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10143ui_story"]) and arg_245_1.var_.characterEffect10143ui_story == nil then
				arg_245_1.var_.characterEffect10143ui_story = arg_245_1.actors_["10143ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10143ui_story"]) then
				if arg_245_1.var_.characterEffect10143ui_story and not isNil(arg_245_1.actors_["10143ui_story"]) then
					arg_245_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10143ui_story"]) and arg_245_1.var_.characterEffect10143ui_story then
				arg_245_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 0.8

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(421111060).content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 32 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 32)

				if (32 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 32)) > 0 and var_248_2 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_6 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_6 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_6

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_6 and arg_245_1.time_ < var_248_1 + var_248_6 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play421111061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 421111061
		arg_249_1.duration_ = 5

		local var_249_0 = {
			zh = 3.233,
			ja = 5
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
				arg_249_0:Play421111062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10143ui_story = arg_249_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10143ui_story"].transform.position).z)
				arg_249_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10143ui_story"].transform.localEulerAngles = arg_249_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_249_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10143ui_story"].transform.position).z)
				arg_249_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10143ui_story"].transform.localEulerAngles = arg_249_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["10143ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect10143ui_story == nil then
				arg_249_1.var_.characterEffect10143ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect10143ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect10143ui_story then
				arg_249_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_252_4 = 0
			local var_252_5 = 0.375

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(421111061)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 15 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 15)

				if (15 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 15)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111061", "story_v_out_421111.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111061", "story_v_out_421111.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_421111", "421111061", "story_v_out_421111.awb")

						arg_249_1:RecordAudio("421111061", var_252_11)
						arg_249_1:RecordAudio("421111061", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_421111", "421111061", "story_v_out_421111.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_421111", "421111061", "story_v_out_421111.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_12 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_12 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_12

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_12 and arg_249_1.time_ < var_252_4 + var_252_12 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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

		arg_249_1:InitPlayNodeList()
	end,
	Play421111062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 421111062
		arg_253_1.duration_ = 5

		local var_253_0 = {
			zh = 3.7,
			ja = 5
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
				arg_253_0:Play421111063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1047ui_story = arg_253_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).z)
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles = arg_253_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_253_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1047ui_story"].transform.position).z)
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1047ui_story"].transform.localEulerAngles = arg_253_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["10102ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10102ui_story = var_256_1.localPosition
			end

			local var_256_2 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 then
				var_256_1.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_2)
				var_256_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_1.position).x, (manager.ui.mainCamera.transform.position - var_256_1.position).y, (manager.ui.mainCamera.transform.position - var_256_1.position).z)
				var_256_1.localEulerAngles.z = 0
				var_256_1.localEulerAngles.x = 0
				var_256_1.localEulerAngles = var_256_1.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 then
				var_256_1.localPosition = Vector3.New(0, 100, 0)
				var_256_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_1.position).x, (manager.ui.mainCamera.transform.position - var_256_1.position).y, (manager.ui.mainCamera.transform.position - var_256_1.position).z)
				var_256_1.localEulerAngles.z = 0
				var_256_1.localEulerAngles.x = 0
				var_256_1.localEulerAngles = var_256_1.localEulerAngles
			end

			local var_256_3 = arg_253_1.actors_["1047ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_3) and arg_253_1.var_.characterEffect1047ui_story == nil then
				arg_253_1.var_.characterEffect1047ui_story = var_256_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_4 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 and not isNil(var_256_3) then
				if arg_253_1.var_.characterEffect1047ui_story and not isNil(var_256_3) then
					arg_253_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 and not isNil(var_256_3) and arg_253_1.var_.characterEffect1047ui_story then
				arg_253_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_256_6 = arg_253_1.actors_["10143ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_6) and arg_253_1.var_.characterEffect10143ui_story == nil then
				arg_253_1.var_.characterEffect10143ui_story = var_256_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_7 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 and not isNil(var_256_6) then
				if arg_253_1.var_.characterEffect10143ui_story and not isNil(var_256_6) then
					arg_253_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_7)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 and not isNil(var_256_6) and arg_253_1.var_.characterEffect10143ui_story then
				arg_253_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_256_8 = 0
			local var_256_9 = 0.4

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_10 = arg_253_1:GetWordFromCfg(421111062)
				local var_256_11 = arg_253_1:FormatText(var_256_10.content)

				arg_253_1.text_.text = var_256_11

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 16 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 16)

				if (16 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 16)) > 0 and var_256_9 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_11
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111062", "story_v_out_421111.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_421111", "421111062", "story_v_out_421111.awb") / 1000

					if var_256_14 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_8
					end

					if var_256_10.prefab_name ~= "" and arg_253_1.actors_[var_256_10.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_10.prefab_name].transform, "story_v_out_421111", "421111062", "story_v_out_421111.awb")

						arg_253_1:RecordAudio("421111062", var_256_15)
						arg_253_1:RecordAudio("421111062", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_421111", "421111062", "story_v_out_421111.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_421111", "421111062", "story_v_out_421111.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_16 and arg_253_1.time_ < var_256_8 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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

		arg_253_1:InitPlayNodeList()
	end,
	Play421111063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 421111063
		arg_257_1.duration_ = 2

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play421111064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos10143ui_story = arg_257_1.actors_["10143ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["10143ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10143ui_story, Vector3.New(0.78, -1.06, -6), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10143ui_story"].transform.position).z)
				arg_257_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["10143ui_story"].transform.localEulerAngles = arg_257_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["10143ui_story"].transform.localPosition = Vector3.New(0.78, -1.06, -6)
				arg_257_1.actors_["10143ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["10143ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10143ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10143ui_story"].transform.position).z)
				arg_257_1.actors_["10143ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["10143ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["10143ui_story"].transform.localEulerAngles = arg_257_1.actors_["10143ui_story"].transform.localEulerAngles
			end

			local var_260_1 = arg_257_1.actors_["10143ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect10143ui_story == nil then
				arg_257_1.var_.characterEffect10143ui_story = var_260_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_2 and not isNil(var_260_1) then
				if arg_257_1.var_.characterEffect10143ui_story and not isNil(var_260_1) then
					arg_257_1.var_.characterEffect10143ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_2 and arg_257_1.time_ < 0 + var_260_2 + arg_260_0 and not isNil(var_260_1) and arg_257_1.var_.characterEffect10143ui_story then
				arg_257_1.var_.characterEffect10143ui_story.fillFlat = false
			end

			local var_260_4 = arg_257_1.actors_["1047ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect1047ui_story == nil then
				arg_257_1.var_.characterEffect1047ui_story = var_260_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_5 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_5 and not isNil(var_260_4) then
				if arg_257_1.var_.characterEffect1047ui_story and not isNil(var_260_4) then
					arg_257_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_5)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_5 and arg_257_1.time_ < 0 + var_260_5 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect1047ui_story then
				arg_257_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/story10143/story10143action/10143action7_2")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10143ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_260_6 = 0
			local var_260_7 = 0.05

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1307].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_8 = arg_257_1:GetWordFromCfg(421111063)
				local var_260_9 = arg_257_1:FormatText(var_260_8.content)

				arg_257_1.text_.text = var_260_9

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_11 = 2 <= 0 and var_260_7 or var_260_7 * (utf8.len(var_260_9) / 2)

				if (2 <= 0 and var_260_7 or var_260_7 * (utf8.len(var_260_9) / 2)) > 0 and var_260_7 < var_260_11 then
					arg_257_1.talkMaxDuration = var_260_11

					if var_260_11 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_11 + var_260_6
					end
				end

				arg_257_1.text_.text = var_260_9
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111063", "story_v_out_421111.awb") ~= 0 then
					local var_260_12 = manager.audio:GetVoiceLength("story_v_out_421111", "421111063", "story_v_out_421111.awb") / 1000

					if var_260_12 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_12 + var_260_6
					end

					if var_260_8.prefab_name ~= "" and arg_257_1.actors_[var_260_8.prefab_name] ~= nil then
						local var_260_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_8.prefab_name].transform, "story_v_out_421111", "421111063", "story_v_out_421111.awb")

						arg_257_1:RecordAudio("421111063", var_260_13)
						arg_257_1:RecordAudio("421111063", var_260_13)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_421111", "421111063", "story_v_out_421111.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_421111", "421111063", "story_v_out_421111.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_14 = math.max(var_260_7, arg_257_1.talkMaxDuration)

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_14 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_6) / var_260_14

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_6 + var_260_14 and arg_257_1.time_ < var_260_6 + var_260_14 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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

		arg_257_1:InitPlayNodeList()
	end,
	Play421111064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 421111064
		arg_261_1.duration_ = 2.07

		local var_261_0 = {
			zh = 1.999999999999,
			ja = 2.066
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
				arg_261_0:Play421111065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1047ui_story = arg_261_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1047ui_story"].transform.position).z)
				arg_261_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1047ui_story"].transform.localEulerAngles = arg_261_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_261_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1047ui_story"].transform.position).z)
				arg_261_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1047ui_story"].transform.localEulerAngles = arg_261_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1047ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1047ui_story == nil then
				arg_261_1.var_.characterEffect1047ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1047ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1047ui_story then
				arg_261_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_264_4 = arg_261_1.actors_["10143ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect10143ui_story == nil then
				arg_261_1.var_.characterEffect10143ui_story = var_264_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_5 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_5 and not isNil(var_264_4) then
				if arg_261_1.var_.characterEffect10143ui_story and not isNil(var_264_4) then
					arg_261_1.var_.characterEffect10143ui_story.fillFlat = true
					arg_261_1.var_.characterEffect10143ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_5)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_5 and arg_261_1.time_ < 0 + var_264_5 + arg_264_0 and not isNil(var_264_4) and arg_261_1.var_.characterEffect10143ui_story then
				arg_261_1.var_.characterEffect10143ui_story.fillFlat = true
				arg_261_1.var_.characterEffect10143ui_story.fillRatio = 0.5
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_264_6 = 0
			local var_264_7 = 0.2

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_8 = arg_261_1:GetWordFromCfg(421111064)
				local var_264_9 = arg_261_1:FormatText(var_264_8.content)

				arg_261_1.text_.text = var_264_9

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_11 = 8 <= 0 and var_264_7 or var_264_7 * (utf8.len(var_264_9) / 8)

				if (8 <= 0 and var_264_7 or var_264_7 * (utf8.len(var_264_9) / 8)) > 0 and var_264_7 < var_264_11 then
					arg_261_1.talkMaxDuration = var_264_11

					if var_264_11 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_9
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111064", "story_v_out_421111.awb") ~= 0 then
					local var_264_12 = manager.audio:GetVoiceLength("story_v_out_421111", "421111064", "story_v_out_421111.awb") / 1000

					if var_264_12 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_12 + var_264_6
					end

					if var_264_8.prefab_name ~= "" and arg_261_1.actors_[var_264_8.prefab_name] ~= nil then
						local var_264_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_8.prefab_name].transform, "story_v_out_421111", "421111064", "story_v_out_421111.awb")

						arg_261_1:RecordAudio("421111064", var_264_13)
						arg_261_1:RecordAudio("421111064", var_264_13)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_421111", "421111064", "story_v_out_421111.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_421111", "421111064", "story_v_out_421111.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_14 = math.max(var_264_7, arg_261_1.talkMaxDuration)

			if var_264_6 <= arg_261_1.time_ and arg_261_1.time_ < var_264_6 + var_264_14 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_6) / var_264_14

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_6 + var_264_14 and arg_261_1.time_ < var_264_6 + var_264_14 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play421111065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 421111065
		arg_265_1.duration_ = 9

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play421111066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if arg_265_1.bgs_.B13a == nil then
				local var_268_0 = Object.Instantiate(arg_265_1.paintGo_)

				var_268_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13a")
				var_268_0.name = "B13a"
				var_268_0.transform.parent = arg_265_1.stage_.transform
				var_268_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_265_1.bgs_.B13a = var_268_0
			end

			if 2 < arg_265_1.time_ and arg_265_1.time_ <= 2 + arg_268_0 then
				local var_268_1 = arg_265_1.bgs_.B13a

				arg_265_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_268_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_2 = var_268_1:GetComponent("SpriteRenderer")

				if var_268_2 and var_268_2.sprite then
					local var_268_3 = 2 * (var_268_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_268_1.transform.localScale = Vector3.New(var_268_3 / var_268_2.sprite.bounds.size.y < var_268_3 * manager.ui.mainCameraCom_.aspect / var_268_2.sprite.bounds.size.x and var_268_3 * manager.ui.mainCameraCom_.aspect / var_268_2.sprite.bounds.size.x or var_268_3 / var_268_2.sprite.bounds.size.y, var_268_3 / var_268_2.sprite.bounds.size.y < var_268_3 * manager.ui.mainCameraCom_.aspect / var_268_2.sprite.bounds.size.x and var_268_3 * manager.ui.mainCameraCom_.aspect / var_268_2.sprite.bounds.size.x or var_268_3 / var_268_2.sprite.bounds.size.y, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "B13a" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_4 = 4

			if 4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.allBtn_.enabled = false
			end

			if arg_265_1.time_ >= var_268_4 + 0.3 and arg_265_1.time_ < var_268_4 + 0.3 + arg_268_0 then
				arg_265_1.allBtn_.enabled = true
			end

			local var_268_5 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_6 = 2

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_6 then
				local var_268_7 = Color.New(0, 0, 0)

				var_268_7.a = Mathf.Lerp(0, 1, (arg_265_1.time_ - var_268_5) / var_268_6)
				arg_265_1.mask_.color = var_268_7
			end

			if arg_265_1.time_ >= var_268_5 + var_268_6 and arg_265_1.time_ < var_268_5 + var_268_6 + arg_268_0 then
				local var_268_8 = Color.New(0, 0, 0)

				var_268_8.a = 1
				arg_265_1.mask_.color = var_268_8
			end

			local var_268_9 = 2

			if 2 < arg_265_1.time_ and arg_265_1.time_ <= var_268_9 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_10 = 2

			if var_268_9 <= arg_265_1.time_ and arg_265_1.time_ < var_268_9 + var_268_10 then
				local var_268_11 = Color.New(0, 0, 0)

				var_268_11.a = Mathf.Lerp(1, 0, (arg_265_1.time_ - var_268_9) / var_268_10)
				arg_265_1.mask_.color = var_268_11
			end

			if arg_265_1.time_ >= var_268_9 + var_268_10 and arg_265_1.time_ < var_268_9 + var_268_10 + arg_268_0 then
				local var_268_12 = Color.New(0, 0, 0)

				arg_265_1.mask_.enabled = false
				var_268_12.a = 0
				arg_265_1.mask_.color = var_268_12
			end

			local var_268_13 = arg_265_1.actors_["1047ui_story"].transform

			if 2 < arg_265_1.time_ and arg_265_1.time_ <= 2 + arg_268_0 then
				arg_265_1.var_.moveOldPos1047ui_story = var_268_13.localPosition
			end

			local var_268_14 = 0.001

			if 2 <= arg_265_1.time_ and arg_265_1.time_ < 2 + var_268_14 then
				var_268_13.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 2) / var_268_14)
				var_268_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_13.position).x, (manager.ui.mainCamera.transform.position - var_268_13.position).y, (manager.ui.mainCamera.transform.position - var_268_13.position).z)
				var_268_13.localEulerAngles.z = 0
				var_268_13.localEulerAngles.x = 0
				var_268_13.localEulerAngles = var_268_13.localEulerAngles
			end

			if arg_265_1.time_ >= 2 + var_268_14 and arg_265_1.time_ < 2 + var_268_14 + arg_268_0 then
				var_268_13.localPosition = Vector3.New(0, 100, 0)
				var_268_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_13.position).x, (manager.ui.mainCamera.transform.position - var_268_13.position).y, (manager.ui.mainCamera.transform.position - var_268_13.position).z)
				var_268_13.localEulerAngles.z = 0
				var_268_13.localEulerAngles.x = 0
				var_268_13.localEulerAngles = var_268_13.localEulerAngles
			end

			local var_268_15 = arg_265_1.actors_["10143ui_story"].transform

			if 2 < arg_265_1.time_ and arg_265_1.time_ <= 2 + arg_268_0 then
				arg_265_1.var_.moveOldPos10143ui_story = var_268_15.localPosition
			end

			local var_268_16 = 0.001

			if 2 <= arg_265_1.time_ and arg_265_1.time_ < 2 + var_268_16 then
				var_268_15.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10143ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 2) / var_268_16)
				var_268_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_15.position).x, (manager.ui.mainCamera.transform.position - var_268_15.position).y, (manager.ui.mainCamera.transform.position - var_268_15.position).z)
				var_268_15.localEulerAngles.z = 0
				var_268_15.localEulerAngles.x = 0
				var_268_15.localEulerAngles = var_268_15.localEulerAngles
			end

			if arg_265_1.time_ >= 2 + var_268_16 and arg_265_1.time_ < 2 + var_268_16 + arg_268_0 then
				var_268_15.localPosition = Vector3.New(0, 100, 0)
				var_268_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_15.position).x, (manager.ui.mainCamera.transform.position - var_268_15.position).y, (manager.ui.mainCamera.transform.position - var_268_15.position).z)
				var_268_15.localEulerAngles.z = 0
				var_268_15.localEulerAngles.x = 0
				var_268_15.localEulerAngles = var_268_15.localEulerAngles
			end

			if 0.1 < arg_265_1.time_ and arg_265_1.time_ <= 0.1 + arg_268_0 then
				arg_265_1:AudioAction("stop", "effect", "se_story_120_04", "se_story_120_04_street_loop", "")
			end

			if 1.56666666666667 < arg_265_1.time_ and arg_265_1.time_ <= 1.56666666666667 + arg_268_0 then
				arg_265_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_19 = 4
			local var_268_20 = 0.525

			if 4 < arg_265_1.time_ and arg_265_1.time_ <= var_268_19 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_21 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_21:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_22 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(421111065).content)

				arg_265_1.text_.text = var_268_22

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_24 = 21 <= 0 and var_268_20 or var_268_20 * (utf8.len(var_268_22) / 21)

				if (21 <= 0 and var_268_20 or var_268_20 * (utf8.len(var_268_22) / 21)) > 0 and var_268_20 < var_268_24 then
					arg_265_1.talkMaxDuration = var_268_24
					var_268_19 = var_268_19 + 0.3

					if var_268_24 + var_268_19 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_24 + var_268_19
					end
				end

				arg_265_1.text_.text = var_268_22
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_25 = var_268_19 + 0.3
			local var_268_26 = math.max(var_268_20, arg_265_1.talkMaxDuration)

			if var_268_19 + 0.3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_25 + var_268_26 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_25) / var_268_26

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_25 + var_268_26 and arg_265_1.time_ < var_268_25 + var_268_26 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10143ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play421111066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 421111066
		arg_271_1.duration_ = 8.77

		local var_271_0 = {
			zh = 8.066,
			ja = 8.766
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play421111067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1047ui_story = arg_271_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1047ui_story"].transform.position).z)
				arg_271_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1047ui_story"].transform.localEulerAngles = arg_271_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_271_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["1047ui_story"].transform.position).z)
				arg_271_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["1047ui_story"].transform.localEulerAngles = arg_271_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["1047ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1047ui_story == nil then
				arg_271_1.var_.characterEffect1047ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect1047ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1047ui_story then
				arg_271_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_274_4 = 0
			local var_274_5 = 0.95

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:GetWordFromCfg(421111066)
				local var_274_7 = arg_271_1:FormatText(var_274_6.content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 38 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 38)

				if (38 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 38)) > 0 and var_274_5 < var_274_9 then
					arg_271_1.talkMaxDuration = var_274_9

					if var_274_9 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_9 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111066", "story_v_out_421111.awb") ~= 0 then
					local var_274_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111066", "story_v_out_421111.awb") / 1000

					if var_274_10 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_4
					end

					if var_274_6.prefab_name ~= "" and arg_271_1.actors_[var_274_6.prefab_name] ~= nil then
						local var_274_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_6.prefab_name].transform, "story_v_out_421111", "421111066", "story_v_out_421111.awb")

						arg_271_1:RecordAudio("421111066", var_274_11)
						arg_271_1:RecordAudio("421111066", var_274_11)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_421111", "421111066", "story_v_out_421111.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_421111", "421111066", "story_v_out_421111.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_12 = math.max(var_274_5, arg_271_1.talkMaxDuration)

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_12 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_4) / var_274_12

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_4 + var_274_12 and arg_271_1.time_ < var_274_4 + var_274_12 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play421111067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 421111067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play421111068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1047ui_story"]) and arg_275_1.var_.characterEffect1047ui_story == nil then
				arg_275_1.var_.characterEffect1047ui_story = arg_275_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1047ui_story"]) then
				if arg_275_1.var_.characterEffect1047ui_story and not isNil(arg_275_1.actors_["1047ui_story"]) then
					arg_275_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1047ui_story"]) and arg_275_1.var_.characterEffect1047ui_story then
				arg_275_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 0.55

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(421111067).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 22 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 22)

				if (22 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 22)) > 0 and var_278_2 < var_278_5 then
					arg_275_1.talkMaxDuration = var_278_5

					if var_278_5 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_6 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_6 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_6

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_6 and arg_275_1.time_ < var_278_1 + var_278_6 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play421111068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 421111068
		arg_279_1.duration_ = 7.47

		local var_279_0 = {
			zh = 6.566,
			ja = 7.466
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play421111069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1047ui_story = arg_279_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1047ui_story"].transform.position).z)
				arg_279_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1047ui_story"].transform.localEulerAngles = arg_279_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_279_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1047ui_story"].transform.position).z)
				arg_279_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1047ui_story"].transform.localEulerAngles = arg_279_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["1047ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1047ui_story == nil then
				arg_279_1.var_.characterEffect1047ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect1047ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1047ui_story then
				arg_279_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_282_4 = 0
			local var_282_5 = 0.75

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:GetWordFromCfg(421111068)
				local var_282_7 = arg_279_1:FormatText(var_282_6.content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 30 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 30)

				if (30 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 30)) > 0 and var_282_5 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111068", "story_v_out_421111.awb") ~= 0 then
					local var_282_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111068", "story_v_out_421111.awb") / 1000

					if var_282_10 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_4
					end

					if var_282_6.prefab_name ~= "" and arg_279_1.actors_[var_282_6.prefab_name] ~= nil then
						local var_282_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_6.prefab_name].transform, "story_v_out_421111", "421111068", "story_v_out_421111.awb")

						arg_279_1:RecordAudio("421111068", var_282_11)
						arg_279_1:RecordAudio("421111068", var_282_11)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_421111", "421111068", "story_v_out_421111.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_421111", "421111068", "story_v_out_421111.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_12 = math.max(var_282_5, arg_279_1.talkMaxDuration)

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_12 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_4) / var_282_12

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_4 + var_282_12 and arg_279_1.time_ < var_282_4 + var_282_12 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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

		arg_279_1:InitPlayNodeList()
	end,
	Play421111069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 421111069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play421111070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1047ui_story"]) and arg_283_1.var_.characterEffect1047ui_story == nil then
				arg_283_1.var_.characterEffect1047ui_story = arg_283_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1047ui_story"]) then
				if arg_283_1.var_.characterEffect1047ui_story and not isNil(arg_283_1.actors_["1047ui_story"]) then
					arg_283_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1047ui_story"]) and arg_283_1.var_.characterEffect1047ui_story then
				arg_283_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_286_1 = 0
			local var_286_2 = 0.825

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(421111069).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 33 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 33)

				if (33 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 33)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play421111070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 421111070
		arg_287_1.duration_ = 8.8

		local var_287_0 = {
			zh = 4.8,
			ja = 8.8
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play421111071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos1047ui_story = arg_287_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1047ui_story"].transform.position).z)
				arg_287_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1047ui_story"].transform.localEulerAngles = arg_287_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_287_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["1047ui_story"].transform.position).z)
				arg_287_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["1047ui_story"].transform.localEulerAngles = arg_287_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["1047ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1047ui_story == nil then
				arg_287_1.var_.characterEffect1047ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect1047ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect1047ui_story then
				arg_287_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_290_4 = 0
			local var_290_5 = 0.675

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_6 = arg_287_1:GetWordFromCfg(421111070)
				local var_290_7 = arg_287_1:FormatText(var_290_6.content)

				arg_287_1.text_.text = var_290_7

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_9 = 27 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 27)

				if (27 <= 0 and var_290_5 or var_290_5 * (utf8.len(var_290_7) / 27)) > 0 and var_290_5 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_4
					end
				end

				arg_287_1.text_.text = var_290_7
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111070", "story_v_out_421111.awb") ~= 0 then
					local var_290_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111070", "story_v_out_421111.awb") / 1000

					if var_290_10 + var_290_4 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_10 + var_290_4
					end

					if var_290_6.prefab_name ~= "" and arg_287_1.actors_[var_290_6.prefab_name] ~= nil then
						local var_290_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_6.prefab_name].transform, "story_v_out_421111", "421111070", "story_v_out_421111.awb")

						arg_287_1:RecordAudio("421111070", var_290_11)
						arg_287_1:RecordAudio("421111070", var_290_11)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_421111", "421111070", "story_v_out_421111.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_421111", "421111070", "story_v_out_421111.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_12 = math.max(var_290_5, arg_287_1.talkMaxDuration)

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_12 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_4) / var_290_12

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_4 + var_290_12 and arg_287_1.time_ < var_290_4 + var_290_12 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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

		arg_287_1:InitPlayNodeList()
	end,
	Play421111071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 421111071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play421111072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1047ui_story"]) and arg_291_1.var_.characterEffect1047ui_story == nil then
				arg_291_1.var_.characterEffect1047ui_story = arg_291_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1047ui_story"]) then
				if arg_291_1.var_.characterEffect1047ui_story and not isNil(arg_291_1.actors_["1047ui_story"]) then
					arg_291_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1047ui_story"]) and arg_291_1.var_.characterEffect1047ui_story then
				arg_291_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_294_1 = 0
			local var_294_2 = 0.525

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(421111071).content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 21 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 21)

				if (21 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 21)) > 0 and var_294_2 < var_294_5 then
					arg_291_1.talkMaxDuration = var_294_5

					if var_294_5 + var_294_1 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + var_294_1
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_6 = math.max(var_294_2, arg_291_1.talkMaxDuration)

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_6 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_1) / var_294_6

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_1 + var_294_6 and arg_291_1.time_ < var_294_1 + var_294_6 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play421111072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 421111072
		arg_295_1.duration_ = 8.03

		local var_295_0 = {
			zh = 3.9,
			ja = 8.033
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play421111073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1047ui_story = arg_295_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1047ui_story"].transform.position).z)
				arg_295_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1047ui_story"].transform.localEulerAngles = arg_295_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_295_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1047ui_story"].transform.position).z)
				arg_295_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1047ui_story"].transform.localEulerAngles = arg_295_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["1047ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1047ui_story == nil then
				arg_295_1.var_.characterEffect1047ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect1047ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect1047ui_story then
				arg_295_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_298_4 = 0
			local var_298_5 = 0.5

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_6 = arg_295_1:GetWordFromCfg(421111072)
				local var_298_7 = arg_295_1:FormatText(var_298_6.content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 20 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 20)

				if (20 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 20)) > 0 and var_298_5 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_4
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111072", "story_v_out_421111.awb") ~= 0 then
					local var_298_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111072", "story_v_out_421111.awb") / 1000

					if var_298_10 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_4
					end

					if var_298_6.prefab_name ~= "" and arg_295_1.actors_[var_298_6.prefab_name] ~= nil then
						local var_298_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_6.prefab_name].transform, "story_v_out_421111", "421111072", "story_v_out_421111.awb")

						arg_295_1:RecordAudio("421111072", var_298_11)
						arg_295_1:RecordAudio("421111072", var_298_11)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_421111", "421111072", "story_v_out_421111.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_421111", "421111072", "story_v_out_421111.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_12 = math.max(var_298_5, arg_295_1.talkMaxDuration)

			if var_298_4 <= arg_295_1.time_ and arg_295_1.time_ < var_298_4 + var_298_12 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_4) / var_298_12

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_4 + var_298_12 and arg_295_1.time_ < var_298_4 + var_298_12 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play421111073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 421111073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play421111074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1047ui_story"]) and arg_299_1.var_.characterEffect1047ui_story == nil then
				arg_299_1.var_.characterEffect1047ui_story = arg_299_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1047ui_story"]) then
				if arg_299_1.var_.characterEffect1047ui_story and not isNil(arg_299_1.actors_["1047ui_story"]) then
					arg_299_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_0)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1047ui_story"]) and arg_299_1.var_.characterEffect1047ui_story then
				arg_299_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_302_1 = 0
			local var_302_2 = 0.475

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_3 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(421111073).content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 19 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 19)

				if (19 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 19)) > 0 and var_302_2 < var_302_5 then
					arg_299_1.talkMaxDuration = var_302_5

					if var_302_5 + var_302_1 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + var_302_1
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_6 = math.max(var_302_2, arg_299_1.talkMaxDuration)

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_6 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_1) / var_302_6

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_1 + var_302_6 and arg_299_1.time_ < var_302_1 + var_302_6 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play421111074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 421111074
		arg_303_1.duration_ = 9.63

		local var_303_0 = {
			zh = 6.233,
			ja = 9.633
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play421111075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1047ui_story = arg_303_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1047ui_story"].transform.position).z)
				arg_303_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1047ui_story"].transform.localEulerAngles = arg_303_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_303_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1047ui_story"].transform.position).z)
				arg_303_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1047ui_story"].transform.localEulerAngles = arg_303_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_306_1 = arg_303_1.actors_["1047ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1047ui_story == nil then
				arg_303_1.var_.characterEffect1047ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect1047ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1047ui_story then
				arg_303_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_306_4 = 0
			local var_306_5 = 0.8

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_4 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_6 = arg_303_1:GetWordFromCfg(421111074)
				local var_306_7 = arg_303_1:FormatText(var_306_6.content)

				arg_303_1.text_.text = var_306_7

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_9 = 32 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 32)

				if (32 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 32)) > 0 and var_306_5 < var_306_9 then
					arg_303_1.talkMaxDuration = var_306_9

					if var_306_9 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_9 + var_306_4
					end
				end

				arg_303_1.text_.text = var_306_7
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111074", "story_v_out_421111.awb") ~= 0 then
					local var_306_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111074", "story_v_out_421111.awb") / 1000

					if var_306_10 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_10 + var_306_4
					end

					if var_306_6.prefab_name ~= "" and arg_303_1.actors_[var_306_6.prefab_name] ~= nil then
						local var_306_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_6.prefab_name].transform, "story_v_out_421111", "421111074", "story_v_out_421111.awb")

						arg_303_1:RecordAudio("421111074", var_306_11)
						arg_303_1:RecordAudio("421111074", var_306_11)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_421111", "421111074", "story_v_out_421111.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_421111", "421111074", "story_v_out_421111.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_12 = math.max(var_306_5, arg_303_1.talkMaxDuration)

			if var_306_4 <= arg_303_1.time_ and arg_303_1.time_ < var_306_4 + var_306_12 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_4) / var_306_12

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_4 + var_306_12 and arg_303_1.time_ < var_306_4 + var_306_12 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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

		arg_303_1:InitPlayNodeList()
	end,
	Play421111075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 421111075
		arg_307_1.duration_ = 12.4

		local var_307_0 = {
			zh = 9.6,
			ja = 12.4
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play421111076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if arg_307_1.bgs_.ST02 == nil then
				local var_310_0 = Object.Instantiate(arg_307_1.paintGo_)

				var_310_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_310_0.name = "ST02"
				var_310_0.transform.parent = arg_307_1.stage_.transform
				var_310_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_307_1.bgs_.ST02 = var_310_0
			end

			if 2 < arg_307_1.time_ and arg_307_1.time_ <= 2 + arg_310_0 then
				local var_310_1 = arg_307_1.bgs_.ST02

				arg_307_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_310_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_310_2 = var_310_1:GetComponent("SpriteRenderer")

				if var_310_2 and var_310_2.sprite then
					local var_310_3 = 2 * (var_310_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_310_1.transform.localScale = Vector3.New(var_310_3 / var_310_2.sprite.bounds.size.y < var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x and var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x or var_310_3 / var_310_2.sprite.bounds.size.y, var_310_3 / var_310_2.sprite.bounds.size.y < var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x and var_310_3 * manager.ui.mainCameraCom_.aspect / var_310_2.sprite.bounds.size.x or var_310_3 / var_310_2.sprite.bounds.size.y, 0)
				end

				for iter_310_0, iter_310_1 in pairs(arg_307_1.bgs_) do
					if iter_310_0 ~= "ST02" then
						iter_310_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_310_4 = 4

			if 4 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.allBtn_.enabled = false
			end

			if arg_307_1.time_ >= var_310_4 + 0.3 and arg_307_1.time_ < var_310_4 + 0.3 + arg_310_0 then
				arg_307_1.allBtn_.enabled = true
			end

			local var_310_5 = 0

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 then
				arg_307_1.mask_.enabled = true
				arg_307_1.mask_.raycastTarget = true

				arg_307_1:SetGaussion(false)
			end

			local var_310_6 = 2

			if var_310_5 <= arg_307_1.time_ and arg_307_1.time_ < var_310_5 + var_310_6 then
				local var_310_7 = Color.New(0, 0, 0)

				var_310_7.a = Mathf.Lerp(0, 1, (arg_307_1.time_ - var_310_5) / var_310_6)
				arg_307_1.mask_.color = var_310_7
			end

			if arg_307_1.time_ >= var_310_5 + var_310_6 and arg_307_1.time_ < var_310_5 + var_310_6 + arg_310_0 then
				local var_310_8 = Color.New(0, 0, 0)

				var_310_8.a = 1
				arg_307_1.mask_.color = var_310_8
			end

			local var_310_9 = 2

			if 2 < arg_307_1.time_ and arg_307_1.time_ <= var_310_9 + arg_310_0 then
				arg_307_1.mask_.enabled = true
				arg_307_1.mask_.raycastTarget = true

				arg_307_1:SetGaussion(false)
			end

			local var_310_10 = 2

			if var_310_9 <= arg_307_1.time_ and arg_307_1.time_ < var_310_9 + var_310_10 then
				local var_310_11 = Color.New(0, 0, 0)

				var_310_11.a = Mathf.Lerp(1, 0, (arg_307_1.time_ - var_310_9) / var_310_10)
				arg_307_1.mask_.color = var_310_11
			end

			if arg_307_1.time_ >= var_310_9 + var_310_10 and arg_307_1.time_ < var_310_9 + var_310_10 + arg_310_0 then
				local var_310_12 = Color.New(0, 0, 0)

				arg_307_1.mask_.enabled = false
				var_310_12.a = 0
				arg_307_1.mask_.color = var_310_12
			end

			local var_310_13 = arg_307_1.actors_["1047ui_story"].transform

			if 2 < arg_307_1.time_ and arg_307_1.time_ <= 2 + arg_310_0 then
				arg_307_1.var_.moveOldPos1047ui_story = var_310_13.localPosition
			end

			local var_310_14 = 0.001

			if 2 <= arg_307_1.time_ and arg_307_1.time_ < 2 + var_310_14 then
				var_310_13.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_307_1.time_ - 2) / var_310_14)
				var_310_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_13.position).x, (manager.ui.mainCamera.transform.position - var_310_13.position).y, (manager.ui.mainCamera.transform.position - var_310_13.position).z)
				var_310_13.localEulerAngles.z = 0
				var_310_13.localEulerAngles.x = 0
				var_310_13.localEulerAngles = var_310_13.localEulerAngles
			end

			if arg_307_1.time_ >= 2 + var_310_14 and arg_307_1.time_ < 2 + var_310_14 + arg_310_0 then
				var_310_13.localPosition = Vector3.New(0, 100, 0)
				var_310_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_13.position).x, (manager.ui.mainCamera.transform.position - var_310_13.position).y, (manager.ui.mainCamera.transform.position - var_310_13.position).z)
				var_310_13.localEulerAngles.z = 0
				var_310_13.localEulerAngles.x = 0
				var_310_13.localEulerAngles = var_310_13.localEulerAngles
			end

			local var_310_15 = arg_307_1.actors_["10102ui_story"].transform

			if 3.8 < arg_307_1.time_ and arg_307_1.time_ <= 3.8 + arg_310_0 then
				arg_307_1.var_.moveOldPos10102ui_story = var_310_15.localPosition
			end

			local var_310_16 = 0.001

			if 3.8 <= arg_307_1.time_ and arg_307_1.time_ < 3.8 + var_310_16 then
				var_310_15.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_307_1.time_ - 3.8) / var_310_16)
				var_310_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_15.position).x, (manager.ui.mainCamera.transform.position - var_310_15.position).y, (manager.ui.mainCamera.transform.position - var_310_15.position).z)
				var_310_15.localEulerAngles.z = 0
				var_310_15.localEulerAngles.x = 0
				var_310_15.localEulerAngles = var_310_15.localEulerAngles
			end

			if arg_307_1.time_ >= 3.8 + var_310_16 and arg_307_1.time_ < 3.8 + var_310_16 + arg_310_0 then
				var_310_15.localPosition = Vector3.New(0, -0.985, -6.275)
				var_310_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_15.position).x, (manager.ui.mainCamera.transform.position - var_310_15.position).y, (manager.ui.mainCamera.transform.position - var_310_15.position).z)
				var_310_15.localEulerAngles.z = 0
				var_310_15.localEulerAngles.x = 0
				var_310_15.localEulerAngles = var_310_15.localEulerAngles
			end

			local var_310_17 = arg_307_1.actors_["10102ui_story"]

			if 3.8 < arg_307_1.time_ and arg_307_1.time_ <= 3.8 + arg_310_0 and not isNil(var_310_17) and arg_307_1.var_.characterEffect10102ui_story == nil then
				arg_307_1.var_.characterEffect10102ui_story = var_310_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_18 = 0.200000002980232

			if 3.8 <= arg_307_1.time_ and arg_307_1.time_ < 3.8 + var_310_18 and not isNil(var_310_17) then
				if arg_307_1.var_.characterEffect10102ui_story and not isNil(var_310_17) then
					arg_307_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 3.8 + var_310_18 and arg_307_1.time_ < 3.8 + var_310_18 + arg_310_0 and not isNil(var_310_17) and arg_307_1.var_.characterEffect10102ui_story then
				arg_307_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 3.8 < arg_307_1.time_ and arg_307_1.time_ <= 3.8 + arg_310_0 then
				arg_307_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 3.8 < arg_307_1.time_ and arg_307_1.time_ <= 3.8 + arg_310_0 then
				arg_307_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_307_1.time_ and arg_307_1.time_ <= 0.1 + arg_310_0 then
				arg_307_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if 1.5 < arg_307_1.time_ and arg_307_1.time_ <= 1.5 + arg_310_0 then
				arg_307_1:AudioAction("play", "effect", "se_story_side_1068", "se_story_1068_restaurant", "")
			end

			if arg_307_1.frameCnt_ <= 1 then
				arg_307_1.dialog_:SetActive(false)
			end

			local var_310_22 = 4
			local var_310_23 = 0.775

			if 4 < arg_307_1.time_ and arg_307_1.time_ <= var_310_22 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0

				arg_307_1.dialog_:SetActive(true)

				arg_307_1.dialogCg_.alpha = 0

				local var_310_24 = LeanTween.value(arg_307_1.dialog_, 0, 1, 0.3)

				var_310_24:setOnUpdate(LuaHelper.FloatAction(function(arg_311_0)
					arg_307_1.dialogCg_.alpha = arg_311_0
				end))
				var_310_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_307_1.dialog_)
					var_310_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_307_1.duration_ = arg_307_1.duration_ + 0.3

				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_25 = arg_307_1:GetWordFromCfg(421111075)
				local var_310_26 = arg_307_1:FormatText(var_310_25.content)

				arg_307_1.text_.text = var_310_26

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_28 = 31 <= 0 and var_310_23 or var_310_23 * (utf8.len(var_310_26) / 31)

				if (31 <= 0 and var_310_23 or var_310_23 * (utf8.len(var_310_26) / 31)) > 0 and var_310_23 < var_310_28 then
					arg_307_1.talkMaxDuration = var_310_28
					var_310_22 = var_310_22 + 0.3

					if var_310_28 + var_310_22 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_28 + var_310_22
					end
				end

				arg_307_1.text_.text = var_310_26
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111075", "story_v_out_421111.awb") ~= 0 then
					local var_310_29 = manager.audio:GetVoiceLength("story_v_out_421111", "421111075", "story_v_out_421111.awb") / 1000

					if var_310_29 + var_310_22 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_29 + var_310_22
					end

					if var_310_25.prefab_name ~= "" and arg_307_1.actors_[var_310_25.prefab_name] ~= nil then
						local var_310_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_25.prefab_name].transform, "story_v_out_421111", "421111075", "story_v_out_421111.awb")

						arg_307_1:RecordAudio("421111075", var_310_30)
						arg_307_1:RecordAudio("421111075", var_310_30)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_421111", "421111075", "story_v_out_421111.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_421111", "421111075", "story_v_out_421111.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_31 = var_310_22 + 0.3
			local var_310_32 = math.max(var_310_23, arg_307_1.talkMaxDuration)

			if var_310_22 + 0.3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_31 + var_310_32 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_31) / var_310_32

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_31 + var_310_32 and arg_307_1.time_ < var_310_31 + var_310_32 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play421111076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 421111076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play421111077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_2")
			end

			local var_316_0 = arg_313_1.actors_["10102ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect10102ui_story == nil then
				arg_313_1.var_.characterEffect10102ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_1 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_1 and not isNil(var_316_0) then
				if arg_313_1.var_.characterEffect10102ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_313_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_1)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_1 and arg_313_1.time_ < 0 + var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect10102ui_story then
				arg_313_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_313_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_316_2 = 0
			local var_316_3 = 0.5

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_4 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(421111076).content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_6 = 20 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_4) / 20)

				if (20 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_4) / 20)) > 0 and var_316_3 < var_316_6 then
					arg_313_1.talkMaxDuration = var_316_6

					if var_316_6 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_2
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_3, arg_313_1.talkMaxDuration)

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_2) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_2 + var_316_7 and arg_313_1.time_ < var_316_2 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play421111077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 421111077
		arg_317_1.duration_ = 6.23

		local var_317_0 = {
			zh = 4.533,
			ja = 6.233
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
				arg_317_0:Play421111078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos10102ui_story = arg_317_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10102ui_story"].transform.position).z)
				arg_317_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["10102ui_story"].transform.localEulerAngles = arg_317_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_317_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10102ui_story"].transform.position).z)
				arg_317_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["10102ui_story"].transform.localEulerAngles = arg_317_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["10102ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect10102ui_story == nil then
				arg_317_1.var_.characterEffect10102ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect10102ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect10102ui_story then
				arg_317_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_320_4 = 0
			local var_320_5 = 0.525

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_6 = arg_317_1:GetWordFromCfg(421111077)
				local var_320_7 = arg_317_1:FormatText(var_320_6.content)

				arg_317_1.text_.text = var_320_7

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_9 = 21 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 21)

				if (21 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 21)) > 0 and var_320_5 < var_320_9 then
					arg_317_1.talkMaxDuration = var_320_9

					if var_320_9 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_9 + var_320_4
					end
				end

				arg_317_1.text_.text = var_320_7
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111077", "story_v_out_421111.awb") ~= 0 then
					local var_320_10 = manager.audio:GetVoiceLength("story_v_out_421111", "421111077", "story_v_out_421111.awb") / 1000

					if var_320_10 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_4
					end

					if var_320_6.prefab_name ~= "" and arg_317_1.actors_[var_320_6.prefab_name] ~= nil then
						local var_320_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_6.prefab_name].transform, "story_v_out_421111", "421111077", "story_v_out_421111.awb")

						arg_317_1:RecordAudio("421111077", var_320_11)
						arg_317_1:RecordAudio("421111077", var_320_11)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_421111", "421111077", "story_v_out_421111.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_421111", "421111077", "story_v_out_421111.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_12 = math.max(var_320_5, arg_317_1.talkMaxDuration)

			if var_320_4 <= arg_317_1.time_ and arg_317_1.time_ < var_320_4 + var_320_12 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_4) / var_320_12

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_4 + var_320_12 and arg_317_1.time_ < var_320_4 + var_320_12 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
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

		arg_317_1:InitPlayNodeList()
	end,
	Play421111078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 421111078
		arg_321_1.duration_ = 9.63

		local var_321_0 = {
			zh = 7.733,
			ja = 9.633
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
				arg_321_0:Play421111079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos10102ui_story = arg_321_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10102ui_story"].transform.position).z)
				arg_321_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["10102ui_story"].transform.localEulerAngles = arg_321_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_321_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10102ui_story"].transform.position).z)
				arg_321_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["10102ui_story"].transform.localEulerAngles = arg_321_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["1047ui_story"].transform

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1047ui_story = var_324_1.localPosition
			end

			local var_324_2 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 then
				var_324_1.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_321_1.time_ - 0) / var_324_2)
				var_324_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_1.position).x, (manager.ui.mainCamera.transform.position - var_324_1.position).y, (manager.ui.mainCamera.transform.position - var_324_1.position).z)
				var_324_1.localEulerAngles.z = 0
				var_324_1.localEulerAngles.x = 0
				var_324_1.localEulerAngles = var_324_1.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 then
				var_324_1.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_324_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_324_1.position).x, (manager.ui.mainCamera.transform.position - var_324_1.position).y, (manager.ui.mainCamera.transform.position - var_324_1.position).z)
				var_324_1.localEulerAngles.z = 0
				var_324_1.localEulerAngles.x = 0
				var_324_1.localEulerAngles = var_324_1.localEulerAngles
			end

			local var_324_3 = arg_321_1.actors_["1047ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_3) and arg_321_1.var_.characterEffect1047ui_story == nil then
				arg_321_1.var_.characterEffect1047ui_story = var_324_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_4 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 and not isNil(var_324_3) then
				if arg_321_1.var_.characterEffect1047ui_story and not isNil(var_324_3) then
					arg_321_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 and not isNil(var_324_3) and arg_321_1.var_.characterEffect1047ui_story then
				arg_321_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_324_6 = arg_321_1.actors_["10102ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_6) and arg_321_1.var_.characterEffect10102ui_story == nil then
				arg_321_1.var_.characterEffect10102ui_story = var_324_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_7 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 and not isNil(var_324_6) then
				if arg_321_1.var_.characterEffect10102ui_story and not isNil(var_324_6) then
					arg_321_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_321_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_7)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 and not isNil(var_324_6) and arg_321_1.var_.characterEffect10102ui_story then
				arg_321_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_321_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_324_8 = 0
			local var_324_9 = 0.9

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_8 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_10 = arg_321_1:GetWordFromCfg(421111078)
				local var_324_11 = arg_321_1:FormatText(var_324_10.content)

				arg_321_1.text_.text = var_324_11

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_13 = 36 <= 0 and var_324_9 or var_324_9 * (utf8.len(var_324_11) / 36)

				if (36 <= 0 and var_324_9 or var_324_9 * (utf8.len(var_324_11) / 36)) > 0 and var_324_9 < var_324_13 then
					arg_321_1.talkMaxDuration = var_324_13

					if var_324_13 + var_324_8 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_8
					end
				end

				arg_321_1.text_.text = var_324_11
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111078", "story_v_out_421111.awb") ~= 0 then
					local var_324_14 = manager.audio:GetVoiceLength("story_v_out_421111", "421111078", "story_v_out_421111.awb") / 1000

					if var_324_14 + var_324_8 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_14 + var_324_8
					end

					if var_324_10.prefab_name ~= "" and arg_321_1.actors_[var_324_10.prefab_name] ~= nil then
						local var_324_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_10.prefab_name].transform, "story_v_out_421111", "421111078", "story_v_out_421111.awb")

						arg_321_1:RecordAudio("421111078", var_324_15)
						arg_321_1:RecordAudio("421111078", var_324_15)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_421111", "421111078", "story_v_out_421111.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_421111", "421111078", "story_v_out_421111.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_16 = math.max(var_324_9, arg_321_1.talkMaxDuration)

			if var_324_8 <= arg_321_1.time_ and arg_321_1.time_ < var_324_8 + var_324_16 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_8) / var_324_16

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_8 + var_324_16 and arg_321_1.time_ < var_324_8 + var_324_16 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play421111079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 421111079
		arg_325_1.duration_ = 8.23

		local var_325_0 = {
			zh = 5.5,
			ja = 8.233
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play421111080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos10145ui_story = arg_325_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10145ui_story"].transform.position).z)
				arg_325_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["10145ui_story"].transform.localEulerAngles = arg_325_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_325_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["10145ui_story"].transform.position).z)
				arg_325_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["10145ui_story"].transform.localEulerAngles = arg_325_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["10145ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect10145ui_story == nil then
				arg_325_1.var_.characterEffect10145ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect10145ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect10145ui_story then
				arg_325_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_328_4 = arg_325_1.actors_["1047ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect1047ui_story == nil then
				arg_325_1.var_.characterEffect1047ui_story = var_328_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_5 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_5 and not isNil(var_328_4) then
				if arg_325_1.var_.characterEffect1047ui_story and not isNil(var_328_4) then
					arg_325_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_5)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_5 and arg_325_1.time_ < 0 + var_328_5 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect1047ui_story then
				arg_325_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_328_6 = 0
			local var_328_7 = 0.675

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_8 = arg_325_1:GetWordFromCfg(421111079)
				local var_328_9 = arg_325_1:FormatText(var_328_8.content)

				arg_325_1.text_.text = var_328_9

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_11 = 27 <= 0 and var_328_7 or var_328_7 * (utf8.len(var_328_9) / 27)

				if (27 <= 0 and var_328_7 or var_328_7 * (utf8.len(var_328_9) / 27)) > 0 and var_328_7 < var_328_11 then
					arg_325_1.talkMaxDuration = var_328_11

					if var_328_11 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_11 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_9
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111079", "story_v_out_421111.awb") ~= 0 then
					local var_328_12 = manager.audio:GetVoiceLength("story_v_out_421111", "421111079", "story_v_out_421111.awb") / 1000

					if var_328_12 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_12 + var_328_6
					end

					if var_328_8.prefab_name ~= "" and arg_325_1.actors_[var_328_8.prefab_name] ~= nil then
						local var_328_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_8.prefab_name].transform, "story_v_out_421111", "421111079", "story_v_out_421111.awb")

						arg_325_1:RecordAudio("421111079", var_328_13)
						arg_325_1:RecordAudio("421111079", var_328_13)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_421111", "421111079", "story_v_out_421111.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_421111", "421111079", "story_v_out_421111.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_14 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_14 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_14

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_14 and arg_325_1.time_ < var_328_6 + var_328_14 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play421111080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 421111080
		arg_329_1.duration_ = 6.27

		local var_329_0 = {
			zh = 3.8,
			ja = 6.266
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play421111081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos10102ui_story = arg_329_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["10102ui_story"].transform.position).z)
				arg_329_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["10102ui_story"].transform.localEulerAngles = arg_329_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_329_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["10102ui_story"].transform.position).z)
				arg_329_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["10102ui_story"].transform.localEulerAngles = arg_329_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["1047ui_story"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1047ui_story = var_332_1.localPosition
			end

			local var_332_2 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 then
				var_332_1.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_2)
				var_332_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_1.position).x, (manager.ui.mainCamera.transform.position - var_332_1.position).y, (manager.ui.mainCamera.transform.position - var_332_1.position).z)
				var_332_1.localEulerAngles.z = 0
				var_332_1.localEulerAngles.x = 0
				var_332_1.localEulerAngles = var_332_1.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 then
				var_332_1.localPosition = Vector3.New(0, 100, 0)
				var_332_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_1.position).x, (manager.ui.mainCamera.transform.position - var_332_1.position).y, (manager.ui.mainCamera.transform.position - var_332_1.position).z)
				var_332_1.localEulerAngles.z = 0
				var_332_1.localEulerAngles.x = 0
				var_332_1.localEulerAngles = var_332_1.localEulerAngles
			end

			local var_332_3 = arg_329_1.actors_["10102ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_3) and arg_329_1.var_.characterEffect10102ui_story == nil then
				arg_329_1.var_.characterEffect10102ui_story = var_332_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_4 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 and not isNil(var_332_3) then
				if arg_329_1.var_.characterEffect10102ui_story and not isNil(var_332_3) then
					arg_329_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 and not isNil(var_332_3) and arg_329_1.var_.characterEffect10102ui_story then
				arg_329_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_332_6 = arg_329_1.actors_["10145ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_6) and arg_329_1.var_.characterEffect10145ui_story == nil then
				arg_329_1.var_.characterEffect10145ui_story = var_332_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_7 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_7 and not isNil(var_332_6) then
				if arg_329_1.var_.characterEffect10145ui_story and not isNil(var_332_6) then
					arg_329_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_329_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_7)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_7 and arg_329_1.time_ < 0 + var_332_7 + arg_332_0 and not isNil(var_332_6) and arg_329_1.var_.characterEffect10145ui_story then
				arg_329_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_329_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_332_8 = 0
			local var_332_9 = 0.45

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_10 = arg_329_1:GetWordFromCfg(421111080)
				local var_332_11 = arg_329_1:FormatText(var_332_10.content)

				arg_329_1.text_.text = var_332_11

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_13 = 18 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_11) / 18)

				if (18 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_11) / 18)) > 0 and var_332_9 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_8
					end
				end

				arg_329_1.text_.text = var_332_11
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111080", "story_v_out_421111.awb") ~= 0 then
					local var_332_14 = manager.audio:GetVoiceLength("story_v_out_421111", "421111080", "story_v_out_421111.awb") / 1000

					if var_332_14 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_14 + var_332_8
					end

					if var_332_10.prefab_name ~= "" and arg_329_1.actors_[var_332_10.prefab_name] ~= nil then
						local var_332_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_10.prefab_name].transform, "story_v_out_421111", "421111080", "story_v_out_421111.awb")

						arg_329_1:RecordAudio("421111080", var_332_15)
						arg_329_1:RecordAudio("421111080", var_332_15)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_421111", "421111080", "story_v_out_421111.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_421111", "421111080", "story_v_out_421111.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_16 = math.max(var_332_9, arg_329_1.talkMaxDuration)

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_16 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_8) / var_332_16

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_8 + var_332_16 and arg_329_1.time_ < var_332_8 + var_332_16 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play421111081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 421111081
		arg_333_1.duration_ = 6.7

		local var_333_0 = {
			zh = 4.566,
			ja = 6.7
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play421111082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos10145ui_story = arg_333_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["10145ui_story"].transform.position).z)
				arg_333_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["10145ui_story"].transform.localEulerAngles = arg_333_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_333_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["10145ui_story"].transform.position).z)
				arg_333_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["10145ui_story"].transform.localEulerAngles = arg_333_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_336_1 = arg_333_1.actors_["10145ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect10145ui_story == nil then
				arg_333_1.var_.characterEffect10145ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_2 and not isNil(var_336_1) then
				if arg_333_1.var_.characterEffect10145ui_story and not isNil(var_336_1) then
					arg_333_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_2 and arg_333_1.time_ < 0 + var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect10145ui_story then
				arg_333_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_336_4 = arg_333_1.actors_["10102ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_4) and arg_333_1.var_.characterEffect10102ui_story == nil then
				arg_333_1.var_.characterEffect10102ui_story = var_336_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_5 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_5 and not isNil(var_336_4) then
				if arg_333_1.var_.characterEffect10102ui_story and not isNil(var_336_4) then
					arg_333_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_333_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_5)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_5 and arg_333_1.time_ < 0 + var_336_5 + arg_336_0 and not isNil(var_336_4) and arg_333_1.var_.characterEffect10102ui_story then
				arg_333_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_333_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_336_6 = 0
			local var_336_7 = 0.625

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_8 = arg_333_1:GetWordFromCfg(421111081)
				local var_336_9 = arg_333_1:FormatText(var_336_8.content)

				arg_333_1.text_.text = var_336_9

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 25 <= 0 and var_336_7 or var_336_7 * (utf8.len(var_336_9) / 25)

				if (25 <= 0 and var_336_7 or var_336_7 * (utf8.len(var_336_9) / 25)) > 0 and var_336_7 < var_336_11 then
					arg_333_1.talkMaxDuration = var_336_11

					if var_336_11 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_11 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_9
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111081", "story_v_out_421111.awb") ~= 0 then
					local var_336_12 = manager.audio:GetVoiceLength("story_v_out_421111", "421111081", "story_v_out_421111.awb") / 1000

					if var_336_12 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_12 + var_336_6
					end

					if var_336_8.prefab_name ~= "" and arg_333_1.actors_[var_336_8.prefab_name] ~= nil then
						local var_336_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_8.prefab_name].transform, "story_v_out_421111", "421111081", "story_v_out_421111.awb")

						arg_333_1:RecordAudio("421111081", var_336_13)
						arg_333_1:RecordAudio("421111081", var_336_13)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_421111", "421111081", "story_v_out_421111.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_421111", "421111081", "story_v_out_421111.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_14 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_14 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_14

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_14 and arg_333_1.time_ < var_336_6 + var_336_14 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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

		arg_333_1:InitPlayNodeList()
	end,
	Play421111082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 421111082
		arg_337_1.duration_ = 4.3

		local var_337_0 = {
			zh = 3.233,
			ja = 4.3
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play421111083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1047ui_story = arg_337_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1047ui_story"].transform.position).z)
				arg_337_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1047ui_story"].transform.localEulerAngles = arg_337_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_337_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1047ui_story"].transform.position).z)
				arg_337_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1047ui_story"].transform.localEulerAngles = arg_337_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_340_1 = arg_337_1.actors_["10102ui_story"].transform

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos10102ui_story = var_340_1.localPosition
			end

			local var_340_2 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 then
				var_340_1.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_337_1.time_ - 0) / var_340_2)
				var_340_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_340_1.position).x, (manager.ui.mainCamera.transform.position - var_340_1.position).y, (manager.ui.mainCamera.transform.position - var_340_1.position).z)
				var_340_1.localEulerAngles.z = 0
				var_340_1.localEulerAngles.x = 0
				var_340_1.localEulerAngles = var_340_1.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 then
				var_340_1.localPosition = Vector3.New(0, 100, 0)
				var_340_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_340_1.position).x, (manager.ui.mainCamera.transform.position - var_340_1.position).y, (manager.ui.mainCamera.transform.position - var_340_1.position).z)
				var_340_1.localEulerAngles.z = 0
				var_340_1.localEulerAngles.x = 0
				var_340_1.localEulerAngles = var_340_1.localEulerAngles
			end

			local var_340_3 = arg_337_1.actors_["1047ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_3) and arg_337_1.var_.characterEffect1047ui_story == nil then
				arg_337_1.var_.characterEffect1047ui_story = var_340_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_4 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 and not isNil(var_340_3) then
				if arg_337_1.var_.characterEffect1047ui_story and not isNil(var_340_3) then
					arg_337_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 and not isNil(var_340_3) and arg_337_1.var_.characterEffect1047ui_story then
				arg_337_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_340_6 = arg_337_1.actors_["10145ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_6) and arg_337_1.var_.characterEffect10145ui_story == nil then
				arg_337_1.var_.characterEffect10145ui_story = var_340_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_7 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 and not isNil(var_340_6) then
				if arg_337_1.var_.characterEffect10145ui_story and not isNil(var_340_6) then
					arg_337_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_337_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_7)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 and not isNil(var_340_6) and arg_337_1.var_.characterEffect10145ui_story then
				arg_337_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_337_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_340_8 = 0
			local var_340_9 = 0.425

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_8 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_10 = arg_337_1:GetWordFromCfg(421111082)
				local var_340_11 = arg_337_1:FormatText(var_340_10.content)

				arg_337_1.text_.text = var_340_11

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_13 = 17 <= 0 and var_340_9 or var_340_9 * (utf8.len(var_340_11) / 17)

				if (17 <= 0 and var_340_9 or var_340_9 * (utf8.len(var_340_11) / 17)) > 0 and var_340_9 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_8 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_8
					end
				end

				arg_337_1.text_.text = var_340_11
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111082", "story_v_out_421111.awb") ~= 0 then
					local var_340_14 = manager.audio:GetVoiceLength("story_v_out_421111", "421111082", "story_v_out_421111.awb") / 1000

					if var_340_14 + var_340_8 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_14 + var_340_8
					end

					if var_340_10.prefab_name ~= "" and arg_337_1.actors_[var_340_10.prefab_name] ~= nil then
						local var_340_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_10.prefab_name].transform, "story_v_out_421111", "421111082", "story_v_out_421111.awb")

						arg_337_1:RecordAudio("421111082", var_340_15)
						arg_337_1:RecordAudio("421111082", var_340_15)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_421111", "421111082", "story_v_out_421111.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_421111", "421111082", "story_v_out_421111.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_16 = math.max(var_340_9, arg_337_1.talkMaxDuration)

			if var_340_8 <= arg_337_1.time_ and arg_337_1.time_ < var_340_8 + var_340_16 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_8) / var_340_16

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_8 + var_340_16 and arg_337_1.time_ < var_340_8 + var_340_16 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
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

		arg_337_1:InitPlayNodeList()
	end,
	Play421111083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 421111083
		arg_341_1.duration_ = 2.93

		local var_341_0 = {
			zh = 2.066,
			ja = 2.933
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play421111084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos10145ui_story = arg_341_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["10145ui_story"].transform.position).z)
				arg_341_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["10145ui_story"].transform.localEulerAngles = arg_341_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_341_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["10145ui_story"].transform.position).z)
				arg_341_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["10145ui_story"].transform.localEulerAngles = arg_341_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["10145ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect10145ui_story == nil then
				arg_341_1.var_.characterEffect10145ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect10145ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect10145ui_story then
				arg_341_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_344_4 = arg_341_1.actors_["1047ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_4) and arg_341_1.var_.characterEffect1047ui_story == nil then
				arg_341_1.var_.characterEffect1047ui_story = var_344_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_5 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_5 and not isNil(var_344_4) then
				if arg_341_1.var_.characterEffect1047ui_story and not isNil(var_344_4) then
					arg_341_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_5)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_5 and arg_341_1.time_ < 0 + var_344_5 + arg_344_0 and not isNil(var_344_4) and arg_341_1.var_.characterEffect1047ui_story then
				arg_341_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_344_6 = 0
			local var_344_7 = 0.225

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_8 = arg_341_1:GetWordFromCfg(421111083)
				local var_344_9 = arg_341_1:FormatText(var_344_8.content)

				arg_341_1.text_.text = var_344_9

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_11 = 9 <= 0 and var_344_7 or var_344_7 * (utf8.len(var_344_9) / 9)

				if (9 <= 0 and var_344_7 or var_344_7 * (utf8.len(var_344_9) / 9)) > 0 and var_344_7 < var_344_11 then
					arg_341_1.talkMaxDuration = var_344_11

					if var_344_11 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_11 + var_344_6
					end
				end

				arg_341_1.text_.text = var_344_9
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111083", "story_v_out_421111.awb") ~= 0 then
					local var_344_12 = manager.audio:GetVoiceLength("story_v_out_421111", "421111083", "story_v_out_421111.awb") / 1000

					if var_344_12 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_12 + var_344_6
					end

					if var_344_8.prefab_name ~= "" and arg_341_1.actors_[var_344_8.prefab_name] ~= nil then
						local var_344_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_8.prefab_name].transform, "story_v_out_421111", "421111083", "story_v_out_421111.awb")

						arg_341_1:RecordAudio("421111083", var_344_13)
						arg_341_1:RecordAudio("421111083", var_344_13)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_421111", "421111083", "story_v_out_421111.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_421111", "421111083", "story_v_out_421111.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_14 = math.max(var_344_7, arg_341_1.talkMaxDuration)

			if var_344_6 <= arg_341_1.time_ and arg_341_1.time_ < var_344_6 + var_344_14 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_6) / var_344_14

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_6 + var_344_14 and arg_341_1.time_ < var_344_6 + var_344_14 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play421111084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 421111084
		arg_345_1.duration_ = 4.83

		local var_345_0 = {
			zh = 3.066,
			ja = 4.833
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play421111085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1047ui_story = arg_345_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).z)
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles = arg_345_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_345_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).z)
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles = arg_345_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["1047ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1047ui_story == nil then
				arg_345_1.var_.characterEffect1047ui_story = var_348_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 and not isNil(var_348_1) then
				if arg_345_1.var_.characterEffect1047ui_story and not isNil(var_348_1) then
					arg_345_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1047ui_story then
				arg_345_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_348_4 = arg_345_1.actors_["10145ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_4) and arg_345_1.var_.characterEffect10145ui_story == nil then
				arg_345_1.var_.characterEffect10145ui_story = var_348_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_5 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_5 and not isNil(var_348_4) then
				if arg_345_1.var_.characterEffect10145ui_story and not isNil(var_348_4) then
					arg_345_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_345_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_5)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_5 and arg_345_1.time_ < 0 + var_348_5 + arg_348_0 and not isNil(var_348_4) and arg_345_1.var_.characterEffect10145ui_story then
				arg_345_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_345_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_348_6 = 0
			local var_348_7 = 0.375

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_8 = arg_345_1:GetWordFromCfg(421111084)
				local var_348_9 = arg_345_1:FormatText(var_348_8.content)

				arg_345_1.text_.text = var_348_9

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 15 <= 0 and var_348_7 or var_348_7 * (utf8.len(var_348_9) / 15)

				if (15 <= 0 and var_348_7 or var_348_7 * (utf8.len(var_348_9) / 15)) > 0 and var_348_7 < var_348_11 then
					arg_345_1.talkMaxDuration = var_348_11

					if var_348_11 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_11 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_9
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111084", "story_v_out_421111.awb") ~= 0 then
					local var_348_12 = manager.audio:GetVoiceLength("story_v_out_421111", "421111084", "story_v_out_421111.awb") / 1000

					if var_348_12 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_12 + var_348_6
					end

					if var_348_8.prefab_name ~= "" and arg_345_1.actors_[var_348_8.prefab_name] ~= nil then
						local var_348_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_8.prefab_name].transform, "story_v_out_421111", "421111084", "story_v_out_421111.awb")

						arg_345_1:RecordAudio("421111084", var_348_13)
						arg_345_1:RecordAudio("421111084", var_348_13)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_421111", "421111084", "story_v_out_421111.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_421111", "421111084", "story_v_out_421111.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_14 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_14 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_14

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_14 and arg_345_1.time_ < var_348_6 + var_348_14 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
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

		arg_345_1:InitPlayNodeList()
	end,
	Play421111085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 421111085
		arg_349_1.duration_ = 5.23

		local var_349_0 = {
			zh = 3.333,
			ja = 5.233
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play421111086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos10102ui_story = arg_349_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10102ui_story"].transform.position).z)
				arg_349_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10102ui_story"].transform.localEulerAngles = arg_349_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.275)
				arg_349_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10102ui_story"].transform.position).z)
				arg_349_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10102ui_story"].transform.localEulerAngles = arg_349_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["1047ui_story"].transform

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1047ui_story = var_352_1.localPosition
			end

			local var_352_2 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 then
				var_352_1.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_2)
				var_352_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_1.position).x, (manager.ui.mainCamera.transform.position - var_352_1.position).y, (manager.ui.mainCamera.transform.position - var_352_1.position).z)
				var_352_1.localEulerAngles.z = 0
				var_352_1.localEulerAngles.x = 0
				var_352_1.localEulerAngles = var_352_1.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 then
				var_352_1.localPosition = Vector3.New(0, 100, 0)
				var_352_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_1.position).x, (manager.ui.mainCamera.transform.position - var_352_1.position).y, (manager.ui.mainCamera.transform.position - var_352_1.position).z)
				var_352_1.localEulerAngles.z = 0
				var_352_1.localEulerAngles.x = 0
				var_352_1.localEulerAngles = var_352_1.localEulerAngles
			end

			local var_352_3 = arg_349_1.actors_["10145ui_story"].transform

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos10145ui_story = var_352_3.localPosition
			end

			local var_352_4 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				var_352_3.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_4)
				var_352_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_3.position).x, (manager.ui.mainCamera.transform.position - var_352_3.position).y, (manager.ui.mainCamera.transform.position - var_352_3.position).z)
				var_352_3.localEulerAngles.z = 0
				var_352_3.localEulerAngles.x = 0
				var_352_3.localEulerAngles = var_352_3.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				var_352_3.localPosition = Vector3.New(0, 100, 0)
				var_352_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_3.position).x, (manager.ui.mainCamera.transform.position - var_352_3.position).y, (manager.ui.mainCamera.transform.position - var_352_3.position).z)
				var_352_3.localEulerAngles.z = 0
				var_352_3.localEulerAngles.x = 0
				var_352_3.localEulerAngles = var_352_3.localEulerAngles
			end

			local var_352_5 = arg_349_1.actors_["10102ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.characterEffect10102ui_story == nil then
				arg_349_1.var_.characterEffect10102ui_story = var_352_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_6 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_6 and not isNil(var_352_5) then
				if arg_349_1.var_.characterEffect10102ui_story and not isNil(var_352_5) then
					arg_349_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_6 and arg_349_1.time_ < 0 + var_352_6 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.characterEffect10102ui_story then
				arg_349_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			local var_352_8 = arg_349_1.actors_["1047ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_8) and arg_349_1.var_.characterEffect1047ui_story == nil then
				arg_349_1.var_.characterEffect1047ui_story = var_352_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_9 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_9 and not isNil(var_352_8) then
				if arg_349_1.var_.characterEffect1047ui_story and not isNil(var_352_8) then
					arg_349_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_9)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_9 and arg_349_1.time_ < 0 + var_352_9 + arg_352_0 and not isNil(var_352_8) and arg_349_1.var_.characterEffect1047ui_story then
				arg_349_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action2_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_352_10 = 0
			local var_352_11 = 0.35

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_10 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_12 = arg_349_1:GetWordFromCfg(421111085)
				local var_352_13 = arg_349_1:FormatText(var_352_12.content)

				arg_349_1.text_.text = var_352_13

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_15 = 14 <= 0 and var_352_11 or var_352_11 * (utf8.len(var_352_13) / 14)

				if (14 <= 0 and var_352_11 or var_352_11 * (utf8.len(var_352_13) / 14)) > 0 and var_352_11 < var_352_15 then
					arg_349_1.talkMaxDuration = var_352_15

					if var_352_15 + var_352_10 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_15 + var_352_10
					end
				end

				arg_349_1.text_.text = var_352_13
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421111", "421111085", "story_v_out_421111.awb") ~= 0 then
					local var_352_16 = manager.audio:GetVoiceLength("story_v_out_421111", "421111085", "story_v_out_421111.awb") / 1000

					if var_352_16 + var_352_10 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_16 + var_352_10
					end

					if var_352_12.prefab_name ~= "" and arg_349_1.actors_[var_352_12.prefab_name] ~= nil then
						local var_352_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_12.prefab_name].transform, "story_v_out_421111", "421111085", "story_v_out_421111.awb")

						arg_349_1:RecordAudio("421111085", var_352_17)
						arg_349_1:RecordAudio("421111085", var_352_17)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_421111", "421111085", "story_v_out_421111.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_421111", "421111085", "story_v_out_421111.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_18 = math.max(var_352_11, arg_349_1.talkMaxDuration)

			if var_352_10 <= arg_349_1.time_ and arg_349_1.time_ < var_352_10 + var_352_18 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_10) / var_352_18

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_10 + var_352_18 and arg_349_1.time_ < var_352_10 + var_352_18 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
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
				actorName = "1047ui_story",
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

		arg_349_1:InitPlayNodeList()
	end,
	Play421111086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 421111086
		arg_353_1.duration_ = 1

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"

			SetActive(arg_353_1.choicesGo_, true)

			for iter_354_0, iter_354_1 in ipairs(arg_353_1.choices_) do
				SetActive(iter_354_1.go, iter_354_0 <= 1)
			end

			arg_353_1.choices_[1].txt.text = arg_353_1:FormatText(StoryChoiceCfg[1358].name)
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play421111087(arg_353_1)
			end

			arg_353_1:RecordChoiceLog(421111086, 1358)
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["10102ui_story"]) and arg_353_1.var_.characterEffect10102ui_story == nil then
				arg_353_1.var_.characterEffect10102ui_story = arg_353_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["10102ui_story"]) then
				if arg_353_1.var_.characterEffect10102ui_story and not isNil(arg_353_1.actors_["10102ui_story"]) then
					arg_353_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_353_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_0)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["10102ui_story"]) and arg_353_1.var_.characterEffect10102ui_story then
				arg_353_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_353_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play421111087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 421111087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play421111088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0.7

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_1 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(421111087).content)

				arg_357_1.text_.text = var_360_1

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_3 = 28 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 28)

				if (28 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 28)) > 0 and var_360_0 < var_360_3 then
					arg_357_1.talkMaxDuration = var_360_3

					if var_360_3 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_3 + 0
					end
				end

				arg_357_1.text_.text = var_360_1
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_4 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_4

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play421111088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 421111088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play421111089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos10102ui_story = arg_361_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_364_0 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 then
				arg_361_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_361_1.time_ - 0) / var_364_0)
				arg_361_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["10102ui_story"].transform.position).z)
				arg_361_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["10102ui_story"].transform.localEulerAngles = arg_361_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 then
				arg_361_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_361_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["10102ui_story"].transform.position).z)
				arg_361_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["10102ui_story"].transform.localEulerAngles = arg_361_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if 0.1 < arg_361_1.time_ and arg_361_1.time_ <= 0.1 + arg_364_0 then
				arg_361_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_pad", "")
			end

			local var_364_2 = 0
			local var_364_3 = 1.15

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_2 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_4 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(421111088).content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_6 = 46 <= 0 and var_364_3 or var_364_3 * (utf8.len(var_364_4) / 46)

				if (46 <= 0 and var_364_3 or var_364_3 * (utf8.len(var_364_4) / 46)) > 0 and var_364_3 < var_364_6 then
					arg_361_1.talkMaxDuration = var_364_6

					if var_364_6 + var_364_2 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_6 + var_364_2
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_7 = math.max(var_364_3, arg_361_1.talkMaxDuration)

			if var_364_2 <= arg_361_1.time_ and arg_361_1.time_ < var_364_2 + var_364_7 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_2) / var_364_7

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_2 + var_364_7 and arg_361_1.time_ < var_364_2 + var_364_7 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play421111089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 421111089
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
			arg_365_1.auto_ = false
		end

		function arg_365_1.playNext_(arg_367_0)
			arg_365_1.onStoryFinished_()
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.575

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_1 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(421111089).content)

				arg_365_1.text_.text = var_368_1

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_3 = 23 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 23)

				if (23 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 23)) > 0 and var_368_0 < var_368_3 then
					arg_365_1.talkMaxDuration = var_368_3

					if var_368_3 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_3 + 0
					end
				end

				arg_365_1.text_.text = var_368_1
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_4 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_4

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0110a",
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/B13a",
		"TextureConfig/Background/ST02"
	},
	voices = {
		"story_v_out_421111.awb"
	}
}
