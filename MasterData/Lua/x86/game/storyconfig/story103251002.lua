return {
	Play325102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325102001
		arg_1_1.duration_ = 4.5

		local var_1_0 = {
			zh = 4.066,
			ja = 4.5
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
				arg_1_0:Play325102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J29g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J29g")
				var_4_0.name = "J29g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J29g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J29g

				arg_1_1.bgs_.J29g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J29g" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_5_1_story_jianzhong", "bgm_activity_5_1_story_jianzhong")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_13 = 2
			local var_4_14 = 0.175

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(325102001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 7 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 7)

				if (7 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 7)) > 0 and var_4_14 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_13 = var_4_13 + 0.3

					if var_4_19 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102001", "story_v_out_325102.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_out_325102", "325102001", "story_v_out_325102.awb") / 1000

					if var_4_20 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_13
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_325102", "325102001", "story_v_out_325102.awb")

						arg_1_1:RecordAudio("325102001", var_4_21)
						arg_1_1:RecordAudio("325102001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325102", "325102001", "story_v_out_325102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325102", "325102001", "story_v_out_325102.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_13 + 0.3
			local var_4_23 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play325102002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325102002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325102003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.625

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325102002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 65 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 65)

				if (65 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 65)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325102003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325102003
		arg_12_1.duration_ = 1.63

		local var_12_0 = {
			zh = 1.2,
			ja = 1.633
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
				arg_12_0:Play325102004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.125

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:GetWordFromCfg(325102003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 5 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 5)

				if (5 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 5)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102003", "story_v_out_325102.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102003", "story_v_out_325102.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_325102", "325102003", "story_v_out_325102.awb")

						arg_12_1:RecordAudio("325102003", var_15_6)
						arg_12_1:RecordAudio("325102003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_325102", "325102003", "story_v_out_325102.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_325102", "325102003", "story_v_out_325102.awb")
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
	Play325102004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325102004
		arg_16_1.duration_ = 2

		local var_16_0 = {
			zh = 1.266,
			ja = 2
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325102005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.15

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(325102004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 6 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 6)

				if (6 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 6)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102004", "story_v_out_325102.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102004", "story_v_out_325102.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_325102", "325102004", "story_v_out_325102.awb")

						arg_16_1:RecordAudio("325102004", var_19_6)
						arg_16_1:RecordAudio("325102004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325102", "325102004", "story_v_out_325102.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325102", "325102004", "story_v_out_325102.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play325102005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325102005
		arg_20_1.duration_ = 6.17

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325102006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_9000

			if arg_20_1.actors_["1077ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1077ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1077ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1077ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1077ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1077ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1077ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1077ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1077ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1077ui_story = var_23_3.localPosition

				local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_4 then
					var_23_4:EnableDynamicBone(false)
				end
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_5)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(0, 100, 0)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles

				local var_23_6 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_6 then
					var_23_6:EnableDynamicBone(true)
				end
			end

			local var_23_7 = "1059ui_story"

			if arg_20_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_23_8 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_20_1.stage_.transform)

				var_23_8.name = var_23_7
				var_23_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_[var_23_7] = var_23_8

				local var_23_9 = var_23_8:GetComponentInChildren(typeof(CharacterEffect))

				var_23_9.enabled = true

				local var_23_10 = GameObjectTools.GetOrAddComponent(var_23_8, typeof(DynamicBoneHelper))

				if var_23_10 then
					var_23_10:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_9.transform, false)

				arg_20_1.var_[var_23_7 .. "Animator"] = var_23_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_[var_23_7 .. "Animator"].applyRootMotion = true
				arg_20_1.var_[var_23_7 .. "LipSync"] = var_23_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_11 = arg_20_1.actors_["1059ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect1059ui_story == nil then
				arg_20_1.var_.characterEffect1059ui_story = var_23_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_12 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_12 and not isNil(var_23_11) then
				if arg_20_1.var_.characterEffect1059ui_story and not isNil(var_23_11) then
					arg_20_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_12)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_12 and arg_20_1.time_ < 0 + var_23_12 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect1059ui_story then
				arg_20_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				local var_23_13 = arg_20_1.var_.effect43243

				if not arg_20_1.var_.effect43243 then
					var_23_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_emp"), manager.ui.mainCamera.transform)
					var_23_13.name = "43243"
					arg_20_1.var_.effect43243 = var_23_13
				else
					var_23_13.transform:SetParent(var_23_9000)
				end

				var_23_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_23_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_23_15 = 0.266666666666667

			if 0.266666666666667 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_16 = 0.733333333333333

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_16 then
				local var_23_17 = Color.New(1, 1, 1)

				var_23_17.a = Mathf.Lerp(1, 0, (arg_20_1.time_ - var_23_15) / var_23_16)
				arg_20_1.mask_.color = var_23_17
			end

			if arg_20_1.time_ >= var_23_15 + var_23_16 and arg_20_1.time_ < var_23_15 + var_23_16 + arg_23_0 then
				local var_23_18 = Color.New(1, 1, 1)

				arg_20_1.mask_.enabled = false
				var_23_18.a = 0
				arg_20_1.mask_.color = var_23_18
			end

			local var_23_19 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			if arg_20_1.time_ >= var_23_19 + 1.43333333333333 and arg_20_1.time_ < var_23_19 + 1.43333333333333 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			if 0.5 < arg_20_1.time_ and arg_20_1.time_ <= 0.5 + arg_23_0 then
				arg_20_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_flash", "")
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_21 = 1.16666666666667
			local var_23_22 = 1.2

			if 1.16666666666667 < arg_20_1.time_ and arg_20_1.time_ <= var_23_21 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_23 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_23:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_24 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(325102005).content)

				arg_20_1.text_.text = var_23_24

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_26 = 48 <= 0 and var_23_22 or var_23_22 * (utf8.len(var_23_24) / 48)

				if (48 <= 0 and var_23_22 or var_23_22 * (utf8.len(var_23_24) / 48)) > 0 and var_23_22 < var_23_26 then
					arg_20_1.talkMaxDuration = var_23_26
					var_23_21 = var_23_21 + 0.3

					if var_23_26 + var_23_21 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_26 + var_23_21
					end
				end

				arg_20_1.text_.text = var_23_24
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_27 = var_23_21 + 0.3
			local var_23_28 = math.max(var_23_22, arg_20_1.talkMaxDuration)

			if var_23_21 + 0.3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_27 + var_23_28 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_27) / var_23_28

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_27 + var_23_28 and arg_20_1.time_ < var_23_27 + var_23_28 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play325102006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 325102006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play325102007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0.5 < arg_26_1.time_ and arg_26_1.time_ <= 0.5 + arg_29_0 then
				arg_26_1:AudioAction("play", "effect", "se_story_150", "se_story_150_sword07", "")
			end

			local var_29_1 = 0
			local var_29_2 = 1.15

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_3 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(325102006).content)

				arg_26_1.text_.text = var_29_3

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 46 <= 0 and var_29_2 or var_29_2 * (utf8.len(var_29_3) / 46)

				if (46 <= 0 and var_29_2 or var_29_2 * (utf8.len(var_29_3) / 46)) > 0 and var_29_2 < var_29_5 then
					arg_26_1.talkMaxDuration = var_29_5

					if var_29_5 + var_29_1 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + var_29_1
					end
				end

				arg_26_1.text_.text = var_29_3
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_6 = math.max(var_29_2, arg_26_1.talkMaxDuration)

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_6 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_1) / var_29_6

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_1 + var_29_6 and arg_26_1.time_ < var_29_1 + var_29_6 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play325102007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 325102007
		arg_30_1.duration_ = 3.43

		local var_30_0 = {
			zh = 3.433,
			ja = 2.466
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
				arg_30_0:Play325102008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.2

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_1 = arg_30_1:GetWordFromCfg(325102007)
				local var_33_2 = arg_30_1:FormatText(var_33_1.content)

				arg_30_1.text_.text = var_33_2

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 8 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 8)

				if (8 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 8)) > 0 and var_33_0 < var_33_4 then
					arg_30_1.talkMaxDuration = var_33_4

					if var_33_4 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_4 + 0
					end
				end

				arg_30_1.text_.text = var_33_2
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102007", "story_v_out_325102.awb") ~= 0 then
					local var_33_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102007", "story_v_out_325102.awb") / 1000

					if var_33_5 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + 0
					end

					if var_33_1.prefab_name ~= "" and arg_30_1.actors_[var_33_1.prefab_name] ~= nil then
						local var_33_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_1.prefab_name].transform, "story_v_out_325102", "325102007", "story_v_out_325102.awb")

						arg_30_1:RecordAudio("325102007", var_33_6)
						arg_30_1:RecordAudio("325102007", var_33_6)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_325102", "325102007", "story_v_out_325102.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_325102", "325102007", "story_v_out_325102.awb")
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
	Play325102008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 325102008
		arg_34_1.duration_ = 9.97

		local var_34_0 = {
			zh = 9.86633333333333,
			ja = 9.96633333333333
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
				arg_34_0:Play325102009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 2 < arg_34_1.time_ and arg_34_1.time_ <= 2 + arg_37_0 then
				local var_37_0 = arg_34_1.bgs_.J29g

				arg_34_1.bgs_.J29g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_37_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_37_1 = var_37_0:GetComponent("SpriteRenderer")

				if var_37_1 and var_37_1.sprite then
					local var_37_2 = 2 * (var_37_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_37_0.transform.localScale = Vector3.New(var_37_2 / var_37_1.sprite.bounds.size.y < var_37_2 * manager.ui.mainCameraCom_.aspect / var_37_1.sprite.bounds.size.x and var_37_2 * manager.ui.mainCameraCom_.aspect / var_37_1.sprite.bounds.size.x or var_37_2 / var_37_1.sprite.bounds.size.y, var_37_2 / var_37_1.sprite.bounds.size.y < var_37_2 * manager.ui.mainCameraCom_.aspect / var_37_1.sprite.bounds.size.x and var_37_2 * manager.ui.mainCameraCom_.aspect / var_37_1.sprite.bounds.size.x or var_37_2 / var_37_1.sprite.bounds.size.y, 0)
				end

				for iter_37_0, iter_37_1 in pairs(arg_34_1.bgs_) do
					if iter_37_0 ~= "J29g" then
						iter_37_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_37_3 = 0

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_3 + arg_37_0 then
				arg_34_1.allBtn_.enabled = false
			end

			if arg_34_1.time_ >= var_37_3 + 0.3 and arg_34_1.time_ < var_37_3 + 0.3 + arg_37_0 then
				arg_34_1.allBtn_.enabled = true
			end

			local var_37_4 = 0

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_5 = 2

			if var_37_4 <= arg_34_1.time_ and arg_34_1.time_ < var_37_4 + var_37_5 then
				local var_37_6 = Color.New(0, 0, 0)

				var_37_6.a = Mathf.Lerp(0, 1, (arg_34_1.time_ - var_37_4) / var_37_5)
				arg_34_1.mask_.color = var_37_6
			end

			if arg_34_1.time_ >= var_37_4 + var_37_5 and arg_34_1.time_ < var_37_4 + var_37_5 + arg_37_0 then
				local var_37_7 = Color.New(0, 0, 0)

				var_37_7.a = 1
				arg_34_1.mask_.color = var_37_7
			end

			local var_37_8 = 2

			if 2 < arg_34_1.time_ and arg_34_1.time_ <= var_37_8 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_9 = 2

			if var_37_8 <= arg_34_1.time_ and arg_34_1.time_ < var_37_8 + var_37_9 then
				local var_37_10 = Color.New(0, 0, 0)

				var_37_10.a = Mathf.Lerp(1, 0, (arg_34_1.time_ - var_37_8) / var_37_9)
				arg_34_1.mask_.color = var_37_10
			end

			if arg_34_1.time_ >= var_37_8 + var_37_9 and arg_34_1.time_ < var_37_8 + var_37_9 + arg_37_0 then
				local var_37_11 = Color.New(0, 0, 0)

				arg_34_1.mask_.enabled = false
				var_37_11.a = 0
				arg_34_1.mask_.color = var_37_11
			end

			local var_37_12 = arg_34_1.actors_["1077ui_story"].transform

			if 3.4 < arg_34_1.time_ and arg_34_1.time_ <= 3.4 + arg_37_0 then
				arg_34_1.var_.moveOldPos1077ui_story = var_37_12.localPosition

				local var_37_13 = GameObjectTools.GetOrAddComponent(var_37_12.gameObject, typeof(DynamicBoneHelper))

				if var_37_13 then
					var_37_13:EnableDynamicBone(false)
				end
			end

			local var_37_14 = 0.001

			if 3.4 <= arg_34_1.time_ and arg_34_1.time_ < 3.4 + var_37_14 then
				var_37_12.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_34_1.time_ - 3.4) / var_37_14)
				var_37_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_12.position).x, (manager.ui.mainCamera.transform.position - var_37_12.position).y, (manager.ui.mainCamera.transform.position - var_37_12.position).z)
				var_37_12.localEulerAngles.z = 0
				var_37_12.localEulerAngles.x = 0
				var_37_12.localEulerAngles = var_37_12.localEulerAngles
			end

			if arg_34_1.time_ >= 3.4 + var_37_14 and arg_34_1.time_ < 3.4 + var_37_14 + arg_37_0 then
				var_37_12.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_37_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_12.position).x, (manager.ui.mainCamera.transform.position - var_37_12.position).y, (manager.ui.mainCamera.transform.position - var_37_12.position).z)
				var_37_12.localEulerAngles.z = 0
				var_37_12.localEulerAngles.x = 0
				var_37_12.localEulerAngles = var_37_12.localEulerAngles

				local var_37_15 = GameObjectTools.GetOrAddComponent(var_37_12.gameObject, typeof(DynamicBoneHelper))

				if var_37_15 then
					var_37_15:EnableDynamicBone(true)
				end
			end

			local var_37_16 = arg_34_1.actors_["1077ui_story"]

			if 3.4 < arg_34_1.time_ and arg_34_1.time_ <= 3.4 + arg_37_0 and not isNil(var_37_16) and arg_34_1.var_.characterEffect1077ui_story == nil then
				arg_34_1.var_.characterEffect1077ui_story = var_37_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_17 = 0.200000002980232

			if 3.4 <= arg_34_1.time_ and arg_34_1.time_ < 3.4 + var_37_17 and not isNil(var_37_16) then
				if arg_34_1.var_.characterEffect1077ui_story and not isNil(var_37_16) then
					arg_34_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 3.4 + var_37_17 and arg_34_1.time_ < 3.4 + var_37_17 + arg_37_0 and not isNil(var_37_16) and arg_34_1.var_.characterEffect1077ui_story then
				arg_34_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 3.43400000184774 < arg_34_1.time_ and arg_34_1.time_ <= 3.43400000184774 + arg_37_0 then
				arg_34_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_1")
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 3.43400000184774 < arg_34_1.time_ and arg_34_1.time_ <= 3.43400000184774 + arg_37_0 then
				arg_34_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if arg_34_1.frameCnt_ <= 1 then
				arg_34_1.dialog_:SetActive(false)
			end

			local var_37_19 = 3.73333333333333
			local var_37_20 = 0.725

			if 3.73333333333333 < arg_34_1.time_ and arg_34_1.time_ <= var_37_19 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				arg_34_1.dialog_:SetActive(true)

				arg_34_1.dialogCg_.alpha = 0

				local var_37_21 = LeanTween.value(arg_34_1.dialog_, 0, 1, 0.3)

				var_37_21:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
					arg_34_1.dialogCg_.alpha = arg_38_0
				end))
				var_37_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_34_1.dialog_)
					var_37_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_34_1.duration_ = arg_34_1.duration_ + 0.3

				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_22 = arg_34_1:GetWordFromCfg(325102008)
				local var_37_23 = arg_34_1:FormatText(var_37_22.content)

				arg_34_1.text_.text = var_37_23

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_25 = 29 <= 0 and var_37_20 or var_37_20 * (utf8.len(var_37_23) / 29)

				if (29 <= 0 and var_37_20 or var_37_20 * (utf8.len(var_37_23) / 29)) > 0 and var_37_20 < var_37_25 then
					arg_34_1.talkMaxDuration = var_37_25
					var_37_19 = var_37_19 + 0.3

					if var_37_25 + var_37_19 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_25 + var_37_19
					end
				end

				arg_34_1.text_.text = var_37_23
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102008", "story_v_out_325102.awb") ~= 0 then
					local var_37_26 = manager.audio:GetVoiceLength("story_v_out_325102", "325102008", "story_v_out_325102.awb") / 1000

					if var_37_26 + var_37_19 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_26 + var_37_19
					end

					if var_37_22.prefab_name ~= "" and arg_34_1.actors_[var_37_22.prefab_name] ~= nil then
						local var_37_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_22.prefab_name].transform, "story_v_out_325102", "325102008", "story_v_out_325102.awb")

						arg_34_1:RecordAudio("325102008", var_37_27)
						arg_34_1:RecordAudio("325102008", var_37_27)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_325102", "325102008", "story_v_out_325102.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_325102", "325102008", "story_v_out_325102.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_28 = var_37_19 + 0.3
			local var_37_29 = math.max(var_37_20, arg_34_1.talkMaxDuration)

			if var_37_19 + 0.3 <= arg_34_1.time_ and arg_34_1.time_ < var_37_28 + var_37_29 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_28) / var_37_29

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_28 + var_37_29 and arg_34_1.time_ < var_37_28 + var_37_29 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play325102009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325102009
		arg_40_1.duration_ = 3.97

		local var_40_0 = {
			zh = 2.3,
			ja = 3.966
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
				arg_40_0:Play325102010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.175

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:GetWordFromCfg(325102009)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 7 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 7)

				if (7 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 7)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102009", "story_v_out_325102.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102009", "story_v_out_325102.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_325102", "325102009", "story_v_out_325102.awb")

						arg_40_1:RecordAudio("325102009", var_43_6)
						arg_40_1:RecordAudio("325102009", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325102", "325102009", "story_v_out_325102.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325102", "325102009", "story_v_out_325102.awb")
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
	Play325102010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325102010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325102011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1077ui_story = arg_44_1.actors_["1077ui_story"].transform.localPosition

				local var_47_0 = GameObjectTools.GetOrAddComponent(arg_44_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_47_0 then
					var_47_0:EnableDynamicBone(false)
				end
			end

			local var_47_1 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_1 then
				arg_44_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_1)
				arg_44_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1077ui_story"].transform.position).z)
				arg_44_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1077ui_story"].transform.localEulerAngles = arg_44_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_1 and arg_44_1.time_ < 0 + var_47_1 + arg_47_0 then
				arg_44_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1077ui_story"].transform.position).z)
				arg_44_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1077ui_story"].transform.localEulerAngles = arg_44_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_47_2 = GameObjectTools.GetOrAddComponent(arg_44_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(true)
				end
			end

			local var_47_3 = arg_44_1.actors_["1077ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1077ui_story == nil then
				arg_44_1.var_.characterEffect1077ui_story = var_47_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_4 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 and not isNil(var_47_3) then
				if arg_44_1.var_.characterEffect1077ui_story and not isNil(var_47_3) then
					arg_44_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_4)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 and not isNil(var_47_3) and arg_44_1.var_.characterEffect1077ui_story then
				arg_44_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0.5 < arg_44_1.time_ and arg_44_1.time_ <= 0.5 + arg_47_0 then
				arg_44_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_laser", "")
			end

			local var_47_6 = 0
			local var_47_7 = 1.1

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_8 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(325102010).content)

				arg_44_1.text_.text = var_47_8

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_10 = 44 <= 0 and var_47_7 or var_47_7 * (utf8.len(var_47_8) / 44)

				if (44 <= 0 and var_47_7 or var_47_7 * (utf8.len(var_47_8) / 44)) > 0 and var_47_7 < var_47_10 then
					arg_44_1.talkMaxDuration = var_47_10

					if var_47_10 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_8
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_11 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_11 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_11

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_11 and arg_44_1.time_ < var_47_6 + var_47_11 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play325102011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325102011
		arg_48_1.duration_ = 8.13

		local var_48_0 = {
			zh = 5.7,
			ja = 8.133
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
				arg_48_0:Play325102012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.5

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_1 = arg_48_1:GetWordFromCfg(325102011)
				local var_51_2 = arg_48_1:FormatText(var_51_1.content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 20 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 20)

				if (20 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 20)) > 0 and var_51_0 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102011", "story_v_out_325102.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102011", "story_v_out_325102.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_out_325102", "325102011", "story_v_out_325102.awb")

						arg_48_1:RecordAudio("325102011", var_51_6)
						arg_48_1:RecordAudio("325102011", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325102", "325102011", "story_v_out_325102.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325102", "325102011", "story_v_out_325102.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325102012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325102012
		arg_52_1.duration_ = 5.87

		local var_52_0 = {
			zh = 2.5,
			ja = 5.866
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
				arg_52_0:Play325102013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1077ui_story = arg_52_1.actors_["1077ui_story"].transform.localPosition

				local var_55_0 = GameObjectTools.GetOrAddComponent(arg_52_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_55_0 then
					var_55_0:EnableDynamicBone(false)
				end
			end

			local var_55_1 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_1 then
				arg_52_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_52_1.time_ - 0) / var_55_1)
				arg_52_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1077ui_story"].transform.position).z)
				arg_52_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1077ui_story"].transform.localEulerAngles = arg_52_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_1 and arg_52_1.time_ < 0 + var_55_1 + arg_55_0 then
				arg_52_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_52_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1077ui_story"].transform.position).z)
				arg_52_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1077ui_story"].transform.localEulerAngles = arg_52_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_55_2 = GameObjectTools.GetOrAddComponent(arg_52_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(true)
				end
			end

			local var_55_3 = arg_52_1.actors_["1077ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_3) and arg_52_1.var_.characterEffect1077ui_story == nil then
				arg_52_1.var_.characterEffect1077ui_story = var_55_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_4 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 and not isNil(var_55_3) then
				if arg_52_1.var_.characterEffect1077ui_story and not isNil(var_55_3) then
					arg_52_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 and not isNil(var_55_3) and arg_52_1.var_.characterEffect1077ui_story then
				arg_52_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action7_2")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_55_6 = 0
			local var_55_7 = 0.35

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_8 = arg_52_1:GetWordFromCfg(325102012)
				local var_55_9 = arg_52_1:FormatText(var_55_8.content)

				arg_52_1.text_.text = var_55_9

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 14 <= 0 and var_55_7 or var_55_7 * (utf8.len(var_55_9) / 14)

				if (14 <= 0 and var_55_7 or var_55_7 * (utf8.len(var_55_9) / 14)) > 0 and var_55_7 < var_55_11 then
					arg_52_1.talkMaxDuration = var_55_11

					if var_55_11 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_9
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102012", "story_v_out_325102.awb") ~= 0 then
					local var_55_12 = manager.audio:GetVoiceLength("story_v_out_325102", "325102012", "story_v_out_325102.awb") / 1000

					if var_55_12 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_12 + var_55_6
					end

					if var_55_8.prefab_name ~= "" and arg_52_1.actors_[var_55_8.prefab_name] ~= nil then
						local var_55_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_8.prefab_name].transform, "story_v_out_325102", "325102012", "story_v_out_325102.awb")

						arg_52_1:RecordAudio("325102012", var_55_13)
						arg_52_1:RecordAudio("325102012", var_55_13)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325102", "325102012", "story_v_out_325102.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325102", "325102012", "story_v_out_325102.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_14 and arg_52_1.time_ < var_55_6 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play325102013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325102013
		arg_56_1.duration_ = 5.4

		local var_56_0 = {
			zh = 4.066,
			ja = 5.4
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
				arg_56_0:Play325102014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1077ui_story"]) and arg_56_1.var_.characterEffect1077ui_story == nil then
				arg_56_1.var_.characterEffect1077ui_story = arg_56_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1077ui_story"]) then
				if arg_56_1.var_.characterEffect1077ui_story and not isNil(arg_56_1.actors_["1077ui_story"]) then
					arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1077ui_story"]) and arg_56_1.var_.characterEffect1077ui_story then
				arg_56_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_59_1 = 0
			local var_59_2 = 0.475

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:GetWordFromCfg(325102013)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 19 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 19)

				if (19 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 19)) > 0 and var_59_2 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102013", "story_v_out_325102.awb") ~= 0 then
					local var_59_7 = manager.audio:GetVoiceLength("story_v_out_325102", "325102013", "story_v_out_325102.awb") / 1000

					if var_59_7 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_1
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_325102", "325102013", "story_v_out_325102.awb")

						arg_56_1:RecordAudio("325102013", var_59_8)
						arg_56_1:RecordAudio("325102013", var_59_8)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325102", "325102013", "story_v_out_325102.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325102", "325102013", "story_v_out_325102.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_9 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_9 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_9

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_9 and arg_56_1.time_ < var_59_1 + var_59_9 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play325102014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325102014
		arg_60_1.duration_ = 2.47

		local var_60_0 = {
			zh = 2.2,
			ja = 2.466
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
				arg_60_0:Play325102015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1077ui_story"]) and arg_60_1.var_.characterEffect1077ui_story == nil then
				arg_60_1.var_.characterEffect1077ui_story = arg_60_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1077ui_story"]) then
				if arg_60_1.var_.characterEffect1077ui_story and not isNil(arg_60_1.actors_["1077ui_story"]) then
					arg_60_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1077ui_story"]) and arg_60_1.var_.characterEffect1077ui_story then
				arg_60_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_63_2 = 0
			local var_63_3 = 0.3

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_4 = arg_60_1:GetWordFromCfg(325102014)
				local var_63_5 = arg_60_1:FormatText(var_63_4.content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_7 = 12 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 12)

				if (12 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 12)) > 0 and var_63_3 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_2
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102014", "story_v_out_325102.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_325102", "325102014", "story_v_out_325102.awb") / 1000

					if var_63_8 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_2
					end

					if var_63_4.prefab_name ~= "" and arg_60_1.actors_[var_63_4.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_4.prefab_name].transform, "story_v_out_325102", "325102014", "story_v_out_325102.awb")

						arg_60_1:RecordAudio("325102014", var_63_9)
						arg_60_1:RecordAudio("325102014", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325102", "325102014", "story_v_out_325102.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325102", "325102014", "story_v_out_325102.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_3, arg_60_1.talkMaxDuration)

			if var_63_2 <= arg_60_1.time_ and arg_60_1.time_ < var_63_2 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_2) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_2 + var_63_10 and arg_60_1.time_ < var_63_2 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play325102015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325102015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325102016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1059ui_story = arg_64_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1059ui_story"].transform.position).z)
				arg_64_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1059ui_story"].transform.localEulerAngles = arg_64_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1059ui_story"].transform.position).z)
				arg_64_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1059ui_story"].transform.localEulerAngles = arg_64_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_67_1 = arg_64_1.actors_["1077ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1077ui_story = var_67_1.localPosition

				local var_67_2 = GameObjectTools.GetOrAddComponent(var_67_1.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(false)
				end
			end

			local var_67_3 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 then
				var_67_1.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_3)
				var_67_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_1.position).x, (manager.ui.mainCamera.transform.position - var_67_1.position).y, (manager.ui.mainCamera.transform.position - var_67_1.position).z)
				var_67_1.localEulerAngles.z = 0
				var_67_1.localEulerAngles.x = 0
				var_67_1.localEulerAngles = var_67_1.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 then
				var_67_1.localPosition = Vector3.New(0, 100, 0)
				var_67_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_1.position).x, (manager.ui.mainCamera.transform.position - var_67_1.position).y, (manager.ui.mainCamera.transform.position - var_67_1.position).z)
				var_67_1.localEulerAngles.z = 0
				var_67_1.localEulerAngles.x = 0
				var_67_1.localEulerAngles = var_67_1.localEulerAngles

				local var_67_4 = GameObjectTools.GetOrAddComponent(var_67_1.gameObject, typeof(DynamicBoneHelper))

				if var_67_4 then
					var_67_4:EnableDynamicBone(true)
				end
			end

			local var_67_5 = arg_64_1.actors_["1077ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_5) and arg_64_1.var_.characterEffect1077ui_story == nil then
				arg_64_1.var_.characterEffect1077ui_story = var_67_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_6 and not isNil(var_67_5) then
				if arg_64_1.var_.characterEffect1077ui_story and not isNil(var_67_5) then
					arg_64_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_6)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_6 and arg_64_1.time_ < 0 + var_67_6 + arg_67_0 and not isNil(var_67_5) and arg_64_1.var_.characterEffect1077ui_story then
				arg_64_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_67_7 = 0
			local var_67_8 = 1.125

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_7 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_9 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(325102015).content)

				arg_64_1.text_.text = var_67_9

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 45 <= 0 and var_67_8 or var_67_8 * (utf8.len(var_67_9) / 45)

				if (45 <= 0 and var_67_8 or var_67_8 * (utf8.len(var_67_9) / 45)) > 0 and var_67_8 < var_67_11 then
					arg_64_1.talkMaxDuration = var_67_11

					if var_67_11 + var_67_7 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_11 + var_67_7
					end
				end

				arg_64_1.text_.text = var_67_9
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_8, arg_64_1.talkMaxDuration)

			if var_67_7 <= arg_64_1.time_ and arg_64_1.time_ < var_67_7 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_7) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_7 + var_67_12 and arg_64_1.time_ < var_67_7 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play325102016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325102016
		arg_68_1.duration_ = 4.23

		local var_68_0 = {
			zh = 4.233,
			ja = 4.166
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
				arg_68_0:Play325102017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.475

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:GetWordFromCfg(325102016)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 19 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 19)

				if (19 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 19)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102016", "story_v_out_325102.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102016", "story_v_out_325102.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_325102", "325102016", "story_v_out_325102.awb")

						arg_68_1:RecordAudio("325102016", var_71_6)
						arg_68_1:RecordAudio("325102016", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325102", "325102016", "story_v_out_325102.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325102", "325102016", "story_v_out_325102.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play325102017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325102017
		arg_72_1.duration_ = 9.87

		local var_72_0 = {
			zh = 4.2,
			ja = 9.866
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
				arg_72_0:Play325102018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1077ui_story = arg_72_1.actors_["1077ui_story"].transform.localPosition

				local var_75_0 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_0 then
					var_75_0:EnableDynamicBone(false)
				end
			end

			local var_75_1 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_1 then
				arg_72_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_1)
				arg_72_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1077ui_story"].transform.position).z)
				arg_72_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1077ui_story"].transform.localEulerAngles = arg_72_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_1 and arg_72_1.time_ < 0 + var_75_1 + arg_75_0 then
				arg_72_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1077ui_story"].transform.position).z)
				arg_72_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1077ui_story"].transform.localEulerAngles = arg_72_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_75_2 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(true)
				end
			end

			local var_75_3 = arg_72_1.actors_["1077ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect1077ui_story == nil then
				arg_72_1.var_.characterEffect1077ui_story = var_75_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_4 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 and not isNil(var_75_3) then
				if arg_72_1.var_.characterEffect1077ui_story and not isNil(var_75_3) then
					arg_72_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 and not isNil(var_75_3) and arg_72_1.var_.characterEffect1077ui_story then
				arg_72_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_75_6 = 0
			local var_75_7 = 0.6

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_8 = arg_72_1:GetWordFromCfg(325102017)
				local var_75_9 = arg_72_1:FormatText(var_75_8.content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 24 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 24)

				if (24 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 24)) > 0 and var_75_7 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102017", "story_v_out_325102.awb") ~= 0 then
					local var_75_12 = manager.audio:GetVoiceLength("story_v_out_325102", "325102017", "story_v_out_325102.awb") / 1000

					if var_75_12 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_6
					end

					if var_75_8.prefab_name ~= "" and arg_72_1.actors_[var_75_8.prefab_name] ~= nil then
						local var_75_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_8.prefab_name].transform, "story_v_out_325102", "325102017", "story_v_out_325102.awb")

						arg_72_1:RecordAudio("325102017", var_75_13)
						arg_72_1:RecordAudio("325102017", var_75_13)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_325102", "325102017", "story_v_out_325102.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_325102", "325102017", "story_v_out_325102.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325102018
		arg_76_1.duration_ = 1.73

		local var_76_0 = {
			zh = 1.433,
			ja = 1.733
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
				arg_76_0:Play325102019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1077ui_story"]) and arg_76_1.var_.characterEffect1077ui_story == nil then
				arg_76_1.var_.characterEffect1077ui_story = arg_76_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1077ui_story"]) then
				if arg_76_1.var_.characterEffect1077ui_story and not isNil(arg_76_1.actors_["1077ui_story"]) then
					arg_76_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_0)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1077ui_story"]) and arg_76_1.var_.characterEffect1077ui_story then
				arg_76_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_79_1 = 0
			local var_79_2 = 0.125

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(325102018)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_6 = 5 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 5)

				if (5 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_4) / 5)) > 0 and var_79_2 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102018", "story_v_out_325102.awb") ~= 0 then
					local var_79_7 = manager.audio:GetVoiceLength("story_v_out_325102", "325102018", "story_v_out_325102.awb") / 1000

					if var_79_7 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_1
					end

					if var_79_3.prefab_name ~= "" and arg_76_1.actors_[var_79_3.prefab_name] ~= nil then
						local var_79_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_3.prefab_name].transform, "story_v_out_325102", "325102018", "story_v_out_325102.awb")

						arg_76_1:RecordAudio("325102018", var_79_8)
						arg_76_1:RecordAudio("325102018", var_79_8)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325102", "325102018", "story_v_out_325102.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325102", "325102018", "story_v_out_325102.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_9 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_9 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_9

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_9 and arg_76_1.time_ < var_79_1 + var_79_9 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play325102019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325102019
		arg_80_1.duration_ = 5.9

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play325102020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_9000

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1059ui_story = arg_80_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1059ui_story"].transform.position).z)
				arg_80_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1059ui_story"].transform.localEulerAngles = arg_80_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1059ui_story"].transform.position).z)
				arg_80_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1059ui_story"].transform.localEulerAngles = arg_80_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_83_1 = arg_80_1.actors_["1077ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1077ui_story = var_83_1.localPosition

				local var_83_2 = GameObjectTools.GetOrAddComponent(var_83_1.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(false)
				end
			end

			local var_83_3 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 then
				var_83_1.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_3)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 then
				var_83_1.localPosition = Vector3.New(0, 100, 0)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles

				local var_83_4 = GameObjectTools.GetOrAddComponent(var_83_1.gameObject, typeof(DynamicBoneHelper))

				if var_83_4 then
					var_83_4:EnableDynamicBone(true)
				end
			end

			local var_83_5 = arg_80_1.actors_["1059ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_5) and arg_80_1.var_.characterEffect1059ui_story == nil then
				arg_80_1.var_.characterEffect1059ui_story = var_83_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_6 and not isNil(var_83_5) then
				if arg_80_1.var_.characterEffect1059ui_story and not isNil(var_83_5) then
					arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_6)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_6 and arg_80_1.time_ < 0 + var_83_6 + arg_83_0 and not isNil(var_83_5) and arg_80_1.var_.characterEffect1059ui_story then
				arg_80_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				local var_83_7 = arg_80_1.var_.effect4324

				if not arg_80_1.var_.effect4324 then
					var_83_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_83_7.name = "4324"
					arg_80_1.var_.effect4324 = var_83_7
				else
					var_83_7.transform:SetParent(var_83_9000)
				end

				var_83_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_83_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_83_7.transform.localScale = Vector3.New(var_83_7.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_83_7.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_83_7.transform.localScale.z)
			end

			if 1.86666666666667 < arg_80_1.time_ and arg_80_1.time_ <= 1.86666666666667 + arg_83_0 then
				if arg_80_1.var_.effect4324 then
					Object.Destroy(arg_80_1.var_.effect4324)

					arg_80_1.var_.effect4324 = nil
				end
			end

			local var_83_10 = 0

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 then
				arg_80_1.allBtn_.enabled = false
			end

			if arg_80_1.time_ >= var_83_10 + 1.43333333333333 and arg_80_1.time_ < var_83_10 + 1.43333333333333 + arg_83_0 then
				arg_80_1.allBtn_.enabled = true
			end

			if 0.3 < arg_80_1.time_ and arg_80_1.time_ <= 0.3 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_smoke", "")
			end

			if 1.3 < arg_80_1.time_ and arg_80_1.time_ <= 1.3 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_141", "se_story_141_foley_cloth", "")
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_13 = 0.9
			local var_83_14 = 1.375

			if 0.9 < arg_80_1.time_ and arg_80_1.time_ <= var_83_13 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_15 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_15:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_16 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(325102019).content)

				arg_80_1.text_.text = var_83_16

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_18 = 55 <= 0 and var_83_14 or var_83_14 * (utf8.len(var_83_16) / 55)

				if (55 <= 0 and var_83_14 or var_83_14 * (utf8.len(var_83_16) / 55)) > 0 and var_83_14 < var_83_18 then
					arg_80_1.talkMaxDuration = var_83_18
					var_83_13 = var_83_13 + 0.3

					if var_83_18 + var_83_13 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_18 + var_83_13
					end
				end

				arg_80_1.text_.text = var_83_16
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_19 = var_83_13 + 0.3
			local var_83_20 = math.max(var_83_14, arg_80_1.talkMaxDuration)

			if var_83_13 + 0.3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_19 + var_83_20 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_19) / var_83_20

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_19 + var_83_20 and arg_80_1.time_ < var_83_19 + var_83_20 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325102020
		arg_86_1.duration_ = 3.23

		local var_86_0 = {
			zh = 3,
			ja = 3.233
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
				arg_86_0:Play325102021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.3

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_1 = arg_86_1:GetWordFromCfg(325102020)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 12 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 12)

				if (12 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 12)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102020", "story_v_out_325102.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102020", "story_v_out_325102.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_325102", "325102020", "story_v_out_325102.awb")

						arg_86_1:RecordAudio("325102020", var_89_6)
						arg_86_1:RecordAudio("325102020", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_325102", "325102020", "story_v_out_325102.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_325102", "325102020", "story_v_out_325102.awb")
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
	Play325102021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 325102021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play325102022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0.3 < arg_90_1.time_ and arg_90_1.time_ <= 0.3 + arg_93_0 then
				arg_90_1:AudioAction("play", "effect", "se_story_150", "se_story_150_sword03", "")
			end

			local var_93_1 = 0
			local var_93_2 = 0.775

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(325102021).content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 31 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 31)

				if (31 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 31)) > 0 and var_93_2 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_6 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_6 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_6

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_6 and arg_90_1.time_ < var_93_1 + var_93_6 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play325102022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 325102022
		arg_94_1.duration_ = 4.23

		local var_94_0 = {
			zh = 3.033,
			ja = 4.233
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
				arg_94_0:Play325102023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1077ui_story = arg_94_1.actors_["1077ui_story"].transform.localPosition

				local var_97_0 = GameObjectTools.GetOrAddComponent(arg_94_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_97_0 then
					var_97_0:EnableDynamicBone(false)
				end
			end

			local var_97_1 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_1 then
				arg_94_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_94_1.time_ - 0) / var_97_1)
				arg_94_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).z)
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles = arg_94_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_1 and arg_94_1.time_ < 0 + var_97_1 + arg_97_0 then
				arg_94_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_94_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1077ui_story"].transform.position).z)
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1077ui_story"].transform.localEulerAngles = arg_94_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_97_2 = GameObjectTools.GetOrAddComponent(arg_94_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(true)
				end
			end

			local var_97_3 = arg_94_1.actors_["1077ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect1077ui_story == nil then
				arg_94_1.var_.characterEffect1077ui_story = var_97_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_4 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 and not isNil(var_97_3) then
				if arg_94_1.var_.characterEffect1077ui_story and not isNil(var_97_3) then
					arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect1077ui_story then
				arg_94_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_97_6 = 0
			local var_97_7 = 0.45

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_8 = arg_94_1:GetWordFromCfg(325102022)
				local var_97_9 = arg_94_1:FormatText(var_97_8.content)

				arg_94_1.text_.text = var_97_9

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 18 <= 0 and var_97_7 or var_97_7 * (utf8.len(var_97_9) / 18)

				if (18 <= 0 and var_97_7 or var_97_7 * (utf8.len(var_97_9) / 18)) > 0 and var_97_7 < var_97_11 then
					arg_94_1.talkMaxDuration = var_97_11

					if var_97_11 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_11 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_9
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102022", "story_v_out_325102.awb") ~= 0 then
					local var_97_12 = manager.audio:GetVoiceLength("story_v_out_325102", "325102022", "story_v_out_325102.awb") / 1000

					if var_97_12 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_12 + var_97_6
					end

					if var_97_8.prefab_name ~= "" and arg_94_1.actors_[var_97_8.prefab_name] ~= nil then
						local var_97_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_8.prefab_name].transform, "story_v_out_325102", "325102022", "story_v_out_325102.awb")

						arg_94_1:RecordAudio("325102022", var_97_13)
						arg_94_1:RecordAudio("325102022", var_97_13)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_325102", "325102022", "story_v_out_325102.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_325102", "325102022", "story_v_out_325102.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_14 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_14 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_14

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_14 and arg_94_1.time_ < var_97_6 + var_97_14 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play325102023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325102023
		arg_98_1.duration_ = 4.3

		local var_98_0 = {
			zh = 3.166,
			ja = 4.3
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play325102024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1077ui_story"]) and arg_98_1.var_.characterEffect1077ui_story == nil then
				arg_98_1.var_.characterEffect1077ui_story = arg_98_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1077ui_story"]) then
				if arg_98_1.var_.characterEffect1077ui_story and not isNil(arg_98_1.actors_["1077ui_story"]) then
					arg_98_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_0)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1077ui_story"]) and arg_98_1.var_.characterEffect1077ui_story then
				arg_98_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_101_1 = 0
			local var_101_2 = 0.275

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_3 = arg_98_1:GetWordFromCfg(325102023)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_6 = 11 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_4) / 11)

				if (11 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_4) / 11)) > 0 and var_101_2 < var_101_6 then
					arg_98_1.talkMaxDuration = var_101_6

					if var_101_6 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_1
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102023", "story_v_out_325102.awb") ~= 0 then
					local var_101_7 = manager.audio:GetVoiceLength("story_v_out_325102", "325102023", "story_v_out_325102.awb") / 1000

					if var_101_7 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_1
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_out_325102", "325102023", "story_v_out_325102.awb")

						arg_98_1:RecordAudio("325102023", var_101_8)
						arg_98_1:RecordAudio("325102023", var_101_8)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_325102", "325102023", "story_v_out_325102.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_325102", "325102023", "story_v_out_325102.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_9 = math.max(var_101_2, arg_98_1.talkMaxDuration)

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_9 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_1) / var_101_9

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_1 + var_101_9 and arg_98_1.time_ < var_101_1 + var_101_9 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play325102024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325102024
		arg_102_1.duration_ = 13.33

		local var_102_0 = {
			zh = 6.3,
			ja = 13.333
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play325102025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.5

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_1 = arg_102_1:GetWordFromCfg(325102024)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 20 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 20)

				if (20 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 20)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102024", "story_v_out_325102.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102024", "story_v_out_325102.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_325102", "325102024", "story_v_out_325102.awb")

						arg_102_1:RecordAudio("325102024", var_105_6)
						arg_102_1:RecordAudio("325102024", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_325102", "325102024", "story_v_out_325102.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_325102", "325102024", "story_v_out_325102.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325102025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325102025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play325102026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1059ui_story = arg_106_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_106_1.time_ - 0) / var_109_0)
				arg_106_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1059ui_story"].transform.position).z)
				arg_106_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1059ui_story"].transform.localEulerAngles = arg_106_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_106_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1059ui_story"].transform.position).z)
				arg_106_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1059ui_story"].transform.localEulerAngles = arg_106_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_109_1 = arg_106_1.actors_["1077ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1077ui_story = var_109_1.localPosition

				local var_109_2 = GameObjectTools.GetOrAddComponent(var_109_1.gameObject, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(false)
				end
			end

			local var_109_3 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 then
				var_109_1.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_106_1.time_ - 0) / var_109_3)
				var_109_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_1.position).x, (manager.ui.mainCamera.transform.position - var_109_1.position).y, (manager.ui.mainCamera.transform.position - var_109_1.position).z)
				var_109_1.localEulerAngles.z = 0
				var_109_1.localEulerAngles.x = 0
				var_109_1.localEulerAngles = var_109_1.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 then
				var_109_1.localPosition = Vector3.New(0, 100, 0)
				var_109_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_1.position).x, (manager.ui.mainCamera.transform.position - var_109_1.position).y, (manager.ui.mainCamera.transform.position - var_109_1.position).z)
				var_109_1.localEulerAngles.z = 0
				var_109_1.localEulerAngles.x = 0
				var_109_1.localEulerAngles = var_109_1.localEulerAngles

				local var_109_4 = GameObjectTools.GetOrAddComponent(var_109_1.gameObject, typeof(DynamicBoneHelper))

				if var_109_4 then
					var_109_4:EnableDynamicBone(true)
				end
			end

			if 0.3 < arg_106_1.time_ and arg_106_1.time_ <= 0.3 + arg_109_0 then
				arg_106_1:AudioAction("play", "effect", "se_story_6", "se_story_6_draw_out02", "")
			end

			local var_109_6 = 0
			local var_109_7 = 0.975

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_8 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(325102025).content)

				arg_106_1.text_.text = var_109_8

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_10 = 39 <= 0 and var_109_7 or var_109_7 * (utf8.len(var_109_8) / 39)

				if (39 <= 0 and var_109_7 or var_109_7 * (utf8.len(var_109_8) / 39)) > 0 and var_109_7 < var_109_10 then
					arg_106_1.talkMaxDuration = var_109_10

					if var_109_10 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_8
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_11 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_11 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_11

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_11 and arg_106_1.time_ < var_109_6 + var_109_11 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play325102026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325102026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play325102027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 1.15

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(325102026).content)

				arg_110_1.text_.text = var_113_1

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_3 = 46 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 46)

				if (46 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 46)) > 0 and var_113_0 < var_113_3 then
					arg_110_1.talkMaxDuration = var_113_3

					if var_113_3 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_3 + 0
					end
				end

				arg_110_1.text_.text = var_113_1
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_4 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_4

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play325102027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325102027
		arg_114_1.duration_ = 2.93

		local var_114_0 = {
			zh = 1.4,
			ja = 2.933
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play325102028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.225

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_1 = arg_114_1:GetWordFromCfg(325102027)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 9 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 9)

				if (9 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 9)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102027", "story_v_out_325102.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102027", "story_v_out_325102.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_325102", "325102027", "story_v_out_325102.awb")

						arg_114_1:RecordAudio("325102027", var_117_6)
						arg_114_1:RecordAudio("325102027", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_325102", "325102027", "story_v_out_325102.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_325102", "325102027", "story_v_out_325102.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play325102028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325102028
		arg_118_1.duration_ = 2.33

		local var_118_0 = {
			zh = 1.999999999999,
			ja = 2.333
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play325102029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1077ui_story = arg_118_1.actors_["1077ui_story"].transform.localPosition

				local var_121_0 = GameObjectTools.GetOrAddComponent(arg_118_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_121_0 then
					var_121_0:EnableDynamicBone(false)
				end
			end

			local var_121_1 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_1 then
				arg_118_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_118_1.time_ - 0) / var_121_1)
				arg_118_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1077ui_story"].transform.position).z)
				arg_118_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1077ui_story"].transform.localEulerAngles = arg_118_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_1 and arg_118_1.time_ < 0 + var_121_1 + arg_121_0 then
				arg_118_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_118_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1077ui_story"].transform.position).z)
				arg_118_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1077ui_story"].transform.localEulerAngles = arg_118_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_121_2 = GameObjectTools.GetOrAddComponent(arg_118_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_121_2 then
					var_121_2:EnableDynamicBone(true)
				end
			end

			local var_121_3 = arg_118_1.actors_["1077ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_3) and arg_118_1.var_.characterEffect1077ui_story == nil then
				arg_118_1.var_.characterEffect1077ui_story = var_121_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_4 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 and not isNil(var_121_3) then
				if arg_118_1.var_.characterEffect1077ui_story and not isNil(var_121_3) then
					arg_118_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 and not isNil(var_121_3) and arg_118_1.var_.characterEffect1077ui_story then
				arg_118_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_121_6 = 0
			local var_121_7 = 0.3

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_8 = arg_118_1:GetWordFromCfg(325102028)
				local var_121_9 = arg_118_1:FormatText(var_121_8.content)

				arg_118_1.text_.text = var_121_9

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 12 <= 0 and var_121_7 or var_121_7 * (utf8.len(var_121_9) / 12)

				if (12 <= 0 and var_121_7 or var_121_7 * (utf8.len(var_121_9) / 12)) > 0 and var_121_7 < var_121_11 then
					arg_118_1.talkMaxDuration = var_121_11

					if var_121_11 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_11 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_9
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102028", "story_v_out_325102.awb") ~= 0 then
					local var_121_12 = manager.audio:GetVoiceLength("story_v_out_325102", "325102028", "story_v_out_325102.awb") / 1000

					if var_121_12 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_12 + var_121_6
					end

					if var_121_8.prefab_name ~= "" and arg_118_1.actors_[var_121_8.prefab_name] ~= nil then
						local var_121_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_8.prefab_name].transform, "story_v_out_325102", "325102028", "story_v_out_325102.awb")

						arg_118_1:RecordAudio("325102028", var_121_13)
						arg_118_1:RecordAudio("325102028", var_121_13)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_325102", "325102028", "story_v_out_325102.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_325102", "325102028", "story_v_out_325102.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_14 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_14 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_14

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_14 and arg_118_1.time_ < var_121_6 + var_121_14 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play325102029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325102029
		arg_122_1.duration_ = 6.4

		local var_122_0 = {
			zh = 6.4,
			ja = 4.866
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play325102030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077actionlink/1077action426")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_125_0 = 0
			local var_125_1 = 0.7

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_2 = arg_122_1:GetWordFromCfg(325102029)
				local var_125_3 = arg_122_1:FormatText(var_125_2.content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 28 <= 0 and var_125_1 or var_125_1 * (utf8.len(var_125_3) / 28)

				if (28 <= 0 and var_125_1 or var_125_1 * (utf8.len(var_125_3) / 28)) > 0 and var_125_1 < var_125_5 then
					arg_122_1.talkMaxDuration = var_125_5

					if var_125_5 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102029", "story_v_out_325102.awb") ~= 0 then
					local var_125_6 = manager.audio:GetVoiceLength("story_v_out_325102", "325102029", "story_v_out_325102.awb") / 1000

					if var_125_6 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_0
					end

					if var_125_2.prefab_name ~= "" and arg_122_1.actors_[var_125_2.prefab_name] ~= nil then
						local var_125_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_2.prefab_name].transform, "story_v_out_325102", "325102029", "story_v_out_325102.awb")

						arg_122_1:RecordAudio("325102029", var_125_7)
						arg_122_1:RecordAudio("325102029", var_125_7)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_325102", "325102029", "story_v_out_325102.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_325102", "325102029", "story_v_out_325102.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_8 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_8 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_8

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_8 and arg_122_1.time_ < var_125_0 + var_125_8 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play325102030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325102030
		arg_126_1.duration_ = 1.33

		local var_126_0 = {
			zh = 0.999999999999,
			ja = 1.333
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play325102031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1077ui_story"]) and arg_126_1.var_.characterEffect1077ui_story == nil then
				arg_126_1.var_.characterEffect1077ui_story = arg_126_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1077ui_story"]) then
				if arg_126_1.var_.characterEffect1077ui_story and not isNil(arg_126_1.actors_["1077ui_story"]) then
					arg_126_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_0)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1077ui_story"]) and arg_126_1.var_.characterEffect1077ui_story then
				arg_126_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_129_1 = 0
			local var_129_2 = 0.05

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_3 = arg_126_1:GetWordFromCfg(325102030)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_6 = 2 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_4) / 2)

				if (2 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_4) / 2)) > 0 and var_129_2 < var_129_6 then
					arg_126_1.talkMaxDuration = var_129_6

					if var_129_6 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_6 + var_129_1
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102030", "story_v_out_325102.awb") ~= 0 then
					local var_129_7 = manager.audio:GetVoiceLength("story_v_out_325102", "325102030", "story_v_out_325102.awb") / 1000

					if var_129_7 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_1
					end

					if var_129_3.prefab_name ~= "" and arg_126_1.actors_[var_129_3.prefab_name] ~= nil then
						local var_129_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_3.prefab_name].transform, "story_v_out_325102", "325102030", "story_v_out_325102.awb")

						arg_126_1:RecordAudio("325102030", var_129_8)
						arg_126_1:RecordAudio("325102030", var_129_8)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_325102", "325102030", "story_v_out_325102.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_325102", "325102030", "story_v_out_325102.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_9 = math.max(var_129_2, arg_126_1.talkMaxDuration)

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_9 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_1) / var_129_9

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_1 + var_129_9 and arg_126_1.time_ < var_129_1 + var_129_9 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play325102031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325102031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play325102032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1059ui_story = arg_130_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_133_0 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 then
				arg_130_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_0)
				arg_130_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1059ui_story"].transform.position).z)
				arg_130_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1059ui_story"].transform.localEulerAngles = arg_130_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 then
				arg_130_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1059ui_story"].transform.position).z)
				arg_130_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1059ui_story"].transform.localEulerAngles = arg_130_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_133_1 = arg_130_1.actors_["1077ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1077ui_story = var_133_1.localPosition

				local var_133_2 = GameObjectTools.GetOrAddComponent(var_133_1.gameObject, typeof(DynamicBoneHelper))

				if var_133_2 then
					var_133_2:EnableDynamicBone(false)
				end
			end

			local var_133_3 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_3 then
				var_133_1.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_3)
				var_133_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_1.position).x, (manager.ui.mainCamera.transform.position - var_133_1.position).y, (manager.ui.mainCamera.transform.position - var_133_1.position).z)
				var_133_1.localEulerAngles.z = 0
				var_133_1.localEulerAngles.x = 0
				var_133_1.localEulerAngles = var_133_1.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_3 and arg_130_1.time_ < 0 + var_133_3 + arg_133_0 then
				var_133_1.localPosition = Vector3.New(0, 100, 0)
				var_133_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_1.position).x, (manager.ui.mainCamera.transform.position - var_133_1.position).y, (manager.ui.mainCamera.transform.position - var_133_1.position).z)
				var_133_1.localEulerAngles.z = 0
				var_133_1.localEulerAngles.x = 0
				var_133_1.localEulerAngles = var_133_1.localEulerAngles

				local var_133_4 = GameObjectTools.GetOrAddComponent(var_133_1.gameObject, typeof(DynamicBoneHelper))

				if var_133_4 then
					var_133_4:EnableDynamicBone(true)
				end
			end

			local var_133_5 = arg_130_1.actors_["1059ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_5) and arg_130_1.var_.characterEffect1059ui_story == nil then
				arg_130_1.var_.characterEffect1059ui_story = var_133_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_6 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_6 and not isNil(var_133_5) then
				if arg_130_1.var_.characterEffect1059ui_story and not isNil(var_133_5) then
					arg_130_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_6)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_6 and arg_130_1.time_ < 0 + var_133_6 + arg_133_0 and not isNil(var_133_5) and arg_130_1.var_.characterEffect1059ui_story then
				arg_130_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_133_7 = 0
			local var_133_8 = 1.175

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_7 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_9 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(325102031).content)

				arg_130_1.text_.text = var_133_9

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_11 = 47 <= 0 and var_133_8 or var_133_8 * (utf8.len(var_133_9) / 47)

				if (47 <= 0 and var_133_8 or var_133_8 * (utf8.len(var_133_9) / 47)) > 0 and var_133_8 < var_133_11 then
					arg_130_1.talkMaxDuration = var_133_11

					if var_133_11 + var_133_7 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_7
					end
				end

				arg_130_1.text_.text = var_133_9
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_12 = math.max(var_133_8, arg_130_1.talkMaxDuration)

			if var_133_7 <= arg_130_1.time_ and arg_130_1.time_ < var_133_7 + var_133_12 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_7) / var_133_12

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_7 + var_133_12 and arg_130_1.time_ < var_133_7 + var_133_12 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play325102032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325102032
		arg_134_1.duration_ = 5.3

		local var_134_0 = {
			zh = 3.133,
			ja = 5.3
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play325102033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1077ui_story = arg_134_1.actors_["1077ui_story"].transform.localPosition

				local var_137_0 = GameObjectTools.GetOrAddComponent(arg_134_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_137_0 then
					var_137_0:EnableDynamicBone(false)
				end
			end

			local var_137_1 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_1 then
				arg_134_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_134_1.time_ - 0) / var_137_1)
				arg_134_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1077ui_story"].transform.position).z)
				arg_134_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1077ui_story"].transform.localEulerAngles = arg_134_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_1 and arg_134_1.time_ < 0 + var_137_1 + arg_137_0 then
				arg_134_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_134_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1077ui_story"].transform.position).z)
				arg_134_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1077ui_story"].transform.localEulerAngles = arg_134_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_137_2 = GameObjectTools.GetOrAddComponent(arg_134_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_137_2 then
					var_137_2:EnableDynamicBone(true)
				end
			end

			local var_137_3 = arg_134_1.actors_["1077ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_3) and arg_134_1.var_.characterEffect1077ui_story == nil then
				arg_134_1.var_.characterEffect1077ui_story = var_137_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_4 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 and not isNil(var_137_3) then
				if arg_134_1.var_.characterEffect1077ui_story and not isNil(var_137_3) then
					arg_134_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 and not isNil(var_137_3) and arg_134_1.var_.characterEffect1077ui_story then
				arg_134_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_137_7 = 0
			local var_137_8 = 0.35

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_7 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_9 = arg_134_1:GetWordFromCfg(325102032)
				local var_137_10 = arg_134_1:FormatText(var_137_9.content)

				arg_134_1.text_.text = var_137_10

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_12 = 14 <= 0 and var_137_8 or var_137_8 * (utf8.len(var_137_10) / 14)

				if (14 <= 0 and var_137_8 or var_137_8 * (utf8.len(var_137_10) / 14)) > 0 and var_137_8 < var_137_12 then
					arg_134_1.talkMaxDuration = var_137_12

					if var_137_12 + var_137_7 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_12 + var_137_7
					end
				end

				arg_134_1.text_.text = var_137_10
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102032", "story_v_out_325102.awb") ~= 0 then
					local var_137_13 = manager.audio:GetVoiceLength("story_v_out_325102", "325102032", "story_v_out_325102.awb") / 1000

					if var_137_13 + var_137_7 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_13 + var_137_7
					end

					if var_137_9.prefab_name ~= "" and arg_134_1.actors_[var_137_9.prefab_name] ~= nil then
						local var_137_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_9.prefab_name].transform, "story_v_out_325102", "325102032", "story_v_out_325102.awb")

						arg_134_1:RecordAudio("325102032", var_137_14)
						arg_134_1:RecordAudio("325102032", var_137_14)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_325102", "325102032", "story_v_out_325102.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_325102", "325102032", "story_v_out_325102.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_15 = math.max(var_137_8, arg_134_1.talkMaxDuration)

			if var_137_7 <= arg_134_1.time_ and arg_134_1.time_ < var_137_7 + var_137_15 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_7) / var_137_15

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_7 + var_137_15 and arg_134_1.time_ < var_137_7 + var_137_15 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play325102033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325102033
		arg_138_1.duration_ = 6.43

		local var_138_0 = {
			zh = 6.43333333333333,
			ja = 5.83333333333333
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
				arg_138_0:Play325102034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_9001
			local var_141_9000

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1077ui_story = arg_138_1.actors_["1077ui_story"].transform.localPosition

				local var_141_0 = GameObjectTools.GetOrAddComponent(arg_138_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_141_0 then
					var_141_0:EnableDynamicBone(false)
				end
			end

			local var_141_1 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_1 then
				arg_138_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_1)
				arg_138_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1077ui_story"].transform.position).z)
				arg_138_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1077ui_story"].transform.localEulerAngles = arg_138_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_1 and arg_138_1.time_ < 0 + var_141_1 + arg_141_0 then
				arg_138_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_138_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1077ui_story"].transform.position).z)
				arg_138_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1077ui_story"].transform.localEulerAngles = arg_138_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_141_2 = GameObjectTools.GetOrAddComponent(arg_138_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_141_2 then
					var_141_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				local var_141_3 = arg_138_1.var_.effect46546

				if not arg_138_1.var_.effect46546 then
					var_141_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rockfall"), manager.ui.mainCamera.transform)
					var_141_3.name = "46546"
					arg_138_1.var_.effect46546 = var_141_3
				else
					var_141_3.transform:SetParent(var_141_9001)
				end

				var_141_3.transform.localPosition = Vector3.New(0, 0, -2.74)
				var_141_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_141_3.transform.localScale = Vector3.New(var_141_3.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_141_3.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_141_3.transform.localScale.z)
			end

			local var_141_5 = 0

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.allBtn_.enabled = false
			end

			if arg_138_1.time_ >= var_141_5 + 2.05833333333333 and arg_138_1.time_ < var_141_5 + 2.05833333333333 + arg_141_0 then
				arg_138_1.allBtn_.enabled = true
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				local var_141_6 = arg_138_1.var_.effectsdsdsd

				if not arg_138_1.var_.effectsdsdsd then
					var_141_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_141_6.name = "sdsdsd"
					arg_138_1.var_.effectsdsdsd = var_141_6
				else
					var_141_6.transform:SetParent(var_141_9000)
				end

				var_141_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_141_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_141_6.transform.localScale = Vector3.New(var_141_6.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_141_6.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_141_6.transform.localScale.z)
			end

			if 2.05833333333333 < arg_138_1.time_ and arg_138_1.time_ <= 2.05833333333333 + arg_141_0 then
				if arg_138_1.var_.effectsdsdsd then
					Object.Destroy(arg_138_1.var_.effectsdsdsd)

					arg_138_1.var_.effectsdsdsd = nil
				end
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			if arg_138_1.frameCnt_ <= 1 then
				arg_138_1.dialog_:SetActive(false)
			end

			local var_141_10 = 1.73333333333333
			local var_141_11 = 0.325

			if 1.73333333333333 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0

				arg_138_1.dialog_:SetActive(true)

				arg_138_1.dialogCg_.alpha = 0

				local var_141_12 = LeanTween.value(arg_138_1.dialog_, 0, 1, 0.3)

				var_141_12:setOnUpdate(LuaHelper.FloatAction(function(arg_142_0)
					arg_138_1.dialogCg_.alpha = arg_142_0
				end))
				var_141_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_138_1.dialog_)
					var_141_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_138_1.duration_ = arg_138_1.duration_ + 0.3

				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_13 = arg_138_1:GetWordFromCfg(325102033)
				local var_141_14 = arg_138_1:FormatText(var_141_13.content)

				arg_138_1.text_.text = var_141_14

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_16 = 13 <= 0 and var_141_11 or var_141_11 * (utf8.len(var_141_14) / 13)

				if (13 <= 0 and var_141_11 or var_141_11 * (utf8.len(var_141_14) / 13)) > 0 and var_141_11 < var_141_16 then
					arg_138_1.talkMaxDuration = var_141_16
					var_141_10 = var_141_10 + 0.3

					if var_141_16 + var_141_10 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_16 + var_141_10
					end
				end

				arg_138_1.text_.text = var_141_14
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102033", "story_v_out_325102.awb") ~= 0 then
					local var_141_17 = manager.audio:GetVoiceLength("story_v_out_325102", "325102033", "story_v_out_325102.awb") / 1000

					if var_141_17 + var_141_10 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_17 + var_141_10
					end

					if var_141_13.prefab_name ~= "" and arg_138_1.actors_[var_141_13.prefab_name] ~= nil then
						local var_141_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_13.prefab_name].transform, "story_v_out_325102", "325102033", "story_v_out_325102.awb")

						arg_138_1:RecordAudio("325102033", var_141_18)
						arg_138_1:RecordAudio("325102033", var_141_18)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_325102", "325102033", "story_v_out_325102.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_325102", "325102033", "story_v_out_325102.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_19 = var_141_10 + 0.3
			local var_141_20 = math.max(var_141_11, arg_138_1.talkMaxDuration)

			if var_141_10 + 0.3 <= arg_138_1.time_ and arg_138_1.time_ < var_141_19 + var_141_20 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_19) / var_141_20

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_19 + var_141_20 and arg_138_1.time_ < var_141_19 + var_141_20 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.06666666666667,
				amplitudeGain = 1,
				startTime = 0.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.06666666666667,
				amplitudeGain = 1,
				startTime = 0.666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			},
			{
				assetPath = "",
				actorName = "",
				frequency = 9,
				className = "StoryShakeNode",
				duration = 1.36862460188568,
				startTime = 0.164708731447657,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG_HEAD,
				offset = Vector3.New(6, 0.2, 0.1)
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play325102034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 325102034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play325102035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1059ui_story = arg_144_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_147_0 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 then
				arg_144_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_144_1.time_ - 0) / var_147_0)
				arg_144_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1059ui_story"].transform.position).z)
				arg_144_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1059ui_story"].transform.localEulerAngles = arg_144_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 then
				arg_144_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_144_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1059ui_story"].transform.position).z)
				arg_144_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1059ui_story"].transform.localEulerAngles = arg_144_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_147_1 = arg_144_1.actors_["1077ui_story"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1077ui_story = var_147_1.localPosition

				local var_147_2 = GameObjectTools.GetOrAddComponent(var_147_1.gameObject, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(false)
				end
			end

			local var_147_3 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 then
				var_147_1.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_144_1.time_ - 0) / var_147_3)
				var_147_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_1.position).x, (manager.ui.mainCamera.transform.position - var_147_1.position).y, (manager.ui.mainCamera.transform.position - var_147_1.position).z)
				var_147_1.localEulerAngles.z = 0
				var_147_1.localEulerAngles.x = 0
				var_147_1.localEulerAngles = var_147_1.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 then
				var_147_1.localPosition = Vector3.New(0, 100, 0)
				var_147_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_1.position).x, (manager.ui.mainCamera.transform.position - var_147_1.position).y, (manager.ui.mainCamera.transform.position - var_147_1.position).z)
				var_147_1.localEulerAngles.z = 0
				var_147_1.localEulerAngles.x = 0
				var_147_1.localEulerAngles = var_147_1.localEulerAngles

				local var_147_4 = GameObjectTools.GetOrAddComponent(var_147_1.gameObject, typeof(DynamicBoneHelper))

				if var_147_4 then
					var_147_4:EnableDynamicBone(true)
				end
			end

			local var_147_5 = arg_144_1.actors_["1059ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_5) and arg_144_1.var_.characterEffect1059ui_story == nil then
				arg_144_1.var_.characterEffect1059ui_story = var_147_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_6 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_6 and not isNil(var_147_5) then
				if arg_144_1.var_.characterEffect1059ui_story and not isNil(var_147_5) then
					arg_144_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_6)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_6 and arg_144_1.time_ < 0 + var_147_6 + arg_147_0 and not isNil(var_147_5) and arg_144_1.var_.characterEffect1059ui_story then
				arg_144_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_147_8 = 0
			local var_147_9 = 0.85

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_10 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(325102034).content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_12 = 34 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_10) / 34)

				if (34 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_10) / 34)) > 0 and var_147_9 < var_147_12 then
					arg_144_1.talkMaxDuration = var_147_12

					if var_147_12 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_8
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_13 = math.max(var_147_9, arg_144_1.talkMaxDuration)

			if var_147_8 <= arg_144_1.time_ and arg_144_1.time_ < var_147_8 + var_147_13 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_8) / var_147_13

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_8 + var_147_13 and arg_144_1.time_ < var_147_8 + var_147_13 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play325102035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 325102035
		arg_148_1.duration_ = 7.77

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play325102036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if arg_148_1.bgs_.J22f == nil then
				local var_151_0 = Object.Instantiate(arg_148_1.paintGo_)

				var_151_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J22f")
				var_151_0.name = "J22f"
				var_151_0.transform.parent = arg_148_1.stage_.transform
				var_151_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.bgs_.J22f = var_151_0
			end

			if 1.5 < arg_148_1.time_ and arg_148_1.time_ <= 1.5 + arg_151_0 then
				local var_151_1 = arg_148_1.bgs_.J22f

				arg_148_1.bgs_.J22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_151_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_151_2 = var_151_1:GetComponent("SpriteRenderer")

				if var_151_2 and var_151_2.sprite then
					local var_151_3 = 2 * (var_151_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_151_1.transform.localScale = Vector3.New(var_151_3 / var_151_2.sprite.bounds.size.y < var_151_3 * manager.ui.mainCameraCom_.aspect / var_151_2.sprite.bounds.size.x and var_151_3 * manager.ui.mainCameraCom_.aspect / var_151_2.sprite.bounds.size.x or var_151_3 / var_151_2.sprite.bounds.size.y, var_151_3 / var_151_2.sprite.bounds.size.y < var_151_3 * manager.ui.mainCameraCom_.aspect / var_151_2.sprite.bounds.size.x and var_151_3 * manager.ui.mainCameraCom_.aspect / var_151_2.sprite.bounds.size.x or var_151_3 / var_151_2.sprite.bounds.size.y, 0)
				end

				for iter_151_0, iter_151_1 in pairs(arg_148_1.bgs_) do
					if iter_151_0 ~= "J22f" then
						iter_151_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_151_4 = 1.5

			if 1.5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1.allBtn_.enabled = false
			end

			if arg_148_1.time_ >= var_151_4 + 0.3 and arg_148_1.time_ < var_151_4 + 0.3 + arg_151_0 then
				arg_148_1.allBtn_.enabled = true
			end

			local var_151_5 = 0

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_6 = 1.5

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_6 then
				local var_151_7 = Color.New(0, 0, 0)

				var_151_7.a = Mathf.Lerp(0, 1, (arg_148_1.time_ - var_151_5) / var_151_6)
				arg_148_1.mask_.color = var_151_7
			end

			if arg_148_1.time_ >= var_151_5 + var_151_6 and arg_148_1.time_ < var_151_5 + var_151_6 + arg_151_0 then
				local var_151_8 = Color.New(0, 0, 0)

				var_151_8.a = 1
				arg_148_1.mask_.color = var_151_8
			end

			local var_151_9 = 1.5

			if 1.5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				arg_148_1.mask_.enabled = true
				arg_148_1.mask_.raycastTarget = true

				arg_148_1:SetGaussion(false)
			end

			local var_151_10 = 2

			if var_151_9 <= arg_148_1.time_ and arg_148_1.time_ < var_151_9 + var_151_10 then
				local var_151_11 = Color.New(0, 0, 0)

				var_151_11.a = Mathf.Lerp(1, 0, (arg_148_1.time_ - var_151_9) / var_151_10)
				arg_148_1.mask_.color = var_151_11
			end

			if arg_148_1.time_ >= var_151_9 + var_151_10 and arg_148_1.time_ < var_151_9 + var_151_10 + arg_151_0 then
				local var_151_12 = Color.New(0, 0, 0)

				arg_148_1.mask_.enabled = false
				var_151_12.a = 0
				arg_148_1.mask_.color = var_151_12
			end

			if 1.5 < arg_148_1.time_ and arg_148_1.time_ <= 1.5 + arg_151_0 then
				if arg_148_1.var_.effect46546 then
					Object.Destroy(arg_148_1.var_.effect46546)

					arg_148_1.var_.effect46546 = nil
				end
			end

			if 1.2 < arg_148_1.time_ and arg_148_1.time_ <= 1.2 + arg_151_0 then
				arg_148_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_lost_city", "")
			end

			if 1.4 < arg_148_1.time_ and arg_148_1.time_ <= 1.4 + arg_151_0 then
				arg_148_1:AudioAction("play", "effect", "se_story_148", "se_story_148_footstep04", "")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:AudioAction("play", "music", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_151_18 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

				if "" ~= "" then
					if arg_148_1.bgmTxt_.text ~= var_151_18 and arg_148_1.bgmTxt_.text ~= "" then
						if arg_148_1.bgmTxt2_.text ~= "" then
							arg_148_1.bgmTxt_.text = arg_148_1.bgmTxt2_.text
						end

						arg_148_1.bgmTxt2_.text = var_151_18

						arg_148_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_148_1.bgmTxt_.text = var_151_18
						arg_148_1.bgmTxt2_.text = var_151_18
					end

					if arg_148_1.bgmTimer then
						arg_148_1.bgmTimer:Stop()

						arg_148_1.bgmTimer = nil
					end

					if arg_148_1.settingData.show_music_name == 1 then
						arg_148_1.musicController:SetSelectedState("show")
						arg_148_1.musicAnimator_:Play("open", 0, 0)

						if arg_148_1.settingData.music_time ~= 0 then
							arg_148_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_148_1.settingData.music_time), function()
								if arg_148_1 == nil or isNil(arg_148_1.bgmTxt_) then
									return
								end

								arg_148_1.musicController:SetSelectedState("hide")
								arg_148_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_148_1.frameCnt_ <= 1 then
				arg_148_1.dialog_:SetActive(false)
			end

			local var_151_19 = 2.76666666666667
			local var_151_20 = 1.15

			if 2.76666666666667 < arg_148_1.time_ and arg_148_1.time_ <= var_151_19 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				arg_148_1.dialog_:SetActive(true)

				arg_148_1.dialogCg_.alpha = 0

				local var_151_21 = LeanTween.value(arg_148_1.dialog_, 0, 1, 0.3)

				var_151_21:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_148_1.dialogCg_.alpha = arg_153_0
				end))
				var_151_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_148_1.dialog_)
					var_151_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_148_1.duration_ = arg_148_1.duration_ + 0.3

				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_22 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(325102035).content)

				arg_148_1.text_.text = var_151_22

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_24 = 46 <= 0 and var_151_20 or var_151_20 * (utf8.len(var_151_22) / 46)

				if (46 <= 0 and var_151_20 or var_151_20 * (utf8.len(var_151_22) / 46)) > 0 and var_151_20 < var_151_24 then
					arg_148_1.talkMaxDuration = var_151_24
					var_151_19 = var_151_19 + 0.3

					if var_151_24 + var_151_19 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_24 + var_151_19
					end
				end

				arg_148_1.text_.text = var_151_22
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_25 = var_151_19 + 0.3
			local var_151_26 = math.max(var_151_20, arg_148_1.talkMaxDuration)

			if var_151_19 + 0.3 <= arg_148_1.time_ and arg_148_1.time_ < var_151_25 + var_151_26 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_25) / var_151_26

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_25 + var_151_26 and arg_148_1.time_ < var_151_25 + var_151_26 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play325102036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 325102036
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play325102037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_158_1 = 0
			local var_158_2 = 1.1

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

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(325102036).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 44 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 44)

				if (44 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 44)) > 0 and var_158_2 < var_158_5 then
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
	Play325102037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 325102037
		arg_159_1.duration_ = 5.37

		local var_159_0 = {
			zh = 2.3,
			ja = 5.366
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
				arg_159_0:Play325102038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1077ui_story = arg_159_1.actors_["1077ui_story"].transform.localPosition

				local var_162_0 = GameObjectTools.GetOrAddComponent(arg_159_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_162_0 then
					var_162_0:EnableDynamicBone(false)
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_159_1.time_ - 0) / var_162_1)
				arg_159_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1077ui_story"].transform.position).z)
				arg_159_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1077ui_story"].transform.localEulerAngles = arg_159_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_159_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1077ui_story"].transform.position).z)
				arg_159_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1077ui_story"].transform.localEulerAngles = arg_159_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_162_2 = GameObjectTools.GetOrAddComponent(arg_159_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_162_2 then
					var_162_2:EnableDynamicBone(true)
				end
			end

			local var_162_3 = arg_159_1.actors_["1077ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_3) and arg_159_1.var_.characterEffect1077ui_story == nil then
				arg_159_1.var_.characterEffect1077ui_story = var_162_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_4 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 and not isNil(var_162_3) then
				if arg_159_1.var_.characterEffect1077ui_story and not isNil(var_162_3) then
					arg_159_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 and not isNil(var_162_3) and arg_159_1.var_.characterEffect1077ui_story then
				arg_159_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_162_6 = 0
			local var_162_7 = 0.35

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_6 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_8 = arg_159_1:GetWordFromCfg(325102037)
				local var_162_9 = arg_159_1:FormatText(var_162_8.content)

				arg_159_1.text_.text = var_162_9

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_11 = 14 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 14)

				if (14 <= 0 and var_162_7 or var_162_7 * (utf8.len(var_162_9) / 14)) > 0 and var_162_7 < var_162_11 then
					arg_159_1.talkMaxDuration = var_162_11

					if var_162_11 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_11 + var_162_6
					end
				end

				arg_159_1.text_.text = var_162_9
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102037", "story_v_out_325102.awb") ~= 0 then
					local var_162_12 = manager.audio:GetVoiceLength("story_v_out_325102", "325102037", "story_v_out_325102.awb") / 1000

					if var_162_12 + var_162_6 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_6
					end

					if var_162_8.prefab_name ~= "" and arg_159_1.actors_[var_162_8.prefab_name] ~= nil then
						local var_162_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_8.prefab_name].transform, "story_v_out_325102", "325102037", "story_v_out_325102.awb")

						arg_159_1:RecordAudio("325102037", var_162_13)
						arg_159_1:RecordAudio("325102037", var_162_13)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_325102", "325102037", "story_v_out_325102.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_325102", "325102037", "story_v_out_325102.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_14 = math.max(var_162_7, arg_159_1.talkMaxDuration)

			if var_162_6 <= arg_159_1.time_ and arg_159_1.time_ < var_162_6 + var_162_14 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_6) / var_162_14

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_6 + var_162_14 and arg_159_1.time_ < var_162_6 + var_162_14 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 325102038
		arg_163_1.duration_ = 4.5

		local var_163_0 = {
			zh = 3.366,
			ja = 4.5
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
				arg_163_0:Play325102039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.475

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:GetWordFromCfg(325102038)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 19 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 19)

				if (19 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 19)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102038", "story_v_out_325102.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102038", "story_v_out_325102.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_325102", "325102038", "story_v_out_325102.awb")

						arg_163_1:RecordAudio("325102038", var_166_6)
						arg_163_1:RecordAudio("325102038", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_325102", "325102038", "story_v_out_325102.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_325102", "325102038", "story_v_out_325102.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play325102039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 325102039
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play325102040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1077ui_story = arg_167_1.actors_["1077ui_story"].transform.localPosition

				local var_170_0 = GameObjectTools.GetOrAddComponent(arg_167_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_170_0 then
					var_170_0:EnableDynamicBone(false)
				end
			end

			local var_170_1 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				arg_167_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_1)
				arg_167_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1077ui_story"].transform.position).z)
				arg_167_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1077ui_story"].transform.localEulerAngles = arg_167_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 then
				arg_167_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1077ui_story"].transform.position).z)
				arg_167_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1077ui_story"].transform.localEulerAngles = arg_167_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_170_2 = GameObjectTools.GetOrAddComponent(arg_167_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_170_2 then
					var_170_2:EnableDynamicBone(true)
				end
			end

			local var_170_3 = arg_167_1.actors_["1077ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_3) and arg_167_1.var_.characterEffect1077ui_story == nil then
				arg_167_1.var_.characterEffect1077ui_story = var_170_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_4 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 and not isNil(var_170_3) then
				if arg_167_1.var_.characterEffect1077ui_story and not isNil(var_170_3) then
					arg_167_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_4)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 and not isNil(var_170_3) and arg_167_1.var_.characterEffect1077ui_story then
				arg_167_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_170_5 = 0
			local var_170_6 = 1.05

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(325102039).content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 42 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_7) / 42)

				if (42 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_7) / 42)) > 0 and var_170_6 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_5
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_6, arg_167_1.talkMaxDuration)

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_5) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_5 + var_170_10 and arg_167_1.time_ < var_170_5 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 325102040
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play325102041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if arg_171_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_174_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_171_1.stage_.transform)

				var_174_0.name = "1061ui_story"
				var_174_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.actors_["1061ui_story"] = var_174_0

				local var_174_1 = var_174_0:GetComponentInChildren(typeof(CharacterEffect))

				var_174_1.enabled = true

				local var_174_2 = GameObjectTools.GetOrAddComponent(var_174_0, typeof(DynamicBoneHelper))

				if var_174_2 then
					var_174_2:EnableDynamicBone(false)
				end

				arg_171_1:ShowWeapon(var_174_1.transform, false)

				arg_171_1.var_["1061ui_story" .. "Animator"] = var_174_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_171_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_171_1.var_["1061ui_story" .. "LipSync"] = var_174_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_174_3 = arg_171_1.actors_["1061ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1061ui_story = var_174_3.localPosition
			end

			local var_174_4 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				var_174_3.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_171_1.time_ - 0) / var_174_4)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				var_174_3.localPosition = Vector3.New(0, -1.18, -6.15)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			local var_174_5 = arg_171_1.actors_["1061ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.characterEffect1061ui_story == nil then
				arg_171_1.var_.characterEffect1061ui_story = var_174_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_6 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_6 and not isNil(var_174_5) then
				if arg_171_1.var_.characterEffect1061ui_story and not isNil(var_174_5) then
					arg_171_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_6 and arg_171_1.time_ < 0 + var_174_6 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.characterEffect1061ui_story then
				arg_171_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				if arg_171_1.var_.characterEffect1061ui_story == nil then
					arg_171_1.var_.characterEffect1061ui_story = arg_171_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_171_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				if arg_171_1.var_.characterEffect1061ui_story == nil then
					arg_171_1.var_.characterEffect1061ui_story = arg_171_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_174_9 = arg_171_1.var_.characterEffect1061ui_story

				arg_171_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_174_9.interferenceEffect.enabled = true
				var_174_9.interferenceEffect.noise = 0.001
				var_174_9.interferenceEffect.simTimeScale = 1
				var_174_9.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_174_10 = 0
			local var_174_11 = 0.2

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_12 = arg_171_1:GetWordFromCfg(325102040)
				local var_174_13 = arg_171_1:FormatText(var_174_12.content)

				arg_171_1.text_.text = var_174_13

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_15 = 8 <= 0 and var_174_11 or var_174_11 * (utf8.len(var_174_13) / 8)

				if (8 <= 0 and var_174_11 or var_174_11 * (utf8.len(var_174_13) / 8)) > 0 and var_174_11 < var_174_15 then
					arg_171_1.talkMaxDuration = var_174_15

					if var_174_15 + var_174_10 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_15 + var_174_10
					end
				end

				arg_171_1.text_.text = var_174_13
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102040", "story_v_out_325102.awb") ~= 0 then
					local var_174_16 = manager.audio:GetVoiceLength("story_v_out_325102", "325102040", "story_v_out_325102.awb") / 1000

					if var_174_16 + var_174_10 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_16 + var_174_10
					end

					if var_174_12.prefab_name ~= "" and arg_171_1.actors_[var_174_12.prefab_name] ~= nil then
						local var_174_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_12.prefab_name].transform, "story_v_out_325102", "325102040", "story_v_out_325102.awb")

						arg_171_1:RecordAudio("325102040", var_174_17)
						arg_171_1:RecordAudio("325102040", var_174_17)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_325102", "325102040", "story_v_out_325102.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_325102", "325102040", "story_v_out_325102.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_18 = math.max(var_174_11, arg_171_1.talkMaxDuration)

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_18 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_10) / var_174_18

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_10 + var_174_18 and arg_171_1.time_ < var_174_10 + var_174_18 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play325102041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 325102041
		arg_175_1.duration_ = 2.5

		local var_175_0 = {
			zh = 2.433,
			ja = 2.5
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
				arg_175_0:Play325102042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1061ui_story = arg_175_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1061ui_story, Vector3.New(-0.7, -1.18, -6.15), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1061ui_story"].transform.position).z)
				arg_175_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1061ui_story"].transform.localEulerAngles = arg_175_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(-0.7, -1.18, -6.15)
				arg_175_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1061ui_story"].transform.position).z)
				arg_175_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1061ui_story"].transform.localEulerAngles = arg_175_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1077ui_story"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1077ui_story = var_178_1.localPosition

				local var_178_2 = GameObjectTools.GetOrAddComponent(var_178_1.gameObject, typeof(DynamicBoneHelper))

				if var_178_2 then
					var_178_2:EnableDynamicBone(false)
				end
			end

			local var_178_3 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 then
				var_178_1.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1077ui_story, Vector3.New(0.8, -1.02, -5.92), (arg_175_1.time_ - 0) / var_178_3)
				var_178_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_1.position).x, (manager.ui.mainCamera.transform.position - var_178_1.position).y, (manager.ui.mainCamera.transform.position - var_178_1.position).z)
				var_178_1.localEulerAngles.z = 0
				var_178_1.localEulerAngles.x = 0
				var_178_1.localEulerAngles = var_178_1.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 then
				var_178_1.localPosition = Vector3.New(0.8, -1.02, -5.92)
				var_178_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_1.position).x, (manager.ui.mainCamera.transform.position - var_178_1.position).y, (manager.ui.mainCamera.transform.position - var_178_1.position).z)
				var_178_1.localEulerAngles.z = 0
				var_178_1.localEulerAngles.x = 0
				var_178_1.localEulerAngles = var_178_1.localEulerAngles

				local var_178_4 = GameObjectTools.GetOrAddComponent(var_178_1.gameObject, typeof(DynamicBoneHelper))

				if var_178_4 then
					var_178_4:EnableDynamicBone(true)
				end
			end

			local var_178_5 = arg_175_1.actors_["1077ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.characterEffect1077ui_story == nil then
				arg_175_1.var_.characterEffect1077ui_story = var_178_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_6 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_6 and not isNil(var_178_5) then
				if arg_175_1.var_.characterEffect1077ui_story and not isNil(var_178_5) then
					arg_175_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_6 and arg_175_1.time_ < 0 + var_178_6 + arg_178_0 and not isNil(var_178_5) and arg_175_1.var_.characterEffect1077ui_story then
				arg_175_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_178_8 = arg_175_1.actors_["1061ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_8) and arg_175_1.var_.characterEffect1061ui_story == nil then
				arg_175_1.var_.characterEffect1061ui_story = var_178_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_9 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_9 and not isNil(var_178_8) then
				if arg_175_1.var_.characterEffect1061ui_story and not isNil(var_178_8) then
					arg_175_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_9)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_9 and arg_175_1.time_ < 0 + var_178_9 + arg_178_0 and not isNil(var_178_8) and arg_175_1.var_.characterEffect1061ui_story then
				arg_175_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_178_10 = 0
			local var_178_11 = 0.275

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_12 = arg_175_1:GetWordFromCfg(325102041)
				local var_178_13 = arg_175_1:FormatText(var_178_12.content)

				arg_175_1.text_.text = var_178_13

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_15 = 11 <= 0 and var_178_11 or var_178_11 * (utf8.len(var_178_13) / 11)

				if (11 <= 0 and var_178_11 or var_178_11 * (utf8.len(var_178_13) / 11)) > 0 and var_178_11 < var_178_15 then
					arg_175_1.talkMaxDuration = var_178_15

					if var_178_15 + var_178_10 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_15 + var_178_10
					end
				end

				arg_175_1.text_.text = var_178_13
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102041", "story_v_out_325102.awb") ~= 0 then
					local var_178_16 = manager.audio:GetVoiceLength("story_v_out_325102", "325102041", "story_v_out_325102.awb") / 1000

					if var_178_16 + var_178_10 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_16 + var_178_10
					end

					if var_178_12.prefab_name ~= "" and arg_175_1.actors_[var_178_12.prefab_name] ~= nil then
						local var_178_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_12.prefab_name].transform, "story_v_out_325102", "325102041", "story_v_out_325102.awb")

						arg_175_1:RecordAudio("325102041", var_178_17)
						arg_175_1:RecordAudio("325102041", var_178_17)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_325102", "325102041", "story_v_out_325102.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_325102", "325102041", "story_v_out_325102.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_18 = math.max(var_178_11, arg_175_1.talkMaxDuration)

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_18 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_10) / var_178_18

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_10 + var_178_18 and arg_175_1.time_ < var_178_10 + var_178_18 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 325102042
		arg_179_1.duration_ = 3.83

		local var_179_0 = {
			zh = 3.833,
			ja = 3.766
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
				arg_179_0:Play325102043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1061ui_story"]) and arg_179_1.var_.characterEffect1061ui_story == nil then
				arg_179_1.var_.characterEffect1061ui_story = arg_179_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1061ui_story"]) then
				if arg_179_1.var_.characterEffect1061ui_story and not isNil(arg_179_1.actors_["1061ui_story"]) then
					arg_179_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1061ui_story"]) and arg_179_1.var_.characterEffect1061ui_story then
				arg_179_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_182_2 = arg_179_1.actors_["1077ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.characterEffect1077ui_story == nil then
				arg_179_1.var_.characterEffect1077ui_story = var_182_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_3 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.characterEffect1077ui_story and not isNil(var_182_2) then
					arg_179_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_3)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.characterEffect1077ui_story then
				arg_179_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			local var_182_4 = 0
			local var_182_5 = 0.4

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(325102042)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 16 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 16)

				if (16 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 16)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102042", "story_v_out_325102.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_out_325102", "325102042", "story_v_out_325102.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_out_325102", "325102042", "story_v_out_325102.awb")

						arg_179_1:RecordAudio("325102042", var_182_11)
						arg_179_1:RecordAudio("325102042", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_325102", "325102042", "story_v_out_325102.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_325102", "325102042", "story_v_out_325102.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play325102043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 325102043
		arg_183_1.duration_ = 6

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play325102044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1077ui_story"]) and arg_183_1.var_.characterEffect1077ui_story == nil then
				arg_183_1.var_.characterEffect1077ui_story = arg_183_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1077ui_story"]) then
				if arg_183_1.var_.characterEffect1077ui_story and not isNil(arg_183_1.actors_["1077ui_story"]) then
					arg_183_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1077ui_story"]) and arg_183_1.var_.characterEffect1077ui_story then
				arg_183_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_186_2 = arg_183_1.actors_["1061ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect1061ui_story == nil then
				arg_183_1.var_.characterEffect1061ui_story = var_186_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_3 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 and not isNil(var_186_2) then
				if arg_183_1.var_.characterEffect1061ui_story and not isNil(var_186_2) then
					arg_183_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_3)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect1061ui_story then
				arg_183_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_186_4 = 0
			local var_186_5 = 0.9

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(325102043)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 33 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 33)

				if (33 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 33)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102043", "story_v_out_325102.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_325102", "325102043", "story_v_out_325102.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_325102", "325102043", "story_v_out_325102.awb")

						arg_183_1:RecordAudio("325102043", var_186_11)
						arg_183_1:RecordAudio("325102043", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_325102", "325102043", "story_v_out_325102.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_325102", "325102043", "story_v_out_325102.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_12 and arg_183_1.time_ < var_186_4 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play325102044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 325102044
		arg_187_1.duration_ = 10.1

		local var_187_0 = {
			zh = 6.9,
			ja = 10.1
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
				arg_187_0:Play325102045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action8_2")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_190_0 = 0
			local var_190_1 = 1

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_2 = arg_187_1:GetWordFromCfg(325102044)
				local var_190_3 = arg_187_1:FormatText(var_190_2.content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 40 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_3) / 40)

				if (40 <= 0 and var_190_1 or var_190_1 * (utf8.len(var_190_3) / 40)) > 0 and var_190_1 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102044", "story_v_out_325102.awb") ~= 0 then
					local var_190_6 = manager.audio:GetVoiceLength("story_v_out_325102", "325102044", "story_v_out_325102.awb") / 1000

					if var_190_6 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_0
					end

					if var_190_2.prefab_name ~= "" and arg_187_1.actors_[var_190_2.prefab_name] ~= nil then
						local var_190_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_2.prefab_name].transform, "story_v_out_325102", "325102044", "story_v_out_325102.awb")

						arg_187_1:RecordAudio("325102044", var_190_7)
						arg_187_1:RecordAudio("325102044", var_190_7)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_325102", "325102044", "story_v_out_325102.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_325102", "325102044", "story_v_out_325102.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_8 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_8 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_8

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_8 and arg_187_1.time_ < var_190_0 + var_190_8 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play325102045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 325102045
		arg_191_1.duration_ = 4.13

		local var_191_0 = {
			zh = 4.133,
			ja = 3.866
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
				arg_191_0:Play325102046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.6

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(325102045)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 24 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 24)

				if (24 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 24)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102045", "story_v_out_325102.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102045", "story_v_out_325102.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_325102", "325102045", "story_v_out_325102.awb")

						arg_191_1:RecordAudio("325102045", var_194_6)
						arg_191_1:RecordAudio("325102045", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_325102", "325102045", "story_v_out_325102.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_325102", "325102045", "story_v_out_325102.awb")
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
	Play325102046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 325102046
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play325102047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1077ui_story = arg_195_1.actors_["1077ui_story"].transform.localPosition

				local var_198_0 = GameObjectTools.GetOrAddComponent(arg_195_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_198_0 then
					var_198_0:EnableDynamicBone(false)
				end
			end

			local var_198_1 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_1 then
				arg_195_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_1)
				arg_195_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1077ui_story"].transform.position).z)
				arg_195_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1077ui_story"].transform.localEulerAngles = arg_195_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_1 and arg_195_1.time_ < 0 + var_198_1 + arg_198_0 then
				arg_195_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1077ui_story"].transform.position).z)
				arg_195_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1077ui_story"].transform.localEulerAngles = arg_195_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_198_2 = GameObjectTools.GetOrAddComponent(arg_195_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_198_2 then
					var_198_2:EnableDynamicBone(true)
				end
			end

			local var_198_3 = arg_195_1.actors_["1061ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1061ui_story = var_198_3.localPosition
			end

			local var_198_4 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				var_198_3.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_4)
				var_198_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_3.position).x, (manager.ui.mainCamera.transform.position - var_198_3.position).y, (manager.ui.mainCamera.transform.position - var_198_3.position).z)
				var_198_3.localEulerAngles.z = 0
				var_198_3.localEulerAngles.x = 0
				var_198_3.localEulerAngles = var_198_3.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				var_198_3.localPosition = Vector3.New(0, 100, 0)
				var_198_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_3.position).x, (manager.ui.mainCamera.transform.position - var_198_3.position).y, (manager.ui.mainCamera.transform.position - var_198_3.position).z)
				var_198_3.localEulerAngles.z = 0
				var_198_3.localEulerAngles.x = 0
				var_198_3.localEulerAngles = var_198_3.localEulerAngles
			end

			local var_198_5 = arg_195_1.actors_["1077ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.characterEffect1077ui_story == nil then
				arg_195_1.var_.characterEffect1077ui_story = var_198_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_6 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_6 and not isNil(var_198_5) then
				if arg_195_1.var_.characterEffect1077ui_story and not isNil(var_198_5) then
					arg_195_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_6)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_6 and arg_195_1.time_ < 0 + var_198_6 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.characterEffect1077ui_story then
				arg_195_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0.7 < arg_195_1.time_ and arg_195_1.time_ <= 0.7 + arg_198_0 then
				arg_195_1:AudioAction("play", "effect", "se_story_7", "se_story_7_leaves", "")
			end

			local var_198_8 = 0
			local var_198_9 = 1.675

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_10 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(325102046).content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_12 = 67 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_10) / 67)

				if (67 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_10) / 67)) > 0 and var_198_9 < var_198_12 then
					arg_195_1.talkMaxDuration = var_198_12

					if var_198_12 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_8
					end
				end

				arg_195_1.text_.text = var_198_10
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_13 = math.max(var_198_9, arg_195_1.talkMaxDuration)

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_13 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_8) / var_198_13

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_8 + var_198_13 and arg_195_1.time_ < var_198_8 + var_198_13 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play325102047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 325102047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play325102048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.625

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

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(325102047).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 25 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 25)

				if (25 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 25)) > 0 and var_202_0 < var_202_3 then
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
	Play325102048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 325102048
		arg_203_1.duration_ = 2.47

		local var_203_0 = {
			zh = 1.999999999999,
			ja = 2.466
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
				arg_203_0:Play325102049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1061ui_story = arg_203_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1061ui_story"].transform.position).z)
				arg_203_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1061ui_story"].transform.localEulerAngles = arg_203_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1061ui_story"].transform.position).z)
				arg_203_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1061ui_story"].transform.localEulerAngles = arg_203_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1061ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1061ui_story == nil then
				arg_203_1.var_.characterEffect1061ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1061ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1061ui_story then
				arg_203_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_206_4 = 0
			local var_206_5 = 0.075

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_1")

				arg_203_1.callingController_:SetSelectedState("calling")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_6 = arg_203_1:GetWordFromCfg(325102048)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 3 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 3)

				if (3 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 3)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102048", "story_v_out_325102.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_325102", "325102048", "story_v_out_325102.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_325102", "325102048", "story_v_out_325102.awb")

						arg_203_1:RecordAudio("325102048", var_206_11)
						arg_203_1:RecordAudio("325102048", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_325102", "325102048", "story_v_out_325102.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_325102", "325102048", "story_v_out_325102.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play325102049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 325102049
		arg_207_1.duration_ = 3.3

		local var_207_0 = {
			zh = 3,
			ja = 3.3
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
				arg_207_0:Play325102050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1061ui_story = arg_207_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1061ui_story"].transform.position).z)
				arg_207_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1061ui_story"].transform.localEulerAngles = arg_207_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1061ui_story"].transform.position).z)
				arg_207_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1061ui_story"].transform.localEulerAngles = arg_207_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1077ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1077ui_story = var_210_1.localPosition

				local var_210_2 = GameObjectTools.GetOrAddComponent(var_210_1.gameObject, typeof(DynamicBoneHelper))

				if var_210_2 then
					var_210_2:EnableDynamicBone(false)
				end
			end

			local var_210_3 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 then
				var_210_1.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_3)
				var_210_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_1.position).x, (manager.ui.mainCamera.transform.position - var_210_1.position).y, (manager.ui.mainCamera.transform.position - var_210_1.position).z)
				var_210_1.localEulerAngles.z = 0
				var_210_1.localEulerAngles.x = 0
				var_210_1.localEulerAngles = var_210_1.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 then
				var_210_1.localPosition = Vector3.New(0, 100, 0)
				var_210_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_1.position).x, (manager.ui.mainCamera.transform.position - var_210_1.position).y, (manager.ui.mainCamera.transform.position - var_210_1.position).z)
				var_210_1.localEulerAngles.z = 0
				var_210_1.localEulerAngles.x = 0
				var_210_1.localEulerAngles = var_210_1.localEulerAngles

				local var_210_4 = GameObjectTools.GetOrAddComponent(var_210_1.gameObject, typeof(DynamicBoneHelper))

				if var_210_4 then
					var_210_4:EnableDynamicBone(true)
				end
			end

			local var_210_5 = arg_207_1.actors_["1077ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect1077ui_story == nil then
				arg_207_1.var_.characterEffect1077ui_story = var_210_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_6 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_6 and not isNil(var_210_5) then
				if arg_207_1.var_.characterEffect1077ui_story and not isNil(var_210_5) then
					arg_207_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_6 and arg_207_1.time_ < 0 + var_210_6 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect1077ui_story then
				arg_207_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_210_8 = arg_207_1.actors_["1061ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_8) and arg_207_1.var_.characterEffect1061ui_story == nil then
				arg_207_1.var_.characterEffect1061ui_story = var_210_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_9 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_9 and not isNil(var_210_8) then
				if arg_207_1.var_.characterEffect1061ui_story and not isNil(var_210_8) then
					arg_207_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_9)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_9 and arg_207_1.time_ < 0 + var_210_9 + arg_210_0 and not isNil(var_210_8) and arg_207_1.var_.characterEffect1061ui_story then
				arg_207_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_210_10 = 0
			local var_210_11 = 0.3

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_12 = arg_207_1:GetWordFromCfg(325102049)
				local var_210_13 = arg_207_1:FormatText(var_210_12.content)

				arg_207_1.text_.text = var_210_13

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_15 = 12 <= 0 and var_210_11 or var_210_11 * (utf8.len(var_210_13) / 12)

				if (12 <= 0 and var_210_11 or var_210_11 * (utf8.len(var_210_13) / 12)) > 0 and var_210_11 < var_210_15 then
					arg_207_1.talkMaxDuration = var_210_15

					if var_210_15 + var_210_10 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_15 + var_210_10
					end
				end

				arg_207_1.text_.text = var_210_13
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102049", "story_v_out_325102.awb") ~= 0 then
					local var_210_16 = manager.audio:GetVoiceLength("story_v_out_325102", "325102049", "story_v_out_325102.awb") / 1000

					if var_210_16 + var_210_10 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_16 + var_210_10
					end

					if var_210_12.prefab_name ~= "" and arg_207_1.actors_[var_210_12.prefab_name] ~= nil then
						local var_210_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_12.prefab_name].transform, "story_v_out_325102", "325102049", "story_v_out_325102.awb")

						arg_207_1:RecordAudio("325102049", var_210_17)
						arg_207_1:RecordAudio("325102049", var_210_17)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_325102", "325102049", "story_v_out_325102.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_325102", "325102049", "story_v_out_325102.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_18 = math.max(var_210_11, arg_207_1.talkMaxDuration)

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_18 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_10) / var_210_18

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_10 + var_210_18 and arg_207_1.time_ < var_210_10 + var_210_18 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 325102050
		arg_211_1.duration_ = 10.8

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play325102051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_9001
			local var_214_9000

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1077ui_story = arg_211_1.actors_["1077ui_story"].transform.localPosition

				local var_214_0 = GameObjectTools.GetOrAddComponent(arg_211_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_214_0 then
					var_214_0:EnableDynamicBone(false)
				end
			end

			local var_214_1 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_1 then
				arg_211_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_1)
				arg_211_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1077ui_story"].transform.position).z)
				arg_211_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1077ui_story"].transform.localEulerAngles = arg_211_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_1 and arg_211_1.time_ < 0 + var_214_1 + arg_214_0 then
				arg_211_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1077ui_story"].transform.position).z)
				arg_211_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1077ui_story"].transform.localEulerAngles = arg_211_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_214_2 = GameObjectTools.GetOrAddComponent(arg_211_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_214_2 then
					var_214_2:EnableDynamicBone(true)
				end
			end

			local var_214_3 = arg_211_1.actors_["1061ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1061ui_story = var_214_3.localPosition
			end

			local var_214_4 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				var_214_3.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_4)
				var_214_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_3.position).x, (manager.ui.mainCamera.transform.position - var_214_3.position).y, (manager.ui.mainCamera.transform.position - var_214_3.position).z)
				var_214_3.localEulerAngles.z = 0
				var_214_3.localEulerAngles.x = 0
				var_214_3.localEulerAngles = var_214_3.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				var_214_3.localPosition = Vector3.New(0, 100, 0)
				var_214_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_3.position).x, (manager.ui.mainCamera.transform.position - var_214_3.position).y, (manager.ui.mainCamera.transform.position - var_214_3.position).z)
				var_214_3.localEulerAngles.z = 0
				var_214_3.localEulerAngles.x = 0
				var_214_3.localEulerAngles = var_214_3.localEulerAngles
			end

			local var_214_5 = arg_211_1.actors_["1077ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.characterEffect1077ui_story == nil then
				arg_211_1.var_.characterEffect1077ui_story = var_214_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_6 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_6 and not isNil(var_214_5) then
				if arg_211_1.var_.characterEffect1077ui_story and not isNil(var_214_5) then
					arg_211_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_6)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_6 and arg_211_1.time_ < 0 + var_214_6 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.characterEffect1077ui_story then
				arg_211_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				local var_214_7 = arg_211_1.var_.effect32323

				if not arg_211_1.var_.effect32323 then
					var_214_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heiwu"), manager.ui.mainCamera.transform)
					var_214_7.name = "32323"
					arg_211_1.var_.effect32323 = var_214_7
				else
					var_214_7.transform:SetParent(var_214_9001)
				end

				var_214_7.transform.localPosition = Vector3.New(0.66, -0.12, 0.38)
				var_214_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 5.03333333333333 < arg_211_1.time_ and arg_211_1.time_ <= 5.03333333333333 + arg_214_0 then
				if arg_211_1.var_.effect32323 then
					Object.Destroy(arg_211_1.var_.effect32323)

					arg_211_1.var_.effect32323 = nil
				end
			end

			if 0.733333333333333 < arg_211_1.time_ and arg_211_1.time_ <= 0.733333333333333 + arg_214_0 then
				local var_214_10 = arg_211_1.var_.effect323231

				if not arg_211_1.var_.effect323231 then
					var_214_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heiwu"), manager.ui.mainCamera.transform)
					var_214_10.name = "323231"
					arg_211_1.var_.effect323231 = var_214_10
				else
					var_214_10.transform:SetParent(var_214_9000)
				end

				var_214_10.transform.localPosition = Vector3.New(-0.66, -0.18, -0.04)
				var_214_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 5.76666666666667 < arg_211_1.time_ and arg_211_1.time_ <= 5.76666666666667 + arg_214_0 then
				if arg_211_1.var_.effect323231 then
					Object.Destroy(arg_211_1.var_.effect323231)

					arg_211_1.var_.effect323231 = nil
				end
			end

			local var_214_13 = 0

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_13 + arg_214_0 then
				arg_211_1.allBtn_.enabled = false
			end

			if arg_211_1.time_ >= var_214_13 + 4.13333333333333 and arg_211_1.time_ < var_214_13 + 4.13333333333333 + arg_214_0 then
				arg_211_1.allBtn_.enabled = true
			end

			if arg_211_1.frameCnt_ <= 1 then
				arg_211_1.dialog_:SetActive(false)
			end

			local var_214_14 = 1.56666666666667
			local var_214_15 = 1.325

			if 1.56666666666667 < arg_211_1.time_ and arg_211_1.time_ <= var_214_14 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0

				arg_211_1.dialog_:SetActive(true)

				arg_211_1.dialogCg_.alpha = 0

				local var_214_16 = LeanTween.value(arg_211_1.dialog_, 0, 1, 0.3)

				var_214_16:setOnUpdate(LuaHelper.FloatAction(function(arg_215_0)
					arg_211_1.dialogCg_.alpha = arg_215_0
				end))
				var_214_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_211_1.dialog_)
					var_214_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_211_1.duration_ = arg_211_1.duration_ + 0.3

				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_17 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(325102050).content)

				arg_211_1.text_.text = var_214_17

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_19 = 53 <= 0 and var_214_15 or var_214_15 * (utf8.len(var_214_17) / 53)

				if (53 <= 0 and var_214_15 or var_214_15 * (utf8.len(var_214_17) / 53)) > 0 and var_214_15 < var_214_19 then
					arg_211_1.talkMaxDuration = var_214_19
					var_214_14 = var_214_14 + 0.3

					if var_214_19 + var_214_14 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_19 + var_214_14
					end
				end

				arg_211_1.text_.text = var_214_17
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_20 = var_214_14 + 0.3
			local var_214_21 = math.max(var_214_15, arg_211_1.talkMaxDuration)

			if var_214_14 + 0.3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_20 + var_214_21 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_20) / var_214_21

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_20 + var_214_21 and arg_211_1.time_ < var_214_20 + var_214_21 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play325102051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 325102051
		arg_217_1.duration_ = 4.63

		local var_217_0 = {
			zh = 2.833,
			ja = 4.633
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
				arg_217_0:Play325102052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1077ui_story = arg_217_1.actors_["1077ui_story"].transform.localPosition

				local var_220_0 = GameObjectTools.GetOrAddComponent(arg_217_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_220_0 then
					var_220_0:EnableDynamicBone(false)
				end
			end

			local var_220_1 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 then
				arg_217_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_217_1.time_ - 0) / var_220_1)
				arg_217_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1077ui_story"].transform.position).z)
				arg_217_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1077ui_story"].transform.localEulerAngles = arg_217_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 then
				arg_217_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_217_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1077ui_story"].transform.position).z)
				arg_217_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1077ui_story"].transform.localEulerAngles = arg_217_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_220_2 = GameObjectTools.GetOrAddComponent(arg_217_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_220_2 then
					var_220_2:EnableDynamicBone(true)
				end
			end

			local var_220_3 = arg_217_1.actors_["1077ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_3) and arg_217_1.var_.characterEffect1077ui_story == nil then
				arg_217_1.var_.characterEffect1077ui_story = var_220_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_4 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 and not isNil(var_220_3) then
				if arg_217_1.var_.characterEffect1077ui_story and not isNil(var_220_3) then
					arg_217_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 and not isNil(var_220_3) and arg_217_1.var_.characterEffect1077ui_story then
				arg_217_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_220_6 = 0
			local var_220_7 = 0.375

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_8 = arg_217_1:GetWordFromCfg(325102051)
				local var_220_9 = arg_217_1:FormatText(var_220_8.content)

				arg_217_1.text_.text = var_220_9

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 15 <= 0 and var_220_7 or var_220_7 * (utf8.len(var_220_9) / 15)

				if (15 <= 0 and var_220_7 or var_220_7 * (utf8.len(var_220_9) / 15)) > 0 and var_220_7 < var_220_11 then
					arg_217_1.talkMaxDuration = var_220_11

					if var_220_11 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_9
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102051", "story_v_out_325102.awb") ~= 0 then
					local var_220_12 = manager.audio:GetVoiceLength("story_v_out_325102", "325102051", "story_v_out_325102.awb") / 1000

					if var_220_12 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_12 + var_220_6
					end

					if var_220_8.prefab_name ~= "" and arg_217_1.actors_[var_220_8.prefab_name] ~= nil then
						local var_220_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_8.prefab_name].transform, "story_v_out_325102", "325102051", "story_v_out_325102.awb")

						arg_217_1:RecordAudio("325102051", var_220_13)
						arg_217_1:RecordAudio("325102051", var_220_13)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_325102", "325102051", "story_v_out_325102.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_325102", "325102051", "story_v_out_325102.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 325102052
		arg_221_1.duration_ = 13.5

		local var_221_0 = {
			zh = 8,
			ja = 13.5
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
				arg_221_0:Play325102053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1077ui_story = arg_221_1.actors_["1077ui_story"].transform.localPosition

				local var_224_0 = GameObjectTools.GetOrAddComponent(arg_221_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_224_0 then
					var_224_0:EnableDynamicBone(false)
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1077ui_story, Vector3.New(-0.83, -1.02, -5.92), (arg_221_1.time_ - 0) / var_224_1)
				arg_221_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1077ui_story"].transform.position).z)
				arg_221_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1077ui_story"].transform.localEulerAngles = arg_221_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.83, -1.02, -5.92)
				arg_221_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1077ui_story"].transform.position).z)
				arg_221_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1077ui_story"].transform.localEulerAngles = arg_221_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_224_2 = GameObjectTools.GetOrAddComponent(arg_221_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_224_2 then
					var_224_2:EnableDynamicBone(true)
				end
			end

			local var_224_3 = arg_221_1.actors_["1061ui_story"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1061ui_story = var_224_3.localPosition
			end

			local var_224_4 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				var_224_3.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1061ui_story, Vector3.New(0.7, -1.18, -6.15), (arg_221_1.time_ - 0) / var_224_4)
				var_224_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_3.position).x, (manager.ui.mainCamera.transform.position - var_224_3.position).y, (manager.ui.mainCamera.transform.position - var_224_3.position).z)
				var_224_3.localEulerAngles.z = 0
				var_224_3.localEulerAngles.x = 0
				var_224_3.localEulerAngles = var_224_3.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				var_224_3.localPosition = Vector3.New(0.7, -1.18, -6.15)
				var_224_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_3.position).x, (manager.ui.mainCamera.transform.position - var_224_3.position).y, (manager.ui.mainCamera.transform.position - var_224_3.position).z)
				var_224_3.localEulerAngles.z = 0
				var_224_3.localEulerAngles.x = 0
				var_224_3.localEulerAngles = var_224_3.localEulerAngles
			end

			local var_224_5 = arg_221_1.actors_["1061ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.characterEffect1061ui_story == nil then
				arg_221_1.var_.characterEffect1061ui_story = var_224_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_6 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_6 and not isNil(var_224_5) then
				if arg_221_1.var_.characterEffect1061ui_story and not isNil(var_224_5) then
					arg_221_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_6 and arg_221_1.time_ < 0 + var_224_6 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.characterEffect1061ui_story then
				arg_221_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_224_8 = arg_221_1.actors_["1077ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_8) and arg_221_1.var_.characterEffect1077ui_story == nil then
				arg_221_1.var_.characterEffect1077ui_story = var_224_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_9 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_9 and not isNil(var_224_8) then
				if arg_221_1.var_.characterEffect1077ui_story and not isNil(var_224_8) then
					arg_221_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_9)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_9 and arg_221_1.time_ < 0 + var_224_9 + arg_224_0 and not isNil(var_224_8) and arg_221_1.var_.characterEffect1077ui_story then
				arg_221_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			local var_224_10 = 0
			local var_224_11 = 0.975

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_12 = arg_221_1:GetWordFromCfg(325102052)
				local var_224_13 = arg_221_1:FormatText(var_224_12.content)

				arg_221_1.text_.text = var_224_13

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_15 = 39 <= 0 and var_224_11 or var_224_11 * (utf8.len(var_224_13) / 39)

				if (39 <= 0 and var_224_11 or var_224_11 * (utf8.len(var_224_13) / 39)) > 0 and var_224_11 < var_224_15 then
					arg_221_1.talkMaxDuration = var_224_15

					if var_224_15 + var_224_10 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_15 + var_224_10
					end
				end

				arg_221_1.text_.text = var_224_13
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102052", "story_v_out_325102.awb") ~= 0 then
					local var_224_16 = manager.audio:GetVoiceLength("story_v_out_325102", "325102052", "story_v_out_325102.awb") / 1000

					if var_224_16 + var_224_10 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_16 + var_224_10
					end

					if var_224_12.prefab_name ~= "" and arg_221_1.actors_[var_224_12.prefab_name] ~= nil then
						local var_224_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_12.prefab_name].transform, "story_v_out_325102", "325102052", "story_v_out_325102.awb")

						arg_221_1:RecordAudio("325102052", var_224_17)
						arg_221_1:RecordAudio("325102052", var_224_17)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_325102", "325102052", "story_v_out_325102.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_325102", "325102052", "story_v_out_325102.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_18 = math.max(var_224_11, arg_221_1.talkMaxDuration)

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_18 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_10) / var_224_18

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_10 + var_224_18 and arg_221_1.time_ < var_224_10 + var_224_18 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play325102053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 325102053
		arg_225_1.duration_ = 4.03

		local var_225_0 = {
			zh = 2.3,
			ja = 4.033
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
				arg_225_0:Play325102054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.35

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:GetWordFromCfg(325102053)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 14 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 14)

				if (14 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 14)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102053", "story_v_out_325102.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102053", "story_v_out_325102.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_325102", "325102053", "story_v_out_325102.awb")

						arg_225_1:RecordAudio("325102053", var_228_6)
						arg_225_1:RecordAudio("325102053", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_325102", "325102053", "story_v_out_325102.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_325102", "325102053", "story_v_out_325102.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play325102054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 325102054
		arg_229_1.duration_ = 11.5

		local var_229_0 = {
			zh = 3.7,
			ja = 11.5
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
				arg_229_0:Play325102055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1077ui_story"]) and arg_229_1.var_.characterEffect1077ui_story == nil then
				arg_229_1.var_.characterEffect1077ui_story = arg_229_1.actors_["1077ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1077ui_story"]) then
				if arg_229_1.var_.characterEffect1077ui_story and not isNil(arg_229_1.actors_["1077ui_story"]) then
					arg_229_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1077ui_story"]) and arg_229_1.var_.characterEffect1077ui_story then
				arg_229_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_232_2 = arg_229_1.actors_["1061ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect1061ui_story == nil then
				arg_229_1.var_.characterEffect1061ui_story = var_232_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_3 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.characterEffect1061ui_story and not isNil(var_232_2) then
					arg_229_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_3)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect1061ui_story then
				arg_229_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_232_4 = 0
			local var_232_5 = 0.425

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(325102054)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 17 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 17)

				if (17 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 17)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102054", "story_v_out_325102.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_out_325102", "325102054", "story_v_out_325102.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_out_325102", "325102054", "story_v_out_325102.awb")

						arg_229_1:RecordAudio("325102054", var_232_11)
						arg_229_1:RecordAudio("325102054", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_325102", "325102054", "story_v_out_325102.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_325102", "325102054", "story_v_out_325102.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play325102055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 325102055
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play325102056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1077ui_story = arg_233_1.actors_["1077ui_story"].transform.localPosition

				local var_236_0 = GameObjectTools.GetOrAddComponent(arg_233_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_236_0 then
					var_236_0:EnableDynamicBone(false)
				end
			end

			local var_236_1 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_1 then
				arg_233_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_1)
				arg_233_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1077ui_story"].transform.position).z)
				arg_233_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1077ui_story"].transform.localEulerAngles = arg_233_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_1 and arg_233_1.time_ < 0 + var_236_1 + arg_236_0 then
				arg_233_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1077ui_story"].transform.position).z)
				arg_233_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1077ui_story"].transform.localEulerAngles = arg_233_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_236_2 = GameObjectTools.GetOrAddComponent(arg_233_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_236_2 then
					var_236_2:EnableDynamicBone(true)
				end
			end

			local var_236_3 = arg_233_1.actors_["1061ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1061ui_story = var_236_3.localPosition
			end

			local var_236_4 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				var_236_3.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_4)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				var_236_3.localPosition = Vector3.New(0, 100, 0)
				var_236_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_3.position).x, (manager.ui.mainCamera.transform.position - var_236_3.position).y, (manager.ui.mainCamera.transform.position - var_236_3.position).z)
				var_236_3.localEulerAngles.z = 0
				var_236_3.localEulerAngles.x = 0
				var_236_3.localEulerAngles = var_236_3.localEulerAngles
			end

			local var_236_5 = arg_233_1.actors_["1077ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect1077ui_story == nil then
				arg_233_1.var_.characterEffect1077ui_story = var_236_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_6 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_6 and not isNil(var_236_5) then
				if arg_233_1.var_.characterEffect1077ui_story and not isNil(var_236_5) then
					arg_233_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_6)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_6 and arg_233_1.time_ < 0 + var_236_6 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.characterEffect1077ui_story then
				arg_233_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_236_7 = 0
			local var_236_8 = 1.05

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_7 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_9 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(325102055).content)

				arg_233_1.text_.text = var_236_9

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_11 = 42 <= 0 and var_236_8 or var_236_8 * (utf8.len(var_236_9) / 42)

				if (42 <= 0 and var_236_8 or var_236_8 * (utf8.len(var_236_9) / 42)) > 0 and var_236_8 < var_236_11 then
					arg_233_1.talkMaxDuration = var_236_11

					if var_236_11 + var_236_7 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_11 + var_236_7
					end
				end

				arg_233_1.text_.text = var_236_9
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_8, arg_233_1.talkMaxDuration)

			if var_236_7 <= arg_233_1.time_ and arg_233_1.time_ < var_236_7 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_7) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_7 + var_236_12 and arg_233_1.time_ < var_236_7 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play325102056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 325102056
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play325102057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.75

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(325102056).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 30 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 30)

				if (30 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 30)) > 0 and var_240_0 < var_240_3 then
					arg_237_1.talkMaxDuration = var_240_3

					if var_240_3 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_3 + 0
					end
				end

				arg_237_1.text_.text = var_240_1
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_4 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_4

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play325102057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 325102057
		arg_241_1.duration_ = 13.63

		local var_241_0 = {
			zh = 10.5333333333333,
			ja = 13.6333333333333
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
				arg_241_0:Play325102058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if arg_241_1.bgs_.J03h == nil then
				local var_244_0 = Object.Instantiate(arg_241_1.paintGo_)

				var_244_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J03h")
				var_244_0.name = "J03h"
				var_244_0.transform.parent = arg_241_1.stage_.transform
				var_244_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.bgs_.J03h = var_244_0
			end

			if 1.43333333333333 < arg_241_1.time_ and arg_241_1.time_ <= 1.43333333333333 + arg_244_0 then
				local var_244_1 = arg_241_1.bgs_.J03h

				arg_241_1.bgs_.J03h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_244_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_244_2 = var_244_1:GetComponent("SpriteRenderer")

				if var_244_2 and var_244_2.sprite then
					local var_244_3 = 2 * (var_244_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_244_1.transform.localScale = Vector3.New(var_244_3 / var_244_2.sprite.bounds.size.y < var_244_3 * manager.ui.mainCameraCom_.aspect / var_244_2.sprite.bounds.size.x and var_244_3 * manager.ui.mainCameraCom_.aspect / var_244_2.sprite.bounds.size.x or var_244_3 / var_244_2.sprite.bounds.size.y, var_244_3 / var_244_2.sprite.bounds.size.y < var_244_3 * manager.ui.mainCameraCom_.aspect / var_244_2.sprite.bounds.size.x and var_244_3 * manager.ui.mainCameraCom_.aspect / var_244_2.sprite.bounds.size.x or var_244_3 / var_244_2.sprite.bounds.size.y, 0)
				end

				for iter_244_0, iter_244_1 in pairs(arg_241_1.bgs_) do
					if iter_244_0 ~= "J03h" then
						iter_244_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_244_4 = 0

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.allBtn_.enabled = false
			end

			if arg_241_1.time_ >= var_244_4 + 0.3 and arg_241_1.time_ < var_244_4 + 0.3 + arg_244_0 then
				arg_241_1.allBtn_.enabled = true
			end

			local var_244_5 = 0

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_6 = 1.43333333333333

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_6 then
				local var_244_7 = Color.New(0, 0, 0)

				var_244_7.a = Mathf.Lerp(0, 1, (arg_241_1.time_ - var_244_5) / var_244_6)
				arg_241_1.mask_.color = var_244_7
			end

			if arg_241_1.time_ >= var_244_5 + var_244_6 and arg_241_1.time_ < var_244_5 + var_244_6 + arg_244_0 then
				local var_244_8 = Color.New(0, 0, 0)

				var_244_8.a = 1
				arg_241_1.mask_.color = var_244_8
			end

			local var_244_9 = 1.43333333333333

			if 1.43333333333333 < arg_241_1.time_ and arg_241_1.time_ <= var_244_9 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_10 = 1.4

			if var_244_9 <= arg_241_1.time_ and arg_241_1.time_ < var_244_9 + var_244_10 then
				local var_244_11 = Color.New(0, 0, 0)

				var_244_11.a = Mathf.Lerp(1, 0, (arg_241_1.time_ - var_244_9) / var_244_10)
				arg_241_1.mask_.color = var_244_11
			end

			if arg_241_1.time_ >= var_244_9 + var_244_10 and arg_241_1.time_ < var_244_9 + var_244_10 + arg_244_0 then
				local var_244_12 = Color.New(0, 0, 0)

				arg_241_1.mask_.enabled = false
				var_244_12.a = 0
				arg_241_1.mask_.color = var_244_12
			end

			local var_244_13 = arg_241_1.actors_["1061ui_story"].transform

			if 2.6333333303531 < arg_241_1.time_ and arg_241_1.time_ <= 2.6333333303531 + arg_244_0 then
				arg_241_1.var_.moveOldPos1061ui_story = var_244_13.localPosition
			end

			local var_244_14 = 0.001

			if 2.6333333303531 <= arg_241_1.time_ and arg_241_1.time_ < 2.6333333303531 + var_244_14 then
				var_244_13.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_241_1.time_ - 2.6333333303531) / var_244_14)
				var_244_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_13.position).x, (manager.ui.mainCamera.transform.position - var_244_13.position).y, (manager.ui.mainCamera.transform.position - var_244_13.position).z)
				var_244_13.localEulerAngles.z = 0
				var_244_13.localEulerAngles.x = 0
				var_244_13.localEulerAngles = var_244_13.localEulerAngles
			end

			if arg_241_1.time_ >= 2.6333333303531 + var_244_14 and arg_241_1.time_ < 2.6333333303531 + var_244_14 + arg_244_0 then
				var_244_13.localPosition = Vector3.New(0, -1.18, -6.15)
				var_244_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_13.position).x, (manager.ui.mainCamera.transform.position - var_244_13.position).y, (manager.ui.mainCamera.transform.position - var_244_13.position).z)
				var_244_13.localEulerAngles.z = 0
				var_244_13.localEulerAngles.x = 0
				var_244_13.localEulerAngles = var_244_13.localEulerAngles
			end

			local var_244_15 = arg_241_1.actors_["1061ui_story"]

			if 2.6333333303531 < arg_241_1.time_ and arg_241_1.time_ <= 2.6333333303531 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.characterEffect1061ui_story == nil then
				arg_241_1.var_.characterEffect1061ui_story = var_244_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_16 = 0.200000002980232

			if 2.6333333303531 <= arg_241_1.time_ and arg_241_1.time_ < 2.6333333303531 + var_244_16 and not isNil(var_244_15) then
				if arg_241_1.var_.characterEffect1061ui_story and not isNil(var_244_15) then
					arg_241_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 2.6333333303531 + var_244_16 and arg_241_1.time_ < 2.6333333303531 + var_244_16 + arg_244_0 and not isNil(var_244_15) and arg_241_1.var_.characterEffect1061ui_story then
				arg_241_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 2.6333333303531 < arg_241_1.time_ and arg_241_1.time_ <= 2.6333333303531 + arg_244_0 then
				arg_241_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 2.6333333303531 < arg_241_1.time_ and arg_241_1.time_ <= 2.6333333303531 + arg_244_0 then
				if arg_241_1.var_.characterEffect1061ui_story == nil then
					arg_241_1.var_.characterEffect1061ui_story = arg_241_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_241_1.var_.characterEffect1061ui_story.imageEffect:turnOff()
			end

			if 2.6333333303531 < arg_241_1.time_ and arg_241_1.time_ <= 2.6333333303531 + arg_244_0 then
				if arg_241_1.var_.characterEffect1061ui_story == nil then
					arg_241_1.var_.characterEffect1061ui_story = arg_241_1.actors_["1061ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_244_19 = arg_241_1.var_.characterEffect1061ui_story

				arg_241_1.var_.characterEffect1061ui_story.imageEffect:turnOff()

				var_244_19.interferenceEffect.enabled = false
				var_244_19.interferenceEffect.noise = 0.001
				var_244_19.interferenceEffect.simTimeScale = 1
				var_244_19.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_244_20 = 1.43333333333333

			arg_241_1.isInRecall_ = false

			if var_244_20 < arg_241_1.time_ and arg_241_1.time_ <= var_244_20 + arg_244_0 then
				arg_241_1.screenFilterGo_:SetActive(true)

				arg_241_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_244_2, iter_244_3 in pairs(arg_241_1.actors_) do
					for iter_244_4, iter_244_5 in ipairs((iter_244_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_244_5.color = iter_244_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_244_21 = 0.034000001847744

			if var_244_20 <= arg_241_1.time_ and arg_241_1.time_ < var_244_20 + var_244_21 then
				arg_241_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_241_1.time_ - var_244_20) / var_244_21)
			end

			if arg_241_1.time_ >= var_244_20 + var_244_21 and arg_241_1.time_ < var_244_20 + var_244_21 + arg_244_0 then
				arg_241_1.screenFilterEffect_.weight = 1
			end

			if arg_241_1.frameCnt_ <= 1 then
				arg_241_1.dialog_:SetActive(false)
			end

			local var_244_22 = 2.83333333333333
			local var_244_23 = 0.9

			if 2.83333333333333 < arg_241_1.time_ and arg_241_1.time_ <= var_244_22 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_24 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_24:setOnUpdate(LuaHelper.FloatAction(function(arg_245_0)
					arg_241_1.dialogCg_.alpha = arg_245_0
				end))
				var_244_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_25 = arg_241_1:GetWordFromCfg(325102057)
				local var_244_26 = arg_241_1:FormatText(var_244_25.content)

				arg_241_1.text_.text = var_244_26

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_28 = 36 <= 0 and var_244_23 or var_244_23 * (utf8.len(var_244_26) / 36)

				if (36 <= 0 and var_244_23 or var_244_23 * (utf8.len(var_244_26) / 36)) > 0 and var_244_23 < var_244_28 then
					arg_241_1.talkMaxDuration = var_244_28
					var_244_22 = var_244_22 + 0.3

					if var_244_28 + var_244_22 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_28 + var_244_22
					end
				end

				arg_241_1.text_.text = var_244_26
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102057", "story_v_out_325102.awb") ~= 0 then
					local var_244_29 = manager.audio:GetVoiceLength("story_v_out_325102", "325102057", "story_v_out_325102.awb") / 1000

					if var_244_29 + var_244_22 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_29 + var_244_22
					end

					if var_244_25.prefab_name ~= "" and arg_241_1.actors_[var_244_25.prefab_name] ~= nil then
						local var_244_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_25.prefab_name].transform, "story_v_out_325102", "325102057", "story_v_out_325102.awb")

						arg_241_1:RecordAudio("325102057", var_244_30)
						arg_241_1:RecordAudio("325102057", var_244_30)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_325102", "325102057", "story_v_out_325102.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_325102", "325102057", "story_v_out_325102.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_31 = var_244_22 + 0.3
			local var_244_32 = math.max(var_244_23, arg_241_1.talkMaxDuration)

			if var_244_22 + 0.3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_31 + var_244_32 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_31) / var_244_32

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_31 + var_244_32 and arg_241_1.time_ < var_244_31 + var_244_32 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.6333333303531,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play325102058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 325102058
		arg_247_1.duration_ = 12.2

		local var_247_0 = {
			zh = 9.866,
			ja = 12.2
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
				arg_247_0:Play325102059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.1

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:GetWordFromCfg(325102058)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 44 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 44)

				if (44 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 44)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102058", "story_v_out_325102.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102058", "story_v_out_325102.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_325102", "325102058", "story_v_out_325102.awb")

						arg_247_1:RecordAudio("325102058", var_250_6)
						arg_247_1:RecordAudio("325102058", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_325102", "325102058", "story_v_out_325102.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_325102", "325102058", "story_v_out_325102.awb")
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
	Play325102059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 325102059
		arg_251_1.duration_ = 9.17

		local var_251_0 = {
			zh = 8.499999999999,
			ja = 9.165999999999
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
				arg_251_0:Play325102060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 1.66666666666667 < arg_251_1.time_ and arg_251_1.time_ <= 1.66666666666667 + arg_254_0 then
				local var_254_0 = arg_251_1.bgs_.J22f

				arg_251_1.bgs_.J22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_254_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_254_1 = var_254_0:GetComponent("SpriteRenderer")

				if var_254_1 and var_254_1.sprite then
					local var_254_2 = 2 * (var_254_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_254_0.transform.localScale = Vector3.New(var_254_2 / var_254_1.sprite.bounds.size.y < var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x and var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x or var_254_2 / var_254_1.sprite.bounds.size.y, var_254_2 / var_254_1.sprite.bounds.size.y < var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x and var_254_2 * manager.ui.mainCameraCom_.aspect / var_254_1.sprite.bounds.size.x or var_254_2 / var_254_1.sprite.bounds.size.y, 0)
				end

				for iter_254_0, iter_254_1 in pairs(arg_251_1.bgs_) do
					if iter_254_0 ~= "J22f" then
						iter_254_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_254_3 = 1.66666666666667

			if 1.66666666666667 < arg_251_1.time_ and arg_251_1.time_ <= var_254_3 + arg_254_0 then
				arg_251_1.allBtn_.enabled = false
			end

			if arg_251_1.time_ >= var_254_3 + 0.3 and arg_251_1.time_ < var_254_3 + 0.3 + arg_254_0 then
				arg_251_1.allBtn_.enabled = true
			end

			local var_254_4 = 0

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_4 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_5 = 1.66666666666667

			if var_254_4 <= arg_251_1.time_ and arg_251_1.time_ < var_254_4 + var_254_5 then
				local var_254_6 = Color.New(0, 0, 0)

				var_254_6.a = Mathf.Lerp(0, 1, (arg_251_1.time_ - var_254_4) / var_254_5)
				arg_251_1.mask_.color = var_254_6
			end

			if arg_251_1.time_ >= var_254_4 + var_254_5 and arg_251_1.time_ < var_254_4 + var_254_5 + arg_254_0 then
				local var_254_7 = Color.New(0, 0, 0)

				var_254_7.a = 1
				arg_251_1.mask_.color = var_254_7
			end

			local var_254_8 = 1.66666666666667

			if 1.66666666666667 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_9 = 2

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_9 then
				local var_254_10 = Color.New(0, 0, 0)

				var_254_10.a = Mathf.Lerp(1, 0, (arg_251_1.time_ - var_254_8) / var_254_9)
				arg_251_1.mask_.color = var_254_10
			end

			if arg_251_1.time_ >= var_254_8 + var_254_9 and arg_251_1.time_ < var_254_8 + var_254_9 + arg_254_0 then
				local var_254_11 = Color.New(0, 0, 0)

				arg_251_1.mask_.enabled = false
				var_254_11.a = 0
				arg_251_1.mask_.color = var_254_11
			end

			local var_254_12 = arg_251_1.actors_["1061ui_story"].transform

			if 1.66666666666667 < arg_251_1.time_ and arg_251_1.time_ <= 1.66666666666667 + arg_254_0 then
				arg_251_1.var_.moveOldPos1061ui_story = var_254_12.localPosition
			end

			local var_254_13 = 0.001

			if 1.66666666666667 <= arg_251_1.time_ and arg_251_1.time_ < 1.66666666666667 + var_254_13 then
				var_254_12.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_251_1.time_ - 1.66666666666667) / var_254_13)
				var_254_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_12.position).x, (manager.ui.mainCamera.transform.position - var_254_12.position).y, (manager.ui.mainCamera.transform.position - var_254_12.position).z)
				var_254_12.localEulerAngles.z = 0
				var_254_12.localEulerAngles.x = 0
				var_254_12.localEulerAngles = var_254_12.localEulerAngles
			end

			if arg_251_1.time_ >= 1.66666666666667 + var_254_13 and arg_251_1.time_ < 1.66666666666667 + var_254_13 + arg_254_0 then
				var_254_12.localPosition = Vector3.New(0, 100, 0)
				var_254_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_12.position).x, (manager.ui.mainCamera.transform.position - var_254_12.position).y, (manager.ui.mainCamera.transform.position - var_254_12.position).z)
				var_254_12.localEulerAngles.z = 0
				var_254_12.localEulerAngles.x = 0
				var_254_12.localEulerAngles = var_254_12.localEulerAngles
			end

			local var_254_14 = arg_251_1.actors_["1077ui_story"].transform

			if 3.4 < arg_251_1.time_ and arg_251_1.time_ <= 3.4 + arg_254_0 then
				arg_251_1.var_.moveOldPos1077ui_story = var_254_14.localPosition

				local var_254_15 = GameObjectTools.GetOrAddComponent(var_254_14.gameObject, typeof(DynamicBoneHelper))

				if var_254_15 then
					var_254_15:EnableDynamicBone(false)
				end
			end

			local var_254_16 = 0.001

			if 3.4 <= arg_251_1.time_ and arg_251_1.time_ < 3.4 + var_254_16 then
				var_254_14.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_251_1.time_ - 3.4) / var_254_16)
				var_254_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_14.position).x, (manager.ui.mainCamera.transform.position - var_254_14.position).y, (manager.ui.mainCamera.transform.position - var_254_14.position).z)
				var_254_14.localEulerAngles.z = 0
				var_254_14.localEulerAngles.x = 0
				var_254_14.localEulerAngles = var_254_14.localEulerAngles
			end

			if arg_251_1.time_ >= 3.4 + var_254_16 and arg_251_1.time_ < 3.4 + var_254_16 + arg_254_0 then
				var_254_14.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_254_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_14.position).x, (manager.ui.mainCamera.transform.position - var_254_14.position).y, (manager.ui.mainCamera.transform.position - var_254_14.position).z)
				var_254_14.localEulerAngles.z = 0
				var_254_14.localEulerAngles.x = 0
				var_254_14.localEulerAngles = var_254_14.localEulerAngles

				local var_254_17 = GameObjectTools.GetOrAddComponent(var_254_14.gameObject, typeof(DynamicBoneHelper))

				if var_254_17 then
					var_254_17:EnableDynamicBone(true)
				end
			end

			local var_254_18 = arg_251_1.actors_["1077ui_story"]

			if 3.4 < arg_251_1.time_ and arg_251_1.time_ <= 3.4 + arg_254_0 and not isNil(var_254_18) and arg_251_1.var_.characterEffect1077ui_story == nil then
				arg_251_1.var_.characterEffect1077ui_story = var_254_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_19 = 0.55

			if 3.4 <= arg_251_1.time_ and arg_251_1.time_ < 3.4 + var_254_19 and not isNil(var_254_18) then
				if arg_251_1.var_.characterEffect1077ui_story and not isNil(var_254_18) then
					arg_251_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 3.4 + var_254_19 and arg_251_1.time_ < 3.4 + var_254_19 + arg_254_0 and not isNil(var_254_18) and arg_251_1.var_.characterEffect1077ui_story then
				arg_251_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_254_21 = arg_251_1.actors_["1061ui_story"]

			if 1.66666666666667 < arg_251_1.time_ and arg_251_1.time_ <= 1.66666666666667 + arg_254_0 and not isNil(var_254_21) and arg_251_1.var_.characterEffect1061ui_story == nil then
				arg_251_1.var_.characterEffect1061ui_story = var_254_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_22 = 0.200000002980232

			if 1.66666666666667 <= arg_251_1.time_ and arg_251_1.time_ < 1.66666666666667 + var_254_22 and not isNil(var_254_21) then
				if arg_251_1.var_.characterEffect1061ui_story and not isNil(var_254_21) then
					arg_251_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1061ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 1.66666666666667) / var_254_22)
				end
			end

			if arg_251_1.time_ >= 1.66666666666667 + var_254_22 and arg_251_1.time_ < 1.66666666666667 + var_254_22 + arg_254_0 and not isNil(var_254_21) and arg_251_1.var_.characterEffect1061ui_story then
				arg_251_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1061ui_story.fillRatio = 0.5
			end

			local var_254_23 = 1.66666666666667

			arg_251_1.isInRecall_ = false

			if var_254_23 < arg_251_1.time_ and arg_251_1.time_ <= var_254_23 + arg_254_0 then
				arg_251_1.screenFilterGo_:SetActive(false)

				for iter_254_2, iter_254_3 in pairs(arg_251_1.actors_) do
					for iter_254_4, iter_254_5 in ipairs((iter_254_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_254_5.color = iter_254_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_254_24 = 0.034000001847744

			if var_254_23 <= arg_251_1.time_ and arg_251_1.time_ < var_254_23 + var_254_24 then
				arg_251_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_251_1.time_ - var_254_23) / var_254_24)
			end

			if arg_251_1.time_ >= var_254_23 + var_254_24 and arg_251_1.time_ < var_254_23 + var_254_24 + arg_254_0 then
				arg_251_1.screenFilterEffect_.weight = 0
			end

			if 3.4 < arg_251_1.time_ and arg_251_1.time_ <= 3.4 + arg_254_0 then
				arg_251_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action2_2")
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_25 = 3.399999999999
			local var_254_26 = 0.55

			if 3.399999999999 < arg_251_1.time_ and arg_251_1.time_ <= var_254_25 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_27 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_27:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_251_1.dialogCg_.alpha = arg_255_0
				end))
				var_254_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_28 = arg_251_1:GetWordFromCfg(325102059)
				local var_254_29 = arg_251_1:FormatText(var_254_28.content)

				arg_251_1.text_.text = var_254_29

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_31 = 22 <= 0 and var_254_26 or var_254_26 * (utf8.len(var_254_29) / 22)

				if (22 <= 0 and var_254_26 or var_254_26 * (utf8.len(var_254_29) / 22)) > 0 and var_254_26 < var_254_31 then
					arg_251_1.talkMaxDuration = var_254_31
					var_254_25 = var_254_25 + 0.3

					if var_254_31 + var_254_25 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_31 + var_254_25
					end
				end

				arg_251_1.text_.text = var_254_29
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102059", "story_v_out_325102.awb") ~= 0 then
					local var_254_32 = manager.audio:GetVoiceLength("story_v_out_325102", "325102059", "story_v_out_325102.awb") / 1000

					if var_254_32 + var_254_25 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_32 + var_254_25
					end

					if var_254_28.prefab_name ~= "" and arg_251_1.actors_[var_254_28.prefab_name] ~= nil then
						local var_254_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_28.prefab_name].transform, "story_v_out_325102", "325102059", "story_v_out_325102.awb")

						arg_251_1:RecordAudio("325102059", var_254_33)
						arg_251_1:RecordAudio("325102059", var_254_33)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_325102", "325102059", "story_v_out_325102.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_325102", "325102059", "story_v_out_325102.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_34 = var_254_25 + 0.3
			local var_254_35 = math.max(var_254_26, arg_251_1.talkMaxDuration)

			if var_254_25 + 0.3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_34 + var_254_35 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_34) / var_254_35

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_34 + var_254_35 and arg_251_1.time_ < var_254_34 + var_254_35 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play325102060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 325102060
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play325102061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1077ui_story = arg_257_1.actors_["1077ui_story"].transform.localPosition

				local var_260_0 = GameObjectTools.GetOrAddComponent(arg_257_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_260_0 then
					var_260_0:EnableDynamicBone(false)
				end
			end

			local var_260_1 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_1 then
				arg_257_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_1)
				arg_257_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1077ui_story"].transform.position).z)
				arg_257_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1077ui_story"].transform.localEulerAngles = arg_257_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_1 and arg_257_1.time_ < 0 + var_260_1 + arg_260_0 then
				arg_257_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1077ui_story"].transform.position).z)
				arg_257_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1077ui_story"].transform.localEulerAngles = arg_257_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_260_2 = GameObjectTools.GetOrAddComponent(arg_257_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_260_2 then
					var_260_2:EnableDynamicBone(true)
				end
			end

			local var_260_3 = arg_257_1.actors_["1077ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_3) and arg_257_1.var_.characterEffect1077ui_story == nil then
				arg_257_1.var_.characterEffect1077ui_story = var_260_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_4 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 and not isNil(var_260_3) then
				if arg_257_1.var_.characterEffect1077ui_story and not isNil(var_260_3) then
					arg_257_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_4)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 and not isNil(var_260_3) and arg_257_1.var_.characterEffect1077ui_story then
				arg_257_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_260_5 = 0
			local var_260_6 = 1.375

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_7 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(325102060).content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 55 <= 0 and var_260_6 or var_260_6 * (utf8.len(var_260_7) / 55)

				if (55 <= 0 and var_260_6 or var_260_6 * (utf8.len(var_260_7) / 55)) > 0 and var_260_6 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_5 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_5
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_6, arg_257_1.talkMaxDuration)

			if var_260_5 <= arg_257_1.time_ and arg_257_1.time_ < var_260_5 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_5) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_5 + var_260_10 and arg_257_1.time_ < var_260_5 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 325102061
		arg_261_1.duration_ = 10.73

		local var_261_0 = {
			zh = 8.233,
			ja = 10.733
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
				arg_261_0:Play325102062(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1077ui_story = arg_261_1.actors_["1077ui_story"].transform.localPosition

				local var_264_0 = GameObjectTools.GetOrAddComponent(arg_261_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_264_0 then
					var_264_0:EnableDynamicBone(false)
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_261_1.time_ - 0) / var_264_1)
				arg_261_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1077ui_story"].transform.position).z)
				arg_261_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1077ui_story"].transform.localEulerAngles = arg_261_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_261_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1077ui_story"].transform.position).z)
				arg_261_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1077ui_story"].transform.localEulerAngles = arg_261_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_264_2 = GameObjectTools.GetOrAddComponent(arg_261_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_264_2 then
					var_264_2:EnableDynamicBone(true)
				end
			end

			local var_264_3 = arg_261_1.actors_["1077ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_3) and arg_261_1.var_.characterEffect1077ui_story == nil then
				arg_261_1.var_.characterEffect1077ui_story = var_264_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_4 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 and not isNil(var_264_3) then
				if arg_261_1.var_.characterEffect1077ui_story and not isNil(var_264_3) then
					arg_261_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 and not isNil(var_264_3) and arg_261_1.var_.characterEffect1077ui_story then
				arg_261_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_264_6 = 0
			local var_264_7 = 0.95

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_6 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_8 = arg_261_1:GetWordFromCfg(325102061)
				local var_264_9 = arg_261_1:FormatText(var_264_8.content)

				arg_261_1.text_.text = var_264_9

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_11 = 38 <= 0 and var_264_7 or var_264_7 * (utf8.len(var_264_9) / 38)

				if (38 <= 0 and var_264_7 or var_264_7 * (utf8.len(var_264_9) / 38)) > 0 and var_264_7 < var_264_11 then
					arg_261_1.talkMaxDuration = var_264_11

					if var_264_11 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_6
					end
				end

				arg_261_1.text_.text = var_264_9
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102061", "story_v_out_325102.awb") ~= 0 then
					local var_264_12 = manager.audio:GetVoiceLength("story_v_out_325102", "325102061", "story_v_out_325102.awb") / 1000

					if var_264_12 + var_264_6 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_12 + var_264_6
					end

					if var_264_8.prefab_name ~= "" and arg_261_1.actors_[var_264_8.prefab_name] ~= nil then
						local var_264_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_8.prefab_name].transform, "story_v_out_325102", "325102061", "story_v_out_325102.awb")

						arg_261_1:RecordAudio("325102061", var_264_13)
						arg_261_1:RecordAudio("325102061", var_264_13)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_325102", "325102061", "story_v_out_325102.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_325102", "325102061", "story_v_out_325102.awb")
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
				actorName = "1077ui_story",
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
	Play325102062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 325102062
		arg_265_1.duration_ = 9.57

		local var_265_0 = {
			zh = 4.3,
			ja = 9.566
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
				arg_265_0:Play325102063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.575

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:GetWordFromCfg(325102062)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 23 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 23)

				if (23 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 23)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102062", "story_v_out_325102.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102062", "story_v_out_325102.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_out_325102", "325102062", "story_v_out_325102.awb")

						arg_265_1:RecordAudio("325102062", var_268_6)
						arg_265_1:RecordAudio("325102062", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_325102", "325102062", "story_v_out_325102.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_325102", "325102062", "story_v_out_325102.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play325102063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 325102063
		arg_269_1.duration_ = 18.23

		local var_269_0 = {
			zh = 11.4333333333333,
			ja = 18.2333333333333
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
				arg_269_0:Play325102064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 1.43333333333333 < arg_269_1.time_ and arg_269_1.time_ <= 1.43333333333333 + arg_272_0 then
				local var_272_0 = arg_269_1.bgs_.J29g

				arg_269_1.bgs_.J29g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_272_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_272_1 = var_272_0:GetComponent("SpriteRenderer")

				if var_272_1 and var_272_1.sprite then
					local var_272_2 = 2 * (var_272_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_272_0.transform.localScale = Vector3.New(var_272_2 / var_272_1.sprite.bounds.size.y < var_272_2 * manager.ui.mainCameraCom_.aspect / var_272_1.sprite.bounds.size.x and var_272_2 * manager.ui.mainCameraCom_.aspect / var_272_1.sprite.bounds.size.x or var_272_2 / var_272_1.sprite.bounds.size.y, var_272_2 / var_272_1.sprite.bounds.size.y < var_272_2 * manager.ui.mainCameraCom_.aspect / var_272_1.sprite.bounds.size.x and var_272_2 * manager.ui.mainCameraCom_.aspect / var_272_1.sprite.bounds.size.x or var_272_2 / var_272_1.sprite.bounds.size.y, 0)
				end

				for iter_272_0, iter_272_1 in pairs(arg_269_1.bgs_) do
					if iter_272_0 ~= "J29g" then
						iter_272_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_272_3 = 0

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_3 + arg_272_0 then
				arg_269_1.allBtn_.enabled = false
			end

			if arg_269_1.time_ >= var_272_3 + 0.3 and arg_269_1.time_ < var_272_3 + 0.3 + arg_272_0 then
				arg_269_1.allBtn_.enabled = true
			end

			local var_272_4 = arg_269_1.actors_["1077ui_story"].transform

			if 1.46733333518108 < arg_269_1.time_ and arg_269_1.time_ <= 1.46733333518108 + arg_272_0 then
				arg_269_1.var_.moveOldPos1077ui_story = var_272_4.localPosition

				local var_272_5 = GameObjectTools.GetOrAddComponent(var_272_4.gameObject, typeof(DynamicBoneHelper))

				if var_272_5 then
					var_272_5:EnableDynamicBone(false)
				end
			end

			local var_272_6 = 0.001

			if 1.46733333518108 <= arg_269_1.time_ and arg_269_1.time_ < 1.46733333518108 + var_272_6 then
				var_272_4.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_269_1.time_ - 1.46733333518108) / var_272_6)
				var_272_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_4.position).x, (manager.ui.mainCamera.transform.position - var_272_4.position).y, (manager.ui.mainCamera.transform.position - var_272_4.position).z)
				var_272_4.localEulerAngles.z = 0
				var_272_4.localEulerAngles.x = 0
				var_272_4.localEulerAngles = var_272_4.localEulerAngles
			end

			if arg_269_1.time_ >= 1.46733333518108 + var_272_6 and arg_269_1.time_ < 1.46733333518108 + var_272_6 + arg_272_0 then
				var_272_4.localPosition = Vector3.New(0, 100, 0)
				var_272_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_4.position).x, (manager.ui.mainCamera.transform.position - var_272_4.position).y, (manager.ui.mainCamera.transform.position - var_272_4.position).z)
				var_272_4.localEulerAngles.z = 0
				var_272_4.localEulerAngles.x = 0
				var_272_4.localEulerAngles = var_272_4.localEulerAngles

				local var_272_7 = GameObjectTools.GetOrAddComponent(var_272_4.gameObject, typeof(DynamicBoneHelper))

				if var_272_7 then
					var_272_7:EnableDynamicBone(true)
				end
			end

			local var_272_8 = arg_269_1.actors_["1059ui_story"]

			if 1.46733333518108 < arg_269_1.time_ and arg_269_1.time_ <= 1.46733333518108 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.characterEffect1059ui_story == nil then
				arg_269_1.var_.characterEffect1059ui_story = var_272_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_9 = 0.200000002980232

			if 1.46733333518108 <= arg_269_1.time_ and arg_269_1.time_ < 1.46733333518108 + var_272_9 and not isNil(var_272_8) then
				if arg_269_1.var_.characterEffect1059ui_story and not isNil(var_272_8) then
					arg_269_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 1.46733333518108 + var_272_9 and arg_269_1.time_ < 1.46733333518108 + var_272_9 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.characterEffect1059ui_story then
				arg_269_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_272_11 = 1.43333333333333

			arg_269_1.isInRecall_ = false

			if var_272_11 < arg_269_1.time_ and arg_269_1.time_ <= var_272_11 + arg_272_0 then
				arg_269_1.screenFilterGo_:SetActive(true)

				arg_269_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_272_2, iter_272_3 in pairs(arg_269_1.actors_) do
					for iter_272_4, iter_272_5 in ipairs((iter_272_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_272_5.color = iter_272_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_272_12 = 0.034000001847744

			if var_272_11 <= arg_269_1.time_ and arg_269_1.time_ < var_272_11 + var_272_12 then
				arg_269_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_269_1.time_ - var_272_11) / var_272_12)
			end

			if arg_269_1.time_ >= var_272_11 + var_272_12 and arg_269_1.time_ < var_272_11 + var_272_12 + arg_272_0 then
				arg_269_1.screenFilterEffect_.weight = 1
			end

			local var_272_13 = 0

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_13 + arg_272_0 then
				arg_269_1.mask_.enabled = true
				arg_269_1.mask_.raycastTarget = true

				arg_269_1:SetGaussion(false)
			end

			local var_272_14 = 1.43333333333333

			if var_272_13 <= arg_269_1.time_ and arg_269_1.time_ < var_272_13 + var_272_14 then
				local var_272_15 = Color.New(0, 0, 0)

				var_272_15.a = Mathf.Lerp(0, 1, (arg_269_1.time_ - var_272_13) / var_272_14)
				arg_269_1.mask_.color = var_272_15
			end

			if arg_269_1.time_ >= var_272_13 + var_272_14 and arg_269_1.time_ < var_272_13 + var_272_14 + arg_272_0 then
				local var_272_16 = Color.New(0, 0, 0)

				var_272_16.a = 1
				arg_269_1.mask_.color = var_272_16
			end

			local var_272_17 = 1.43333333333333

			if 1.43333333333333 < arg_269_1.time_ and arg_269_1.time_ <= var_272_17 + arg_272_0 then
				arg_269_1.mask_.enabled = true
				arg_269_1.mask_.raycastTarget = true

				arg_269_1:SetGaussion(false)
			end

			local var_272_18 = 1.4

			if var_272_17 <= arg_269_1.time_ and arg_269_1.time_ < var_272_17 + var_272_18 then
				local var_272_19 = Color.New(0, 0, 0)

				var_272_19.a = Mathf.Lerp(1, 0, (arg_269_1.time_ - var_272_17) / var_272_18)
				arg_269_1.mask_.color = var_272_19
			end

			if arg_269_1.time_ >= var_272_17 + var_272_18 and arg_269_1.time_ < var_272_17 + var_272_18 + arg_272_0 then
				local var_272_20 = Color.New(0, 0, 0)

				arg_269_1.mask_.enabled = false
				var_272_20.a = 0
				arg_269_1.mask_.color = var_272_20
			end

			if arg_269_1.frameCnt_ <= 1 then
				arg_269_1.dialog_:SetActive(false)
			end

			local var_272_21 = 2.73333333333333
			local var_272_22 = 1.175

			if 2.73333333333333 < arg_269_1.time_ and arg_269_1.time_ <= var_272_21 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				arg_269_1.dialog_:SetActive(true)

				arg_269_1.dialogCg_.alpha = 0

				local var_272_23 = LeanTween.value(arg_269_1.dialog_, 0, 1, 0.3)

				var_272_23:setOnUpdate(LuaHelper.FloatAction(function(arg_273_0)
					arg_269_1.dialogCg_.alpha = arg_273_0
				end))
				var_272_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_269_1.dialog_)
					var_272_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_269_1.duration_ = arg_269_1.duration_ + 0.3

				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_269_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_272_24 = arg_269_1:GetWordFromCfg(325102063)
				local var_272_25 = arg_269_1:FormatText(var_272_24.content)

				arg_269_1.text_.text = var_272_25

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_27 = 47 <= 0 and var_272_22 or var_272_22 * (utf8.len(var_272_25) / 47)

				if (47 <= 0 and var_272_22 or var_272_22 * (utf8.len(var_272_25) / 47)) > 0 and var_272_22 < var_272_27 then
					arg_269_1.talkMaxDuration = var_272_27
					var_272_21 = var_272_21 + 0.3

					if var_272_27 + var_272_21 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_27 + var_272_21
					end
				end

				arg_269_1.text_.text = var_272_25
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102063", "story_v_out_325102.awb") ~= 0 then
					local var_272_28 = manager.audio:GetVoiceLength("story_v_out_325102", "325102063", "story_v_out_325102.awb") / 1000

					if var_272_28 + var_272_21 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_28 + var_272_21
					end

					if var_272_24.prefab_name ~= "" and arg_269_1.actors_[var_272_24.prefab_name] ~= nil then
						local var_272_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_24.prefab_name].transform, "story_v_out_325102", "325102063", "story_v_out_325102.awb")

						arg_269_1:RecordAudio("325102063", var_272_29)
						arg_269_1:RecordAudio("325102063", var_272_29)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_325102", "325102063", "story_v_out_325102.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_325102", "325102063", "story_v_out_325102.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_30 = var_272_21 + 0.3
			local var_272_31 = math.max(var_272_22, arg_269_1.talkMaxDuration)

			if var_272_21 + 0.3 <= arg_269_1.time_ and arg_269_1.time_ < var_272_30 + var_272_31 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_30) / var_272_31

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_30 + var_272_31 and arg_269_1.time_ < var_272_30 + var_272_31 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.46733333518108,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play325102064 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 325102064
		arg_275_1.duration_ = 16.27

		local var_275_0 = {
			zh = 9.76599999815225,
			ja = 16.2659999981523
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
				arg_275_0:Play325102065(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0.9 < arg_275_1.time_ and arg_275_1.time_ <= 0.9 + arg_278_0 then
				local var_278_0 = arg_275_1.bgs_.J22f

				arg_275_1.bgs_.J22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_278_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_278_1 = var_278_0:GetComponent("SpriteRenderer")

				if var_278_1 and var_278_1.sprite then
					local var_278_2 = 2 * (var_278_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_278_0.transform.localScale = Vector3.New(var_278_2 / var_278_1.sprite.bounds.size.y < var_278_2 * manager.ui.mainCameraCom_.aspect / var_278_1.sprite.bounds.size.x and var_278_2 * manager.ui.mainCameraCom_.aspect / var_278_1.sprite.bounds.size.x or var_278_2 / var_278_1.sprite.bounds.size.y, var_278_2 / var_278_1.sprite.bounds.size.y < var_278_2 * manager.ui.mainCameraCom_.aspect / var_278_1.sprite.bounds.size.x and var_278_2 * manager.ui.mainCameraCom_.aspect / var_278_1.sprite.bounds.size.x or var_278_2 / var_278_1.sprite.bounds.size.y, 0)
				end

				for iter_278_0, iter_278_1 in pairs(arg_275_1.bgs_) do
					if iter_278_0 ~= "J22f" then
						iter_278_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_278_3 = arg_275_1.actors_["1077ui_story"]

			if 2.36599999815226 < arg_275_1.time_ and arg_275_1.time_ <= 2.36599999815226 + arg_278_0 and not isNil(var_278_3) and arg_275_1.var_.characterEffect1077ui_story == nil then
				arg_275_1.var_.characterEffect1077ui_story = var_278_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_4 = 0.300666668514411

			if 2.36599999815226 <= arg_275_1.time_ and arg_275_1.time_ < 2.36599999815226 + var_278_4 and not isNil(var_278_3) then
				if arg_275_1.var_.characterEffect1077ui_story and not isNil(var_278_3) then
					arg_275_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 2.36599999815226 + var_278_4 and arg_275_1.time_ < 2.36599999815226 + var_278_4 + arg_278_0 and not isNil(var_278_3) and arg_275_1.var_.characterEffect1077ui_story then
				arg_275_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 2.36599999815226 < arg_275_1.time_ and arg_275_1.time_ <= 2.36599999815226 + arg_278_0 then
				arg_275_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_278_6 = 0

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_7 = 0.899999999999999

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_7 then
				local var_278_8 = Color.New(0, 0, 0)

				var_278_8.a = Mathf.Lerp(0, 1, (arg_275_1.time_ - var_278_6) / var_278_7)
				arg_275_1.mask_.color = var_278_8
			end

			if arg_275_1.time_ >= var_278_6 + var_278_7 and arg_275_1.time_ < var_278_6 + var_278_7 + arg_278_0 then
				local var_278_9 = Color.New(0, 0, 0)

				var_278_9.a = 1
				arg_275_1.mask_.color = var_278_9
			end

			local var_278_10 = 0.899999999999999

			if 0.899999999999999 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 then
				arg_275_1.mask_.enabled = true
				arg_275_1.mask_.raycastTarget = true

				arg_275_1:SetGaussion(false)
			end

			local var_278_11 = 1.53333333333333

			if var_278_10 <= arg_275_1.time_ and arg_275_1.time_ < var_278_10 + var_278_11 then
				local var_278_12 = Color.New(0, 0, 0)

				var_278_12.a = Mathf.Lerp(1, 0, (arg_275_1.time_ - var_278_10) / var_278_11)
				arg_275_1.mask_.color = var_278_12
			end

			if arg_275_1.time_ >= var_278_10 + var_278_11 and arg_275_1.time_ < var_278_10 + var_278_11 + arg_278_0 then
				local var_278_13 = Color.New(0, 0, 0)

				arg_275_1.mask_.enabled = false
				var_278_13.a = 0
				arg_275_1.mask_.color = var_278_13
			end

			local var_278_14 = arg_275_1.actors_["1077ui_story"].transform

			if 2.36599999815226 < arg_275_1.time_ and arg_275_1.time_ <= 2.36599999815226 + arg_278_0 then
				arg_275_1.var_.moveOldPos1077ui_story = var_278_14.localPosition

				local var_278_15 = GameObjectTools.GetOrAddComponent(var_278_14.gameObject, typeof(DynamicBoneHelper))

				if var_278_15 then
					var_278_15:EnableDynamicBone(false)
				end
			end

			local var_278_16 = 0.001

			if 2.36599999815226 <= arg_275_1.time_ and arg_275_1.time_ < 2.36599999815226 + var_278_16 then
				var_278_14.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_275_1.time_ - 2.36599999815226) / var_278_16)
				var_278_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_14.position).x, (manager.ui.mainCamera.transform.position - var_278_14.position).y, (manager.ui.mainCamera.transform.position - var_278_14.position).z)
				var_278_14.localEulerAngles.z = 0
				var_278_14.localEulerAngles.x = 0
				var_278_14.localEulerAngles = var_278_14.localEulerAngles
			end

			if arg_275_1.time_ >= 2.36599999815226 + var_278_16 and arg_275_1.time_ < 2.36599999815226 + var_278_16 + arg_278_0 then
				var_278_14.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_278_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_14.position).x, (manager.ui.mainCamera.transform.position - var_278_14.position).y, (manager.ui.mainCamera.transform.position - var_278_14.position).z)
				var_278_14.localEulerAngles.z = 0
				var_278_14.localEulerAngles.x = 0
				var_278_14.localEulerAngles = var_278_14.localEulerAngles

				local var_278_17 = GameObjectTools.GetOrAddComponent(var_278_14.gameObject, typeof(DynamicBoneHelper))

				if var_278_17 then
					var_278_17:EnableDynamicBone(true)
				end
			end

			local var_278_18 = arg_275_1.actors_["1077ui_story"]

			if 2.36599999815226 < arg_275_1.time_ and arg_275_1.time_ <= 2.36599999815226 + arg_278_0 and not isNil(var_278_18) and arg_275_1.var_.characterEffect1077ui_story == nil then
				arg_275_1.var_.characterEffect1077ui_story = var_278_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_19 = 0.55

			if 2.36599999815226 <= arg_275_1.time_ and arg_275_1.time_ < 2.36599999815226 + var_278_19 and not isNil(var_278_18) then
				if arg_275_1.var_.characterEffect1077ui_story and not isNil(var_278_18) then
					arg_275_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 2.36599999815226 + var_278_19 and arg_275_1.time_ < 2.36599999815226 + var_278_19 + arg_278_0 and not isNil(var_278_18) and arg_275_1.var_.characterEffect1077ui_story then
				arg_275_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_278_21 = 0.9

			arg_275_1.isInRecall_ = false

			if var_278_21 < arg_275_1.time_ and arg_275_1.time_ <= var_278_21 + arg_278_0 then
				arg_275_1.screenFilterGo_:SetActive(false)

				for iter_278_2, iter_278_3 in pairs(arg_275_1.actors_) do
					for iter_278_4, iter_278_5 in ipairs((iter_278_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_278_5.color = iter_278_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_278_22 = 0.034000001847744

			if var_278_21 <= arg_275_1.time_ and arg_275_1.time_ < var_278_21 + var_278_22 then
				arg_275_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_275_1.time_ - var_278_21) / var_278_22)
			end

			if arg_275_1.time_ >= var_278_21 + var_278_22 and arg_275_1.time_ < var_278_21 + var_278_22 + arg_278_0 then
				arg_275_1.screenFilterEffect_.weight = 0
			end

			if 2.36599999815226 < arg_275_1.time_ and arg_275_1.time_ <= 2.36599999815226 + arg_278_0 then
				arg_275_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0.9 < arg_275_1.time_ and arg_275_1.time_ <= 0.9 + arg_278_0 then
				local var_278_23 = arg_275_1.bgs_.J22f

				arg_275_1.bgs_.J22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_278_23.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_278_24 = var_278_23:GetComponent("SpriteRenderer")

				if var_278_24 and var_278_24.sprite then
					local var_278_25 = 2 * (var_278_23.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_278_23.transform.localScale = Vector3.New(var_278_25 / var_278_24.sprite.bounds.size.y < var_278_25 * manager.ui.mainCameraCom_.aspect / var_278_24.sprite.bounds.size.x and var_278_25 * manager.ui.mainCameraCom_.aspect / var_278_24.sprite.bounds.size.x or var_278_25 / var_278_24.sprite.bounds.size.y, var_278_25 / var_278_24.sprite.bounds.size.y < var_278_25 * manager.ui.mainCameraCom_.aspect / var_278_24.sprite.bounds.size.x and var_278_25 * manager.ui.mainCameraCom_.aspect / var_278_24.sprite.bounds.size.x or var_278_25 / var_278_24.sprite.bounds.size.y, 0)
				end

				for iter_278_6, iter_278_7 in pairs(arg_275_1.bgs_) do
					if iter_278_6 ~= "J22f" then
						iter_278_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_275_1.frameCnt_ <= 1 then
				arg_275_1.dialog_:SetActive(false)
			end

			local var_278_26 = 2.46599999815226
			local var_278_27 = 0.85

			if 2.46599999815226 < arg_275_1.time_ and arg_275_1.time_ <= var_278_26 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0

				arg_275_1.dialog_:SetActive(true)

				arg_275_1.dialogCg_.alpha = 0

				local var_278_28 = LeanTween.value(arg_275_1.dialog_, 0, 1, 0.3)

				var_278_28:setOnUpdate(LuaHelper.FloatAction(function(arg_279_0)
					arg_275_1.dialogCg_.alpha = arg_279_0
				end))
				var_278_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_275_1.dialog_)
					var_278_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_275_1.duration_ = arg_275_1.duration_ + 0.3

				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_29 = arg_275_1:GetWordFromCfg(325102064)
				local var_278_30 = arg_275_1:FormatText(var_278_29.content)

				arg_275_1.text_.text = var_278_30

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_32 = 34 <= 0 and var_278_27 or var_278_27 * (utf8.len(var_278_30) / 34)

				if (34 <= 0 and var_278_27 or var_278_27 * (utf8.len(var_278_30) / 34)) > 0 and var_278_27 < var_278_32 then
					arg_275_1.talkMaxDuration = var_278_32
					var_278_26 = var_278_26 + 0.3

					if var_278_32 + var_278_26 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_32 + var_278_26
					end
				end

				arg_275_1.text_.text = var_278_30
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102064", "story_v_out_325102.awb") ~= 0 then
					local var_278_33 = manager.audio:GetVoiceLength("story_v_out_325102", "325102064", "story_v_out_325102.awb") / 1000

					if var_278_33 + var_278_26 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_33 + var_278_26
					end

					if var_278_29.prefab_name ~= "" and arg_275_1.actors_[var_278_29.prefab_name] ~= nil then
						local var_278_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_29.prefab_name].transform, "story_v_out_325102", "325102064", "story_v_out_325102.awb")

						arg_275_1:RecordAudio("325102064", var_278_34)
						arg_275_1:RecordAudio("325102064", var_278_34)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_325102", "325102064", "story_v_out_325102.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_325102", "325102064", "story_v_out_325102.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_35 = var_278_26 + 0.3
			local var_278_36 = math.max(var_278_27, arg_275_1.talkMaxDuration)

			if var_278_26 + 0.3 <= arg_275_1.time_ and arg_275_1.time_ < var_278_35 + var_278_36 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_35) / var_278_36

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_35 + var_278_36 and arg_275_1.time_ < var_278_35 + var_278_36 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.36599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play325102065 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 325102065
		arg_281_1.duration_ = 4.93

		local var_281_0 = {
			zh = 4.133,
			ja = 4.933
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
				arg_281_0:Play325102066(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_284_0 = 0
			local var_284_1 = 0.525

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(325102065)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 21 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 21)

				if (21 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 21)) > 0 and var_284_1 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102065", "story_v_out_325102.awb") ~= 0 then
					local var_284_6 = manager.audio:GetVoiceLength("story_v_out_325102", "325102065", "story_v_out_325102.awb") / 1000

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end

					if var_284_2.prefab_name ~= "" and arg_281_1.actors_[var_284_2.prefab_name] ~= nil then
						local var_284_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_2.prefab_name].transform, "story_v_out_325102", "325102065", "story_v_out_325102.awb")

						arg_281_1:RecordAudio("325102065", var_284_7)
						arg_281_1:RecordAudio("325102065", var_284_7)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_325102", "325102065", "story_v_out_325102.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_325102", "325102065", "story_v_out_325102.awb")
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
	Play325102066 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 325102066
		arg_285_1.duration_ = 10.6

		local var_285_0 = {
			zh = 7.633,
			ja = 10.6
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
				arg_285_0:Play325102067(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.925

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_1 = arg_285_1:GetWordFromCfg(325102066)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 37 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 37)

				if (37 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 37)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102066", "story_v_out_325102.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102066", "story_v_out_325102.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_325102", "325102066", "story_v_out_325102.awb")

						arg_285_1:RecordAudio("325102066", var_288_6)
						arg_285_1:RecordAudio("325102066", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_325102", "325102066", "story_v_out_325102.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_325102", "325102066", "story_v_out_325102.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play325102067 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 325102067
		arg_289_1.duration_ = 14.29

		local var_289_0 = {
			zh = 7.79133333333333,
			ja = 14.2913333333333
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
				arg_289_0:Play325102068(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 1.43333333333333 < arg_289_1.time_ and arg_289_1.time_ <= 1.43333333333333 + arg_292_0 then
				local var_292_0 = arg_289_1.bgs_.J29g

				arg_289_1.bgs_.J29g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_292_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_1 = var_292_0:GetComponent("SpriteRenderer")

				if var_292_1 and var_292_1.sprite then
					local var_292_2 = 2 * (var_292_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_292_0.transform.localScale = Vector3.New(var_292_2 / var_292_1.sprite.bounds.size.y < var_292_2 * manager.ui.mainCameraCom_.aspect / var_292_1.sprite.bounds.size.x and var_292_2 * manager.ui.mainCameraCom_.aspect / var_292_1.sprite.bounds.size.x or var_292_2 / var_292_1.sprite.bounds.size.y, var_292_2 / var_292_1.sprite.bounds.size.y < var_292_2 * manager.ui.mainCameraCom_.aspect / var_292_1.sprite.bounds.size.x and var_292_2 * manager.ui.mainCameraCom_.aspect / var_292_1.sprite.bounds.size.x or var_292_2 / var_292_1.sprite.bounds.size.y, 0)
				end

				for iter_292_0, iter_292_1 in pairs(arg_289_1.bgs_) do
					if iter_292_0 ~= "J29g" then
						iter_292_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_3 = 1.43333333333333

			arg_289_1.isInRecall_ = false

			if var_292_3 < arg_289_1.time_ and arg_289_1.time_ <= var_292_3 + arg_292_0 then
				arg_289_1.screenFilterGo_:SetActive(true)

				arg_289_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_292_2, iter_292_3 in pairs(arg_289_1.actors_) do
					for iter_292_4, iter_292_5 in ipairs((iter_292_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_292_5.color = iter_292_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_292_4 = 0.034000001847744

			if var_292_3 <= arg_289_1.time_ and arg_289_1.time_ < var_292_3 + var_292_4 then
				arg_289_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_289_1.time_ - var_292_3) / var_292_4)
			end

			if arg_289_1.time_ >= var_292_3 + var_292_4 and arg_289_1.time_ < var_292_3 + var_292_4 + arg_292_0 then
				arg_289_1.screenFilterEffect_.weight = 1
			end

			local var_292_5 = 0

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_6 = 1.43333333333333

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_6 then
				local var_292_7 = Color.New(0, 0, 0)

				var_292_7.a = Mathf.Lerp(0, 1, (arg_289_1.time_ - var_292_5) / var_292_6)
				arg_289_1.mask_.color = var_292_7
			end

			if arg_289_1.time_ >= var_292_5 + var_292_6 and arg_289_1.time_ < var_292_5 + var_292_6 + arg_292_0 then
				local var_292_8 = Color.New(0, 0, 0)

				var_292_8.a = 1
				arg_289_1.mask_.color = var_292_8
			end

			local var_292_9 = 1.43333333333333

			if 1.43333333333333 < arg_289_1.time_ and arg_289_1.time_ <= var_292_9 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_10 = 1.4

			if var_292_9 <= arg_289_1.time_ and arg_289_1.time_ < var_292_9 + var_292_10 then
				local var_292_11 = Color.New(0, 0, 0)

				var_292_11.a = Mathf.Lerp(1, 0, (arg_289_1.time_ - var_292_9) / var_292_10)
				arg_289_1.mask_.color = var_292_11
			end

			if arg_289_1.time_ >= var_292_9 + var_292_10 and arg_289_1.time_ < var_292_9 + var_292_10 + arg_292_0 then
				local var_292_12 = Color.New(0, 0, 0)

				arg_289_1.mask_.enabled = false
				var_292_12.a = 0
				arg_289_1.mask_.color = var_292_12
			end

			local var_292_13 = arg_289_1.actors_["1077ui_story"].transform

			if 1.43333333333333 < arg_289_1.time_ and arg_289_1.time_ <= 1.43333333333333 + arg_292_0 then
				arg_289_1.var_.moveOldPos1077ui_story = var_292_13.localPosition

				local var_292_14 = GameObjectTools.GetOrAddComponent(var_292_13.gameObject, typeof(DynamicBoneHelper))

				if var_292_14 then
					var_292_14:EnableDynamicBone(false)
				end
			end

			local var_292_15 = 0.001

			if 1.43333333333333 <= arg_289_1.time_ and arg_289_1.time_ < 1.43333333333333 + var_292_15 then
				var_292_13.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 1.43333333333333) / var_292_15)
				var_292_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_13.position).x, (manager.ui.mainCamera.transform.position - var_292_13.position).y, (manager.ui.mainCamera.transform.position - var_292_13.position).z)
				var_292_13.localEulerAngles.z = 0
				var_292_13.localEulerAngles.x = 0
				var_292_13.localEulerAngles = var_292_13.localEulerAngles
			end

			if arg_289_1.time_ >= 1.43333333333333 + var_292_15 and arg_289_1.time_ < 1.43333333333333 + var_292_15 + arg_292_0 then
				var_292_13.localPosition = Vector3.New(0, 100, 0)
				var_292_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_13.position).x, (manager.ui.mainCamera.transform.position - var_292_13.position).y, (manager.ui.mainCamera.transform.position - var_292_13.position).z)
				var_292_13.localEulerAngles.z = 0
				var_292_13.localEulerAngles.x = 0
				var_292_13.localEulerAngles = var_292_13.localEulerAngles

				local var_292_16 = GameObjectTools.GetOrAddComponent(var_292_13.gameObject, typeof(DynamicBoneHelper))

				if var_292_16 then
					var_292_16:EnableDynamicBone(true)
				end
			end

			if arg_289_1.frameCnt_ <= 1 then
				arg_289_1.dialog_:SetActive(false)
			end

			local var_292_17 = 2.85833333333333
			local var_292_18 = 0.575

			if 2.85833333333333 < arg_289_1.time_ and arg_289_1.time_ <= var_292_17 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				arg_289_1.dialog_:SetActive(true)

				arg_289_1.dialogCg_.alpha = 0

				local var_292_19 = LeanTween.value(arg_289_1.dialog_, 0, 1, 0.3)

				var_292_19:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_289_1.dialogCg_.alpha = arg_293_0
				end))
				var_292_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_289_1.dialog_)
					var_292_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_289_1.duration_ = arg_289_1.duration_ + 0.3

				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_289_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_292_20 = arg_289_1:GetWordFromCfg(325102067)
				local var_292_21 = arg_289_1:FormatText(var_292_20.content)

				arg_289_1.text_.text = var_292_21

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_23 = 23 <= 0 and var_292_18 or var_292_18 * (utf8.len(var_292_21) / 23)

				if (23 <= 0 and var_292_18 or var_292_18 * (utf8.len(var_292_21) / 23)) > 0 and var_292_18 < var_292_23 then
					arg_289_1.talkMaxDuration = var_292_23
					var_292_17 = var_292_17 + 0.3

					if var_292_23 + var_292_17 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_23 + var_292_17
					end
				end

				arg_289_1.text_.text = var_292_21
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102067", "story_v_out_325102.awb") ~= 0 then
					local var_292_24 = manager.audio:GetVoiceLength("story_v_out_325102", "325102067", "story_v_out_325102.awb") / 1000

					if var_292_24 + var_292_17 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_24 + var_292_17
					end

					if var_292_20.prefab_name ~= "" and arg_289_1.actors_[var_292_20.prefab_name] ~= nil then
						local var_292_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_20.prefab_name].transform, "story_v_out_325102", "325102067", "story_v_out_325102.awb")

						arg_289_1:RecordAudio("325102067", var_292_25)
						arg_289_1:RecordAudio("325102067", var_292_25)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_325102", "325102067", "story_v_out_325102.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_325102", "325102067", "story_v_out_325102.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_26 = var_292_17 + 0.3
			local var_292_27 = math.max(var_292_18, arg_289_1.talkMaxDuration)

			if var_292_17 + 0.3 <= arg_289_1.time_ and arg_289_1.time_ < var_292_26 + var_292_27 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_26) / var_292_27

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_26 + var_292_27 and arg_289_1.time_ < var_292_26 + var_292_27 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play325102068 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 325102068
		arg_295_1.duration_ = 16.17

		local var_295_0 = {
			zh = 8.133,
			ja = 16.166
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
				arg_295_0:Play325102069(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 1.05

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_295_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_298_1 = arg_295_1:GetWordFromCfg(325102068)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 42 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 42)

				if (42 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 42)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102068", "story_v_out_325102.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102068", "story_v_out_325102.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_325102", "325102068", "story_v_out_325102.awb")

						arg_295_1:RecordAudio("325102068", var_298_6)
						arg_295_1:RecordAudio("325102068", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_325102", "325102068", "story_v_out_325102.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_325102", "325102068", "story_v_out_325102.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play325102069 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 325102069
		arg_299_1.duration_ = 12.73

		local var_299_0 = {
			zh = 11.1996666666667,
			ja = 12.7326666666667
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play325102070(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 1.26666666666667 < arg_299_1.time_ and arg_299_1.time_ <= 1.26666666666667 + arg_302_0 then
				local var_302_0 = arg_299_1.bgs_.J22f

				arg_299_1.bgs_.J22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_302_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_302_1 = var_302_0:GetComponent("SpriteRenderer")

				if var_302_1 and var_302_1.sprite then
					local var_302_2 = 2 * (var_302_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_302_0.transform.localScale = Vector3.New(var_302_2 / var_302_1.sprite.bounds.size.y < var_302_2 * manager.ui.mainCameraCom_.aspect / var_302_1.sprite.bounds.size.x and var_302_2 * manager.ui.mainCameraCom_.aspect / var_302_1.sprite.bounds.size.x or var_302_2 / var_302_1.sprite.bounds.size.y, var_302_2 / var_302_1.sprite.bounds.size.y < var_302_2 * manager.ui.mainCameraCom_.aspect / var_302_1.sprite.bounds.size.x and var_302_2 * manager.ui.mainCameraCom_.aspect / var_302_1.sprite.bounds.size.x or var_302_2 / var_302_1.sprite.bounds.size.y, 0)
				end

				for iter_302_0, iter_302_1 in pairs(arg_299_1.bgs_) do
					if iter_302_0 ~= "J22f" then
						iter_302_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_302_3 = arg_299_1.actors_["1077ui_story"]

			if 3 < arg_299_1.time_ and arg_299_1.time_ <= 3 + arg_302_0 and not isNil(var_302_3) and arg_299_1.var_.characterEffect1077ui_story == nil then
				arg_299_1.var_.characterEffect1077ui_story = var_302_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_4 = 0.200000002980232

			if 3 <= arg_299_1.time_ and arg_299_1.time_ < 3 + var_302_4 and not isNil(var_302_3) then
				if arg_299_1.var_.characterEffect1077ui_story and not isNil(var_302_3) then
					arg_299_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 3 + var_302_4 and arg_299_1.time_ < 3 + var_302_4 + arg_302_0 and not isNil(var_302_3) and arg_299_1.var_.characterEffect1077ui_story then
				arg_299_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_302_6 = 0

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.mask_.enabled = true
				arg_299_1.mask_.raycastTarget = true

				arg_299_1:SetGaussion(false)
			end

			local var_302_7 = 1.26666666666667

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_7 then
				local var_302_8 = Color.New(0, 0, 0)

				var_302_8.a = Mathf.Lerp(0, 1, (arg_299_1.time_ - var_302_6) / var_302_7)
				arg_299_1.mask_.color = var_302_8
			end

			if arg_299_1.time_ >= var_302_6 + var_302_7 and arg_299_1.time_ < var_302_6 + var_302_7 + arg_302_0 then
				local var_302_9 = Color.New(0, 0, 0)

				var_302_9.a = 1
				arg_299_1.mask_.color = var_302_9
			end

			local var_302_10 = 1.26666666666667

			if 1.26666666666667 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 then
				arg_299_1.mask_.enabled = true
				arg_299_1.mask_.raycastTarget = true

				arg_299_1:SetGaussion(false)
			end

			local var_302_11 = 2

			if var_302_10 <= arg_299_1.time_ and arg_299_1.time_ < var_302_10 + var_302_11 then
				local var_302_12 = Color.New(0, 0, 0)

				var_302_12.a = Mathf.Lerp(1, 0, (arg_299_1.time_ - var_302_10) / var_302_11)
				arg_299_1.mask_.color = var_302_12
			end

			if arg_299_1.time_ >= var_302_10 + var_302_11 and arg_299_1.time_ < var_302_10 + var_302_11 + arg_302_0 then
				local var_302_13 = Color.New(0, 0, 0)

				arg_299_1.mask_.enabled = false
				var_302_13.a = 0
				arg_299_1.mask_.color = var_302_13
			end

			local var_302_14 = arg_299_1.actors_["1077ui_story"].transform

			if 2.64279113151133 < arg_299_1.time_ and arg_299_1.time_ <= 2.64279113151133 + arg_302_0 then
				arg_299_1.var_.moveOldPos1077ui_story = var_302_14.localPosition

				local var_302_15 = GameObjectTools.GetOrAddComponent(var_302_14.gameObject, typeof(DynamicBoneHelper))

				if var_302_15 then
					var_302_15:EnableDynamicBone(false)
				end
			end

			local var_302_16 = 0.001

			if 2.64279113151133 <= arg_299_1.time_ and arg_299_1.time_ < 2.64279113151133 + var_302_16 then
				var_302_14.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_299_1.time_ - 2.64279113151133) / var_302_16)
				var_302_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_14.position).x, (manager.ui.mainCamera.transform.position - var_302_14.position).y, (manager.ui.mainCamera.transform.position - var_302_14.position).z)
				var_302_14.localEulerAngles.z = 0
				var_302_14.localEulerAngles.x = 0
				var_302_14.localEulerAngles = var_302_14.localEulerAngles
			end

			if arg_299_1.time_ >= 2.64279113151133 + var_302_16 and arg_299_1.time_ < 2.64279113151133 + var_302_16 + arg_302_0 then
				var_302_14.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_302_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_14.position).x, (manager.ui.mainCamera.transform.position - var_302_14.position).y, (manager.ui.mainCamera.transform.position - var_302_14.position).z)
				var_302_14.localEulerAngles.z = 0
				var_302_14.localEulerAngles.x = 0
				var_302_14.localEulerAngles = var_302_14.localEulerAngles

				local var_302_17 = GameObjectTools.GetOrAddComponent(var_302_14.gameObject, typeof(DynamicBoneHelper))

				if var_302_17 then
					var_302_17:EnableDynamicBone(true)
				end
			end

			local var_302_18 = arg_299_1.actors_["1077ui_story"]

			if 2.64279113151133 < arg_299_1.time_ and arg_299_1.time_ <= 2.64279113151133 + arg_302_0 and not isNil(var_302_18) and arg_299_1.var_.characterEffect1077ui_story == nil then
				arg_299_1.var_.characterEffect1077ui_story = var_302_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_19 = 0.55

			if 2.64279113151133 <= arg_299_1.time_ and arg_299_1.time_ < 2.64279113151133 + var_302_19 and not isNil(var_302_18) then
				if arg_299_1.var_.characterEffect1077ui_story and not isNil(var_302_18) then
					arg_299_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 2.64279113151133 + var_302_19 and arg_299_1.time_ < 2.64279113151133 + var_302_19 + arg_302_0 and not isNil(var_302_18) and arg_299_1.var_.characterEffect1077ui_story then
				arg_299_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_302_21 = 1.26666666666667

			arg_299_1.isInRecall_ = false

			if var_302_21 < arg_299_1.time_ and arg_299_1.time_ <= var_302_21 + arg_302_0 then
				arg_299_1.screenFilterGo_:SetActive(false)

				for iter_302_2, iter_302_3 in pairs(arg_299_1.actors_) do
					for iter_302_4, iter_302_5 in ipairs((iter_302_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_302_5.color = iter_302_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_302_22 = 0.034000001847744

			if var_302_21 <= arg_299_1.time_ and arg_299_1.time_ < var_302_21 + var_302_22 then
				arg_299_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_299_1.time_ - var_302_21) / var_302_22)
			end

			if arg_299_1.time_ >= var_302_21 + var_302_22 and arg_299_1.time_ < var_302_21 + var_302_22 + arg_302_0 then
				arg_299_1.screenFilterEffect_.weight = 0
			end

			if 2.64279113151133 < arg_299_1.time_ and arg_299_1.time_ <= 2.64279113151133 + arg_302_0 then
				arg_299_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action3_2")
			end

			if 1.26666666666667 < arg_299_1.time_ and arg_299_1.time_ <= 1.26666666666667 + arg_302_0 then
				local var_302_23 = arg_299_1.bgs_.J22f

				arg_299_1.bgs_.J22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_302_23.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_302_24 = var_302_23:GetComponent("SpriteRenderer")

				if var_302_24 and var_302_24.sprite then
					local var_302_25 = 2 * (var_302_23.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_302_23.transform.localScale = Vector3.New(var_302_25 / var_302_24.sprite.bounds.size.y < var_302_25 * manager.ui.mainCameraCom_.aspect / var_302_24.sprite.bounds.size.x and var_302_25 * manager.ui.mainCameraCom_.aspect / var_302_24.sprite.bounds.size.x or var_302_25 / var_302_24.sprite.bounds.size.y, var_302_25 / var_302_24.sprite.bounds.size.y < var_302_25 * manager.ui.mainCameraCom_.aspect / var_302_24.sprite.bounds.size.x and var_302_25 * manager.ui.mainCameraCom_.aspect / var_302_24.sprite.bounds.size.x or var_302_25 / var_302_24.sprite.bounds.size.y, 0)
				end

				for iter_302_6, iter_302_7 in pairs(arg_299_1.bgs_) do
					if iter_302_6 ~= "J22f" then
						iter_302_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_299_1.frameCnt_ <= 1 then
				arg_299_1.dialog_:SetActive(false)
			end

			local var_302_26 = 2.86666666666667
			local var_302_27 = 0.9

			if 2.86666666666667 < arg_299_1.time_ and arg_299_1.time_ <= var_302_26 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0

				arg_299_1.dialog_:SetActive(true)

				arg_299_1.dialogCg_.alpha = 0

				local var_302_28 = LeanTween.value(arg_299_1.dialog_, 0, 1, 0.3)

				var_302_28:setOnUpdate(LuaHelper.FloatAction(function(arg_303_0)
					arg_299_1.dialogCg_.alpha = arg_303_0
				end))
				var_302_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_299_1.dialog_)
					var_302_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_299_1.duration_ = arg_299_1.duration_ + 0.3

				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_29 = arg_299_1:GetWordFromCfg(325102069)
				local var_302_30 = arg_299_1:FormatText(var_302_29.content)

				arg_299_1.text_.text = var_302_30

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_32 = 36 <= 0 and var_302_27 or var_302_27 * (utf8.len(var_302_30) / 36)

				if (36 <= 0 and var_302_27 or var_302_27 * (utf8.len(var_302_30) / 36)) > 0 and var_302_27 < var_302_32 then
					arg_299_1.talkMaxDuration = var_302_32
					var_302_26 = var_302_26 + 0.3

					if var_302_32 + var_302_26 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_32 + var_302_26
					end
				end

				arg_299_1.text_.text = var_302_30
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102069", "story_v_out_325102.awb") ~= 0 then
					local var_302_33 = manager.audio:GetVoiceLength("story_v_out_325102", "325102069", "story_v_out_325102.awb") / 1000

					if var_302_33 + var_302_26 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_33 + var_302_26
					end

					if var_302_29.prefab_name ~= "" and arg_299_1.actors_[var_302_29.prefab_name] ~= nil then
						local var_302_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_29.prefab_name].transform, "story_v_out_325102", "325102069", "story_v_out_325102.awb")

						arg_299_1:RecordAudio("325102069", var_302_34)
						arg_299_1:RecordAudio("325102069", var_302_34)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_325102", "325102069", "story_v_out_325102.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_325102", "325102069", "story_v_out_325102.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_35 = var_302_26 + 0.3
			local var_302_36 = math.max(var_302_27, arg_299_1.talkMaxDuration)

			if var_302_26 + 0.3 <= arg_299_1.time_ and arg_299_1.time_ < var_302_35 + var_302_36 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_35) / var_302_36

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_35 + var_302_36 and arg_299_1.time_ < var_302_35 + var_302_36 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.64279113151133,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play325102070 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 325102070
		arg_305_1.duration_ = 7.73

		local var_305_0 = {
			zh = 6.866,
			ja = 7.733
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
				arg_305_0:Play325102071(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.825

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:GetWordFromCfg(325102070)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 33 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 33)

				if (33 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 33)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102070", "story_v_out_325102.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102070", "story_v_out_325102.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_out_325102", "325102070", "story_v_out_325102.awb")

						arg_305_1:RecordAudio("325102070", var_308_6)
						arg_305_1:RecordAudio("325102070", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_325102", "325102070", "story_v_out_325102.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_325102", "325102070", "story_v_out_325102.awb")
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
	Play325102071 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 325102071
		arg_309_1.duration_ = 8.83

		local var_309_0 = {
			zh = 4.4,
			ja = 8.833
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
				arg_309_0:Play325102072(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.55

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:GetWordFromCfg(325102071)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 22 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 22)

				if (22 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 22)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102071", "story_v_out_325102.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102071", "story_v_out_325102.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_out_325102", "325102071", "story_v_out_325102.awb")

						arg_309_1:RecordAudio("325102071", var_312_6)
						arg_309_1:RecordAudio("325102071", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_325102", "325102071", "story_v_out_325102.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_325102", "325102071", "story_v_out_325102.awb")
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
	Play325102072 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 325102072
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play325102073(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1059ui_story = arg_313_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1059ui_story"].transform.position).z)
				arg_313_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1059ui_story"].transform.localEulerAngles = arg_313_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1059ui_story"].transform.position).z)
				arg_313_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1059ui_story"].transform.localEulerAngles = arg_313_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1077ui_story"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1077ui_story = var_316_1.localPosition

				local var_316_2 = GameObjectTools.GetOrAddComponent(var_316_1.gameObject, typeof(DynamicBoneHelper))

				if var_316_2 then
					var_316_2:EnableDynamicBone(false)
				end
			end

			local var_316_3 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_3 then
				var_316_1.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_313_1.time_ - 0) / var_316_3)
				var_316_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_1.position).x, (manager.ui.mainCamera.transform.position - var_316_1.position).y, (manager.ui.mainCamera.transform.position - var_316_1.position).z)
				var_316_1.localEulerAngles.z = 0
				var_316_1.localEulerAngles.x = 0
				var_316_1.localEulerAngles = var_316_1.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_3 and arg_313_1.time_ < 0 + var_316_3 + arg_316_0 then
				var_316_1.localPosition = Vector3.New(0, 100, 0)
				var_316_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_1.position).x, (manager.ui.mainCamera.transform.position - var_316_1.position).y, (manager.ui.mainCamera.transform.position - var_316_1.position).z)
				var_316_1.localEulerAngles.z = 0
				var_316_1.localEulerAngles.x = 0
				var_316_1.localEulerAngles = var_316_1.localEulerAngles

				local var_316_4 = GameObjectTools.GetOrAddComponent(var_316_1.gameObject, typeof(DynamicBoneHelper))

				if var_316_4 then
					var_316_4:EnableDynamicBone(true)
				end
			end

			local var_316_5 = arg_313_1.actors_["1077ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1077ui_story == nil then
				arg_313_1.var_.characterEffect1077ui_story = var_316_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_6 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_6 and not isNil(var_316_5) then
				if arg_313_1.var_.characterEffect1077ui_story and not isNil(var_316_5) then
					arg_313_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_6)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_6 and arg_313_1.time_ < 0 + var_316_6 + arg_316_0 and not isNil(var_316_5) and arg_313_1.var_.characterEffect1077ui_story then
				arg_313_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_316_7 = 0
			local var_316_8 = 1.3

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_7 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_9 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(325102072).content)

				arg_313_1.text_.text = var_316_9

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 52 <= 0 and var_316_8 or var_316_8 * (utf8.len(var_316_9) / 52)

				if (52 <= 0 and var_316_8 or var_316_8 * (utf8.len(var_316_9) / 52)) > 0 and var_316_8 < var_316_11 then
					arg_313_1.talkMaxDuration = var_316_11

					if var_316_11 + var_316_7 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_11 + var_316_7
					end
				end

				arg_313_1.text_.text = var_316_9
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_8, arg_313_1.talkMaxDuration)

			if var_316_7 <= arg_313_1.time_ and arg_313_1.time_ < var_316_7 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_7) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_7 + var_316_12 and arg_313_1.time_ < var_316_7 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play325102073 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 325102073
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play325102074(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.675

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(325102073).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 27 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 27)

				if (27 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 27)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play325102074 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 325102074
		arg_321_1.duration_ = 5.43

		local var_321_0 = {
			zh = 3.4,
			ja = 5.433
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
				arg_321_0:Play325102075(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1077ui_story = arg_321_1.actors_["1077ui_story"].transform.localPosition

				local var_324_0 = GameObjectTools.GetOrAddComponent(arg_321_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_324_0 then
					var_324_0:EnableDynamicBone(false)
				end
			end

			local var_324_1 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_1 then
				arg_321_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_321_1.time_ - 0) / var_324_1)
				arg_321_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1077ui_story"].transform.position).z)
				arg_321_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1077ui_story"].transform.localEulerAngles = arg_321_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_1 and arg_321_1.time_ < 0 + var_324_1 + arg_324_0 then
				arg_321_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_321_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1077ui_story"].transform.position).z)
				arg_321_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1077ui_story"].transform.localEulerAngles = arg_321_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_324_2 = GameObjectTools.GetOrAddComponent(arg_321_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_324_2 then
					var_324_2:EnableDynamicBone(true)
				end
			end

			local var_324_3 = arg_321_1.actors_["1077ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_3) and arg_321_1.var_.characterEffect1077ui_story == nil then
				arg_321_1.var_.characterEffect1077ui_story = var_324_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_4 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 and not isNil(var_324_3) then
				if arg_321_1.var_.characterEffect1077ui_story and not isNil(var_324_3) then
					arg_321_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 and not isNil(var_324_3) and arg_321_1.var_.characterEffect1077ui_story then
				arg_321_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_1")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_324_6 = 0
			local var_324_7 = 0.25

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_8 = arg_321_1:GetWordFromCfg(325102074)
				local var_324_9 = arg_321_1:FormatText(var_324_8.content)

				arg_321_1.text_.text = var_324_9

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 10 <= 0 and var_324_7 or var_324_7 * (utf8.len(var_324_9) / 10)

				if (10 <= 0 and var_324_7 or var_324_7 * (utf8.len(var_324_9) / 10)) > 0 and var_324_7 < var_324_11 then
					arg_321_1.talkMaxDuration = var_324_11

					if var_324_11 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_11 + var_324_6
					end
				end

				arg_321_1.text_.text = var_324_9
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102074", "story_v_out_325102.awb") ~= 0 then
					local var_324_12 = manager.audio:GetVoiceLength("story_v_out_325102", "325102074", "story_v_out_325102.awb") / 1000

					if var_324_12 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_12 + var_324_6
					end

					if var_324_8.prefab_name ~= "" and arg_321_1.actors_[var_324_8.prefab_name] ~= nil then
						local var_324_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_8.prefab_name].transform, "story_v_out_325102", "325102074", "story_v_out_325102.awb")

						arg_321_1:RecordAudio("325102074", var_324_13)
						arg_321_1:RecordAudio("325102074", var_324_13)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_325102", "325102074", "story_v_out_325102.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_325102", "325102074", "story_v_out_325102.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_14 = math.max(var_324_7, arg_321_1.talkMaxDuration)

			if var_324_6 <= arg_321_1.time_ and arg_321_1.time_ < var_324_6 + var_324_14 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_6) / var_324_14

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_6 + var_324_14 and arg_321_1.time_ < var_324_6 + var_324_14 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102075 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 325102075
		arg_325_1.duration_ = 11.57

		local var_325_0 = {
			zh = 8.49933333333333,
			ja = 11.5663333333333
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
				arg_325_0:Play325102076(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 1.43333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 1.43333333333333 + arg_328_0 then
				local var_328_0 = arg_325_1.bgs_.J29g

				arg_325_1.bgs_.J29g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_328_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_328_1 = var_328_0:GetComponent("SpriteRenderer")

				if var_328_1 and var_328_1.sprite then
					local var_328_2 = 2 * (var_328_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_328_0.transform.localScale = Vector3.New(var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, 0)
				end

				for iter_328_0, iter_328_1 in pairs(arg_325_1.bgs_) do
					if iter_328_0 ~= "J29g" then
						iter_328_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_328_3 = 1.43333333333333

			arg_325_1.isInRecall_ = false

			if var_328_3 < arg_325_1.time_ and arg_325_1.time_ <= var_328_3 + arg_328_0 then
				arg_325_1.screenFilterGo_:SetActive(true)

				arg_325_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_328_2, iter_328_3 in pairs(arg_325_1.actors_) do
					for iter_328_4, iter_328_5 in ipairs((iter_328_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_328_5.color = iter_328_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_328_4 = 0.034000001847744

			if var_328_3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_3 + var_328_4 then
				arg_325_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_325_1.time_ - var_328_3) / var_328_4)
			end

			if arg_325_1.time_ >= var_328_3 + var_328_4 and arg_325_1.time_ < var_328_3 + var_328_4 + arg_328_0 then
				arg_325_1.screenFilterEffect_.weight = 1
			end

			local var_328_5 = 0

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_6 = 1.43333333333333

			if var_328_5 <= arg_325_1.time_ and arg_325_1.time_ < var_328_5 + var_328_6 then
				local var_328_7 = Color.New(0, 0, 0)

				var_328_7.a = Mathf.Lerp(0, 1, (arg_325_1.time_ - var_328_5) / var_328_6)
				arg_325_1.mask_.color = var_328_7
			end

			if arg_325_1.time_ >= var_328_5 + var_328_6 and arg_325_1.time_ < var_328_5 + var_328_6 + arg_328_0 then
				local var_328_8 = Color.New(0, 0, 0)

				var_328_8.a = 1
				arg_325_1.mask_.color = var_328_8
			end

			local var_328_9 = 1.43333333333333

			if 1.43333333333333 < arg_325_1.time_ and arg_325_1.time_ <= var_328_9 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_10 = 1.4

			if var_328_9 <= arg_325_1.time_ and arg_325_1.time_ < var_328_9 + var_328_10 then
				local var_328_11 = Color.New(0, 0, 0)

				var_328_11.a = Mathf.Lerp(1, 0, (arg_325_1.time_ - var_328_9) / var_328_10)
				arg_325_1.mask_.color = var_328_11
			end

			if arg_325_1.time_ >= var_328_9 + var_328_10 and arg_325_1.time_ < var_328_9 + var_328_10 + arg_328_0 then
				local var_328_12 = Color.New(0, 0, 0)

				arg_325_1.mask_.enabled = false
				var_328_12.a = 0
				arg_325_1.mask_.color = var_328_12
			end

			if 2.53333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 2.53333333333333 + arg_328_0 then
				arg_325_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_328_13 = arg_325_1.actors_["1077ui_story"].transform

			if 2.53333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 2.53333333333333 + arg_328_0 then
				arg_325_1.var_.moveOldPos1077ui_story = var_328_13.localPosition

				local var_328_14 = GameObjectTools.GetOrAddComponent(var_328_13.gameObject, typeof(DynamicBoneHelper))

				if var_328_14 then
					var_328_14:EnableDynamicBone(false)
				end
			end

			local var_328_15 = 0.001

			if 2.53333333333333 <= arg_325_1.time_ and arg_325_1.time_ < 2.53333333333333 + var_328_15 then
				var_328_13.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_325_1.time_ - 2.53333333333333) / var_328_15)
				var_328_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_13.position).x, (manager.ui.mainCamera.transform.position - var_328_13.position).y, (manager.ui.mainCamera.transform.position - var_328_13.position).z)
				var_328_13.localEulerAngles.z = 0
				var_328_13.localEulerAngles.x = 0
				var_328_13.localEulerAngles = var_328_13.localEulerAngles
			end

			if arg_325_1.time_ >= 2.53333333333333 + var_328_15 and arg_325_1.time_ < 2.53333333333333 + var_328_15 + arg_328_0 then
				var_328_13.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_328_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_13.position).x, (manager.ui.mainCamera.transform.position - var_328_13.position).y, (manager.ui.mainCamera.transform.position - var_328_13.position).z)
				var_328_13.localEulerAngles.z = 0
				var_328_13.localEulerAngles.x = 0
				var_328_13.localEulerAngles = var_328_13.localEulerAngles

				local var_328_16 = GameObjectTools.GetOrAddComponent(var_328_13.gameObject, typeof(DynamicBoneHelper))

				if var_328_16 then
					var_328_16:EnableDynamicBone(true)
				end
			end

			local var_328_17 = arg_325_1.actors_["1077ui_story"]

			if 2.53333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 2.53333333333333 + arg_328_0 and not isNil(var_328_17) and arg_325_1.var_.characterEffect1077ui_story == nil then
				arg_325_1.var_.characterEffect1077ui_story = var_328_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_18 = 0.533333333333333

			if 2.53333333333333 <= arg_325_1.time_ and arg_325_1.time_ < 2.53333333333333 + var_328_18 and not isNil(var_328_17) then
				if arg_325_1.var_.characterEffect1077ui_story and not isNil(var_328_17) then
					arg_325_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 2.53333333333333 + var_328_18 and arg_325_1.time_ < 2.53333333333333 + var_328_18 + arg_328_0 and not isNil(var_328_17) and arg_325_1.var_.characterEffect1077ui_story then
				arg_325_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 2.53333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 2.53333333333333 + arg_328_0 then
				arg_325_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			local var_328_20 = arg_325_1.actors_["1077ui_story"]

			if 2.53333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 2.53333333333333 + arg_328_0 and not isNil(var_328_20) and arg_325_1.var_.characterEffect1077ui_story == nil then
				arg_325_1.var_.characterEffect1077ui_story = var_328_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_21 = 0.200000002980232

			if 2.53333333333333 <= arg_325_1.time_ and arg_325_1.time_ < 2.53333333333333 + var_328_21 and not isNil(var_328_20) then
				if arg_325_1.var_.characterEffect1077ui_story and not isNil(var_328_20) then
					arg_325_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 2.53333333333333 + var_328_21 and arg_325_1.time_ < 2.53333333333333 + var_328_21 + arg_328_0 and not isNil(var_328_20) and arg_325_1.var_.characterEffect1077ui_story then
				arg_325_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_328_23 = arg_325_1.actors_["1077ui_story"].transform

			if 1.43333333333333 < arg_325_1.time_ and arg_325_1.time_ <= 1.43333333333333 + arg_328_0 then
				arg_325_1.var_.moveOldPos1077ui_story = var_328_23.localPosition

				local var_328_24 = GameObjectTools.GetOrAddComponent(var_328_23.gameObject, typeof(DynamicBoneHelper))

				if var_328_24 then
					var_328_24:EnableDynamicBone(false)
				end
			end

			local var_328_25 = 0.001

			if 1.43333333333333 <= arg_325_1.time_ and arg_325_1.time_ < 1.43333333333333 + var_328_25 then
				var_328_23.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_325_1.time_ - 1.43333333333333) / var_328_25)
				var_328_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_23.position).x, (manager.ui.mainCamera.transform.position - var_328_23.position).y, (manager.ui.mainCamera.transform.position - var_328_23.position).z)
				var_328_23.localEulerAngles.z = 0
				var_328_23.localEulerAngles.x = 0
				var_328_23.localEulerAngles = var_328_23.localEulerAngles
			end

			if arg_325_1.time_ >= 1.43333333333333 + var_328_25 and arg_325_1.time_ < 1.43333333333333 + var_328_25 + arg_328_0 then
				var_328_23.localPosition = Vector3.New(0, 100, 0)
				var_328_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_23.position).x, (manager.ui.mainCamera.transform.position - var_328_23.position).y, (manager.ui.mainCamera.transform.position - var_328_23.position).z)
				var_328_23.localEulerAngles.z = 0
				var_328_23.localEulerAngles.x = 0
				var_328_23.localEulerAngles = var_328_23.localEulerAngles

				local var_328_26 = GameObjectTools.GetOrAddComponent(var_328_23.gameObject, typeof(DynamicBoneHelper))

				if var_328_26 then
					var_328_26:EnableDynamicBone(true)
				end
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_27 = 2.83333333333333
			local var_328_28 = 0.775

			if 2.83333333333333 < arg_325_1.time_ and arg_325_1.time_ <= var_328_27 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_29 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_29:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_30 = arg_325_1:GetWordFromCfg(325102075)
				local var_328_31 = arg_325_1:FormatText(var_328_30.content)

				arg_325_1.text_.text = var_328_31

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_33 = 31 <= 0 and var_328_28 or var_328_28 * (utf8.len(var_328_31) / 31)

				if (31 <= 0 and var_328_28 or var_328_28 * (utf8.len(var_328_31) / 31)) > 0 and var_328_28 < var_328_33 then
					arg_325_1.talkMaxDuration = var_328_33
					var_328_27 = var_328_27 + 0.3

					if var_328_33 + var_328_27 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_33 + var_328_27
					end
				end

				arg_325_1.text_.text = var_328_31
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102075", "story_v_out_325102.awb") ~= 0 then
					local var_328_34 = manager.audio:GetVoiceLength("story_v_out_325102", "325102075", "story_v_out_325102.awb") / 1000

					if var_328_34 + var_328_27 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_34 + var_328_27
					end

					if var_328_30.prefab_name ~= "" and arg_325_1.actors_[var_328_30.prefab_name] ~= nil then
						local var_328_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_30.prefab_name].transform, "story_v_out_325102", "325102075", "story_v_out_325102.awb")

						arg_325_1:RecordAudio("325102075", var_328_35)
						arg_325_1:RecordAudio("325102075", var_328_35)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_325102", "325102075", "story_v_out_325102.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_325102", "325102075", "story_v_out_325102.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_36 = var_328_27 + 0.3
			local var_328_37 = math.max(var_328_28, arg_325_1.talkMaxDuration)

			if var_328_27 + 0.3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_36 + var_328_37 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_36) / var_328_37

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_36 + var_328_37 and arg_325_1.time_ < var_328_36 + var_328_37 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play325102076 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 325102076
		arg_331_1.duration_ = 6.93

		local var_331_0 = {
			zh = 4.733,
			ja = 6.933
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
				arg_331_0:Play325102077(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1059ui_story"]) and arg_331_1.var_.characterEffect1059ui_story == nil then
				arg_331_1.var_.characterEffect1059ui_story = arg_331_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1059ui_story"]) then
				if arg_331_1.var_.characterEffect1059ui_story and not isNil(arg_331_1.actors_["1059ui_story"]) then
					arg_331_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1059ui_story"]) and arg_331_1.var_.characterEffect1059ui_story then
				arg_331_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_334_2 = arg_331_1.actors_["1077ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_2) and arg_331_1.var_.characterEffect1077ui_story == nil then
				arg_331_1.var_.characterEffect1077ui_story = var_334_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_3 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_3 and not isNil(var_334_2) then
				if arg_331_1.var_.characterEffect1077ui_story and not isNil(var_334_2) then
					arg_331_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_3)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_3 and arg_331_1.time_ < 0 + var_334_3 + arg_334_0 and not isNil(var_334_2) and arg_331_1.var_.characterEffect1077ui_story then
				arg_331_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_334_4 = 0
			local var_334_5 = 0.55

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_331_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_334_6 = arg_331_1:GetWordFromCfg(325102076)
				local var_334_7 = arg_331_1:FormatText(var_334_6.content)

				arg_331_1.text_.text = var_334_7

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_9 = 22 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 22)

				if (22 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 22)) > 0 and var_334_5 < var_334_9 then
					arg_331_1.talkMaxDuration = var_334_9

					if var_334_9 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_9 + var_334_4
					end
				end

				arg_331_1.text_.text = var_334_7
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102076", "story_v_out_325102.awb") ~= 0 then
					local var_334_10 = manager.audio:GetVoiceLength("story_v_out_325102", "325102076", "story_v_out_325102.awb") / 1000

					if var_334_10 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_10 + var_334_4
					end

					if var_334_6.prefab_name ~= "" and arg_331_1.actors_[var_334_6.prefab_name] ~= nil then
						local var_334_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_6.prefab_name].transform, "story_v_out_325102", "325102076", "story_v_out_325102.awb")

						arg_331_1:RecordAudio("325102076", var_334_11)
						arg_331_1:RecordAudio("325102076", var_334_11)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_325102", "325102076", "story_v_out_325102.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_325102", "325102076", "story_v_out_325102.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_12 = math.max(var_334_5, arg_331_1.talkMaxDuration)

			if var_334_4 <= arg_331_1.time_ and arg_331_1.time_ < var_334_4 + var_334_12 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_4) / var_334_12

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_4 + var_334_12 and arg_331_1.time_ < var_334_4 + var_334_12 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play325102077 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 325102077
		arg_335_1.duration_ = 16.97

		local var_335_0 = {
			zh = 11.2,
			ja = 16.966
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
				arg_335_0:Play325102078(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 1.375

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1455].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3056")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_335_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_338_1 = arg_335_1:GetWordFromCfg(325102077)
				local var_338_2 = arg_335_1:FormatText(var_338_1.content)

				arg_335_1.text_.text = var_338_2

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_4 = 55 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 55)

				if (55 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 55)) > 0 and var_338_0 < var_338_4 then
					arg_335_1.talkMaxDuration = var_338_4

					if var_338_4 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_4 + 0
					end
				end

				arg_335_1.text_.text = var_338_2
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102077", "story_v_out_325102.awb") ~= 0 then
					local var_338_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102077", "story_v_out_325102.awb") / 1000

					if var_338_5 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + 0
					end

					if var_338_1.prefab_name ~= "" and arg_335_1.actors_[var_338_1.prefab_name] ~= nil then
						local var_338_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_1.prefab_name].transform, "story_v_out_325102", "325102077", "story_v_out_325102.awb")

						arg_335_1:RecordAudio("325102077", var_338_6)
						arg_335_1:RecordAudio("325102077", var_338_6)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_325102", "325102077", "story_v_out_325102.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_325102", "325102077", "story_v_out_325102.awb")
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
	Play325102078 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 325102078
		arg_339_1.duration_ = 7.17

		local var_339_0 = {
			zh = 6.93333333631356,
			ja = 7.16633333631357
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
				arg_339_0:Play325102079(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 1.26666666666667 < arg_339_1.time_ and arg_339_1.time_ <= 1.26666666666667 + arg_342_0 then
				local var_342_0 = arg_339_1.bgs_.J22f

				arg_339_1.bgs_.J22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_342_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_342_1 = var_342_0:GetComponent("SpriteRenderer")

				if var_342_1 and var_342_1.sprite then
					local var_342_2 = 2 * (var_342_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_342_0.transform.localScale = Vector3.New(var_342_2 / var_342_1.sprite.bounds.size.y < var_342_2 * manager.ui.mainCameraCom_.aspect / var_342_1.sprite.bounds.size.x and var_342_2 * manager.ui.mainCameraCom_.aspect / var_342_1.sprite.bounds.size.x or var_342_2 / var_342_1.sprite.bounds.size.y, var_342_2 / var_342_1.sprite.bounds.size.y < var_342_2 * manager.ui.mainCameraCom_.aspect / var_342_1.sprite.bounds.size.x and var_342_2 * manager.ui.mainCameraCom_.aspect / var_342_1.sprite.bounds.size.x or var_342_2 / var_342_1.sprite.bounds.size.y, 0)
				end

				for iter_342_0, iter_342_1 in pairs(arg_339_1.bgs_) do
					if iter_342_0 ~= "J22f" then
						iter_342_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_342_3 = arg_339_1.actors_["1077ui_story"]

			if 2.63333333333333 < arg_339_1.time_ and arg_339_1.time_ <= 2.63333333333333 + arg_342_0 and not isNil(var_342_3) and arg_339_1.var_.characterEffect1077ui_story == nil then
				arg_339_1.var_.characterEffect1077ui_story = var_342_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_4 = 0.200000002980232

			if 2.63333333333333 <= arg_339_1.time_ and arg_339_1.time_ < 2.63333333333333 + var_342_4 and not isNil(var_342_3) then
				if arg_339_1.var_.characterEffect1077ui_story and not isNil(var_342_3) then
					arg_339_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 2.63333333333333 + var_342_4 and arg_339_1.time_ < 2.63333333333333 + var_342_4 + arg_342_0 and not isNil(var_342_3) and arg_339_1.var_.characterEffect1077ui_story then
				arg_339_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_342_6 = 0

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_6 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_7 = 1.26666666666667

			if var_342_6 <= arg_339_1.time_ and arg_339_1.time_ < var_342_6 + var_342_7 then
				local var_342_8 = Color.New(0, 0, 0)

				var_342_8.a = Mathf.Lerp(0, 1, (arg_339_1.time_ - var_342_6) / var_342_7)
				arg_339_1.mask_.color = var_342_8
			end

			if arg_339_1.time_ >= var_342_6 + var_342_7 and arg_339_1.time_ < var_342_6 + var_342_7 + arg_342_0 then
				local var_342_9 = Color.New(0, 0, 0)

				var_342_9.a = 1
				arg_339_1.mask_.color = var_342_9
			end

			local var_342_10 = 1.26666666666667

			if 1.26666666666667 < arg_339_1.time_ and arg_339_1.time_ <= var_342_10 + arg_342_0 then
				arg_339_1.mask_.enabled = true
				arg_339_1.mask_.raycastTarget = true

				arg_339_1:SetGaussion(false)
			end

			local var_342_11 = 1.73333333333333

			if var_342_10 <= arg_339_1.time_ and arg_339_1.time_ < var_342_10 + var_342_11 then
				local var_342_12 = Color.New(0, 0, 0)

				var_342_12.a = Mathf.Lerp(1, 0, (arg_339_1.time_ - var_342_10) / var_342_11)
				arg_339_1.mask_.color = var_342_12
			end

			if arg_339_1.time_ >= var_342_10 + var_342_11 and arg_339_1.time_ < var_342_10 + var_342_11 + arg_342_0 then
				local var_342_13 = Color.New(0, 0, 0)

				arg_339_1.mask_.enabled = false
				var_342_13.a = 0
				arg_339_1.mask_.color = var_342_13
			end

			local var_342_14 = arg_339_1.actors_["1077ui_story"].transform

			if 2.63333333333333 < arg_339_1.time_ and arg_339_1.time_ <= 2.63333333333333 + arg_342_0 then
				arg_339_1.var_.moveOldPos1077ui_story = var_342_14.localPosition

				local var_342_15 = GameObjectTools.GetOrAddComponent(var_342_14.gameObject, typeof(DynamicBoneHelper))

				if var_342_15 then
					var_342_15:EnableDynamicBone(false)
				end
			end

			local var_342_16 = 0.001

			if 2.63333333333333 <= arg_339_1.time_ and arg_339_1.time_ < 2.63333333333333 + var_342_16 then
				var_342_14.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_339_1.time_ - 2.63333333333333) / var_342_16)
				var_342_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_14.position).x, (manager.ui.mainCamera.transform.position - var_342_14.position).y, (manager.ui.mainCamera.transform.position - var_342_14.position).z)
				var_342_14.localEulerAngles.z = 0
				var_342_14.localEulerAngles.x = 0
				var_342_14.localEulerAngles = var_342_14.localEulerAngles
			end

			if arg_339_1.time_ >= 2.63333333333333 + var_342_16 and arg_339_1.time_ < 2.63333333333333 + var_342_16 + arg_342_0 then
				var_342_14.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				var_342_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_14.position).x, (manager.ui.mainCamera.transform.position - var_342_14.position).y, (manager.ui.mainCamera.transform.position - var_342_14.position).z)
				var_342_14.localEulerAngles.z = 0
				var_342_14.localEulerAngles.x = 0
				var_342_14.localEulerAngles = var_342_14.localEulerAngles

				local var_342_17 = GameObjectTools.GetOrAddComponent(var_342_14.gameObject, typeof(DynamicBoneHelper))

				if var_342_17 then
					var_342_17:EnableDynamicBone(true)
				end
			end

			local var_342_18 = arg_339_1.actors_["1077ui_story"]

			if 2.63333333333333 < arg_339_1.time_ and arg_339_1.time_ <= 2.63333333333333 + arg_342_0 and not isNil(var_342_18) and arg_339_1.var_.characterEffect1077ui_story == nil then
				arg_339_1.var_.characterEffect1077ui_story = var_342_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_19 = 0.55

			if 2.63333333333333 <= arg_339_1.time_ and arg_339_1.time_ < 2.63333333333333 + var_342_19 and not isNil(var_342_18) then
				if arg_339_1.var_.characterEffect1077ui_story and not isNil(var_342_18) then
					arg_339_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 2.63333333333333 + var_342_19 and arg_339_1.time_ < 2.63333333333333 + var_342_19 + arg_342_0 and not isNil(var_342_18) and arg_339_1.var_.characterEffect1077ui_story then
				arg_339_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			local var_342_21 = 1.26666666666667

			arg_339_1.isInRecall_ = false

			if var_342_21 < arg_339_1.time_ and arg_339_1.time_ <= var_342_21 + arg_342_0 then
				arg_339_1.screenFilterGo_:SetActive(false)

				for iter_342_2, iter_342_3 in pairs(arg_339_1.actors_) do
					for iter_342_4, iter_342_5 in ipairs((iter_342_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_342_5.color = iter_342_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_342_22 = 0.034000001847744

			if var_342_21 <= arg_339_1.time_ and arg_339_1.time_ < var_342_21 + var_342_22 then
				arg_339_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_339_1.time_ - var_342_21) / var_342_22)
			end

			if arg_339_1.time_ >= var_342_21 + var_342_22 and arg_339_1.time_ < var_342_21 + var_342_22 + arg_342_0 then
				arg_339_1.screenFilterEffect_.weight = 0
			end

			if 2.63333333333333 < arg_339_1.time_ and arg_339_1.time_ <= 2.63333333333333 + arg_342_0 then
				arg_339_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action6_2")
			end

			local var_342_23 = arg_339_1.actors_["1077ui_story"].transform

			if 1.26666666666667 < arg_339_1.time_ and arg_339_1.time_ <= 1.26666666666667 + arg_342_0 then
				arg_339_1.var_.moveOldPos1077ui_story = var_342_23.localPosition

				local var_342_24 = GameObjectTools.GetOrAddComponent(var_342_23.gameObject, typeof(DynamicBoneHelper))

				if var_342_24 then
					var_342_24:EnableDynamicBone(false)
				end
			end

			local var_342_25 = 0.001

			if 1.26666666666667 <= arg_339_1.time_ and arg_339_1.time_ < 1.26666666666667 + var_342_25 then
				var_342_23.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_339_1.time_ - 1.26666666666667) / var_342_25)
				var_342_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_23.position).x, (manager.ui.mainCamera.transform.position - var_342_23.position).y, (manager.ui.mainCamera.transform.position - var_342_23.position).z)
				var_342_23.localEulerAngles.z = 0
				var_342_23.localEulerAngles.x = 0
				var_342_23.localEulerAngles = var_342_23.localEulerAngles
			end

			if arg_339_1.time_ >= 1.26666666666667 + var_342_25 and arg_339_1.time_ < 1.26666666666667 + var_342_25 + arg_342_0 then
				var_342_23.localPosition = Vector3.New(0, 100, 0)
				var_342_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_23.position).x, (manager.ui.mainCamera.transform.position - var_342_23.position).y, (manager.ui.mainCamera.transform.position - var_342_23.position).z)
				var_342_23.localEulerAngles.z = 0
				var_342_23.localEulerAngles.x = 0
				var_342_23.localEulerAngles = var_342_23.localEulerAngles

				local var_342_26 = GameObjectTools.GetOrAddComponent(var_342_23.gameObject, typeof(DynamicBoneHelper))

				if var_342_26 then
					var_342_26:EnableDynamicBone(true)
				end
			end

			if arg_339_1.frameCnt_ <= 1 then
				arg_339_1.dialog_:SetActive(false)
			end

			local var_342_27 = 2.83333333631357
			local var_342_28 = 0.45

			if 2.83333333631357 < arg_339_1.time_ and arg_339_1.time_ <= var_342_27 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0

				arg_339_1.dialog_:SetActive(true)

				arg_339_1.dialogCg_.alpha = 0

				local var_342_29 = LeanTween.value(arg_339_1.dialog_, 0, 1, 0.3)

				var_342_29:setOnUpdate(LuaHelper.FloatAction(function(arg_343_0)
					arg_339_1.dialogCg_.alpha = arg_343_0
				end))
				var_342_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_339_1.dialog_)
					var_342_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_339_1.duration_ = arg_339_1.duration_ + 0.3

				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_30 = arg_339_1:GetWordFromCfg(325102078)
				local var_342_31 = arg_339_1:FormatText(var_342_30.content)

				arg_339_1.text_.text = var_342_31

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_33 = 18 <= 0 and var_342_28 or var_342_28 * (utf8.len(var_342_31) / 18)

				if (18 <= 0 and var_342_28 or var_342_28 * (utf8.len(var_342_31) / 18)) > 0 and var_342_28 < var_342_33 then
					arg_339_1.talkMaxDuration = var_342_33
					var_342_27 = var_342_27 + 0.3

					if var_342_33 + var_342_27 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_33 + var_342_27
					end
				end

				arg_339_1.text_.text = var_342_31
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102078", "story_v_out_325102.awb") ~= 0 then
					local var_342_34 = manager.audio:GetVoiceLength("story_v_out_325102", "325102078", "story_v_out_325102.awb") / 1000

					if var_342_34 + var_342_27 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_34 + var_342_27
					end

					if var_342_30.prefab_name ~= "" and arg_339_1.actors_[var_342_30.prefab_name] ~= nil then
						local var_342_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_30.prefab_name].transform, "story_v_out_325102", "325102078", "story_v_out_325102.awb")

						arg_339_1:RecordAudio("325102078", var_342_35)
						arg_339_1:RecordAudio("325102078", var_342_35)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_325102", "325102078", "story_v_out_325102.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_325102", "325102078", "story_v_out_325102.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_36 = var_342_27 + 0.3
			local var_342_37 = math.max(var_342_28, arg_339_1.talkMaxDuration)

			if var_342_27 + 0.3 <= arg_339_1.time_ and arg_339_1.time_ < var_342_36 + var_342_37 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_36) / var_342_37

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_36 + var_342_37 and arg_339_1.time_ < var_342_36 + var_342_37 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.26666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play325102079 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 325102079
		arg_345_1.duration_ = 11.3

		local var_345_0 = {
			zh = 11.3,
			ja = 11
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
				arg_345_0:Play325102080(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0.975

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_1 = arg_345_1:GetWordFromCfg(325102079)
				local var_348_2 = arg_345_1:FormatText(var_348_1.content)

				arg_345_1.text_.text = var_348_2

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_4 = 39 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 39)

				if (39 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 39)) > 0 and var_348_0 < var_348_4 then
					arg_345_1.talkMaxDuration = var_348_4

					if var_348_4 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_4 + 0
					end
				end

				arg_345_1.text_.text = var_348_2
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102079", "story_v_out_325102.awb") ~= 0 then
					local var_348_5 = manager.audio:GetVoiceLength("story_v_out_325102", "325102079", "story_v_out_325102.awb") / 1000

					if var_348_5 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + 0
					end

					if var_348_1.prefab_name ~= "" and arg_345_1.actors_[var_348_1.prefab_name] ~= nil then
						local var_348_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_1.prefab_name].transform, "story_v_out_325102", "325102079", "story_v_out_325102.awb")

						arg_345_1:RecordAudio("325102079", var_348_6)
						arg_345_1:RecordAudio("325102079", var_348_6)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_325102", "325102079", "story_v_out_325102.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_325102", "325102079", "story_v_out_325102.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_7 and arg_345_1.time_ < 0 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play325102080 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 325102080
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play325102081(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1059ui_story = arg_349_1.actors_["1059ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1059ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1059ui_story"].transform.position).z)
				arg_349_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1059ui_story"].transform.localEulerAngles = arg_349_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1059ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_349_1.actors_["1059ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1059ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1059ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1059ui_story"].transform.position).z)
				arg_349_1.actors_["1059ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1059ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1059ui_story"].transform.localEulerAngles = arg_349_1.actors_["1059ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["1077ui_story"].transform

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1077ui_story = var_352_1.localPosition

				local var_352_2 = GameObjectTools.GetOrAddComponent(var_352_1.gameObject, typeof(DynamicBoneHelper))

				if var_352_2 then
					var_352_2:EnableDynamicBone(false)
				end
			end

			local var_352_3 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_3 then
				var_352_1.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_349_1.time_ - 0) / var_352_3)
				var_352_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_1.position).x, (manager.ui.mainCamera.transform.position - var_352_1.position).y, (manager.ui.mainCamera.transform.position - var_352_1.position).z)
				var_352_1.localEulerAngles.z = 0
				var_352_1.localEulerAngles.x = 0
				var_352_1.localEulerAngles = var_352_1.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_3 and arg_349_1.time_ < 0 + var_352_3 + arg_352_0 then
				var_352_1.localPosition = Vector3.New(0, 100, 0)
				var_352_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_352_1.position).x, (manager.ui.mainCamera.transform.position - var_352_1.position).y, (manager.ui.mainCamera.transform.position - var_352_1.position).z)
				var_352_1.localEulerAngles.z = 0
				var_352_1.localEulerAngles.x = 0
				var_352_1.localEulerAngles = var_352_1.localEulerAngles

				local var_352_4 = GameObjectTools.GetOrAddComponent(var_352_1.gameObject, typeof(DynamicBoneHelper))

				if var_352_4 then
					var_352_4:EnableDynamicBone(true)
				end
			end

			local var_352_5 = arg_349_1.actors_["1077ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.characterEffect1077ui_story == nil then
				arg_349_1.var_.characterEffect1077ui_story = var_352_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_6 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_6 and not isNil(var_352_5) then
				if arg_349_1.var_.characterEffect1077ui_story and not isNil(var_352_5) then
					arg_349_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_6)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_6 and arg_349_1.time_ < 0 + var_352_6 + arg_352_0 and not isNil(var_352_5) and arg_349_1.var_.characterEffect1077ui_story then
				arg_349_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_352_7 = 0
			local var_352_8 = 1.075

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_7 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_9 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(325102080).content)

				arg_349_1.text_.text = var_352_9

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 43 <= 0 and var_352_8 or var_352_8 * (utf8.len(var_352_9) / 43)

				if (43 <= 0 and var_352_8 or var_352_8 * (utf8.len(var_352_9) / 43)) > 0 and var_352_8 < var_352_11 then
					arg_349_1.talkMaxDuration = var_352_11

					if var_352_11 + var_352_7 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_11 + var_352_7
					end
				end

				arg_349_1.text_.text = var_352_9
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_12 = math.max(var_352_8, arg_349_1.talkMaxDuration)

			if var_352_7 <= arg_349_1.time_ and arg_349_1.time_ < var_352_7 + var_352_12 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_7) / var_352_12

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_7 + var_352_12 and arg_349_1.time_ < var_352_7 + var_352_12 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	Play325102081 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 325102081
		arg_353_1.duration_ = 5.47

		local var_353_0 = {
			zh = 4.133,
			ja = 5.466
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play325102082(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1077ui_story = arg_353_1.actors_["1077ui_story"].transform.localPosition

				local var_356_0 = GameObjectTools.GetOrAddComponent(arg_353_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_356_0 then
					var_356_0:EnableDynamicBone(false)
				end
			end

			local var_356_1 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_1 then
				arg_353_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_353_1.time_ - 0) / var_356_1)
				arg_353_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1077ui_story"].transform.position).z)
				arg_353_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1077ui_story"].transform.localEulerAngles = arg_353_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_1 and arg_353_1.time_ < 0 + var_356_1 + arg_356_0 then
				arg_353_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_353_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1077ui_story"].transform.position).z)
				arg_353_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1077ui_story"].transform.localEulerAngles = arg_353_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_356_2 = GameObjectTools.GetOrAddComponent(arg_353_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_356_2 then
					var_356_2:EnableDynamicBone(true)
				end
			end

			local var_356_3 = arg_353_1.actors_["1077ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_3) and arg_353_1.var_.characterEffect1077ui_story == nil then
				arg_353_1.var_.characterEffect1077ui_story = var_356_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_4 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 and not isNil(var_356_3) then
				if arg_353_1.var_.characterEffect1077ui_story and not isNil(var_356_3) then
					arg_353_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 and not isNil(var_356_3) and arg_353_1.var_.characterEffect1077ui_story then
				arg_353_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/story1077/story1077action/1077action1_1")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1077ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_356_6 = 0
			local var_356_7 = 0.625

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_6 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_8 = arg_353_1:GetWordFromCfg(325102081)
				local var_356_9 = arg_353_1:FormatText(var_356_8.content)

				arg_353_1.text_.text = var_356_9

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_11 = 25 <= 0 and var_356_7 or var_356_7 * (utf8.len(var_356_9) / 25)

				if (25 <= 0 and var_356_7 or var_356_7 * (utf8.len(var_356_9) / 25)) > 0 and var_356_7 < var_356_11 then
					arg_353_1.talkMaxDuration = var_356_11

					if var_356_11 + var_356_6 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_11 + var_356_6
					end
				end

				arg_353_1.text_.text = var_356_9
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102081", "story_v_out_325102.awb") ~= 0 then
					local var_356_12 = manager.audio:GetVoiceLength("story_v_out_325102", "325102081", "story_v_out_325102.awb") / 1000

					if var_356_12 + var_356_6 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_12 + var_356_6
					end

					if var_356_8.prefab_name ~= "" and arg_353_1.actors_[var_356_8.prefab_name] ~= nil then
						local var_356_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_8.prefab_name].transform, "story_v_out_325102", "325102081", "story_v_out_325102.awb")

						arg_353_1:RecordAudio("325102081", var_356_13)
						arg_353_1:RecordAudio("325102081", var_356_13)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_325102", "325102081", "story_v_out_325102.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_325102", "325102081", "story_v_out_325102.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_14 = math.max(var_356_7, arg_353_1.talkMaxDuration)

			if var_356_6 <= arg_353_1.time_ and arg_353_1.time_ < var_356_6 + var_356_14 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_6) / var_356_14

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_6 + var_356_14 and arg_353_1.time_ < var_356_6 + var_356_14 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play325102082 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 325102082
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play325102083(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1077ui_story = arg_357_1.actors_["1077ui_story"].transform.localPosition

				local var_360_0 = GameObjectTools.GetOrAddComponent(arg_357_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_360_0 then
					var_360_0:EnableDynamicBone(false)
				end
			end

			local var_360_1 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_1 then
				arg_357_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1077ui_story, Vector3.New(0, 100, 0), (arg_357_1.time_ - 0) / var_360_1)
				arg_357_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1077ui_story"].transform.position).z)
				arg_357_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1077ui_story"].transform.localEulerAngles = arg_357_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_1 and arg_357_1.time_ < 0 + var_360_1 + arg_360_0 then
				arg_357_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_357_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1077ui_story"].transform.position).z)
				arg_357_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1077ui_story"].transform.localEulerAngles = arg_357_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_360_2 = GameObjectTools.GetOrAddComponent(arg_357_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_360_2 then
					var_360_2:EnableDynamicBone(true)
				end
			end

			local var_360_3 = arg_357_1.actors_["1077ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_3) and arg_357_1.var_.characterEffect1077ui_story == nil then
				arg_357_1.var_.characterEffect1077ui_story = var_360_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_4 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 and not isNil(var_360_3) then
				if arg_357_1.var_.characterEffect1077ui_story and not isNil(var_360_3) then
					arg_357_1.var_.characterEffect1077ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_4)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 and not isNil(var_360_3) and arg_357_1.var_.characterEffect1077ui_story then
				arg_357_1.var_.characterEffect1077ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1077ui_story.fillRatio = 0.5
			end

			local var_360_5 = 0
			local var_360_6 = 0.725

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_7 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(325102082).content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 29 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_7) / 29)

				if (29 <= 0 and var_360_6 or var_360_6 * (utf8.len(var_360_7) / 29)) > 0 and var_360_6 < var_360_9 then
					arg_357_1.talkMaxDuration = var_360_9

					if var_360_9 + var_360_5 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_9 + var_360_5
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_10 = math.max(var_360_6, arg_357_1.talkMaxDuration)

			if var_360_5 <= arg_357_1.time_ and arg_357_1.time_ < var_360_5 + var_360_10 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_5) / var_360_10

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_5 + var_360_10 and arg_357_1.time_ < var_360_5 + var_360_10 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play325102083 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 325102083
		arg_361_1.duration_ = 5.73

		local var_361_0 = {
			zh = 5.733,
			ja = 4.566
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
			arg_361_1.auto_ = false
		end

		function arg_361_1.playNext_(arg_363_0)
			arg_361_1.onStoryFinished_()
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1077ui_story = arg_361_1.actors_["1077ui_story"].transform.localPosition

				local var_364_0 = GameObjectTools.GetOrAddComponent(arg_361_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_364_0 then
					var_364_0:EnableDynamicBone(false)
				end
			end

			local var_364_1 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_1 then
				arg_361_1.actors_["1077ui_story"].transform.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1077ui_story, Vector3.New(-0.03, -1.02, -5.92), (arg_361_1.time_ - 0) / var_364_1)
				arg_361_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1077ui_story"].transform.position).z)
				arg_361_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1077ui_story"].transform.localEulerAngles = arg_361_1.actors_["1077ui_story"].transform.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_1 and arg_361_1.time_ < 0 + var_364_1 + arg_364_0 then
				arg_361_1.actors_["1077ui_story"].transform.localPosition = Vector3.New(-0.03, -1.02, -5.92)
				arg_361_1.actors_["1077ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_361_1.actors_["1077ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1077ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_361_1.actors_["1077ui_story"].transform.position).z)
				arg_361_1.actors_["1077ui_story"].transform.localEulerAngles.z = 0
				arg_361_1.actors_["1077ui_story"].transform.localEulerAngles.x = 0
				arg_361_1.actors_["1077ui_story"].transform.localEulerAngles = arg_361_1.actors_["1077ui_story"].transform.localEulerAngles

				local var_364_2 = GameObjectTools.GetOrAddComponent(arg_361_1.actors_["1077ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_364_2 then
					var_364_2:EnableDynamicBone(true)
				end
			end

			local var_364_3 = arg_361_1.actors_["1077ui_story"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_3) and arg_361_1.var_.characterEffect1077ui_story == nil then
				arg_361_1.var_.characterEffect1077ui_story = var_364_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_4 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 and not isNil(var_364_3) then
				if arg_361_1.var_.characterEffect1077ui_story and not isNil(var_364_3) then
					arg_361_1.var_.characterEffect1077ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 and not isNil(var_364_3) and arg_361_1.var_.characterEffect1077ui_story then
				arg_361_1.var_.characterEffect1077ui_story.fillFlat = false
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_364_7 = 0
			local var_364_8 = 0.525

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_7 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_9 = arg_361_1:GetWordFromCfg(325102083)
				local var_364_10 = arg_361_1:FormatText(var_364_9.content)

				arg_361_1.text_.text = var_364_10

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_12 = 21 <= 0 and var_364_8 or var_364_8 * (utf8.len(var_364_10) / 21)

				if (21 <= 0 and var_364_8 or var_364_8 * (utf8.len(var_364_10) / 21)) > 0 and var_364_8 < var_364_12 then
					arg_361_1.talkMaxDuration = var_364_12

					if var_364_12 + var_364_7 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_12 + var_364_7
					end
				end

				arg_361_1.text_.text = var_364_10
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325102", "325102083", "story_v_out_325102.awb") ~= 0 then
					local var_364_13 = manager.audio:GetVoiceLength("story_v_out_325102", "325102083", "story_v_out_325102.awb") / 1000

					if var_364_13 + var_364_7 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_13 + var_364_7
					end

					if var_364_9.prefab_name ~= "" and arg_361_1.actors_[var_364_9.prefab_name] ~= nil then
						local var_364_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_9.prefab_name].transform, "story_v_out_325102", "325102083", "story_v_out_325102.awb")

						arg_361_1:RecordAudio("325102083", var_364_14)
						arg_361_1:RecordAudio("325102083", var_364_14)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_325102", "325102083", "story_v_out_325102.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_325102", "325102083", "story_v_out_325102.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_15 = math.max(var_364_8, arg_361_1.talkMaxDuration)

			if var_364_7 <= arg_361_1.time_ and arg_361_1.time_ < var_364_7 + var_364_15 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_7) / var_364_15

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_7 + var_364_15 and arg_361_1.time_ < var_364_7 + var_364_15 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1077ui_story",
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
	assets = {
		"TextureConfig/Background/J29g",
		"TextureConfig/Background/J22f",
		"TextureConfig/Background/J03h"
	},
	voices = {
		"story_v_out_325102.awb"
	}
}
