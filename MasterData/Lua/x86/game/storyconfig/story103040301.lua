return {
	Play304031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304031001
		arg_1_1.duration_ = 11.37

		local var_1_0 = {
			zh = 9.233,
			ja = 11.366
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
				arg_1_0:Play304031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B10a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B10a")
				var_4_0.name = "B10a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B10a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B10a

				arg_1_1.bgs_.B10a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B10a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 1.5
			local var_4_15 = 0.75

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[16].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:GetWordFromCfg(304031001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 30 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 30)

				if (30 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 30)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031001", "story_v_out_304031.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_304031", "304031001", "story_v_out_304031.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_304031", "304031001", "story_v_out_304031.awb")

						arg_1_1:RecordAudio("304031001", var_4_22)
						arg_1_1:RecordAudio("304031001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304031", "304031001", "story_v_out_304031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304031", "304031001", "story_v_out_304031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304031002
		arg_8_1.duration_ = 2.73

		local var_8_0 = {
			zh = 2.733,
			ja = 2.533
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play304031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.25

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[17].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10035_split_1")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(304031002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 10 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 10)

				if (10 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 10)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031002", "story_v_out_304031.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031002", "story_v_out_304031.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_304031", "304031002", "story_v_out_304031.awb")

						arg_8_1:RecordAudio("304031002", var_11_6)
						arg_8_1:RecordAudio("304031002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_304031", "304031002", "story_v_out_304031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_304031", "304031002", "story_v_out_304031.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play304031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304031003
		arg_12_1.duration_ = 7.1

		local var_12_0 = {
			zh = 4.333,
			ja = 7.1
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play304031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.55

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[18].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:GetWordFromCfg(304031003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 22 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 22)

				if (22 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 22)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031003", "story_v_out_304031.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031003", "story_v_out_304031.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_304031", "304031003", "story_v_out_304031.awb")

						arg_12_1:RecordAudio("304031003", var_15_6)
						arg_12_1:RecordAudio("304031003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_304031", "304031003", "story_v_out_304031.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_304031", "304031003", "story_v_out_304031.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play304031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304031004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play304031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.725

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(304031004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 69 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 69)

				if (69 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 69)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play304031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304031005
		arg_20_1.duration_ = 5.47

		local var_20_0 = {
			zh = 5.466,
			ja = 3.3
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play304031006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["2020ui_story"]) and arg_20_1.var_.characterEffect2020ui_story == nil then
				arg_20_1.var_.characterEffect2020ui_story = arg_20_1.actors_["2020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["2020ui_story"]) then
				if arg_20_1.var_.characterEffect2020ui_story and not isNil(arg_20_1.actors_["2020ui_story"]) then
					arg_20_1.var_.characterEffect2020ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["2020ui_story"]) and arg_20_1.var_.characterEffect2020ui_story then
				arg_20_1.var_.characterEffect2020ui_story.fillFlat = false
			end

			local var_23_2 = 0
			local var_23_3 = 0.55

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2020")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_4 = arg_20_1:GetWordFromCfg(304031005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 22 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 22)

				if (22 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 22)) > 0 and var_23_3 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031005", "story_v_out_304031.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_304031", "304031005", "story_v_out_304031.awb") / 1000

					if var_23_8 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_2
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_out_304031", "304031005", "story_v_out_304031.awb")

						arg_20_1:RecordAudio("304031005", var_23_9)
						arg_20_1:RecordAudio("304031005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_304031", "304031005", "story_v_out_304031.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_304031", "304031005", "story_v_out_304031.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_3, arg_20_1.talkMaxDuration)

			if var_23_2 <= arg_20_1.time_ and arg_20_1.time_ < var_23_2 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_2) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_2 + var_23_10 and arg_20_1.time_ < var_23_2 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play304031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304031006
		arg_24_1.duration_ = 8.5

		local var_24_0 = {
			zh = 8.5,
			ja = 6.533
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
				arg_24_0:Play304031007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["3008ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3008ui_story"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_24_1.stage_.transform)

				var_27_0.name = "3008ui_story"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["3008ui_story"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["3008ui_story" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["3008ui_story" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["3008ui_story" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_3 = arg_24_1.actors_["3008ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos3008ui_story = var_27_3.localPosition
			end

			local var_27_4 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos3008ui_story, Vector3.New(0, -1.51, -4.3), (arg_24_1.time_ - 0) / var_27_4)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				var_27_3.localPosition = Vector3.New(0, -1.51, -4.3)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			local var_27_5 = arg_24_1.actors_["3008ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect3008ui_story == nil then
				arg_24_1.var_.characterEffect3008ui_story = var_27_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_6 and not isNil(var_27_5) then
				if arg_24_1.var_.characterEffect3008ui_story and not isNil(var_27_5) then
					arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_6 and arg_24_1.time_ < 0 + var_27_6 + arg_27_0 and not isNil(var_27_5) and arg_24_1.var_.characterEffect3008ui_story then
				arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_27_8 = arg_24_1.actors_["2020ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_8) and arg_24_1.var_.characterEffect2020ui_story == nil then
				arg_24_1.var_.characterEffect2020ui_story = var_27_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_9 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_9 and not isNil(var_27_8) then
				if arg_24_1.var_.characterEffect2020ui_story and not isNil(var_27_8) then
					arg_24_1.var_.characterEffect2020ui_story.fillFlat = true
					arg_24_1.var_.characterEffect2020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_9)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_9 and arg_24_1.time_ < 0 + var_27_9 + arg_27_0 and not isNil(var_27_8) and arg_24_1.var_.characterEffect2020ui_story then
				arg_24_1.var_.characterEffect2020ui_story.fillFlat = true
				arg_24_1.var_.characterEffect2020ui_story.fillRatio = 0.5
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_27_10 = 0
			local var_27_11 = 0.975

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_12 = arg_24_1:GetWordFromCfg(304031006)
				local var_27_13 = arg_24_1:FormatText(var_27_12.content)

				arg_24_1.text_.text = var_27_13

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 39 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 39)

				if (39 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 39)) > 0 and var_27_11 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_13
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031006", "story_v_out_304031.awb") ~= 0 then
					local var_27_16 = manager.audio:GetVoiceLength("story_v_out_304031", "304031006", "story_v_out_304031.awb") / 1000

					if var_27_16 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_16 + var_27_10
					end

					if var_27_12.prefab_name ~= "" and arg_24_1.actors_[var_27_12.prefab_name] ~= nil then
						local var_27_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_12.prefab_name].transform, "story_v_out_304031", "304031006", "story_v_out_304031.awb")

						arg_24_1:RecordAudio("304031006", var_27_17)
						arg_24_1:RecordAudio("304031006", var_27_17)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304031", "304031006", "story_v_out_304031.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304031", "304031006", "story_v_out_304031.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_18 = math.max(var_27_11, arg_24_1.talkMaxDuration)

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_18 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_10) / var_27_18

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_10 + var_27_18 and arg_24_1.time_ < var_27_10 + var_27_18 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play304031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304031007
		arg_28_1.duration_ = 6.87

		local var_28_0 = {
			zh = 6.866,
			ja = 6.733
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
				arg_28_0:Play304031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["2030ui_story"]) and arg_28_1.var_.characterEffect2030ui_story == nil then
				arg_28_1.var_.characterEffect2030ui_story = arg_28_1.actors_["2030ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["2030ui_story"]) then
				if arg_28_1.var_.characterEffect2030ui_story and not isNil(arg_28_1.actors_["2030ui_story"]) then
					arg_28_1.var_.characterEffect2030ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["2030ui_story"]) and arg_28_1.var_.characterEffect2030ui_story then
				arg_28_1.var_.characterEffect2030ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["3008ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect3008ui_story == nil then
				arg_28_1.var_.characterEffect3008ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect3008ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_28_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect3008ui_story then
				arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_28_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_31_4 = 0
			local var_31_5 = 1

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[33].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_6 = arg_28_1:GetWordFromCfg(304031007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 40 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 40)

				if (40 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 40)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031007", "story_v_out_304031.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_304031", "304031007", "story_v_out_304031.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_304031", "304031007", "story_v_out_304031.awb")

						arg_28_1:RecordAudio("304031007", var_31_11)
						arg_28_1:RecordAudio("304031007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304031", "304031007", "story_v_out_304031.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304031", "304031007", "story_v_out_304031.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play304031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304031008
		arg_32_1.duration_ = 6.03

		local var_32_0 = {
			zh = 4.133,
			ja = 6.033
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
				arg_32_0:Play304031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["3008ui_story"]) and arg_32_1.var_.characterEffect3008ui_story == nil then
				arg_32_1.var_.characterEffect3008ui_story = arg_32_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["3008ui_story"]) then
				if arg_32_1.var_.characterEffect3008ui_story and not isNil(arg_32_1.actors_["3008ui_story"]) then
					arg_32_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["3008ui_story"]) and arg_32_1.var_.characterEffect3008ui_story then
				arg_32_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["2030ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect2030ui_story == nil then
				arg_32_1.var_.characterEffect2030ui_story = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect2030ui_story and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect2030ui_story.fillFlat = true
					arg_32_1.var_.characterEffect2030ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect2030ui_story then
				arg_32_1.var_.characterEffect2030ui_story.fillFlat = true
				arg_32_1.var_.characterEffect2030ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action5_2")
			end

			local var_35_4 = 0
			local var_35_5 = 0.55

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(304031008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 22 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 22)

				if (22 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 22)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031008", "story_v_out_304031.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_304031", "304031008", "story_v_out_304031.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_304031", "304031008", "story_v_out_304031.awb")

						arg_32_1:RecordAudio("304031008", var_35_11)
						arg_32_1:RecordAudio("304031008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_304031", "304031008", "story_v_out_304031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_304031", "304031008", "story_v_out_304031.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play304031009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304031009
		arg_36_1.duration_ = 7.43

		local var_36_0 = {
			zh = 7.433,
			ja = 6.5
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
				arg_36_0:Play304031010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["2020ui_story"]) and arg_36_1.var_.characterEffect2020ui_story == nil then
				arg_36_1.var_.characterEffect2020ui_story = arg_36_1.actors_["2020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["2020ui_story"]) then
				if arg_36_1.var_.characterEffect2020ui_story and not isNil(arg_36_1.actors_["2020ui_story"]) then
					arg_36_1.var_.characterEffect2020ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["2020ui_story"]) and arg_36_1.var_.characterEffect2020ui_story then
				arg_36_1.var_.characterEffect2020ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["3008ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect3008ui_story == nil then
				arg_36_1.var_.characterEffect3008ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect3008ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_36_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect3008ui_story then
				arg_36_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_36_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_39_4 = 0
			local var_39_5 = 0.85

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2020")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_6 = arg_36_1:GetWordFromCfg(304031009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 34 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 34)

				if (34 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 34)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031009", "story_v_out_304031.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_304031", "304031009", "story_v_out_304031.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_304031", "304031009", "story_v_out_304031.awb")

						arg_36_1:RecordAudio("304031009", var_39_11)
						arg_36_1:RecordAudio("304031009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_304031", "304031009", "story_v_out_304031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_304031", "304031009", "story_v_out_304031.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_12 and arg_36_1.time_ < var_39_4 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play304031010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304031010
		arg_40_1.duration_ = 3.87

		local var_40_0 = {
			zh = 3.533,
			ja = 3.866
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
				arg_40_0:Play304031011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["3008ui_story"]) and arg_40_1.var_.characterEffect3008ui_story == nil then
				arg_40_1.var_.characterEffect3008ui_story = arg_40_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["3008ui_story"]) then
				if arg_40_1.var_.characterEffect3008ui_story and not isNil(arg_40_1.actors_["3008ui_story"]) then
					arg_40_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["3008ui_story"]) and arg_40_1.var_.characterEffect3008ui_story then
				arg_40_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["2020ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect2020ui_story == nil then
				arg_40_1.var_.characterEffect2020ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect2020ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect2020ui_story.fillFlat = true
					arg_40_1.var_.characterEffect2020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect2020ui_story then
				arg_40_1.var_.characterEffect2020ui_story.fillFlat = true
				arg_40_1.var_.characterEffect2020ui_story.fillRatio = 0.5
			end

			local var_43_4 = 0
			local var_43_5 = 0.3

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(304031010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 12 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 12)

				if (12 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 12)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031010", "story_v_out_304031.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_304031", "304031010", "story_v_out_304031.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_304031", "304031010", "story_v_out_304031.awb")

						arg_40_1:RecordAudio("304031010", var_43_11)
						arg_40_1:RecordAudio("304031010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_304031", "304031010", "story_v_out_304031.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_304031", "304031010", "story_v_out_304031.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play304031011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304031011
		arg_44_1.duration_ = 7.13

		local var_44_0 = {
			zh = 4.533,
			ja = 7.133
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play304031012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_1")
			end

			local var_47_0 = 0
			local var_47_1 = 0.625

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(304031011)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 25 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_3) / 25)

				if (25 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_3) / 25)) > 0 and var_47_1 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031011", "story_v_out_304031.awb") ~= 0 then
					local var_47_6 = manager.audio:GetVoiceLength("story_v_out_304031", "304031011", "story_v_out_304031.awb") / 1000

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end

					if var_47_2.prefab_name ~= "" and arg_44_1.actors_[var_47_2.prefab_name] ~= nil then
						local var_47_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_2.prefab_name].transform, "story_v_out_304031", "304031011", "story_v_out_304031.awb")

						arg_44_1:RecordAudio("304031011", var_47_7)
						arg_44_1:RecordAudio("304031011", var_47_7)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_304031", "304031011", "story_v_out_304031.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_304031", "304031011", "story_v_out_304031.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_8 and arg_44_1.time_ < var_47_0 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play304031012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304031012
		arg_48_1.duration_ = 6.07

		local var_48_0 = {
			zh = 6.066,
			ja = 3.433
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play304031013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["2020ui_story"]) and arg_48_1.var_.characterEffect2020ui_story == nil then
				arg_48_1.var_.characterEffect2020ui_story = arg_48_1.actors_["2020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["2020ui_story"]) then
				if arg_48_1.var_.characterEffect2020ui_story and not isNil(arg_48_1.actors_["2020ui_story"]) then
					arg_48_1.var_.characterEffect2020ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["2020ui_story"]) and arg_48_1.var_.characterEffect2020ui_story then
				arg_48_1.var_.characterEffect2020ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["3008ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect3008ui_story == nil then
				arg_48_1.var_.characterEffect3008ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect3008ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_48_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect3008ui_story then
				arg_48_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_48_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_51_4 = 0
			local var_51_5 = 0.575

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2020")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_6 = arg_48_1:GetWordFromCfg(304031012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 23 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 23)

				if (23 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 23)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031012", "story_v_out_304031.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_304031", "304031012", "story_v_out_304031.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_304031", "304031012", "story_v_out_304031.awb")

						arg_48_1:RecordAudio("304031012", var_51_11)
						arg_48_1:RecordAudio("304031012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_304031", "304031012", "story_v_out_304031.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_304031", "304031012", "story_v_out_304031.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play304031013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304031013
		arg_52_1.duration_ = 5

		local var_52_0 = {
			zh = 3.233,
			ja = 5
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play304031014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["3008ui_story"]) and arg_52_1.var_.characterEffect3008ui_story == nil then
				arg_52_1.var_.characterEffect3008ui_story = arg_52_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["3008ui_story"]) then
				if arg_52_1.var_.characterEffect3008ui_story and not isNil(arg_52_1.actors_["3008ui_story"]) then
					arg_52_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["3008ui_story"]) and arg_52_1.var_.characterEffect3008ui_story then
				arg_52_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["2020ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect2020ui_story == nil then
				arg_52_1.var_.characterEffect2020ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect2020ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect2020ui_story.fillFlat = true
					arg_52_1.var_.characterEffect2020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect2020ui_story then
				arg_52_1.var_.characterEffect2020ui_story.fillFlat = true
				arg_52_1.var_.characterEffect2020ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008actionlink/3008action476")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_55_4 = 0
			local var_55_5 = 0.475

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(304031013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 19 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 19)

				if (19 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 19)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031013", "story_v_out_304031.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_304031", "304031013", "story_v_out_304031.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_304031", "304031013", "story_v_out_304031.awb")

						arg_52_1:RecordAudio("304031013", var_55_11)
						arg_52_1:RecordAudio("304031013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_304031", "304031013", "story_v_out_304031.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_304031", "304031013", "story_v_out_304031.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play304031014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 304031014
		arg_56_1.duration_ = 2.87

		local var_56_0 = {
			zh = 1.733,
			ja = 2.866
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
				arg_56_0:Play304031015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["2020ui_story"]) and arg_56_1.var_.characterEffect2020ui_story == nil then
				arg_56_1.var_.characterEffect2020ui_story = arg_56_1.actors_["2020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["2020ui_story"]) then
				if arg_56_1.var_.characterEffect2020ui_story and not isNil(arg_56_1.actors_["2020ui_story"]) then
					arg_56_1.var_.characterEffect2020ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["2020ui_story"]) and arg_56_1.var_.characterEffect2020ui_story then
				arg_56_1.var_.characterEffect2020ui_story.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["3008ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect3008ui_story == nil then
				arg_56_1.var_.characterEffect3008ui_story = var_59_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.characterEffect3008ui_story and not isNil(var_59_2) then
					arg_56_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_56_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_3)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect3008ui_story then
				arg_56_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_56_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_59_4 = 0
			local var_59_5 = 0.2

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2020")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_6 = arg_56_1:GetWordFromCfg(304031014)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 8 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 8)

				if (8 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 8)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031014", "story_v_out_304031.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_304031", "304031014", "story_v_out_304031.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_304031", "304031014", "story_v_out_304031.awb")

						arg_56_1:RecordAudio("304031014", var_59_11)
						arg_56_1:RecordAudio("304031014", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_304031", "304031014", "story_v_out_304031.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_304031", "304031014", "story_v_out_304031.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play304031015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 304031015
		arg_60_1.duration_ = 7.1

		local var_60_0 = {
			zh = 6.366,
			ja = 7.1
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
				arg_60_0:Play304031016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["3008ui_story"]) and arg_60_1.var_.characterEffect3008ui_story == nil then
				arg_60_1.var_.characterEffect3008ui_story = arg_60_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["3008ui_story"]) then
				if arg_60_1.var_.characterEffect3008ui_story and not isNil(arg_60_1.actors_["3008ui_story"]) then
					arg_60_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["3008ui_story"]) and arg_60_1.var_.characterEffect3008ui_story then
				arg_60_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["2020ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect2020ui_story == nil then
				arg_60_1.var_.characterEffect2020ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect2020ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect2020ui_story.fillFlat = true
					arg_60_1.var_.characterEffect2020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect2020ui_story then
				arg_60_1.var_.characterEffect2020ui_story.fillFlat = true
				arg_60_1.var_.characterEffect2020ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action6_2")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_63_4 = 0
			local var_63_5 = 0.8

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(304031015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 32 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 32)

				if (32 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 32)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031015", "story_v_out_304031.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_304031", "304031015", "story_v_out_304031.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_304031", "304031015", "story_v_out_304031.awb")

						arg_60_1:RecordAudio("304031015", var_63_11)
						arg_60_1:RecordAudio("304031015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_304031", "304031015", "story_v_out_304031.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_304031", "304031015", "story_v_out_304031.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play304031016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 304031016
		arg_64_1.duration_ = 2.8

		local var_64_0 = {
			zh = 2.5,
			ja = 2.8
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
				arg_64_0:Play304031017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["2020ui_story"]) and arg_64_1.var_.characterEffect2020ui_story == nil then
				arg_64_1.var_.characterEffect2020ui_story = arg_64_1.actors_["2020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["2020ui_story"]) then
				if arg_64_1.var_.characterEffect2020ui_story and not isNil(arg_64_1.actors_["2020ui_story"]) then
					arg_64_1.var_.characterEffect2020ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["2020ui_story"]) and arg_64_1.var_.characterEffect2020ui_story then
				arg_64_1.var_.characterEffect2020ui_story.fillFlat = false
			end

			local var_67_2 = arg_64_1.actors_["3008ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect3008ui_story == nil then
				arg_64_1.var_.characterEffect3008ui_story = var_67_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_3 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.characterEffect3008ui_story and not isNil(var_67_2) then
					arg_64_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_64_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_3)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect3008ui_story then
				arg_64_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_64_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_67_4 = 0
			local var_67_5 = 0.25

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2020")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_6 = arg_64_1:GetWordFromCfg(304031016)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 10 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 10)

				if (10 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 10)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031016", "story_v_out_304031.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_304031", "304031016", "story_v_out_304031.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_out_304031", "304031016", "story_v_out_304031.awb")

						arg_64_1:RecordAudio("304031016", var_67_11)
						arg_64_1:RecordAudio("304031016", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_304031", "304031016", "story_v_out_304031.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_304031", "304031016", "story_v_out_304031.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play304031017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 304031017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play304031018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos3008ui_story = arg_68_1.actors_["3008ui_story"].transform.localPosition
			end

			local var_71_0 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 then
				arg_68_1.actors_["3008ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_0)
				arg_68_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["3008ui_story"].transform.position).z)
				arg_68_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["3008ui_story"].transform.localEulerAngles = arg_68_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 then
				arg_68_1.actors_["3008ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["3008ui_story"].transform.position).z)
				arg_68_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["3008ui_story"].transform.localEulerAngles = arg_68_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			local var_71_1 = arg_68_1.actors_["2020ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect2020ui_story == nil then
				arg_68_1.var_.characterEffect2020ui_story = var_71_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_2 and not isNil(var_71_1) then
				if arg_68_1.var_.characterEffect2020ui_story and not isNil(var_71_1) then
					arg_68_1.var_.characterEffect2020ui_story.fillFlat = true
					arg_68_1.var_.characterEffect2020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_2)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_2 and arg_68_1.time_ < 0 + var_71_2 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect2020ui_story then
				arg_68_1.var_.characterEffect2020ui_story.fillFlat = true
				arg_68_1.var_.characterEffect2020ui_story.fillRatio = 0.5
			end

			local var_71_3 = 0
			local var_71_4 = 1.55

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_3 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_5 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(304031017).content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 62 <= 0 and var_71_4 or var_71_4 * (utf8.len(var_71_5) / 62)

				if (62 <= 0 and var_71_4 or var_71_4 * (utf8.len(var_71_5) / 62)) > 0 and var_71_4 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_3 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_3
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_8 = math.max(var_71_4, arg_68_1.talkMaxDuration)

			if var_71_3 <= arg_68_1.time_ and arg_68_1.time_ < var_71_3 + var_71_8 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_3) / var_71_8

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_3 + var_71_8 and arg_68_1.time_ < var_71_3 + var_71_8 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play304031018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 304031018
		arg_72_1.duration_ = 4.5

		local var_72_0 = {
			zh = 4.5,
			ja = 1.999999999999
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play304031019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if arg_72_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_75_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_72_1.stage_.transform)

				var_75_0.name = "1084ui_story"
				var_75_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["1084ui_story"] = var_75_0

				local var_75_1 = var_75_0:GetComponentInChildren(typeof(CharacterEffect))

				var_75_1.enabled = true

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_0, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end

				arg_72_1:ShowWeapon(var_75_1.transform, false)

				arg_72_1.var_["1084ui_story" .. "Animator"] = var_75_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_72_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_72_1.var_["1084ui_story" .. "LipSync"] = var_75_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_75_3 = arg_72_1.actors_["1084ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_3.localPosition
			end

			local var_75_4 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				var_75_3.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_72_1.time_ - 0) / var_75_4)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				var_75_3.localPosition = Vector3.New(0, -0.97, -6)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			local var_75_5 = arg_72_1.actors_["1084ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_6 and not isNil(var_75_5) then
				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_5) then
					arg_72_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_6 and arg_72_1.time_ < 0 + var_75_6 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect1084ui_story then
				arg_72_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_75_8 = 0
			local var_75_9 = 0.55

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_10 = arg_72_1:GetWordFromCfg(304031018)
				local var_75_11 = arg_72_1:FormatText(var_75_10.content)

				arg_72_1.text_.text = var_75_11

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_13 = 22 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_11) / 22)

				if (22 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_11) / 22)) > 0 and var_75_9 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_8
					end
				end

				arg_72_1.text_.text = var_75_11
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031018", "story_v_out_304031.awb") ~= 0 then
					local var_75_14 = manager.audio:GetVoiceLength("story_v_out_304031", "304031018", "story_v_out_304031.awb") / 1000

					if var_75_14 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_8
					end

					if var_75_10.prefab_name ~= "" and arg_72_1.actors_[var_75_10.prefab_name] ~= nil then
						local var_75_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_10.prefab_name].transform, "story_v_out_304031", "304031018", "story_v_out_304031.awb")

						arg_72_1:RecordAudio("304031018", var_75_15)
						arg_72_1:RecordAudio("304031018", var_75_15)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_304031", "304031018", "story_v_out_304031.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_304031", "304031018", "story_v_out_304031.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_9, arg_72_1.talkMaxDuration)

			if var_75_8 <= arg_72_1.time_ and arg_72_1.time_ < var_75_8 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_8) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_8 + var_75_16 and arg_72_1.time_ < var_75_8 + var_75_16 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play304031019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 304031019
		arg_76_1.duration_ = 3.53

		local var_76_0 = {
			zh = 3.533,
			ja = 1.333
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play304031020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.525

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:GetWordFromCfg(304031019)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 21 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 21)

				if (21 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 21)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031019", "story_v_out_304031.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031019", "story_v_out_304031.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_304031", "304031019", "story_v_out_304031.awb")

						arg_76_1:RecordAudio("304031019", var_79_6)
						arg_76_1:RecordAudio("304031019", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_304031", "304031019", "story_v_out_304031.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_304031", "304031019", "story_v_out_304031.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play304031020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 304031020
		arg_80_1.duration_ = 5.3

		local var_80_0 = {
			zh = 5.3,
			ja = 5.1
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
				arg_80_0:Play304031021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if arg_80_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_83_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_80_1.stage_.transform)

				var_83_0.name = "1019ui_story"
				var_83_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["1019ui_story"] = var_83_0

				local var_83_1 = var_83_0:GetComponentInChildren(typeof(CharacterEffect))

				var_83_1.enabled = true

				local var_83_2 = GameObjectTools.GetOrAddComponent(var_83_0, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(false)
				end

				arg_80_1:ShowWeapon(var_83_1.transform, false)

				arg_80_1.var_["1019ui_story" .. "Animator"] = var_83_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_80_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_80_1.var_["1019ui_story" .. "LipSync"] = var_83_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_83_3 = arg_80_1.actors_["1019ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1019ui_story = var_83_3.localPosition
			end

			local var_83_4 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				var_83_3.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_80_1.time_ - 0) / var_83_4)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				var_83_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			local var_83_5 = arg_80_1.actors_["1084ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1084ui_story = var_83_5.localPosition
			end

			local var_83_6 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_6 then
				var_83_5.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_6)
				var_83_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_5.position).x, (manager.ui.mainCamera.transform.position - var_83_5.position).y, (manager.ui.mainCamera.transform.position - var_83_5.position).z)
				var_83_5.localEulerAngles.z = 0
				var_83_5.localEulerAngles.x = 0
				var_83_5.localEulerAngles = var_83_5.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_6 and arg_80_1.time_ < 0 + var_83_6 + arg_83_0 then
				var_83_5.localPosition = Vector3.New(0, 100, 0)
				var_83_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_5.position).x, (manager.ui.mainCamera.transform.position - var_83_5.position).y, (manager.ui.mainCamera.transform.position - var_83_5.position).z)
				var_83_5.localEulerAngles.z = 0
				var_83_5.localEulerAngles.x = 0
				var_83_5.localEulerAngles = var_83_5.localEulerAngles
			end

			local var_83_7 = arg_80_1.actors_["1019ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_7) and arg_80_1.var_.characterEffect1019ui_story == nil then
				arg_80_1.var_.characterEffect1019ui_story = var_83_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_8 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_8 and not isNil(var_83_7) then
				if arg_80_1.var_.characterEffect1019ui_story and not isNil(var_83_7) then
					arg_80_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_8 and arg_80_1.time_ < 0 + var_83_8 + arg_83_0 and not isNil(var_83_7) and arg_80_1.var_.characterEffect1019ui_story then
				arg_80_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_83_10 = arg_80_1.actors_["1084ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_10) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = var_83_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_11 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_11 and not isNil(var_83_10) then
				if arg_80_1.var_.characterEffect1084ui_story and not isNil(var_83_10) then
					arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_11)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_11 and arg_80_1.time_ < 0 + var_83_11 + arg_83_0 and not isNil(var_83_10) and arg_80_1.var_.characterEffect1084ui_story then
				arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_83_12 = 0
			local var_83_13 = 0.725

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_14 = arg_80_1:GetWordFromCfg(304031020)
				local var_83_15 = arg_80_1:FormatText(var_83_14.content)

				arg_80_1.text_.text = var_83_15

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_17 = 29 <= 0 and var_83_13 or var_83_13 * (utf8.len(var_83_15) / 29)

				if (29 <= 0 and var_83_13 or var_83_13 * (utf8.len(var_83_15) / 29)) > 0 and var_83_13 < var_83_17 then
					arg_80_1.talkMaxDuration = var_83_17

					if var_83_17 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_17 + var_83_12
					end
				end

				arg_80_1.text_.text = var_83_15
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031020", "story_v_out_304031.awb") ~= 0 then
					local var_83_18 = manager.audio:GetVoiceLength("story_v_out_304031", "304031020", "story_v_out_304031.awb") / 1000

					if var_83_18 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_18 + var_83_12
					end

					if var_83_14.prefab_name ~= "" and arg_80_1.actors_[var_83_14.prefab_name] ~= nil then
						local var_83_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_14.prefab_name].transform, "story_v_out_304031", "304031020", "story_v_out_304031.awb")

						arg_80_1:RecordAudio("304031020", var_83_19)
						arg_80_1:RecordAudio("304031020", var_83_19)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_304031", "304031020", "story_v_out_304031.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_304031", "304031020", "story_v_out_304031.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_20 = math.max(var_83_13, arg_80_1.talkMaxDuration)

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_20 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_12) / var_83_20

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_12 + var_83_20 and arg_80_1.time_ < var_83_12 + var_83_20 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play304031021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 304031021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play304031022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1019ui_story"]) and arg_84_1.var_.characterEffect1019ui_story == nil then
				arg_84_1.var_.characterEffect1019ui_story = arg_84_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1019ui_story"]) then
				if arg_84_1.var_.characterEffect1019ui_story and not isNil(arg_84_1.actors_["1019ui_story"]) then
					arg_84_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1019ui_story"]) and arg_84_1.var_.characterEffect1019ui_story then
				arg_84_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_87_1 = 0
			local var_87_2 = 1.3

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(304031021).content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 52 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 52)

				if (52 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 52)) > 0 and var_87_2 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_6 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_6 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_6

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_6 and arg_84_1.time_ < var_87_1 + var_87_6 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play304031022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 304031022
		arg_88_1.duration_ = 6.87

		local var_88_0 = {
			zh = 4.2,
			ja = 6.866
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
				arg_88_0:Play304031023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1019ui_story"]) and arg_88_1.var_.characterEffect1019ui_story == nil then
				arg_88_1.var_.characterEffect1019ui_story = arg_88_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1019ui_story"]) then
				if arg_88_1.var_.characterEffect1019ui_story and not isNil(arg_88_1.actors_["1019ui_story"]) then
					arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1019ui_story"]) and arg_88_1.var_.characterEffect1019ui_story then
				arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_91_2 = 0
			local var_91_3 = 0.775

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_4 = arg_88_1:GetWordFromCfg(304031022)
				local var_91_5 = arg_88_1:FormatText(var_91_4.content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 31 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 31)

				if (31 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 31)) > 0 and var_91_3 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031022", "story_v_out_304031.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_304031", "304031022", "story_v_out_304031.awb") / 1000

					if var_91_8 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_2
					end

					if var_91_4.prefab_name ~= "" and arg_88_1.actors_[var_91_4.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_4.prefab_name].transform, "story_v_out_304031", "304031022", "story_v_out_304031.awb")

						arg_88_1:RecordAudio("304031022", var_91_9)
						arg_88_1:RecordAudio("304031022", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_304031", "304031022", "story_v_out_304031.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_304031", "304031022", "story_v_out_304031.awb")
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
	Play304031023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 304031023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play304031024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1019ui_story"]) and arg_92_1.var_.characterEffect1019ui_story == nil then
				arg_92_1.var_.characterEffect1019ui_story = arg_92_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1019ui_story"]) then
				if arg_92_1.var_.characterEffect1019ui_story and not isNil(arg_92_1.actors_["1019ui_story"]) then
					arg_92_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_0)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1019ui_story"]) and arg_92_1.var_.characterEffect1019ui_story then
				arg_92_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_95_1 = 0
			local var_95_2 = 0.75

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_92_1.callingController_:SetSelectedState("calling")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(304031023).content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 29 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 29)

				if (29 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 29)) > 0 and var_95_2 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_6 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_6 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_6

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_6 and arg_92_1.time_ < var_95_1 + var_95_6 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play304031024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 304031024
		arg_96_1.duration_ = 5.5

		local var_96_0 = {
			zh = 5.5,
			ja = 4.933
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
				arg_96_0:Play304031025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1019ui_story"]) and arg_96_1.var_.characterEffect1019ui_story == nil then
				arg_96_1.var_.characterEffect1019ui_story = arg_96_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1019ui_story"]) then
				if arg_96_1.var_.characterEffect1019ui_story and not isNil(arg_96_1.actors_["1019ui_story"]) then
					arg_96_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1019ui_story"]) and arg_96_1.var_.characterEffect1019ui_story then
				arg_96_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_99_2 = 0
			local var_99_3 = 0.7

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:GetWordFromCfg(304031024)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 28 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 28)

				if (28 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 28)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031024", "story_v_out_304031.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_304031", "304031024", "story_v_out_304031.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_out_304031", "304031024", "story_v_out_304031.awb")

						arg_96_1:RecordAudio("304031024", var_99_9)
						arg_96_1:RecordAudio("304031024", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_304031", "304031024", "story_v_out_304031.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_304031", "304031024", "story_v_out_304031.awb")
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
	Play304031025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 304031025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play304031026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1019ui_story"]) and arg_100_1.var_.characterEffect1019ui_story == nil then
				arg_100_1.var_.characterEffect1019ui_story = arg_100_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1019ui_story"]) then
				if arg_100_1.var_.characterEffect1019ui_story and not isNil(arg_100_1.actors_["1019ui_story"]) then
					arg_100_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1019ui_story"]) and arg_100_1.var_.characterEffect1019ui_story then
				arg_100_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 1.1

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("calling")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(304031025).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 44 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 44)

				if (44 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 44)) > 0 and var_103_2 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_6 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_6 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_6

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_6 and arg_100_1.time_ < var_103_1 + var_103_6 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play304031026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 304031026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play304031027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 1.075

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_104_1.callingController_:SetSelectedState("calling")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(304031026).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 41 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 41)

				if (41 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 41)) > 0 and var_107_0 < var_107_3 then
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
	Play304031027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 304031027
		arg_108_1.duration_ = 13.32

		local var_108_0 = {
			zh = 11.083,
			ja = 13.316
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
				arg_108_0:Play304031028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if arg_108_1.bgs_.B02a == nil then
				local var_111_0 = Object.Instantiate(arg_108_1.paintGo_)

				var_111_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B02a")
				var_111_0.name = "B02a"
				var_111_0.transform.parent = arg_108_1.stage_.transform
				var_111_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_108_1.bgs_.B02a = var_111_0
			end

			if 1 < arg_108_1.time_ and arg_108_1.time_ <= 1 + arg_111_0 then
				local var_111_1 = arg_108_1.bgs_.B02a

				arg_108_1.bgs_.B02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_111_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_111_2 = var_111_1:GetComponent("SpriteRenderer")

				if var_111_2 and var_111_2.sprite then
					local var_111_3 = 2 * (var_111_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_111_1.transform.localScale = Vector3.New(var_111_3 / var_111_2.sprite.bounds.size.y < var_111_3 * manager.ui.mainCameraCom_.aspect / var_111_2.sprite.bounds.size.x and var_111_3 * manager.ui.mainCameraCom_.aspect / var_111_2.sprite.bounds.size.x or var_111_3 / var_111_2.sprite.bounds.size.y, var_111_3 / var_111_2.sprite.bounds.size.y < var_111_3 * manager.ui.mainCameraCom_.aspect / var_111_2.sprite.bounds.size.x and var_111_3 * manager.ui.mainCameraCom_.aspect / var_111_2.sprite.bounds.size.x or var_111_3 / var_111_2.sprite.bounds.size.y, 0)
				end

				for iter_111_0, iter_111_1 in pairs(arg_108_1.bgs_) do
					if iter_111_0 ~= "B02a" then
						iter_111_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_111_4 = 1.6

			if 1.6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.allBtn_.enabled = false
			end

			if arg_108_1.time_ >= var_111_4 + 0.3 and arg_108_1.time_ < var_111_4 + 0.3 + arg_111_0 then
				arg_108_1.allBtn_.enabled = true
			end

			local var_111_5 = 0

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1.mask_.enabled = true
				arg_108_1.mask_.raycastTarget = true

				arg_108_1:SetGaussion(false)
			end

			local var_111_6 = 1

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_6 then
				local var_111_7 = Color.New(0, 0, 0)

				var_111_7.a = Mathf.Lerp(0, 1, (arg_108_1.time_ - var_111_5) / var_111_6)
				arg_108_1.mask_.color = var_111_7
			end

			if arg_108_1.time_ >= var_111_5 + var_111_6 and arg_108_1.time_ < var_111_5 + var_111_6 + arg_111_0 then
				local var_111_8 = Color.New(0, 0, 0)

				var_111_8.a = 1
				arg_108_1.mask_.color = var_111_8
			end

			local var_111_9 = 1

			if 1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_9 + arg_111_0 then
				arg_108_1.mask_.enabled = true
				arg_108_1.mask_.raycastTarget = true

				arg_108_1:SetGaussion(false)
			end

			local var_111_10 = 1.1

			if var_111_9 <= arg_108_1.time_ and arg_108_1.time_ < var_111_9 + var_111_10 then
				local var_111_11 = Color.New(0, 0, 0)

				var_111_11.a = Mathf.Lerp(1, 0, (arg_108_1.time_ - var_111_9) / var_111_10)
				arg_108_1.mask_.color = var_111_11
			end

			if arg_108_1.time_ >= var_111_9 + var_111_10 and arg_108_1.time_ < var_111_9 + var_111_10 + arg_111_0 then
				local var_111_12 = Color.New(0, 0, 0)

				arg_108_1.mask_.enabled = false
				var_111_12.a = 0
				arg_108_1.mask_.color = var_111_12
			end

			local var_111_13 = arg_108_1.actors_["1019ui_story"].transform

			if 1 < arg_108_1.time_ and arg_108_1.time_ <= 1 + arg_111_0 then
				arg_108_1.var_.moveOldPos1019ui_story = var_111_13.localPosition
			end

			local var_111_14 = 0.001

			if 1 <= arg_108_1.time_ and arg_108_1.time_ < 1 + var_111_14 then
				var_111_13.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 1) / var_111_14)
				var_111_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_13.position).x, (manager.ui.mainCamera.transform.position - var_111_13.position).y, (manager.ui.mainCamera.transform.position - var_111_13.position).z)
				var_111_13.localEulerAngles.z = 0
				var_111_13.localEulerAngles.x = 0
				var_111_13.localEulerAngles = var_111_13.localEulerAngles
			end

			if arg_108_1.time_ >= 1 + var_111_14 and arg_108_1.time_ < 1 + var_111_14 + arg_111_0 then
				var_111_13.localPosition = Vector3.New(0, 100, 0)
				var_111_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_13.position).x, (manager.ui.mainCamera.transform.position - var_111_13.position).y, (manager.ui.mainCamera.transform.position - var_111_13.position).z)
				var_111_13.localEulerAngles.z = 0
				var_111_13.localEulerAngles.x = 0
				var_111_13.localEulerAngles = var_111_13.localEulerAngles
			end

			local var_111_15 = 1

			if 1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1.timestampController_:SetSelectedState("show")
				arg_108_1.timestampAni_:Play("in")

				arg_108_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B02a")

				arg_108_1.timestampColorController_:SetSelectedState("cold")
				arg_108_1.timeColdImg_:SetAlpha(0.031)

				arg_108_1.text_timeText_.text = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(102).content)
				arg_108_1.text_timeText_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_timeText_)

				arg_108_1.text_siteText_.text = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(501133).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_siteText_)
			end

			if arg_108_1.time_ >= var_111_15 + 3 and arg_108_1.time_ < var_111_15 + 3 + arg_111_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_108_1.timestampAni_, "out", function()
					arg_108_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_111_16 = 4

			if 4 < arg_108_1.time_ and arg_108_1.time_ <= var_111_16 + arg_111_0 then
				arg_108_1.mask_.enabled = true
				arg_108_1.mask_.raycastTarget = true

				arg_108_1:SetGaussion(false)
			end

			local var_111_17 = 1.2

			if var_111_16 <= arg_108_1.time_ and arg_108_1.time_ < var_111_16 + var_111_17 then
				local var_111_18 = Color.New(0, 0, 0)

				var_111_18.a = Mathf.Lerp(0, 1, (arg_108_1.time_ - var_111_16) / var_111_17)
				arg_108_1.mask_.color = var_111_18
			end

			if arg_108_1.time_ >= var_111_16 + var_111_17 and arg_108_1.time_ < var_111_16 + var_111_17 + arg_111_0 then
				local var_111_19 = Color.New(0, 0, 0)

				var_111_19.a = 1
				arg_108_1.mask_.color = var_111_19
			end

			local var_111_20 = 5.2

			if 5.2 < arg_108_1.time_ and arg_108_1.time_ <= var_111_20 + arg_111_0 then
				arg_108_1.mask_.enabled = true
				arg_108_1.mask_.raycastTarget = true

				arg_108_1:SetGaussion(false)
			end

			local var_111_21 = 1.26666666666667

			if var_111_20 <= arg_108_1.time_ and arg_108_1.time_ < var_111_20 + var_111_21 then
				local var_111_22 = Color.New(0, 0, 0)

				var_111_22.a = Mathf.Lerp(1, 0, (arg_108_1.time_ - var_111_20) / var_111_21)
				arg_108_1.mask_.color = var_111_22
			end

			if arg_108_1.time_ >= var_111_20 + var_111_21 and arg_108_1.time_ < var_111_20 + var_111_21 + arg_111_0 then
				local var_111_23 = Color.New(0, 0, 0)

				arg_108_1.mask_.enabled = false
				var_111_23.a = 0
				arg_108_1.mask_.color = var_111_23
			end

			local var_111_24 = 0

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_24 + arg_111_0 then
				arg_108_1.allBtn_.enabled = false
			end

			if arg_108_1.time_ >= var_111_24 + 6.46666666666666 and arg_108_1.time_ < var_111_24 + 6.46666666666666 + arg_111_0 then
				arg_108_1.allBtn_.enabled = true
			end

			if 1.2 < arg_108_1.time_ and arg_108_1.time_ <= 1.2 + arg_111_0 then
				arg_108_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0.2 < arg_108_1.time_ and arg_108_1.time_ <= 0.2 + arg_111_0 then
				arg_108_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if arg_108_1.frameCnt_ <= 1 then
				arg_108_1.dialog_:SetActive(false)
			end

			local var_111_27 = 6.74999999999999
			local var_111_28 = 0.45

			if 6.74999999999999 < arg_108_1.time_ and arg_108_1.time_ <= var_111_27 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0

				arg_108_1.dialog_:SetActive(true)

				arg_108_1.dialogCg_.alpha = 0

				local var_111_29 = LeanTween.value(arg_108_1.dialog_, 0, 1, 0.3)

				var_111_29:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_108_1.dialogCg_.alpha = arg_113_0
				end))
				var_111_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_108_1.dialog_)
					var_111_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_108_1.duration_ = arg_108_1.duration_ + 0.3

				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2020")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_30 = arg_108_1:GetWordFromCfg(304031027)
				local var_111_31 = arg_108_1:FormatText(var_111_30.content)

				arg_108_1.text_.text = var_111_31

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_33 = 18 <= 0 and var_111_28 or var_111_28 * (utf8.len(var_111_31) / 18)

				if (18 <= 0 and var_111_28 or var_111_28 * (utf8.len(var_111_31) / 18)) > 0 and var_111_28 < var_111_33 then
					arg_108_1.talkMaxDuration = var_111_33
					var_111_27 = var_111_27 + 0.3

					if var_111_33 + var_111_27 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_33 + var_111_27
					end
				end

				arg_108_1.text_.text = var_111_31
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031027", "story_v_out_304031.awb") ~= 0 then
					local var_111_34 = manager.audio:GetVoiceLength("story_v_out_304031", "304031027", "story_v_out_304031.awb") / 1000

					if var_111_34 + var_111_27 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_34 + var_111_27
					end

					if var_111_30.prefab_name ~= "" and arg_108_1.actors_[var_111_30.prefab_name] ~= nil then
						local var_111_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_30.prefab_name].transform, "story_v_out_304031", "304031027", "story_v_out_304031.awb")

						arg_108_1:RecordAudio("304031027", var_111_35)
						arg_108_1:RecordAudio("304031027", var_111_35)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_304031", "304031027", "story_v_out_304031.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_304031", "304031027", "story_v_out_304031.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_36 = var_111_27 + 0.3
			local var_111_37 = math.max(var_111_28, arg_108_1.talkMaxDuration)

			if var_111_27 + 0.3 <= arg_108_1.time_ and arg_108_1.time_ < var_111_36 + var_111_37 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_36) / var_111_37

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_36 + var_111_37 and arg_108_1.time_ < var_111_36 + var_111_37 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play304031028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 304031028
		arg_115_1.duration_ = 4.67

		local var_115_0 = {
			zh = 4.1,
			ja = 4.666
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
				arg_115_0:Play304031029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if arg_115_1.actors_["2030_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2030_tpose"))) then
				local var_118_0 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_115_1.stage_.transform)

				var_118_0.name = "2030_tpose"
				var_118_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_["2030_tpose"] = var_118_0

				local var_118_1 = var_118_0:GetComponentInChildren(typeof(CharacterEffect))

				var_118_1.enabled = true

				local var_118_2 = GameObjectTools.GetOrAddComponent(var_118_0, typeof(DynamicBoneHelper))

				if var_118_2 then
					var_118_2:EnableDynamicBone(false)
				end

				arg_115_1:ShowWeapon(var_118_1.transform, false)

				arg_115_1.var_["2030_tpose" .. "Animator"] = var_118_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_115_1.var_["2030_tpose" .. "Animator"].applyRootMotion = true
				arg_115_1.var_["2030_tpose" .. "LipSync"] = var_118_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_118_3 = arg_115_1.actors_["2030_tpose"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos2030_tpose = var_118_3.localPosition

				local var_118_4 = GameObjectTools.GetOrAddComponent(var_118_3.gameObject, typeof(DynamicBoneHelper))

				if var_118_4 then
					var_118_4:EnableDynamicBone(false)
				end
			end

			local var_118_5 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_5 then
				var_118_3.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos2030_tpose, Vector3.New(0, -1.2, -4.2), (arg_115_1.time_ - 0) / var_118_5)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_5 and arg_115_1.time_ < 0 + var_118_5 + arg_118_0 then
				var_118_3.localPosition = Vector3.New(0, -1.2, -4.2)
				var_118_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_3.position).x, (manager.ui.mainCamera.transform.position - var_118_3.position).y, (manager.ui.mainCamera.transform.position - var_118_3.position).z)
				var_118_3.localEulerAngles.z = 0
				var_118_3.localEulerAngles.x = 0
				var_118_3.localEulerAngles = var_118_3.localEulerAngles

				local var_118_6 = GameObjectTools.GetOrAddComponent(var_118_3.gameObject, typeof(DynamicBoneHelper))

				if var_118_6 then
					var_118_6:EnableDynamicBone(true)
				end
			end

			local var_118_7 = arg_115_1.actors_["2030_tpose"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.characterEffect2030_tpose == nil then
				arg_115_1.var_.characterEffect2030_tpose = var_118_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_8 and not isNil(var_118_7) then
				if arg_115_1.var_.characterEffect2030_tpose and not isNil(var_118_7) then
					arg_115_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_8 and arg_115_1.time_ < 0 + var_118_8 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.characterEffect2030_tpose then
				arg_115_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_118_10 = 0
			local var_118_11 = 0.325

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[34].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_12 = arg_115_1:GetWordFromCfg(304031028)
				local var_118_13 = arg_115_1:FormatText(var_118_12.content)

				arg_115_1.text_.text = var_118_13

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_15 = 13 <= 0 and var_118_11 or var_118_11 * (utf8.len(var_118_13) / 13)

				if (13 <= 0 and var_118_11 or var_118_11 * (utf8.len(var_118_13) / 13)) > 0 and var_118_11 < var_118_15 then
					arg_115_1.talkMaxDuration = var_118_15

					if var_118_15 + var_118_10 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_15 + var_118_10
					end
				end

				arg_115_1.text_.text = var_118_13
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031028", "story_v_out_304031.awb") ~= 0 then
					local var_118_16 = manager.audio:GetVoiceLength("story_v_out_304031", "304031028", "story_v_out_304031.awb") / 1000

					if var_118_16 + var_118_10 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_16 + var_118_10
					end

					if var_118_12.prefab_name ~= "" and arg_115_1.actors_[var_118_12.prefab_name] ~= nil then
						local var_118_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_12.prefab_name].transform, "story_v_out_304031", "304031028", "story_v_out_304031.awb")

						arg_115_1:RecordAudio("304031028", var_118_17)
						arg_115_1:RecordAudio("304031028", var_118_17)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_304031", "304031028", "story_v_out_304031.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_304031", "304031028", "story_v_out_304031.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_18 = math.max(var_118_11, arg_115_1.talkMaxDuration)

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_18 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_10) / var_118_18

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_10 + var_118_18 and arg_115_1.time_ < var_118_10 + var_118_18 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
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
	Play304031029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 304031029
		arg_119_1.duration_ = 5.87

		local var_119_0 = {
			zh = 5.8,
			ja = 5.866
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
				arg_119_0:Play304031030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["2030_tpose"]) and arg_119_1.var_.characterEffect2030_tpose == nil then
				arg_119_1.var_.characterEffect2030_tpose = arg_119_1.actors_["2030_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["2030_tpose"]) then
				if arg_119_1.var_.characterEffect2030_tpose and not isNil(arg_119_1.actors_["2030_tpose"]) then
					arg_119_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_119_1.var_.characterEffect2030_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["2030_tpose"]) and arg_119_1.var_.characterEffect2030_tpose then
				arg_119_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_119_1.var_.characterEffect2030_tpose.fillRatio = 0.5
			end

			local var_122_1 = 0
			local var_122_2 = 0.625

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2020")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:GetWordFromCfg(304031029)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_6 = 25 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_4) / 25)

				if (25 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_4) / 25)) > 0 and var_122_2 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031029", "story_v_out_304031.awb") ~= 0 then
					local var_122_7 = manager.audio:GetVoiceLength("story_v_out_304031", "304031029", "story_v_out_304031.awb") / 1000

					if var_122_7 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_1
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_304031", "304031029", "story_v_out_304031.awb")

						arg_119_1:RecordAudio("304031029", var_122_8)
						arg_119_1:RecordAudio("304031029", var_122_8)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_304031", "304031029", "story_v_out_304031.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_304031", "304031029", "story_v_out_304031.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_9 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_9 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_9

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_9 and arg_119_1.time_ < var_122_1 + var_122_9 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play304031030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 304031030
		arg_123_1.duration_ = 3.87

		local var_123_0 = {
			zh = 3.866,
			ja = 3.566
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
				arg_123_0:Play304031031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["2030_tpose"]) and arg_123_1.var_.characterEffect2030_tpose == nil then
				arg_123_1.var_.characterEffect2030_tpose = arg_123_1.actors_["2030_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["2030_tpose"]) then
				if arg_123_1.var_.characterEffect2030_tpose and not isNil(arg_123_1.actors_["2030_tpose"]) then
					arg_123_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["2030_tpose"]) and arg_123_1.var_.characterEffect2030_tpose then
				arg_123_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_126_2 = 0
			local var_126_3 = 0.3

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[34].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_4 = arg_123_1:GetWordFromCfg(304031030)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 12 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 12)

				if (12 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 12)) > 0 and var_126_3 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031030", "story_v_out_304031.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_304031", "304031030", "story_v_out_304031.awb") / 1000

					if var_126_8 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_2
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_out_304031", "304031030", "story_v_out_304031.awb")

						arg_123_1:RecordAudio("304031030", var_126_9)
						arg_123_1:RecordAudio("304031030", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_304031", "304031030", "story_v_out_304031.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_304031", "304031030", "story_v_out_304031.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_10 and arg_123_1.time_ < var_126_2 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play304031031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 304031031
		arg_127_1.duration_ = 6.5

		local var_127_0 = {
			zh = 6.5,
			ja = 3.066
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
				arg_127_0:Play304031032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["2030_tpose"]) and arg_127_1.var_.characterEffect2030_tpose == nil then
				arg_127_1.var_.characterEffect2030_tpose = arg_127_1.actors_["2030_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["2030_tpose"]) then
				if arg_127_1.var_.characterEffect2030_tpose and not isNil(arg_127_1.actors_["2030_tpose"]) then
					arg_127_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_127_1.var_.characterEffect2030_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["2030_tpose"]) and arg_127_1.var_.characterEffect2030_tpose then
				arg_127_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_127_1.var_.characterEffect2030_tpose.fillRatio = 0.5
			end

			local var_130_1 = 0
			local var_130_2 = 0.75

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2020")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(304031031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_6 = 30 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_4) / 30)

				if (30 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_4) / 30)) > 0 and var_130_2 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031031", "story_v_out_304031.awb") ~= 0 then
					local var_130_7 = manager.audio:GetVoiceLength("story_v_out_304031", "304031031", "story_v_out_304031.awb") / 1000

					if var_130_7 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_1
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_304031", "304031031", "story_v_out_304031.awb")

						arg_127_1:RecordAudio("304031031", var_130_8)
						arg_127_1:RecordAudio("304031031", var_130_8)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_304031", "304031031", "story_v_out_304031.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_304031", "304031031", "story_v_out_304031.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_9 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_9 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_9

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_9 and arg_127_1.time_ < var_130_1 + var_130_9 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play304031032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 304031032
		arg_131_1.duration_ = 3.9

		local var_131_0 = {
			zh = 3.566,
			ja = 3.9
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
				arg_131_0:Play304031033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.425

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2020")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:GetWordFromCfg(304031032)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 17 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 17)

				if (17 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 17)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031032", "story_v_out_304031.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031032", "story_v_out_304031.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_304031", "304031032", "story_v_out_304031.awb")

						arg_131_1:RecordAudio("304031032", var_134_6)
						arg_131_1:RecordAudio("304031032", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_304031", "304031032", "story_v_out_304031.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_304031", "304031032", "story_v_out_304031.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play304031033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 304031033
		arg_135_1.duration_ = 4.1

		local var_135_0 = {
			zh = 4.1,
			ja = 3.2
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
				arg_135_0:Play304031034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["2030_tpose"]) and arg_135_1.var_.characterEffect2030_tpose == nil then
				arg_135_1.var_.characterEffect2030_tpose = arg_135_1.actors_["2030_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["2030_tpose"]) then
				if arg_135_1.var_.characterEffect2030_tpose and not isNil(arg_135_1.actors_["2030_tpose"]) then
					arg_135_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["2030_tpose"]) and arg_135_1.var_.characterEffect2030_tpose then
				arg_135_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_138_2 = 0
			local var_138_3 = 0.275

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[34].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_4 = arg_135_1:GetWordFromCfg(304031033)
				local var_138_5 = arg_135_1:FormatText(var_138_4.content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 11 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 11)

				if (11 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 11)) > 0 and var_138_3 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031033", "story_v_out_304031.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_304031", "304031033", "story_v_out_304031.awb") / 1000

					if var_138_8 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_2
					end

					if var_138_4.prefab_name ~= "" and arg_135_1.actors_[var_138_4.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_4.prefab_name].transform, "story_v_out_304031", "304031033", "story_v_out_304031.awb")

						arg_135_1:RecordAudio("304031033", var_138_9)
						arg_135_1:RecordAudio("304031033", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_304031", "304031033", "story_v_out_304031.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_304031", "304031033", "story_v_out_304031.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_3, arg_135_1.talkMaxDuration)

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_2) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_2 + var_138_10 and arg_135_1.time_ < var_138_2 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play304031034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 304031034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play304031035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos2030_tpose = arg_139_1.actors_["2030_tpose"].transform.localPosition

				local var_142_0 = GameObjectTools.GetOrAddComponent(arg_139_1.actors_["2030_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_142_0 then
					var_142_0:EnableDynamicBone(false)
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["2030_tpose"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos2030_tpose, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_1)
				arg_139_1.actors_["2030_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["2030_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["2030_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["2030_tpose"].transform.position).z)
				arg_139_1.actors_["2030_tpose"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["2030_tpose"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["2030_tpose"].transform.localEulerAngles = arg_139_1.actors_["2030_tpose"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["2030_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["2030_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["2030_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["2030_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["2030_tpose"].transform.position).z)
				arg_139_1.actors_["2030_tpose"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["2030_tpose"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["2030_tpose"].transform.localEulerAngles = arg_139_1.actors_["2030_tpose"].transform.localEulerAngles

				local var_142_2 = GameObjectTools.GetOrAddComponent(arg_139_1.actors_["2030_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_142_2 then
					var_142_2:EnableDynamicBone(true)
				end
			end

			local var_142_3 = 0
			local var_142_4 = 0.675

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_3 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_5 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(304031034).content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 27 <= 0 and var_142_4 or var_142_4 * (utf8.len(var_142_5) / 27)

				if (27 <= 0 and var_142_4 or var_142_4 * (utf8.len(var_142_5) / 27)) > 0 and var_142_4 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_3 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_3
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_4, arg_139_1.talkMaxDuration)

			if var_142_3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_3 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_3) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_3 + var_142_8 and arg_139_1.time_ < var_142_3 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
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
	Play304031035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 304031035
		arg_143_1.duration_ = 8.6

		local var_143_0 = {
			zh = 6.633,
			ja = 8.6
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
				arg_143_0:Play304031036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			if arg_143_1.time_ >= 0 + 1.33333333333333 and arg_143_1.time_ < 0 + 1.33333333333333 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end

			local var_146_0 = 0
			local var_146_1 = 0.8

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2020")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_2 = arg_143_1:GetWordFromCfg(304031035)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 32 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_3) / 32)

				if (32 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_3) / 32)) > 0 and var_146_1 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031035", "story_v_out_304031.awb") ~= 0 then
					local var_146_6 = manager.audio:GetVoiceLength("story_v_out_304031", "304031035", "story_v_out_304031.awb") / 1000

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end

					if var_146_2.prefab_name ~= "" and arg_143_1.actors_[var_146_2.prefab_name] ~= nil then
						local var_146_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_2.prefab_name].transform, "story_v_out_304031", "304031035", "story_v_out_304031.awb")

						arg_143_1:RecordAudio("304031035", var_146_7)
						arg_143_1:RecordAudio("304031035", var_146_7)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_304031", "304031035", "story_v_out_304031.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_304031", "304031035", "story_v_out_304031.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_8 and arg_143_1.time_ < var_146_0 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.799999997019768,
				startTime = 0.566666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(3, 0.3, 0.1)
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play304031036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 304031036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play304031037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0.8 < arg_147_1.time_ and arg_147_1.time_ <= 0.8 + arg_150_0 then
				arg_147_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_down", "")
			end

			local var_150_1 = 0
			local var_150_2 = 1.05

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

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(304031036).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 42 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 42)

				if (42 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 42)) > 0 and var_150_2 < var_150_5 then
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

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play304031037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 304031037
		arg_151_1.duration_ = 5.9

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play304031038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				local var_154_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_154_0 then
					var_154_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_154_0.radialBlurScale = 0
					var_154_0.radialBlurGradient = 1
					var_154_0.radialBlurIntensity = 1

					if nil then
						var_154_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_154_1 = 0.833333333333333

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_1 then
				local var_154_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_154_2 then
					var_154_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_154_2.radialBlurScale = Mathf.Lerp(0, 0.862, (arg_151_1.time_ - 0) / var_154_1)
					var_154_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_151_1.time_ - 0) / var_154_1)
					var_154_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_151_1.time_ - 0) / var_154_1)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_1 and arg_151_1.time_ < 0 + var_154_1 + arg_154_0 then
				local var_154_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_154_3 then
					var_154_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_154_3.radialBlurScale = 0.862
					var_154_3.radialBlurGradient = 1
					var_154_3.radialBlurIntensity = 1
				end
			end

			local var_154_4 = 0

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			if arg_151_1.time_ >= var_154_4 + 1.4 and arg_151_1.time_ < var_154_4 + 1.4 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			if arg_151_1.frameCnt_ <= 1 then
				arg_151_1.dialog_:SetActive(false)
			end

			local var_154_5 = 0.9
			local var_154_6 = 0.825

			if 0.9 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_7 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_7:setOnUpdate(LuaHelper.FloatAction(function(arg_155_0)
					arg_151_1.dialogCg_.alpha = arg_155_0
				end))
				var_154_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_8 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(304031037).content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 33 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 33)

				if (33 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 33)) > 0 and var_154_6 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10
					var_154_5 = var_154_5 + 0.3

					if var_154_10 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_11 = var_154_5 + 0.3
			local var_154_12 = math.max(var_154_6, arg_151_1.talkMaxDuration)

			if var_154_5 + 0.3 <= arg_151_1.time_ and arg_151_1.time_ < var_154_11 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_11) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_11 + var_154_12 and arg_151_1.time_ < var_154_11 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play304031038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 304031038
		arg_157_1.duration_ = 2.9

		local var_157_0 = {
			zh = 0.999999999999,
			ja = 2.9
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
				arg_157_0:Play304031039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.075

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2020")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:GetWordFromCfg(304031038)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 3 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 3)

				if (3 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 3)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031038", "story_v_out_304031.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031038", "story_v_out_304031.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_304031", "304031038", "story_v_out_304031.awb")

						arg_157_1:RecordAudio("304031038", var_160_6)
						arg_157_1:RecordAudio("304031038", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_304031", "304031038", "story_v_out_304031.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_304031", "304031038", "story_v_out_304031.awb")
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
	Play304031039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 304031039
		arg_161_1.duration_ = 3.1

		local var_161_0 = {
			zh = 2.833,
			ja = 3.1
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play304031040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if arg_161_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_164_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_161_1.stage_.transform)

				var_164_0.name = "1036ui_story"
				var_164_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["1036ui_story"] = var_164_0

				local var_164_1 = var_164_0:GetComponentInChildren(typeof(CharacterEffect))

				var_164_1.enabled = true

				local var_164_2 = GameObjectTools.GetOrAddComponent(var_164_0, typeof(DynamicBoneHelper))

				if var_164_2 then
					var_164_2:EnableDynamicBone(false)
				end

				arg_161_1:ShowWeapon(var_164_1.transform, false)

				arg_161_1.var_["1036ui_story" .. "Animator"] = var_164_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_161_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_161_1.var_["1036ui_story" .. "LipSync"] = var_164_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_164_3 = arg_161_1.actors_["1036ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1036ui_story = var_164_3.localPosition
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_3.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_161_1.time_ - 0) / var_164_4)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_3.localPosition = Vector3.New(0, -1.09, -5.78)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			local var_164_5 = arg_161_1.actors_["1036ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1036ui_story == nil then
				arg_161_1.var_.characterEffect1036ui_story = var_164_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 and not isNil(var_164_5) then
				if arg_161_1.var_.characterEffect1036ui_story and not isNil(var_164_5) then
					arg_161_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1036ui_story then
				arg_161_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_164_8 = 0
			local var_164_9 = 0.3

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_10 = arg_161_1:GetWordFromCfg(304031039)
				local var_164_11 = arg_161_1:FormatText(var_164_10.content)

				arg_161_1.text_.text = var_164_11

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 12 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 12)

				if (12 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 12)) > 0 and var_164_9 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_11
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031039", "story_v_out_304031.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_304031", "304031039", "story_v_out_304031.awb") / 1000

					if var_164_14 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_8
					end

					if var_164_10.prefab_name ~= "" and arg_161_1.actors_[var_164_10.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_10.prefab_name].transform, "story_v_out_304031", "304031039", "story_v_out_304031.awb")

						arg_161_1:RecordAudio("304031039", var_164_15)
						arg_161_1:RecordAudio("304031039", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_304031", "304031039", "story_v_out_304031.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_304031", "304031039", "story_v_out_304031.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_8) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_8 + var_164_16 and arg_161_1.time_ < var_164_8 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play304031040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 304031040
		arg_165_1.duration_ = 8.97

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play304031041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if arg_165_1.bgs_.S0103 == nil then
				local var_168_0 = Object.Instantiate(arg_165_1.paintGo_)

				var_168_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0103")
				var_168_0.name = "S0103"
				var_168_0.transform.parent = arg_165_1.stage_.transform
				var_168_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.bgs_.S0103 = var_168_0
			end

			if 2.3 < arg_165_1.time_ and arg_165_1.time_ <= 2.3 + arg_168_0 then
				local var_168_1 = arg_165_1.bgs_.S0103

				arg_165_1.bgs_.S0103.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_168_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_168_2 = var_168_1:GetComponent("SpriteRenderer")

				if var_168_2 and var_168_2.sprite then
					local var_168_3 = 2 * (var_168_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_168_1.transform.localScale = Vector3.New(var_168_3 / var_168_2.sprite.bounds.size.y < var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x and var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x or var_168_3 / var_168_2.sprite.bounds.size.y, var_168_3 / var_168_2.sprite.bounds.size.y < var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x and var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x or var_168_3 / var_168_2.sprite.bounds.size.y, 0)
				end

				for iter_168_0, iter_168_1 in pairs(arg_165_1.bgs_) do
					if iter_168_0 ~= "S0103" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_168_4 = 2.3

			if 2.3 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.allBtn_.enabled = false
			end

			if arg_165_1.time_ >= var_168_4 + 0.3 and arg_165_1.time_ < var_168_4 + 0.3 + arg_168_0 then
				arg_165_1.allBtn_.enabled = true
			end

			local var_168_5 = 0

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_5 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_6 = 2.3

			if var_168_5 <= arg_165_1.time_ and arg_165_1.time_ < var_168_5 + var_168_6 then
				local var_168_7 = Color.New(0, 0, 0)

				var_168_7.a = Mathf.Lerp(0, 1, (arg_165_1.time_ - var_168_5) / var_168_6)
				arg_165_1.mask_.color = var_168_7
			end

			if arg_165_1.time_ >= var_168_5 + var_168_6 and arg_165_1.time_ < var_168_5 + var_168_6 + arg_168_0 then
				local var_168_8 = Color.New(0, 0, 0)

				var_168_8.a = 1
				arg_165_1.mask_.color = var_168_8
			end

			local var_168_9 = 2.3

			if 2.3 < arg_165_1.time_ and arg_165_1.time_ <= var_168_9 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_10 = 2

			if var_168_9 <= arg_165_1.time_ and arg_165_1.time_ < var_168_9 + var_168_10 then
				local var_168_11 = Color.New(0, 0, 0)

				var_168_11.a = Mathf.Lerp(1, 0, (arg_165_1.time_ - var_168_9) / var_168_10)
				arg_165_1.mask_.color = var_168_11
			end

			if arg_165_1.time_ >= var_168_9 + var_168_10 and arg_165_1.time_ < var_168_9 + var_168_10 + arg_168_0 then
				local var_168_12 = Color.New(0, 0, 0)

				arg_165_1.mask_.enabled = false
				var_168_12.a = 0
				arg_165_1.mask_.color = var_168_12
			end

			local var_168_13 = arg_165_1.actors_["1036ui_story"].transform

			if 2.3 < arg_165_1.time_ and arg_165_1.time_ <= 2.3 + arg_168_0 then
				arg_165_1.var_.moveOldPos1036ui_story = var_168_13.localPosition
			end

			local var_168_14 = 0.001

			if 2.3 <= arg_165_1.time_ and arg_165_1.time_ < 2.3 + var_168_14 then
				var_168_13.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 2.3) / var_168_14)
				var_168_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_13.position).x, (manager.ui.mainCamera.transform.position - var_168_13.position).y, (manager.ui.mainCamera.transform.position - var_168_13.position).z)
				var_168_13.localEulerAngles.z = 0
				var_168_13.localEulerAngles.x = 0
				var_168_13.localEulerAngles = var_168_13.localEulerAngles
			end

			if arg_165_1.time_ >= 2.3 + var_168_14 and arg_165_1.time_ < 2.3 + var_168_14 + arg_168_0 then
				var_168_13.localPosition = Vector3.New(0, 100, 0)
				var_168_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_13.position).x, (manager.ui.mainCamera.transform.position - var_168_13.position).y, (manager.ui.mainCamera.transform.position - var_168_13.position).z)
				var_168_13.localEulerAngles.z = 0
				var_168_13.localEulerAngles.x = 0
				var_168_13.localEulerAngles = var_168_13.localEulerAngles
			end

			local var_168_15 = arg_165_1.actors_["1036ui_story"]

			if 2.3 < arg_165_1.time_ and arg_165_1.time_ <= 2.3 + arg_168_0 and not isNil(var_168_15) and arg_165_1.var_.characterEffect1036ui_story == nil then
				arg_165_1.var_.characterEffect1036ui_story = var_168_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_16 = 0.200000002980232

			if 2.3 <= arg_165_1.time_ and arg_165_1.time_ < 2.3 + var_168_16 and not isNil(var_168_15) then
				if arg_165_1.var_.characterEffect1036ui_story and not isNil(var_168_15) then
					arg_165_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 2.3) / var_168_16)
				end
			end

			if arg_165_1.time_ >= 2.3 + var_168_16 and arg_165_1.time_ < 2.3 + var_168_16 + arg_168_0 and not isNil(var_168_15) and arg_165_1.var_.characterEffect1036ui_story then
				arg_165_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_168_17

			if 2.3 < arg_165_1.time_ and arg_165_1.time_ <= 2.3 + arg_168_0 then
				local var_168_18 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_168_18 then
					var_168_18.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_168_18.radialBlurScale = 0
					var_168_18.radialBlurGradient = 1
					var_168_18.radialBlurIntensity = 1

					if var_168_17 then
						var_168_18.radialBlurTarget = var_168_17.transform
					end
				end
			end

			local var_168_19 = 0.833333333333333

			if 2.3 <= arg_165_1.time_ and arg_165_1.time_ < 2.3 + var_168_19 then
				local var_168_20 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_168_20 then
					var_168_20.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_168_20.radialBlurScale = Mathf.Lerp(0, 0, (arg_165_1.time_ - 2.3) / var_168_19)
					var_168_20.radialBlurGradient = Mathf.Lerp(1, 1, (arg_165_1.time_ - 2.3) / var_168_19)
					var_168_20.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_165_1.time_ - 2.3) / var_168_19)
				end
			end

			if arg_165_1.time_ >= 2.3 + var_168_19 and arg_165_1.time_ < 2.3 + var_168_19 + arg_168_0 then
				local var_168_21 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_168_21 then
					var_168_21.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_168_21.radialBlurScale = 0
					var_168_21.radialBlurGradient = 1
					var_168_21.radialBlurIntensity = 1
				end
			end

			local var_168_22 = arg_165_1.bgs_.S0103.transform

			if 2.3 < arg_165_1.time_ and arg_165_1.time_ <= 2.3 + arg_168_0 then
				arg_165_1.var_.moveOldPosS0103 = var_168_22.localPosition
			end

			local var_168_23 = 1.93333333333333

			if 2.3 <= arg_165_1.time_ and arg_165_1.time_ < 2.3 + var_168_23 then
				var_168_22.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPosS0103, Vector3.New(0, 1, 5), (arg_165_1.time_ - 2.3) / var_168_23)
			end

			if arg_165_1.time_ >= 2.3 + var_168_23 and arg_165_1.time_ < 2.3 + var_168_23 + arg_168_0 then
				var_168_22.localPosition = Vector3.New(0, 1, 5)
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_24 = 3.96666666666667
			local var_168_25 = 1.225

			if 3.96666666666667 < arg_165_1.time_ and arg_165_1.time_ <= var_168_24 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_26 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_26:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_27 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(304031040).content)

				arg_165_1.text_.text = var_168_27

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_29 = 49 <= 0 and var_168_25 or var_168_25 * (utf8.len(var_168_27) / 49)

				if (49 <= 0 and var_168_25 or var_168_25 * (utf8.len(var_168_27) / 49)) > 0 and var_168_25 < var_168_29 then
					arg_165_1.talkMaxDuration = var_168_29
					var_168_24 = var_168_24 + 0.3

					if var_168_29 + var_168_24 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_29 + var_168_24
					end
				end

				arg_165_1.text_.text = var_168_27
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_30 = var_168_24 + 0.3
			local var_168_31 = math.max(var_168_25, arg_165_1.talkMaxDuration)

			if var_168_24 + 0.3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_30 + var_168_31 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_30) / var_168_31

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_30 + var_168_31 and arg_165_1.time_ < var_168_30 + var_168_31 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0103",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.93333333333333,
				startTime = 2.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-0.37, 1, 1.69),
					endPos = Vector3.New(0, 1, 5),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play304031041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 304031041
		arg_171_1.duration_ = 5.77

		local var_171_0 = {
			zh = 4.6,
			ja = 5.766
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
				arg_171_0:Play304031042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.6

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(304031041)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 24 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 24)

				if (24 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 24)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031041", "story_v_out_304031.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031041", "story_v_out_304031.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_304031", "304031041", "story_v_out_304031.awb")

						arg_171_1:RecordAudio("304031041", var_174_6)
						arg_171_1:RecordAudio("304031041", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_304031", "304031041", "story_v_out_304031.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_304031", "304031041", "story_v_out_304031.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play304031042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 304031042
		arg_175_1.duration_ = 6.1

		local var_175_0 = {
			zh = 6.1,
			ja = 5.366
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
				arg_175_0:Play304031043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.75

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(304031042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 30 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 30)

				if (30 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 30)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031042", "story_v_out_304031.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031042", "story_v_out_304031.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_304031", "304031042", "story_v_out_304031.awb")

						arg_175_1:RecordAudio("304031042", var_178_6)
						arg_175_1:RecordAudio("304031042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_304031", "304031042", "story_v_out_304031.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_304031", "304031042", "story_v_out_304031.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play304031043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 304031043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play304031044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1036ui_story"]) and arg_179_1.var_.characterEffect1036ui_story == nil then
				arg_179_1.var_.characterEffect1036ui_story = arg_179_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1036ui_story"]) then
				if arg_179_1.var_.characterEffect1036ui_story and not isNil(arg_179_1.actors_["1036ui_story"]) then
					arg_179_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_0)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1036ui_story"]) and arg_179_1.var_.characterEffect1036ui_story then
				arg_179_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_182_1 = 0
			local var_182_2 = 0.375

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
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

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_179_1.callingController_:SetSelectedState("calling")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_3 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(304031043).content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 15 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 15)

				if (15 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 15)) > 0 and var_182_2 < var_182_5 then
					arg_179_1.talkMaxDuration = var_182_5

					if var_182_5 + var_182_1 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + var_182_1
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_6 = math.max(var_182_2, arg_179_1.talkMaxDuration)

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_6 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_1) / var_182_6

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_1 + var_182_6 and arg_179_1.time_ < var_182_1 + var_182_6 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play304031044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 304031044
		arg_183_1.duration_ = 7.03

		local var_183_0 = {
			zh = 4.8,
			ja = 7.033
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
				arg_183_0:Play304031045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.525

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(304031044)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 21 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 21)

				if (21 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 21)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031044", "story_v_out_304031.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031044", "story_v_out_304031.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_304031", "304031044", "story_v_out_304031.awb")

						arg_183_1:RecordAudio("304031044", var_186_6)
						arg_183_1:RecordAudio("304031044", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_304031", "304031044", "story_v_out_304031.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_304031", "304031044", "story_v_out_304031.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play304031045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 304031045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play304031046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1036ui_story"]) and arg_187_1.var_.characterEffect1036ui_story == nil then
				arg_187_1.var_.characterEffect1036ui_story = arg_187_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1036ui_story"]) then
				if arg_187_1.var_.characterEffect1036ui_story and not isNil(arg_187_1.actors_["1036ui_story"]) then
					arg_187_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1036ui_story"]) and arg_187_1.var_.characterEffect1036ui_story then
				arg_187_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.725

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(304031045).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 29 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 29)

				if (29 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 29)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play304031046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 304031046
		arg_191_1.duration_ = 5.1

		local var_191_0 = {
			zh = 4.533,
			ja = 5.1
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
				arg_191_0:Play304031047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.575

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(304031046)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 23 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 23)

				if (23 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 23)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031046", "story_v_out_304031.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031046", "story_v_out_304031.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_304031", "304031046", "story_v_out_304031.awb")

						arg_191_1:RecordAudio("304031046", var_194_6)
						arg_191_1:RecordAudio("304031046", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_304031", "304031046", "story_v_out_304031.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_304031", "304031046", "story_v_out_304031.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play304031047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 304031047
		arg_195_1.duration_ = 4.77

		local var_195_0 = {
			zh = 4.6,
			ja = 4.766
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
				arg_195_0:Play304031048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.575

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(304031047)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 23 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 23)

				if (23 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 23)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031047", "story_v_out_304031.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031047", "story_v_out_304031.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_304031", "304031047", "story_v_out_304031.awb")

						arg_195_1:RecordAudio("304031047", var_198_6)
						arg_195_1:RecordAudio("304031047", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_304031", "304031047", "story_v_out_304031.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_304031", "304031047", "story_v_out_304031.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play304031048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 304031048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play304031049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1036ui_story"]) and arg_199_1.var_.characterEffect1036ui_story == nil then
				arg_199_1.var_.characterEffect1036ui_story = arg_199_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1036ui_story"]) then
				if arg_199_1.var_.characterEffect1036ui_story and not isNil(arg_199_1.actors_["1036ui_story"]) then
					arg_199_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1036ui_story"]) and arg_199_1.var_.characterEffect1036ui_story then
				arg_199_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.575

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(304031048).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 23 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 23)

				if (23 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 23)) > 0 and var_202_2 < var_202_5 then
					arg_199_1.talkMaxDuration = var_202_5

					if var_202_5 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_6 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_6 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_6

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_6 and arg_199_1.time_ < var_202_1 + var_202_6 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play304031049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 304031049
		arg_203_1.duration_ = 5.23

		local var_203_0 = {
			zh = 3.433,
			ja = 5.233
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play304031050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.475

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:GetWordFromCfg(304031049)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 19 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 19)

				if (19 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 19)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031049", "story_v_out_304031.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031049", "story_v_out_304031.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_304031", "304031049", "story_v_out_304031.awb")

						arg_203_1:RecordAudio("304031049", var_206_6)
						arg_203_1:RecordAudio("304031049", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_304031", "304031049", "story_v_out_304031.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_304031", "304031049", "story_v_out_304031.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play304031050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 304031050
		arg_207_1.duration_ = 11.2

		local var_207_0 = {
			zh = 8.5,
			ja = 11.2
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
				arg_207_0:Play304031051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 1.2

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_1 = arg_207_1:GetWordFromCfg(304031050)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 48 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 48)

				if (48 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 48)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031050", "story_v_out_304031.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031050", "story_v_out_304031.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_304031", "304031050", "story_v_out_304031.awb")

						arg_207_1:RecordAudio("304031050", var_210_6)
						arg_207_1:RecordAudio("304031050", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_304031", "304031050", "story_v_out_304031.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_304031", "304031050", "story_v_out_304031.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play304031051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 304031051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play304031052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.925

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(304031051).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 37 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 37)

				if (37 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 37)) > 0 and var_214_0 < var_214_3 then
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
	Play304031052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 304031052
		arg_215_1.duration_ = 4.47

		local var_215_0 = {
			zh = 4.466,
			ja = 3.333
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
				arg_215_0:Play304031053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.45

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:GetWordFromCfg(304031052)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 18 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 18)

				if (18 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 18)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031052", "story_v_out_304031.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031052", "story_v_out_304031.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_304031", "304031052", "story_v_out_304031.awb")

						arg_215_1:RecordAudio("304031052", var_218_6)
						arg_215_1:RecordAudio("304031052", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_304031", "304031052", "story_v_out_304031.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_304031", "304031052", "story_v_out_304031.awb")
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
	Play304031053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 304031053
		arg_219_1.duration_ = 7.57

		local var_219_0 = {
			zh = 6.533,
			ja = 7.566
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
				arg_219_0:Play304031054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if arg_219_1.bgs_.S0201 == nil then
				local var_222_0 = Object.Instantiate(arg_219_1.paintGo_)

				var_222_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0201")
				var_222_0.name = "S0201"
				var_222_0.transform.parent = arg_219_1.stage_.transform
				var_222_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.bgs_.S0201 = var_222_0
			end

			if 1.26666666666667 < arg_219_1.time_ and arg_219_1.time_ <= 1.26666666666667 + arg_222_0 then
				local var_222_1 = arg_219_1.bgs_.S0201

				arg_219_1.bgs_.S0201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_222_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_2 = var_222_1:GetComponent("SpriteRenderer")

				if var_222_2 and var_222_2.sprite then
					local var_222_3 = 2 * (var_222_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_222_1.transform.localScale = Vector3.New(var_222_3 / var_222_2.sprite.bounds.size.y < var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x and var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x or var_222_3 / var_222_2.sprite.bounds.size.y, var_222_3 / var_222_2.sprite.bounds.size.y < var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x and var_222_3 * manager.ui.mainCameraCom_.aspect / var_222_2.sprite.bounds.size.x or var_222_3 / var_222_2.sprite.bounds.size.y, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "S0201" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_4 = 0

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			if arg_219_1.time_ >= var_222_4 + 0.3 and arg_219_1.time_ < var_222_4 + 0.3 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			local var_222_5 = 0

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_6 = 1.26666666666667

			if var_222_5 <= arg_219_1.time_ and arg_219_1.time_ < var_222_5 + var_222_6 then
				local var_222_7 = Color.New(0, 0, 0)

				var_222_7.a = Mathf.Lerp(0, 1, (arg_219_1.time_ - var_222_5) / var_222_6)
				arg_219_1.mask_.color = var_222_7
			end

			if arg_219_1.time_ >= var_222_5 + var_222_6 and arg_219_1.time_ < var_222_5 + var_222_6 + arg_222_0 then
				local var_222_8 = Color.New(0, 0, 0)

				var_222_8.a = 1
				arg_219_1.mask_.color = var_222_8
			end

			local var_222_9 = 1.26666666666667

			if 1.26666666666667 < arg_219_1.time_ and arg_219_1.time_ <= var_222_9 + arg_222_0 then
				arg_219_1.mask_.enabled = true
				arg_219_1.mask_.raycastTarget = true

				arg_219_1:SetGaussion(false)
			end

			local var_222_10 = 1.66666666666667

			if var_222_9 <= arg_219_1.time_ and arg_219_1.time_ < var_222_9 + var_222_10 then
				local var_222_11 = Color.New(0, 0, 0)

				var_222_11.a = Mathf.Lerp(1, 0, (arg_219_1.time_ - var_222_9) / var_222_10)
				arg_219_1.mask_.color = var_222_11
			end

			if arg_219_1.time_ >= var_222_9 + var_222_10 and arg_219_1.time_ < var_222_9 + var_222_10 + arg_222_0 then
				local var_222_12 = Color.New(0, 0, 0)

				arg_219_1.mask_.enabled = false
				var_222_12.a = 0
				arg_219_1.mask_.color = var_222_12
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_13 = 2.7
			local var_222_14 = 0.5

			if 2.7 < arg_219_1.time_ and arg_219_1.time_ <= var_222_13 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_15 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_15:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_16 = arg_219_1:GetWordFromCfg(304031053)
				local var_222_17 = arg_219_1:FormatText(var_222_16.content)

				arg_219_1.text_.text = var_222_17

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_19 = 20 <= 0 and var_222_14 or var_222_14 * (utf8.len(var_222_17) / 20)

				if (20 <= 0 and var_222_14 or var_222_14 * (utf8.len(var_222_17) / 20)) > 0 and var_222_14 < var_222_19 then
					arg_219_1.talkMaxDuration = var_222_19
					var_222_13 = var_222_13 + 0.3

					if var_222_19 + var_222_13 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_19 + var_222_13
					end
				end

				arg_219_1.text_.text = var_222_17
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031053", "story_v_out_304031.awb") ~= 0 then
					local var_222_20 = manager.audio:GetVoiceLength("story_v_out_304031", "304031053", "story_v_out_304031.awb") / 1000

					if var_222_20 + var_222_13 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_20 + var_222_13
					end

					if var_222_16.prefab_name ~= "" and arg_219_1.actors_[var_222_16.prefab_name] ~= nil then
						local var_222_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_16.prefab_name].transform, "story_v_out_304031", "304031053", "story_v_out_304031.awb")

						arg_219_1:RecordAudio("304031053", var_222_21)
						arg_219_1:RecordAudio("304031053", var_222_21)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_304031", "304031053", "story_v_out_304031.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_304031", "304031053", "story_v_out_304031.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_22 = var_222_13 + 0.3
			local var_222_23 = math.max(var_222_14, arg_219_1.talkMaxDuration)

			if var_222_13 + 0.3 <= arg_219_1.time_ and arg_219_1.time_ < var_222_22 + var_222_23 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_22) / var_222_23

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_22 + var_222_23 and arg_219_1.time_ < var_222_22 + var_222_23 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play304031054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 304031054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play304031055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1036ui_story"]) and arg_225_1.var_.characterEffect1036ui_story == nil then
				arg_225_1.var_.characterEffect1036ui_story = arg_225_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1036ui_story"]) then
				if arg_225_1.var_.characterEffect1036ui_story and not isNil(arg_225_1.actors_["1036ui_story"]) then
					arg_225_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1036ui_story"]) and arg_225_1.var_.characterEffect1036ui_story then
				arg_225_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 0.6

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(304031054).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 24 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 24)

				if (24 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 24)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play304031055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 304031055
		arg_229_1.duration_ = 14.1

		local var_229_0 = {
			zh = 14.1,
			ja = 1.749999999999
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
				arg_229_0:Play304031056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 1.75

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_1")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:GetWordFromCfg(304031055)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 70 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 70)

				if (70 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 70)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031055", "story_v_out_304031.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031055", "story_v_out_304031.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_304031", "304031055", "story_v_out_304031.awb")

						arg_229_1:RecordAudio("304031055", var_232_6)
						arg_229_1:RecordAudio("304031055", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_304031", "304031055", "story_v_out_304031.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_304031", "304031055", "story_v_out_304031.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play304031056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 304031056
		arg_233_1.duration_ = 8.07

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play304031057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if arg_233_1.bgs_.A00 == nil then
				local var_236_0 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_236_0.name = "A00"
				var_236_0.transform.parent = arg_233_1.stage_.transform
				var_236_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_.A00 = var_236_0
			end

			if 1.66666666666667 < arg_233_1.time_ and arg_233_1.time_ <= 1.66666666666667 + arg_236_0 then
				local var_236_1 = arg_233_1.bgs_.A00

				arg_233_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_236_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_2 = var_236_1:GetComponent("SpriteRenderer")

				if var_236_2 and var_236_2.sprite then
					local var_236_3 = 2 * (var_236_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_236_1.transform.localScale = Vector3.New(var_236_3 / var_236_2.sprite.bounds.size.y < var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x and var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x or var_236_3 / var_236_2.sprite.bounds.size.y, var_236_3 / var_236_2.sprite.bounds.size.y < var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x and var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x or var_236_3 / var_236_2.sprite.bounds.size.y, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "A00" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_4 = 1.66666666666667

			if 1.66666666666667 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			if arg_233_1.time_ >= var_236_4 + 0.3 and arg_233_1.time_ < var_236_4 + 0.3 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			local var_236_5 = 0

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_6 = 1.66666666666667

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_6 then
				local var_236_7 = Color.New(0, 0, 0)

				var_236_7.a = Mathf.Lerp(0, 1, (arg_233_1.time_ - var_236_5) / var_236_6)
				arg_233_1.mask_.color = var_236_7
			end

			if arg_233_1.time_ >= var_236_5 + var_236_6 and arg_233_1.time_ < var_236_5 + var_236_6 + arg_236_0 then
				local var_236_8 = Color.New(0, 0, 0)

				var_236_8.a = 1
				arg_233_1.mask_.color = var_236_8
			end

			local var_236_9 = 1.66666666666667

			if 1.66666666666667 < arg_233_1.time_ and arg_233_1.time_ <= var_236_9 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_10 = 2

			if var_236_9 <= arg_233_1.time_ and arg_233_1.time_ < var_236_9 + var_236_10 then
				local var_236_11 = Color.New(0, 0, 0)

				var_236_11.a = Mathf.Lerp(1, 0, (arg_233_1.time_ - var_236_9) / var_236_10)
				arg_233_1.mask_.color = var_236_11
			end

			if arg_233_1.time_ >= var_236_9 + var_236_10 and arg_233_1.time_ < var_236_9 + var_236_10 + arg_236_0 then
				local var_236_12 = Color.New(0, 0, 0)

				arg_233_1.mask_.enabled = false
				var_236_12.a = 0
				arg_233_1.mask_.color = var_236_12
			end

			local var_236_13 = "1037ui_story"

			if arg_233_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_236_14 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_233_1.stage_.transform)

				var_236_14.name = var_236_13
				var_236_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_[var_236_13] = var_236_14

				local var_236_15 = var_236_14:GetComponentInChildren(typeof(CharacterEffect))

				var_236_15.enabled = true

				local var_236_16 = GameObjectTools.GetOrAddComponent(var_236_14, typeof(DynamicBoneHelper))

				if var_236_16 then
					var_236_16:EnableDynamicBone(false)
				end

				arg_233_1:ShowWeapon(var_236_15.transform, false)

				arg_233_1.var_[var_236_13 .. "Animator"] = var_236_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_233_1.var_[var_236_13 .. "Animator"].applyRootMotion = true
				arg_233_1.var_[var_236_13 .. "LipSync"] = var_236_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_236_17 = arg_233_1.actors_["1037ui_story"].transform

			if 1.66666666666667 < arg_233_1.time_ and arg_233_1.time_ <= 1.66666666666667 + arg_236_0 then
				arg_233_1.var_.moveOldPos1037ui_story = var_236_17.localPosition
			end

			local var_236_18 = 0.001

			if 1.66666666666667 <= arg_233_1.time_ and arg_233_1.time_ < 1.66666666666667 + var_236_18 then
				var_236_17.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 1.66666666666667) / var_236_18)
				var_236_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_17.position).x, (manager.ui.mainCamera.transform.position - var_236_17.position).y, (manager.ui.mainCamera.transform.position - var_236_17.position).z)
				var_236_17.localEulerAngles.z = 0
				var_236_17.localEulerAngles.x = 0
				var_236_17.localEulerAngles = var_236_17.localEulerAngles
			end

			if arg_233_1.time_ >= 1.66666666666667 + var_236_18 and arg_233_1.time_ < 1.66666666666667 + var_236_18 + arg_236_0 then
				var_236_17.localPosition = Vector3.New(0, 100, 0)
				var_236_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_17.position).x, (manager.ui.mainCamera.transform.position - var_236_17.position).y, (manager.ui.mainCamera.transform.position - var_236_17.position).z)
				var_236_17.localEulerAngles.z = 0
				var_236_17.localEulerAngles.x = 0
				var_236_17.localEulerAngles = var_236_17.localEulerAngles
			end

			local var_236_19 = arg_233_1.actors_["1037ui_story"]

			if 1.66666666666667 < arg_233_1.time_ and arg_233_1.time_ <= 1.66666666666667 + arg_236_0 and not isNil(var_236_19) and arg_233_1.var_.characterEffect1037ui_story == nil then
				arg_233_1.var_.characterEffect1037ui_story = var_236_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_20 = 0.200000002980232

			if 1.66666666666667 <= arg_233_1.time_ and arg_233_1.time_ < 1.66666666666667 + var_236_20 and not isNil(var_236_19) then
				if arg_233_1.var_.characterEffect1037ui_story and not isNil(var_236_19) then
					arg_233_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 1.66666666666667) / var_236_20)
				end
			end

			if arg_233_1.time_ >= 1.66666666666667 + var_236_20 and arg_233_1.time_ < 1.66666666666667 + var_236_20 + arg_236_0 and not isNil(var_236_19) and arg_233_1.var_.characterEffect1037ui_story then
				arg_233_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_233_1.time_ and arg_233_1.time_ <= 1.2 + arg_236_0 then
				arg_233_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_command room", "")
			end

			if 0.2 < arg_233_1.time_ and arg_233_1.time_ <= 0.2 + arg_236_0 then
				arg_233_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_23 = 3.06666666666667
			local var_236_24 = 1.825

			if 3.06666666666667 < arg_233_1.time_ and arg_233_1.time_ <= var_236_23 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_25 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_25:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_26 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(304031056).content)

				arg_233_1.text_.text = var_236_26

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_28 = 73 <= 0 and var_236_24 or var_236_24 * (utf8.len(var_236_26) / 73)

				if (73 <= 0 and var_236_24 or var_236_24 * (utf8.len(var_236_26) / 73)) > 0 and var_236_24 < var_236_28 then
					arg_233_1.talkMaxDuration = var_236_28
					var_236_23 = var_236_23 + 0.3

					if var_236_28 + var_236_23 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_28 + var_236_23
					end
				end

				arg_233_1.text_.text = var_236_26
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_29 = var_236_23 + 0.3
			local var_236_30 = math.max(var_236_24, arg_233_1.talkMaxDuration)

			if var_236_23 + 0.3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_29 + var_236_30 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_29) / var_236_30

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_29 + var_236_30 and arg_233_1.time_ < var_236_29 + var_236_30 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play304031057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 304031057
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play304031058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.55

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(304031057).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 22 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 22)

				if (22 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 22)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play304031058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 304031058
		arg_243_1.duration_ = 8.07

		local var_243_0 = {
			zh = 6.033,
			ja = 8.066
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play304031059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1036ui_story = arg_243_1.actors_["1036ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1036ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1036ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1036ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1036ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1036ui_story"].transform.position).z)
				arg_243_1.actors_["1036ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1036ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1036ui_story"].transform.localEulerAngles = arg_243_1.actors_["1036ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1036ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.78)
				arg_243_1.actors_["1036ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1036ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1036ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1036ui_story"].transform.position).z)
				arg_243_1.actors_["1036ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1036ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1036ui_story"].transform.localEulerAngles = arg_243_1.actors_["1036ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1036ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1036ui_story == nil then
				arg_243_1.var_.characterEffect1036ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1036ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1036ui_story then
				arg_243_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action6_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				if arg_243_1.var_.characterEffect1036ui_story == nil then
					arg_243_1.var_.characterEffect1036ui_story = arg_243_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_243_1.var_.characterEffect1036ui_story.imageEffect:turnOn(false)
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				if arg_243_1.var_.characterEffect1036ui_story == nil then
					arg_243_1.var_.characterEffect1036ui_story = arg_243_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_246_5 = arg_243_1.var_.characterEffect1036ui_story

				arg_243_1.var_.characterEffect1036ui_story.imageEffect:turnOff()

				var_246_5.interferenceEffect.enabled = true
				var_246_5.interferenceEffect.noise = 0.001
				var_246_5.interferenceEffect.simTimeScale = 1
				var_246_5.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_246_6 = 0
			local var_246_7 = 0.775

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_8 = arg_243_1:GetWordFromCfg(304031058)
				local var_246_9 = arg_243_1:FormatText(var_246_8.content)

				arg_243_1.text_.text = var_246_9

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 31 <= 0 and var_246_7 or var_246_7 * (utf8.len(var_246_9) / 31)

				if (31 <= 0 and var_246_7 or var_246_7 * (utf8.len(var_246_9) / 31)) > 0 and var_246_7 < var_246_11 then
					arg_243_1.talkMaxDuration = var_246_11

					if var_246_11 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_11 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_9
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031058", "story_v_out_304031.awb") ~= 0 then
					local var_246_12 = manager.audio:GetVoiceLength("story_v_out_304031", "304031058", "story_v_out_304031.awb") / 1000

					if var_246_12 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_12 + var_246_6
					end

					if var_246_8.prefab_name ~= "" and arg_243_1.actors_[var_246_8.prefab_name] ~= nil then
						local var_246_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_8.prefab_name].transform, "story_v_out_304031", "304031058", "story_v_out_304031.awb")

						arg_243_1:RecordAudio("304031058", var_246_13)
						arg_243_1:RecordAudio("304031058", var_246_13)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_304031", "304031058", "story_v_out_304031.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_304031", "304031058", "story_v_out_304031.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_14 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_14 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_14

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_14 and arg_243_1.time_ < var_246_6 + var_246_14 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play304031059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 304031059
		arg_247_1.duration_ = 9.2

		local var_247_0 = {
			zh = 8.066,
			ja = 9.2
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
				arg_247_0:Play304031060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.95

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:GetWordFromCfg(304031059)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 38 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 38)

				if (38 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 38)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031059", "story_v_out_304031.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031059", "story_v_out_304031.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_304031", "304031059", "story_v_out_304031.awb")

						arg_247_1:RecordAudio("304031059", var_250_6)
						arg_247_1:RecordAudio("304031059", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_304031", "304031059", "story_v_out_304031.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_304031", "304031059", "story_v_out_304031.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play304031060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 304031060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play304031061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1036ui_story"]) and arg_251_1.var_.characterEffect1036ui_story == nil then
				arg_251_1.var_.characterEffect1036ui_story = arg_251_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1036ui_story"]) then
				if arg_251_1.var_.characterEffect1036ui_story and not isNil(arg_251_1.actors_["1036ui_story"]) then
					arg_251_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1036ui_story"]) and arg_251_1.var_.characterEffect1036ui_story then
				arg_251_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 0.525

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(304031060).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 11 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 11)

				if (11 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 11)) > 0 and var_254_2 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_6 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_6 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_6

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_6 and arg_251_1.time_ < var_254_1 + var_254_6 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play304031061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 304031061
		arg_255_1.duration_ = 1

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"

			SetActive(arg_255_1.choicesGo_, true)

			for iter_256_0, iter_256_1 in ipairs(arg_255_1.choices_) do
				SetActive(iter_256_1.go, iter_256_0 <= 2)
			end

			arg_255_1.choices_[1].txt.text = arg_255_1:FormatText(StoryChoiceCfg[1764].name)
			arg_255_1.choices_[2].txt.text = arg_255_1:FormatText(StoryChoiceCfg[1765].name)
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play304031062(arg_255_1)
			end

			if arg_257_0 == 2 then
				arg_255_0:Play304031062(arg_255_1)
			end

			arg_255_1:RecordChoiceLog(304031061, 1764, 1765)
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			return
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play304031062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 304031062
		arg_259_1.duration_ = 6.47

		local var_259_0 = {
			zh = 6.466,
			ja = 6.4
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play304031063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1036ui_story"]) and arg_259_1.var_.characterEffect1036ui_story == nil then
				arg_259_1.var_.characterEffect1036ui_story = arg_259_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1036ui_story"]) then
				if arg_259_1.var_.characterEffect1036ui_story and not isNil(arg_259_1.actors_["1036ui_story"]) then
					arg_259_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1036ui_story"]) and arg_259_1.var_.characterEffect1036ui_story then
				arg_259_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_262_2 = "1036ui_story"

			if arg_259_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_262_3 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_259_1.stage_.transform)

				var_262_3.name = var_262_2
				var_262_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.actors_[var_262_2] = var_262_3

				local var_262_4 = var_262_3:GetComponentInChildren(typeof(CharacterEffect))

				var_262_4.enabled = true

				local var_262_5 = GameObjectTools.GetOrAddComponent(var_262_3, typeof(DynamicBoneHelper))

				if var_262_5 then
					var_262_5:EnableDynamicBone(false)
				end

				arg_259_1:ShowWeapon(var_262_4.transform, false)

				arg_259_1.var_[var_262_2 .. "Animator"] = var_262_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_259_1.var_[var_262_2 .. "Animator"].applyRootMotion = true
				arg_259_1.var_[var_262_2 .. "LipSync"] = var_262_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action6_2")
			end

			local var_262_6 = "1036ui_story"

			if arg_259_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_262_7 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_259_1.stage_.transform)

				var_262_7.name = var_262_6
				var_262_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.actors_[var_262_6] = var_262_7

				local var_262_8 = var_262_7:GetComponentInChildren(typeof(CharacterEffect))

				var_262_8.enabled = true

				local var_262_9 = GameObjectTools.GetOrAddComponent(var_262_7, typeof(DynamicBoneHelper))

				if var_262_9 then
					var_262_9:EnableDynamicBone(false)
				end

				arg_259_1:ShowWeapon(var_262_8.transform, false)

				arg_259_1.var_[var_262_6 .. "Animator"] = var_262_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_259_1.var_[var_262_6 .. "Animator"].applyRootMotion = true
				arg_259_1.var_[var_262_6 .. "LipSync"] = var_262_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_262_10 = 0
			local var_262_11 = 0.775

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_12 = arg_259_1:GetWordFromCfg(304031062)
				local var_262_13 = arg_259_1:FormatText(var_262_12.content)

				arg_259_1.text_.text = var_262_13

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_15 = 31 <= 0 and var_262_11 or var_262_11 * (utf8.len(var_262_13) / 31)

				if (31 <= 0 and var_262_11 or var_262_11 * (utf8.len(var_262_13) / 31)) > 0 and var_262_11 < var_262_15 then
					arg_259_1.talkMaxDuration = var_262_15

					if var_262_15 + var_262_10 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_15 + var_262_10
					end
				end

				arg_259_1.text_.text = var_262_13
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031062", "story_v_out_304031.awb") ~= 0 then
					local var_262_16 = manager.audio:GetVoiceLength("story_v_out_304031", "304031062", "story_v_out_304031.awb") / 1000

					if var_262_16 + var_262_10 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_16 + var_262_10
					end

					if var_262_12.prefab_name ~= "" and arg_259_1.actors_[var_262_12.prefab_name] ~= nil then
						local var_262_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_12.prefab_name].transform, "story_v_out_304031", "304031062", "story_v_out_304031.awb")

						arg_259_1:RecordAudio("304031062", var_262_17)
						arg_259_1:RecordAudio("304031062", var_262_17)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_304031", "304031062", "story_v_out_304031.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_304031", "304031062", "story_v_out_304031.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_18 = math.max(var_262_11, arg_259_1.talkMaxDuration)

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_18 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_10) / var_262_18

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_10 + var_262_18 and arg_259_1.time_ < var_262_10 + var_262_18 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play304031063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 304031063
		arg_263_1.duration_ = 10.7

		local var_263_0 = {
			zh = 9.733,
			ja = 10.7
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play304031064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 1.125

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:GetWordFromCfg(304031063)
				local var_266_2 = arg_263_1:FormatText(var_266_1.content)

				arg_263_1.text_.text = var_266_2

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 45 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 45)

				if (45 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 45)) > 0 and var_266_0 < var_266_4 then
					arg_263_1.talkMaxDuration = var_266_4

					if var_266_4 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_4 + 0
					end
				end

				arg_263_1.text_.text = var_266_2
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031063", "story_v_out_304031.awb") ~= 0 then
					local var_266_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031063", "story_v_out_304031.awb") / 1000

					if var_266_5 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + 0
					end

					if var_266_1.prefab_name ~= "" and arg_263_1.actors_[var_266_1.prefab_name] ~= nil then
						local var_266_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_1.prefab_name].transform, "story_v_out_304031", "304031063", "story_v_out_304031.awb")

						arg_263_1:RecordAudio("304031063", var_266_6)
						arg_263_1:RecordAudio("304031063", var_266_6)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_304031", "304031063", "story_v_out_304031.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_304031", "304031063", "story_v_out_304031.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_7 and arg_263_1.time_ < 0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play304031064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 304031064
		arg_267_1.duration_ = 7.8

		local var_267_0 = {
			zh = 4.933,
			ja = 7.8
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
				arg_267_0:Play304031065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action3_1")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_270_0 = 0
			local var_270_1 = 0.65

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_2 = arg_267_1:GetWordFromCfg(304031064)
				local var_270_3 = arg_267_1:FormatText(var_270_2.content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 26 <= 0 and var_270_1 or var_270_1 * (utf8.len(var_270_3) / 26)

				if (26 <= 0 and var_270_1 or var_270_1 * (utf8.len(var_270_3) / 26)) > 0 and var_270_1 < var_270_5 then
					arg_267_1.talkMaxDuration = var_270_5

					if var_270_5 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + var_270_0
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031064", "story_v_out_304031.awb") ~= 0 then
					local var_270_6 = manager.audio:GetVoiceLength("story_v_out_304031", "304031064", "story_v_out_304031.awb") / 1000

					if var_270_6 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_6 + var_270_0
					end

					if var_270_2.prefab_name ~= "" and arg_267_1.actors_[var_270_2.prefab_name] ~= nil then
						local var_270_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_2.prefab_name].transform, "story_v_out_304031", "304031064", "story_v_out_304031.awb")

						arg_267_1:RecordAudio("304031064", var_270_7)
						arg_267_1:RecordAudio("304031064", var_270_7)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_304031", "304031064", "story_v_out_304031.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_304031", "304031064", "story_v_out_304031.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_8 = math.max(var_270_1, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_8 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_0) / var_270_8

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_8 and arg_267_1.time_ < var_270_0 + var_270_8 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play304031065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 304031065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play304031066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1036ui_story"]) and arg_271_1.var_.characterEffect1036ui_story == nil then
				arg_271_1.var_.characterEffect1036ui_story = arg_271_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1036ui_story"]) then
				if arg_271_1.var_.characterEffect1036ui_story and not isNil(arg_271_1.actors_["1036ui_story"]) then
					arg_271_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_0)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1036ui_story"]) and arg_271_1.var_.characterEffect1036ui_story then
				arg_271_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_274_1 = 0
			local var_274_2 = 0.55

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_3 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(304031065).content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 22 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 22)

				if (22 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 22)) > 0 and var_274_2 < var_274_5 then
					arg_271_1.talkMaxDuration = var_274_5

					if var_274_5 + var_274_1 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + var_274_1
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_6 = math.max(var_274_2, arg_271_1.talkMaxDuration)

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_6 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_1) / var_274_6

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_1 + var_274_6 and arg_271_1.time_ < var_274_1 + var_274_6 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play304031066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 304031066
		arg_275_1.duration_ = 6.3

		local var_275_0 = {
			zh = 3.833,
			ja = 6.3
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play304031067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1036ui_story"]) and arg_275_1.var_.characterEffect1036ui_story == nil then
				arg_275_1.var_.characterEffect1036ui_story = arg_275_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1036ui_story"]) then
				if arg_275_1.var_.characterEffect1036ui_story and not isNil(arg_275_1.actors_["1036ui_story"]) then
					arg_275_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1036ui_story"]) and arg_275_1.var_.characterEffect1036ui_story then
				arg_275_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action435")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_278_2 = 0
			local var_278_3 = 0.5

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_4 = arg_275_1:GetWordFromCfg(304031066)
				local var_278_5 = arg_275_1:FormatText(var_278_4.content)

				arg_275_1.text_.text = var_278_5

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_7 = 20 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 20)

				if (20 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 20)) > 0 and var_278_3 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_5
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031066", "story_v_out_304031.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_out_304031", "304031066", "story_v_out_304031.awb") / 1000

					if var_278_8 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_2
					end

					if var_278_4.prefab_name ~= "" and arg_275_1.actors_[var_278_4.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_4.prefab_name].transform, "story_v_out_304031", "304031066", "story_v_out_304031.awb")

						arg_275_1:RecordAudio("304031066", var_278_9)
						arg_275_1:RecordAudio("304031066", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_304031", "304031066", "story_v_out_304031.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_304031", "304031066", "story_v_out_304031.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_3, arg_275_1.talkMaxDuration)

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_2) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_2 + var_278_10 and arg_275_1.time_ < var_278_2 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play304031067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 304031067
		arg_279_1.duration_ = 8.13

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play304031068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 1.53333333333333 < arg_279_1.time_ and arg_279_1.time_ <= 1.53333333333333 + arg_282_0 then
				local var_282_0 = arg_279_1.bgs_.B10a

				arg_279_1.bgs_.B10a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_282_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_282_1 = var_282_0:GetComponent("SpriteRenderer")

				if var_282_1 and var_282_1.sprite then
					local var_282_2 = 2 * (var_282_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_282_0.transform.localScale = Vector3.New(var_282_2 / var_282_1.sprite.bounds.size.y < var_282_2 * manager.ui.mainCameraCom_.aspect / var_282_1.sprite.bounds.size.x and var_282_2 * manager.ui.mainCameraCom_.aspect / var_282_1.sprite.bounds.size.x or var_282_2 / var_282_1.sprite.bounds.size.y, var_282_2 / var_282_1.sprite.bounds.size.y < var_282_2 * manager.ui.mainCameraCom_.aspect / var_282_1.sprite.bounds.size.x and var_282_2 * manager.ui.mainCameraCom_.aspect / var_282_1.sprite.bounds.size.x or var_282_2 / var_282_1.sprite.bounds.size.y, 0)
				end

				for iter_282_0, iter_282_1 in pairs(arg_279_1.bgs_) do
					if iter_282_0 ~= "B10a" then
						iter_282_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_282_3 = 1.53333333333333

			if 1.53333333333333 < arg_279_1.time_ and arg_279_1.time_ <= var_282_3 + arg_282_0 then
				arg_279_1.allBtn_.enabled = false
			end

			if arg_279_1.time_ >= var_282_3 + 0.3 and arg_279_1.time_ < var_282_3 + 0.3 + arg_282_0 then
				arg_279_1.allBtn_.enabled = true
			end

			local var_282_4 = 0

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_5 = 1.53333333333333

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_5 then
				local var_282_6 = Color.New(0, 0, 0)

				var_282_6.a = Mathf.Lerp(0, 1, (arg_279_1.time_ - var_282_4) / var_282_5)
				arg_279_1.mask_.color = var_282_6
			end

			if arg_279_1.time_ >= var_282_4 + var_282_5 and arg_279_1.time_ < var_282_4 + var_282_5 + arg_282_0 then
				local var_282_7 = Color.New(0, 0, 0)

				var_282_7.a = 1
				arg_279_1.mask_.color = var_282_7
			end

			local var_282_8 = 1.53333333333333

			if 1.53333333333333 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.mask_.enabled = true
				arg_279_1.mask_.raycastTarget = true

				arg_279_1:SetGaussion(false)
			end

			local var_282_9 = 2

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_9 then
				local var_282_10 = Color.New(0, 0, 0)

				var_282_10.a = Mathf.Lerp(1, 0, (arg_279_1.time_ - var_282_8) / var_282_9)
				arg_279_1.mask_.color = var_282_10
			end

			if arg_279_1.time_ >= var_282_8 + var_282_9 and arg_279_1.time_ < var_282_8 + var_282_9 + arg_282_0 then
				local var_282_11 = Color.New(0, 0, 0)

				arg_279_1.mask_.enabled = false
				var_282_11.a = 0
				arg_279_1.mask_.color = var_282_11
			end

			local var_282_12 = arg_279_1.actors_["1036ui_story"].transform

			if 1.53333333333333 < arg_279_1.time_ and arg_279_1.time_ <= 1.53333333333333 + arg_282_0 then
				arg_279_1.var_.moveOldPos1036ui_story = var_282_12.localPosition
			end

			local var_282_13 = 0.001

			if 1.53333333333333 <= arg_279_1.time_ and arg_279_1.time_ < 1.53333333333333 + var_282_13 then
				var_282_12.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 1.53333333333333) / var_282_13)
				var_282_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_12.position).x, (manager.ui.mainCamera.transform.position - var_282_12.position).y, (manager.ui.mainCamera.transform.position - var_282_12.position).z)
				var_282_12.localEulerAngles.z = 0
				var_282_12.localEulerAngles.x = 0
				var_282_12.localEulerAngles = var_282_12.localEulerAngles
			end

			if arg_279_1.time_ >= 1.53333333333333 + var_282_13 and arg_279_1.time_ < 1.53333333333333 + var_282_13 + arg_282_0 then
				var_282_12.localPosition = Vector3.New(0, 100, 0)
				var_282_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_12.position).x, (manager.ui.mainCamera.transform.position - var_282_12.position).y, (manager.ui.mainCamera.transform.position - var_282_12.position).z)
				var_282_12.localEulerAngles.z = 0
				var_282_12.localEulerAngles.x = 0
				var_282_12.localEulerAngles = var_282_12.localEulerAngles
			end

			local var_282_14 = arg_279_1.actors_["1036ui_story"]

			if 1.53333333333333 < arg_279_1.time_ and arg_279_1.time_ <= 1.53333333333333 + arg_282_0 and not isNil(var_282_14) and arg_279_1.var_.characterEffect1036ui_story == nil then
				arg_279_1.var_.characterEffect1036ui_story = var_282_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_15 = 0.200000002980232

			if 1.53333333333333 <= arg_279_1.time_ and arg_279_1.time_ < 1.53333333333333 + var_282_15 and not isNil(var_282_14) then
				if arg_279_1.var_.characterEffect1036ui_story and not isNil(var_282_14) then
					arg_279_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 1.53333333333333) / var_282_15)
				end
			end

			if arg_279_1.time_ >= 1.53333333333333 + var_282_15 and arg_279_1.time_ < 1.53333333333333 + var_282_15 + arg_282_0 and not isNil(var_282_14) and arg_279_1.var_.characterEffect1036ui_story then
				arg_279_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_279_1.time_ and arg_279_1.time_ <= 1.2 + arg_282_0 then
				arg_279_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 0.2 < arg_279_1.time_ and arg_279_1.time_ <= 0.2 + arg_282_0 then
				arg_279_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_command room", "")
			end

			if arg_279_1.frameCnt_ <= 1 then
				arg_279_1.dialog_:SetActive(false)
			end

			local var_282_18 = 3.13333333333333
			local var_282_19 = 0.225

			if 3.13333333333333 < arg_279_1.time_ and arg_279_1.time_ <= var_282_18 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0

				arg_279_1.dialog_:SetActive(true)

				arg_279_1.dialogCg_.alpha = 0

				local var_282_20 = LeanTween.value(arg_279_1.dialog_, 0, 1, 0.3)

				var_282_20:setOnUpdate(LuaHelper.FloatAction(function(arg_283_0)
					arg_279_1.dialogCg_.alpha = arg_283_0
				end))
				var_282_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_279_1.dialog_)
					var_282_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_279_1.duration_ = arg_279_1.duration_ + 0.3

				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_21 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(304031067).content)

				arg_279_1.text_.text = var_282_21

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_23 = 9 <= 0 and var_282_19 or var_282_19 * (utf8.len(var_282_21) / 9)

				if (9 <= 0 and var_282_19 or var_282_19 * (utf8.len(var_282_21) / 9)) > 0 and var_282_19 < var_282_23 then
					arg_279_1.talkMaxDuration = var_282_23
					var_282_18 = var_282_18 + 0.3

					if var_282_23 + var_282_18 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_23 + var_282_18
					end
				end

				arg_279_1.text_.text = var_282_21
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_24 = var_282_18 + 0.3
			local var_282_25 = math.max(var_282_19, arg_279_1.talkMaxDuration)

			if var_282_18 + 0.3 <= arg_279_1.time_ and arg_279_1.time_ < var_282_24 + var_282_25 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_24) / var_282_25

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_24 + var_282_25 and arg_279_1.time_ < var_282_24 + var_282_25 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play304031068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 304031068
		arg_285_1.duration_ = 8.73

		local var_285_0 = {
			zh = 8.733,
			ja = 1.999999999999
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
				arg_285_0:Play304031069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1084ui_story = arg_285_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1084ui_story"].transform.position).z)
				arg_285_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1084ui_story"].transform.localEulerAngles = arg_285_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_285_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1084ui_story"].transform.position).z)
				arg_285_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1084ui_story"].transform.localEulerAngles = arg_285_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1084ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1084ui_story == nil then
				arg_285_1.var_.characterEffect1084ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect1084ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1084ui_story then
				arg_285_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_288_4 = 0
			local var_288_5 = 0.925

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(304031068)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 37 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 37)

				if (37 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 37)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031068", "story_v_out_304031.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_304031", "304031068", "story_v_out_304031.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_304031", "304031068", "story_v_out_304031.awb")

						arg_285_1:RecordAudio("304031068", var_288_11)
						arg_285_1:RecordAudio("304031068", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_304031", "304031068", "story_v_out_304031.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_304031", "304031068", "story_v_out_304031.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play304031069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 304031069
		arg_289_1.duration_ = 2.9

		local var_289_0 = {
			zh = 2.9,
			ja = 2.733
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
				arg_289_0:Play304031070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if arg_289_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_292_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_289_1.stage_.transform)

				var_292_0.name = "1011ui_story"
				var_292_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.actors_["1011ui_story"] = var_292_0

				local var_292_1 = var_292_0:GetComponentInChildren(typeof(CharacterEffect))

				var_292_1.enabled = true

				local var_292_2 = GameObjectTools.GetOrAddComponent(var_292_0, typeof(DynamicBoneHelper))

				if var_292_2 then
					var_292_2:EnableDynamicBone(false)
				end

				arg_289_1:ShowWeapon(var_292_1.transform, false)

				arg_289_1.var_["1011ui_story" .. "Animator"] = var_292_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_289_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_289_1.var_["1011ui_story" .. "LipSync"] = var_292_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_292_3 = arg_289_1.actors_["1011ui_story"].transform

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1011ui_story = var_292_3.localPosition
			end

			local var_292_4 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				var_292_3.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_289_1.time_ - 0) / var_292_4)
				var_292_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_3.position).x, (manager.ui.mainCamera.transform.position - var_292_3.position).y, (manager.ui.mainCamera.transform.position - var_292_3.position).z)
				var_292_3.localEulerAngles.z = 0
				var_292_3.localEulerAngles.x = 0
				var_292_3.localEulerAngles = var_292_3.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				var_292_3.localPosition = Vector3.New(0.7, -0.71, -6)
				var_292_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_3.position).x, (manager.ui.mainCamera.transform.position - var_292_3.position).y, (manager.ui.mainCamera.transform.position - var_292_3.position).z)
				var_292_3.localEulerAngles.z = 0
				var_292_3.localEulerAngles.x = 0
				var_292_3.localEulerAngles = var_292_3.localEulerAngles
			end

			local var_292_5 = arg_289_1.actors_["1011ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.characterEffect1011ui_story == nil then
				arg_289_1.var_.characterEffect1011ui_story = var_292_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_6 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_6 and not isNil(var_292_5) then
				if arg_289_1.var_.characterEffect1011ui_story and not isNil(var_292_5) then
					arg_289_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_6 and arg_289_1.time_ < 0 + var_292_6 + arg_292_0 and not isNil(var_292_5) and arg_289_1.var_.characterEffect1011ui_story then
				arg_289_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_292_8 = arg_289_1.actors_["1084ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_8) and arg_289_1.var_.characterEffect1084ui_story == nil then
				arg_289_1.var_.characterEffect1084ui_story = var_292_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_9 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_9 and not isNil(var_292_8) then
				if arg_289_1.var_.characterEffect1084ui_story and not isNil(var_292_8) then
					arg_289_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_9)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_9 and arg_289_1.time_ < 0 + var_292_9 + arg_292_0 and not isNil(var_292_8) and arg_289_1.var_.characterEffect1084ui_story then
				arg_289_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_292_10 = 0
			local var_292_11 = 0.325

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_12 = arg_289_1:GetWordFromCfg(304031069)
				local var_292_13 = arg_289_1:FormatText(var_292_12.content)

				arg_289_1.text_.text = var_292_13

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_15 = 13 <= 0 and var_292_11 or var_292_11 * (utf8.len(var_292_13) / 13)

				if (13 <= 0 and var_292_11 or var_292_11 * (utf8.len(var_292_13) / 13)) > 0 and var_292_11 < var_292_15 then
					arg_289_1.talkMaxDuration = var_292_15

					if var_292_15 + var_292_10 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_15 + var_292_10
					end
				end

				arg_289_1.text_.text = var_292_13
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031069", "story_v_out_304031.awb") ~= 0 then
					local var_292_16 = manager.audio:GetVoiceLength("story_v_out_304031", "304031069", "story_v_out_304031.awb") / 1000

					if var_292_16 + var_292_10 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_16 + var_292_10
					end

					if var_292_12.prefab_name ~= "" and arg_289_1.actors_[var_292_12.prefab_name] ~= nil then
						local var_292_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_12.prefab_name].transform, "story_v_out_304031", "304031069", "story_v_out_304031.awb")

						arg_289_1:RecordAudio("304031069", var_292_17)
						arg_289_1:RecordAudio("304031069", var_292_17)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_304031", "304031069", "story_v_out_304031.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_304031", "304031069", "story_v_out_304031.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_18 = math.max(var_292_11, arg_289_1.talkMaxDuration)

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_18 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_10) / var_292_18

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_10 + var_292_18 and arg_289_1.time_ < var_292_10 + var_292_18 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play304031070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 304031070
		arg_293_1.duration_ = 7.73

		local var_293_0 = {
			zh = 6.9,
			ja = 7.733
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
				arg_293_0:Play304031071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1019ui_story = arg_293_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1019ui_story"].transform.position).z)
				arg_293_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1019ui_story"].transform.localEulerAngles = arg_293_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_293_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1019ui_story"].transform.position).z)
				arg_293_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1019ui_story"].transform.localEulerAngles = arg_293_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["1011ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1011ui_story = var_296_1.localPosition
			end

			local var_296_2 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 then
				var_296_1.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_2)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 then
				var_296_1.localPosition = Vector3.New(0, 100, 0)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			local var_296_3 = arg_293_1.actors_["1084ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1084ui_story = var_296_3.localPosition
			end

			local var_296_4 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				var_296_3.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_4)
				var_296_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_3.position).x, (manager.ui.mainCamera.transform.position - var_296_3.position).y, (manager.ui.mainCamera.transform.position - var_296_3.position).z)
				var_296_3.localEulerAngles.z = 0
				var_296_3.localEulerAngles.x = 0
				var_296_3.localEulerAngles = var_296_3.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				var_296_3.localPosition = Vector3.New(0, 100, 0)
				var_296_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_3.position).x, (manager.ui.mainCamera.transform.position - var_296_3.position).y, (manager.ui.mainCamera.transform.position - var_296_3.position).z)
				var_296_3.localEulerAngles.z = 0
				var_296_3.localEulerAngles.x = 0
				var_296_3.localEulerAngles = var_296_3.localEulerAngles
			end

			local var_296_5 = arg_293_1.actors_["1019ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_5) and arg_293_1.var_.characterEffect1019ui_story == nil then
				arg_293_1.var_.characterEffect1019ui_story = var_296_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_6 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_6 and not isNil(var_296_5) then
				if arg_293_1.var_.characterEffect1019ui_story and not isNil(var_296_5) then
					arg_293_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_6 and arg_293_1.time_ < 0 + var_296_6 + arg_296_0 and not isNil(var_296_5) and arg_293_1.var_.characterEffect1019ui_story then
				arg_293_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_296_8 = arg_293_1.actors_["1011ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_8) and arg_293_1.var_.characterEffect1011ui_story == nil then
				arg_293_1.var_.characterEffect1011ui_story = var_296_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_9 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_9 and not isNil(var_296_8) then
				if arg_293_1.var_.characterEffect1011ui_story and not isNil(var_296_8) then
					arg_293_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_9)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_9 and arg_293_1.time_ < 0 + var_296_9 + arg_296_0 and not isNil(var_296_8) and arg_293_1.var_.characterEffect1011ui_story then
				arg_293_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_296_10 = 0
			local var_296_11 = 0.85

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_12 = arg_293_1:GetWordFromCfg(304031070)
				local var_296_13 = arg_293_1:FormatText(var_296_12.content)

				arg_293_1.text_.text = var_296_13

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_15 = 34 <= 0 and var_296_11 or var_296_11 * (utf8.len(var_296_13) / 34)

				if (34 <= 0 and var_296_11 or var_296_11 * (utf8.len(var_296_13) / 34)) > 0 and var_296_11 < var_296_15 then
					arg_293_1.talkMaxDuration = var_296_15

					if var_296_15 + var_296_10 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_15 + var_296_10
					end
				end

				arg_293_1.text_.text = var_296_13
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031070", "story_v_out_304031.awb") ~= 0 then
					local var_296_16 = manager.audio:GetVoiceLength("story_v_out_304031", "304031070", "story_v_out_304031.awb") / 1000

					if var_296_16 + var_296_10 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_16 + var_296_10
					end

					if var_296_12.prefab_name ~= "" and arg_293_1.actors_[var_296_12.prefab_name] ~= nil then
						local var_296_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_12.prefab_name].transform, "story_v_out_304031", "304031070", "story_v_out_304031.awb")

						arg_293_1:RecordAudio("304031070", var_296_17)
						arg_293_1:RecordAudio("304031070", var_296_17)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_304031", "304031070", "story_v_out_304031.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_304031", "304031070", "story_v_out_304031.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_18 = math.max(var_296_11, arg_293_1.talkMaxDuration)

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_18 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_10) / var_296_18

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_10 + var_296_18 and arg_293_1.time_ < var_296_10 + var_296_18 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play304031071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 304031071
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play304031072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1019ui_story"]) and arg_297_1.var_.characterEffect1019ui_story == nil then
				arg_297_1.var_.characterEffect1019ui_story = arg_297_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1019ui_story"]) then
				if arg_297_1.var_.characterEffect1019ui_story and not isNil(arg_297_1.actors_["1019ui_story"]) then
					arg_297_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_0)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1019ui_story"]) and arg_297_1.var_.characterEffect1019ui_story then
				arg_297_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_300_1 = 0
			local var_300_2 = 0.5

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(304031071).content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 20 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 20)

				if (20 <= 0 and var_300_2 or var_300_2 * (utf8.len(var_300_3) / 20)) > 0 and var_300_2 < var_300_5 then
					arg_297_1.talkMaxDuration = var_300_5

					if var_300_5 + var_300_1 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + var_300_1
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_6 = math.max(var_300_2, arg_297_1.talkMaxDuration)

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_6 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_1) / var_300_6

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_1 + var_300_6 and arg_297_1.time_ < var_300_1 + var_300_6 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play304031072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 304031072
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play304031073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 1.3

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(304031072).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 52 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 52)

				if (52 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 52)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play304031073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 304031073
		arg_305_1.duration_ = 6.17

		local var_305_0 = {
			zh = 4.633,
			ja = 6.166
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
				arg_305_0:Play304031074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1019ui_story"]) and arg_305_1.var_.characterEffect1019ui_story == nil then
				arg_305_1.var_.characterEffect1019ui_story = arg_305_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1019ui_story"]) then
				if arg_305_1.var_.characterEffect1019ui_story and not isNil(arg_305_1.actors_["1019ui_story"]) then
					arg_305_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1019ui_story"]) and arg_305_1.var_.characterEffect1019ui_story then
				arg_305_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			local var_308_2 = 0
			local var_308_3 = 0.575

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_2 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_4 = arg_305_1:GetWordFromCfg(304031073)
				local var_308_5 = arg_305_1:FormatText(var_308_4.content)

				arg_305_1.text_.text = var_308_5

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_7 = 23 <= 0 and var_308_3 or var_308_3 * (utf8.len(var_308_5) / 23)

				if (23 <= 0 and var_308_3 or var_308_3 * (utf8.len(var_308_5) / 23)) > 0 and var_308_3 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_2 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_2
					end
				end

				arg_305_1.text_.text = var_308_5
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031073", "story_v_out_304031.awb") ~= 0 then
					local var_308_8 = manager.audio:GetVoiceLength("story_v_out_304031", "304031073", "story_v_out_304031.awb") / 1000

					if var_308_8 + var_308_2 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_8 + var_308_2
					end

					if var_308_4.prefab_name ~= "" and arg_305_1.actors_[var_308_4.prefab_name] ~= nil then
						local var_308_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_4.prefab_name].transform, "story_v_out_304031", "304031073", "story_v_out_304031.awb")

						arg_305_1:RecordAudio("304031073", var_308_9)
						arg_305_1:RecordAudio("304031073", var_308_9)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_304031", "304031073", "story_v_out_304031.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_304031", "304031073", "story_v_out_304031.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_10 = math.max(var_308_3, arg_305_1.talkMaxDuration)

			if var_308_2 <= arg_305_1.time_ and arg_305_1.time_ < var_308_2 + var_308_10 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_2) / var_308_10

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_2 + var_308_10 and arg_305_1.time_ < var_308_2 + var_308_10 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play304031074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 304031074
		arg_309_1.duration_ = 10.57

		local var_309_0 = {
			zh = 8.133,
			ja = 10.566
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play304031075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 1.025

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:GetWordFromCfg(304031074)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 41 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 41)

				if (41 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 41)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304031", "304031074", "story_v_out_304031.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_out_304031", "304031074", "story_v_out_304031.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_out_304031", "304031074", "story_v_out_304031.awb")

						arg_309_1:RecordAudio("304031074", var_312_6)
						arg_309_1:RecordAudio("304031074", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_304031", "304031074", "story_v_out_304031.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_304031", "304031074", "story_v_out_304031.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_7 and arg_309_1.time_ < 0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play304031075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 304031075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
			arg_313_1.auto_ = false
		end

		function arg_313_1.playNext_(arg_315_0)
			arg_313_1.onStoryFinished_()
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1019ui_story"]) and arg_313_1.var_.characterEffect1019ui_story == nil then
				arg_313_1.var_.characterEffect1019ui_story = arg_313_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1019ui_story"]) then
				if arg_313_1.var_.characterEffect1019ui_story and not isNil(arg_313_1.actors_["1019ui_story"]) then
					arg_313_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1019ui_story"]) and arg_313_1.var_.characterEffect1019ui_story then
				arg_313_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 0.6

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
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

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(304031075).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 24 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 24)

				if (24 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 24)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10a",
		"TextureConfig/Background/B02a",
		"TextureConfig/Background/S0103",
		"TextureConfig/Background/S0201",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_304031.awb"
	}
}
