return {
	Play1109402001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109402001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1109402002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST03 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_4_0.name = "ST03"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST03 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_1 = arg_1_1.bgs_.ST03

				arg_1_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST03" then
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

			if 1.875 < arg_1_1.time_ and arg_1_1.time_ <= 1.875 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_crowd", "se_story_v1_environment_crowd", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 1.575 < arg_1_1.time_ and arg_1_1.time_ <= 1.575 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = 2
			local var_4_16 = 0.575

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

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1109402001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 23 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 23)

				if (23 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 23)) > 0 and var_4_16 < var_4_20 then
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
	Play1109402002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109402002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1109402003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.6

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1109402002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 24 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 24)

				if (24 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 24)) > 0 and var_12_0 < var_12_3 then
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
	Play1109402003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109402003
		arg_13_1.duration_ = 6.4

		local var_13_0 = {
			ja = 6.4,
			ko = 5.966,
			zh = 5.966
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
				arg_13_0:Play1109402004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.9

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[23].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(1109402003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 36 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 36)

				if (36 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 36)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402003", "story_v_side_new_1109402.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402003", "story_v_side_new_1109402.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_side_new_1109402", "1109402003", "story_v_side_new_1109402.awb")

						arg_13_1:RecordAudio("1109402003", var_16_6)
						arg_13_1:RecordAudio("1109402003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402003", "story_v_side_new_1109402.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402003", "story_v_side_new_1109402.awb")
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
	Play1109402004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109402004
		arg_17_1.duration_ = 7.53

		local var_17_0 = {
			ja = 4.966,
			ko = 7.533,
			zh = 7.533
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
				arg_17_0:Play1109402005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.1

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[25].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(1109402004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 44 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 44)

				if (44 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 44)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402004", "story_v_side_new_1109402.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402004", "story_v_side_new_1109402.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_side_new_1109402", "1109402004", "story_v_side_new_1109402.awb")

						arg_17_1:RecordAudio("1109402004", var_20_6)
						arg_17_1:RecordAudio("1109402004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402004", "story_v_side_new_1109402.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402004", "story_v_side_new_1109402.awb")
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
	Play1109402005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109402005
		arg_21_1.duration_ = 5.47

		local var_21_0 = {
			ja = 5.466,
			ko = 4.833,
			zh = 4.833
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
				arg_21_0:Play1109402006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.7

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[26].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentm")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(1109402005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 28 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 28)

				if (28 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 28)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402005", "story_v_side_new_1109402.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402005", "story_v_side_new_1109402.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_side_new_1109402", "1109402005", "story_v_side_new_1109402.awb")

						arg_21_1:RecordAudio("1109402005", var_24_6)
						arg_21_1:RecordAudio("1109402005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402005", "story_v_side_new_1109402.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402005", "story_v_side_new_1109402.awb")
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
	Play1109402006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109402006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1109402007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.65

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1109402006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 26)

				if (26 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 26)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1109402007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109402007
		arg_29_1.duration_ = 3.2

		local var_29_0 = {
			ja = 1.999999999999,
			ko = 3.2,
			zh = 3.2
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
				arg_29_0:Play1109402008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1094ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1094ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1094ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1094ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1094ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1094ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1094ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["1094ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1094ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, -0.84, -6.1)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["1094ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1094ui_story == nil then
				arg_29_1.var_.characterEffect1094ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect1094ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect1094ui_story then
				arg_29_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_32_8 = 0
			local var_32_9 = 0.075

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(1109402007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 3 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 3)

				if (3 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 3)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402007", "story_v_side_new_1109402.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402007", "story_v_side_new_1109402.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_side_new_1109402", "1109402007", "story_v_side_new_1109402.awb")

						arg_29_1:RecordAudio("1109402007", var_32_15)
						arg_29_1:RecordAudio("1109402007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402007", "story_v_side_new_1109402.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402007", "story_v_side_new_1109402.awb")
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
				actorName = "1094ui_story",
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
	Play1109402008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109402008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1109402009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1094ui_story"]) and arg_33_1.var_.characterEffect1094ui_story == nil then
				arg_33_1.var_.characterEffect1094ui_story = arg_33_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1094ui_story"]) then
				if arg_33_1.var_.characterEffect1094ui_story and not isNil(arg_33_1.actors_["1094ui_story"]) then
					arg_33_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1094ui_story"]) and arg_33_1.var_.characterEffect1094ui_story then
				arg_33_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.775

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1109402008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 31 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 31)

				if (31 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 31)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1109402009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1109402009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1109402010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 1.225

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1109402009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 49 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 49)

				if (49 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 49)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1109402010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1109402010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1109402011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.975

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1109402010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 39 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 39)

				if (39 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 39)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1109402011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1109402011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1109402012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1094ui_story = arg_45_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1094ui_story"].transform.position).z)
				arg_45_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1094ui_story"].transform.localEulerAngles = arg_45_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1094ui_story"].transform.position).z)
				arg_45_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1094ui_story"].transform.localEulerAngles = arg_45_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1094ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1094ui_story == nil then
				arg_45_1.var_.characterEffect1094ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1094ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_2)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1094ui_story then
				arg_45_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:AudioAction("stop", "effect", "se_story_v1_environment_crowd", "se_story_v1_environment_crowd", "")
			end

			local var_48_4 = 0
			local var_48_5 = 0.475

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(1109402011).content)

				arg_45_1.text_.text = var_48_6

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_8 = 19 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_6) / 19)

				if (19 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_6) / 19)) > 0 and var_48_5 < var_48_8 then
					arg_45_1.talkMaxDuration = var_48_8

					if var_48_8 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_6
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_9 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_9 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_9

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_9 and arg_45_1.time_ < var_48_4 + var_48_9 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1109402012
		arg_49_1.duration_ = 6

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1109402013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 then
				local var_52_0 = arg_49_1.bgs_.ST03

				arg_49_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_52_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_1 = var_52_0:GetComponent("SpriteRenderer")

				if var_52_1 and var_52_1.sprite then
					local var_52_2 = 2 * (var_52_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_52_0.transform.localScale = Vector3.New(var_52_2 / var_52_1.sprite.bounds.size.y < var_52_2 * manager.ui.mainCameraCom_.aspect / var_52_1.sprite.bounds.size.x and var_52_2 * manager.ui.mainCameraCom_.aspect / var_52_1.sprite.bounds.size.x or var_52_2 / var_52_1.sprite.bounds.size.y, var_52_2 / var_52_1.sprite.bounds.size.y < var_52_2 * manager.ui.mainCameraCom_.aspect / var_52_1.sprite.bounds.size.x and var_52_2 * manager.ui.mainCameraCom_.aspect / var_52_1.sprite.bounds.size.x or var_52_2 / var_52_1.sprite.bounds.size.y, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "ST03" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_3 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_4 = 2

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_4 then
				local var_52_5 = Color.New(0, 0, 0)

				var_52_5.a = Mathf.Lerp(0, 1, (arg_49_1.time_ - var_52_3) / var_52_4)
				arg_49_1.mask_.color = var_52_5
			end

			if arg_49_1.time_ >= var_52_3 + var_52_4 and arg_49_1.time_ < var_52_3 + var_52_4 + arg_52_0 then
				local var_52_6 = Color.New(0, 0, 0)

				var_52_6.a = 1
				arg_49_1.mask_.color = var_52_6
			end

			local var_52_7 = 2

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_8 = 2

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_8 then
				local var_52_9 = Color.New(0, 0, 0)

				var_52_9.a = Mathf.Lerp(1, 0, (arg_49_1.time_ - var_52_7) / var_52_8)
				arg_49_1.mask_.color = var_52_9
			end

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 then
				local var_52_10 = Color.New(0, 0, 0)

				arg_49_1.mask_.enabled = false
				var_52_10.a = 0
				arg_49_1.mask_.color = var_52_10
			end

			local var_52_11 = arg_49_1.actors_["1094ui_story"].transform

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= 4 + arg_52_0 then
				arg_49_1.var_.moveOldPos1094ui_story = var_52_11.localPosition
			end

			local var_52_12 = 0.001

			if 4 <= arg_49_1.time_ and arg_49_1.time_ < 4 + var_52_12 then
				var_52_11.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_49_1.time_ - 4) / var_52_12)
				var_52_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_11.position).x, (manager.ui.mainCamera.transform.position - var_52_11.position).y, (manager.ui.mainCamera.transform.position - var_52_11.position).z)
				var_52_11.localEulerAngles.z = 0
				var_52_11.localEulerAngles.x = 0
				var_52_11.localEulerAngles = var_52_11.localEulerAngles
			end

			if arg_49_1.time_ >= 4 + var_52_12 and arg_49_1.time_ < 4 + var_52_12 + arg_52_0 then
				var_52_11.localPosition = Vector3.New(0, -0.84, -6.1)
				var_52_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_11.position).x, (manager.ui.mainCamera.transform.position - var_52_11.position).y, (manager.ui.mainCamera.transform.position - var_52_11.position).z)
				var_52_11.localEulerAngles.z = 0
				var_52_11.localEulerAngles.x = 0
				var_52_11.localEulerAngles = var_52_11.localEulerAngles
			end

			local var_52_13 = arg_49_1.actors_["1094ui_story"]

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= 4 + arg_52_0 and not isNil(var_52_13) and arg_49_1.var_.characterEffect1094ui_story == nil then
				arg_49_1.var_.characterEffect1094ui_story = var_52_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_14 = 0.200000002980232

			if 4 <= arg_49_1.time_ and arg_49_1.time_ < 4 + var_52_14 and not isNil(var_52_13) then
				if arg_49_1.var_.characterEffect1094ui_story and not isNil(var_52_13) then
					arg_49_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 4 + var_52_14 and arg_49_1.time_ < 4 + var_52_14 + arg_52_0 and not isNil(var_52_13) and arg_49_1.var_.characterEffect1094ui_story then
				arg_49_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= 4 + arg_52_0 then
				arg_49_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= 4 + arg_52_0 then
				arg_49_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_16 = 4
			local var_52_17 = 0.1

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_18 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_18:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_19 = arg_49_1:GetWordFromCfg(1109402012)
				local var_52_20 = arg_49_1:FormatText(var_52_19.content)

				arg_49_1.text_.text = var_52_20

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_22 = 4 <= 0 and var_52_17 or var_52_17 * (utf8.len(var_52_20) / 4)

				if (4 <= 0 and var_52_17 or var_52_17 * (utf8.len(var_52_20) / 4)) > 0 and var_52_17 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22
					var_52_16 = var_52_16 + 0.3

					if var_52_22 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_16
					end
				end

				arg_49_1.text_.text = var_52_20
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402012", "story_v_side_new_1109402.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402012", "story_v_side_new_1109402.awb") / 1000

					if var_52_23 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_16
					end

					if var_52_19.prefab_name ~= "" and arg_49_1.actors_[var_52_19.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_19.prefab_name].transform, "story_v_side_new_1109402", "1109402012", "story_v_side_new_1109402.awb")

						arg_49_1:RecordAudio("1109402012", var_52_24)
						arg_49_1:RecordAudio("1109402012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402012", "story_v_side_new_1109402.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402012", "story_v_side_new_1109402.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = var_52_16 + 0.3
			local var_52_26 = math.max(var_52_17, arg_49_1.talkMaxDuration)

			if var_52_16 + 0.3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_25 + var_52_26 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_25) / var_52_26

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_25 + var_52_26 and arg_49_1.time_ < var_52_25 + var_52_26 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play1109402013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1109402013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1109402014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1094ui_story"]) and arg_55_1.var_.characterEffect1094ui_story == nil then
				arg_55_1.var_.characterEffect1094ui_story = arg_55_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1094ui_story"]) then
				if arg_55_1.var_.characterEffect1094ui_story and not isNil(arg_55_1.actors_["1094ui_story"]) then
					arg_55_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_0)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1094ui_story"]) and arg_55_1.var_.characterEffect1094ui_story then
				arg_55_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_58_1 = 0
			local var_58_2 = 0.075

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_3 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(1109402013).content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 3 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 3)

				if (3 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 3)) > 0 and var_58_2 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_1
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_6 = math.max(var_58_2, arg_55_1.talkMaxDuration)

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_6 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_1) / var_58_6

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_1 + var_58_6 and arg_55_1.time_ < var_58_1 + var_58_6 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1109402014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1109402014
		arg_59_1.duration_ = 6.6

		local var_59_0 = {
			ja = 5.566,
			ko = 6.6,
			zh = 6.6
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
				arg_59_0:Play1109402015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1094ui_story = arg_59_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1094ui_story"].transform.position).z)
				arg_59_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1094ui_story"].transform.localEulerAngles = arg_59_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_59_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1094ui_story"].transform.position).z)
				arg_59_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1094ui_story"].transform.localEulerAngles = arg_59_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["1094ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1094ui_story == nil then
				arg_59_1.var_.characterEffect1094ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1094ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1094ui_story then
				arg_59_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_4 = 0
			local var_62_5 = 0.675

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(1109402014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 27 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 27)

				if (27 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 27)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402014", "story_v_side_new_1109402.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402014", "story_v_side_new_1109402.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_side_new_1109402", "1109402014", "story_v_side_new_1109402.awb")

						arg_59_1:RecordAudio("1109402014", var_62_11)
						arg_59_1:RecordAudio("1109402014", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402014", "story_v_side_new_1109402.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402014", "story_v_side_new_1109402.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_12 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_12 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_12

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_12 and arg_59_1.time_ < var_62_4 + var_62_12 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play1109402015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1109402015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1109402016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1094ui_story"]) and arg_63_1.var_.characterEffect1094ui_story == nil then
				arg_63_1.var_.characterEffect1094ui_story = arg_63_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1094ui_story"]) then
				if arg_63_1.var_.characterEffect1094ui_story and not isNil(arg_63_1.actors_["1094ui_story"]) then
					arg_63_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1094ui_story"]) and arg_63_1.var_.characterEffect1094ui_story then
				arg_63_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 0.7

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(1109402015).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 28 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 28)

				if (28 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 28)) > 0 and var_66_2 < var_66_5 then
					arg_63_1.talkMaxDuration = var_66_5

					if var_66_5 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_6 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_6 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_6

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_6 and arg_63_1.time_ < var_66_1 + var_66_6 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1109402016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1109402016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1109402017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.85

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(1109402016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 34 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 34)

				if (34 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 34)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1109402017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1109402017
		arg_71_1.duration_ = 2.7

		local var_71_0 = {
			ja = 2.7,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_71_0:Play1109402018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1094ui_story = arg_71_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1094ui_story"].transform.position).z)
				arg_71_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1094ui_story"].transform.localEulerAngles = arg_71_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_71_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1094ui_story"].transform.position).z)
				arg_71_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1094ui_story"].transform.localEulerAngles = arg_71_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1094ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1094ui_story == nil then
				arg_71_1.var_.characterEffect1094ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1094ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1094ui_story then
				arg_71_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_74_4 = 0
			local var_74_5 = 0.275

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(1109402017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 11 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 11)

				if (11 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 11)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402017", "story_v_side_new_1109402.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402017", "story_v_side_new_1109402.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_side_new_1109402", "1109402017", "story_v_side_new_1109402.awb")

						arg_71_1:RecordAudio("1109402017", var_74_11)
						arg_71_1:RecordAudio("1109402017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402017", "story_v_side_new_1109402.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402017", "story_v_side_new_1109402.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play1109402018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1109402018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1109402019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1094ui_story"]) and arg_75_1.var_.characterEffect1094ui_story == nil then
				arg_75_1.var_.characterEffect1094ui_story = arg_75_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1094ui_story"]) then
				if arg_75_1.var_.characterEffect1094ui_story and not isNil(arg_75_1.actors_["1094ui_story"]) then
					arg_75_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1094ui_story"]) and arg_75_1.var_.characterEffect1094ui_story then
				arg_75_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 1.125

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(1109402018).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 45 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 45)

				if (45 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 45)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1109402019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1109402019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1109402020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.65

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(1109402019).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 26 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 26)

				if (26 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 26)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1109402020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1109402020
		arg_83_1.duration_ = 2

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1109402021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_2")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_86_0 = arg_83_1.actors_["1094ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1094ui_story == nil then
				arg_83_1.var_.characterEffect1094ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_1 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 and not isNil(var_86_0) then
				if arg_83_1.var_.characterEffect1094ui_story and not isNil(var_86_0) then
					arg_83_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1094ui_story then
				arg_83_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_86_3 = 0
			local var_86_4 = 0.625

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_5 = arg_83_1:GetWordFromCfg(1109402020)
				local var_86_6 = arg_83_1:FormatText(var_86_5.content)

				arg_83_1.text_.text = var_86_6

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_8 = 24 <= 0 and var_86_4 or var_86_4 * (utf8.len(var_86_6) / 24)

				if (24 <= 0 and var_86_4 or var_86_4 * (utf8.len(var_86_6) / 24)) > 0 and var_86_4 < var_86_8 then
					arg_83_1.talkMaxDuration = var_86_8

					if var_86_8 + var_86_3 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_3
					end
				end

				arg_83_1.text_.text = var_86_6
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402020", "story_v_side_new_1109402.awb") ~= 0 then
					local var_86_9 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402020", "story_v_side_new_1109402.awb") / 1000

					if var_86_9 + var_86_3 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_3
					end

					if var_86_5.prefab_name ~= "" and arg_83_1.actors_[var_86_5.prefab_name] ~= nil then
						local var_86_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_5.prefab_name].transform, "story_v_side_new_1109402", "1109402020", "story_v_side_new_1109402.awb")

						arg_83_1:RecordAudio("1109402020", var_86_10)
						arg_83_1:RecordAudio("1109402020", var_86_10)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402020", "story_v_side_new_1109402.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402020", "story_v_side_new_1109402.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_11 = math.max(var_86_4, arg_83_1.talkMaxDuration)

			if var_86_3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_3 + var_86_11 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_3) / var_86_11

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_3 + var_86_11 and arg_83_1.time_ < var_86_3 + var_86_11 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1109402021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1109402021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1109402022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_90_0 = 0
			local var_90_1 = 0.5

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_2 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(1109402021).content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 20 <= 0 and var_90_1 or var_90_1 * (utf8.len(var_90_2) / 20)

				if (20 <= 0 and var_90_1 or var_90_1 * (utf8.len(var_90_2) / 20)) > 0 and var_90_1 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_5 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_5 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_5

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_5 and arg_87_1.time_ < var_90_0 + var_90_5 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play1109402022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1109402022
		arg_91_1.duration_ = 3.37

		local var_91_0 = {
			ja = 2.7,
			ko = 3.366,
			zh = 3.366
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
				arg_91_0:Play1109402023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1094ui_story = arg_91_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1094ui_story"].transform.position).z)
				arg_91_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1094ui_story"].transform.localEulerAngles = arg_91_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_91_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1094ui_story"].transform.position).z)
				arg_91_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1094ui_story"].transform.localEulerAngles = arg_91_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["1094ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1094ui_story == nil then
				arg_91_1.var_.characterEffect1094ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect1094ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1094ui_story then
				arg_91_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_94_4 = 0
			local var_94_5 = 0.3

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(1109402022)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 12 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 12)

				if (12 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 12)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402022", "story_v_side_new_1109402.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402022", "story_v_side_new_1109402.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_side_new_1109402", "1109402022", "story_v_side_new_1109402.awb")

						arg_91_1:RecordAudio("1109402022", var_94_11)
						arg_91_1:RecordAudio("1109402022", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402022", "story_v_side_new_1109402.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402022", "story_v_side_new_1109402.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_12 and arg_91_1.time_ < var_94_4 + var_94_12 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1109402023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1109402024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1094ui_story"]) and arg_95_1.var_.characterEffect1094ui_story == nil then
				arg_95_1.var_.characterEffect1094ui_story = arg_95_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1094ui_story"]) then
				if arg_95_1.var_.characterEffect1094ui_story and not isNil(arg_95_1.actors_["1094ui_story"]) then
					arg_95_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1094ui_story"]) and arg_95_1.var_.characterEffect1094ui_story then
				arg_95_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_98_1 = 0
			local var_98_2 = 0.5

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(1109402023).content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 20 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 20)

				if (20 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 20)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_6 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_6 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_6

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_6 and arg_95_1.time_ < var_98_1 + var_98_6 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1109402024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1109402024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1109402025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.15

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1109402024).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 6 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 6)

				if (6 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 6)) > 0 and var_102_0 < var_102_3 then
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
	Play1109402025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1109402025
		arg_103_1.duration_ = 5.4

		local var_103_0 = {
			ja = 4.8,
			ko = 5.4,
			zh = 5.4
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
				arg_103_0:Play1109402026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1094ui_story = arg_103_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1094ui_story"].transform.position).z)
				arg_103_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1094ui_story"].transform.localEulerAngles = arg_103_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_103_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1094ui_story"].transform.position).z)
				arg_103_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1094ui_story"].transform.localEulerAngles = arg_103_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["1094ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1094ui_story == nil then
				arg_103_1.var_.characterEffect1094ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1094ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1094ui_story then
				arg_103_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_2")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_106_4 = 0
			local var_106_5 = 0.325

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(1109402025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 13 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 13)

				if (13 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 13)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402025", "story_v_side_new_1109402.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402025", "story_v_side_new_1109402.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_side_new_1109402", "1109402025", "story_v_side_new_1109402.awb")

						arg_103_1:RecordAudio("1109402025", var_106_11)
						arg_103_1:RecordAudio("1109402025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402025", "story_v_side_new_1109402.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402025", "story_v_side_new_1109402.awb")
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
				actorName = "1094ui_story",
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
	Play1109402026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1109402026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1109402027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1094ui_story"]) and arg_107_1.var_.characterEffect1094ui_story == nil then
				arg_107_1.var_.characterEffect1094ui_story = arg_107_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1094ui_story"]) then
				if arg_107_1.var_.characterEffect1094ui_story and not isNil(arg_107_1.actors_["1094ui_story"]) then
					arg_107_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1094ui_story"]) and arg_107_1.var_.characterEffect1094ui_story then
				arg_107_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0
			local var_110_2 = 0.55

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(1109402026).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 22 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 22)

				if (22 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 22)) > 0 and var_110_2 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_6 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_6

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_6 and arg_107_1.time_ < var_110_1 + var_110_6 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play1109402027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1109402027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1109402028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.85

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

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(1109402027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 34 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 34)

				if (34 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 34)) > 0 and var_114_0 < var_114_3 then
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
	Play1109402028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1109402028
		arg_115_1.duration_ = 4

		local var_115_0 = {
			ja = 4,
			ko = 3.833,
			zh = 3.833
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
				arg_115_0:Play1109402029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1094ui_story = arg_115_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1094ui_story"].transform.position).z)
				arg_115_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1094ui_story"].transform.localEulerAngles = arg_115_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_115_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1094ui_story"].transform.position).z)
				arg_115_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1094ui_story"].transform.localEulerAngles = arg_115_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["1094ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1094ui_story == nil then
				arg_115_1.var_.characterEffect1094ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect1094ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1094ui_story then
				arg_115_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_118_4 = 0
			local var_118_5 = 0.25

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(1109402028)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 10 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 10)

				if (10 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 10)) > 0 and var_118_5 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402028", "story_v_side_new_1109402.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402028", "story_v_side_new_1109402.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_side_new_1109402", "1109402028", "story_v_side_new_1109402.awb")

						arg_115_1:RecordAudio("1109402028", var_118_11)
						arg_115_1:RecordAudio("1109402028", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402028", "story_v_side_new_1109402.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402028", "story_v_side_new_1109402.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_12 and arg_115_1.time_ < var_118_4 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1109402029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1109402030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1094ui_story"]) and arg_119_1.var_.characterEffect1094ui_story == nil then
				arg_119_1.var_.characterEffect1094ui_story = arg_119_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1094ui_story"]) then
				if arg_119_1.var_.characterEffect1094ui_story and not isNil(arg_119_1.actors_["1094ui_story"]) then
					arg_119_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1094ui_story"]) and arg_119_1.var_.characterEffect1094ui_story then
				arg_119_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_122_1 = 0
			local var_122_2 = 0.225

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(1109402029).content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 9 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 9)

				if (9 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_3) / 9)) > 0 and var_122_2 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_6 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_6 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_6

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_6 and arg_119_1.time_ < var_122_1 + var_122_6 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1109402030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1109402030
		arg_123_1.duration_ = 3.1

		local var_123_0 = {
			ja = 3.1,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_123_0:Play1109402031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1094ui_story = arg_123_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1094ui_story"].transform.position).z)
				arg_123_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1094ui_story"].transform.localEulerAngles = arg_123_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_123_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1094ui_story"].transform.position).z)
				arg_123_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1094ui_story"].transform.localEulerAngles = arg_123_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1094ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1094ui_story == nil then
				arg_123_1.var_.characterEffect1094ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1094ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1094ui_story then
				arg_123_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_4 = 0
			local var_126_5 = 0.125

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(1109402030)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 5 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 5)

				if (5 <= 0 and var_126_5 or var_126_5 * (utf8.len(var_126_7) / 5)) > 0 and var_126_5 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402030", "story_v_side_new_1109402.awb") ~= 0 then
					local var_126_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402030", "story_v_side_new_1109402.awb") / 1000

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end

					if var_126_6.prefab_name ~= "" and arg_123_1.actors_[var_126_6.prefab_name] ~= nil then
						local var_126_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_6.prefab_name].transform, "story_v_side_new_1109402", "1109402030", "story_v_side_new_1109402.awb")

						arg_123_1:RecordAudio("1109402030", var_126_11)
						arg_123_1:RecordAudio("1109402030", var_126_11)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402030", "story_v_side_new_1109402.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402030", "story_v_side_new_1109402.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_12 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_12 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_12

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_12 and arg_123_1.time_ < var_126_4 + var_126_12 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1109402031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1109402032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1094ui_story"]) and arg_127_1.var_.characterEffect1094ui_story == nil then
				arg_127_1.var_.characterEffect1094ui_story = arg_127_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1094ui_story"]) then
				if arg_127_1.var_.characterEffect1094ui_story and not isNil(arg_127_1.actors_["1094ui_story"]) then
					arg_127_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1094ui_story"]) and arg_127_1.var_.characterEffect1094ui_story then
				arg_127_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_130_1 = 0
			local var_130_2 = 0.4

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(1109402031).content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 16 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 16)

				if (16 <= 0 and var_130_2 or var_130_2 * (utf8.len(var_130_3) / 16)) > 0 and var_130_2 < var_130_5 then
					arg_127_1.talkMaxDuration = var_130_5

					if var_130_5 + var_130_1 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + var_130_1
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_6 = math.max(var_130_2, arg_127_1.talkMaxDuration)

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_6 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_1) / var_130_6

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_1 + var_130_6 and arg_127_1.time_ < var_130_1 + var_130_6 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1109402032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1109402032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1109402033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.4

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
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

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(1109402032).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 16 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 16)

				if (16 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 16)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play1109402033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1109402033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1109402034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1094ui_story = arg_135_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1094ui_story"].transform.position).z)
				arg_135_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1094ui_story"].transform.localEulerAngles = arg_135_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1094ui_story"].transform.position).z)
				arg_135_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1094ui_story"].transform.localEulerAngles = arg_135_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_138_1 = 0
			local var_138_2 = 0.625

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

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(1109402033).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 25 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 25)

				if (25 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 25)) > 0 and var_138_2 < var_138_5 then
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

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1109402034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1109402035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.175

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(1109402034).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 7 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 7)

				if (7 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 7)) > 0 and var_142_0 < var_142_3 then
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
	Play1109402035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1109402035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1109402036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.6

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

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(1109402035).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 24 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 24)

				if (24 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 24)) > 0 and var_146_0 < var_146_3 then
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
	Play1109402036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1109402036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1109402037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.55

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1109402036).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 22 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 22)

				if (22 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 22)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1109402037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1109402037
		arg_151_1.duration_ = 2

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1109402038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1094ui_story = arg_151_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1094ui_story"].transform.position).z)
				arg_151_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1094ui_story"].transform.localEulerAngles = arg_151_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_151_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1094ui_story"].transform.position).z)
				arg_151_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1094ui_story"].transform.localEulerAngles = arg_151_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1094ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1094ui_story == nil then
				arg_151_1.var_.characterEffect1094ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1094ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1094ui_story then
				arg_151_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_2")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_4 = 0
			local var_154_5 = 0.125

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(1109402037)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 5 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 5)

				if (5 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 5)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402037", "story_v_side_new_1109402.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402037", "story_v_side_new_1109402.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_side_new_1109402", "1109402037", "story_v_side_new_1109402.awb")

						arg_151_1:RecordAudio("1109402037", var_154_11)
						arg_151_1:RecordAudio("1109402037", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402037", "story_v_side_new_1109402.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402037", "story_v_side_new_1109402.awb")
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
				actorName = "1094ui_story",
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
	Play1109402038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1109402038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1109402039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1094ui_story"]) and arg_155_1.var_.characterEffect1094ui_story == nil then
				arg_155_1.var_.characterEffect1094ui_story = arg_155_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1094ui_story"]) then
				if arg_155_1.var_.characterEffect1094ui_story and not isNil(arg_155_1.actors_["1094ui_story"]) then
					arg_155_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1094ui_story"]) and arg_155_1.var_.characterEffect1094ui_story then
				arg_155_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_158_1 = 0
			local var_158_2 = 0.55

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

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(1109402038).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 22 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 22)

				if (22 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 22)) > 0 and var_158_2 < var_158_5 then
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
	Play1109402039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1109402039
		arg_159_1.duration_ = 11

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1109402040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 3 < arg_159_1.time_ and arg_159_1.time_ <= 3 + arg_162_0 then
				local var_162_0 = arg_159_1.bgs_.ST03

				arg_159_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_162_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_162_1 = var_162_0:GetComponent("SpriteRenderer")

				if var_162_1 and var_162_1.sprite then
					local var_162_2 = 2 * (var_162_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_162_0.transform.localScale = Vector3.New(var_162_2 / var_162_1.sprite.bounds.size.y < var_162_2 * manager.ui.mainCameraCom_.aspect / var_162_1.sprite.bounds.size.x and var_162_2 * manager.ui.mainCameraCom_.aspect / var_162_1.sprite.bounds.size.x or var_162_2 / var_162_1.sprite.bounds.size.y, var_162_2 / var_162_1.sprite.bounds.size.y < var_162_2 * manager.ui.mainCameraCom_.aspect / var_162_1.sprite.bounds.size.x and var_162_2 * manager.ui.mainCameraCom_.aspect / var_162_1.sprite.bounds.size.x or var_162_2 / var_162_1.sprite.bounds.size.y, 0)
				end

				for iter_162_0, iter_162_1 in pairs(arg_159_1.bgs_) do
					if iter_162_0 ~= "ST03" then
						iter_162_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_162_3 = 0

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_3 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_4 = 3

			if var_162_3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_3 + var_162_4 then
				local var_162_5 = Color.New(0, 0, 0)

				var_162_5.a = Mathf.Lerp(0, 1, (arg_159_1.time_ - var_162_3) / var_162_4)
				arg_159_1.mask_.color = var_162_5
			end

			if arg_159_1.time_ >= var_162_3 + var_162_4 and arg_159_1.time_ < var_162_3 + var_162_4 + arg_162_0 then
				local var_162_6 = Color.New(0, 0, 0)

				var_162_6.a = 1
				arg_159_1.mask_.color = var_162_6
			end

			local var_162_7 = 3

			if 3 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_8 = 3

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_8 then
				local var_162_9 = Color.New(0, 0, 0)

				var_162_9.a = Mathf.Lerp(1, 0, (arg_159_1.time_ - var_162_7) / var_162_8)
				arg_159_1.mask_.color = var_162_9
			end

			if arg_159_1.time_ >= var_162_7 + var_162_8 and arg_159_1.time_ < var_162_7 + var_162_8 + arg_162_0 then
				local var_162_10 = Color.New(0, 0, 0)

				arg_159_1.mask_.enabled = false
				var_162_10.a = 0
				arg_159_1.mask_.color = var_162_10
			end

			local var_162_11 = arg_159_1.actors_["1094ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1094ui_story = var_162_11.localPosition
			end

			local var_162_12 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_12 then
				var_162_11.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0) / var_162_12)
				var_162_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_11.position).x, (manager.ui.mainCamera.transform.position - var_162_11.position).y, (manager.ui.mainCamera.transform.position - var_162_11.position).z)
				var_162_11.localEulerAngles.z = 0
				var_162_11.localEulerAngles.x = 0
				var_162_11.localEulerAngles = var_162_11.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_12 and arg_159_1.time_ < 0 + var_162_12 + arg_162_0 then
				var_162_11.localPosition = Vector3.New(0, 100, 0)
				var_162_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_11.position).x, (manager.ui.mainCamera.transform.position - var_162_11.position).y, (manager.ui.mainCamera.transform.position - var_162_11.position).z)
				var_162_11.localEulerAngles.z = 0
				var_162_11.localEulerAngles.x = 0
				var_162_11.localEulerAngles = var_162_11.localEulerAngles
			end

			if arg_159_1.frameCnt_ <= 1 then
				arg_159_1.dialog_:SetActive(false)
			end

			local var_162_13 = 6
			local var_162_14 = 0.8

			if 6 < arg_159_1.time_ and arg_159_1.time_ <= var_162_13 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				arg_159_1.dialog_:SetActive(true)

				arg_159_1.dialogCg_.alpha = 0

				local var_162_15 = LeanTween.value(arg_159_1.dialog_, 0, 1, 0.3)

				var_162_15:setOnUpdate(LuaHelper.FloatAction(function(arg_163_0)
					arg_159_1.dialogCg_.alpha = arg_163_0
				end))
				var_162_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_159_1.dialog_)
					var_162_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_159_1.duration_ = arg_159_1.duration_ + 0.3

				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_16 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(1109402039).content)

				arg_159_1.text_.text = var_162_16

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_18 = 25 <= 0 and var_162_14 or var_162_14 * (utf8.len(var_162_16) / 25)

				if (25 <= 0 and var_162_14 or var_162_14 * (utf8.len(var_162_16) / 25)) > 0 and var_162_14 < var_162_18 then
					arg_159_1.talkMaxDuration = var_162_18
					var_162_13 = var_162_13 + 0.3

					if var_162_18 + var_162_13 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_18 + var_162_13
					end
				end

				arg_159_1.text_.text = var_162_16
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_19 = var_162_13 + 0.3
			local var_162_20 = math.max(var_162_14, arg_159_1.talkMaxDuration)

			if var_162_13 + 0.3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_19 + var_162_20 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_19) / var_162_20

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_19 + var_162_20 and arg_159_1.time_ < var_162_19 + var_162_20 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1109402040
		arg_165_1.duration_ = 3.43

		local var_165_0 = {
			ja = 2.733,
			ko = 3.433,
			zh = 3.433
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1109402041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1094ui_story = arg_165_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1094ui_story"].transform.position).z)
				arg_165_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1094ui_story"].transform.localEulerAngles = arg_165_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_165_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1094ui_story"].transform.position).z)
				arg_165_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1094ui_story"].transform.localEulerAngles = arg_165_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1094ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1094ui_story == nil then
				arg_165_1.var_.characterEffect1094ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1094ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1094ui_story then
				arg_165_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_168_4 = 0
			local var_168_5 = 0.25

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(1109402040)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 10 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 10)

				if (10 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 10)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402040", "story_v_side_new_1109402.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402040", "story_v_side_new_1109402.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_side_new_1109402", "1109402040", "story_v_side_new_1109402.awb")

						arg_165_1:RecordAudio("1109402040", var_168_11)
						arg_165_1:RecordAudio("1109402040", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402040", "story_v_side_new_1109402.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402040", "story_v_side_new_1109402.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play1109402041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1109402041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1109402042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1094ui_story"]) and arg_169_1.var_.characterEffect1094ui_story == nil then
				arg_169_1.var_.characterEffect1094ui_story = arg_169_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1094ui_story"]) then
				if arg_169_1.var_.characterEffect1094ui_story and not isNil(arg_169_1.actors_["1094ui_story"]) then
					arg_169_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_0)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1094ui_story"]) and arg_169_1.var_.characterEffect1094ui_story then
				arg_169_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_172_1 = 0
			local var_172_2 = 0.725

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(1109402041).content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 32 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 32)

				if (32 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 32)) > 0 and var_172_2 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_6 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_6 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_6

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_6 and arg_169_1.time_ < var_172_1 + var_172_6 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play1109402042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1109402042
		arg_173_1.duration_ = 2.87

		local var_173_0 = {
			ja = 2.866,
			ko = 2.233,
			zh = 2.233
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1109402043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.225

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:GetWordFromCfg(1109402042)
				local var_176_2 = arg_173_1:FormatText(var_176_1.content)

				arg_173_1.text_.text = var_176_2

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_4 = 9 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 9)

				if (9 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_2) / 9)) > 0 and var_176_0 < var_176_4 then
					arg_173_1.talkMaxDuration = var_176_4

					if var_176_4 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_4 + 0
					end
				end

				arg_173_1.text_.text = var_176_2
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402042", "story_v_side_new_1109402.awb") ~= 0 then
					local var_176_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402042", "story_v_side_new_1109402.awb") / 1000

					if var_176_5 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + 0
					end

					if var_176_1.prefab_name ~= "" and arg_173_1.actors_[var_176_1.prefab_name] ~= nil then
						local var_176_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_1.prefab_name].transform, "story_v_side_new_1109402", "1109402042", "story_v_side_new_1109402.awb")

						arg_173_1:RecordAudio("1109402042", var_176_6)
						arg_173_1:RecordAudio("1109402042", var_176_6)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402042", "story_v_side_new_1109402.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402042", "story_v_side_new_1109402.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_7 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_7 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_7

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_7 and arg_173_1.time_ < 0 + var_176_7 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1109402043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1109402043
		arg_177_1.duration_ = 2

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1109402044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1094ui_story = arg_177_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1094ui_story"].transform.position).z)
				arg_177_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1094ui_story"].transform.localEulerAngles = arg_177_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_177_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1094ui_story"].transform.position).z)
				arg_177_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1094ui_story"].transform.localEulerAngles = arg_177_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1094ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1094ui_story == nil then
				arg_177_1.var_.characterEffect1094ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1094ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1094ui_story then
				arg_177_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action2_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_4 = 0
			local var_180_5 = 0.15

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(1109402043)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 6 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 6)

				if (6 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 6)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402043", "story_v_side_new_1109402.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402043", "story_v_side_new_1109402.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_side_new_1109402", "1109402043", "story_v_side_new_1109402.awb")

						arg_177_1:RecordAudio("1109402043", var_180_11)
						arg_177_1:RecordAudio("1109402043", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402043", "story_v_side_new_1109402.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402043", "story_v_side_new_1109402.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play1109402044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1109402044
		arg_181_1.duration_ = 13

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1109402045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if arg_181_1.bgs_.I05d == nil then
				local var_184_0 = Object.Instantiate(arg_181_1.paintGo_)

				var_184_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05d")
				var_184_0.name = "I05d"
				var_184_0.transform.parent = arg_181_1.stage_.transform
				var_184_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.bgs_.I05d = var_184_0
			end

			if 4 < arg_181_1.time_ and arg_181_1.time_ <= 4 + arg_184_0 then
				local var_184_1 = arg_181_1.bgs_.I05d

				arg_181_1.bgs_.I05d.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_184_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_184_2 = var_184_1:GetComponent("SpriteRenderer")

				if var_184_2 and var_184_2.sprite then
					local var_184_3 = 2 * (var_184_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_184_1.transform.localScale = Vector3.New(var_184_3 / var_184_2.sprite.bounds.size.y < var_184_3 * manager.ui.mainCameraCom_.aspect / var_184_2.sprite.bounds.size.x and var_184_3 * manager.ui.mainCameraCom_.aspect / var_184_2.sprite.bounds.size.x or var_184_3 / var_184_2.sprite.bounds.size.y, var_184_3 / var_184_2.sprite.bounds.size.y < var_184_3 * manager.ui.mainCameraCom_.aspect / var_184_2.sprite.bounds.size.x and var_184_3 * manager.ui.mainCameraCom_.aspect / var_184_2.sprite.bounds.size.x or var_184_3 / var_184_2.sprite.bounds.size.y, 0)
				end

				for iter_184_0, iter_184_1 in pairs(arg_181_1.bgs_) do
					if iter_184_0 ~= "I05d" then
						iter_184_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_184_4 = 0

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_5 = 4

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_5 then
				local var_184_6 = Color.New(0, 0, 0)

				var_184_6.a = Mathf.Lerp(0, 1, (arg_181_1.time_ - var_184_4) / var_184_5)
				arg_181_1.mask_.color = var_184_6
			end

			if arg_181_1.time_ >= var_184_4 + var_184_5 and arg_181_1.time_ < var_184_4 + var_184_5 + arg_184_0 then
				local var_184_7 = Color.New(0, 0, 0)

				var_184_7.a = 1
				arg_181_1.mask_.color = var_184_7
			end

			local var_184_8 = 4

			if 4 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_9 = 4

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_9 then
				local var_184_10 = Color.New(0, 0, 0)

				var_184_10.a = Mathf.Lerp(1, 0, (arg_181_1.time_ - var_184_8) / var_184_9)
				arg_181_1.mask_.color = var_184_10
			end

			if arg_181_1.time_ >= var_184_8 + var_184_9 and arg_181_1.time_ < var_184_8 + var_184_9 + arg_184_0 then
				local var_184_11 = Color.New(0, 0, 0)

				arg_181_1.mask_.enabled = false
				var_184_11.a = 0
				arg_181_1.mask_.color = var_184_11
			end

			local var_184_12 = arg_181_1.actors_["1094ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1094ui_story = var_184_12.localPosition
			end

			local var_184_13 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_13 then
				var_184_12.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_13)
				var_184_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_12.position).x, (manager.ui.mainCamera.transform.position - var_184_12.position).y, (manager.ui.mainCamera.transform.position - var_184_12.position).z)
				var_184_12.localEulerAngles.z = 0
				var_184_12.localEulerAngles.x = 0
				var_184_12.localEulerAngles = var_184_12.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_13 and arg_181_1.time_ < 0 + var_184_13 + arg_184_0 then
				var_184_12.localPosition = Vector3.New(0, 100, 0)
				var_184_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_12.position).x, (manager.ui.mainCamera.transform.position - var_184_12.position).y, (manager.ui.mainCamera.transform.position - var_184_12.position).z)
				var_184_12.localEulerAngles.z = 0
				var_184_12.localEulerAngles.x = 0
				var_184_12.localEulerAngles = var_184_12.localEulerAngles
			end

			local var_184_14 = arg_181_1.actors_["1094ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_14) and arg_181_1.var_.characterEffect1094ui_story == nil then
				arg_181_1.var_.characterEffect1094ui_story = var_184_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_15 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_15 and not isNil(var_184_14) then
				if arg_181_1.var_.characterEffect1094ui_story and not isNil(var_184_14) then
					arg_181_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_15)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_15 and arg_181_1.time_ < 0 + var_184_15 + arg_184_0 and not isNil(var_184_14) and arg_181_1.var_.characterEffect1094ui_story then
				arg_181_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			if arg_181_1.frameCnt_ <= 1 then
				arg_181_1.dialog_:SetActive(false)
			end

			local var_184_16 = 8
			local var_184_17 = 0.725

			if 8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				arg_181_1.dialog_:SetActive(true)

				arg_181_1.dialogCg_.alpha = 0

				local var_184_18 = LeanTween.value(arg_181_1.dialog_, 0, 1, 0.3)

				var_184_18:setOnUpdate(LuaHelper.FloatAction(function(arg_185_0)
					arg_181_1.dialogCg_.alpha = arg_185_0
				end))
				var_184_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_181_1.dialog_)
					var_184_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_181_1.duration_ = arg_181_1.duration_ + 0.3

				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_19 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(1109402044).content)

				arg_181_1.text_.text = var_184_19

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_21 = 29 <= 0 and var_184_17 or var_184_17 * (utf8.len(var_184_19) / 29)

				if (29 <= 0 and var_184_17 or var_184_17 * (utf8.len(var_184_19) / 29)) > 0 and var_184_17 < var_184_21 then
					arg_181_1.talkMaxDuration = var_184_21
					var_184_16 = var_184_16 + 0.3

					if var_184_21 + var_184_16 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_21 + var_184_16
					end
				end

				arg_181_1.text_.text = var_184_19
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_22 = var_184_16 + 0.3
			local var_184_23 = math.max(var_184_17, arg_181_1.talkMaxDuration)

			if var_184_16 + 0.3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_22 + var_184_23 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_22) / var_184_23

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_22 + var_184_23 and arg_181_1.time_ < var_184_22 + var_184_23 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play1109402045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1109402045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1109402046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.8

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1109402045).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 29 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 29)

				if (29 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 29)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1109402046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1109402046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1109402047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.775

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

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(1109402046).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 31 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 31)

				if (31 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 31)) > 0 and var_194_0 < var_194_3 then
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
	Play1109402047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1109402047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1109402048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 1.125

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

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(1109402047).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 45 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 45)

				if (45 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 45)) > 0 and var_198_0 < var_198_3 then
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
	Play1109402048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1109402048
		arg_199_1.duration_ = 6.4

		local var_199_0 = {
			ja = 6.4,
			ko = 2.466,
			zh = 2.466
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1109402049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.25

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:GetWordFromCfg(1109402048)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 10 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 10)

				if (10 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 10)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402048", "story_v_side_new_1109402.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402048", "story_v_side_new_1109402.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_side_new_1109402", "1109402048", "story_v_side_new_1109402.awb")

						arg_199_1:RecordAudio("1109402048", var_202_6)
						arg_199_1:RecordAudio("1109402048", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402048", "story_v_side_new_1109402.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402048", "story_v_side_new_1109402.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1109402049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1109402049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1109402050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.3

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(1109402049).content)

				arg_203_1.text_.text = var_206_1

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_3 = 12 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 12)

				if (12 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 12)) > 0 and var_206_0 < var_206_3 then
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
	Play1109402050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1109402050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1109402051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.55

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1109402050).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 22 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 22)

				if (22 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 22)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1109402051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1109402051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1109402052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1094ui_story = arg_211_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1094ui_story"].transform.position).z)
				arg_211_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1094ui_story"].transform.localEulerAngles = arg_211_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_211_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1094ui_story"].transform.position).z)
				arg_211_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1094ui_story"].transform.localEulerAngles = arg_211_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1094ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1094ui_story == nil then
				arg_211_1.var_.characterEffect1094ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.0166666666666667

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1094ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_2)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1094ui_story then
				arg_211_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_214_3 = 0
			local var_214_4 = 0.9

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

				local var_214_5 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(1109402051).content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 36 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 36)

				if (36 <= 0 and var_214_4 or var_214_4 * (utf8.len(var_214_5) / 36)) > 0 and var_214_4 < var_214_7 then
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
				actorName = "1094ui_story",
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
	Play1109402052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1109402052
		arg_215_1.duration_ = 2.83

		local var_215_0 = {
			ja = 2.833,
			ko = 2.433,
			zh = 2.433
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
				arg_215_0:Play1109402053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1094ui_story"]) and arg_215_1.var_.characterEffect1094ui_story == nil then
				arg_215_1.var_.characterEffect1094ui_story = arg_215_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1094ui_story"]) then
				if arg_215_1.var_.characterEffect1094ui_story and not isNil(arg_215_1.actors_["1094ui_story"]) then
					arg_215_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1094ui_story"]) and arg_215_1.var_.characterEffect1094ui_story then
				arg_215_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_218_2 = 0
			local var_218_3 = 0.3

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_2 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_4 = arg_215_1:GetWordFromCfg(1109402052)
				local var_218_5 = arg_215_1:FormatText(var_218_4.content)

				arg_215_1.text_.text = var_218_5

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_7 = 12 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_5) / 12)

				if (12 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_5) / 12)) > 0 and var_218_3 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_2 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_2
					end
				end

				arg_215_1.text_.text = var_218_5
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402052", "story_v_side_new_1109402.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402052", "story_v_side_new_1109402.awb") / 1000

					if var_218_8 + var_218_2 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_2
					end

					if var_218_4.prefab_name ~= "" and arg_215_1.actors_[var_218_4.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_4.prefab_name].transform, "story_v_side_new_1109402", "1109402052", "story_v_side_new_1109402.awb")

						arg_215_1:RecordAudio("1109402052", var_218_9)
						arg_215_1:RecordAudio("1109402052", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402052", "story_v_side_new_1109402.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402052", "story_v_side_new_1109402.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_3, arg_215_1.talkMaxDuration)

			if var_218_2 <= arg_215_1.time_ and arg_215_1.time_ < var_218_2 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_2) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_2 + var_218_10 and arg_215_1.time_ < var_218_2 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1109402053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1109402053
		arg_219_1.duration_ = 8.3

		local var_219_0 = {
			ja = 8.3,
			ko = 6.366,
			zh = 6.366
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
				arg_219_0:Play1109402054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1094ui_story"]) and arg_219_1.var_.characterEffect1094ui_story == nil then
				arg_219_1.var_.characterEffect1094ui_story = arg_219_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1094ui_story"]) then
				if arg_219_1.var_.characterEffect1094ui_story and not isNil(arg_219_1.actors_["1094ui_story"]) then
					arg_219_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1094ui_story"]) and arg_219_1.var_.characterEffect1094ui_story then
				arg_219_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.975

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:GetWordFromCfg(1109402053)
				local var_222_4 = arg_219_1:FormatText(var_222_3.content)

				arg_219_1.text_.text = var_222_4

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_6 = 39 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_4) / 39)

				if (39 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_4) / 39)) > 0 and var_222_2 < var_222_6 then
					arg_219_1.talkMaxDuration = var_222_6

					if var_222_6 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_6 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_4
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402053", "story_v_side_new_1109402.awb") ~= 0 then
					local var_222_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402053", "story_v_side_new_1109402.awb") / 1000

					if var_222_7 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_1
					end

					if var_222_3.prefab_name ~= "" and arg_219_1.actors_[var_222_3.prefab_name] ~= nil then
						local var_222_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_3.prefab_name].transform, "story_v_side_new_1109402", "1109402053", "story_v_side_new_1109402.awb")

						arg_219_1:RecordAudio("1109402053", var_222_8)
						arg_219_1:RecordAudio("1109402053", var_222_8)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402053", "story_v_side_new_1109402.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402053", "story_v_side_new_1109402.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_9 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_9 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_9

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_9 and arg_219_1.time_ < var_222_1 + var_222_9 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1109402054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1109402054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1109402055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.675

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(1109402054).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 28 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 28)

				if (28 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 28)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play1109402055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1109402055
		arg_227_1.duration_ = 2.6

		local var_227_0 = {
			ja = 2.6,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_227_0:Play1109402056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1094ui_story = arg_227_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1094ui_story"].transform.position).z)
				arg_227_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1094ui_story"].transform.localEulerAngles = arg_227_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_227_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1094ui_story"].transform.position).z)
				arg_227_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1094ui_story"].transform.localEulerAngles = arg_227_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1094ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1094ui_story == nil then
				arg_227_1.var_.characterEffect1094ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1094ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1094ui_story then
				arg_227_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_4 = 0
			local var_230_5 = 0.15

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_6 = arg_227_1:GetWordFromCfg(1109402055)
				local var_230_7 = arg_227_1:FormatText(var_230_6.content)

				arg_227_1.text_.text = var_230_7

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_9 = 6 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 6)

				if (6 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 6)) > 0 and var_230_5 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_4
					end
				end

				arg_227_1.text_.text = var_230_7
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402055", "story_v_side_new_1109402.awb") ~= 0 then
					local var_230_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402055", "story_v_side_new_1109402.awb") / 1000

					if var_230_10 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_4
					end

					if var_230_6.prefab_name ~= "" and arg_227_1.actors_[var_230_6.prefab_name] ~= nil then
						local var_230_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_6.prefab_name].transform, "story_v_side_new_1109402", "1109402055", "story_v_side_new_1109402.awb")

						arg_227_1:RecordAudio("1109402055", var_230_11)
						arg_227_1:RecordAudio("1109402055", var_230_11)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402055", "story_v_side_new_1109402.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402055", "story_v_side_new_1109402.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_5, arg_227_1.talkMaxDuration)

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_4) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_4 + var_230_12 and arg_227_1.time_ < var_230_4 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play1109402056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1109402056
		arg_231_1.duration_ = 3.97

		local var_231_0 = {
			ja = 3.966,
			ko = 3.2,
			zh = 3.2
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
				arg_231_0:Play1109402057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1094ui_story = arg_231_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1094ui_story"].transform.position).z)
				arg_231_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1094ui_story"].transform.localEulerAngles = arg_231_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_231_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1094ui_story"].transform.position).z)
				arg_231_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1094ui_story"].transform.localEulerAngles = arg_231_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_1 = 0
			local var_234_2 = 0.25

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_3 = arg_231_1:GetWordFromCfg(1109402056)
				local var_234_4 = arg_231_1:FormatText(var_234_3.content)

				arg_231_1.text_.text = var_234_4

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_6 = 10 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_4) / 10)

				if (10 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_4) / 10)) > 0 and var_234_2 < var_234_6 then
					arg_231_1.talkMaxDuration = var_234_6

					if var_234_6 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_6 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_4
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402056", "story_v_side_new_1109402.awb") ~= 0 then
					local var_234_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402056", "story_v_side_new_1109402.awb") / 1000

					if var_234_7 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_1
					end

					if var_234_3.prefab_name ~= "" and arg_231_1.actors_[var_234_3.prefab_name] ~= nil then
						local var_234_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_3.prefab_name].transform, "story_v_side_new_1109402", "1109402056", "story_v_side_new_1109402.awb")

						arg_231_1:RecordAudio("1109402056", var_234_8)
						arg_231_1:RecordAudio("1109402056", var_234_8)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402056", "story_v_side_new_1109402.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402056", "story_v_side_new_1109402.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_9 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_9 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_9

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_9 and arg_231_1.time_ < var_234_1 + var_234_9 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play1109402057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1109402057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1109402058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1094ui_story"]) and arg_235_1.var_.characterEffect1094ui_story == nil then
				arg_235_1.var_.characterEffect1094ui_story = arg_235_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1094ui_story"]) then
				if arg_235_1.var_.characterEffect1094ui_story and not isNil(arg_235_1.actors_["1094ui_story"]) then
					arg_235_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_0)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1094ui_story"]) and arg_235_1.var_.characterEffect1094ui_story then
				arg_235_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_238_1 = 0
			local var_238_2 = 0.4

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(1109402057).content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 16 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 16)

				if (16 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 16)) > 0 and var_238_2 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_6 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_6 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_6

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_6 and arg_235_1.time_ < var_238_1 + var_238_6 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1109402058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1109402058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1109402059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_242_0 = 0
			local var_242_1 = 0.55

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(1109402058).content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 22 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_2) / 22)

				if (22 <= 0 and var_242_1 or var_242_1 * (utf8.len(var_242_2) / 22)) > 0 and var_242_1 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_5 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_5 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_5

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_5 and arg_239_1.time_ < var_242_0 + var_242_5 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1109402059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1109402059
		arg_243_1.duration_ = 9

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1109402060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1094ui_story = arg_243_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1094ui_story"].transform.position).z)
				arg_243_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1094ui_story"].transform.localEulerAngles = arg_243_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1094ui_story"].transform.position).z)
				arg_243_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1094ui_story"].transform.localEulerAngles = arg_243_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1094ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1094ui_story == nil then
				arg_243_1.var_.characterEffect1094ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1094ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_2)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1094ui_story then
				arg_243_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			if 4.33333333333333 < arg_243_1.time_ and arg_243_1.time_ <= 4.33333333333333 + arg_246_0 then
				arg_243_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			local var_246_4 = "D06_1"

			if arg_243_1.bgs_.D06_1 == nil then
				local var_246_5 = Object.Instantiate(arg_243_1.paintGo_)

				var_246_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_246_4)
				var_246_5.name = var_246_4
				var_246_5.transform.parent = arg_243_1.stage_.transform
				var_246_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_243_1.bgs_[var_246_4] = var_246_5
			end

			if 2 < arg_243_1.time_ and arg_243_1.time_ <= 2 + arg_246_0 then
				local var_246_6 = arg_243_1.bgs_.D06_1

				arg_243_1.bgs_.D06_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_246_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_7 = var_246_6:GetComponent("SpriteRenderer")

				if var_246_7 and var_246_7.sprite then
					local var_246_8 = 2 * (var_246_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_246_6.transform.localScale = Vector3.New(var_246_8 / var_246_7.sprite.bounds.size.y < var_246_8 * manager.ui.mainCameraCom_.aspect / var_246_7.sprite.bounds.size.x and var_246_8 * manager.ui.mainCameraCom_.aspect / var_246_7.sprite.bounds.size.x or var_246_8 / var_246_7.sprite.bounds.size.y, var_246_8 / var_246_7.sprite.bounds.size.y < var_246_8 * manager.ui.mainCameraCom_.aspect / var_246_7.sprite.bounds.size.x and var_246_8 * manager.ui.mainCameraCom_.aspect / var_246_7.sprite.bounds.size.x or var_246_8 / var_246_7.sprite.bounds.size.y, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "D06_1" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_9 = 0

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_9 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_10 = 2

			if var_246_9 <= arg_243_1.time_ and arg_243_1.time_ < var_246_9 + var_246_10 then
				local var_246_11 = Color.New(0, 0, 0)

				var_246_11.a = Mathf.Lerp(0, 1, (arg_243_1.time_ - var_246_9) / var_246_10)
				arg_243_1.mask_.color = var_246_11
			end

			if arg_243_1.time_ >= var_246_9 + var_246_10 and arg_243_1.time_ < var_246_9 + var_246_10 + arg_246_0 then
				local var_246_12 = Color.New(0, 0, 0)

				var_246_12.a = 1
				arg_243_1.mask_.color = var_246_12
			end

			local var_246_13 = 2

			if 2 < arg_243_1.time_ and arg_243_1.time_ <= var_246_13 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_14 = 2

			if var_246_13 <= arg_243_1.time_ and arg_243_1.time_ < var_246_13 + var_246_14 then
				local var_246_15 = Color.New(0, 0, 0)

				var_246_15.a = Mathf.Lerp(1, 0, (arg_243_1.time_ - var_246_13) / var_246_14)
				arg_243_1.mask_.color = var_246_15
			end

			if arg_243_1.time_ >= var_246_13 + var_246_14 and arg_243_1.time_ < var_246_13 + var_246_14 + arg_246_0 then
				local var_246_16 = Color.New(0, 0, 0)

				arg_243_1.mask_.enabled = false
				var_246_16.a = 0
				arg_243_1.mask_.color = var_246_16
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_17 = 4
			local var_246_18 = 0.975

			if 4 < arg_243_1.time_ and arg_243_1.time_ <= var_246_17 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_19 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_19:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_243_1.dialogCg_.alpha = arg_247_0
				end))
				var_246_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_20 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(1109402059).content)

				arg_243_1.text_.text = var_246_20

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_22 = 37 <= 0 and var_246_18 or var_246_18 * (utf8.len(var_246_20) / 37)

				if (37 <= 0 and var_246_18 or var_246_18 * (utf8.len(var_246_20) / 37)) > 0 and var_246_18 < var_246_22 then
					arg_243_1.talkMaxDuration = var_246_22
					var_246_17 = var_246_17 + 0.3

					if var_246_22 + var_246_17 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_22 + var_246_17
					end
				end

				arg_243_1.text_.text = var_246_20
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_23 = var_246_17 + 0.3
			local var_246_24 = math.max(var_246_18, arg_243_1.talkMaxDuration)

			if var_246_17 + 0.3 <= arg_243_1.time_ and arg_243_1.time_ < var_246_23 + var_246_24 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_23) / var_246_24

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_23 + var_246_24 and arg_243_1.time_ < var_246_23 + var_246_24 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1109402060
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1109402061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.825

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(1109402060).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 33 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 33)

				if (33 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 33)) > 0 and var_252_0 < var_252_3 then
					arg_249_1.talkMaxDuration = var_252_3

					if var_252_3 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_3 + 0
					end
				end

				arg_249_1.text_.text = var_252_1
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_4 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_4

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1109402061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1109402061
		arg_253_1.duration_ = 1.7

		local var_253_0 = {
			ja = 1.1,
			ko = 1.7,
			zh = 1.7
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
				arg_253_0:Play1109402062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.075

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:GetWordFromCfg(1109402061)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 3 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 3)

				if (3 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 3)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402061", "story_v_side_new_1109402.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402061", "story_v_side_new_1109402.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_side_new_1109402", "1109402061", "story_v_side_new_1109402.awb")

						arg_253_1:RecordAudio("1109402061", var_256_6)
						arg_253_1:RecordAudio("1109402061", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402061", "story_v_side_new_1109402.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402061", "story_v_side_new_1109402.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1109402062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1109402062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1109402063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.6

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1109402062).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 24 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 24)

				if (24 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 24)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play1109402063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1109402063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1109402064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_run", "")
			end

			local var_264_1 = 0
			local var_264_2 = 0.225

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(1109402063).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 9 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 9)

				if (9 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 9)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_6 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_6 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_6

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_6 and arg_261_1.time_ < var_264_1 + var_264_6 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1109402064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1109402064
		arg_265_1.duration_ = 7.2

		local var_265_0 = {
			ja = 7.2,
			ko = 3.5,
			zh = 3.5
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
				arg_265_0:Play1109402065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1094ui_story = arg_265_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1094ui_story"].transform.position).z)
				arg_265_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1094ui_story"].transform.localEulerAngles = arg_265_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_265_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1094ui_story"].transform.position).z)
				arg_265_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1094ui_story"].transform.localEulerAngles = arg_265_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1094ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1094ui_story == nil then
				arg_265_1.var_.characterEffect1094ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect1094ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1094ui_story then
				arg_265_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_268_4 = 0
			local var_268_5 = 0.4

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(1109402064)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 16 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 16)

				if (16 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 16)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402064", "story_v_side_new_1109402.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402064", "story_v_side_new_1109402.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_side_new_1109402", "1109402064", "story_v_side_new_1109402.awb")

						arg_265_1:RecordAudio("1109402064", var_268_11)
						arg_265_1:RecordAudio("1109402064", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402064", "story_v_side_new_1109402.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402064", "story_v_side_new_1109402.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play1109402065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1109402065
		arg_269_1.duration_ = 0.2

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"

			SetActive(arg_269_1.choicesGo_, true)

			for iter_270_0, iter_270_1 in ipairs(arg_269_1.choices_) do
				SetActive(iter_270_1.go, iter_270_0 <= 1)
			end

			arg_269_1.choices_[1].txt.text = arg_269_1:FormatText(StoryChoiceCfg[405].name)
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1109402066(arg_269_1)
			end

			arg_269_1:RecordChoiceLog(1109402065, 405)
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1094ui_story"]) and arg_269_1.var_.characterEffect1094ui_story == nil then
				arg_269_1.var_.characterEffect1094ui_story = arg_269_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1094ui_story"]) then
				if arg_269_1.var_.characterEffect1094ui_story and not isNil(arg_269_1.actors_["1094ui_story"]) then
					arg_269_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1094ui_story"]) and arg_269_1.var_.characterEffect1094ui_story then
				arg_269_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_272_1 = 0

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.allBtn_.enabled = false
			end

			if arg_269_1.time_ >= var_272_1 + 0.200000002980232 and arg_269_1.time_ < var_272_1 + 0.200000002980232 + arg_272_0 then
				arg_269_1.allBtn_.enabled = true
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1109402066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1109402066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1109402067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1094ui_story = arg_273_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1094ui_story"].transform.position).z)
				arg_273_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1094ui_story"].transform.localEulerAngles = arg_273_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1094ui_story"].transform.position).z)
				arg_273_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1094ui_story"].transform.localEulerAngles = arg_273_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["1094ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1094ui_story == nil then
				arg_273_1.var_.characterEffect1094ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect1094ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_2)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1094ui_story then
				arg_273_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_run", "")
			end

			local var_276_4 = 0
			local var_276_5 = 0.225

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(1109402066).content)

				arg_273_1.text_.text = var_276_6

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_8 = 9 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_6) / 9)

				if (9 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_6) / 9)) > 0 and var_276_5 < var_276_8 then
					arg_273_1.talkMaxDuration = var_276_8

					if var_276_8 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_6
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_9 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_9 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_9

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_9 and arg_273_1.time_ < var_276_4 + var_276_9 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play1109402067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1109402067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1109402068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.375

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(1109402067).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 15 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 15)

				if (15 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 15)) > 0 and var_280_0 < var_280_3 then
					arg_277_1.talkMaxDuration = var_280_3

					if var_280_3 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_3 + 0
					end
				end

				arg_277_1.text_.text = var_280_1
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_4 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_4

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1109402068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1109402068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1109402069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_run", "")
			end

			local var_284_1 = 0
			local var_284_2 = 0.325

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(1109402068).content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 13 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 13)

				if (13 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 13)) > 0 and var_284_2 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_1 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_1
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_6 = math.max(var_284_2, arg_281_1.talkMaxDuration)

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_6 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_1) / var_284_6

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_1 + var_284_6 and arg_281_1.time_ < var_284_1 + var_284_6 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play1109402069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1109402069
		arg_285_1.duration_ = 4.6

		local var_285_0 = {
			ja = 4.6,
			ko = 3.066,
			zh = 3.066
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
				arg_285_0:Play1109402070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1094ui_story = arg_285_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1094ui_story"].transform.position).z)
				arg_285_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1094ui_story"].transform.localEulerAngles = arg_285_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_285_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1094ui_story"].transform.position).z)
				arg_285_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1094ui_story"].transform.localEulerAngles = arg_285_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1094ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1094ui_story == nil then
				arg_285_1.var_.characterEffect1094ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect1094ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1094ui_story then
				arg_285_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_288_4 = 0
			local var_288_5 = 0.35

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(1109402069)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 14 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 14)

				if (14 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 14)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402069", "story_v_side_new_1109402.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402069", "story_v_side_new_1109402.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_side_new_1109402", "1109402069", "story_v_side_new_1109402.awb")

						arg_285_1:RecordAudio("1109402069", var_288_11)
						arg_285_1:RecordAudio("1109402069", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402069", "story_v_side_new_1109402.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402069", "story_v_side_new_1109402.awb")
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
				actorName = "1094ui_story",
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
	Play1109402070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1109402070
		arg_289_1.duration_ = 0.2

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"

			SetActive(arg_289_1.choicesGo_, true)

			for iter_290_0, iter_290_1 in ipairs(arg_289_1.choices_) do
				SetActive(iter_290_1.go, iter_290_0 <= 1)
			end

			arg_289_1.choices_[1].txt.text = arg_289_1:FormatText(StoryChoiceCfg[406].name)
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1109402071(arg_289_1)
			end

			arg_289_1:RecordChoiceLog(1109402070, 406)
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1094ui_story"]) and arg_289_1.var_.characterEffect1094ui_story == nil then
				arg_289_1.var_.characterEffect1094ui_story = arg_289_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1094ui_story"]) then
				if arg_289_1.var_.characterEffect1094ui_story and not isNil(arg_289_1.actors_["1094ui_story"]) then
					arg_289_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_0)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1094ui_story"]) and arg_289_1.var_.characterEffect1094ui_story then
				arg_289_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_292_1 = 0

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.allBtn_.enabled = false
			end

			if arg_289_1.time_ >= var_292_1 + 0.200000002980232 and arg_289_1.time_ < var_292_1 + 0.200000002980232 + arg_292_0 then
				arg_289_1.allBtn_.enabled = true
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1109402071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1109402071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1109402072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1094ui_story = arg_293_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1094ui_story"].transform.position).z)
				arg_293_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1094ui_story"].transform.localEulerAngles = arg_293_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_293_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1094ui_story"].transform.position).z)
				arg_293_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1094ui_story"].transform.localEulerAngles = arg_293_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["1094ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1094ui_story == nil then
				arg_293_1.var_.characterEffect1094ui_story = var_296_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 and not isNil(var_296_1) then
				if arg_293_1.var_.characterEffect1094ui_story and not isNil(var_296_1) then
					arg_293_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_2)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1094ui_story then
				arg_293_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_run", "")
			end

			local var_296_4 = 0
			local var_296_5 = 0.25

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_6 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(1109402071).content)

				arg_293_1.text_.text = var_296_6

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_8 = 10 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_6) / 10)

				if (10 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_6) / 10)) > 0 and var_296_5 < var_296_8 then
					arg_293_1.talkMaxDuration = var_296_8

					if var_296_8 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_6
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_9 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_9 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_9

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_9 and arg_293_1.time_ < var_296_4 + var_296_9 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1109402072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1109402073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.5

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
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

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(1109402072).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 20 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 20)

				if (20 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 20)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1109402073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1109402073
		arg_301_1.duration_ = 4.23

		local var_301_0 = {
			ja = 4.233,
			ko = 3.2,
			zh = 3.2
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
				arg_301_0:Play1109402074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.225

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_1 = arg_301_1:GetWordFromCfg(1109402073)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 9 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 9)

				if (9 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 9)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402073", "story_v_side_new_1109402.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402073", "story_v_side_new_1109402.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_side_new_1109402", "1109402073", "story_v_side_new_1109402.awb")

						arg_301_1:RecordAudio("1109402073", var_304_6)
						arg_301_1:RecordAudio("1109402073", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402073", "story_v_side_new_1109402.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402073", "story_v_side_new_1109402.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1109402074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1109402074
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1109402075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.65

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(1109402074).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 26 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 26)

				if (26 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 26)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1109402075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1109402075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1109402076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 1.075

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(1109402075).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 43 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 43)

				if (43 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 43)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1109402076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1109402076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1109402077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.85

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(1109402076).content)

				arg_313_1.text_.text = var_316_1

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_3 = 34 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 34)

				if (34 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 34)) > 0 and var_316_0 < var_316_3 then
					arg_313_1.talkMaxDuration = var_316_3

					if var_316_3 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_3 + 0
					end
				end

				arg_313_1.text_.text = var_316_1
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_4 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_4

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1109402077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1109402077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1109402078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.8

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

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(1109402077).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 32 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 32)

				if (32 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 32)) > 0 and var_320_0 < var_320_3 then
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
	Play1109402078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1109402078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1109402079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.3

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_1 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(1109402078).content)

				arg_321_1.text_.text = var_324_1

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_3 = 12 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 12)

				if (12 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 12)) > 0 and var_324_0 < var_324_3 then
					arg_321_1.talkMaxDuration = var_324_3

					if var_324_3 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_3 + 0
					end
				end

				arg_321_1.text_.text = var_324_1
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_4 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_4

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1109402079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1109402079
		arg_325_1.duration_ = 1.73

		local var_325_0 = {
			ja = 1.566,
			ko = 1.733,
			zh = 1.733
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
				arg_325_0:Play1109402080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1094ui_story = arg_325_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1094ui_story"].transform.position).z)
				arg_325_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1094ui_story"].transform.localEulerAngles = arg_325_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_325_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1094ui_story"].transform.position).z)
				arg_325_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1094ui_story"].transform.localEulerAngles = arg_325_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["1094ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1094ui_story == nil then
				arg_325_1.var_.characterEffect1094ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1094ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1094ui_story then
				arg_325_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_328_4 = 0
			local var_328_5 = 0.125

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_6 = arg_325_1:GetWordFromCfg(1109402079)
				local var_328_7 = arg_325_1:FormatText(var_328_6.content)

				arg_325_1.text_.text = var_328_7

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_9 = 5 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 5)

				if (5 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 5)) > 0 and var_328_5 < var_328_9 then
					arg_325_1.talkMaxDuration = var_328_9

					if var_328_9 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_9 + var_328_4
					end
				end

				arg_325_1.text_.text = var_328_7
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402079", "story_v_side_new_1109402.awb") ~= 0 then
					local var_328_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402079", "story_v_side_new_1109402.awb") / 1000

					if var_328_10 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_4
					end

					if var_328_6.prefab_name ~= "" and arg_325_1.actors_[var_328_6.prefab_name] ~= nil then
						local var_328_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_6.prefab_name].transform, "story_v_side_new_1109402", "1109402079", "story_v_side_new_1109402.awb")

						arg_325_1:RecordAudio("1109402079", var_328_11)
						arg_325_1:RecordAudio("1109402079", var_328_11)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402079", "story_v_side_new_1109402.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402079", "story_v_side_new_1109402.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_12 = math.max(var_328_5, arg_325_1.talkMaxDuration)

			if var_328_4 <= arg_325_1.time_ and arg_325_1.time_ < var_328_4 + var_328_12 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_4) / var_328_12

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_4 + var_328_12 and arg_325_1.time_ < var_328_4 + var_328_12 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1109402080
		arg_329_1.duration_ = 5.2

		local var_329_0 = {
			ja = 5.066,
			ko = 5.2,
			zh = 5.2
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
				arg_329_0:Play1109402081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1094ui_story = arg_329_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1094ui_story"].transform.position).z)
				arg_329_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1094ui_story"].transform.localEulerAngles = arg_329_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_329_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1094ui_story"].transform.position).z)
				arg_329_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1094ui_story"].transform.localEulerAngles = arg_329_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_332_1 = 0
			local var_332_2 = 0.625

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_3 = arg_329_1:GetWordFromCfg(1109402080)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_6 = 25 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_4) / 25)

				if (25 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_4) / 25)) > 0 and var_332_2 < var_332_6 then
					arg_329_1.talkMaxDuration = var_332_6

					if var_332_6 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_6 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_4
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402080", "story_v_side_new_1109402.awb") ~= 0 then
					local var_332_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402080", "story_v_side_new_1109402.awb") / 1000

					if var_332_7 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_1
					end

					if var_332_3.prefab_name ~= "" and arg_329_1.actors_[var_332_3.prefab_name] ~= nil then
						local var_332_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_3.prefab_name].transform, "story_v_side_new_1109402", "1109402080", "story_v_side_new_1109402.awb")

						arg_329_1:RecordAudio("1109402080", var_332_8)
						arg_329_1:RecordAudio("1109402080", var_332_8)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402080", "story_v_side_new_1109402.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402080", "story_v_side_new_1109402.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_9 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_9 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_9

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_9 and arg_329_1.time_ < var_332_1 + var_332_9 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1109402081
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1109402082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1094ui_story"]) and arg_333_1.var_.characterEffect1094ui_story == nil then
				arg_333_1.var_.characterEffect1094ui_story = arg_333_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1094ui_story"]) then
				if arg_333_1.var_.characterEffect1094ui_story and not isNil(arg_333_1.actors_["1094ui_story"]) then
					arg_333_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_0)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1094ui_story"]) and arg_333_1.var_.characterEffect1094ui_story then
				arg_333_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_336_1 = 0
			local var_336_2 = 0.8

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(1109402081).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 32 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 32)

				if (32 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 32)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1109402082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1109402082
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1109402083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.225

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(1109402082).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 9 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 9)

				if (9 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 9)) > 0 and var_340_0 < var_340_3 then
					arg_337_1.talkMaxDuration = var_340_3

					if var_340_3 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_3 + 0
					end
				end

				arg_337_1.text_.text = var_340_1
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_4 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_4

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1109402083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1109402083
		arg_341_1.duration_ = 2

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1109402084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1094ui_story = arg_341_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1094ui_story"].transform.position).z)
				arg_341_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1094ui_story"].transform.localEulerAngles = arg_341_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_341_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1094ui_story"].transform.position).z)
				arg_341_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1094ui_story"].transform.localEulerAngles = arg_341_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1094ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1094ui_story == nil then
				arg_341_1.var_.characterEffect1094ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1094ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1094ui_story then
				arg_341_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_2")
			end

			local var_344_4 = 0
			local var_344_5 = 0.1

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(1109402083)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 4 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 4)

				if (4 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 4)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402083", "story_v_side_new_1109402.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402083", "story_v_side_new_1109402.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_side_new_1109402", "1109402083", "story_v_side_new_1109402.awb")

						arg_341_1:RecordAudio("1109402083", var_344_11)
						arg_341_1:RecordAudio("1109402083", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402083", "story_v_side_new_1109402.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402083", "story_v_side_new_1109402.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1109402084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1109402085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1094ui_story"]) and arg_345_1.var_.characterEffect1094ui_story == nil then
				arg_345_1.var_.characterEffect1094ui_story = arg_345_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1094ui_story"]) then
				if arg_345_1.var_.characterEffect1094ui_story and not isNil(arg_345_1.actors_["1094ui_story"]) then
					arg_345_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_0)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1094ui_story"]) and arg_345_1.var_.characterEffect1094ui_story then
				arg_345_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_348_1 = 0
			local var_348_2 = 0.25

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_3 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(1109402084).content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 10 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 10)

				if (10 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 10)) > 0 and var_348_2 < var_348_5 then
					arg_345_1.talkMaxDuration = var_348_5

					if var_348_5 + var_348_1 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + var_348_1
					end
				end

				arg_345_1.text_.text = var_348_3
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_6 = math.max(var_348_2, arg_345_1.talkMaxDuration)

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_6 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_1) / var_348_6

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_1 + var_348_6 and arg_345_1.time_ < var_348_1 + var_348_6 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1109402085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1109402085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1109402086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.575

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_1 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(1109402085).content)

				arg_349_1.text_.text = var_352_1

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_3 = 23 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 23)

				if (23 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_1) / 23)) > 0 and var_352_0 < var_352_3 then
					arg_349_1.talkMaxDuration = var_352_3

					if var_352_3 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_3 + 0
					end
				end

				arg_349_1.text_.text = var_352_1
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_4 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_4

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play1109402086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1109402086
		arg_353_1.duration_ = 2

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1109402087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1094ui_story = arg_353_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1094ui_story"].transform.position).z)
				arg_353_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1094ui_story"].transform.localEulerAngles = arg_353_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_353_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1094ui_story"].transform.position).z)
				arg_353_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1094ui_story"].transform.localEulerAngles = arg_353_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1094ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1094ui_story == nil then
				arg_353_1.var_.characterEffect1094ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect1094ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1094ui_story then
				arg_353_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			local var_356_4 = 0
			local var_356_5 = 0.05

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_6 = arg_353_1:GetWordFromCfg(1109402086)
				local var_356_7 = arg_353_1:FormatText(var_356_6.content)

				arg_353_1.text_.text = var_356_7

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_9 = 2 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 2)

				if (2 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 2)) > 0 and var_356_5 < var_356_9 then
					arg_353_1.talkMaxDuration = var_356_9

					if var_356_9 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_9 + var_356_4
					end
				end

				arg_353_1.text_.text = var_356_7
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402086", "story_v_side_new_1109402.awb") ~= 0 then
					local var_356_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402086", "story_v_side_new_1109402.awb") / 1000

					if var_356_10 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_4
					end

					if var_356_6.prefab_name ~= "" and arg_353_1.actors_[var_356_6.prefab_name] ~= nil then
						local var_356_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_6.prefab_name].transform, "story_v_side_new_1109402", "1109402086", "story_v_side_new_1109402.awb")

						arg_353_1:RecordAudio("1109402086", var_356_11)
						arg_353_1:RecordAudio("1109402086", var_356_11)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402086", "story_v_side_new_1109402.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402086", "story_v_side_new_1109402.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_12 = math.max(var_356_5, arg_353_1.talkMaxDuration)

			if var_356_4 <= arg_353_1.time_ and arg_353_1.time_ < var_356_4 + var_356_12 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_4) / var_356_12

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_4 + var_356_12 and arg_353_1.time_ < var_356_4 + var_356_12 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109402087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1109402087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1109402088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1094ui_story"]) and arg_357_1.var_.characterEffect1094ui_story == nil then
				arg_357_1.var_.characterEffect1094ui_story = arg_357_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1094ui_story"]) then
				if arg_357_1.var_.characterEffect1094ui_story and not isNil(arg_357_1.actors_["1094ui_story"]) then
					arg_357_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_0)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1094ui_story"]) and arg_357_1.var_.characterEffect1094ui_story then
				arg_357_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_360_1 = 0
			local var_360_2 = 0.275

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_3 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(1109402087).content)

				arg_357_1.text_.text = var_360_3

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 11 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 11)

				if (11 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_3) / 11)) > 0 and var_360_2 < var_360_5 then
					arg_357_1.talkMaxDuration = var_360_5

					if var_360_5 + var_360_1 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + var_360_1
					end
				end

				arg_357_1.text_.text = var_360_3
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_6 = math.max(var_360_2, arg_357_1.talkMaxDuration)

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_6 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_1) / var_360_6

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_1 + var_360_6 and arg_357_1.time_ < var_360_1 + var_360_6 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play1109402088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1109402088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1109402089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.275

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_1 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(1109402088).content)

				arg_361_1.text_.text = var_364_1

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_3 = 11 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 11)

				if (11 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 11)) > 0 and var_364_0 < var_364_3 then
					arg_361_1.talkMaxDuration = var_364_3

					if var_364_3 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_3 + 0
					end
				end

				arg_361_1.text_.text = var_364_1
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_4 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_4

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1109402089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1109402089
		arg_365_1.duration_ = 2.6

		local var_365_0 = {
			ja = 2.6,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1109402090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1094ui_story = arg_365_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_368_0 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 then
				arg_365_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_365_1.time_ - 0) / var_368_0)
				arg_365_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1094ui_story"].transform.position).z)
				arg_365_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1094ui_story"].transform.localEulerAngles = arg_365_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 then
				arg_365_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_365_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1094ui_story"].transform.position).z)
				arg_365_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1094ui_story"].transform.localEulerAngles = arg_365_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_368_1 = arg_365_1.actors_["1094ui_story"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1094ui_story == nil then
				arg_365_1.var_.characterEffect1094ui_story = var_368_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_2 and not isNil(var_368_1) then
				if arg_365_1.var_.characterEffect1094ui_story and not isNil(var_368_1) then
					arg_365_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_2 and arg_365_1.time_ < 0 + var_368_2 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1094ui_story then
				arg_365_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_368_4 = 0
			local var_368_5 = 0.125

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_6 = arg_365_1:GetWordFromCfg(1109402089)
				local var_368_7 = arg_365_1:FormatText(var_368_6.content)

				arg_365_1.text_.text = var_368_7

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_9 = 5 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 5)

				if (5 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 5)) > 0 and var_368_5 < var_368_9 then
					arg_365_1.talkMaxDuration = var_368_9

					if var_368_9 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_9 + var_368_4
					end
				end

				arg_365_1.text_.text = var_368_7
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402089", "story_v_side_new_1109402.awb") ~= 0 then
					local var_368_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402089", "story_v_side_new_1109402.awb") / 1000

					if var_368_10 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_10 + var_368_4
					end

					if var_368_6.prefab_name ~= "" and arg_365_1.actors_[var_368_6.prefab_name] ~= nil then
						local var_368_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_6.prefab_name].transform, "story_v_side_new_1109402", "1109402089", "story_v_side_new_1109402.awb")

						arg_365_1:RecordAudio("1109402089", var_368_11)
						arg_365_1:RecordAudio("1109402089", var_368_11)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402089", "story_v_side_new_1109402.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402089", "story_v_side_new_1109402.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_12 = math.max(var_368_5, arg_365_1.talkMaxDuration)

			if var_368_4 <= arg_365_1.time_ and arg_365_1.time_ < var_368_4 + var_368_12 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_4) / var_368_12

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_4 + var_368_12 and arg_365_1.time_ < var_368_4 + var_368_12 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play1109402090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1109402090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1109402091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1094ui_story"]) and arg_369_1.var_.characterEffect1094ui_story == nil then
				arg_369_1.var_.characterEffect1094ui_story = arg_369_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1094ui_story"]) then
				if arg_369_1.var_.characterEffect1094ui_story and not isNil(arg_369_1.actors_["1094ui_story"]) then
					arg_369_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1094ui_story"]) and arg_369_1.var_.characterEffect1094ui_story then
				arg_369_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_372_1 = 0
			local var_372_2 = 0.6

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(1109402090).content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 24 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 24)

				if (24 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 24)) > 0 and var_372_2 < var_372_5 then
					arg_369_1.talkMaxDuration = var_372_5

					if var_372_5 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_6 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_6 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_6

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_6 and arg_369_1.time_ < var_372_1 + var_372_6 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1109402091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1109402091
		arg_373_1.duration_ = 1.57

		local var_373_0 = {
			ja = 1.266,
			ko = 1.566,
			zh = 1.566
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1109402092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0.05

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_1 = arg_373_1:GetWordFromCfg(1109402091)
				local var_376_2 = arg_373_1:FormatText(var_376_1.content)

				arg_373_1.text_.text = var_376_2

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_4 = 2 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 2)

				if (2 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 2)) > 0 and var_376_0 < var_376_4 then
					arg_373_1.talkMaxDuration = var_376_4

					if var_376_4 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_4 + 0
					end
				end

				arg_373_1.text_.text = var_376_2
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402091", "story_v_side_new_1109402.awb") ~= 0 then
					local var_376_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402091", "story_v_side_new_1109402.awb") / 1000

					if var_376_5 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_5 + 0
					end

					if var_376_1.prefab_name ~= "" and arg_373_1.actors_[var_376_1.prefab_name] ~= nil then
						local var_376_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_1.prefab_name].transform, "story_v_side_new_1109402", "1109402091", "story_v_side_new_1109402.awb")

						arg_373_1:RecordAudio("1109402091", var_376_6)
						arg_373_1:RecordAudio("1109402091", var_376_6)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402091", "story_v_side_new_1109402.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402091", "story_v_side_new_1109402.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_7 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_7 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_7

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_7 and arg_373_1.time_ < 0 + var_376_7 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play1109402092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1109402092
		arg_377_1.duration_ = 6

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1109402093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 2 < arg_377_1.time_ and arg_377_1.time_ <= 2 + arg_380_0 then
				local var_380_0 = arg_377_1.bgs_.I05d

				arg_377_1.bgs_.I05d.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_380_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_380_1 = var_380_0:GetComponent("SpriteRenderer")

				if var_380_1 and var_380_1.sprite then
					local var_380_2 = 2 * (var_380_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_380_0.transform.localScale = Vector3.New(var_380_2 / var_380_1.sprite.bounds.size.y < var_380_2 * manager.ui.mainCameraCom_.aspect / var_380_1.sprite.bounds.size.x and var_380_2 * manager.ui.mainCameraCom_.aspect / var_380_1.sprite.bounds.size.x or var_380_2 / var_380_1.sprite.bounds.size.y, var_380_2 / var_380_1.sprite.bounds.size.y < var_380_2 * manager.ui.mainCameraCom_.aspect / var_380_1.sprite.bounds.size.x and var_380_2 * manager.ui.mainCameraCom_.aspect / var_380_1.sprite.bounds.size.x or var_380_2 / var_380_1.sprite.bounds.size.y, 0)
				end

				for iter_380_0, iter_380_1 in pairs(arg_377_1.bgs_) do
					if iter_380_0 ~= "I05d" then
						iter_380_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_380_3 = 0

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_3 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_4 = 2

			if var_380_3 <= arg_377_1.time_ and arg_377_1.time_ < var_380_3 + var_380_4 then
				local var_380_5 = Color.New(0, 0, 0)

				var_380_5.a = Mathf.Lerp(0, 1, (arg_377_1.time_ - var_380_3) / var_380_4)
				arg_377_1.mask_.color = var_380_5
			end

			if arg_377_1.time_ >= var_380_3 + var_380_4 and arg_377_1.time_ < var_380_3 + var_380_4 + arg_380_0 then
				local var_380_6 = Color.New(0, 0, 0)

				var_380_6.a = 1
				arg_377_1.mask_.color = var_380_6
			end

			local var_380_7 = 2

			if 2 < arg_377_1.time_ and arg_377_1.time_ <= var_380_7 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_8 = 2

			if var_380_7 <= arg_377_1.time_ and arg_377_1.time_ < var_380_7 + var_380_8 then
				local var_380_9 = Color.New(0, 0, 0)

				var_380_9.a = Mathf.Lerp(1, 0, (arg_377_1.time_ - var_380_7) / var_380_8)
				arg_377_1.mask_.color = var_380_9
			end

			if arg_377_1.time_ >= var_380_7 + var_380_8 and arg_377_1.time_ < var_380_7 + var_380_8 + arg_380_0 then
				local var_380_10 = Color.New(0, 0, 0)

				arg_377_1.mask_.enabled = false
				var_380_10.a = 0
				arg_377_1.mask_.color = var_380_10
			end

			local var_380_11 = arg_377_1.actors_["1094ui_story"].transform

			if 4 < arg_377_1.time_ and arg_377_1.time_ <= 4 + arg_380_0 then
				arg_377_1.var_.moveOldPos1094ui_story = var_380_11.localPosition
			end

			local var_380_12 = 0.001

			if 4 <= arg_377_1.time_ and arg_377_1.time_ < 4 + var_380_12 then
				var_380_11.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_377_1.time_ - 4) / var_380_12)
				var_380_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_11.position).x, (manager.ui.mainCamera.transform.position - var_380_11.position).y, (manager.ui.mainCamera.transform.position - var_380_11.position).z)
				var_380_11.localEulerAngles.z = 0
				var_380_11.localEulerAngles.x = 0
				var_380_11.localEulerAngles = var_380_11.localEulerAngles
			end

			if arg_377_1.time_ >= 4 + var_380_12 and arg_377_1.time_ < 4 + var_380_12 + arg_380_0 then
				var_380_11.localPosition = Vector3.New(0, -0.84, -6.1)
				var_380_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_11.position).x, (manager.ui.mainCamera.transform.position - var_380_11.position).y, (manager.ui.mainCamera.transform.position - var_380_11.position).z)
				var_380_11.localEulerAngles.z = 0
				var_380_11.localEulerAngles.x = 0
				var_380_11.localEulerAngles = var_380_11.localEulerAngles
			end

			local var_380_13 = arg_377_1.actors_["1094ui_story"]

			if 4 < arg_377_1.time_ and arg_377_1.time_ <= 4 + arg_380_0 and not isNil(var_380_13) and arg_377_1.var_.characterEffect1094ui_story == nil then
				arg_377_1.var_.characterEffect1094ui_story = var_380_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_14 = 0.200000002980232

			if 4 <= arg_377_1.time_ and arg_377_1.time_ < 4 + var_380_14 and not isNil(var_380_13) then
				if arg_377_1.var_.characterEffect1094ui_story and not isNil(var_380_13) then
					arg_377_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 4 + var_380_14 and arg_377_1.time_ < 4 + var_380_14 + arg_380_0 and not isNil(var_380_13) and arg_377_1.var_.characterEffect1094ui_story then
				arg_377_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 4 < arg_377_1.time_ and arg_377_1.time_ <= 4 + arg_380_0 then
				arg_377_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 4 < arg_377_1.time_ and arg_377_1.time_ <= 4 + arg_380_0 then
				arg_377_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_380_16 = arg_377_1.actors_["1094ui_story"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1094ui_story = var_380_16.localPosition
			end

			local var_380_17 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_17 then
				var_380_16.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_377_1.time_ - 0) / var_380_17)
				var_380_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_16.position).x, (manager.ui.mainCamera.transform.position - var_380_16.position).y, (manager.ui.mainCamera.transform.position - var_380_16.position).z)
				var_380_16.localEulerAngles.z = 0
				var_380_16.localEulerAngles.x = 0
				var_380_16.localEulerAngles = var_380_16.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_17 and arg_377_1.time_ < 0 + var_380_17 + arg_380_0 then
				var_380_16.localPosition = Vector3.New(0, 100, 0)
				var_380_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_380_16.position).x, (manager.ui.mainCamera.transform.position - var_380_16.position).y, (manager.ui.mainCamera.transform.position - var_380_16.position).z)
				var_380_16.localEulerAngles.z = 0
				var_380_16.localEulerAngles.x = 0
				var_380_16.localEulerAngles = var_380_16.localEulerAngles
			end

			if arg_377_1.frameCnt_ <= 1 then
				arg_377_1.dialog_:SetActive(false)
			end

			local var_380_18 = 4
			local var_380_19 = 0.125

			if 4 < arg_377_1.time_ and arg_377_1.time_ <= var_380_18 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0

				arg_377_1.dialog_:SetActive(true)

				arg_377_1.dialogCg_.alpha = 0

				local var_380_20 = LeanTween.value(arg_377_1.dialog_, 0, 1, 0.3)

				var_380_20:setOnUpdate(LuaHelper.FloatAction(function(arg_381_0)
					arg_377_1.dialogCg_.alpha = arg_381_0
				end))
				var_380_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_377_1.dialog_)
					var_380_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_377_1.duration_ = arg_377_1.duration_ + 0.3

				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_21 = arg_377_1:GetWordFromCfg(1109402092)
				local var_380_22 = arg_377_1:FormatText(var_380_21.content)

				arg_377_1.text_.text = var_380_22

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_24 = 5 <= 0 and var_380_19 or var_380_19 * (utf8.len(var_380_22) / 5)

				if (5 <= 0 and var_380_19 or var_380_19 * (utf8.len(var_380_22) / 5)) > 0 and var_380_19 < var_380_24 then
					arg_377_1.talkMaxDuration = var_380_24
					var_380_18 = var_380_18 + 0.3

					if var_380_24 + var_380_18 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_24 + var_380_18
					end
				end

				arg_377_1.text_.text = var_380_22
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402092", "story_v_side_new_1109402.awb") ~= 0 then
					local var_380_25 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402092", "story_v_side_new_1109402.awb") / 1000

					if var_380_25 + var_380_18 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_25 + var_380_18
					end

					if var_380_21.prefab_name ~= "" and arg_377_1.actors_[var_380_21.prefab_name] ~= nil then
						local var_380_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_21.prefab_name].transform, "story_v_side_new_1109402", "1109402092", "story_v_side_new_1109402.awb")

						arg_377_1:RecordAudio("1109402092", var_380_26)
						arg_377_1:RecordAudio("1109402092", var_380_26)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402092", "story_v_side_new_1109402.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402092", "story_v_side_new_1109402.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_27 = var_380_18 + 0.3
			local var_380_28 = math.max(var_380_19, arg_377_1.talkMaxDuration)

			if var_380_18 + 0.3 <= arg_377_1.time_ and arg_377_1.time_ < var_380_27 + var_380_28 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_27) / var_380_28

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_27 + var_380_28 and arg_377_1.time_ < var_380_27 + var_380_28 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play1109402093 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1109402093
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1109402094(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1094ui_story"]) and arg_383_1.var_.characterEffect1094ui_story == nil then
				arg_383_1.var_.characterEffect1094ui_story = arg_383_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1094ui_story"]) then
				if arg_383_1.var_.characterEffect1094ui_story and not isNil(arg_383_1.actors_["1094ui_story"]) then
					arg_383_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_0)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1094ui_story"]) and arg_383_1.var_.characterEffect1094ui_story then
				arg_383_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_386_1 = 0
			local var_386_2 = 0.65

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_3 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1109402093).content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 26 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 26)

				if (26 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 26)) > 0 and var_386_2 < var_386_5 then
					arg_383_1.talkMaxDuration = var_386_5

					if var_386_5 + var_386_1 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + var_386_1
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_6 = math.max(var_386_2, arg_383_1.talkMaxDuration)

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_6 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_1) / var_386_6

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_1 + var_386_6 and arg_383_1.time_ < var_386_1 + var_386_6 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1109402094 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1109402094
		arg_387_1.duration_ = 4.6

		local var_387_0 = {
			ja = 1.999999999999,
			ko = 4.6,
			zh = 4.6
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1109402095(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1094ui_story = arg_387_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_390_0 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 then
				arg_387_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_387_1.time_ - 0) / var_390_0)
				arg_387_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1094ui_story"].transform.position).z)
				arg_387_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1094ui_story"].transform.localEulerAngles = arg_387_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 then
				arg_387_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_387_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1094ui_story"].transform.position).z)
				arg_387_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1094ui_story"].transform.localEulerAngles = arg_387_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_390_1 = arg_387_1.actors_["1094ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1094ui_story == nil then
				arg_387_1.var_.characterEffect1094ui_story = var_390_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_2 and not isNil(var_390_1) then
				if arg_387_1.var_.characterEffect1094ui_story and not isNil(var_390_1) then
					arg_387_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_2 and arg_387_1.time_ < 0 + var_390_2 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1094ui_story then
				arg_387_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_390_4 = 0
			local var_390_5 = 0.225

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_4 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_6 = arg_387_1:GetWordFromCfg(1109402094)
				local var_390_7 = arg_387_1:FormatText(var_390_6.content)

				arg_387_1.text_.text = var_390_7

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_9 = 9 <= 0 and var_390_5 or var_390_5 * (utf8.len(var_390_7) / 9)

				if (9 <= 0 and var_390_5 or var_390_5 * (utf8.len(var_390_7) / 9)) > 0 and var_390_5 < var_390_9 then
					arg_387_1.talkMaxDuration = var_390_9

					if var_390_9 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_9 + var_390_4
					end
				end

				arg_387_1.text_.text = var_390_7
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402094", "story_v_side_new_1109402.awb") ~= 0 then
					local var_390_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402094", "story_v_side_new_1109402.awb") / 1000

					if var_390_10 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_10 + var_390_4
					end

					if var_390_6.prefab_name ~= "" and arg_387_1.actors_[var_390_6.prefab_name] ~= nil then
						local var_390_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_6.prefab_name].transform, "story_v_side_new_1109402", "1109402094", "story_v_side_new_1109402.awb")

						arg_387_1:RecordAudio("1109402094", var_390_11)
						arg_387_1:RecordAudio("1109402094", var_390_11)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402094", "story_v_side_new_1109402.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402094", "story_v_side_new_1109402.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_12 = math.max(var_390_5, arg_387_1.talkMaxDuration)

			if var_390_4 <= arg_387_1.time_ and arg_387_1.time_ < var_390_4 + var_390_12 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_4) / var_390_12

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_4 + var_390_12 and arg_387_1.time_ < var_390_4 + var_390_12 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play1109402095 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1109402095
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1109402096(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1094ui_story"]) and arg_391_1.var_.characterEffect1094ui_story == nil then
				arg_391_1.var_.characterEffect1094ui_story = arg_391_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1094ui_story"]) then
				if arg_391_1.var_.characterEffect1094ui_story and not isNil(arg_391_1.actors_["1094ui_story"]) then
					arg_391_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_0)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1094ui_story"]) and arg_391_1.var_.characterEffect1094ui_story then
				arg_391_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_394_1 = 0
			local var_394_2 = 0.55

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_391_1.callingController_:SetSelectedState("normal")

				arg_391_1.keyicon_.color = Color.New(1, 1, 1)
				arg_391_1.icon_.color = Color.New(1, 1, 1)

				local var_394_3 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1109402095).content)

				arg_391_1.text_.text = var_394_3

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 22 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 22)

				if (22 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 22)) > 0 and var_394_2 < var_394_5 then
					arg_391_1.talkMaxDuration = var_394_5

					if var_394_5 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + var_394_1
					end
				end

				arg_391_1.text_.text = var_394_3
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_6 = math.max(var_394_2, arg_391_1.talkMaxDuration)

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_6 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_1) / var_394_6

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_1 + var_394_6 and arg_391_1.time_ < var_394_1 + var_394_6 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1109402096 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1109402096
		arg_395_1.duration_ = 3.6

		local var_395_0 = {
			ja = 3.6,
			ko = 3,
			zh = 3
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
				arg_395_0:Play1109402097(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0.325

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, true)
				arg_395_1.iconController_:SetSelectedState("hero")

				arg_395_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_395_1.callingController_:SetSelectedState("normal")

				arg_395_1.keyicon_.color = Color.New(1, 1, 1)
				arg_395_1.icon_.color = Color.New(1, 1, 1)

				local var_398_1 = arg_395_1:GetWordFromCfg(1109402096)
				local var_398_2 = arg_395_1:FormatText(var_398_1.content)

				arg_395_1.text_.text = var_398_2

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_4 = 13 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 13)

				if (13 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 13)) > 0 and var_398_0 < var_398_4 then
					arg_395_1.talkMaxDuration = var_398_4

					if var_398_4 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_4 + 0
					end
				end

				arg_395_1.text_.text = var_398_2
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402096", "story_v_side_new_1109402.awb") ~= 0 then
					local var_398_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402096", "story_v_side_new_1109402.awb") / 1000

					if var_398_5 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + 0
					end

					if var_398_1.prefab_name ~= "" and arg_395_1.actors_[var_398_1.prefab_name] ~= nil then
						local var_398_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_1.prefab_name].transform, "story_v_side_new_1109402", "1109402096", "story_v_side_new_1109402.awb")

						arg_395_1:RecordAudio("1109402096", var_398_6)
						arg_395_1:RecordAudio("1109402096", var_398_6)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402096", "story_v_side_new_1109402.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402096", "story_v_side_new_1109402.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_7 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_7 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_7

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_7 and arg_395_1.time_ < 0 + var_398_7 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1109402097 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1109402097
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1109402098(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.575

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(1109402097).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 23 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 23)

				if (23 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 23)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1109402098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1109402098
		arg_403_1.duration_ = 3.43

		local var_403_0 = {
			ja = 1.999999999999,
			ko = 3.433,
			zh = 3.433
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1109402099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1094ui_story = arg_403_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1094ui_story"].transform.position).z)
				arg_403_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1094ui_story"].transform.localEulerAngles = arg_403_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_403_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1094ui_story"].transform.position).z)
				arg_403_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1094ui_story"].transform.localEulerAngles = arg_403_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1094ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1094ui_story == nil then
				arg_403_1.var_.characterEffect1094ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect1094ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1094ui_story then
				arg_403_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_2")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_406_4 = 0
			local var_406_5 = 0.25

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_6 = arg_403_1:GetWordFromCfg(1109402098)
				local var_406_7 = arg_403_1:FormatText(var_406_6.content)

				arg_403_1.text_.text = var_406_7

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_9 = 10 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 10)

				if (10 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_7) / 10)) > 0 and var_406_5 < var_406_9 then
					arg_403_1.talkMaxDuration = var_406_9

					if var_406_9 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_9 + var_406_4
					end
				end

				arg_403_1.text_.text = var_406_7
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402098", "story_v_side_new_1109402.awb") ~= 0 then
					local var_406_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402098", "story_v_side_new_1109402.awb") / 1000

					if var_406_10 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_4
					end

					if var_406_6.prefab_name ~= "" and arg_403_1.actors_[var_406_6.prefab_name] ~= nil then
						local var_406_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_6.prefab_name].transform, "story_v_side_new_1109402", "1109402098", "story_v_side_new_1109402.awb")

						arg_403_1:RecordAudio("1109402098", var_406_11)
						arg_403_1:RecordAudio("1109402098", var_406_11)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402098", "story_v_side_new_1109402.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402098", "story_v_side_new_1109402.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_12 = math.max(var_406_5, arg_403_1.talkMaxDuration)

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_12 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_4) / var_406_12

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_4 + var_406_12 and arg_403_1.time_ < var_406_4 + var_406_12 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play1109402099 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1109402099
		arg_407_1.duration_ = 11.57

		local var_407_0 = {
			ja = 11.566,
			ko = 5.866,
			zh = 5.866
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1109402100(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["1094ui_story"]) and arg_407_1.var_.characterEffect1094ui_story == nil then
				arg_407_1.var_.characterEffect1094ui_story = arg_407_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["1094ui_story"]) then
				if arg_407_1.var_.characterEffect1094ui_story and not isNil(arg_407_1.actors_["1094ui_story"]) then
					arg_407_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_0)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["1094ui_story"]) and arg_407_1.var_.characterEffect1094ui_story then
				arg_407_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_410_1 = 0
			local var_410_2 = 0.65

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, true)
				arg_407_1.iconController_:SetSelectedState("hero")

				arg_407_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_407_1.callingController_:SetSelectedState("normal")

				arg_407_1.keyicon_.color = Color.New(1, 1, 1)
				arg_407_1.icon_.color = Color.New(1, 1, 1)

				local var_410_3 = arg_407_1:GetWordFromCfg(1109402099)
				local var_410_4 = arg_407_1:FormatText(var_410_3.content)

				arg_407_1.text_.text = var_410_4

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_6 = 26 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_4) / 26)

				if (26 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_4) / 26)) > 0 and var_410_2 < var_410_6 then
					arg_407_1.talkMaxDuration = var_410_6

					if var_410_6 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_6 + var_410_1
					end
				end

				arg_407_1.text_.text = var_410_4
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402099", "story_v_side_new_1109402.awb") ~= 0 then
					local var_410_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402099", "story_v_side_new_1109402.awb") / 1000

					if var_410_7 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_1
					end

					if var_410_3.prefab_name ~= "" and arg_407_1.actors_[var_410_3.prefab_name] ~= nil then
						local var_410_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_3.prefab_name].transform, "story_v_side_new_1109402", "1109402099", "story_v_side_new_1109402.awb")

						arg_407_1:RecordAudio("1109402099", var_410_8)
						arg_407_1:RecordAudio("1109402099", var_410_8)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402099", "story_v_side_new_1109402.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402099", "story_v_side_new_1109402.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_9 = math.max(var_410_2, arg_407_1.talkMaxDuration)

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_9 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_1) / var_410_9

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_1 + var_410_9 and arg_407_1.time_ < var_410_1 + var_410_9 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1109402100 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1109402100
		arg_411_1.duration_ = 8.9

		local var_411_0 = {
			ja = 8.9,
			ko = 6.3,
			zh = 6.3
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1109402101(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.8

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_1 = arg_411_1:GetWordFromCfg(1109402100)
				local var_414_2 = arg_411_1:FormatText(var_414_1.content)

				arg_411_1.text_.text = var_414_2

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_4 = 32 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_2) / 32)

				if (32 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_2) / 32)) > 0 and var_414_0 < var_414_4 then
					arg_411_1.talkMaxDuration = var_414_4

					if var_414_4 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_4 + 0
					end
				end

				arg_411_1.text_.text = var_414_2
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402100", "story_v_side_new_1109402.awb") ~= 0 then
					local var_414_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402100", "story_v_side_new_1109402.awb") / 1000

					if var_414_5 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + 0
					end

					if var_414_1.prefab_name ~= "" and arg_411_1.actors_[var_414_1.prefab_name] ~= nil then
						local var_414_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_1.prefab_name].transform, "story_v_side_new_1109402", "1109402100", "story_v_side_new_1109402.awb")

						arg_411_1:RecordAudio("1109402100", var_414_6)
						arg_411_1:RecordAudio("1109402100", var_414_6)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402100", "story_v_side_new_1109402.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402100", "story_v_side_new_1109402.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_7 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_7 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_7

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_7 and arg_411_1.time_ < 0 + var_414_7 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1109402101 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1109402101
		arg_415_1.duration_ = 9

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1109402102(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if arg_415_1.bgs_.ST17 == nil then
				local var_418_0 = Object.Instantiate(arg_415_1.paintGo_)

				var_418_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST17")
				var_418_0.name = "ST17"
				var_418_0.transform.parent = arg_415_1.stage_.transform
				var_418_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_415_1.bgs_.ST17 = var_418_0
			end

			if 2 < arg_415_1.time_ and arg_415_1.time_ <= 2 + arg_418_0 then
				local var_418_1 = arg_415_1.bgs_.ST17

				arg_415_1.bgs_.ST17.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_418_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_418_2 = var_418_1:GetComponent("SpriteRenderer")

				if var_418_2 and var_418_2.sprite then
					local var_418_3 = 2 * (var_418_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_418_1.transform.localScale = Vector3.New(var_418_3 / var_418_2.sprite.bounds.size.y < var_418_3 * manager.ui.mainCameraCom_.aspect / var_418_2.sprite.bounds.size.x and var_418_3 * manager.ui.mainCameraCom_.aspect / var_418_2.sprite.bounds.size.x or var_418_3 / var_418_2.sprite.bounds.size.y, var_418_3 / var_418_2.sprite.bounds.size.y < var_418_3 * manager.ui.mainCameraCom_.aspect / var_418_2.sprite.bounds.size.x and var_418_3 * manager.ui.mainCameraCom_.aspect / var_418_2.sprite.bounds.size.x or var_418_3 / var_418_2.sprite.bounds.size.y, 0)
				end

				for iter_418_0, iter_418_1 in pairs(arg_415_1.bgs_) do
					if iter_418_0 ~= "ST17" then
						iter_418_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_418_4 = 0

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_5 = 2

			if var_418_4 <= arg_415_1.time_ and arg_415_1.time_ < var_418_4 + var_418_5 then
				local var_418_6 = Color.New(0, 0, 0)

				var_418_6.a = Mathf.Lerp(0, 1, (arg_415_1.time_ - var_418_4) / var_418_5)
				arg_415_1.mask_.color = var_418_6
			end

			if arg_415_1.time_ >= var_418_4 + var_418_5 and arg_415_1.time_ < var_418_4 + var_418_5 + arg_418_0 then
				local var_418_7 = Color.New(0, 0, 0)

				var_418_7.a = 1
				arg_415_1.mask_.color = var_418_7
			end

			local var_418_8 = 2

			if 2 < arg_415_1.time_ and arg_415_1.time_ <= var_418_8 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_9 = 2

			if var_418_8 <= arg_415_1.time_ and arg_415_1.time_ < var_418_8 + var_418_9 then
				local var_418_10 = Color.New(0, 0, 0)

				var_418_10.a = Mathf.Lerp(1, 0, (arg_415_1.time_ - var_418_8) / var_418_9)
				arg_415_1.mask_.color = var_418_10
			end

			if arg_415_1.time_ >= var_418_8 + var_418_9 and arg_415_1.time_ < var_418_8 + var_418_9 + arg_418_0 then
				local var_418_11 = Color.New(0, 0, 0)

				arg_415_1.mask_.enabled = false
				var_418_11.a = 0
				arg_415_1.mask_.color = var_418_11
			end

			local var_418_12 = arg_415_1.actors_["1094ui_story"].transform

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos1094ui_story = var_418_12.localPosition
			end

			local var_418_13 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_13 then
				var_418_12.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_415_1.time_ - 0) / var_418_13)
				var_418_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_12.position).x, (manager.ui.mainCamera.transform.position - var_418_12.position).y, (manager.ui.mainCamera.transform.position - var_418_12.position).z)
				var_418_12.localEulerAngles.z = 0
				var_418_12.localEulerAngles.x = 0
				var_418_12.localEulerAngles = var_418_12.localEulerAngles
			end

			if arg_415_1.time_ >= 0 + var_418_13 and arg_415_1.time_ < 0 + var_418_13 + arg_418_0 then
				var_418_12.localPosition = Vector3.New(0, 100, 0)
				var_418_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_418_12.position).x, (manager.ui.mainCamera.transform.position - var_418_12.position).y, (manager.ui.mainCamera.transform.position - var_418_12.position).z)
				var_418_12.localEulerAngles.z = 0
				var_418_12.localEulerAngles.x = 0
				var_418_12.localEulerAngles = var_418_12.localEulerAngles
			end

			local var_418_14 = arg_415_1.actors_["1094ui_story"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_14) and arg_415_1.var_.characterEffect1094ui_story == nil then
				arg_415_1.var_.characterEffect1094ui_story = var_418_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_15 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_15 and not isNil(var_418_14) then
				if arg_415_1.var_.characterEffect1094ui_story and not isNil(var_418_14) then
					arg_415_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_415_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_415_1.time_ - 0) / var_418_15)
				end
			end

			if arg_415_1.time_ >= 0 + var_418_15 and arg_415_1.time_ < 0 + var_418_15 + arg_418_0 and not isNil(var_418_14) and arg_415_1.var_.characterEffect1094ui_story then
				arg_415_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_415_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			if arg_415_1.frameCnt_ <= 1 then
				arg_415_1.dialog_:SetActive(false)
			end

			local var_418_16 = 4
			local var_418_17 = 0.4

			if 4 < arg_415_1.time_ and arg_415_1.time_ <= var_418_16 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				arg_415_1.dialog_:SetActive(true)

				arg_415_1.dialogCg_.alpha = 0

				local var_418_18 = LeanTween.value(arg_415_1.dialog_, 0, 1, 0.3)

				var_418_18:setOnUpdate(LuaHelper.FloatAction(function(arg_419_0)
					arg_415_1.dialogCg_.alpha = arg_419_0
				end))
				var_418_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_415_1.dialog_)
					var_418_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_415_1.duration_ = arg_415_1.duration_ + 0.3

				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_19 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(1109402101).content)

				arg_415_1.text_.text = var_418_19

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_21 = 16 <= 0 and var_418_17 or var_418_17 * (utf8.len(var_418_19) / 16)

				if (16 <= 0 and var_418_17 or var_418_17 * (utf8.len(var_418_19) / 16)) > 0 and var_418_17 < var_418_21 then
					arg_415_1.talkMaxDuration = var_418_21
					var_418_16 = var_418_16 + 0.3

					if var_418_21 + var_418_16 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_21 + var_418_16
					end
				end

				arg_415_1.text_.text = var_418_19
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_22 = var_418_16 + 0.3
			local var_418_23 = math.max(var_418_17, arg_415_1.talkMaxDuration)

			if var_418_16 + 0.3 <= arg_415_1.time_ and arg_415_1.time_ < var_418_22 + var_418_23 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_22) / var_418_23

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_22 + var_418_23 and arg_415_1.time_ < var_418_22 + var_418_23 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play1109402102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1109402102
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1109402103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 1.075

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, false)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_1 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(1109402102).content)

				arg_421_1.text_.text = var_424_1

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_3 = 43 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_1) / 43)

				if (43 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_1) / 43)) > 0 and var_424_0 < var_424_3 then
					arg_421_1.talkMaxDuration = var_424_3

					if var_424_3 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_3 + 0
					end
				end

				arg_421_1.text_.text = var_424_1
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_4 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_4 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_4

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_4 and arg_421_1.time_ < 0 + var_424_4 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1109402103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1109402103
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1109402104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.575

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_1 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(1109402103).content)

				arg_425_1.text_.text = var_428_1

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_3 = 23 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 23)

				if (23 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 23)) > 0 and var_428_0 < var_428_3 then
					arg_425_1.talkMaxDuration = var_428_3

					if var_428_3 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_3 + 0
					end
				end

				arg_425_1.text_.text = var_428_1
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_4 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_4

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1109402104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1109402104
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1109402105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 1.85

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_1 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(1109402104).content)

				arg_429_1.text_.text = var_432_1

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_3 = 74 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 74)

				if (74 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_1) / 74)) > 0 and var_432_0 < var_432_3 then
					arg_429_1.talkMaxDuration = var_432_3

					if var_432_3 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_3 + 0
					end
				end

				arg_429_1.text_.text = var_432_1
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_4 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_4

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1109402105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1109402105
		arg_433_1.duration_ = 7.97

		local var_433_0 = {
			ja = 7.966,
			ko = 6.166,
			zh = 6.166
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1109402106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0.475

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_1 = arg_433_1:GetWordFromCfg(1109402105)
				local var_436_2 = arg_433_1:FormatText(var_436_1.content)

				arg_433_1.text_.text = var_436_2

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_4 = 19 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_2) / 19)

				if (19 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_2) / 19)) > 0 and var_436_0 < var_436_4 then
					arg_433_1.talkMaxDuration = var_436_4

					if var_436_4 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_4 + 0
					end
				end

				arg_433_1.text_.text = var_436_2
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402105", "story_v_side_new_1109402.awb") ~= 0 then
					local var_436_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402105", "story_v_side_new_1109402.awb") / 1000

					if var_436_5 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_5 + 0
					end

					if var_436_1.prefab_name ~= "" and arg_433_1.actors_[var_436_1.prefab_name] ~= nil then
						local var_436_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_1.prefab_name].transform, "story_v_side_new_1109402", "1109402105", "story_v_side_new_1109402.awb")

						arg_433_1:RecordAudio("1109402105", var_436_6)
						arg_433_1:RecordAudio("1109402105", var_436_6)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402105", "story_v_side_new_1109402.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402105", "story_v_side_new_1109402.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_7 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_7 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_7

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_7 and arg_433_1.time_ < 0 + var_436_7 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1109402106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1109402106
		arg_437_1.duration_ = 13.2

		local var_437_0 = {
			ja = 13.2,
			ko = 8.633,
			zh = 8.633
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1109402107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos1094ui_story = arg_437_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_440_0 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 then
				arg_437_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_437_1.time_ - 0) / var_440_0)
				arg_437_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1094ui_story"].transform.position).z)
				arg_437_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1094ui_story"].transform.localEulerAngles = arg_437_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 then
				arg_437_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_437_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1094ui_story"].transform.position).z)
				arg_437_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1094ui_story"].transform.localEulerAngles = arg_437_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_440_1 = arg_437_1.actors_["1094ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1094ui_story == nil then
				arg_437_1.var_.characterEffect1094ui_story = var_440_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 and not isNil(var_440_1) then
				if arg_437_1.var_.characterEffect1094ui_story and not isNil(var_440_1) then
					arg_437_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1094ui_story then
				arg_437_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_440_4 = 0
			local var_440_5 = 0.8

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_4 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_6 = arg_437_1:GetWordFromCfg(1109402106)
				local var_440_7 = arg_437_1:FormatText(var_440_6.content)

				arg_437_1.text_.text = var_440_7

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_9 = 32 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 32)

				if (32 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 32)) > 0 and var_440_5 < var_440_9 then
					arg_437_1.talkMaxDuration = var_440_9

					if var_440_9 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_9 + var_440_4
					end
				end

				arg_437_1.text_.text = var_440_7
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402106", "story_v_side_new_1109402.awb") ~= 0 then
					local var_440_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402106", "story_v_side_new_1109402.awb") / 1000

					if var_440_10 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_10 + var_440_4
					end

					if var_440_6.prefab_name ~= "" and arg_437_1.actors_[var_440_6.prefab_name] ~= nil then
						local var_440_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_6.prefab_name].transform, "story_v_side_new_1109402", "1109402106", "story_v_side_new_1109402.awb")

						arg_437_1:RecordAudio("1109402106", var_440_11)
						arg_437_1:RecordAudio("1109402106", var_440_11)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402106", "story_v_side_new_1109402.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402106", "story_v_side_new_1109402.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_12 = math.max(var_440_5, arg_437_1.talkMaxDuration)

			if var_440_4 <= arg_437_1.time_ and arg_437_1.time_ < var_440_4 + var_440_12 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_4) / var_440_12

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_4 + var_440_12 and arg_437_1.time_ < var_440_4 + var_440_12 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play1109402107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1109402107
		arg_441_1.duration_ = 3.87

		local var_441_0 = {
			ja = 3.866,
			ko = 1.633,
			zh = 1.633
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1109402108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["1094ui_story"]) and arg_441_1.var_.characterEffect1094ui_story == nil then
				arg_441_1.var_.characterEffect1094ui_story = arg_441_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_0 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["1094ui_story"]) then
				if arg_441_1.var_.characterEffect1094ui_story and not isNil(arg_441_1.actors_["1094ui_story"]) then
					arg_441_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_441_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_441_1.time_ - 0) / var_444_0)
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["1094ui_story"]) and arg_441_1.var_.characterEffect1094ui_story then
				arg_441_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_441_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_444_1 = 0
			local var_444_2 = 0.125

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_3 = arg_441_1:GetWordFromCfg(1109402107)
				local var_444_4 = arg_441_1:FormatText(var_444_3.content)

				arg_441_1.text_.text = var_444_4

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_6 = 5 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_4) / 5)

				if (5 <= 0 and var_444_2 or var_444_2 * (utf8.len(var_444_4) / 5)) > 0 and var_444_2 < var_444_6 then
					arg_441_1.talkMaxDuration = var_444_6

					if var_444_6 + var_444_1 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_6 + var_444_1
					end
				end

				arg_441_1.text_.text = var_444_4
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402107", "story_v_side_new_1109402.awb") ~= 0 then
					local var_444_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402107", "story_v_side_new_1109402.awb") / 1000

					if var_444_7 + var_444_1 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_1
					end

					if var_444_3.prefab_name ~= "" and arg_441_1.actors_[var_444_3.prefab_name] ~= nil then
						local var_444_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_3.prefab_name].transform, "story_v_side_new_1109402", "1109402107", "story_v_side_new_1109402.awb")

						arg_441_1:RecordAudio("1109402107", var_444_8)
						arg_441_1:RecordAudio("1109402107", var_444_8)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402107", "story_v_side_new_1109402.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402107", "story_v_side_new_1109402.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_9 = math.max(var_444_2, arg_441_1.talkMaxDuration)

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_9 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_1) / var_444_9

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_1 + var_444_9 and arg_441_1.time_ < var_444_1 + var_444_9 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1109402108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1109402108
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1109402109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0.925

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_1 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(1109402108).content)

				arg_445_1.text_.text = var_448_1

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_3 = 37 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 37)

				if (37 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 37)) > 0 and var_448_0 < var_448_3 then
					arg_445_1.talkMaxDuration = var_448_3

					if var_448_3 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_3 + 0
					end
				end

				arg_445_1.text_.text = var_448_1
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_4 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_4 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_4

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_4 and arg_445_1.time_ < 0 + var_448_4 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1109402109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1109402109
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1109402110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0.25

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_1 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(1109402109).content)

				arg_449_1.text_.text = var_452_1

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_3 = 10 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 10)

				if (10 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 10)) > 0 and var_452_0 < var_452_3 then
					arg_449_1.talkMaxDuration = var_452_3

					if var_452_3 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_3 + 0
					end
				end

				arg_449_1.text_.text = var_452_1
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_4 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_4

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1109402110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1109402110
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1109402111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1094ui_story = arg_453_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1094ui_story"].transform.position).z)
				arg_453_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1094ui_story"].transform.localEulerAngles = arg_453_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_453_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1094ui_story"].transform.position).z)
				arg_453_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1094ui_story"].transform.localEulerAngles = arg_453_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_456_1 = 0
			local var_456_2 = 0.85

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_3 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(1109402110).content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 33 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 33)

				if (33 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 33)) > 0 and var_456_2 < var_456_5 then
					arg_453_1.talkMaxDuration = var_456_5

					if var_456_5 + var_456_1 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + var_456_1
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_6 = math.max(var_456_2, arg_453_1.talkMaxDuration)

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_6 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_1) / var_456_6

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_1 + var_456_6 and arg_453_1.time_ < var_456_1 + var_456_6 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play1109402111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1109402111
		arg_457_1.duration_ = 4.1

		local var_457_0 = {
			ja = 4.1,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1109402112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1094ui_story = arg_457_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1094ui_story"].transform.position).z)
				arg_457_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1094ui_story"].transform.localEulerAngles = arg_457_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_457_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1094ui_story"].transform.position).z)
				arg_457_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1094ui_story"].transform.localEulerAngles = arg_457_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_460_1 = arg_457_1.actors_["1094ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1094ui_story == nil then
				arg_457_1.var_.characterEffect1094ui_story = var_460_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_2 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_2 and not isNil(var_460_1) then
				if arg_457_1.var_.characterEffect1094ui_story and not isNil(var_460_1) then
					arg_457_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_2 and arg_457_1.time_ < 0 + var_460_2 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1094ui_story then
				arg_457_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094actionlink/1094action454")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_460_4 = 0
			local var_460_5 = 0.15

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_4 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_6 = arg_457_1:GetWordFromCfg(1109402111)
				local var_460_7 = arg_457_1:FormatText(var_460_6.content)

				arg_457_1.text_.text = var_460_7

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_9 = 6 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 6)

				if (6 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 6)) > 0 and var_460_5 < var_460_9 then
					arg_457_1.talkMaxDuration = var_460_9

					if var_460_9 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_9 + var_460_4
					end
				end

				arg_457_1.text_.text = var_460_7
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402111", "story_v_side_new_1109402.awb") ~= 0 then
					local var_460_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402111", "story_v_side_new_1109402.awb") / 1000

					if var_460_10 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_10 + var_460_4
					end

					if var_460_6.prefab_name ~= "" and arg_457_1.actors_[var_460_6.prefab_name] ~= nil then
						local var_460_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_6.prefab_name].transform, "story_v_side_new_1109402", "1109402111", "story_v_side_new_1109402.awb")

						arg_457_1:RecordAudio("1109402111", var_460_11)
						arg_457_1:RecordAudio("1109402111", var_460_11)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402111", "story_v_side_new_1109402.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402111", "story_v_side_new_1109402.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_12 = math.max(var_460_5, arg_457_1.talkMaxDuration)

			if var_460_4 <= arg_457_1.time_ and arg_457_1.time_ < var_460_4 + var_460_12 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_4) / var_460_12

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_4 + var_460_12 and arg_457_1.time_ < var_460_4 + var_460_12 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play1109402112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1109402112
		arg_461_1.duration_ = 5.27

		local var_461_0 = {
			ja = 5.266,
			ko = 4.8,
			zh = 4.8
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1109402113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["1094ui_story"]) and arg_461_1.var_.characterEffect1094ui_story == nil then
				arg_461_1.var_.characterEffect1094ui_story = arg_461_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["1094ui_story"]) then
				if arg_461_1.var_.characterEffect1094ui_story and not isNil(arg_461_1.actors_["1094ui_story"]) then
					arg_461_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_0)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["1094ui_story"]) and arg_461_1.var_.characterEffect1094ui_story then
				arg_461_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_464_1 = 0
			local var_464_2 = 0.575

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:GetWordFromCfg(1109402112)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_6 = 23 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_4) / 23)

				if (23 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_4) / 23)) > 0 and var_464_2 < var_464_6 then
					arg_461_1.talkMaxDuration = var_464_6

					if var_464_6 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_6 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_4
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402112", "story_v_side_new_1109402.awb") ~= 0 then
					local var_464_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402112", "story_v_side_new_1109402.awb") / 1000

					if var_464_7 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_1
					end

					if var_464_3.prefab_name ~= "" and arg_461_1.actors_[var_464_3.prefab_name] ~= nil then
						local var_464_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_3.prefab_name].transform, "story_v_side_new_1109402", "1109402112", "story_v_side_new_1109402.awb")

						arg_461_1:RecordAudio("1109402112", var_464_8)
						arg_461_1:RecordAudio("1109402112", var_464_8)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402112", "story_v_side_new_1109402.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402112", "story_v_side_new_1109402.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_9 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_9 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_9

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_9 and arg_461_1.time_ < var_464_1 + var_464_9 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1109402113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1109402113
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1109402114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_468_0 = 0
			local var_468_1 = 0.6

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_2 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(1109402113).content)

				arg_465_1.text_.text = var_468_2

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_4 = 24 <= 0 and var_468_1 or var_468_1 * (utf8.len(var_468_2) / 24)

				if (24 <= 0 and var_468_1 or var_468_1 * (utf8.len(var_468_2) / 24)) > 0 and var_468_1 < var_468_4 then
					arg_465_1.talkMaxDuration = var_468_4

					if var_468_4 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_4 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_2
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_5 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_5 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_5

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_5 and arg_465_1.time_ < var_468_0 + var_468_5 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1109402114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1109402114
		arg_469_1.duration_ = 5.23

		local var_469_0 = {
			ja = 5.233,
			ko = 3.566,
			zh = 3.566
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1109402115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.325

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_1 = arg_469_1:GetWordFromCfg(1109402114)
				local var_472_2 = arg_469_1:FormatText(var_472_1.content)

				arg_469_1.text_.text = var_472_2

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_4 = 13 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 13)

				if (13 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 13)) > 0 and var_472_0 < var_472_4 then
					arg_469_1.talkMaxDuration = var_472_4

					if var_472_4 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_4 + 0
					end
				end

				arg_469_1.text_.text = var_472_2
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402114", "story_v_side_new_1109402.awb") ~= 0 then
					local var_472_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402114", "story_v_side_new_1109402.awb") / 1000

					if var_472_5 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + 0
					end

					if var_472_1.prefab_name ~= "" and arg_469_1.actors_[var_472_1.prefab_name] ~= nil then
						local var_472_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_1.prefab_name].transform, "story_v_side_new_1109402", "1109402114", "story_v_side_new_1109402.awb")

						arg_469_1:RecordAudio("1109402114", var_472_6)
						arg_469_1:RecordAudio("1109402114", var_472_6)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402114", "story_v_side_new_1109402.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402114", "story_v_side_new_1109402.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_7 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_7 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_7

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_7 and arg_469_1.time_ < 0 + var_472_7 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1109402115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1109402115
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1109402116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.8

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_1 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(1109402115).content)

				arg_473_1.text_.text = var_476_1

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_3 = 32 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 32)

				if (32 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_1) / 32)) > 0 and var_476_0 < var_476_3 then
					arg_473_1.talkMaxDuration = var_476_3

					if var_476_3 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_3 + 0
					end
				end

				arg_473_1.text_.text = var_476_1
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_4 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_4 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_4

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_4 and arg_473_1.time_ < 0 + var_476_4 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1109402116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1109402116
		arg_477_1.duration_ = 2

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1109402117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos1094ui_story = arg_477_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_480_0 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 then
				arg_477_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_477_1.time_ - 0) / var_480_0)
				arg_477_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1094ui_story"].transform.position).z)
				arg_477_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1094ui_story"].transform.localEulerAngles = arg_477_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 then
				arg_477_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_477_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1094ui_story"].transform.position).z)
				arg_477_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1094ui_story"].transform.localEulerAngles = arg_477_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_480_1 = arg_477_1.actors_["1094ui_story"]

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1094ui_story == nil then
				arg_477_1.var_.characterEffect1094ui_story = var_480_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_2 and not isNil(var_480_1) then
				if arg_477_1.var_.characterEffect1094ui_story and not isNil(var_480_1) then
					arg_477_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_2 and arg_477_1.time_ < 0 + var_480_2 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1094ui_story then
				arg_477_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_2")
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_480_4 = 0
			local var_480_5 = 0.1

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_6 = arg_477_1:GetWordFromCfg(1109402116)
				local var_480_7 = arg_477_1:FormatText(var_480_6.content)

				arg_477_1.text_.text = var_480_7

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_9 = 4 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_7) / 4)

				if (4 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_7) / 4)) > 0 and var_480_5 < var_480_9 then
					arg_477_1.talkMaxDuration = var_480_9

					if var_480_9 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_9 + var_480_4
					end
				end

				arg_477_1.text_.text = var_480_7
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402116", "story_v_side_new_1109402.awb") ~= 0 then
					local var_480_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402116", "story_v_side_new_1109402.awb") / 1000

					if var_480_10 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_10 + var_480_4
					end

					if var_480_6.prefab_name ~= "" and arg_477_1.actors_[var_480_6.prefab_name] ~= nil then
						local var_480_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_6.prefab_name].transform, "story_v_side_new_1109402", "1109402116", "story_v_side_new_1109402.awb")

						arg_477_1:RecordAudio("1109402116", var_480_11)
						arg_477_1:RecordAudio("1109402116", var_480_11)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402116", "story_v_side_new_1109402.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402116", "story_v_side_new_1109402.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_12 = math.max(var_480_5, arg_477_1.talkMaxDuration)

			if var_480_4 <= arg_477_1.time_ and arg_477_1.time_ < var_480_4 + var_480_12 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_4) / var_480_12

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_4 + var_480_12 and arg_477_1.time_ < var_480_4 + var_480_12 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play1109402117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1109402117
		arg_481_1.duration_ = 7.07

		local var_481_0 = {
			ja = 7.066,
			ko = 6.166,
			zh = 6.166
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1109402118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(arg_481_1.actors_["1094ui_story"]) and arg_481_1.var_.characterEffect1094ui_story == nil then
				arg_481_1.var_.characterEffect1094ui_story = arg_481_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_0 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 and not isNil(arg_481_1.actors_["1094ui_story"]) then
				if arg_481_1.var_.characterEffect1094ui_story and not isNil(arg_481_1.actors_["1094ui_story"]) then
					arg_481_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_481_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_481_1.time_ - 0) / var_484_0)
				end
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 and not isNil(arg_481_1.actors_["1094ui_story"]) and arg_481_1.var_.characterEffect1094ui_story then
				arg_481_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_481_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_484_1 = 0
			local var_484_2 = 0.825

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_3 = arg_481_1:GetWordFromCfg(1109402117)
				local var_484_4 = arg_481_1:FormatText(var_484_3.content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_6 = 33 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_4) / 33)

				if (33 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_4) / 33)) > 0 and var_484_2 < var_484_6 then
					arg_481_1.talkMaxDuration = var_484_6

					if var_484_6 + var_484_1 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_6 + var_484_1
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402117", "story_v_side_new_1109402.awb") ~= 0 then
					local var_484_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402117", "story_v_side_new_1109402.awb") / 1000

					if var_484_7 + var_484_1 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_1
					end

					if var_484_3.prefab_name ~= "" and arg_481_1.actors_[var_484_3.prefab_name] ~= nil then
						local var_484_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_3.prefab_name].transform, "story_v_side_new_1109402", "1109402117", "story_v_side_new_1109402.awb")

						arg_481_1:RecordAudio("1109402117", var_484_8)
						arg_481_1:RecordAudio("1109402117", var_484_8)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402117", "story_v_side_new_1109402.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402117", "story_v_side_new_1109402.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_9 = math.max(var_484_2, arg_481_1.talkMaxDuration)

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_9 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_1) / var_484_9

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_1 + var_484_9 and arg_481_1.time_ < var_484_1 + var_484_9 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1109402118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1109402118
		arg_485_1.duration_ = 6.73

		local var_485_0 = {
			ja = 3.566,
			ko = 6.733,
			zh = 6.733
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1109402119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.55

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_1 = arg_485_1:GetWordFromCfg(1109402118)
				local var_488_2 = arg_485_1:FormatText(var_488_1.content)

				arg_485_1.text_.text = var_488_2

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_4 = 22 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 22)

				if (22 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 22)) > 0 and var_488_0 < var_488_4 then
					arg_485_1.talkMaxDuration = var_488_4

					if var_488_4 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_4 + 0
					end
				end

				arg_485_1.text_.text = var_488_2
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402118", "story_v_side_new_1109402.awb") ~= 0 then
					local var_488_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402118", "story_v_side_new_1109402.awb") / 1000

					if var_488_5 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_5 + 0
					end

					if var_488_1.prefab_name ~= "" and arg_485_1.actors_[var_488_1.prefab_name] ~= nil then
						local var_488_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_1.prefab_name].transform, "story_v_side_new_1109402", "1109402118", "story_v_side_new_1109402.awb")

						arg_485_1:RecordAudio("1109402118", var_488_6)
						arg_485_1:RecordAudio("1109402118", var_488_6)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402118", "story_v_side_new_1109402.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402118", "story_v_side_new_1109402.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_7 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_7 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_7

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_7 and arg_485_1.time_ < 0 + var_488_7 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1109402119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1109402119
		arg_489_1.duration_ = 9.8

		local var_489_0 = {
			ja = 9.8,
			ko = 6.6,
			zh = 6.6
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1109402120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.775

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_1 = arg_489_1:GetWordFromCfg(1109402119)
				local var_492_2 = arg_489_1:FormatText(var_492_1.content)

				arg_489_1.text_.text = var_492_2

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_4 = 31 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 31)

				if (31 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 31)) > 0 and var_492_0 < var_492_4 then
					arg_489_1.talkMaxDuration = var_492_4

					if var_492_4 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_4 + 0
					end
				end

				arg_489_1.text_.text = var_492_2
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402119", "story_v_side_new_1109402.awb") ~= 0 then
					local var_492_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402119", "story_v_side_new_1109402.awb") / 1000

					if var_492_5 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + 0
					end

					if var_492_1.prefab_name ~= "" and arg_489_1.actors_[var_492_1.prefab_name] ~= nil then
						local var_492_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_1.prefab_name].transform, "story_v_side_new_1109402", "1109402119", "story_v_side_new_1109402.awb")

						arg_489_1:RecordAudio("1109402119", var_492_6)
						arg_489_1:RecordAudio("1109402119", var_492_6)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402119", "story_v_side_new_1109402.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402119", "story_v_side_new_1109402.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_7 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_7

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1109402120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1109402120
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1109402121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.55

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_1 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(1109402120).content)

				arg_493_1.text_.text = var_496_1

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_3 = 22 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 22)

				if (22 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 22)) > 0 and var_496_0 < var_496_3 then
					arg_493_1.talkMaxDuration = var_496_3

					if var_496_3 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_3 + 0
					end
				end

				arg_493_1.text_.text = var_496_1
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_4 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_4 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_4

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_4 and arg_493_1.time_ < 0 + var_496_4 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play1109402121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1109402121
		arg_497_1.duration_ = 2.93

		local var_497_0 = {
			ja = 2.833,
			ko = 2.933,
			zh = 2.933
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1109402122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_500_0 = 0
			local var_500_1 = 0.325

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_2 = arg_497_1:GetWordFromCfg(1109402121)
				local var_500_3 = arg_497_1:FormatText(var_500_2.content)

				arg_497_1.text_.text = var_500_3

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_5 = 13 <= 0 and var_500_1 or var_500_1 * (utf8.len(var_500_3) / 13)

				if (13 <= 0 and var_500_1 or var_500_1 * (utf8.len(var_500_3) / 13)) > 0 and var_500_1 < var_500_5 then
					arg_497_1.talkMaxDuration = var_500_5

					if var_500_5 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + var_500_0
					end
				end

				arg_497_1.text_.text = var_500_3
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402121", "story_v_side_new_1109402.awb") ~= 0 then
					local var_500_6 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402121", "story_v_side_new_1109402.awb") / 1000

					if var_500_6 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_6 + var_500_0
					end

					if var_500_2.prefab_name ~= "" and arg_497_1.actors_[var_500_2.prefab_name] ~= nil then
						local var_500_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_2.prefab_name].transform, "story_v_side_new_1109402", "1109402121", "story_v_side_new_1109402.awb")

						arg_497_1:RecordAudio("1109402121", var_500_7)
						arg_497_1:RecordAudio("1109402121", var_500_7)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402121", "story_v_side_new_1109402.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402121", "story_v_side_new_1109402.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_8 = math.max(var_500_1, arg_497_1.talkMaxDuration)

			if var_500_0 <= arg_497_1.time_ and arg_497_1.time_ < var_500_0 + var_500_8 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_0) / var_500_8

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_0 + var_500_8 and arg_497_1.time_ < var_500_0 + var_500_8 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1109402122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1109402122
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1109402123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0.45

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_1 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(1109402122).content)

				arg_501_1.text_.text = var_504_1

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_3 = 18 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 18)

				if (18 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_1) / 18)) > 0 and var_504_0 < var_504_3 then
					arg_501_1.talkMaxDuration = var_504_3

					if var_504_3 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_3 + 0
					end
				end

				arg_501_1.text_.text = var_504_1
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_4 = math.max(var_504_0, arg_501_1.talkMaxDuration)

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_4 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - 0) / var_504_4

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= 0 + var_504_4 and arg_501_1.time_ < 0 + var_504_4 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1109402123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1109402123
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1109402124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0.375

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_1 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(1109402123).content)

				arg_505_1.text_.text = var_508_1

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_3 = 15 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 15)

				if (15 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 15)) > 0 and var_508_0 < var_508_3 then
					arg_505_1.talkMaxDuration = var_508_3

					if var_508_3 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_3 + 0
					end
				end

				arg_505_1.text_.text = var_508_1
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_4 = math.max(var_508_0, arg_505_1.talkMaxDuration)

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_4 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - 0) / var_508_4

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= 0 + var_508_4 and arg_505_1.time_ < 0 + var_508_4 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1109402124 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1109402124
		arg_509_1.duration_ = 6.27

		local var_509_0 = {
			ja = 6.266,
			ko = 6,
			zh = 6
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1109402125(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0.675

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[426].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_1 = arg_509_1:GetWordFromCfg(1109402124)
				local var_512_2 = arg_509_1:FormatText(var_512_1.content)

				arg_509_1.text_.text = var_512_2

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_4 = 27 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 27)

				if (27 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 27)) > 0 and var_512_0 < var_512_4 then
					arg_509_1.talkMaxDuration = var_512_4

					if var_512_4 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_4 + 0
					end
				end

				arg_509_1.text_.text = var_512_2
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402124", "story_v_side_new_1109402.awb") ~= 0 then
					local var_512_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402124", "story_v_side_new_1109402.awb") / 1000

					if var_512_5 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + 0
					end

					if var_512_1.prefab_name ~= "" and arg_509_1.actors_[var_512_1.prefab_name] ~= nil then
						local var_512_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_1.prefab_name].transform, "story_v_side_new_1109402", "1109402124", "story_v_side_new_1109402.awb")

						arg_509_1:RecordAudio("1109402124", var_512_6)
						arg_509_1:RecordAudio("1109402124", var_512_6)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402124", "story_v_side_new_1109402.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402124", "story_v_side_new_1109402.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_7 = math.max(var_512_0, arg_509_1.talkMaxDuration)

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_7 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - 0) / var_512_7

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= 0 + var_512_7 and arg_509_1.time_ < 0 + var_512_7 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1109402125 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1109402125
		arg_513_1.duration_ = 8.47

		local var_513_0 = {
			ja = 8.466,
			ko = 5.7,
			zh = 5.7
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1109402126(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.575

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_1 = arg_513_1:GetWordFromCfg(1109402125)
				local var_516_2 = arg_513_1:FormatText(var_516_1.content)

				arg_513_1.text_.text = var_516_2

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_4 = 23 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 23)

				if (23 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 23)) > 0 and var_516_0 < var_516_4 then
					arg_513_1.talkMaxDuration = var_516_4

					if var_516_4 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_4 + 0
					end
				end

				arg_513_1.text_.text = var_516_2
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402125", "story_v_side_new_1109402.awb") ~= 0 then
					local var_516_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402125", "story_v_side_new_1109402.awb") / 1000

					if var_516_5 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_5 + 0
					end

					if var_516_1.prefab_name ~= "" and arg_513_1.actors_[var_516_1.prefab_name] ~= nil then
						local var_516_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_1.prefab_name].transform, "story_v_side_new_1109402", "1109402125", "story_v_side_new_1109402.awb")

						arg_513_1:RecordAudio("1109402125", var_516_6)
						arg_513_1:RecordAudio("1109402125", var_516_6)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402125", "story_v_side_new_1109402.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402125", "story_v_side_new_1109402.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_7 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_7 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_7

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_7 and arg_513_1.time_ < 0 + var_516_7 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1109402126 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1109402126
		arg_517_1.duration_ = 7

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1109402127(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if arg_517_1.bgs_.STblack == nil then
				local var_520_0 = Object.Instantiate(arg_517_1.paintGo_)

				var_520_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_520_0.name = "STblack"
				var_520_0.transform.parent = arg_517_1.stage_.transform
				var_520_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_517_1.bgs_.STblack = var_520_0
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				local var_520_1 = arg_517_1.bgs_.STblack

				arg_517_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_520_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_520_2 = var_520_1:GetComponent("SpriteRenderer")

				if var_520_2 and var_520_2.sprite then
					local var_520_3 = 2 * (var_520_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_520_1.transform.localScale = Vector3.New(var_520_3 / var_520_2.sprite.bounds.size.y < var_520_3 * manager.ui.mainCameraCom_.aspect / var_520_2.sprite.bounds.size.x and var_520_3 * manager.ui.mainCameraCom_.aspect / var_520_2.sprite.bounds.size.x or var_520_3 / var_520_2.sprite.bounds.size.y, var_520_3 / var_520_2.sprite.bounds.size.y < var_520_3 * manager.ui.mainCameraCom_.aspect / var_520_2.sprite.bounds.size.x and var_520_3 * manager.ui.mainCameraCom_.aspect / var_520_2.sprite.bounds.size.x or var_520_3 / var_520_2.sprite.bounds.size.y, 0)
				end

				for iter_520_0, iter_520_1 in pairs(arg_517_1.bgs_) do
					if iter_520_0 ~= "STblack" then
						iter_520_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_520_4 = arg_517_1.actors_["1094ui_story"].transform

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.var_.moveOldPos1094ui_story = var_520_4.localPosition
			end

			local var_520_5 = 0.001

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_5 then
				var_520_4.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_517_1.time_ - 0) / var_520_5)
				var_520_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_520_4.position).x, (manager.ui.mainCamera.transform.position - var_520_4.position).y, (manager.ui.mainCamera.transform.position - var_520_4.position).z)
				var_520_4.localEulerAngles.z = 0
				var_520_4.localEulerAngles.x = 0
				var_520_4.localEulerAngles = var_520_4.localEulerAngles
			end

			if arg_517_1.time_ >= 0 + var_520_5 and arg_517_1.time_ < 0 + var_520_5 + arg_520_0 then
				var_520_4.localPosition = Vector3.New(0, 100, 0)
				var_520_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_520_4.position).x, (manager.ui.mainCamera.transform.position - var_520_4.position).y, (manager.ui.mainCamera.transform.position - var_520_4.position).z)
				var_520_4.localEulerAngles.z = 0
				var_520_4.localEulerAngles.x = 0
				var_520_4.localEulerAngles = var_520_4.localEulerAngles
			end

			local var_520_6 = arg_517_1.actors_["1094ui_story"]

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(var_520_6) and arg_517_1.var_.characterEffect1094ui_story == nil then
				arg_517_1.var_.characterEffect1094ui_story = var_520_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_7 = 0.200000002980232

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_7 and not isNil(var_520_6) then
				if arg_517_1.var_.characterEffect1094ui_story and not isNil(var_520_6) then
					arg_517_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_517_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_517_1.time_ - 0) / var_520_7)
				end
			end

			if arg_517_1.time_ >= 0 + var_520_7 and arg_517_1.time_ < 0 + var_520_7 + arg_520_0 and not isNil(var_520_6) and arg_517_1.var_.characterEffect1094ui_story then
				arg_517_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_517_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_520_8 = 0

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_8 + arg_520_0 then
				arg_517_1.mask_.enabled = true
				arg_517_1.mask_.raycastTarget = true

				arg_517_1:SetGaussion(false)
			end

			local var_520_9 = 2

			if var_520_8 <= arg_517_1.time_ and arg_517_1.time_ < var_520_8 + var_520_9 then
				local var_520_10 = Color.New(0, 0, 0)

				var_520_10.a = Mathf.Lerp(1, 0, (arg_517_1.time_ - var_520_8) / var_520_9)
				arg_517_1.mask_.color = var_520_10
			end

			if arg_517_1.time_ >= var_520_8 + var_520_9 and arg_517_1.time_ < var_520_8 + var_520_9 + arg_520_0 then
				local var_520_11 = Color.New(0, 0, 0)

				arg_517_1.mask_.enabled = false
				var_520_11.a = 0
				arg_517_1.mask_.color = var_520_11
			end

			if arg_517_1.frameCnt_ <= 1 then
				arg_517_1.dialog_:SetActive(false)
			end

			local var_520_12 = 2
			local var_520_13 = 0.65

			if 2 < arg_517_1.time_ and arg_517_1.time_ <= var_520_12 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0

				arg_517_1.dialog_:SetActive(true)

				arg_517_1.dialogCg_.alpha = 0

				local var_520_14 = LeanTween.value(arg_517_1.dialog_, 0, 1, 0.3)

				var_520_14:setOnUpdate(LuaHelper.FloatAction(function(arg_521_0)
					arg_517_1.dialogCg_.alpha = arg_521_0
				end))
				var_520_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_517_1.dialog_)
					var_520_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_517_1.duration_ = arg_517_1.duration_ + 0.3

				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_15 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(1109402126).content)

				arg_517_1.text_.text = var_520_15

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_17 = 26 <= 0 and var_520_13 or var_520_13 * (utf8.len(var_520_15) / 26)

				if (26 <= 0 and var_520_13 or var_520_13 * (utf8.len(var_520_15) / 26)) > 0 and var_520_13 < var_520_17 then
					arg_517_1.talkMaxDuration = var_520_17
					var_520_12 = var_520_12 + 0.3

					if var_520_17 + var_520_12 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_17 + var_520_12
					end
				end

				arg_517_1.text_.text = var_520_15
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_18 = var_520_12 + 0.3
			local var_520_19 = math.max(var_520_13, arg_517_1.talkMaxDuration)

			if var_520_12 + 0.3 <= arg_517_1.time_ and arg_517_1.time_ < var_520_18 + var_520_19 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_18) / var_520_19

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_18 + var_520_19 and arg_517_1.time_ < var_520_18 + var_520_19 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_517_1:InitPlayNodeList()
	end,
	Play1109402127 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1109402127
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1109402128(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0.65

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_1 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(1109402127).content)

				arg_523_1.text_.text = var_526_1

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_3 = 26 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 26)

				if (26 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 26)) > 0 and var_526_0 < var_526_3 then
					arg_523_1.talkMaxDuration = var_526_3

					if var_526_3 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_3 + 0
					end
				end

				arg_523_1.text_.text = var_526_1
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_4 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_4

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1109402128 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1109402128
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1109402129(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.675

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, false)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_1 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(1109402128).content)

				arg_527_1.text_.text = var_530_1

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_3 = 27 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 27)

				if (27 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 27)) > 0 and var_530_0 < var_530_3 then
					arg_527_1.talkMaxDuration = var_530_3

					if var_530_3 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_3 + 0
					end
				end

				arg_527_1.text_.text = var_530_1
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_4 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_4 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_4

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_4 and arg_527_1.time_ < 0 + var_530_4 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1109402129 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1109402129
		arg_531_1.duration_ = 7

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1109402130(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if arg_531_1.bgs_.ST03a == nil then
				local var_534_0 = Object.Instantiate(arg_531_1.paintGo_)

				var_534_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03a")
				var_534_0.name = "ST03a"
				var_534_0.transform.parent = arg_531_1.stage_.transform
				var_534_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_531_1.bgs_.ST03a = var_534_0
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				if arg_531_0.sceneSettingEffect_ then
					arg_531_1.sceneSettingEffect_.enabled = false
				end

				arg_531_1.sceneSettingGo_:SetActive(true)

				local var_534_1 = arg_531_1.bgs_.ST03a

				arg_531_1.bgs_.ST03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_534_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_534_2 = var_534_1:GetComponent("SpriteRenderer")

				if var_534_2 and var_534_2.sprite then
					local var_534_3 = 2 * (var_534_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_534_1.transform.localScale = Vector3.New(var_534_3 / var_534_2.sprite.bounds.size.y < var_534_3 * manager.ui.mainCameraCom_.aspect / var_534_2.sprite.bounds.size.x and var_534_3 * manager.ui.mainCameraCom_.aspect / var_534_2.sprite.bounds.size.x or var_534_3 / var_534_2.sprite.bounds.size.y, var_534_3 / var_534_2.sprite.bounds.size.y < var_534_3 * manager.ui.mainCameraCom_.aspect / var_534_2.sprite.bounds.size.x and var_534_3 * manager.ui.mainCameraCom_.aspect / var_534_2.sprite.bounds.size.x or var_534_3 / var_534_2.sprite.bounds.size.y, 0)
				end

				for iter_534_0, iter_534_1 in pairs(arg_531_1.bgs_) do
					if iter_534_0 ~= "ST03a" then
						iter_534_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_534_4 = 0

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_4 + arg_534_0 then
				arg_531_1.mask_.enabled = true
				arg_531_1.mask_.raycastTarget = true

				arg_531_1:SetGaussion(false)
			end

			local var_534_5 = 2

			if var_534_4 <= arg_531_1.time_ and arg_531_1.time_ < var_534_4 + var_534_5 then
				local var_534_6 = Color.New(0, 0, 0)

				var_534_6.a = Mathf.Lerp(1, 0, (arg_531_1.time_ - var_534_4) / var_534_5)
				arg_531_1.mask_.color = var_534_6
			end

			if arg_531_1.time_ >= var_534_4 + var_534_5 and arg_531_1.time_ < var_534_4 + var_534_5 + arg_534_0 then
				local var_534_7 = Color.New(0, 0, 0)

				arg_531_1.mask_.enabled = false
				var_534_7.a = 0
				arg_531_1.mask_.color = var_534_7
			end

			if arg_531_1.frameCnt_ <= 1 then
				arg_531_1.dialog_:SetActive(false)
			end

			local var_534_8 = 2
			local var_534_9 = 0.75

			if 2 < arg_531_1.time_ and arg_531_1.time_ <= var_534_8 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0

				arg_531_1.dialog_:SetActive(true)

				arg_531_1.dialogCg_.alpha = 0

				local var_534_10 = LeanTween.value(arg_531_1.dialog_, 0, 1, 0.3)

				var_534_10:setOnUpdate(LuaHelper.FloatAction(function(arg_535_0)
					arg_531_1.dialogCg_.alpha = arg_535_0
				end))
				var_534_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_531_1.dialog_)
					var_534_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_531_1.duration_ = arg_531_1.duration_ + 0.3

				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_11 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(1109402129).content)

				arg_531_1.text_.text = var_534_11

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_13 = 30 <= 0 and var_534_9 or var_534_9 * (utf8.len(var_534_11) / 30)

				if (30 <= 0 and var_534_9 or var_534_9 * (utf8.len(var_534_11) / 30)) > 0 and var_534_9 < var_534_13 then
					arg_531_1.talkMaxDuration = var_534_13
					var_534_8 = var_534_8 + 0.3

					if var_534_13 + var_534_8 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_13 + var_534_8
					end
				end

				arg_531_1.text_.text = var_534_11
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_14 = var_534_8 + 0.3
			local var_534_15 = math.max(var_534_9, arg_531_1.talkMaxDuration)

			if var_534_8 + 0.3 <= arg_531_1.time_ and arg_531_1.time_ < var_534_14 + var_534_15 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_14) / var_534_15

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_14 + var_534_15 and arg_531_1.time_ < var_534_14 + var_534_15 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1109402130 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1109402130
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1109402131(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0.7

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, false)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_1 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(1109402130).content)

				arg_537_1.text_.text = var_540_1

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_3 = 28 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 28)

				if (28 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 28)) > 0 and var_540_0 < var_540_3 then
					arg_537_1.talkMaxDuration = var_540_3

					if var_540_3 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_3 + 0
					end
				end

				arg_537_1.text_.text = var_540_1
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_4 = math.max(var_540_0, arg_537_1.talkMaxDuration)

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_4 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - 0) / var_540_4

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= 0 + var_540_4 and arg_537_1.time_ < 0 + var_540_4 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1109402131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1109402131
		arg_541_1.duration_ = 6.73

		local var_541_0 = {
			ja = 6.733,
			ko = 5.666,
			zh = 5.666
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1109402132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0.625

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_541_1.callingController_:SetSelectedState("normal")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_1 = arg_541_1:GetWordFromCfg(1109402131)
				local var_544_2 = arg_541_1:FormatText(var_544_1.content)

				arg_541_1.text_.text = var_544_2

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_4 = 25 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 25)

				if (25 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_2) / 25)) > 0 and var_544_0 < var_544_4 then
					arg_541_1.talkMaxDuration = var_544_4

					if var_544_4 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_4 + 0
					end
				end

				arg_541_1.text_.text = var_544_2
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402131", "story_v_side_new_1109402.awb") ~= 0 then
					local var_544_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402131", "story_v_side_new_1109402.awb") / 1000

					if var_544_5 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + 0
					end

					if var_544_1.prefab_name ~= "" and arg_541_1.actors_[var_544_1.prefab_name] ~= nil then
						local var_544_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_1.prefab_name].transform, "story_v_side_new_1109402", "1109402131", "story_v_side_new_1109402.awb")

						arg_541_1:RecordAudio("1109402131", var_544_6)
						arg_541_1:RecordAudio("1109402131", var_544_6)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402131", "story_v_side_new_1109402.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402131", "story_v_side_new_1109402.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_7 = math.max(var_544_0, arg_541_1.talkMaxDuration)

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_7 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - 0) / var_544_7

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= 0 + var_544_7 and arg_541_1.time_ < 0 + var_544_7 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1109402132 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1109402132
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1109402133(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0.875

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_1 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(1109402132).content)

				arg_545_1.text_.text = var_548_1

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_3 = 35 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_1) / 35)

				if (35 <= 0 and var_548_0 or var_548_0 * (utf8.len(var_548_1) / 35)) > 0 and var_548_0 < var_548_3 then
					arg_545_1.talkMaxDuration = var_548_3

					if var_548_3 + 0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_3 + 0
					end
				end

				arg_545_1.text_.text = var_548_1
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_4 = math.max(var_548_0, arg_545_1.talkMaxDuration)

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_4 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - 0) / var_548_4

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= 0 + var_548_4 and arg_545_1.time_ < 0 + var_548_4 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play1109402133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1109402133
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1109402134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0.7

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_1 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(1109402133).content)

				arg_549_1.text_.text = var_552_1

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_3 = 28 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_1) / 28)

				if (28 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_1) / 28)) > 0 and var_552_0 < var_552_3 then
					arg_549_1.talkMaxDuration = var_552_3

					if var_552_3 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_3 + 0
					end
				end

				arg_549_1.text_.text = var_552_1
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_4 = math.max(var_552_0, arg_549_1.talkMaxDuration)

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_4 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - 0) / var_552_4

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= 0 + var_552_4 and arg_549_1.time_ < 0 + var_552_4 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1109402134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1109402134
		arg_553_1.duration_ = 3.17

		local var_553_0 = {
			ja = 3.166,
			ko = 1.233,
			zh = 1.233
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1109402135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos1094ui_story = arg_553_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_556_0 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 then
				arg_553_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_553_1.time_ - 0) / var_556_0)
				arg_553_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_553_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1094ui_story"].transform.position).z)
				arg_553_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_553_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_553_1.actors_["1094ui_story"].transform.localEulerAngles = arg_553_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 then
				arg_553_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_553_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_553_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1094ui_story"].transform.position).z)
				arg_553_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_553_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_553_1.actors_["1094ui_story"].transform.localEulerAngles = arg_553_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_556_1 = arg_553_1.actors_["1094ui_story"]

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect1094ui_story == nil then
				arg_553_1.var_.characterEffect1094ui_story = var_556_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_2 and not isNil(var_556_1) then
				if arg_553_1.var_.characterEffect1094ui_story and not isNil(var_556_1) then
					arg_553_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= 0 + var_556_2 and arg_553_1.time_ < 0 + var_556_2 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect1094ui_story then
				arg_553_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_556_4 = 0
			local var_556_5 = 0.075

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_4 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_6 = arg_553_1:GetWordFromCfg(1109402134)
				local var_556_7 = arg_553_1:FormatText(var_556_6.content)

				arg_553_1.text_.text = var_556_7

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_9 = 3 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 3)

				if (3 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 3)) > 0 and var_556_5 < var_556_9 then
					arg_553_1.talkMaxDuration = var_556_9

					if var_556_9 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_9 + var_556_4
					end
				end

				arg_553_1.text_.text = var_556_7
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402134", "story_v_side_new_1109402.awb") ~= 0 then
					local var_556_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402134", "story_v_side_new_1109402.awb") / 1000

					if var_556_10 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_10 + var_556_4
					end

					if var_556_6.prefab_name ~= "" and arg_553_1.actors_[var_556_6.prefab_name] ~= nil then
						local var_556_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_6.prefab_name].transform, "story_v_side_new_1109402", "1109402134", "story_v_side_new_1109402.awb")

						arg_553_1:RecordAudio("1109402134", var_556_11)
						arg_553_1:RecordAudio("1109402134", var_556_11)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402134", "story_v_side_new_1109402.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402134", "story_v_side_new_1109402.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_12 = math.max(var_556_5, arg_553_1.talkMaxDuration)

			if var_556_4 <= arg_553_1.time_ and arg_553_1.time_ < var_556_4 + var_556_12 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_4) / var_556_12

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_4 + var_556_12 and arg_553_1.time_ < var_556_4 + var_556_12 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_553_1:InitPlayNodeList()
	end,
	Play1109402135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1109402135
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1109402136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["1094ui_story"]) and arg_557_1.var_.characterEffect1094ui_story == nil then
				arg_557_1.var_.characterEffect1094ui_story = arg_557_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_0 = 0.200000002980232

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["1094ui_story"]) then
				if arg_557_1.var_.characterEffect1094ui_story and not isNil(arg_557_1.actors_["1094ui_story"]) then
					arg_557_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_557_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_557_1.time_ - 0) / var_560_0)
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["1094ui_story"]) and arg_557_1.var_.characterEffect1094ui_story then
				arg_557_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_557_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_560_1 = 0
			local var_560_2 = 0.625

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_3 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(1109402135).content)

				arg_557_1.text_.text = var_560_3

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_5 = 25 <= 0 and var_560_2 or var_560_2 * (utf8.len(var_560_3) / 25)

				if (25 <= 0 and var_560_2 or var_560_2 * (utf8.len(var_560_3) / 25)) > 0 and var_560_2 < var_560_5 then
					arg_557_1.talkMaxDuration = var_560_5

					if var_560_5 + var_560_1 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_5 + var_560_1
					end
				end

				arg_557_1.text_.text = var_560_3
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_6 = math.max(var_560_2, arg_557_1.talkMaxDuration)

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_6 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_1) / var_560_6

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_1 + var_560_6 and arg_557_1.time_ < var_560_1 + var_560_6 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1109402136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1109402136
		arg_561_1.duration_ = 5.2

		local var_561_0 = {
			ja = 5.2,
			ko = 3.433,
			zh = 3.433
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1109402137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.var_.moveOldPos1094ui_story = arg_561_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_564_0 = 0.001

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 then
				arg_561_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_561_1.time_ - 0) / var_564_0)
				arg_561_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1094ui_story"].transform.position).z)
				arg_561_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1094ui_story"].transform.localEulerAngles = arg_561_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 then
				arg_561_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_561_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1094ui_story"].transform.position).z)
				arg_561_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1094ui_story"].transform.localEulerAngles = arg_561_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_564_1 = arg_561_1.actors_["1094ui_story"]

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1094ui_story == nil then
				arg_561_1.var_.characterEffect1094ui_story = var_564_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_2 = 0.200000002980232

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_2 and not isNil(var_564_1) then
				if arg_561_1.var_.characterEffect1094ui_story and not isNil(var_564_1) then
					arg_561_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_561_1.time_ >= 0 + var_564_2 and arg_561_1.time_ < 0 + var_564_2 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1094ui_story then
				arg_561_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_564_4 = 0
			local var_564_5 = 0.3

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_4 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_6 = arg_561_1:GetWordFromCfg(1109402136)
				local var_564_7 = arg_561_1:FormatText(var_564_6.content)

				arg_561_1.text_.text = var_564_7

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_9 = 12 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 12)

				if (12 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 12)) > 0 and var_564_5 < var_564_9 then
					arg_561_1.talkMaxDuration = var_564_9

					if var_564_9 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_9 + var_564_4
					end
				end

				arg_561_1.text_.text = var_564_7
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402136", "story_v_side_new_1109402.awb") ~= 0 then
					local var_564_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402136", "story_v_side_new_1109402.awb") / 1000

					if var_564_10 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_10 + var_564_4
					end

					if var_564_6.prefab_name ~= "" and arg_561_1.actors_[var_564_6.prefab_name] ~= nil then
						local var_564_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_6.prefab_name].transform, "story_v_side_new_1109402", "1109402136", "story_v_side_new_1109402.awb")

						arg_561_1:RecordAudio("1109402136", var_564_11)
						arg_561_1:RecordAudio("1109402136", var_564_11)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402136", "story_v_side_new_1109402.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402136", "story_v_side_new_1109402.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_12 = math.max(var_564_5, arg_561_1.talkMaxDuration)

			if var_564_4 <= arg_561_1.time_ and arg_561_1.time_ < var_564_4 + var_564_12 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_4) / var_564_12

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_4 + var_564_12 and arg_561_1.time_ < var_564_4 + var_564_12 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play1109402137 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1109402137
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1109402138(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(arg_565_1.actors_["1094ui_story"]) and arg_565_1.var_.characterEffect1094ui_story == nil then
				arg_565_1.var_.characterEffect1094ui_story = arg_565_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_0 = 0.200000002980232

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 and not isNil(arg_565_1.actors_["1094ui_story"]) then
				if arg_565_1.var_.characterEffect1094ui_story and not isNil(arg_565_1.actors_["1094ui_story"]) then
					arg_565_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_565_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_565_1.time_ - 0) / var_568_0)
				end
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 and not isNil(arg_565_1.actors_["1094ui_story"]) and arg_565_1.var_.characterEffect1094ui_story then
				arg_565_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_565_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_568_1 = 0
			local var_568_2 = 0.425

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, true)
				arg_565_1.iconController_:SetSelectedState("hero")

				arg_565_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_565_1.callingController_:SetSelectedState("normal")

				arg_565_1.keyicon_.color = Color.New(1, 1, 1)
				arg_565_1.icon_.color = Color.New(1, 1, 1)

				local var_568_3 = arg_565_1:FormatText(arg_565_1:GetWordFromCfg(1109402137).content)

				arg_565_1.text_.text = var_568_3

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_5 = 17 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_3) / 17)

				if (17 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_3) / 17)) > 0 and var_568_2 < var_568_5 then
					arg_565_1.talkMaxDuration = var_568_5

					if var_568_5 + var_568_1 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_5 + var_568_1
					end
				end

				arg_565_1.text_.text = var_568_3
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_6 = math.max(var_568_2, arg_565_1.talkMaxDuration)

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_6 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_1) / var_568_6

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_1 + var_568_6 and arg_565_1.time_ < var_568_1 + var_568_6 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1109402138 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1109402138
		arg_569_1.duration_ = 2

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1109402139(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.var_.moveOldPos1094ui_story = arg_569_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_572_0 = 0.001

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_0 then
				arg_569_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_569_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_569_1.time_ - 0) / var_572_0)
				arg_569_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_569_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1094ui_story"].transform.position).z)
				arg_569_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_569_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_569_1.actors_["1094ui_story"].transform.localEulerAngles = arg_569_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_569_1.time_ >= 0 + var_572_0 and arg_569_1.time_ < 0 + var_572_0 + arg_572_0 then
				arg_569_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_569_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_569_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_569_1.actors_["1094ui_story"].transform.position).z)
				arg_569_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_569_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_569_1.actors_["1094ui_story"].transform.localEulerAngles = arg_569_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_572_1 = arg_569_1.actors_["1094ui_story"]

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 and not isNil(var_572_1) and arg_569_1.var_.characterEffect1094ui_story == nil then
				arg_569_1.var_.characterEffect1094ui_story = var_572_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_2 = 0.200000002980232

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_2 and not isNil(var_572_1) then
				if arg_569_1.var_.characterEffect1094ui_story and not isNil(var_572_1) then
					arg_569_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_569_1.time_ >= 0 + var_572_2 and arg_569_1.time_ < 0 + var_572_2 + arg_572_0 and not isNil(var_572_1) and arg_569_1.var_.characterEffect1094ui_story then
				arg_569_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_572_4 = 0
			local var_572_5 = 0.15

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_4 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_6 = arg_569_1:GetWordFromCfg(1109402138)
				local var_572_7 = arg_569_1:FormatText(var_572_6.content)

				arg_569_1.text_.text = var_572_7

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_9 = 6 <= 0 and var_572_5 or var_572_5 * (utf8.len(var_572_7) / 6)

				if (6 <= 0 and var_572_5 or var_572_5 * (utf8.len(var_572_7) / 6)) > 0 and var_572_5 < var_572_9 then
					arg_569_1.talkMaxDuration = var_572_9

					if var_572_9 + var_572_4 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_9 + var_572_4
					end
				end

				arg_569_1.text_.text = var_572_7
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402138", "story_v_side_new_1109402.awb") ~= 0 then
					local var_572_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402138", "story_v_side_new_1109402.awb") / 1000

					if var_572_10 + var_572_4 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_10 + var_572_4
					end

					if var_572_6.prefab_name ~= "" and arg_569_1.actors_[var_572_6.prefab_name] ~= nil then
						local var_572_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_6.prefab_name].transform, "story_v_side_new_1109402", "1109402138", "story_v_side_new_1109402.awb")

						arg_569_1:RecordAudio("1109402138", var_572_11)
						arg_569_1:RecordAudio("1109402138", var_572_11)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402138", "story_v_side_new_1109402.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402138", "story_v_side_new_1109402.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_12 = math.max(var_572_5, arg_569_1.talkMaxDuration)

			if var_572_4 <= arg_569_1.time_ and arg_569_1.time_ < var_572_4 + var_572_12 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_4) / var_572_12

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_4 + var_572_12 and arg_569_1.time_ < var_572_4 + var_572_12 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_569_1:InitPlayNodeList()
	end,
	Play1109402139 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1109402139
		arg_573_1.duration_ = 9

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1109402140(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if arg_573_1.bgs_.I05a == nil then
				local var_576_0 = Object.Instantiate(arg_573_1.paintGo_)

				var_576_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05a")
				var_576_0.name = "I05a"
				var_576_0.transform.parent = arg_573_1.stage_.transform
				var_576_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_573_1.bgs_.I05a = var_576_0
			end

			if 2 < arg_573_1.time_ and arg_573_1.time_ <= 2 + arg_576_0 then
				if arg_573_0.sceneSettingEffect_ then
					arg_573_1.sceneSettingEffect_.enabled = false
				end

				arg_573_1.sceneSettingGo_:SetActive(true)

				local var_576_1 = arg_573_1.bgs_.I05a

				arg_573_1.bgs_.I05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_576_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_576_2 = var_576_1:GetComponent("SpriteRenderer")

				if var_576_2 and var_576_2.sprite then
					local var_576_3 = 2 * (var_576_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_576_1.transform.localScale = Vector3.New(var_576_3 / var_576_2.sprite.bounds.size.y < var_576_3 * manager.ui.mainCameraCom_.aspect / var_576_2.sprite.bounds.size.x and var_576_3 * manager.ui.mainCameraCom_.aspect / var_576_2.sprite.bounds.size.x or var_576_3 / var_576_2.sprite.bounds.size.y, var_576_3 / var_576_2.sprite.bounds.size.y < var_576_3 * manager.ui.mainCameraCom_.aspect / var_576_2.sprite.bounds.size.x and var_576_3 * manager.ui.mainCameraCom_.aspect / var_576_2.sprite.bounds.size.x or var_576_3 / var_576_2.sprite.bounds.size.y, 0)
				end

				for iter_576_0, iter_576_1 in pairs(arg_573_1.bgs_) do
					if iter_576_0 ~= "I05a" then
						iter_576_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_576_4 = 0

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_4 + arg_576_0 then
				arg_573_1.mask_.enabled = true
				arg_573_1.mask_.raycastTarget = true

				arg_573_1:SetGaussion(false)
			end

			local var_576_5 = 2

			if var_576_4 <= arg_573_1.time_ and arg_573_1.time_ < var_576_4 + var_576_5 then
				local var_576_6 = Color.New(0, 0, 0)

				var_576_6.a = Mathf.Lerp(0, 1, (arg_573_1.time_ - var_576_4) / var_576_5)
				arg_573_1.mask_.color = var_576_6
			end

			if arg_573_1.time_ >= var_576_4 + var_576_5 and arg_573_1.time_ < var_576_4 + var_576_5 + arg_576_0 then
				local var_576_7 = Color.New(0, 0, 0)

				var_576_7.a = 1
				arg_573_1.mask_.color = var_576_7
			end

			local var_576_8 = 2

			if 2 < arg_573_1.time_ and arg_573_1.time_ <= var_576_8 + arg_576_0 then
				arg_573_1.mask_.enabled = true
				arg_573_1.mask_.raycastTarget = true

				arg_573_1:SetGaussion(false)
			end

			local var_576_9 = 2

			if var_576_8 <= arg_573_1.time_ and arg_573_1.time_ < var_576_8 + var_576_9 then
				local var_576_10 = Color.New(0, 0, 0)

				var_576_10.a = Mathf.Lerp(1, 0, (arg_573_1.time_ - var_576_8) / var_576_9)
				arg_573_1.mask_.color = var_576_10
			end

			if arg_573_1.time_ >= var_576_8 + var_576_9 and arg_573_1.time_ < var_576_8 + var_576_9 + arg_576_0 then
				local var_576_11 = Color.New(0, 0, 0)

				arg_573_1.mask_.enabled = false
				var_576_11.a = 0
				arg_573_1.mask_.color = var_576_11
			end

			local var_576_12 = arg_573_1.actors_["1094ui_story"].transform

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.var_.moveOldPos1094ui_story = var_576_12.localPosition
			end

			local var_576_13 = 0.001

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_13 then
				var_576_12.localPosition = Vector3.Lerp(arg_573_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_573_1.time_ - 0) / var_576_13)
				var_576_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_576_12.position).x, (manager.ui.mainCamera.transform.position - var_576_12.position).y, (manager.ui.mainCamera.transform.position - var_576_12.position).z)
				var_576_12.localEulerAngles.z = 0
				var_576_12.localEulerAngles.x = 0
				var_576_12.localEulerAngles = var_576_12.localEulerAngles
			end

			if arg_573_1.time_ >= 0 + var_576_13 and arg_573_1.time_ < 0 + var_576_13 + arg_576_0 then
				var_576_12.localPosition = Vector3.New(0, 100, 0)
				var_576_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_576_12.position).x, (manager.ui.mainCamera.transform.position - var_576_12.position).y, (manager.ui.mainCamera.transform.position - var_576_12.position).z)
				var_576_12.localEulerAngles.z = 0
				var_576_12.localEulerAngles.x = 0
				var_576_12.localEulerAngles = var_576_12.localEulerAngles
			end

			local var_576_14 = arg_573_1.actors_["1094ui_story"]

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(var_576_14) and arg_573_1.var_.characterEffect1094ui_story == nil then
				arg_573_1.var_.characterEffect1094ui_story = var_576_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_15 = 0.200000002980232

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_15 and not isNil(var_576_14) then
				if arg_573_1.var_.characterEffect1094ui_story and not isNil(var_576_14) then
					arg_573_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_573_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_573_1.time_ - 0) / var_576_15)
				end
			end

			if arg_573_1.time_ >= 0 + var_576_15 and arg_573_1.time_ < 0 + var_576_15 + arg_576_0 and not isNil(var_576_14) and arg_573_1.var_.characterEffect1094ui_story then
				arg_573_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_573_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			if 4 < arg_573_1.time_ and arg_573_1.time_ <= 4 + arg_576_0 then
				arg_573_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_chime", "")
			end

			if arg_573_1.frameCnt_ <= 1 then
				arg_573_1.dialog_:SetActive(false)
			end

			local var_576_17 = 4
			local var_576_18 = 1

			if 4 < arg_573_1.time_ and arg_573_1.time_ <= var_576_17 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0

				arg_573_1.dialog_:SetActive(true)

				arg_573_1.dialogCg_.alpha = 0

				local var_576_19 = LeanTween.value(arg_573_1.dialog_, 0, 1, 0.3)

				var_576_19:setOnUpdate(LuaHelper.FloatAction(function(arg_577_0)
					arg_573_1.dialogCg_.alpha = arg_577_0
				end))
				var_576_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_573_1.dialog_)
					var_576_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_573_1.duration_ = arg_573_1.duration_ + 0.3

				SetActive(arg_573_1.leftNameGo_, false)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_20 = arg_573_1:FormatText(arg_573_1:GetWordFromCfg(1109402139).content)

				arg_573_1.text_.text = var_576_20

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_22 = 40 <= 0 and var_576_18 or var_576_18 * (utf8.len(var_576_20) / 40)

				if (40 <= 0 and var_576_18 or var_576_18 * (utf8.len(var_576_20) / 40)) > 0 and var_576_18 < var_576_22 then
					arg_573_1.talkMaxDuration = var_576_22
					var_576_17 = var_576_17 + 0.3

					if var_576_22 + var_576_17 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_22 + var_576_17
					end
				end

				arg_573_1.text_.text = var_576_20
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_23 = var_576_17 + 0.3
			local var_576_24 = math.max(var_576_18, arg_573_1.talkMaxDuration)

			if var_576_17 + 0.3 <= arg_573_1.time_ and arg_573_1.time_ < var_576_23 + var_576_24 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_23) / var_576_24

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_23 + var_576_24 and arg_573_1.time_ < var_576_23 + var_576_24 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_573_1:InitPlayNodeList()
	end,
	Play1109402140 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1109402140
		arg_579_1.duration_ = 3.93

		local var_579_0 = {
			ja = 3.933,
			ko = 3.9,
			zh = 3.9
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1109402141(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0.35

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_1 = arg_579_1:GetWordFromCfg(1109402140)
				local var_582_2 = arg_579_1:FormatText(var_582_1.content)

				arg_579_1.text_.text = var_582_2

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_4 = 14 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_2) / 14)

				if (14 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_2) / 14)) > 0 and var_582_0 < var_582_4 then
					arg_579_1.talkMaxDuration = var_582_4

					if var_582_4 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_4 + 0
					end
				end

				arg_579_1.text_.text = var_582_2
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402140", "story_v_side_new_1109402.awb") ~= 0 then
					local var_582_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402140", "story_v_side_new_1109402.awb") / 1000

					if var_582_5 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_5 + 0
					end

					if var_582_1.prefab_name ~= "" and arg_579_1.actors_[var_582_1.prefab_name] ~= nil then
						local var_582_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_1.prefab_name].transform, "story_v_side_new_1109402", "1109402140", "story_v_side_new_1109402.awb")

						arg_579_1:RecordAudio("1109402140", var_582_6)
						arg_579_1:RecordAudio("1109402140", var_582_6)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402140", "story_v_side_new_1109402.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402140", "story_v_side_new_1109402.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_7 = math.max(var_582_0, arg_579_1.talkMaxDuration)

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_7 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - 0) / var_582_7

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= 0 + var_582_7 and arg_579_1.time_ < 0 + var_582_7 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1109402141 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1109402141
		arg_583_1.duration_ = 12.37

		local var_583_0 = {
			ja = 12.366,
			ko = 8.8,
			zh = 8.8
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1109402142(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 1

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, true)
				arg_583_1.iconController_:SetSelectedState("hero")

				arg_583_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_583_1.callingController_:SetSelectedState("normal")

				arg_583_1.keyicon_.color = Color.New(1, 1, 1)
				arg_583_1.icon_.color = Color.New(1, 1, 1)

				local var_586_1 = arg_583_1:GetWordFromCfg(1109402141)
				local var_586_2 = arg_583_1:FormatText(var_586_1.content)

				arg_583_1.text_.text = var_586_2

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_4 = 40 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_2) / 40)

				if (40 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_2) / 40)) > 0 and var_586_0 < var_586_4 then
					arg_583_1.talkMaxDuration = var_586_4

					if var_586_4 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_4 + 0
					end
				end

				arg_583_1.text_.text = var_586_2
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402141", "story_v_side_new_1109402.awb") ~= 0 then
					local var_586_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402141", "story_v_side_new_1109402.awb") / 1000

					if var_586_5 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_5 + 0
					end

					if var_586_1.prefab_name ~= "" and arg_583_1.actors_[var_586_1.prefab_name] ~= nil then
						local var_586_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_1.prefab_name].transform, "story_v_side_new_1109402", "1109402141", "story_v_side_new_1109402.awb")

						arg_583_1:RecordAudio("1109402141", var_586_6)
						arg_583_1:RecordAudio("1109402141", var_586_6)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402141", "story_v_side_new_1109402.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402141", "story_v_side_new_1109402.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_7 = math.max(var_586_0, arg_583_1.talkMaxDuration)

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_7 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - 0) / var_586_7

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= 0 + var_586_7 and arg_583_1.time_ < 0 + var_586_7 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play1109402142 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 1109402142
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play1109402143(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			local var_590_0 = 0.475

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_1 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(1109402142).content)

				arg_587_1.text_.text = var_590_1

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_3 = 19 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_1) / 19)

				if (19 <= 0 and var_590_0 or var_590_0 * (utf8.len(var_590_1) / 19)) > 0 and var_590_0 < var_590_3 then
					arg_587_1.talkMaxDuration = var_590_3

					if var_590_3 + 0 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_3 + 0
					end
				end

				arg_587_1.text_.text = var_590_1
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_4 = math.max(var_590_0, arg_587_1.talkMaxDuration)

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_4 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - 0) / var_590_4

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= 0 + var_590_4 and arg_587_1.time_ < 0 + var_590_4 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play1109402143 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 1109402143
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play1109402144(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0.6

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_1 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(1109402143).content)

				arg_591_1.text_.text = var_594_1

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_3 = 24 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 24)

				if (24 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 24)) > 0 and var_594_0 < var_594_3 then
					arg_591_1.talkMaxDuration = var_594_3

					if var_594_3 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_3 + 0
					end
				end

				arg_591_1.text_.text = var_594_1
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_4 = math.max(var_594_0, arg_591_1.talkMaxDuration)

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_4 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - 0) / var_594_4

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= 0 + var_594_4 and arg_591_1.time_ < 0 + var_594_4 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play1109402144 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 1109402144
		arg_595_1.duration_ = 5.97

		local var_595_0 = {
			ja = 5.433,
			ko = 5.966,
			zh = 5.966
		}
		local var_595_1 = manager.audio:GetLocalizationFlag()

		if var_595_0[var_595_1] ~= nil then
			arg_595_1.duration_ = var_595_0[var_595_1]
		end

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play1109402145(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.var_.moveOldPos1094ui_story = arg_595_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_598_0 = 0.001

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_0 then
				arg_595_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_595_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_595_1.time_ - 0) / var_598_0)
				arg_595_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_595_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_595_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_595_1.actors_["1094ui_story"].transform.position).z)
				arg_595_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_595_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_595_1.actors_["1094ui_story"].transform.localEulerAngles = arg_595_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_595_1.time_ >= 0 + var_598_0 and arg_595_1.time_ < 0 + var_598_0 + arg_598_0 then
				arg_595_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_595_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_595_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_595_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_595_1.actors_["1094ui_story"].transform.position).z)
				arg_595_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_595_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_595_1.actors_["1094ui_story"].transform.localEulerAngles = arg_595_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_598_1 = arg_595_1.actors_["1094ui_story"]

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 and not isNil(var_598_1) and arg_595_1.var_.characterEffect1094ui_story == nil then
				arg_595_1.var_.characterEffect1094ui_story = var_598_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_598_2 = 0.200000002980232

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_2 and not isNil(var_598_1) then
				if arg_595_1.var_.characterEffect1094ui_story and not isNil(var_598_1) then
					arg_595_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_595_1.time_ >= 0 + var_598_2 and arg_595_1.time_ < 0 + var_598_2 + arg_598_0 and not isNil(var_598_1) and arg_595_1.var_.characterEffect1094ui_story then
				arg_595_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_598_4 = 0
			local var_598_5 = 0.575

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= var_598_4 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, false)
				arg_595_1.callingController_:SetSelectedState("normal")

				local var_598_6 = arg_595_1:GetWordFromCfg(1109402144)
				local var_598_7 = arg_595_1:FormatText(var_598_6.content)

				arg_595_1.text_.text = var_598_7

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_9 = 23 <= 0 and var_598_5 or var_598_5 * (utf8.len(var_598_7) / 23)

				if (23 <= 0 and var_598_5 or var_598_5 * (utf8.len(var_598_7) / 23)) > 0 and var_598_5 < var_598_9 then
					arg_595_1.talkMaxDuration = var_598_9

					if var_598_9 + var_598_4 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_9 + var_598_4
					end
				end

				arg_595_1.text_.text = var_598_7
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402144", "story_v_side_new_1109402.awb") ~= 0 then
					local var_598_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402144", "story_v_side_new_1109402.awb") / 1000

					if var_598_10 + var_598_4 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_10 + var_598_4
					end

					if var_598_6.prefab_name ~= "" and arg_595_1.actors_[var_598_6.prefab_name] ~= nil then
						local var_598_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_6.prefab_name].transform, "story_v_side_new_1109402", "1109402144", "story_v_side_new_1109402.awb")

						arg_595_1:RecordAudio("1109402144", var_598_11)
						arg_595_1:RecordAudio("1109402144", var_598_11)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402144", "story_v_side_new_1109402.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402144", "story_v_side_new_1109402.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_12 = math.max(var_598_5, arg_595_1.talkMaxDuration)

			if var_598_4 <= arg_595_1.time_ and arg_595_1.time_ < var_598_4 + var_598_12 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - var_598_4) / var_598_12

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= var_598_4 + var_598_12 and arg_595_1.time_ < var_598_4 + var_598_12 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_595_1:InitPlayNodeList()
	end,
	Play1109402145 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 1109402145
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play1109402146(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 and not isNil(arg_599_1.actors_["1094ui_story"]) and arg_599_1.var_.characterEffect1094ui_story == nil then
				arg_599_1.var_.characterEffect1094ui_story = arg_599_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_602_0 = 0.200000002980232

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_0 and not isNil(arg_599_1.actors_["1094ui_story"]) then
				if arg_599_1.var_.characterEffect1094ui_story and not isNil(arg_599_1.actors_["1094ui_story"]) then
					arg_599_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_599_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_599_1.time_ - 0) / var_602_0)
				end
			end

			if arg_599_1.time_ >= 0 + var_602_0 and arg_599_1.time_ < 0 + var_602_0 + arg_602_0 and not isNil(arg_599_1.actors_["1094ui_story"]) and arg_599_1.var_.characterEffect1094ui_story then
				arg_599_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_599_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_602_1 = 0
			local var_602_2 = 0.1

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= var_602_1 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_3 = arg_599_1:FormatText(arg_599_1:GetWordFromCfg(1109402145).content)

				arg_599_1.text_.text = var_602_3

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_5 = 4 <= 0 and var_602_2 or var_602_2 * (utf8.len(var_602_3) / 4)

				if (4 <= 0 and var_602_2 or var_602_2 * (utf8.len(var_602_3) / 4)) > 0 and var_602_2 < var_602_5 then
					arg_599_1.talkMaxDuration = var_602_5

					if var_602_5 + var_602_1 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_5 + var_602_1
					end
				end

				arg_599_1.text_.text = var_602_3
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_6 = math.max(var_602_2, arg_599_1.talkMaxDuration)

			if var_602_1 <= arg_599_1.time_ and arg_599_1.time_ < var_602_1 + var_602_6 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - var_602_1) / var_602_6

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= var_602_1 + var_602_6 and arg_599_1.time_ < var_602_1 + var_602_6 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play1109402146 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1109402146
		arg_603_1.duration_ = 9.9

		local var_603_0 = {
			ja = 7.433,
			ko = 9.9,
			zh = 9.9
		}
		local var_603_1 = manager.audio:GetLocalizationFlag()

		if var_603_0[var_603_1] ~= nil then
			arg_603_1.duration_ = var_603_0[var_603_1]
		end

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1109402147(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 0.825

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, true)
				arg_603_1.iconController_:SetSelectedState("hero")

				arg_603_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_603_1.callingController_:SetSelectedState("normal")

				arg_603_1.keyicon_.color = Color.New(1, 1, 1)
				arg_603_1.icon_.color = Color.New(1, 1, 1)

				local var_606_1 = arg_603_1:GetWordFromCfg(1109402146)
				local var_606_2 = arg_603_1:FormatText(var_606_1.content)

				arg_603_1.text_.text = var_606_2

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_4 = 37 <= 0 and var_606_0 or var_606_0 * (utf8.len(var_606_2) / 37)

				if (37 <= 0 and var_606_0 or var_606_0 * (utf8.len(var_606_2) / 37)) > 0 and var_606_0 < var_606_4 then
					arg_603_1.talkMaxDuration = var_606_4

					if var_606_4 + 0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_4 + 0
					end
				end

				arg_603_1.text_.text = var_606_2
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402146", "story_v_side_new_1109402.awb") ~= 0 then
					local var_606_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402146", "story_v_side_new_1109402.awb") / 1000

					if var_606_5 + 0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_5 + 0
					end

					if var_606_1.prefab_name ~= "" and arg_603_1.actors_[var_606_1.prefab_name] ~= nil then
						local var_606_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_1.prefab_name].transform, "story_v_side_new_1109402", "1109402146", "story_v_side_new_1109402.awb")

						arg_603_1:RecordAudio("1109402146", var_606_6)
						arg_603_1:RecordAudio("1109402146", var_606_6)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402146", "story_v_side_new_1109402.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402146", "story_v_side_new_1109402.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_7 = math.max(var_606_0, arg_603_1.talkMaxDuration)

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_7 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - 0) / var_606_7

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= 0 + var_606_7 and arg_603_1.time_ < 0 + var_606_7 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1109402147 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1109402147
		arg_607_1.duration_ = 6.1

		local var_607_0 = {
			ja = 6.1,
			ko = 4.3,
			zh = 4.3
		}
		local var_607_1 = manager.audio:GetLocalizationFlag()

		if var_607_0[var_607_1] ~= nil then
			arg_607_1.duration_ = var_607_0[var_607_1]
		end

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1109402148(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1.var_.moveOldPos1094ui_story = arg_607_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_610_0 = 0.001

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_0 then
				arg_607_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_607_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_607_1.time_ - 0) / var_610_0)
				arg_607_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_607_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_607_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_607_1.actors_["1094ui_story"].transform.position).z)
				arg_607_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_607_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_607_1.actors_["1094ui_story"].transform.localEulerAngles = arg_607_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_607_1.time_ >= 0 + var_610_0 and arg_607_1.time_ < 0 + var_610_0 + arg_610_0 then
				arg_607_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_607_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_607_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_607_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_607_1.actors_["1094ui_story"].transform.position).z)
				arg_607_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_607_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_607_1.actors_["1094ui_story"].transform.localEulerAngles = arg_607_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_610_1 = arg_607_1.actors_["1094ui_story"]

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 and not isNil(var_610_1) and arg_607_1.var_.characterEffect1094ui_story == nil then
				arg_607_1.var_.characterEffect1094ui_story = var_610_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_2 = 0.200000002980232

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_2 and not isNil(var_610_1) then
				if arg_607_1.var_.characterEffect1094ui_story and not isNil(var_610_1) then
					arg_607_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_607_1.time_ >= 0 + var_610_2 and arg_607_1.time_ < 0 + var_610_2 + arg_610_0 and not isNil(var_610_1) and arg_607_1.var_.characterEffect1094ui_story then
				arg_607_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_610_4 = 0
			local var_610_5 = 0.35

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_4 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_6 = arg_607_1:GetWordFromCfg(1109402147)
				local var_610_7 = arg_607_1:FormatText(var_610_6.content)

				arg_607_1.text_.text = var_610_7

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_9 = 14 <= 0 and var_610_5 or var_610_5 * (utf8.len(var_610_7) / 14)

				if (14 <= 0 and var_610_5 or var_610_5 * (utf8.len(var_610_7) / 14)) > 0 and var_610_5 < var_610_9 then
					arg_607_1.talkMaxDuration = var_610_9

					if var_610_9 + var_610_4 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_9 + var_610_4
					end
				end

				arg_607_1.text_.text = var_610_7
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402147", "story_v_side_new_1109402.awb") ~= 0 then
					local var_610_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402147", "story_v_side_new_1109402.awb") / 1000

					if var_610_10 + var_610_4 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_10 + var_610_4
					end

					if var_610_6.prefab_name ~= "" and arg_607_1.actors_[var_610_6.prefab_name] ~= nil then
						local var_610_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_607_1.actors_[var_610_6.prefab_name].transform, "story_v_side_new_1109402", "1109402147", "story_v_side_new_1109402.awb")

						arg_607_1:RecordAudio("1109402147", var_610_11)
						arg_607_1:RecordAudio("1109402147", var_610_11)
					else
						arg_607_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402147", "story_v_side_new_1109402.awb")
					end

					arg_607_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402147", "story_v_side_new_1109402.awb")
				end

				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_12 = math.max(var_610_5, arg_607_1.talkMaxDuration)

			if var_610_4 <= arg_607_1.time_ and arg_607_1.time_ < var_610_4 + var_610_12 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_4) / var_610_12

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_4 + var_610_12 and arg_607_1.time_ < var_610_4 + var_610_12 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_607_1:InitPlayNodeList()
	end,
	Play1109402148 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1109402148
		arg_611_1.duration_ = 7.3

		local var_611_0 = {
			ja = 7.3,
			ko = 2.733,
			zh = 2.733
		}
		local var_611_1 = manager.audio:GetLocalizationFlag()

		if var_611_0[var_611_1] ~= nil then
			arg_611_1.duration_ = var_611_0[var_611_1]
		end

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1109402149(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(arg_611_1.actors_["1094ui_story"]) and arg_611_1.var_.characterEffect1094ui_story == nil then
				arg_611_1.var_.characterEffect1094ui_story = arg_611_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_0 = 0.200000002980232

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_0 and not isNil(arg_611_1.actors_["1094ui_story"]) then
				if arg_611_1.var_.characterEffect1094ui_story and not isNil(arg_611_1.actors_["1094ui_story"]) then
					arg_611_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_611_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_611_1.time_ - 0) / var_614_0)
				end
			end

			if arg_611_1.time_ >= 0 + var_614_0 and arg_611_1.time_ < 0 + var_614_0 + arg_614_0 and not isNil(arg_611_1.actors_["1094ui_story"]) and arg_611_1.var_.characterEffect1094ui_story then
				arg_611_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_611_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_614_1 = 0
			local var_614_2 = 0.275

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_3 = arg_611_1:GetWordFromCfg(1109402148)
				local var_614_4 = arg_611_1:FormatText(var_614_3.content)

				arg_611_1.text_.text = var_614_4

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_6 = 11 <= 0 and var_614_2 or var_614_2 * (utf8.len(var_614_4) / 11)

				if (11 <= 0 and var_614_2 or var_614_2 * (utf8.len(var_614_4) / 11)) > 0 and var_614_2 < var_614_6 then
					arg_611_1.talkMaxDuration = var_614_6

					if var_614_6 + var_614_1 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_6 + var_614_1
					end
				end

				arg_611_1.text_.text = var_614_4
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402148", "story_v_side_new_1109402.awb") ~= 0 then
					local var_614_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402148", "story_v_side_new_1109402.awb") / 1000

					if var_614_7 + var_614_1 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_7 + var_614_1
					end

					if var_614_3.prefab_name ~= "" and arg_611_1.actors_[var_614_3.prefab_name] ~= nil then
						local var_614_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_3.prefab_name].transform, "story_v_side_new_1109402", "1109402148", "story_v_side_new_1109402.awb")

						arg_611_1:RecordAudio("1109402148", var_614_8)
						arg_611_1:RecordAudio("1109402148", var_614_8)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402148", "story_v_side_new_1109402.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402148", "story_v_side_new_1109402.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_9 = math.max(var_614_2, arg_611_1.talkMaxDuration)

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_9 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_1) / var_614_9

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_1 + var_614_9 and arg_611_1.time_ < var_614_1 + var_614_9 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play1109402149 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1109402149
		arg_615_1.duration_ = 5.47

		local var_615_0 = {
			ja = 5.466,
			ko = 3,
			zh = 3
		}
		local var_615_1 = manager.audio:GetLocalizationFlag()

		if var_615_0[var_615_1] ~= nil then
			arg_615_1.duration_ = var_615_0[var_615_1]
		end

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1109402150(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0.375

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				arg_615_1.leftNameTxt_.text = arg_615_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_1 = arg_615_1:GetWordFromCfg(1109402149)
				local var_618_2 = arg_615_1:FormatText(var_618_1.content)

				arg_615_1.text_.text = var_618_2

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_4 = 15 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_2) / 15)

				if (15 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_2) / 15)) > 0 and var_618_0 < var_618_4 then
					arg_615_1.talkMaxDuration = var_618_4

					if var_618_4 + 0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_4 + 0
					end
				end

				arg_615_1.text_.text = var_618_2
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402149", "story_v_side_new_1109402.awb") ~= 0 then
					local var_618_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402149", "story_v_side_new_1109402.awb") / 1000

					if var_618_5 + 0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_5 + 0
					end

					if var_618_1.prefab_name ~= "" and arg_615_1.actors_[var_618_1.prefab_name] ~= nil then
						local var_618_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_615_1.actors_[var_618_1.prefab_name].transform, "story_v_side_new_1109402", "1109402149", "story_v_side_new_1109402.awb")

						arg_615_1:RecordAudio("1109402149", var_618_6)
						arg_615_1:RecordAudio("1109402149", var_618_6)
					else
						arg_615_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402149", "story_v_side_new_1109402.awb")
					end

					arg_615_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402149", "story_v_side_new_1109402.awb")
				end

				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_7 = math.max(var_618_0, arg_615_1.talkMaxDuration)

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_7 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - 0) / var_618_7

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= 0 + var_618_7 and arg_615_1.time_ < 0 + var_618_7 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1109402150 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1109402150
		arg_619_1.duration_ = 2.5

		local var_619_0 = {
			ja = 2.5,
			ko = 2.433,
			zh = 2.433
		}
		local var_619_1 = manager.audio:GetLocalizationFlag()

		if var_619_0[var_619_1] ~= nil then
			arg_619_1.duration_ = var_619_0[var_619_1]
		end

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1109402151(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.var_.moveOldPos1094ui_story = arg_619_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_622_0 = 0.001

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_0 then
				arg_619_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_619_1.time_ - 0) / var_622_0)
				arg_619_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_619_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1094ui_story"].transform.position).z)
				arg_619_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_619_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_619_1.actors_["1094ui_story"].transform.localEulerAngles = arg_619_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_619_1.time_ >= 0 + var_622_0 and arg_619_1.time_ < 0 + var_622_0 + arg_622_0 then
				arg_619_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_619_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_619_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_619_1.actors_["1094ui_story"].transform.position).z)
				arg_619_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_619_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_619_1.actors_["1094ui_story"].transform.localEulerAngles = arg_619_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_622_1 = arg_619_1.actors_["1094ui_story"]

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 and not isNil(var_622_1) and arg_619_1.var_.characterEffect1094ui_story == nil then
				arg_619_1.var_.characterEffect1094ui_story = var_622_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_2 = 0.200000002980232

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_2 and not isNil(var_622_1) then
				if arg_619_1.var_.characterEffect1094ui_story and not isNil(var_622_1) then
					arg_619_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_619_1.time_ >= 0 + var_622_2 and arg_619_1.time_ < 0 + var_622_2 + arg_622_0 and not isNil(var_622_1) and arg_619_1.var_.characterEffect1094ui_story then
				arg_619_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_622_4 = 0
			local var_622_5 = 0.175

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_4 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				arg_619_1.leftNameTxt_.text = arg_619_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_6 = arg_619_1:GetWordFromCfg(1109402150)
				local var_622_7 = arg_619_1:FormatText(var_622_6.content)

				arg_619_1.text_.text = var_622_7

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_9 = 7 <= 0 and var_622_5 or var_622_5 * (utf8.len(var_622_7) / 7)

				if (7 <= 0 and var_622_5 or var_622_5 * (utf8.len(var_622_7) / 7)) > 0 and var_622_5 < var_622_9 then
					arg_619_1.talkMaxDuration = var_622_9

					if var_622_9 + var_622_4 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_9 + var_622_4
					end
				end

				arg_619_1.text_.text = var_622_7
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402150", "story_v_side_new_1109402.awb") ~= 0 then
					local var_622_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402150", "story_v_side_new_1109402.awb") / 1000

					if var_622_10 + var_622_4 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_10 + var_622_4
					end

					if var_622_6.prefab_name ~= "" and arg_619_1.actors_[var_622_6.prefab_name] ~= nil then
						local var_622_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_619_1.actors_[var_622_6.prefab_name].transform, "story_v_side_new_1109402", "1109402150", "story_v_side_new_1109402.awb")

						arg_619_1:RecordAudio("1109402150", var_622_11)
						arg_619_1:RecordAudio("1109402150", var_622_11)
					else
						arg_619_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402150", "story_v_side_new_1109402.awb")
					end

					arg_619_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402150", "story_v_side_new_1109402.awb")
				end

				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_12 = math.max(var_622_5, arg_619_1.talkMaxDuration)

			if var_622_4 <= arg_619_1.time_ and arg_619_1.time_ < var_622_4 + var_622_12 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_4) / var_622_12

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_4 + var_622_12 and arg_619_1.time_ < var_622_4 + var_622_12 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_619_1:InitPlayNodeList()
	end,
	Play1109402151 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1109402151
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1109402152(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(arg_623_1.actors_["1094ui_story"]) and arg_623_1.var_.characterEffect1094ui_story == nil then
				arg_623_1.var_.characterEffect1094ui_story = arg_623_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_0 = 0.200000002980232

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_0 and not isNil(arg_623_1.actors_["1094ui_story"]) then
				if arg_623_1.var_.characterEffect1094ui_story and not isNil(arg_623_1.actors_["1094ui_story"]) then
					arg_623_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_623_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_623_1.time_ - 0) / var_626_0)
				end
			end

			if arg_623_1.time_ >= 0 + var_626_0 and arg_623_1.time_ < 0 + var_626_0 + arg_626_0 and not isNil(arg_623_1.actors_["1094ui_story"]) and arg_623_1.var_.characterEffect1094ui_story then
				arg_623_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_623_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_626_1 = 0
			local var_626_2 = 0.75

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, false)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_3 = arg_623_1:FormatText(arg_623_1:GetWordFromCfg(1109402151).content)

				arg_623_1.text_.text = var_626_3

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_5 = 35 <= 0 and var_626_2 or var_626_2 * (utf8.len(var_626_3) / 35)

				if (35 <= 0 and var_626_2 or var_626_2 * (utf8.len(var_626_3) / 35)) > 0 and var_626_2 < var_626_5 then
					arg_623_1.talkMaxDuration = var_626_5

					if var_626_5 + var_626_1 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_5 + var_626_1
					end
				end

				arg_623_1.text_.text = var_626_3
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_6 = math.max(var_626_2, arg_623_1.talkMaxDuration)

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_6 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_1) / var_626_6

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_1 + var_626_6 and arg_623_1.time_ < var_626_1 + var_626_6 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1109402152 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1109402152
		arg_627_1.duration_ = 5

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1109402153(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = 0.275

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_1 = arg_627_1:FormatText(arg_627_1:GetWordFromCfg(1109402152).content)

				arg_627_1.text_.text = var_630_1

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_3 = 11 <= 0 and var_630_0 or var_630_0 * (utf8.len(var_630_1) / 11)

				if (11 <= 0 and var_630_0 or var_630_0 * (utf8.len(var_630_1) / 11)) > 0 and var_630_0 < var_630_3 then
					arg_627_1.talkMaxDuration = var_630_3

					if var_630_3 + 0 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_3 + 0
					end
				end

				arg_627_1.text_.text = var_630_1
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)
				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_4 = math.max(var_630_0, arg_627_1.talkMaxDuration)

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_4 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - 0) / var_630_4

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= 0 + var_630_4 and arg_627_1.time_ < 0 + var_630_4 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1109402153 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1109402153
		arg_631_1.duration_ = 12.5

		local var_631_0 = {
			ja = 12.5,
			ko = 6.3,
			zh = 6.3
		}
		local var_631_1 = manager.audio:GetLocalizationFlag()

		if var_631_0[var_631_1] ~= nil then
			arg_631_1.duration_ = var_631_0[var_631_1]
		end

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1109402154(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = 0.55

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, true)
				arg_631_1.iconController_:SetSelectedState("hero")

				arg_631_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_631_1.callingController_:SetSelectedState("normal")

				arg_631_1.keyicon_.color = Color.New(1, 1, 1)
				arg_631_1.icon_.color = Color.New(1, 1, 1)

				local var_634_1 = arg_631_1:GetWordFromCfg(1109402153)
				local var_634_2 = arg_631_1:FormatText(var_634_1.content)

				arg_631_1.text_.text = var_634_2

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_4 = 22 <= 0 and var_634_0 or var_634_0 * (utf8.len(var_634_2) / 22)

				if (22 <= 0 and var_634_0 or var_634_0 * (utf8.len(var_634_2) / 22)) > 0 and var_634_0 < var_634_4 then
					arg_631_1.talkMaxDuration = var_634_4

					if var_634_4 + 0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_4 + 0
					end
				end

				arg_631_1.text_.text = var_634_2
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402153", "story_v_side_new_1109402.awb") ~= 0 then
					local var_634_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402153", "story_v_side_new_1109402.awb") / 1000

					if var_634_5 + 0 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_5 + 0
					end

					if var_634_1.prefab_name ~= "" and arg_631_1.actors_[var_634_1.prefab_name] ~= nil then
						local var_634_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_1.prefab_name].transform, "story_v_side_new_1109402", "1109402153", "story_v_side_new_1109402.awb")

						arg_631_1:RecordAudio("1109402153", var_634_6)
						arg_631_1:RecordAudio("1109402153", var_634_6)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402153", "story_v_side_new_1109402.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402153", "story_v_side_new_1109402.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_7 = math.max(var_634_0, arg_631_1.talkMaxDuration)

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_7 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - 0) / var_634_7

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= 0 + var_634_7 and arg_631_1.time_ < 0 + var_634_7 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play1109402154 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1109402154
		arg_635_1.duration_ = 12.27

		local var_635_0 = {
			ja = 12.266,
			ko = 4.666,
			zh = 4.666
		}
		local var_635_1 = manager.audio:GetLocalizationFlag()

		if var_635_0[var_635_1] ~= nil then
			arg_635_1.duration_ = var_635_0[var_635_1]
		end

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1109402155(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 0.525

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[189].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, true)
				arg_635_1.iconController_:SetSelectedState("hero")

				arg_635_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_vina")

				arg_635_1.callingController_:SetSelectedState("normal")

				arg_635_1.keyicon_.color = Color.New(1, 1, 1)
				arg_635_1.icon_.color = Color.New(1, 1, 1)

				local var_638_1 = arg_635_1:GetWordFromCfg(1109402154)
				local var_638_2 = arg_635_1:FormatText(var_638_1.content)

				arg_635_1.text_.text = var_638_2

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_4 = 21 <= 0 and var_638_0 or var_638_0 * (utf8.len(var_638_2) / 21)

				if (21 <= 0 and var_638_0 or var_638_0 * (utf8.len(var_638_2) / 21)) > 0 and var_638_0 < var_638_4 then
					arg_635_1.talkMaxDuration = var_638_4

					if var_638_4 + 0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_4 + 0
					end
				end

				arg_635_1.text_.text = var_638_2
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402154", "story_v_side_new_1109402.awb") ~= 0 then
					local var_638_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402154", "story_v_side_new_1109402.awb") / 1000

					if var_638_5 + 0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_5 + 0
					end

					if var_638_1.prefab_name ~= "" and arg_635_1.actors_[var_638_1.prefab_name] ~= nil then
						local var_638_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_1.prefab_name].transform, "story_v_side_new_1109402", "1109402154", "story_v_side_new_1109402.awb")

						arg_635_1:RecordAudio("1109402154", var_638_6)
						arg_635_1:RecordAudio("1109402154", var_638_6)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402154", "story_v_side_new_1109402.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402154", "story_v_side_new_1109402.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_7 = math.max(var_638_0, arg_635_1.talkMaxDuration)

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_7 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - 0) / var_638_7

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= 0 + var_638_7 and arg_635_1.time_ < 0 + var_638_7 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play1109402155 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1109402155
		arg_639_1.duration_ = 3.03

		local var_639_0 = {
			ja = 3.033,
			ko = 2.366,
			zh = 2.366
		}
		local var_639_1 = manager.audio:GetLocalizationFlag()

		if var_639_0[var_639_1] ~= nil then
			arg_639_1.duration_ = var_639_0[var_639_1]
		end

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1109402156(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1.var_.moveOldPos1094ui_story = arg_639_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_642_0 = 0.001

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_0 then
				arg_639_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_639_1.time_ - 0) / var_642_0)
				arg_639_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_639_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1094ui_story"].transform.position).z)
				arg_639_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_639_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_639_1.actors_["1094ui_story"].transform.localEulerAngles = arg_639_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_639_1.time_ >= 0 + var_642_0 and arg_639_1.time_ < 0 + var_642_0 + arg_642_0 then
				arg_639_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_639_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_639_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_639_1.actors_["1094ui_story"].transform.position).z)
				arg_639_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_639_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_639_1.actors_["1094ui_story"].transform.localEulerAngles = arg_639_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_642_1 = arg_639_1.actors_["1094ui_story"]

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 and not isNil(var_642_1) and arg_639_1.var_.characterEffect1094ui_story == nil then
				arg_639_1.var_.characterEffect1094ui_story = var_642_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_2 = 0.200000002980232

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_2 and not isNil(var_642_1) then
				if arg_639_1.var_.characterEffect1094ui_story and not isNil(var_642_1) then
					arg_639_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_639_1.time_ >= 0 + var_642_2 and arg_639_1.time_ < 0 + var_642_2 + arg_642_0 and not isNil(var_642_1) and arg_639_1.var_.characterEffect1094ui_story then
				arg_639_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_642_4 = 0
			local var_642_5 = 0.225

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_4 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				arg_639_1.leftNameTxt_.text = arg_639_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_6 = arg_639_1:GetWordFromCfg(1109402155)
				local var_642_7 = arg_639_1:FormatText(var_642_6.content)

				arg_639_1.text_.text = var_642_7

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_9 = 9 <= 0 and var_642_5 or var_642_5 * (utf8.len(var_642_7) / 9)

				if (9 <= 0 and var_642_5 or var_642_5 * (utf8.len(var_642_7) / 9)) > 0 and var_642_5 < var_642_9 then
					arg_639_1.talkMaxDuration = var_642_9

					if var_642_9 + var_642_4 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_9 + var_642_4
					end
				end

				arg_639_1.text_.text = var_642_7
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402155", "story_v_side_new_1109402.awb") ~= 0 then
					local var_642_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402155", "story_v_side_new_1109402.awb") / 1000

					if var_642_10 + var_642_4 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_10 + var_642_4
					end

					if var_642_6.prefab_name ~= "" and arg_639_1.actors_[var_642_6.prefab_name] ~= nil then
						local var_642_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_6.prefab_name].transform, "story_v_side_new_1109402", "1109402155", "story_v_side_new_1109402.awb")

						arg_639_1:RecordAudio("1109402155", var_642_11)
						arg_639_1:RecordAudio("1109402155", var_642_11)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402155", "story_v_side_new_1109402.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402155", "story_v_side_new_1109402.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_12 = math.max(var_642_5, arg_639_1.talkMaxDuration)

			if var_642_4 <= arg_639_1.time_ and arg_639_1.time_ < var_642_4 + var_642_12 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_4) / var_642_12

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_4 + var_642_12 and arg_639_1.time_ < var_642_4 + var_642_12 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_639_1:InitPlayNodeList()
	end,
	Play1109402156 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1109402156
		arg_643_1.duration_ = 6.33

		local var_643_0 = {
			ja = 4.966,
			ko = 6.333,
			zh = 6.333
		}
		local var_643_1 = manager.audio:GetLocalizationFlag()

		if var_643_0[var_643_1] ~= nil then
			arg_643_1.duration_ = var_643_0[var_643_1]
		end

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1109402157(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1.var_.moveOldPos1094ui_story = arg_643_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_646_0 = 0.001

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_0 then
				arg_643_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_643_1.time_ - 0) / var_646_0)
				arg_643_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_643_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1094ui_story"].transform.position).z)
				arg_643_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_643_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_643_1.actors_["1094ui_story"].transform.localEulerAngles = arg_643_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_643_1.time_ >= 0 + var_646_0 and arg_643_1.time_ < 0 + var_646_0 + arg_646_0 then
				arg_643_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_643_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_643_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_643_1.actors_["1094ui_story"].transform.position).z)
				arg_643_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_643_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_643_1.actors_["1094ui_story"].transform.localEulerAngles = arg_643_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_646_1 = arg_643_1.actors_["1094ui_story"]

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 and not isNil(var_646_1) and arg_643_1.var_.characterEffect1094ui_story == nil then
				arg_643_1.var_.characterEffect1094ui_story = var_646_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_2 = 0.200000002980232

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_2 and not isNil(var_646_1) then
				if arg_643_1.var_.characterEffect1094ui_story and not isNil(var_646_1) then
					arg_643_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_643_1.time_ >= 0 + var_646_2 and arg_643_1.time_ < 0 + var_646_2 + arg_646_0 and not isNil(var_646_1) and arg_643_1.var_.characterEffect1094ui_story then
				arg_643_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 then
				arg_643_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_646_4 = 0
			local var_646_5 = 0.5

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_4 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_6 = arg_643_1:GetWordFromCfg(1109402156)
				local var_646_7 = arg_643_1:FormatText(var_646_6.content)

				arg_643_1.text_.text = var_646_7

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_9 = 20 <= 0 and var_646_5 or var_646_5 * (utf8.len(var_646_7) / 20)

				if (20 <= 0 and var_646_5 or var_646_5 * (utf8.len(var_646_7) / 20)) > 0 and var_646_5 < var_646_9 then
					arg_643_1.talkMaxDuration = var_646_9

					if var_646_9 + var_646_4 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_9 + var_646_4
					end
				end

				arg_643_1.text_.text = var_646_7
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402156", "story_v_side_new_1109402.awb") ~= 0 then
					local var_646_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402156", "story_v_side_new_1109402.awb") / 1000

					if var_646_10 + var_646_4 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_10 + var_646_4
					end

					if var_646_6.prefab_name ~= "" and arg_643_1.actors_[var_646_6.prefab_name] ~= nil then
						local var_646_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_6.prefab_name].transform, "story_v_side_new_1109402", "1109402156", "story_v_side_new_1109402.awb")

						arg_643_1:RecordAudio("1109402156", var_646_11)
						arg_643_1:RecordAudio("1109402156", var_646_11)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402156", "story_v_side_new_1109402.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402156", "story_v_side_new_1109402.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_12 = math.max(var_646_5, arg_643_1.talkMaxDuration)

			if var_646_4 <= arg_643_1.time_ and arg_643_1.time_ < var_646_4 + var_646_12 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_4) / var_646_12

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_4 + var_646_12 and arg_643_1.time_ < var_646_4 + var_646_12 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_643_1:InitPlayNodeList()
	end,
	Play1109402157 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1109402157
		arg_647_1.duration_ = 0.2

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"

			SetActive(arg_647_1.choicesGo_, true)

			for iter_648_0, iter_648_1 in ipairs(arg_647_1.choices_) do
				SetActive(iter_648_1.go, iter_648_0 <= 1)
			end

			arg_647_1.choices_[1].txt.text = arg_647_1:FormatText(StoryChoiceCfg[407].name)
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play1109402158(arg_647_1)
			end

			arg_647_1:RecordChoiceLog(1109402157, 407)
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 and not isNil(arg_647_1.actors_["1094ui_story"]) and arg_647_1.var_.characterEffect1094ui_story == nil then
				arg_647_1.var_.characterEffect1094ui_story = arg_647_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_650_0 = 0.200000002980232

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_0 and not isNil(arg_647_1.actors_["1094ui_story"]) then
				if arg_647_1.var_.characterEffect1094ui_story and not isNil(arg_647_1.actors_["1094ui_story"]) then
					arg_647_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_647_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_647_1.time_ - 0) / var_650_0)
				end
			end

			if arg_647_1.time_ >= 0 + var_650_0 and arg_647_1.time_ < 0 + var_650_0 + arg_650_0 and not isNil(arg_647_1.actors_["1094ui_story"]) and arg_647_1.var_.characterEffect1094ui_story then
				arg_647_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_647_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_650_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_647_1.bgmTxt_.text ~= var_650_3 and arg_647_1.bgmTxt_.text ~= "" then
						if arg_647_1.bgmTxt2_.text ~= "" then
							arg_647_1.bgmTxt_.text = arg_647_1.bgmTxt2_.text
						end

						arg_647_1.bgmTxt2_.text = var_650_3

						arg_647_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_647_1.bgmTxt_.text = var_650_3
						arg_647_1.bgmTxt2_.text = var_650_3
					end

					if arg_647_1.bgmTimer then
						arg_647_1.bgmTimer:Stop()

						arg_647_1.bgmTimer = nil
					end

					if arg_647_1.settingData.show_music_name == 1 then
						arg_647_1.musicController:SetSelectedState("show")
						arg_647_1.musicAnimator_:Play("open", 0, 0)

						if arg_647_1.settingData.music_time ~= 0 then
							arg_647_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_647_1.settingData.music_time), function()
								if arg_647_1 == nil or isNil(arg_647_1.bgmTxt_) then
									return
								end

								arg_647_1.musicController:SetSelectedState("hide")
								arg_647_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_650_4 = 0

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= var_650_4 + arg_650_0 then
				arg_647_1.allBtn_.enabled = false
			end

			if arg_647_1.time_ >= var_650_4 + 0.200000002980232 and arg_647_1.time_ < var_650_4 + 0.200000002980232 + arg_650_0 then
				arg_647_1.allBtn_.enabled = true
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play1109402158 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 1109402158
		arg_652_1.duration_ = 7

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play1109402159(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				local var_655_0 = arg_652_1.bgs_.STblack

				arg_652_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_655_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_655_1 = var_655_0:GetComponent("SpriteRenderer")

				if var_655_1 and var_655_1.sprite then
					local var_655_2 = 2 * (var_655_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_655_0.transform.localScale = Vector3.New(var_655_2 / var_655_1.sprite.bounds.size.y < var_655_2 * manager.ui.mainCameraCom_.aspect / var_655_1.sprite.bounds.size.x and var_655_2 * manager.ui.mainCameraCom_.aspect / var_655_1.sprite.bounds.size.x or var_655_2 / var_655_1.sprite.bounds.size.y, var_655_2 / var_655_1.sprite.bounds.size.y < var_655_2 * manager.ui.mainCameraCom_.aspect / var_655_1.sprite.bounds.size.x and var_655_2 * manager.ui.mainCameraCom_.aspect / var_655_1.sprite.bounds.size.x or var_655_2 / var_655_1.sprite.bounds.size.y, 0)
				end

				for iter_655_0, iter_655_1 in pairs(arg_652_1.bgs_) do
					if iter_655_0 ~= "STblack" then
						iter_655_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_655_3 = 0

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= var_655_3 + arg_655_0 then
				arg_652_1.mask_.enabled = true
				arg_652_1.mask_.raycastTarget = true

				arg_652_1:SetGaussion(false)
			end

			local var_655_4 = 2

			if var_655_3 <= arg_652_1.time_ and arg_652_1.time_ < var_655_3 + var_655_4 then
				local var_655_5 = Color.New(0, 0, 0)

				var_655_5.a = Mathf.Lerp(1, 0, (arg_652_1.time_ - var_655_3) / var_655_4)
				arg_652_1.mask_.color = var_655_5
			end

			if arg_652_1.time_ >= var_655_3 + var_655_4 and arg_652_1.time_ < var_655_3 + var_655_4 + arg_655_0 then
				local var_655_6 = Color.New(0, 0, 0)

				arg_652_1.mask_.enabled = false
				var_655_6.a = 0
				arg_652_1.mask_.color = var_655_6
			end

			local var_655_7 = arg_652_1.actors_["1094ui_story"].transform

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1.var_.moveOldPos1094ui_story = var_655_7.localPosition
			end

			local var_655_8 = 0.001

			if 0 <= arg_652_1.time_ and arg_652_1.time_ < 0 + var_655_8 then
				var_655_7.localPosition = Vector3.Lerp(arg_652_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_652_1.time_ - 0) / var_655_8)
				var_655_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_655_7.position).x, (manager.ui.mainCamera.transform.position - var_655_7.position).y, (manager.ui.mainCamera.transform.position - var_655_7.position).z)
				var_655_7.localEulerAngles.z = 0
				var_655_7.localEulerAngles.x = 0
				var_655_7.localEulerAngles = var_655_7.localEulerAngles
			end

			if arg_652_1.time_ >= 0 + var_655_8 and arg_652_1.time_ < 0 + var_655_8 + arg_655_0 then
				var_655_7.localPosition = Vector3.New(0, 100, 0)
				var_655_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_655_7.position).x, (manager.ui.mainCamera.transform.position - var_655_7.position).y, (manager.ui.mainCamera.transform.position - var_655_7.position).z)
				var_655_7.localEulerAngles.z = 0
				var_655_7.localEulerAngles.x = 0
				var_655_7.localEulerAngles = var_655_7.localEulerAngles
			end

			local var_655_9 = arg_652_1.actors_["1094ui_story"]

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 and not isNil(var_655_9) and arg_652_1.var_.characterEffect1094ui_story == nil then
				arg_652_1.var_.characterEffect1094ui_story = var_655_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_655_10 = 0.200000002980232

			if 0 <= arg_652_1.time_ and arg_652_1.time_ < 0 + var_655_10 and not isNil(var_655_9) then
				if arg_652_1.var_.characterEffect1094ui_story and not isNil(var_655_9) then
					arg_652_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_652_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_652_1.time_ - 0) / var_655_10)
				end
			end

			if arg_652_1.time_ >= 0 + var_655_10 and arg_652_1.time_ < 0 + var_655_10 + arg_655_0 and not isNil(var_655_9) and arg_652_1.var_.characterEffect1094ui_story then
				arg_652_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_652_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_655_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_652_1.bgmTxt_.text ~= var_655_13 and arg_652_1.bgmTxt_.text ~= "" then
						if arg_652_1.bgmTxt2_.text ~= "" then
							arg_652_1.bgmTxt_.text = arg_652_1.bgmTxt2_.text
						end

						arg_652_1.bgmTxt2_.text = var_655_13

						arg_652_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_652_1.bgmTxt_.text = var_655_13
						arg_652_1.bgmTxt2_.text = var_655_13
					end

					if arg_652_1.bgmTimer then
						arg_652_1.bgmTimer:Stop()

						arg_652_1.bgmTimer = nil
					end

					if arg_652_1.settingData.show_music_name == 1 then
						arg_652_1.musicController:SetSelectedState("show")
						arg_652_1.musicAnimator_:Play("open", 0, 0)

						if arg_652_1.settingData.music_time ~= 0 then
							arg_652_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_652_1.settingData.music_time), function()
								if arg_652_1 == nil or isNil(arg_652_1.bgmTxt_) then
									return
								end

								arg_652_1.musicController:SetSelectedState("hide")
								arg_652_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.46666666666667 < arg_652_1.time_ and arg_652_1.time_ <= 1.46666666666667 + arg_655_0 then
				arg_652_1:AudioAction("play", "music", "bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm.awb")

				local var_655_16 = manager.audio:GetAudioName("bgm_activity_1_1_hel_story_warm", "bgm_activity_1_1_hel_story_warm")

				if "" ~= "" then
					if arg_652_1.bgmTxt_.text ~= var_655_16 and arg_652_1.bgmTxt_.text ~= "" then
						if arg_652_1.bgmTxt2_.text ~= "" then
							arg_652_1.bgmTxt_.text = arg_652_1.bgmTxt2_.text
						end

						arg_652_1.bgmTxt2_.text = var_655_16

						arg_652_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_652_1.bgmTxt_.text = var_655_16
						arg_652_1.bgmTxt2_.text = var_655_16
					end

					if arg_652_1.bgmTimer then
						arg_652_1.bgmTimer:Stop()

						arg_652_1.bgmTimer = nil
					end

					if arg_652_1.settingData.show_music_name == 1 then
						arg_652_1.musicController:SetSelectedState("show")
						arg_652_1.musicAnimator_:Play("open", 0, 0)

						if arg_652_1.settingData.music_time ~= 0 then
							arg_652_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_652_1.settingData.music_time), function()
								if arg_652_1 == nil or isNil(arg_652_1.bgmTxt_) then
									return
								end

								arg_652_1.musicController:SetSelectedState("hide")
								arg_652_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_652_1.frameCnt_ <= 1 then
				arg_652_1.dialog_:SetActive(false)
			end

			local var_655_17 = 2
			local var_655_18 = 0.525

			if 2 < arg_652_1.time_ and arg_652_1.time_ <= var_655_17 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0

				arg_652_1.dialog_:SetActive(true)

				arg_652_1.dialogCg_.alpha = 0

				local var_655_19 = LeanTween.value(arg_652_1.dialog_, 0, 1, 0.3)

				var_655_19:setOnUpdate(LuaHelper.FloatAction(function(arg_658_0)
					arg_652_1.dialogCg_.alpha = arg_658_0
				end))
				var_655_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_652_1.dialog_)
					var_655_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_652_1.duration_ = arg_652_1.duration_ + 0.3

				SetActive(arg_652_1.leftNameGo_, false)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_20 = arg_652_1:FormatText(arg_652_1:GetWordFromCfg(1109402158).content)

				arg_652_1.text_.text = var_655_20

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_22 = 24 <= 0 and var_655_18 or var_655_18 * (utf8.len(var_655_20) / 24)

				if (24 <= 0 and var_655_18 or var_655_18 * (utf8.len(var_655_20) / 24)) > 0 and var_655_18 < var_655_22 then
					arg_652_1.talkMaxDuration = var_655_22
					var_655_17 = var_655_17 + 0.3

					if var_655_22 + var_655_17 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_22 + var_655_17
					end
				end

				arg_652_1.text_.text = var_655_20
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)
				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_23 = var_655_17 + 0.3
			local var_655_24 = math.max(var_655_18, arg_652_1.talkMaxDuration)

			if var_655_17 + 0.3 <= arg_652_1.time_ and arg_652_1.time_ < var_655_23 + var_655_24 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_23) / var_655_24

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_23 + var_655_24 and arg_652_1.time_ < var_655_23 + var_655_24 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_652_1:InitPlayNodeList()
	end,
	Play1109402159 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1109402159
		arg_660_1.duration_ = 2.83

		local var_660_0 = {
			ja = 2.833,
			ko = 2.666,
			zh = 2.666
		}
		local var_660_1 = manager.audio:GetLocalizationFlag()

		if var_660_0[var_660_1] ~= nil then
			arg_660_1.duration_ = var_660_0[var_660_1]
		end

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play1109402160(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = 0.225

			if 0 < arg_660_1.time_ and arg_660_1.time_ <= 0 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, true)

				arg_660_1.leftNameTxt_.text = arg_660_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_660_1.leftNameTxt_.transform)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1.leftNameTxt_.text)
				SetActive(arg_660_1.iconTrs_.gameObject, true)
				arg_660_1.iconController_:SetSelectedState("hero")

				arg_660_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_660_1.callingController_:SetSelectedState("normal")

				arg_660_1.keyicon_.color = Color.New(1, 1, 1)
				arg_660_1.icon_.color = Color.New(1, 1, 1)

				local var_663_1 = arg_660_1:GetWordFromCfg(1109402159)
				local var_663_2 = arg_660_1:FormatText(var_663_1.content)

				arg_660_1.text_.text = var_663_2

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_4 = 9 <= 0 and var_663_0 or var_663_0 * (utf8.len(var_663_2) / 9)

				if (9 <= 0 and var_663_0 or var_663_0 * (utf8.len(var_663_2) / 9)) > 0 and var_663_0 < var_663_4 then
					arg_660_1.talkMaxDuration = var_663_4

					if var_663_4 + 0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_4 + 0
					end
				end

				arg_660_1.text_.text = var_663_2
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402159", "story_v_side_new_1109402.awb") ~= 0 then
					local var_663_5 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402159", "story_v_side_new_1109402.awb") / 1000

					if var_663_5 + 0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_5 + 0
					end

					if var_663_1.prefab_name ~= "" and arg_660_1.actors_[var_663_1.prefab_name] ~= nil then
						local var_663_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_660_1.actors_[var_663_1.prefab_name].transform, "story_v_side_new_1109402", "1109402159", "story_v_side_new_1109402.awb")

						arg_660_1:RecordAudio("1109402159", var_663_6)
						arg_660_1:RecordAudio("1109402159", var_663_6)
					else
						arg_660_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402159", "story_v_side_new_1109402.awb")
					end

					arg_660_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402159", "story_v_side_new_1109402.awb")
				end

				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_7 = math.max(var_663_0, arg_660_1.talkMaxDuration)

			if 0 <= arg_660_1.time_ and arg_660_1.time_ < 0 + var_663_7 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - 0) / var_663_7

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= 0 + var_663_7 and arg_660_1.time_ < 0 + var_663_7 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play1109402160 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 1109402160
		arg_664_1.duration_ = 7.97

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play1109402161(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			if 0 < arg_664_1.time_ and arg_664_1.time_ <= 0 + arg_667_0 then
				arg_664_1.fswbg_:SetActive(true)
				arg_664_1.dialog_:SetActive(false)

				arg_664_1.fswtw_.percent = 0
				arg_664_1.fswt_.text = arg_664_1:FormatText(arg_664_1:GetWordFromCfg(1109402160).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.fswt_)

				arg_664_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_664_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_664_1.fswtw_:SetDirty()

				arg_664_1.typewritterCharCountI18N = 0

				SetActive(arg_664_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_664_1:ShowNextGo(false)
			end

			local var_667_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_664_1.time_ and arg_664_1.time_ <= var_667_0 + arg_667_0 then
				arg_664_1.var_.oldValueTypewriter = arg_664_1.fswtw_.percent

				SetActive(arg_664_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_664_1:ShowNextGo(false)
			end

			local var_667_1 = 0
			local var_667_2 = -9.33333333333333
			local var_667_3, var_667_4 = arg_664_1:GetPercentByPara(arg_664_1:FormatText(arg_664_1:GetWordFromCfg(1109402160).content), 1)

			if var_667_0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_0 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0

				local var_667_5 = var_667_1 <= 0 and var_667_2 or var_667_2 * ((var_667_4 - arg_664_1.typewritterCharCountI18N) / var_667_1)

				if (var_667_1 <= 0 and var_667_2 or var_667_2 * ((var_667_4 - arg_664_1.typewritterCharCountI18N) / var_667_1)) > 0 and var_667_2 < var_667_5 then
					arg_664_1.talkMaxDuration = var_667_5

					if var_667_5 + var_667_0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_5 + var_667_0
					end
				end
			end

			local var_667_6 = math.max(-9.33333333333333, arg_664_1.talkMaxDuration)

			if var_667_0 <= arg_664_1.time_ and arg_664_1.time_ < var_667_0 + var_667_6 then
				arg_664_1.fswtw_.percent = Mathf.Lerp(arg_664_1.var_.oldValueTypewriter, var_667_3, (arg_664_1.time_ - var_667_0) / var_667_6)
				arg_664_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_664_1.fswtw_:SetDirty()
			end

			if arg_664_1.time_ >= var_667_0 + var_667_6 and arg_664_1.time_ < var_667_0 + var_667_6 + arg_667_0 then
				arg_664_1.fswtw_.percent = var_667_3

				arg_664_1.fswtw_:SetDirty()
				arg_664_1:ShowNextGo(true)

				arg_664_1.typewritterCharCountI18N = var_667_4
			end

			local var_667_7 = 0
			local var_667_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402160", "story_v_side_new_1109402.awb") / 1000

			if var_667_8 > 0 and 7.966 < var_667_8 and var_667_8 + var_667_7 > arg_664_1.duration_ then
				arg_664_1.duration_ = var_667_8 + var_667_7
			end

			if var_667_7 < arg_664_1.time_ and arg_664_1.time_ <= var_667_7 + arg_667_0 then
				arg_664_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402160", "story_v_side_new_1109402.awb")
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	Play1109402161 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 1109402161
		arg_668_1.duration_ = 5.67

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play1109402162(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			if 0 < arg_668_1.time_ and arg_668_1.time_ <= 0 + arg_671_0 then
				arg_668_1.var_.oldValueTypewriter = arg_668_1.fswtw_.percent

				SetActive(arg_668_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_668_1:ShowNextGo(false)
			end

			local var_671_0 = 0
			local var_671_1 = 0
			local var_671_2, var_671_3 = arg_668_1:GetPercentByPara(arg_668_1:FormatText(arg_668_1:GetWordFromCfg(1109402160).content), 6)

			if 0 < arg_668_1.time_ and arg_668_1.time_ <= 0 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0

				local var_671_4 = var_671_0 <= 0 and var_671_1 or var_671_1 * ((var_671_3 - arg_668_1.typewritterCharCountI18N) / var_671_0)

				if (var_671_0 <= 0 and var_671_1 or var_671_1 * ((var_671_3 - arg_668_1.typewritterCharCountI18N) / var_671_0)) > 0 and var_671_1 < var_671_4 then
					arg_668_1.talkMaxDuration = var_671_4

					if var_671_4 + 0 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_4 + 0
					end
				end
			end

			local var_671_5 = math.max(0, arg_668_1.talkMaxDuration)

			if 0 <= arg_668_1.time_ and arg_668_1.time_ < 0 + var_671_5 then
				arg_668_1.fswtw_.percent = Mathf.Lerp(arg_668_1.var_.oldValueTypewriter, var_671_2, (arg_668_1.time_ - 0) / var_671_5)
				arg_668_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_668_1.fswtw_:SetDirty()
			end

			if arg_668_1.time_ >= 0 + var_671_5 and arg_668_1.time_ < 0 + var_671_5 + arg_671_0 then
				arg_668_1.fswtw_.percent = var_671_2

				arg_668_1.fswtw_:SetDirty()
				arg_668_1:ShowNextGo(true)

				arg_668_1.typewritterCharCountI18N = var_671_3
			end

			local var_671_6 = 0

			if 0 < arg_668_1.time_ and arg_668_1.time_ <= var_671_6 + arg_671_0 then
				arg_668_1.var_.oldValueTypewriter = arg_668_1.fswtw_.percent

				SetActive(arg_668_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_668_1:ShowNextGo(false)
			end

			local var_671_7 = 42
			local var_671_8 = 2.8
			local var_671_9, var_671_10 = arg_668_1:GetPercentByPara(arg_668_1:FormatText(arg_668_1:GetWordFromCfg(1109402160).content), 1)

			if var_671_6 < arg_668_1.time_ and arg_668_1.time_ <= var_671_6 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0

				local var_671_11 = var_671_7 <= 0 and var_671_8 or var_671_8 * ((var_671_10 - arg_668_1.typewritterCharCountI18N) / var_671_7)

				if (var_671_7 <= 0 and var_671_8 or var_671_8 * ((var_671_10 - arg_668_1.typewritterCharCountI18N) / var_671_7)) > 0 and var_671_8 < var_671_11 then
					arg_668_1.talkMaxDuration = var_671_11

					if var_671_11 + var_671_6 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_11 + var_671_6
					end
				end
			end

			local var_671_12 = math.max(2.8, arg_668_1.talkMaxDuration)

			if var_671_6 <= arg_668_1.time_ and arg_668_1.time_ < var_671_6 + var_671_12 then
				arg_668_1.fswtw_.percent = Mathf.Lerp(arg_668_1.var_.oldValueTypewriter, var_671_9, (arg_668_1.time_ - var_671_6) / var_671_12)
				arg_668_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_668_1.fswtw_:SetDirty()
			end

			if arg_668_1.time_ >= var_671_6 + var_671_12 and arg_668_1.time_ < var_671_6 + var_671_12 + arg_671_0 then
				arg_668_1.fswtw_.percent = var_671_9

				arg_668_1.fswtw_:SetDirty()
				arg_668_1:ShowNextGo(true)

				arg_668_1.typewritterCharCountI18N = var_671_10
			end

			local var_671_13 = 0
			local var_671_14 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402161", "story_v_side_new_1109402.awb") / 1000

			if var_671_14 > 0 and 5.666 < var_671_14 and var_671_14 + var_671_13 > arg_668_1.duration_ then
				arg_668_1.duration_ = var_671_14 + var_671_13
			end

			if var_671_13 < arg_668_1.time_ and arg_668_1.time_ <= var_671_13 + arg_671_0 then
				arg_668_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402161", "story_v_side_new_1109402.awb")
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play1109402162 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 1109402162
		arg_672_1.duration_ = 3.47

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play1109402163(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			if 0 < arg_672_1.time_ and arg_672_1.time_ <= 0 + arg_675_0 then
				arg_672_1.var_.oldValueTypewriter = arg_672_1.fswtw_.percent

				SetActive(arg_672_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_672_1:ShowNextGo(false)
			end

			local var_675_0 = 0
			local var_675_1 = 0
			local var_675_2, var_675_3 = arg_672_1:GetPercentByPara(arg_672_1:FormatText(arg_672_1:GetWordFromCfg(1109402160).content), 6)

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= 0 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0

				local var_675_4 = var_675_0 <= 0 and var_675_1 or var_675_1 * ((var_675_3 - arg_672_1.typewritterCharCountI18N) / var_675_0)

				if (var_675_0 <= 0 and var_675_1 or var_675_1 * ((var_675_3 - arg_672_1.typewritterCharCountI18N) / var_675_0)) > 0 and var_675_1 < var_675_4 then
					arg_672_1.talkMaxDuration = var_675_4

					if var_675_4 + 0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_4 + 0
					end
				end
			end

			local var_675_5 = math.max(0, arg_672_1.talkMaxDuration)

			if 0 <= arg_672_1.time_ and arg_672_1.time_ < 0 + var_675_5 then
				arg_672_1.fswtw_.percent = Mathf.Lerp(arg_672_1.var_.oldValueTypewriter, var_675_2, (arg_672_1.time_ - 0) / var_675_5)
				arg_672_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_672_1.fswtw_:SetDirty()
			end

			if arg_672_1.time_ >= 0 + var_675_5 and arg_672_1.time_ < 0 + var_675_5 + arg_675_0 then
				arg_672_1.fswtw_.percent = var_675_2

				arg_672_1.fswtw_:SetDirty()
				arg_672_1:ShowNextGo(true)

				arg_672_1.typewritterCharCountI18N = var_675_3
			end

			local var_675_6 = 0

			if 0 < arg_672_1.time_ and arg_672_1.time_ <= var_675_6 + arg_675_0 then
				arg_672_1.var_.oldValueTypewriter = arg_672_1.fswtw_.percent

				SetActive(arg_672_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_672_1:ShowNextGo(false)
			end

			local var_675_7 = 40
			local var_675_8 = 1.26666666666667
			local var_675_9, var_675_10 = arg_672_1:GetPercentByPara(arg_672_1:FormatText(arg_672_1:GetWordFromCfg(1109402160).content), 3)

			if var_675_6 < arg_672_1.time_ and arg_672_1.time_ <= var_675_6 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0

				local var_675_11 = var_675_7 <= 0 and var_675_8 or var_675_8 * ((var_675_10 - arg_672_1.typewritterCharCountI18N) / var_675_7)

				if (var_675_7 <= 0 and var_675_8 or var_675_8 * ((var_675_10 - arg_672_1.typewritterCharCountI18N) / var_675_7)) > 0 and var_675_8 < var_675_11 then
					arg_672_1.talkMaxDuration = var_675_11

					if var_675_11 + var_675_6 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_11 + var_675_6
					end
				end
			end

			local var_675_12 = math.max(1.26666666666667, arg_672_1.talkMaxDuration)

			if var_675_6 <= arg_672_1.time_ and arg_672_1.time_ < var_675_6 + var_675_12 then
				arg_672_1.fswtw_.percent = Mathf.Lerp(arg_672_1.var_.oldValueTypewriter, var_675_9, (arg_672_1.time_ - var_675_6) / var_675_12)
				arg_672_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_672_1.fswtw_:SetDirty()
			end

			if arg_672_1.time_ >= var_675_6 + var_675_12 and arg_672_1.time_ < var_675_6 + var_675_12 + arg_675_0 then
				arg_672_1.fswtw_.percent = var_675_9

				arg_672_1.fswtw_:SetDirty()
				arg_672_1:ShowNextGo(true)

				arg_672_1.typewritterCharCountI18N = var_675_10
			end

			local var_675_13 = 0
			local var_675_14 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402162", "story_v_side_new_1109402.awb") / 1000

			if var_675_14 > 0 and 3.466 < var_675_14 and var_675_14 + var_675_13 > arg_672_1.duration_ then
				arg_672_1.duration_ = var_675_14 + var_675_13
			end

			if var_675_13 < arg_672_1.time_ and arg_672_1.time_ <= var_675_13 + arg_675_0 then
				arg_672_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402162", "story_v_side_new_1109402.awb")
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play1109402163 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 1109402163
		arg_676_1.duration_ = 1.4

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play1109402164(arg_676_1)
			end
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			if 0 < arg_676_1.time_ and arg_676_1.time_ <= 0 + arg_679_0 then
				arg_676_1.var_.oldValueTypewriter = arg_676_1.fswtw_.percent

				SetActive(arg_676_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_676_1:ShowNextGo(false)
			end

			local var_679_0 = 0
			local var_679_1 = 0
			local var_679_2, var_679_3 = arg_676_1:GetPercentByPara(arg_676_1:FormatText(arg_676_1:GetWordFromCfg(1109402160).content), 6)

			if 0 < arg_676_1.time_ and arg_676_1.time_ <= 0 + arg_679_0 then
				arg_676_1.talkMaxDuration = 0

				local var_679_4 = var_679_0 <= 0 and var_679_1 or var_679_1 * ((var_679_3 - arg_676_1.typewritterCharCountI18N) / var_679_0)

				if (var_679_0 <= 0 and var_679_1 or var_679_1 * ((var_679_3 - arg_676_1.typewritterCharCountI18N) / var_679_0)) > 0 and var_679_1 < var_679_4 then
					arg_676_1.talkMaxDuration = var_679_4

					if var_679_4 + 0 > arg_676_1.duration_ then
						arg_676_1.duration_ = var_679_4 + 0
					end
				end
			end

			local var_679_5 = math.max(0, arg_676_1.talkMaxDuration)

			if 0 <= arg_676_1.time_ and arg_676_1.time_ < 0 + var_679_5 then
				arg_676_1.fswtw_.percent = Mathf.Lerp(arg_676_1.var_.oldValueTypewriter, var_679_2, (arg_676_1.time_ - 0) / var_679_5)
				arg_676_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_676_1.fswtw_:SetDirty()
			end

			if arg_676_1.time_ >= 0 + var_679_5 and arg_676_1.time_ < 0 + var_679_5 + arg_679_0 then
				arg_676_1.fswtw_.percent = var_679_2

				arg_676_1.fswtw_:SetDirty()
				arg_676_1:ShowNextGo(true)

				arg_676_1.typewritterCharCountI18N = var_679_3
			end

			local var_679_6 = 0

			if 0 < arg_676_1.time_ and arg_676_1.time_ <= var_679_6 + arg_679_0 then
				arg_676_1.var_.oldValueTypewriter = arg_676_1.fswtw_.percent

				SetActive(arg_676_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_676_1:ShowNextGo(false)
			end

			local var_679_7 = 21
			local var_679_8 = 1.4
			local var_679_9, var_679_10 = arg_676_1:GetPercentByPara(arg_676_1:FormatText(arg_676_1:GetWordFromCfg(1109402160).content), 4)

			if var_679_6 < arg_676_1.time_ and arg_676_1.time_ <= var_679_6 + arg_679_0 then
				arg_676_1.talkMaxDuration = 0

				local var_679_11 = var_679_7 <= 0 and var_679_8 or var_679_8 * ((var_679_10 - arg_676_1.typewritterCharCountI18N) / var_679_7)

				if (var_679_7 <= 0 and var_679_8 or var_679_8 * ((var_679_10 - arg_676_1.typewritterCharCountI18N) / var_679_7)) > 0 and var_679_8 < var_679_11 then
					arg_676_1.talkMaxDuration = var_679_11

					if var_679_11 + var_679_6 > arg_676_1.duration_ then
						arg_676_1.duration_ = var_679_11 + var_679_6
					end
				end
			end

			local var_679_12 = math.max(1.4, arg_676_1.talkMaxDuration)

			if var_679_6 <= arg_676_1.time_ and arg_676_1.time_ < var_679_6 + var_679_12 then
				arg_676_1.fswtw_.percent = Mathf.Lerp(arg_676_1.var_.oldValueTypewriter, var_679_9, (arg_676_1.time_ - var_679_6) / var_679_12)
				arg_676_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_676_1.fswtw_:SetDirty()
			end

			if arg_676_1.time_ >= var_679_6 + var_679_12 and arg_676_1.time_ < var_679_6 + var_679_12 + arg_679_0 then
				arg_676_1.fswtw_.percent = var_679_9

				arg_676_1.fswtw_:SetDirty()
				arg_676_1:ShowNextGo(true)

				arg_676_1.typewritterCharCountI18N = var_679_10
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	Play1109402164 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 1109402164
		arg_680_1.duration_ = 2.47

		SetActive(arg_680_1.tipsGo_, false)

		function arg_680_1.onSingleLineFinish_()
			arg_680_1.onSingleLineUpdate_ = nil
			arg_680_1.onSingleLineFinish_ = nil
			arg_680_1.state_ = "waiting"
		end

		function arg_680_1.playNext_(arg_682_0)
			if arg_682_0 == 1 then
				arg_680_0:Play1109402165(arg_680_1)
			end
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 then
				arg_680_1.var_.oldValueTypewriter = arg_680_1.fswtw_.percent

				SetActive(arg_680_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_680_1:ShowNextGo(false)
			end

			local var_683_0 = 0
			local var_683_1 = 0
			local var_683_2, var_683_3 = arg_680_1:GetPercentByPara(arg_680_1:FormatText(arg_680_1:GetWordFromCfg(1109402160).content), 6)

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= 0 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0

				local var_683_4 = var_683_0 <= 0 and var_683_1 or var_683_1 * ((var_683_3 - arg_680_1.typewritterCharCountI18N) / var_683_0)

				if (var_683_0 <= 0 and var_683_1 or var_683_1 * ((var_683_3 - arg_680_1.typewritterCharCountI18N) / var_683_0)) > 0 and var_683_1 < var_683_4 then
					arg_680_1.talkMaxDuration = var_683_4

					if var_683_4 + 0 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_4 + 0
					end
				end
			end

			local var_683_5 = math.max(0, arg_680_1.talkMaxDuration)

			if 0 <= arg_680_1.time_ and arg_680_1.time_ < 0 + var_683_5 then
				arg_680_1.fswtw_.percent = Mathf.Lerp(arg_680_1.var_.oldValueTypewriter, var_683_2, (arg_680_1.time_ - 0) / var_683_5)
				arg_680_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_680_1.fswtw_:SetDirty()
			end

			if arg_680_1.time_ >= 0 + var_683_5 and arg_680_1.time_ < 0 + var_683_5 + arg_683_0 then
				arg_680_1.fswtw_.percent = var_683_2

				arg_680_1.fswtw_:SetDirty()
				arg_680_1:ShowNextGo(true)

				arg_680_1.typewritterCharCountI18N = var_683_3
			end

			local var_683_6 = 0

			if 0 < arg_680_1.time_ and arg_680_1.time_ <= var_683_6 + arg_683_0 then
				arg_680_1.var_.oldValueTypewriter = arg_680_1.fswtw_.percent

				SetActive(arg_680_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_680_1:ShowNextGo(false)
			end

			local var_683_7 = 37
			local var_683_8 = 2.46666666666667
			local var_683_9, var_683_10 = arg_680_1:GetPercentByPara(arg_680_1:FormatText(arg_680_1:GetWordFromCfg(1109402160).content), 5)

			if var_683_6 < arg_680_1.time_ and arg_680_1.time_ <= var_683_6 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0

				local var_683_11 = var_683_7 <= 0 and var_683_8 or var_683_8 * ((var_683_10 - arg_680_1.typewritterCharCountI18N) / var_683_7)

				if (var_683_7 <= 0 and var_683_8 or var_683_8 * ((var_683_10 - arg_680_1.typewritterCharCountI18N) / var_683_7)) > 0 and var_683_8 < var_683_11 then
					arg_680_1.talkMaxDuration = var_683_11

					if var_683_11 + var_683_6 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_11 + var_683_6
					end
				end
			end

			local var_683_12 = math.max(2.46666666666667, arg_680_1.talkMaxDuration)

			if var_683_6 <= arg_680_1.time_ and arg_680_1.time_ < var_683_6 + var_683_12 then
				arg_680_1.fswtw_.percent = Mathf.Lerp(arg_680_1.var_.oldValueTypewriter, var_683_9, (arg_680_1.time_ - var_683_6) / var_683_12)
				arg_680_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_680_1.fswtw_:SetDirty()
			end

			if arg_680_1.time_ >= var_683_6 + var_683_12 and arg_680_1.time_ < var_683_6 + var_683_12 + arg_683_0 then
				arg_680_1.fswtw_.percent = var_683_9

				arg_680_1.fswtw_:SetDirty()
				arg_680_1:ShowNextGo(true)

				arg_680_1.typewritterCharCountI18N = var_683_10
			end
		end

		arg_680_1.nodeConfigList_ = {}

		arg_680_1:InitPlayNodeList()
	end,
	Play1109402165 = function(arg_684_0, arg_684_1)
		arg_684_1.time_ = 0
		arg_684_1.frameCnt_ = 0
		arg_684_1.state_ = "playing"
		arg_684_1.curTalkId_ = 1109402165
		arg_684_1.duration_ = 5.4

		SetActive(arg_684_1.tipsGo_, false)

		function arg_684_1.onSingleLineFinish_()
			arg_684_1.onSingleLineUpdate_ = nil
			arg_684_1.onSingleLineFinish_ = nil
			arg_684_1.state_ = "waiting"
		end

		function arg_684_1.playNext_(arg_686_0)
			if arg_686_0 == 1 then
				arg_684_0:Play1109402166(arg_684_1)
			end
		end

		function arg_684_1.onSingleLineUpdate_(arg_687_0)
			if 0 < arg_684_1.time_ and arg_684_1.time_ <= 0 + arg_687_0 then
				arg_684_1.var_.oldValueTypewriter = arg_684_1.fswtw_.percent

				SetActive(arg_684_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_684_1:ShowNextGo(false)
			end

			local var_687_0 = 0
			local var_687_1 = 0
			local var_687_2, var_687_3 = arg_684_1:GetPercentByPara(arg_684_1:FormatText(arg_684_1:GetWordFromCfg(1109402160).content), 6)

			if 0 < arg_684_1.time_ and arg_684_1.time_ <= 0 + arg_687_0 then
				arg_684_1.talkMaxDuration = 0

				local var_687_4 = var_687_0 <= 0 and var_687_1 or var_687_1 * ((var_687_3 - arg_684_1.typewritterCharCountI18N) / var_687_0)

				if (var_687_0 <= 0 and var_687_1 or var_687_1 * ((var_687_3 - arg_684_1.typewritterCharCountI18N) / var_687_0)) > 0 and var_687_1 < var_687_4 then
					arg_684_1.talkMaxDuration = var_687_4

					if var_687_4 + 0 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_4 + 0
					end
				end
			end

			local var_687_5 = math.max(0, arg_684_1.talkMaxDuration)

			if 0 <= arg_684_1.time_ and arg_684_1.time_ < 0 + var_687_5 then
				arg_684_1.fswtw_.percent = Mathf.Lerp(arg_684_1.var_.oldValueTypewriter, var_687_2, (arg_684_1.time_ - 0) / var_687_5)
				arg_684_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_684_1.fswtw_:SetDirty()
			end

			if arg_684_1.time_ >= 0 + var_687_5 and arg_684_1.time_ < 0 + var_687_5 + arg_687_0 then
				arg_684_1.fswtw_.percent = var_687_2

				arg_684_1.fswtw_:SetDirty()
				arg_684_1:ShowNextGo(true)

				arg_684_1.typewritterCharCountI18N = var_687_3
			end

			local var_687_6 = 0

			if 0 < arg_684_1.time_ and arg_684_1.time_ <= var_687_6 + arg_687_0 then
				arg_684_1.var_.oldValueTypewriter = arg_684_1.fswtw_.percent

				SetActive(arg_684_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_684_1:ShowNextGo(false)
			end

			local var_687_7 = 25
			local var_687_8 = 1.66666666666667
			local var_687_9, var_687_10 = arg_684_1:GetPercentByPara(arg_684_1:FormatText(arg_684_1:GetWordFromCfg(1109402160).content), 6)

			if var_687_6 < arg_684_1.time_ and arg_684_1.time_ <= var_687_6 + arg_687_0 then
				arg_684_1.talkMaxDuration = 0

				local var_687_11 = var_687_7 <= 0 and var_687_8 or var_687_8 * ((var_687_10 - arg_684_1.typewritterCharCountI18N) / var_687_7)

				if (var_687_7 <= 0 and var_687_8 or var_687_8 * ((var_687_10 - arg_684_1.typewritterCharCountI18N) / var_687_7)) > 0 and var_687_8 < var_687_11 then
					arg_684_1.talkMaxDuration = var_687_11

					if var_687_11 + var_687_6 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_11 + var_687_6
					end
				end
			end

			local var_687_12 = math.max(1.66666666666667, arg_684_1.talkMaxDuration)

			if var_687_6 <= arg_684_1.time_ and arg_684_1.time_ < var_687_6 + var_687_12 then
				arg_684_1.fswtw_.percent = Mathf.Lerp(arg_684_1.var_.oldValueTypewriter, var_687_9, (arg_684_1.time_ - var_687_6) / var_687_12)
				arg_684_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_684_1.fswtw_:SetDirty()
			end

			if arg_684_1.time_ >= var_687_6 + var_687_12 and arg_684_1.time_ < var_687_6 + var_687_12 + arg_687_0 then
				arg_684_1.fswtw_.percent = var_687_9

				arg_684_1.fswtw_:SetDirty()
				arg_684_1:ShowNextGo(true)

				arg_684_1.typewritterCharCountI18N = var_687_10
			end

			local var_687_13 = 0
			local var_687_14 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402165", "story_v_side_new_1109402.awb") / 1000

			if var_687_14 > 0 and 5.4 < var_687_14 and var_687_14 + var_687_13 > arg_684_1.duration_ then
				arg_684_1.duration_ = var_687_14 + var_687_13
			end

			if var_687_13 < arg_684_1.time_ and arg_684_1.time_ <= var_687_13 + arg_687_0 then
				arg_684_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402165", "story_v_side_new_1109402.awb")
			end
		end

		arg_684_1.nodeConfigList_ = {}

		arg_684_1:InitPlayNodeList()
	end,
	Play1109402166 = function(arg_688_0, arg_688_1)
		arg_688_1.time_ = 0
		arg_688_1.frameCnt_ = 0
		arg_688_1.state_ = "playing"
		arg_688_1.curTalkId_ = 1109402166
		arg_688_1.duration_ = 5.93

		SetActive(arg_688_1.tipsGo_, false)

		function arg_688_1.onSingleLineFinish_()
			arg_688_1.onSingleLineUpdate_ = nil
			arg_688_1.onSingleLineFinish_ = nil
			arg_688_1.state_ = "waiting"
		end

		function arg_688_1.playNext_(arg_690_0)
			if arg_690_0 == 1 then
				arg_688_0:Play1109402167(arg_688_1)
			end
		end

		function arg_688_1.onSingleLineUpdate_(arg_691_0)
			if 0 < arg_688_1.time_ and arg_688_1.time_ <= 0 + arg_691_0 then
				arg_688_1.var_.oldValueTypewriter = arg_688_1.fswtw_.percent

				SetActive(arg_688_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_688_1:ShowNextGo(false)
			end

			local var_691_0 = 0
			local var_691_1 = 0
			local var_691_2, var_691_3 = arg_688_1:GetPercentByPara(arg_688_1:FormatText(arg_688_1:GetWordFromCfg(1109402160).content), 6)

			if 0 < arg_688_1.time_ and arg_688_1.time_ <= 0 + arg_691_0 then
				arg_688_1.talkMaxDuration = 0

				local var_691_4 = var_691_0 <= 0 and var_691_1 or var_691_1 * ((var_691_3 - arg_688_1.typewritterCharCountI18N) / var_691_0)

				if (var_691_0 <= 0 and var_691_1 or var_691_1 * ((var_691_3 - arg_688_1.typewritterCharCountI18N) / var_691_0)) > 0 and var_691_1 < var_691_4 then
					arg_688_1.talkMaxDuration = var_691_4

					if var_691_4 + 0 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_4 + 0
					end
				end
			end

			local var_691_5 = math.max(0, arg_688_1.talkMaxDuration)

			if 0 <= arg_688_1.time_ and arg_688_1.time_ < 0 + var_691_5 then
				arg_688_1.fswtw_.percent = Mathf.Lerp(arg_688_1.var_.oldValueTypewriter, var_691_2, (arg_688_1.time_ - 0) / var_691_5)
				arg_688_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_688_1.fswtw_:SetDirty()
			end

			if arg_688_1.time_ >= 0 + var_691_5 and arg_688_1.time_ < 0 + var_691_5 + arg_691_0 then
				arg_688_1.fswtw_.percent = var_691_2

				arg_688_1.fswtw_:SetDirty()
				arg_688_1:ShowNextGo(true)

				arg_688_1.typewritterCharCountI18N = var_691_3
			end

			if 0 < arg_688_1.time_ and arg_688_1.time_ <= 0 + arg_691_0 then
				arg_688_1.fswbg_:SetActive(true)
				arg_688_1.dialog_:SetActive(false)

				arg_688_1.fswtw_.percent = 0
				arg_688_1.fswt_.text = arg_688_1:FormatText(arg_688_1:GetWordFromCfg(1109402166).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_688_1.fswt_)

				arg_688_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_688_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_688_1.fswtw_:SetDirty()

				arg_688_1.typewritterCharCountI18N = 0

				SetActive(arg_688_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_688_1:ShowNextGo(false)
			end

			local var_691_6 = 0.0166666666666667

			if 0.0166666666666667 < arg_688_1.time_ and arg_688_1.time_ <= var_691_6 + arg_691_0 then
				arg_688_1.var_.oldValueTypewriter = arg_688_1.fswtw_.percent

				SetActive(arg_688_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_688_1:ShowNextGo(false)
			end

			local var_691_7 = 24
			local var_691_8 = 1.6
			local var_691_9, var_691_10 = arg_688_1:GetPercentByPara(arg_688_1:FormatText(arg_688_1:GetWordFromCfg(1109402166).content), 1)

			if var_691_6 < arg_688_1.time_ and arg_688_1.time_ <= var_691_6 + arg_691_0 then
				arg_688_1.talkMaxDuration = 0

				local var_691_11 = var_691_7 <= 0 and var_691_8 or var_691_8 * ((var_691_10 - arg_688_1.typewritterCharCountI18N) / var_691_7)

				if (var_691_7 <= 0 and var_691_8 or var_691_8 * ((var_691_10 - arg_688_1.typewritterCharCountI18N) / var_691_7)) > 0 and var_691_8 < var_691_11 then
					arg_688_1.talkMaxDuration = var_691_11

					if var_691_11 + var_691_6 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_11 + var_691_6
					end
				end
			end

			local var_691_12 = math.max(1.6, arg_688_1.talkMaxDuration)

			if var_691_6 <= arg_688_1.time_ and arg_688_1.time_ < var_691_6 + var_691_12 then
				arg_688_1.fswtw_.percent = Mathf.Lerp(arg_688_1.var_.oldValueTypewriter, var_691_9, (arg_688_1.time_ - var_691_6) / var_691_12)
				arg_688_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_688_1.fswtw_:SetDirty()
			end

			if arg_688_1.time_ >= var_691_6 + var_691_12 and arg_688_1.time_ < var_691_6 + var_691_12 + arg_691_0 then
				arg_688_1.fswtw_.percent = var_691_9

				arg_688_1.fswtw_:SetDirty()
				arg_688_1:ShowNextGo(true)

				arg_688_1.typewritterCharCountI18N = var_691_10
			end

			local var_691_13 = 0
			local var_691_14 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402166", "story_v_side_new_1109402.awb") / 1000

			if var_691_14 > 0 and 5.933 < var_691_14 and var_691_14 + var_691_13 > arg_688_1.duration_ then
				arg_688_1.duration_ = var_691_14 + var_691_13
			end

			if var_691_13 < arg_688_1.time_ and arg_688_1.time_ <= var_691_13 + arg_691_0 then
				arg_688_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402166", "story_v_side_new_1109402.awb")
			end
		end

		arg_688_1.nodeConfigList_ = {}

		arg_688_1:InitPlayNodeList()
	end,
	Play1109402167 = function(arg_692_0, arg_692_1)
		arg_692_1.time_ = 0
		arg_692_1.frameCnt_ = 0
		arg_692_1.state_ = "playing"
		arg_692_1.curTalkId_ = 1109402167
		arg_692_1.duration_ = 6.43

		SetActive(arg_692_1.tipsGo_, false)

		function arg_692_1.onSingleLineFinish_()
			arg_692_1.onSingleLineUpdate_ = nil
			arg_692_1.onSingleLineFinish_ = nil
			arg_692_1.state_ = "waiting"
		end

		function arg_692_1.playNext_(arg_694_0)
			if arg_694_0 == 1 then
				arg_692_0:Play1109402168(arg_692_1)
			end
		end

		function arg_692_1.onSingleLineUpdate_(arg_695_0)
			if 0 < arg_692_1.time_ and arg_692_1.time_ <= 0 + arg_695_0 then
				arg_692_1.var_.oldValueTypewriter = arg_692_1.fswtw_.percent

				SetActive(arg_692_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_692_1:ShowNextGo(false)
			end

			local var_695_0 = 26
			local var_695_1 = 1.73333333333333
			local var_695_2, var_695_3 = arg_692_1:GetPercentByPara(arg_692_1:FormatText(arg_692_1:GetWordFromCfg(1109402166).content), 2)

			if 0 < arg_692_1.time_ and arg_692_1.time_ <= 0 + arg_695_0 then
				arg_692_1.talkMaxDuration = 0

				local var_695_4 = var_695_0 <= 0 and var_695_1 or var_695_1 * ((var_695_3 - arg_692_1.typewritterCharCountI18N) / var_695_0)

				if (var_695_0 <= 0 and var_695_1 or var_695_1 * ((var_695_3 - arg_692_1.typewritterCharCountI18N) / var_695_0)) > 0 and var_695_1 < var_695_4 then
					arg_692_1.talkMaxDuration = var_695_4

					if var_695_4 + 0 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_4 + 0
					end
				end
			end

			local var_695_5 = math.max(1.73333333333333, arg_692_1.talkMaxDuration)

			if 0 <= arg_692_1.time_ and arg_692_1.time_ < 0 + var_695_5 then
				arg_692_1.fswtw_.percent = Mathf.Lerp(arg_692_1.var_.oldValueTypewriter, var_695_2, (arg_692_1.time_ - 0) / var_695_5)
				arg_692_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_692_1.fswtw_:SetDirty()
			end

			if arg_692_1.time_ >= 0 + var_695_5 and arg_692_1.time_ < 0 + var_695_5 + arg_695_0 then
				arg_692_1.fswtw_.percent = var_695_2

				arg_692_1.fswtw_:SetDirty()
				arg_692_1:ShowNextGo(true)

				arg_692_1.typewritterCharCountI18N = var_695_3
			end

			local var_695_6 = 0
			local var_695_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402167", "story_v_side_new_1109402.awb") / 1000

			if var_695_7 > 0 and 6.433 < var_695_7 and var_695_7 + var_695_6 > arg_692_1.duration_ then
				arg_692_1.duration_ = var_695_7 + var_695_6
			end

			if var_695_6 < arg_692_1.time_ and arg_692_1.time_ <= var_695_6 + arg_695_0 then
				arg_692_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402167", "story_v_side_new_1109402.awb")
			end
		end

		arg_692_1.nodeConfigList_ = {}

		arg_692_1:InitPlayNodeList()
	end,
	Play1109402168 = function(arg_696_0, arg_696_1)
		arg_696_1.time_ = 0
		arg_696_1.frameCnt_ = 0
		arg_696_1.state_ = "playing"
		arg_696_1.curTalkId_ = 1109402168
		arg_696_1.duration_ = 6.17

		SetActive(arg_696_1.tipsGo_, false)

		function arg_696_1.onSingleLineFinish_()
			arg_696_1.onSingleLineUpdate_ = nil
			arg_696_1.onSingleLineFinish_ = nil
			arg_696_1.state_ = "waiting"
		end

		function arg_696_1.playNext_(arg_698_0)
			if arg_698_0 == 1 then
				arg_696_0:Play1109402169(arg_696_1)
			end
		end

		function arg_696_1.onSingleLineUpdate_(arg_699_0)
			if 0 < arg_696_1.time_ and arg_696_1.time_ <= 0 + arg_699_0 then
				arg_696_1.var_.oldValueTypewriter = arg_696_1.fswtw_.percent

				SetActive(arg_696_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_696_1:ShowNextGo(false)
			end

			local var_699_0 = 28
			local var_699_1 = 1.86666666666667
			local var_699_2, var_699_3 = arg_696_1:GetPercentByPara(arg_696_1:FormatText(arg_696_1:GetWordFromCfg(1109402166).content), 3)

			if 0 < arg_696_1.time_ and arg_696_1.time_ <= 0 + arg_699_0 then
				arg_696_1.talkMaxDuration = 0

				local var_699_4 = var_699_0 <= 0 and var_699_1 or var_699_1 * ((var_699_3 - arg_696_1.typewritterCharCountI18N) / var_699_0)

				if (var_699_0 <= 0 and var_699_1 or var_699_1 * ((var_699_3 - arg_696_1.typewritterCharCountI18N) / var_699_0)) > 0 and var_699_1 < var_699_4 then
					arg_696_1.talkMaxDuration = var_699_4

					if var_699_4 + 0 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_4 + 0
					end
				end
			end

			local var_699_5 = math.max(1.86666666666667, arg_696_1.talkMaxDuration)

			if 0 <= arg_696_1.time_ and arg_696_1.time_ < 0 + var_699_5 then
				arg_696_1.fswtw_.percent = Mathf.Lerp(arg_696_1.var_.oldValueTypewriter, var_699_2, (arg_696_1.time_ - 0) / var_699_5)
				arg_696_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_696_1.fswtw_:SetDirty()
			end

			if arg_696_1.time_ >= 0 + var_699_5 and arg_696_1.time_ < 0 + var_699_5 + arg_699_0 then
				arg_696_1.fswtw_.percent = var_699_2

				arg_696_1.fswtw_:SetDirty()
				arg_696_1:ShowNextGo(true)

				arg_696_1.typewritterCharCountI18N = var_699_3
			end

			local var_699_6 = 0
			local var_699_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402168", "story_v_side_new_1109402.awb") / 1000

			if var_699_7 > 0 and 6.166 < var_699_7 and var_699_7 + var_699_6 > arg_696_1.duration_ then
				arg_696_1.duration_ = var_699_7 + var_699_6
			end

			if var_699_6 < arg_696_1.time_ and arg_696_1.time_ <= var_699_6 + arg_699_0 then
				arg_696_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402168", "story_v_side_new_1109402.awb")
			end
		end

		arg_696_1.nodeConfigList_ = {}

		arg_696_1:InitPlayNodeList()
	end,
	Play1109402169 = function(arg_700_0, arg_700_1)
		arg_700_1.time_ = 0
		arg_700_1.frameCnt_ = 0
		arg_700_1.state_ = "playing"
		arg_700_1.curTalkId_ = 1109402169
		arg_700_1.duration_ = 2.53

		SetActive(arg_700_1.tipsGo_, false)

		function arg_700_1.onSingleLineFinish_()
			arg_700_1.onSingleLineUpdate_ = nil
			arg_700_1.onSingleLineFinish_ = nil
			arg_700_1.state_ = "waiting"
		end

		function arg_700_1.playNext_(arg_702_0)
			if arg_702_0 == 1 then
				arg_700_0:Play1109402170(arg_700_1)
			end
		end

		function arg_700_1.onSingleLineUpdate_(arg_703_0)
			if 0 < arg_700_1.time_ and arg_700_1.time_ <= 0 + arg_703_0 then
				arg_700_1.var_.oldValueTypewriter = arg_700_1.fswtw_.percent

				SetActive(arg_700_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_700_1:ShowNextGo(false)
			end

			local var_703_0 = 38
			local var_703_1 = 2.53333333333333
			local var_703_2, var_703_3 = arg_700_1:GetPercentByPara(arg_700_1:FormatText(arg_700_1:GetWordFromCfg(1109402166).content), 4)

			if 0 < arg_700_1.time_ and arg_700_1.time_ <= 0 + arg_703_0 then
				arg_700_1.talkMaxDuration = 0

				local var_703_4 = var_703_0 <= 0 and var_703_1 or var_703_1 * ((var_703_3 - arg_700_1.typewritterCharCountI18N) / var_703_0)

				if (var_703_0 <= 0 and var_703_1 or var_703_1 * ((var_703_3 - arg_700_1.typewritterCharCountI18N) / var_703_0)) > 0 and var_703_1 < var_703_4 then
					arg_700_1.talkMaxDuration = var_703_4

					if var_703_4 + 0 > arg_700_1.duration_ then
						arg_700_1.duration_ = var_703_4 + 0
					end
				end
			end

			local var_703_5 = math.max(2.53333333333333, arg_700_1.talkMaxDuration)

			if 0 <= arg_700_1.time_ and arg_700_1.time_ < 0 + var_703_5 then
				arg_700_1.fswtw_.percent = Mathf.Lerp(arg_700_1.var_.oldValueTypewriter, var_703_2, (arg_700_1.time_ - 0) / var_703_5)
				arg_700_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_700_1.fswtw_:SetDirty()
			end

			if arg_700_1.time_ >= 0 + var_703_5 and arg_700_1.time_ < 0 + var_703_5 + arg_703_0 then
				arg_700_1.fswtw_.percent = var_703_2

				arg_700_1.fswtw_:SetDirty()
				arg_700_1:ShowNextGo(true)

				arg_700_1.typewritterCharCountI18N = var_703_3
			end
		end

		arg_700_1.nodeConfigList_ = {}

		arg_700_1:InitPlayNodeList()
	end,
	Play1109402170 = function(arg_704_0, arg_704_1)
		arg_704_1.time_ = 0
		arg_704_1.frameCnt_ = 0
		arg_704_1.state_ = "playing"
		arg_704_1.curTalkId_ = 1109402170
		arg_704_1.duration_ = 6.93

		SetActive(arg_704_1.tipsGo_, false)

		function arg_704_1.onSingleLineFinish_()
			arg_704_1.onSingleLineUpdate_ = nil
			arg_704_1.onSingleLineFinish_ = nil
			arg_704_1.state_ = "waiting"
		end

		function arg_704_1.playNext_(arg_706_0)
			if arg_706_0 == 1 then
				arg_704_0:Play1109402171(arg_704_1)
			end
		end

		function arg_704_1.onSingleLineUpdate_(arg_707_0)
			if 0 < arg_704_1.time_ and arg_704_1.time_ <= 0 + arg_707_0 then
				arg_704_1.var_.oldValueTypewriter = arg_704_1.fswtw_.percent

				SetActive(arg_704_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_704_1:ShowNextGo(false)
			end

			local var_707_0 = 35
			local var_707_1 = 2.33333333333333
			local var_707_2, var_707_3 = arg_704_1:GetPercentByPara(arg_704_1:FormatText(arg_704_1:GetWordFromCfg(1109402166).content), 5)

			if 0 < arg_704_1.time_ and arg_704_1.time_ <= 0 + arg_707_0 then
				arg_704_1.talkMaxDuration = 0

				local var_707_4 = var_707_0 <= 0 and var_707_1 or var_707_1 * ((var_707_3 - arg_704_1.typewritterCharCountI18N) / var_707_0)

				if (var_707_0 <= 0 and var_707_1 or var_707_1 * ((var_707_3 - arg_704_1.typewritterCharCountI18N) / var_707_0)) > 0 and var_707_1 < var_707_4 then
					arg_704_1.talkMaxDuration = var_707_4

					if var_707_4 + 0 > arg_704_1.duration_ then
						arg_704_1.duration_ = var_707_4 + 0
					end
				end
			end

			local var_707_5 = math.max(2.33333333333333, arg_704_1.talkMaxDuration)

			if 0 <= arg_704_1.time_ and arg_704_1.time_ < 0 + var_707_5 then
				arg_704_1.fswtw_.percent = Mathf.Lerp(arg_704_1.var_.oldValueTypewriter, var_707_2, (arg_704_1.time_ - 0) / var_707_5)
				arg_704_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_704_1.fswtw_:SetDirty()
			end

			if arg_704_1.time_ >= 0 + var_707_5 and arg_704_1.time_ < 0 + var_707_5 + arg_707_0 then
				arg_704_1.fswtw_.percent = var_707_2

				arg_704_1.fswtw_:SetDirty()
				arg_704_1:ShowNextGo(true)

				arg_704_1.typewritterCharCountI18N = var_707_3
			end

			local var_707_6 = 0
			local var_707_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402170", "story_v_side_new_1109402.awb") / 1000

			if var_707_7 > 0 and 6.933 < var_707_7 and var_707_7 + var_707_6 > arg_704_1.duration_ then
				arg_704_1.duration_ = var_707_7 + var_707_6
			end

			if var_707_6 < arg_704_1.time_ and arg_704_1.time_ <= var_707_6 + arg_707_0 then
				arg_704_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402170", "story_v_side_new_1109402.awb")
			end
		end

		arg_704_1.nodeConfigList_ = {}

		arg_704_1:InitPlayNodeList()
	end,
	Play1109402171 = function(arg_708_0, arg_708_1)
		arg_708_1.time_ = 0
		arg_708_1.frameCnt_ = 0
		arg_708_1.state_ = "playing"
		arg_708_1.curTalkId_ = 1109402171
		arg_708_1.duration_ = 2.33

		SetActive(arg_708_1.tipsGo_, false)

		function arg_708_1.onSingleLineFinish_()
			arg_708_1.onSingleLineUpdate_ = nil
			arg_708_1.onSingleLineFinish_ = nil
			arg_708_1.state_ = "waiting"
		end

		function arg_708_1.playNext_(arg_710_0)
			if arg_710_0 == 1 then
				arg_708_0:Play1109402172(arg_708_1)
			end
		end

		function arg_708_1.onSingleLineUpdate_(arg_711_0)
			if 0 < arg_708_1.time_ and arg_708_1.time_ <= 0 + arg_711_0 then
				arg_708_1.var_.oldValueTypewriter = arg_708_1.fswtw_.percent

				SetActive(arg_708_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_708_1:ShowNextGo(false)
			end

			local var_711_0 = 35
			local var_711_1 = 2.33333333333333
			local var_711_2, var_711_3 = arg_708_1:GetPercentByPara(arg_708_1:FormatText(arg_708_1:GetWordFromCfg(1109402166).content), 6)

			if 0 < arg_708_1.time_ and arg_708_1.time_ <= 0 + arg_711_0 then
				arg_708_1.talkMaxDuration = 0

				local var_711_4 = var_711_0 <= 0 and var_711_1 or var_711_1 * ((var_711_3 - arg_708_1.typewritterCharCountI18N) / var_711_0)

				if (var_711_0 <= 0 and var_711_1 or var_711_1 * ((var_711_3 - arg_708_1.typewritterCharCountI18N) / var_711_0)) > 0 and var_711_1 < var_711_4 then
					arg_708_1.talkMaxDuration = var_711_4

					if var_711_4 + 0 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_4 + 0
					end
				end
			end

			local var_711_5 = math.max(2.33333333333333, arg_708_1.talkMaxDuration)

			if 0 <= arg_708_1.time_ and arg_708_1.time_ < 0 + var_711_5 then
				arg_708_1.fswtw_.percent = Mathf.Lerp(arg_708_1.var_.oldValueTypewriter, var_711_2, (arg_708_1.time_ - 0) / var_711_5)
				arg_708_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_708_1.fswtw_:SetDirty()
			end

			if arg_708_1.time_ >= 0 + var_711_5 and arg_708_1.time_ < 0 + var_711_5 + arg_711_0 then
				arg_708_1.fswtw_.percent = var_711_2

				arg_708_1.fswtw_:SetDirty()
				arg_708_1:ShowNextGo(true)

				arg_708_1.typewritterCharCountI18N = var_711_3
			end
		end

		arg_708_1.nodeConfigList_ = {}

		arg_708_1:InitPlayNodeList()
	end,
	Play1109402172 = function(arg_712_0, arg_712_1)
		arg_712_1.time_ = 0
		arg_712_1.frameCnt_ = 0
		arg_712_1.state_ = "playing"
		arg_712_1.curTalkId_ = 1109402172
		arg_712_1.duration_ = 1

		SetActive(arg_712_1.tipsGo_, false)

		function arg_712_1.onSingleLineFinish_()
			arg_712_1.onSingleLineUpdate_ = nil
			arg_712_1.onSingleLineFinish_ = nil
			arg_712_1.state_ = "waiting"
		end

		function arg_712_1.playNext_(arg_714_0)
			if arg_714_0 == 1 then
				arg_712_0:Play1109402173(arg_712_1)
			end
		end

		function arg_712_1.onSingleLineUpdate_(arg_715_0)
			if 0 < arg_712_1.time_ and arg_712_1.time_ <= 0 + arg_715_0 then
				arg_712_1.fswbg_:SetActive(true)
				arg_712_1.dialog_:SetActive(false)

				arg_712_1.fswtw_.percent = 0
				arg_712_1.fswt_.text = arg_712_1:FormatText(arg_712_1:GetWordFromCfg(1109402172).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_712_1.fswt_)

				arg_712_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_712_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_712_1.fswtw_:SetDirty()

				arg_712_1.typewritterCharCountI18N = 0

				SetActive(arg_712_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_712_1:ShowNextGo(false)
			end

			local var_715_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_712_1.time_ and arg_712_1.time_ <= var_715_0 + arg_715_0 then
				arg_712_1.var_.oldValueTypewriter = arg_712_1.fswtw_.percent

				SetActive(arg_712_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_712_1:ShowNextGo(false)
			end

			local var_715_1 = 12
			local var_715_2 = 0.8
			local var_715_3, var_715_4 = arg_712_1:GetPercentByPara(arg_712_1:FormatText(arg_712_1:GetWordFromCfg(1109402172).content), 1)

			if var_715_0 < arg_712_1.time_ and arg_712_1.time_ <= var_715_0 + arg_715_0 then
				arg_712_1.talkMaxDuration = 0

				local var_715_5 = var_715_1 <= 0 and var_715_2 or var_715_2 * ((var_715_4 - arg_712_1.typewritterCharCountI18N) / var_715_1)

				if (var_715_1 <= 0 and var_715_2 or var_715_2 * ((var_715_4 - arg_712_1.typewritterCharCountI18N) / var_715_1)) > 0 and var_715_2 < var_715_5 then
					arg_712_1.talkMaxDuration = var_715_5

					if var_715_5 + var_715_0 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_5 + var_715_0
					end
				end
			end

			local var_715_6 = math.max(0.8, arg_712_1.talkMaxDuration)

			if var_715_0 <= arg_712_1.time_ and arg_712_1.time_ < var_715_0 + var_715_6 then
				arg_712_1.fswtw_.percent = Mathf.Lerp(arg_712_1.var_.oldValueTypewriter, var_715_3, (arg_712_1.time_ - var_715_0) / var_715_6)
				arg_712_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_712_1.fswtw_:SetDirty()
			end

			if arg_712_1.time_ >= var_715_0 + var_715_6 and arg_712_1.time_ < var_715_0 + var_715_6 + arg_715_0 then
				arg_712_1.fswtw_.percent = var_715_3

				arg_712_1.fswtw_:SetDirty()
				arg_712_1:ShowNextGo(true)

				arg_712_1.typewritterCharCountI18N = var_715_4
			end
		end

		arg_712_1.nodeConfigList_ = {}

		arg_712_1:InitPlayNodeList()
	end,
	Play1109402173 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 1109402173
		arg_716_1.duration_ = 2.13

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
		end

		function arg_716_1.playNext_(arg_718_0)
			if arg_718_0 == 1 then
				arg_716_0:Play1109402174(arg_716_1)
			end
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			if 0 < arg_716_1.time_ and arg_716_1.time_ <= 0 + arg_719_0 then
				arg_716_1.var_.oldValueTypewriter = arg_716_1.fswtw_.percent

				SetActive(arg_716_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_716_1:ShowNextGo(false)
			end

			local var_719_0 = 32
			local var_719_1 = 2.13333333333333
			local var_719_2, var_719_3 = arg_716_1:GetPercentByPara(arg_716_1:FormatText(arg_716_1:GetWordFromCfg(1109402172).content), 2)

			if 0 < arg_716_1.time_ and arg_716_1.time_ <= 0 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0

				local var_719_4 = var_719_0 <= 0 and var_719_1 or var_719_1 * ((var_719_3 - arg_716_1.typewritterCharCountI18N) / var_719_0)

				if (var_719_0 <= 0 and var_719_1 or var_719_1 * ((var_719_3 - arg_716_1.typewritterCharCountI18N) / var_719_0)) > 0 and var_719_1 < var_719_4 then
					arg_716_1.talkMaxDuration = var_719_4

					if var_719_4 + 0 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_4 + 0
					end
				end
			end

			local var_719_5 = math.max(2.13333333333333, arg_716_1.talkMaxDuration)

			if 0 <= arg_716_1.time_ and arg_716_1.time_ < 0 + var_719_5 then
				arg_716_1.fswtw_.percent = Mathf.Lerp(arg_716_1.var_.oldValueTypewriter, var_719_2, (arg_716_1.time_ - 0) / var_719_5)
				arg_716_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_716_1.fswtw_:SetDirty()
			end

			if arg_716_1.time_ >= 0 + var_719_5 and arg_716_1.time_ < 0 + var_719_5 + arg_719_0 then
				arg_716_1.fswtw_.percent = var_719_2

				arg_716_1.fswtw_:SetDirty()
				arg_716_1:ShowNextGo(true)

				arg_716_1.typewritterCharCountI18N = var_719_3
			end
		end

		arg_716_1.nodeConfigList_ = {}

		arg_716_1:InitPlayNodeList()
	end,
	Play1109402174 = function(arg_720_0, arg_720_1)
		arg_720_1.time_ = 0
		arg_720_1.frameCnt_ = 0
		arg_720_1.state_ = "playing"
		arg_720_1.curTalkId_ = 1109402174
		arg_720_1.duration_ = 2.7

		SetActive(arg_720_1.tipsGo_, false)

		function arg_720_1.onSingleLineFinish_()
			arg_720_1.onSingleLineUpdate_ = nil
			arg_720_1.onSingleLineFinish_ = nil
			arg_720_1.state_ = "waiting"
		end

		function arg_720_1.playNext_(arg_722_0)
			if arg_722_0 == 1 then
				arg_720_0:Play1109402175(arg_720_1)
			end
		end

		function arg_720_1.onSingleLineUpdate_(arg_723_0)
			if 0 < arg_720_1.time_ and arg_720_1.time_ <= 0 + arg_723_0 then
				arg_720_1.var_.oldValueTypewriter = arg_720_1.fswtw_.percent

				SetActive(arg_720_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_720_1:ShowNextGo(false)
			end

			local var_723_0 = 13
			local var_723_1 = 0.866666666666667
			local var_723_2, var_723_3 = arg_720_1:GetPercentByPara(arg_720_1:FormatText(arg_720_1:GetWordFromCfg(1109402172).content), 3)

			if 0 < arg_720_1.time_ and arg_720_1.time_ <= 0 + arg_723_0 then
				arg_720_1.talkMaxDuration = 0

				local var_723_4 = var_723_0 <= 0 and var_723_1 or var_723_1 * ((var_723_3 - arg_720_1.typewritterCharCountI18N) / var_723_0)

				if (var_723_0 <= 0 and var_723_1 or var_723_1 * ((var_723_3 - arg_720_1.typewritterCharCountI18N) / var_723_0)) > 0 and var_723_1 < var_723_4 then
					arg_720_1.talkMaxDuration = var_723_4

					if var_723_4 + 0 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_4 + 0
					end
				end
			end

			local var_723_5 = math.max(0.866666666666667, arg_720_1.talkMaxDuration)

			if 0 <= arg_720_1.time_ and arg_720_1.time_ < 0 + var_723_5 then
				arg_720_1.fswtw_.percent = Mathf.Lerp(arg_720_1.var_.oldValueTypewriter, var_723_2, (arg_720_1.time_ - 0) / var_723_5)
				arg_720_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_720_1.fswtw_:SetDirty()
			end

			if arg_720_1.time_ >= 0 + var_723_5 and arg_720_1.time_ < 0 + var_723_5 + arg_723_0 then
				arg_720_1.fswtw_.percent = var_723_2

				arg_720_1.fswtw_:SetDirty()
				arg_720_1:ShowNextGo(true)

				arg_720_1.typewritterCharCountI18N = var_723_3
			end

			local var_723_6 = 0
			local var_723_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402174", "story_v_side_new_1109402.awb") / 1000

			if var_723_7 > 0 and 2.7 < var_723_7 and var_723_7 + var_723_6 > arg_720_1.duration_ then
				arg_720_1.duration_ = var_723_7 + var_723_6
			end

			if var_723_6 < arg_720_1.time_ and arg_720_1.time_ <= var_723_6 + arg_723_0 then
				arg_720_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402174", "story_v_side_new_1109402.awb")
			end
		end

		arg_720_1.nodeConfigList_ = {}

		arg_720_1:InitPlayNodeList()
	end,
	Play1109402175 = function(arg_724_0, arg_724_1)
		arg_724_1.time_ = 0
		arg_724_1.frameCnt_ = 0
		arg_724_1.state_ = "playing"
		arg_724_1.curTalkId_ = 1109402175
		arg_724_1.duration_ = 2.43

		SetActive(arg_724_1.tipsGo_, false)

		function arg_724_1.onSingleLineFinish_()
			arg_724_1.onSingleLineUpdate_ = nil
			arg_724_1.onSingleLineFinish_ = nil
			arg_724_1.state_ = "waiting"
		end

		function arg_724_1.playNext_(arg_726_0)
			if arg_726_0 == 1 then
				arg_724_0:Play1109402176(arg_724_1)
			end
		end

		function arg_724_1.onSingleLineUpdate_(arg_727_0)
			if 0 < arg_724_1.time_ and arg_724_1.time_ <= 0 + arg_727_0 then
				arg_724_1.var_.oldValueTypewriter = arg_724_1.fswtw_.percent

				SetActive(arg_724_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_724_1:ShowNextGo(false)
			end

			local var_727_0 = 10
			local var_727_1 = 0.666666666666667
			local var_727_2, var_727_3 = arg_724_1:GetPercentByPara(arg_724_1:FormatText(arg_724_1:GetWordFromCfg(1109402172).content), 4)

			if 0 < arg_724_1.time_ and arg_724_1.time_ <= 0 + arg_727_0 then
				arg_724_1.talkMaxDuration = 0

				local var_727_4 = var_727_0 <= 0 and var_727_1 or var_727_1 * ((var_727_3 - arg_724_1.typewritterCharCountI18N) / var_727_0)

				if (var_727_0 <= 0 and var_727_1 or var_727_1 * ((var_727_3 - arg_724_1.typewritterCharCountI18N) / var_727_0)) > 0 and var_727_1 < var_727_4 then
					arg_724_1.talkMaxDuration = var_727_4

					if var_727_4 + 0 > arg_724_1.duration_ then
						arg_724_1.duration_ = var_727_4 + 0
					end
				end
			end

			local var_727_5 = math.max(0.666666666666667, arg_724_1.talkMaxDuration)

			if 0 <= arg_724_1.time_ and arg_724_1.time_ < 0 + var_727_5 then
				arg_724_1.fswtw_.percent = Mathf.Lerp(arg_724_1.var_.oldValueTypewriter, var_727_2, (arg_724_1.time_ - 0) / var_727_5)
				arg_724_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_724_1.fswtw_:SetDirty()
			end

			if arg_724_1.time_ >= 0 + var_727_5 and arg_724_1.time_ < 0 + var_727_5 + arg_727_0 then
				arg_724_1.fswtw_.percent = var_727_2

				arg_724_1.fswtw_:SetDirty()
				arg_724_1:ShowNextGo(true)

				arg_724_1.typewritterCharCountI18N = var_727_3
			end

			local var_727_6 = 0
			local var_727_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402175", "story_v_side_new_1109402.awb") / 1000

			if var_727_7 > 0 and 2.433 < var_727_7 and var_727_7 + var_727_6 > arg_724_1.duration_ then
				arg_724_1.duration_ = var_727_7 + var_727_6
			end

			if var_727_6 < arg_724_1.time_ and arg_724_1.time_ <= var_727_6 + arg_727_0 then
				arg_724_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402175", "story_v_side_new_1109402.awb")
			end
		end

		arg_724_1.nodeConfigList_ = {}

		arg_724_1:InitPlayNodeList()
	end,
	Play1109402176 = function(arg_728_0, arg_728_1)
		arg_728_1.time_ = 0
		arg_728_1.frameCnt_ = 0
		arg_728_1.state_ = "playing"
		arg_728_1.curTalkId_ = 1109402176
		arg_728_1.duration_ = 1.97

		SetActive(arg_728_1.tipsGo_, false)

		function arg_728_1.onSingleLineFinish_()
			arg_728_1.onSingleLineUpdate_ = nil
			arg_728_1.onSingleLineFinish_ = nil
			arg_728_1.state_ = "waiting"
		end

		function arg_728_1.playNext_(arg_730_0)
			if arg_730_0 == 1 then
				arg_728_0:Play1109402177(arg_728_1)
			end
		end

		function arg_728_1.onSingleLineUpdate_(arg_731_0)
			if 0 < arg_728_1.time_ and arg_728_1.time_ <= 0 + arg_731_0 then
				arg_728_1.var_.oldValueTypewriter = arg_728_1.fswtw_.percent

				SetActive(arg_728_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_728_1:ShowNextGo(false)
			end

			local var_731_0 = 6
			local var_731_1 = 0.4
			local var_731_2, var_731_3 = arg_728_1:GetPercentByPara(arg_728_1:FormatText(arg_728_1:GetWordFromCfg(1109402172).content), 5)

			if 0 < arg_728_1.time_ and arg_728_1.time_ <= 0 + arg_731_0 then
				arg_728_1.talkMaxDuration = 0

				local var_731_4 = var_731_0 <= 0 and var_731_1 or var_731_1 * ((var_731_3 - arg_728_1.typewritterCharCountI18N) / var_731_0)

				if (var_731_0 <= 0 and var_731_1 or var_731_1 * ((var_731_3 - arg_728_1.typewritterCharCountI18N) / var_731_0)) > 0 and var_731_1 < var_731_4 then
					arg_728_1.talkMaxDuration = var_731_4

					if var_731_4 + 0 > arg_728_1.duration_ then
						arg_728_1.duration_ = var_731_4 + 0
					end
				end
			end

			local var_731_5 = math.max(0.4, arg_728_1.talkMaxDuration)

			if 0 <= arg_728_1.time_ and arg_728_1.time_ < 0 + var_731_5 then
				arg_728_1.fswtw_.percent = Mathf.Lerp(arg_728_1.var_.oldValueTypewriter, var_731_2, (arg_728_1.time_ - 0) / var_731_5)
				arg_728_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_728_1.fswtw_:SetDirty()
			end

			if arg_728_1.time_ >= 0 + var_731_5 and arg_728_1.time_ < 0 + var_731_5 + arg_731_0 then
				arg_728_1.fswtw_.percent = var_731_2

				arg_728_1.fswtw_:SetDirty()
				arg_728_1:ShowNextGo(true)

				arg_728_1.typewritterCharCountI18N = var_731_3
			end

			local var_731_6 = 0
			local var_731_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402176", "story_v_side_new_1109402.awb") / 1000

			if var_731_7 > 0 and 1.966 < var_731_7 and var_731_7 + var_731_6 > arg_728_1.duration_ then
				arg_728_1.duration_ = var_731_7 + var_731_6
			end

			if var_731_6 < arg_728_1.time_ and arg_728_1.time_ <= var_731_6 + arg_731_0 then
				arg_728_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402176", "story_v_side_new_1109402.awb")
			end
		end

		arg_728_1.nodeConfigList_ = {}

		arg_728_1:InitPlayNodeList()
	end,
	Play1109402177 = function(arg_732_0, arg_732_1)
		arg_732_1.time_ = 0
		arg_732_1.frameCnt_ = 0
		arg_732_1.state_ = "playing"
		arg_732_1.curTalkId_ = 1109402177
		arg_732_1.duration_ = 3.27

		SetActive(arg_732_1.tipsGo_, false)

		function arg_732_1.onSingleLineFinish_()
			arg_732_1.onSingleLineUpdate_ = nil
			arg_732_1.onSingleLineFinish_ = nil
			arg_732_1.state_ = "waiting"
		end

		function arg_732_1.playNext_(arg_734_0)
			if arg_734_0 == 1 then
				arg_732_0:Play1109402178(arg_732_1)
			end
		end

		function arg_732_1.onSingleLineUpdate_(arg_735_0)
			if 0 < arg_732_1.time_ and arg_732_1.time_ <= 0 + arg_735_0 then
				arg_732_1.var_.oldValueTypewriter = arg_732_1.fswtw_.percent

				SetActive(arg_732_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_732_1:ShowNextGo(false)
			end

			local var_735_0 = 11
			local var_735_1 = 0.733333333333333
			local var_735_2, var_735_3 = arg_732_1:GetPercentByPara(arg_732_1:FormatText(arg_732_1:GetWordFromCfg(1109402172).content), 6)

			if 0 < arg_732_1.time_ and arg_732_1.time_ <= 0 + arg_735_0 then
				arg_732_1.talkMaxDuration = 0

				local var_735_4 = var_735_0 <= 0 and var_735_1 or var_735_1 * ((var_735_3 - arg_732_1.typewritterCharCountI18N) / var_735_0)

				if (var_735_0 <= 0 and var_735_1 or var_735_1 * ((var_735_3 - arg_732_1.typewritterCharCountI18N) / var_735_0)) > 0 and var_735_1 < var_735_4 then
					arg_732_1.talkMaxDuration = var_735_4

					if var_735_4 + 0 > arg_732_1.duration_ then
						arg_732_1.duration_ = var_735_4 + 0
					end
				end
			end

			local var_735_5 = math.max(0.733333333333333, arg_732_1.talkMaxDuration)

			if 0 <= arg_732_1.time_ and arg_732_1.time_ < 0 + var_735_5 then
				arg_732_1.fswtw_.percent = Mathf.Lerp(arg_732_1.var_.oldValueTypewriter, var_735_2, (arg_732_1.time_ - 0) / var_735_5)
				arg_732_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_732_1.fswtw_:SetDirty()
			end

			if arg_732_1.time_ >= 0 + var_735_5 and arg_732_1.time_ < 0 + var_735_5 + arg_735_0 then
				arg_732_1.fswtw_.percent = var_735_2

				arg_732_1.fswtw_:SetDirty()
				arg_732_1:ShowNextGo(true)

				arg_732_1.typewritterCharCountI18N = var_735_3
			end

			local var_735_6 = 0
			local var_735_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402177", "story_v_side_new_1109402.awb") / 1000

			if var_735_7 > 0 and 3.266 < var_735_7 and var_735_7 + var_735_6 > arg_732_1.duration_ then
				arg_732_1.duration_ = var_735_7 + var_735_6
			end

			if var_735_6 < arg_732_1.time_ and arg_732_1.time_ <= var_735_6 + arg_735_0 then
				arg_732_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402177", "story_v_side_new_1109402.awb")
			end
		end

		arg_732_1.nodeConfigList_ = {}

		arg_732_1:InitPlayNodeList()
	end,
	Play1109402178 = function(arg_736_0, arg_736_1)
		arg_736_1.time_ = 0
		arg_736_1.frameCnt_ = 0
		arg_736_1.state_ = "playing"
		arg_736_1.curTalkId_ = 1109402178
		arg_736_1.duration_ = 3.83

		SetActive(arg_736_1.tipsGo_, false)

		function arg_736_1.onSingleLineFinish_()
			arg_736_1.onSingleLineUpdate_ = nil
			arg_736_1.onSingleLineFinish_ = nil
			arg_736_1.state_ = "waiting"
		end

		function arg_736_1.playNext_(arg_738_0)
			if arg_738_0 == 1 then
				arg_736_0:Play1109402179(arg_736_1)
			end
		end

		function arg_736_1.onSingleLineUpdate_(arg_739_0)
			if 0 < arg_736_1.time_ and arg_736_1.time_ <= 0 + arg_739_0 then
				arg_736_1.fswbg_:SetActive(true)
				arg_736_1.dialog_:SetActive(false)

				arg_736_1.fswtw_.percent = 0
				arg_736_1.fswt_.text = arg_736_1:FormatText(arg_736_1:GetWordFromCfg(1109402178).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_736_1.fswt_)

				arg_736_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_736_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_736_1.fswtw_:SetDirty()

				arg_736_1.typewritterCharCountI18N = 0

				SetActive(arg_736_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_736_1:ShowNextGo(false)
			end

			local var_739_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_736_1.time_ and arg_736_1.time_ <= var_739_0 + arg_739_0 then
				arg_736_1.var_.oldValueTypewriter = arg_736_1.fswtw_.percent

				SetActive(arg_736_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_736_1:ShowNextGo(false)
			end

			local var_739_1 = 12
			local var_739_2 = 0.8
			local var_739_3, var_739_4 = arg_736_1:GetPercentByPara(arg_736_1:FormatText(arg_736_1:GetWordFromCfg(1109402178).content), 1)

			if var_739_0 < arg_736_1.time_ and arg_736_1.time_ <= var_739_0 + arg_739_0 then
				arg_736_1.talkMaxDuration = 0

				local var_739_5 = var_739_1 <= 0 and var_739_2 or var_739_2 * ((var_739_4 - arg_736_1.typewritterCharCountI18N) / var_739_1)

				if (var_739_1 <= 0 and var_739_2 or var_739_2 * ((var_739_4 - arg_736_1.typewritterCharCountI18N) / var_739_1)) > 0 and var_739_2 < var_739_5 then
					arg_736_1.talkMaxDuration = var_739_5

					if var_739_5 + var_739_0 > arg_736_1.duration_ then
						arg_736_1.duration_ = var_739_5 + var_739_0
					end
				end
			end

			local var_739_6 = math.max(0.8, arg_736_1.talkMaxDuration)

			if var_739_0 <= arg_736_1.time_ and arg_736_1.time_ < var_739_0 + var_739_6 then
				arg_736_1.fswtw_.percent = Mathf.Lerp(arg_736_1.var_.oldValueTypewriter, var_739_3, (arg_736_1.time_ - var_739_0) / var_739_6)
				arg_736_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_736_1.fswtw_:SetDirty()
			end

			if arg_736_1.time_ >= var_739_0 + var_739_6 and arg_736_1.time_ < var_739_0 + var_739_6 + arg_739_0 then
				arg_736_1.fswtw_.percent = var_739_3

				arg_736_1.fswtw_:SetDirty()
				arg_736_1:ShowNextGo(true)

				arg_736_1.typewritterCharCountI18N = var_739_4
			end

			local var_739_7 = 0
			local var_739_8 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402178", "story_v_side_new_1109402.awb") / 1000

			if var_739_8 > 0 and 3.833 < var_739_8 and var_739_8 + var_739_7 > arg_736_1.duration_ then
				arg_736_1.duration_ = var_739_8 + var_739_7
			end

			if var_739_7 < arg_736_1.time_ and arg_736_1.time_ <= var_739_7 + arg_739_0 then
				arg_736_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402178", "story_v_side_new_1109402.awb")
			end
		end

		arg_736_1.nodeConfigList_ = {}

		arg_736_1:InitPlayNodeList()
	end,
	Play1109402179 = function(arg_740_0, arg_740_1)
		arg_740_1.time_ = 0
		arg_740_1.frameCnt_ = 0
		arg_740_1.state_ = "playing"
		arg_740_1.curTalkId_ = 1109402179
		arg_740_1.duration_ = 1.47

		SetActive(arg_740_1.tipsGo_, false)

		function arg_740_1.onSingleLineFinish_()
			arg_740_1.onSingleLineUpdate_ = nil
			arg_740_1.onSingleLineFinish_ = nil
			arg_740_1.state_ = "waiting"
		end

		function arg_740_1.playNext_(arg_742_0)
			if arg_742_0 == 1 then
				arg_740_0:Play1109402180(arg_740_1)
			end
		end

		function arg_740_1.onSingleLineUpdate_(arg_743_0)
			if 0 < arg_740_1.time_ and arg_740_1.time_ <= 0 + arg_743_0 then
				arg_740_1.var_.oldValueTypewriter = arg_740_1.fswtw_.percent

				SetActive(arg_740_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_740_1:ShowNextGo(false)
			end

			local var_743_0 = 22
			local var_743_1 = 1.46666666666667
			local var_743_2, var_743_3 = arg_740_1:GetPercentByPara(arg_740_1:FormatText(arg_740_1:GetWordFromCfg(1109402178).content), 2)

			if 0 < arg_740_1.time_ and arg_740_1.time_ <= 0 + arg_743_0 then
				arg_740_1.talkMaxDuration = 0

				local var_743_4 = var_743_0 <= 0 and var_743_1 or var_743_1 * ((var_743_3 - arg_740_1.typewritterCharCountI18N) / var_743_0)

				if (var_743_0 <= 0 and var_743_1 or var_743_1 * ((var_743_3 - arg_740_1.typewritterCharCountI18N) / var_743_0)) > 0 and var_743_1 < var_743_4 then
					arg_740_1.talkMaxDuration = var_743_4

					if var_743_4 + 0 > arg_740_1.duration_ then
						arg_740_1.duration_ = var_743_4 + 0
					end
				end
			end

			local var_743_5 = math.max(1.46666666666667, arg_740_1.talkMaxDuration)

			if 0 <= arg_740_1.time_ and arg_740_1.time_ < 0 + var_743_5 then
				arg_740_1.fswtw_.percent = Mathf.Lerp(arg_740_1.var_.oldValueTypewriter, var_743_2, (arg_740_1.time_ - 0) / var_743_5)
				arg_740_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_740_1.fswtw_:SetDirty()
			end

			if arg_740_1.time_ >= 0 + var_743_5 and arg_740_1.time_ < 0 + var_743_5 + arg_743_0 then
				arg_740_1.fswtw_.percent = var_743_2

				arg_740_1.fswtw_:SetDirty()
				arg_740_1:ShowNextGo(true)

				arg_740_1.typewritterCharCountI18N = var_743_3
			end
		end

		arg_740_1.nodeConfigList_ = {}

		arg_740_1:InitPlayNodeList()
	end,
	Play1109402180 = function(arg_744_0, arg_744_1)
		arg_744_1.time_ = 0
		arg_744_1.frameCnt_ = 0
		arg_744_1.state_ = "playing"
		arg_744_1.curTalkId_ = 1109402180
		arg_744_1.duration_ = 4.4

		SetActive(arg_744_1.tipsGo_, false)

		function arg_744_1.onSingleLineFinish_()
			arg_744_1.onSingleLineUpdate_ = nil
			arg_744_1.onSingleLineFinish_ = nil
			arg_744_1.state_ = "waiting"
		end

		function arg_744_1.playNext_(arg_746_0)
			if arg_746_0 == 1 then
				arg_744_0:Play1109402181(arg_744_1)
			end
		end

		function arg_744_1.onSingleLineUpdate_(arg_747_0)
			if 0 < arg_744_1.time_ and arg_744_1.time_ <= 0 + arg_747_0 then
				arg_744_1.var_.oldValueTypewriter = arg_744_1.fswtw_.percent

				SetActive(arg_744_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_744_1:ShowNextGo(false)
			end

			local var_747_0 = 18
			local var_747_1 = 1.2
			local var_747_2, var_747_3 = arg_744_1:GetPercentByPara(arg_744_1:FormatText(arg_744_1:GetWordFromCfg(1109402178).content), 3)

			if 0 < arg_744_1.time_ and arg_744_1.time_ <= 0 + arg_747_0 then
				arg_744_1.talkMaxDuration = 0

				local var_747_4 = var_747_0 <= 0 and var_747_1 or var_747_1 * ((var_747_3 - arg_744_1.typewritterCharCountI18N) / var_747_0)

				if (var_747_0 <= 0 and var_747_1 or var_747_1 * ((var_747_3 - arg_744_1.typewritterCharCountI18N) / var_747_0)) > 0 and var_747_1 < var_747_4 then
					arg_744_1.talkMaxDuration = var_747_4

					if var_747_4 + 0 > arg_744_1.duration_ then
						arg_744_1.duration_ = var_747_4 + 0
					end
				end
			end

			local var_747_5 = math.max(1.2, arg_744_1.talkMaxDuration)

			if 0 <= arg_744_1.time_ and arg_744_1.time_ < 0 + var_747_5 then
				arg_744_1.fswtw_.percent = Mathf.Lerp(arg_744_1.var_.oldValueTypewriter, var_747_2, (arg_744_1.time_ - 0) / var_747_5)
				arg_744_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_744_1.fswtw_:SetDirty()
			end

			if arg_744_1.time_ >= 0 + var_747_5 and arg_744_1.time_ < 0 + var_747_5 + arg_747_0 then
				arg_744_1.fswtw_.percent = var_747_2

				arg_744_1.fswtw_:SetDirty()
				arg_744_1:ShowNextGo(true)

				arg_744_1.typewritterCharCountI18N = var_747_3
			end

			local var_747_6 = 0
			local var_747_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402180", "story_v_side_new_1109402.awb") / 1000

			if var_747_7 > 0 and 4.4 < var_747_7 and var_747_7 + var_747_6 > arg_744_1.duration_ then
				arg_744_1.duration_ = var_747_7 + var_747_6
			end

			if var_747_6 < arg_744_1.time_ and arg_744_1.time_ <= var_747_6 + arg_747_0 then
				arg_744_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402180", "story_v_side_new_1109402.awb")
			end
		end

		arg_744_1.nodeConfigList_ = {}

		arg_744_1:InitPlayNodeList()
	end,
	Play1109402181 = function(arg_748_0, arg_748_1)
		arg_748_1.time_ = 0
		arg_748_1.frameCnt_ = 0
		arg_748_1.state_ = "playing"
		arg_748_1.curTalkId_ = 1109402181
		arg_748_1.duration_ = 1

		SetActive(arg_748_1.tipsGo_, false)

		function arg_748_1.onSingleLineFinish_()
			arg_748_1.onSingleLineUpdate_ = nil
			arg_748_1.onSingleLineFinish_ = nil
			arg_748_1.state_ = "waiting"
		end

		function arg_748_1.playNext_(arg_750_0)
			if arg_750_0 == 1 then
				arg_748_0:Play1109402182(arg_748_1)
			end
		end

		function arg_748_1.onSingleLineUpdate_(arg_751_0)
			if 0 < arg_748_1.time_ and arg_748_1.time_ <= 0 + arg_751_0 then
				arg_748_1.var_.oldValueTypewriter = arg_748_1.fswtw_.percent

				SetActive(arg_748_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_748_1:ShowNextGo(false)
			end

			local var_751_0 = 11
			local var_751_1 = 0.733333333333333
			local var_751_2, var_751_3 = arg_748_1:GetPercentByPara(arg_748_1:FormatText(arg_748_1:GetWordFromCfg(1109402178).content), 4)

			if 0 < arg_748_1.time_ and arg_748_1.time_ <= 0 + arg_751_0 then
				arg_748_1.talkMaxDuration = 0

				local var_751_4 = var_751_0 <= 0 and var_751_1 or var_751_1 * ((var_751_3 - arg_748_1.typewritterCharCountI18N) / var_751_0)

				if (var_751_0 <= 0 and var_751_1 or var_751_1 * ((var_751_3 - arg_748_1.typewritterCharCountI18N) / var_751_0)) > 0 and var_751_1 < var_751_4 then
					arg_748_1.talkMaxDuration = var_751_4

					if var_751_4 + 0 > arg_748_1.duration_ then
						arg_748_1.duration_ = var_751_4 + 0
					end
				end
			end

			local var_751_5 = math.max(0.733333333333333, arg_748_1.talkMaxDuration)

			if 0 <= arg_748_1.time_ and arg_748_1.time_ < 0 + var_751_5 then
				arg_748_1.fswtw_.percent = Mathf.Lerp(arg_748_1.var_.oldValueTypewriter, var_751_2, (arg_748_1.time_ - 0) / var_751_5)
				arg_748_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_748_1.fswtw_:SetDirty()
			end

			if arg_748_1.time_ >= 0 + var_751_5 and arg_748_1.time_ < 0 + var_751_5 + arg_751_0 then
				arg_748_1.fswtw_.percent = var_751_2

				arg_748_1.fswtw_:SetDirty()
				arg_748_1:ShowNextGo(true)

				arg_748_1.typewritterCharCountI18N = var_751_3
			end
		end

		arg_748_1.nodeConfigList_ = {}

		arg_748_1:InitPlayNodeList()
	end,
	Play1109402182 = function(arg_752_0, arg_752_1)
		arg_752_1.time_ = 0
		arg_752_1.frameCnt_ = 0
		arg_752_1.state_ = "playing"
		arg_752_1.curTalkId_ = 1109402182
		arg_752_1.duration_ = 6.07

		SetActive(arg_752_1.tipsGo_, false)

		function arg_752_1.onSingleLineFinish_()
			arg_752_1.onSingleLineUpdate_ = nil
			arg_752_1.onSingleLineFinish_ = nil
			arg_752_1.state_ = "waiting"
		end

		function arg_752_1.playNext_(arg_754_0)
			if arg_754_0 == 1 then
				arg_752_0:Play1109402183(arg_752_1)
			end
		end

		function arg_752_1.onSingleLineUpdate_(arg_755_0)
			if 0 < arg_752_1.time_ and arg_752_1.time_ <= 0 + arg_755_0 then
				arg_752_1.var_.oldValueTypewriter = arg_752_1.fswtw_.percent

				SetActive(arg_752_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_752_1:ShowNextGo(false)
			end

			local var_755_0 = 27
			local var_755_1 = 1.8
			local var_755_2, var_755_3 = arg_752_1:GetPercentByPara(arg_752_1:FormatText(arg_752_1:GetWordFromCfg(1109402178).content), 5)

			if 0 < arg_752_1.time_ and arg_752_1.time_ <= 0 + arg_755_0 then
				arg_752_1.talkMaxDuration = 0

				local var_755_4 = var_755_0 <= 0 and var_755_1 or var_755_1 * ((var_755_3 - arg_752_1.typewritterCharCountI18N) / var_755_0)

				if (var_755_0 <= 0 and var_755_1 or var_755_1 * ((var_755_3 - arg_752_1.typewritterCharCountI18N) / var_755_0)) > 0 and var_755_1 < var_755_4 then
					arg_752_1.talkMaxDuration = var_755_4

					if var_755_4 + 0 > arg_752_1.duration_ then
						arg_752_1.duration_ = var_755_4 + 0
					end
				end
			end

			local var_755_5 = math.max(1.8, arg_752_1.talkMaxDuration)

			if 0 <= arg_752_1.time_ and arg_752_1.time_ < 0 + var_755_5 then
				arg_752_1.fswtw_.percent = Mathf.Lerp(arg_752_1.var_.oldValueTypewriter, var_755_2, (arg_752_1.time_ - 0) / var_755_5)
				arg_752_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_752_1.fswtw_:SetDirty()
			end

			if arg_752_1.time_ >= 0 + var_755_5 and arg_752_1.time_ < 0 + var_755_5 + arg_755_0 then
				arg_752_1.fswtw_.percent = var_755_2

				arg_752_1.fswtw_:SetDirty()
				arg_752_1:ShowNextGo(true)

				arg_752_1.typewritterCharCountI18N = var_755_3
			end

			local var_755_6 = 0
			local var_755_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402182", "story_v_side_new_1109402.awb") / 1000

			if var_755_7 > 0 and 6.066 < var_755_7 and var_755_7 + var_755_6 > arg_752_1.duration_ then
				arg_752_1.duration_ = var_755_7 + var_755_6
			end

			if var_755_6 < arg_752_1.time_ and arg_752_1.time_ <= var_755_6 + arg_755_0 then
				arg_752_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402182", "story_v_side_new_1109402.awb")
			end
		end

		arg_752_1.nodeConfigList_ = {}

		arg_752_1:InitPlayNodeList()
	end,
	Play1109402183 = function(arg_756_0, arg_756_1)
		arg_756_1.time_ = 0
		arg_756_1.frameCnt_ = 0
		arg_756_1.state_ = "playing"
		arg_756_1.curTalkId_ = 1109402183
		arg_756_1.duration_ = 1.43

		SetActive(arg_756_1.tipsGo_, false)

		function arg_756_1.onSingleLineFinish_()
			arg_756_1.onSingleLineUpdate_ = nil
			arg_756_1.onSingleLineFinish_ = nil
			arg_756_1.state_ = "waiting"
		end

		function arg_756_1.playNext_(arg_758_0)
			if arg_758_0 == 1 then
				arg_756_0:Play1109402184(arg_756_1)
			end
		end

		function arg_756_1.onSingleLineUpdate_(arg_759_0)
			if 0 < arg_756_1.time_ and arg_756_1.time_ <= 0 + arg_759_0 then
				arg_756_1.var_.oldValueTypewriter = arg_756_1.fswtw_.percent

				SetActive(arg_756_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_756_1:ShowNextGo(false)
			end

			local var_759_0 = 5
			local var_759_1 = 0.333333333333333
			local var_759_2, var_759_3 = arg_756_1:GetPercentByPara(arg_756_1:FormatText(arg_756_1:GetWordFromCfg(1109402178).content), 6)

			if 0 < arg_756_1.time_ and arg_756_1.time_ <= 0 + arg_759_0 then
				arg_756_1.talkMaxDuration = 0

				local var_759_4 = var_759_0 <= 0 and var_759_1 or var_759_1 * ((var_759_3 - arg_756_1.typewritterCharCountI18N) / var_759_0)

				if (var_759_0 <= 0 and var_759_1 or var_759_1 * ((var_759_3 - arg_756_1.typewritterCharCountI18N) / var_759_0)) > 0 and var_759_1 < var_759_4 then
					arg_756_1.talkMaxDuration = var_759_4

					if var_759_4 + 0 > arg_756_1.duration_ then
						arg_756_1.duration_ = var_759_4 + 0
					end
				end
			end

			local var_759_5 = math.max(0.333333333333333, arg_756_1.talkMaxDuration)

			if 0 <= arg_756_1.time_ and arg_756_1.time_ < 0 + var_759_5 then
				arg_756_1.fswtw_.percent = Mathf.Lerp(arg_756_1.var_.oldValueTypewriter, var_759_2, (arg_756_1.time_ - 0) / var_759_5)
				arg_756_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_756_1.fswtw_:SetDirty()
			end

			if arg_756_1.time_ >= 0 + var_759_5 and arg_756_1.time_ < 0 + var_759_5 + arg_759_0 then
				arg_756_1.fswtw_.percent = var_759_2

				arg_756_1.fswtw_:SetDirty()
				arg_756_1:ShowNextGo(true)

				arg_756_1.typewritterCharCountI18N = var_759_3
			end

			local var_759_6 = 0
			local var_759_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402183", "story_v_side_new_1109402.awb") / 1000

			if var_759_7 > 0 and 1.433 < var_759_7 and var_759_7 + var_759_6 > arg_756_1.duration_ then
				arg_756_1.duration_ = var_759_7 + var_759_6
			end

			if var_759_6 < arg_756_1.time_ and arg_756_1.time_ <= var_759_6 + arg_759_0 then
				arg_756_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402183", "story_v_side_new_1109402.awb")
			end
		end

		arg_756_1.nodeConfigList_ = {}

		arg_756_1:InitPlayNodeList()
	end,
	Play1109402184 = function(arg_760_0, arg_760_1)
		arg_760_1.time_ = 0
		arg_760_1.frameCnt_ = 0
		arg_760_1.state_ = "playing"
		arg_760_1.curTalkId_ = 1109402184
		arg_760_1.duration_ = 1.95

		SetActive(arg_760_1.tipsGo_, false)

		function arg_760_1.onSingleLineFinish_()
			arg_760_1.onSingleLineUpdate_ = nil
			arg_760_1.onSingleLineFinish_ = nil
			arg_760_1.state_ = "waiting"
		end

		function arg_760_1.playNext_(arg_762_0)
			if arg_762_0 == 1 then
				arg_760_0:Play1109402185(arg_760_1)
			end
		end

		function arg_760_1.onSingleLineUpdate_(arg_763_0)
			if 0 < arg_760_1.time_ and arg_760_1.time_ <= 0 + arg_763_0 then
				arg_760_1.fswbg_:SetActive(true)
				arg_760_1.dialog_:SetActive(false)

				arg_760_1.fswtw_.percent = 0
				arg_760_1.fswt_.text = arg_760_1:FormatText(arg_760_1:GetWordFromCfg(1109402184).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_760_1.fswt_)

				arg_760_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_760_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_760_1.fswtw_:SetDirty()

				arg_760_1.typewritterCharCountI18N = 0

				SetActive(arg_760_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_760_1:ShowNextGo(false)
			end

			local var_763_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_760_1.time_ and arg_760_1.time_ <= var_763_0 + arg_763_0 then
				arg_760_1.var_.oldValueTypewriter = arg_760_1.fswtw_.percent

				SetActive(arg_760_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_760_1:ShowNextGo(false)
			end

			local var_763_1 = 29
			local var_763_2 = 1.93333333333333
			local var_763_3, var_763_4 = arg_760_1:GetPercentByPara(arg_760_1:FormatText(arg_760_1:GetWordFromCfg(1109402184).content), 1)

			if var_763_0 < arg_760_1.time_ and arg_760_1.time_ <= var_763_0 + arg_763_0 then
				arg_760_1.talkMaxDuration = 0

				local var_763_5 = var_763_1 <= 0 and var_763_2 or var_763_2 * ((var_763_4 - arg_760_1.typewritterCharCountI18N) / var_763_1)

				if (var_763_1 <= 0 and var_763_2 or var_763_2 * ((var_763_4 - arg_760_1.typewritterCharCountI18N) / var_763_1)) > 0 and var_763_2 < var_763_5 then
					arg_760_1.talkMaxDuration = var_763_5

					if var_763_5 + var_763_0 > arg_760_1.duration_ then
						arg_760_1.duration_ = var_763_5 + var_763_0
					end
				end
			end

			local var_763_6 = math.max(1.93333333333333, arg_760_1.talkMaxDuration)

			if var_763_0 <= arg_760_1.time_ and arg_760_1.time_ < var_763_0 + var_763_6 then
				arg_760_1.fswtw_.percent = Mathf.Lerp(arg_760_1.var_.oldValueTypewriter, var_763_3, (arg_760_1.time_ - var_763_0) / var_763_6)
				arg_760_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_760_1.fswtw_:SetDirty()
			end

			if arg_760_1.time_ >= var_763_0 + var_763_6 and arg_760_1.time_ < var_763_0 + var_763_6 + arg_763_0 then
				arg_760_1.fswtw_.percent = var_763_3

				arg_760_1.fswtw_:SetDirty()
				arg_760_1:ShowNextGo(true)

				arg_760_1.typewritterCharCountI18N = var_763_4
			end
		end

		arg_760_1.nodeConfigList_ = {}

		arg_760_1:InitPlayNodeList()
	end,
	Play1109402185 = function(arg_764_0, arg_764_1)
		arg_764_1.time_ = 0
		arg_764_1.frameCnt_ = 0
		arg_764_1.state_ = "playing"
		arg_764_1.curTalkId_ = 1109402185
		arg_764_1.duration_ = 9.3

		SetActive(arg_764_1.tipsGo_, false)

		function arg_764_1.onSingleLineFinish_()
			arg_764_1.onSingleLineUpdate_ = nil
			arg_764_1.onSingleLineFinish_ = nil
			arg_764_1.state_ = "waiting"
		end

		function arg_764_1.playNext_(arg_766_0)
			if arg_766_0 == 1 then
				arg_764_0:Play1109402186(arg_764_1)
			end
		end

		function arg_764_1.onSingleLineUpdate_(arg_767_0)
			if 0 < arg_764_1.time_ and arg_764_1.time_ <= 0 + arg_767_0 then
				arg_764_1.var_.oldValueTypewriter = arg_764_1.fswtw_.percent

				SetActive(arg_764_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_764_1:ShowNextGo(false)
			end

			local var_767_0 = 43
			local var_767_1 = 2.86666666666667
			local var_767_2, var_767_3 = arg_764_1:GetPercentByPara(arg_764_1:FormatText(arg_764_1:GetWordFromCfg(1109402184).content), 2)

			if 0 < arg_764_1.time_ and arg_764_1.time_ <= 0 + arg_767_0 then
				arg_764_1.talkMaxDuration = 0

				local var_767_4 = var_767_0 <= 0 and var_767_1 or var_767_1 * ((var_767_3 - arg_764_1.typewritterCharCountI18N) / var_767_0)

				if (var_767_0 <= 0 and var_767_1 or var_767_1 * ((var_767_3 - arg_764_1.typewritterCharCountI18N) / var_767_0)) > 0 and var_767_1 < var_767_4 then
					arg_764_1.talkMaxDuration = var_767_4

					if var_767_4 + 0 > arg_764_1.duration_ then
						arg_764_1.duration_ = var_767_4 + 0
					end
				end
			end

			local var_767_5 = math.max(2.86666666666667, arg_764_1.talkMaxDuration)

			if 0 <= arg_764_1.time_ and arg_764_1.time_ < 0 + var_767_5 then
				arg_764_1.fswtw_.percent = Mathf.Lerp(arg_764_1.var_.oldValueTypewriter, var_767_2, (arg_764_1.time_ - 0) / var_767_5)
				arg_764_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_764_1.fswtw_:SetDirty()
			end

			if arg_764_1.time_ >= 0 + var_767_5 and arg_764_1.time_ < 0 + var_767_5 + arg_767_0 then
				arg_764_1.fswtw_.percent = var_767_2

				arg_764_1.fswtw_:SetDirty()
				arg_764_1:ShowNextGo(true)

				arg_764_1.typewritterCharCountI18N = var_767_3
			end

			local var_767_6 = 0
			local var_767_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402185", "story_v_side_new_1109402.awb") / 1000

			if var_767_7 > 0 and 9.3 < var_767_7 and var_767_7 + var_767_6 > arg_764_1.duration_ then
				arg_764_1.duration_ = var_767_7 + var_767_6
			end

			if var_767_6 < arg_764_1.time_ and arg_764_1.time_ <= var_767_6 + arg_767_0 then
				arg_764_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402185", "story_v_side_new_1109402.awb")
			end
		end

		arg_764_1.nodeConfigList_ = {}

		arg_764_1:InitPlayNodeList()
	end,
	Play1109402186 = function(arg_768_0, arg_768_1)
		arg_768_1.time_ = 0
		arg_768_1.frameCnt_ = 0
		arg_768_1.state_ = "playing"
		arg_768_1.curTalkId_ = 1109402186
		arg_768_1.duration_ = 1.13

		SetActive(arg_768_1.tipsGo_, false)

		function arg_768_1.onSingleLineFinish_()
			arg_768_1.onSingleLineUpdate_ = nil
			arg_768_1.onSingleLineFinish_ = nil
			arg_768_1.state_ = "waiting"
		end

		function arg_768_1.playNext_(arg_770_0)
			if arg_770_0 == 1 then
				arg_768_0:Play1109402187(arg_768_1)
			end
		end

		function arg_768_1.onSingleLineUpdate_(arg_771_0)
			if 0 < arg_768_1.time_ and arg_768_1.time_ <= 0 + arg_771_0 then
				arg_768_1.var_.oldValueTypewriter = arg_768_1.fswtw_.percent

				SetActive(arg_768_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_768_1:ShowNextGo(false)
			end

			local var_771_0 = 7
			local var_771_1 = 0.466666666666667
			local var_771_2, var_771_3 = arg_768_1:GetPercentByPara(arg_768_1:FormatText(arg_768_1:GetWordFromCfg(1109402184).content), 3)

			if 0 < arg_768_1.time_ and arg_768_1.time_ <= 0 + arg_771_0 then
				arg_768_1.talkMaxDuration = 0

				local var_771_4 = var_771_0 <= 0 and var_771_1 or var_771_1 * ((var_771_3 - arg_768_1.typewritterCharCountI18N) / var_771_0)

				if (var_771_0 <= 0 and var_771_1 or var_771_1 * ((var_771_3 - arg_768_1.typewritterCharCountI18N) / var_771_0)) > 0 and var_771_1 < var_771_4 then
					arg_768_1.talkMaxDuration = var_771_4

					if var_771_4 + 0 > arg_768_1.duration_ then
						arg_768_1.duration_ = var_771_4 + 0
					end
				end
			end

			local var_771_5 = math.max(0.466666666666667, arg_768_1.talkMaxDuration)

			if 0 <= arg_768_1.time_ and arg_768_1.time_ < 0 + var_771_5 then
				arg_768_1.fswtw_.percent = Mathf.Lerp(arg_768_1.var_.oldValueTypewriter, var_771_2, (arg_768_1.time_ - 0) / var_771_5)
				arg_768_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_768_1.fswtw_:SetDirty()
			end

			if arg_768_1.time_ >= 0 + var_771_5 and arg_768_1.time_ < 0 + var_771_5 + arg_771_0 then
				arg_768_1.fswtw_.percent = var_771_2

				arg_768_1.fswtw_:SetDirty()
				arg_768_1:ShowNextGo(true)

				arg_768_1.typewritterCharCountI18N = var_771_3
			end

			local var_771_6 = 0
			local var_771_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402186", "story_v_side_new_1109402.awb") / 1000

			if var_771_7 > 0 and 1.133 < var_771_7 and var_771_7 + var_771_6 > arg_768_1.duration_ then
				arg_768_1.duration_ = var_771_7 + var_771_6
			end

			if var_771_6 < arg_768_1.time_ and arg_768_1.time_ <= var_771_6 + arg_771_0 then
				arg_768_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402186", "story_v_side_new_1109402.awb")
			end
		end

		arg_768_1.nodeConfigList_ = {}

		arg_768_1:InitPlayNodeList()
	end,
	Play1109402187 = function(arg_772_0, arg_772_1)
		arg_772_1.time_ = 0
		arg_772_1.frameCnt_ = 0
		arg_772_1.state_ = "playing"
		arg_772_1.curTalkId_ = 1109402187
		arg_772_1.duration_ = 7.9

		SetActive(arg_772_1.tipsGo_, false)

		function arg_772_1.onSingleLineFinish_()
			arg_772_1.onSingleLineUpdate_ = nil
			arg_772_1.onSingleLineFinish_ = nil
			arg_772_1.state_ = "waiting"
		end

		function arg_772_1.playNext_(arg_774_0)
			if arg_774_0 == 1 then
				arg_772_0:Play1109402188(arg_772_1)
			end
		end

		function arg_772_1.onSingleLineUpdate_(arg_775_0)
			if 0 < arg_772_1.time_ and arg_772_1.time_ <= 0 + arg_775_0 then
				arg_772_1.var_.oldValueTypewriter = arg_772_1.fswtw_.percent

				SetActive(arg_772_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_772_1:ShowNextGo(false)
			end

			local var_775_0 = 38
			local var_775_1 = 2.53333333333333
			local var_775_2, var_775_3 = arg_772_1:GetPercentByPara(arg_772_1:FormatText(arg_772_1:GetWordFromCfg(1109402184).content), 4)

			if 0 < arg_772_1.time_ and arg_772_1.time_ <= 0 + arg_775_0 then
				arg_772_1.talkMaxDuration = 0

				local var_775_4 = var_775_0 <= 0 and var_775_1 or var_775_1 * ((var_775_3 - arg_772_1.typewritterCharCountI18N) / var_775_0)

				if (var_775_0 <= 0 and var_775_1 or var_775_1 * ((var_775_3 - arg_772_1.typewritterCharCountI18N) / var_775_0)) > 0 and var_775_1 < var_775_4 then
					arg_772_1.talkMaxDuration = var_775_4

					if var_775_4 + 0 > arg_772_1.duration_ then
						arg_772_1.duration_ = var_775_4 + 0
					end
				end
			end

			local var_775_5 = math.max(2.53333333333333, arg_772_1.talkMaxDuration)

			if 0 <= arg_772_1.time_ and arg_772_1.time_ < 0 + var_775_5 then
				arg_772_1.fswtw_.percent = Mathf.Lerp(arg_772_1.var_.oldValueTypewriter, var_775_2, (arg_772_1.time_ - 0) / var_775_5)
				arg_772_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_772_1.fswtw_:SetDirty()
			end

			if arg_772_1.time_ >= 0 + var_775_5 and arg_772_1.time_ < 0 + var_775_5 + arg_775_0 then
				arg_772_1.fswtw_.percent = var_775_2

				arg_772_1.fswtw_:SetDirty()
				arg_772_1:ShowNextGo(true)

				arg_772_1.typewritterCharCountI18N = var_775_3
			end

			local var_775_6 = 0
			local var_775_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402187", "story_v_side_new_1109402.awb") / 1000

			if var_775_7 > 0 and 7.9 < var_775_7 and var_775_7 + var_775_6 > arg_772_1.duration_ then
				arg_772_1.duration_ = var_775_7 + var_775_6
			end

			if var_775_6 < arg_772_1.time_ and arg_772_1.time_ <= var_775_6 + arg_775_0 then
				arg_772_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402187", "story_v_side_new_1109402.awb")
			end
		end

		arg_772_1.nodeConfigList_ = {}

		arg_772_1:InitPlayNodeList()
	end,
	Play1109402188 = function(arg_776_0, arg_776_1)
		arg_776_1.time_ = 0
		arg_776_1.frameCnt_ = 0
		arg_776_1.state_ = "playing"
		arg_776_1.curTalkId_ = 1109402188
		arg_776_1.duration_ = 0.67

		SetActive(arg_776_1.tipsGo_, false)

		function arg_776_1.onSingleLineFinish_()
			arg_776_1.onSingleLineUpdate_ = nil
			arg_776_1.onSingleLineFinish_ = nil
			arg_776_1.state_ = "waiting"
		end

		function arg_776_1.playNext_(arg_778_0)
			if arg_778_0 == 1 then
				arg_776_0:Play1109402189(arg_776_1)
			end
		end

		function arg_776_1.onSingleLineUpdate_(arg_779_0)
			if 0 < arg_776_1.time_ and arg_776_1.time_ <= 0 + arg_779_0 then
				arg_776_1.var_.oldValueTypewriter = arg_776_1.fswtw_.percent

				SetActive(arg_776_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_776_1:ShowNextGo(false)
			end

			local var_779_0 = 10
			local var_779_1 = 0.666666666666667
			local var_779_2, var_779_3 = arg_776_1:GetPercentByPara(arg_776_1:FormatText(arg_776_1:GetWordFromCfg(1109402184).content), 5)

			if 0 < arg_776_1.time_ and arg_776_1.time_ <= 0 + arg_779_0 then
				arg_776_1.talkMaxDuration = 0

				local var_779_4 = var_779_0 <= 0 and var_779_1 or var_779_1 * ((var_779_3 - arg_776_1.typewritterCharCountI18N) / var_779_0)

				if (var_779_0 <= 0 and var_779_1 or var_779_1 * ((var_779_3 - arg_776_1.typewritterCharCountI18N) / var_779_0)) > 0 and var_779_1 < var_779_4 then
					arg_776_1.talkMaxDuration = var_779_4

					if var_779_4 + 0 > arg_776_1.duration_ then
						arg_776_1.duration_ = var_779_4 + 0
					end
				end
			end

			local var_779_5 = math.max(0.666666666666667, arg_776_1.talkMaxDuration)

			if 0 <= arg_776_1.time_ and arg_776_1.time_ < 0 + var_779_5 then
				arg_776_1.fswtw_.percent = Mathf.Lerp(arg_776_1.var_.oldValueTypewriter, var_779_2, (arg_776_1.time_ - 0) / var_779_5)
				arg_776_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_776_1.fswtw_:SetDirty()
			end

			if arg_776_1.time_ >= 0 + var_779_5 and arg_776_1.time_ < 0 + var_779_5 + arg_779_0 then
				arg_776_1.fswtw_.percent = var_779_2

				arg_776_1.fswtw_:SetDirty()
				arg_776_1:ShowNextGo(true)

				arg_776_1.typewritterCharCountI18N = var_779_3
			end
		end

		arg_776_1.nodeConfigList_ = {}

		arg_776_1:InitPlayNodeList()
	end,
	Play1109402189 = function(arg_780_0, arg_780_1)
		arg_780_1.time_ = 0
		arg_780_1.frameCnt_ = 0
		arg_780_1.state_ = "playing"
		arg_780_1.curTalkId_ = 1109402189
		arg_780_1.duration_ = 1.3

		SetActive(arg_780_1.tipsGo_, false)

		function arg_780_1.onSingleLineFinish_()
			arg_780_1.onSingleLineUpdate_ = nil
			arg_780_1.onSingleLineFinish_ = nil
			arg_780_1.state_ = "waiting"
		end

		function arg_780_1.playNext_(arg_782_0)
			if arg_782_0 == 1 then
				arg_780_0:Play1109402190(arg_780_1)
			end
		end

		function arg_780_1.onSingleLineUpdate_(arg_783_0)
			if 0 < arg_780_1.time_ and arg_780_1.time_ <= 0 + arg_783_0 then
				arg_780_1.var_.oldValueTypewriter = arg_780_1.fswtw_.percent

				SetActive(arg_780_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_780_1:ShowNextGo(false)
			end

			local var_783_0 = 5
			local var_783_1 = 0.333333333333333
			local var_783_2, var_783_3 = arg_780_1:GetPercentByPara(arg_780_1:FormatText(arg_780_1:GetWordFromCfg(1109402184).content), 6)

			if 0 < arg_780_1.time_ and arg_780_1.time_ <= 0 + arg_783_0 then
				arg_780_1.talkMaxDuration = 0

				local var_783_4 = var_783_0 <= 0 and var_783_1 or var_783_1 * ((var_783_3 - arg_780_1.typewritterCharCountI18N) / var_783_0)

				if (var_783_0 <= 0 and var_783_1 or var_783_1 * ((var_783_3 - arg_780_1.typewritterCharCountI18N) / var_783_0)) > 0 and var_783_1 < var_783_4 then
					arg_780_1.talkMaxDuration = var_783_4

					if var_783_4 + 0 > arg_780_1.duration_ then
						arg_780_1.duration_ = var_783_4 + 0
					end
				end
			end

			local var_783_5 = math.max(0.333333333333333, arg_780_1.talkMaxDuration)

			if 0 <= arg_780_1.time_ and arg_780_1.time_ < 0 + var_783_5 then
				arg_780_1.fswtw_.percent = Mathf.Lerp(arg_780_1.var_.oldValueTypewriter, var_783_2, (arg_780_1.time_ - 0) / var_783_5)
				arg_780_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_780_1.fswtw_:SetDirty()
			end

			if arg_780_1.time_ >= 0 + var_783_5 and arg_780_1.time_ < 0 + var_783_5 + arg_783_0 then
				arg_780_1.fswtw_.percent = var_783_2

				arg_780_1.fswtw_:SetDirty()
				arg_780_1:ShowNextGo(true)

				arg_780_1.typewritterCharCountI18N = var_783_3
			end

			local var_783_6 = 0
			local var_783_7 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402189", "story_v_side_new_1109402.awb") / 1000

			if var_783_7 > 0 and 1.3 < var_783_7 and var_783_7 + var_783_6 > arg_780_1.duration_ then
				arg_780_1.duration_ = var_783_7 + var_783_6
			end

			if var_783_6 < arg_780_1.time_ and arg_780_1.time_ <= var_783_6 + arg_783_0 then
				arg_780_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402189", "story_v_side_new_1109402.awb")
			end
		end

		arg_780_1.nodeConfigList_ = {}

		arg_780_1:InitPlayNodeList()
	end,
	Play1109402190 = function(arg_784_0, arg_784_1)
		arg_784_1.time_ = 0
		arg_784_1.frameCnt_ = 0
		arg_784_1.state_ = "playing"
		arg_784_1.curTalkId_ = 1109402190
		arg_784_1.duration_ = 7

		SetActive(arg_784_1.tipsGo_, false)

		function arg_784_1.onSingleLineFinish_()
			arg_784_1.onSingleLineUpdate_ = nil
			arg_784_1.onSingleLineFinish_ = nil
			arg_784_1.state_ = "waiting"
		end

		function arg_784_1.playNext_(arg_786_0)
			if arg_786_0 == 1 then
				arg_784_0:Play1109402191(arg_784_1)
			end
		end

		function arg_784_1.onSingleLineUpdate_(arg_787_0)
			if 0 < arg_784_1.time_ and arg_784_1.time_ <= 0 + arg_787_0 then
				if arg_784_0.sceneSettingEffect_ then
					arg_784_1.sceneSettingEffect_.enabled = false
				end

				arg_784_1.sceneSettingGo_:SetActive(true)

				local var_787_0 = arg_784_1.bgs_.ST03a

				arg_784_1.bgs_.ST03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_787_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_787_1 = var_787_0:GetComponent("SpriteRenderer")

				if var_787_1 and var_787_1.sprite then
					local var_787_2 = 2 * (var_787_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_787_0.transform.localScale = Vector3.New(var_787_2 / var_787_1.sprite.bounds.size.y < var_787_2 * manager.ui.mainCameraCom_.aspect / var_787_1.sprite.bounds.size.x and var_787_2 * manager.ui.mainCameraCom_.aspect / var_787_1.sprite.bounds.size.x or var_787_2 / var_787_1.sprite.bounds.size.y, var_787_2 / var_787_1.sprite.bounds.size.y < var_787_2 * manager.ui.mainCameraCom_.aspect / var_787_1.sprite.bounds.size.x and var_787_2 * manager.ui.mainCameraCom_.aspect / var_787_1.sprite.bounds.size.x or var_787_2 / var_787_1.sprite.bounds.size.y, 0)
				end

				for iter_787_0, iter_787_1 in pairs(arg_784_1.bgs_) do
					if iter_787_0 ~= "ST03a" then
						iter_787_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_787_3 = 0

			if 0 < arg_784_1.time_ and arg_784_1.time_ <= var_787_3 + arg_787_0 then
				arg_784_1.mask_.enabled = true
				arg_784_1.mask_.raycastTarget = true

				arg_784_1:SetGaussion(false)
			end

			local var_787_4 = 2

			if var_787_3 <= arg_784_1.time_ and arg_784_1.time_ < var_787_3 + var_787_4 then
				local var_787_5 = Color.New(0, 0, 0)

				var_787_5.a = Mathf.Lerp(1, 0, (arg_784_1.time_ - var_787_3) / var_787_4)
				arg_784_1.mask_.color = var_787_5
			end

			if arg_784_1.time_ >= var_787_3 + var_787_4 and arg_784_1.time_ < var_787_3 + var_787_4 + arg_787_0 then
				local var_787_6 = Color.New(0, 0, 0)

				arg_784_1.mask_.enabled = false
				var_787_6.a = 0
				arg_784_1.mask_.color = var_787_6
			end

			if 0 < arg_784_1.time_ and arg_784_1.time_ <= 0 + arg_787_0 then
				arg_784_1.fswbg_:SetActive(false)
				arg_784_1.dialog_:SetActive(false)
				SetActive(arg_784_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_784_1:ShowNextGo(false)
			end

			if arg_784_1.frameCnt_ <= 1 then
				arg_784_1.dialog_:SetActive(false)
			end

			local var_787_7 = 2
			local var_787_8 = 1

			if 2 < arg_784_1.time_ and arg_784_1.time_ <= var_787_7 + arg_787_0 then
				arg_784_1.talkMaxDuration = 0

				arg_784_1.dialog_:SetActive(true)

				arg_784_1.dialogCg_.alpha = 0

				local var_787_9 = LeanTween.value(arg_784_1.dialog_, 0, 1, 0.3)

				var_787_9:setOnUpdate(LuaHelper.FloatAction(function(arg_788_0)
					arg_784_1.dialogCg_.alpha = arg_788_0
				end))
				var_787_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_784_1.dialog_)
					var_787_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_784_1.duration_ = arg_784_1.duration_ + 0.3

				SetActive(arg_784_1.leftNameGo_, false)

				arg_784_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_784_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_784_1:RecordName(arg_784_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_784_1.iconTrs_.gameObject, false)
				arg_784_1.callingController_:SetSelectedState("normal")

				local var_787_10 = arg_784_1:FormatText(arg_784_1:GetWordFromCfg(1109402190).content)

				arg_784_1.text_.text = var_787_10

				LuaForUtil.ClearLinePrefixSymbol(arg_784_1.text_)

				local var_787_12 = 40 <= 0 and var_787_8 or var_787_8 * (utf8.len(var_787_10) / 40)

				if (40 <= 0 and var_787_8 or var_787_8 * (utf8.len(var_787_10) / 40)) > 0 and var_787_8 < var_787_12 then
					arg_784_1.talkMaxDuration = var_787_12
					var_787_7 = var_787_7 + 0.3

					if var_787_12 + var_787_7 > arg_784_1.duration_ then
						arg_784_1.duration_ = var_787_12 + var_787_7
					end
				end

				arg_784_1.text_.text = var_787_10
				arg_784_1.typewritter.percent = 0

				arg_784_1.typewritter:SetDirty()
				arg_784_1:ShowNextGo(false)
				arg_784_1:RecordContent(arg_784_1.text_.text)
			end

			local var_787_13 = var_787_7 + 0.3
			local var_787_14 = math.max(var_787_8, arg_784_1.talkMaxDuration)

			if var_787_7 + 0.3 <= arg_784_1.time_ and arg_784_1.time_ < var_787_13 + var_787_14 then
				arg_784_1.typewritter.percent = (arg_784_1.time_ - var_787_13) / var_787_14

				arg_784_1.typewritter:SetDirty()
			end

			if arg_784_1.time_ >= var_787_13 + var_787_14 and arg_784_1.time_ < var_787_13 + var_787_14 + arg_787_0 then
				arg_784_1.typewritter.percent = 1

				arg_784_1.typewritter:SetDirty()
				arg_784_1:ShowNextGo(true)
			end
		end

		arg_784_1.nodeConfigList_ = {}

		arg_784_1:InitPlayNodeList()
	end,
	Play1109402191 = function(arg_790_0, arg_790_1)
		arg_790_1.time_ = 0
		arg_790_1.frameCnt_ = 0
		arg_790_1.state_ = "playing"
		arg_790_1.curTalkId_ = 1109402191
		arg_790_1.duration_ = 5

		SetActive(arg_790_1.tipsGo_, false)

		function arg_790_1.onSingleLineFinish_()
			arg_790_1.onSingleLineUpdate_ = nil
			arg_790_1.onSingleLineFinish_ = nil
			arg_790_1.state_ = "waiting"
		end

		function arg_790_1.playNext_(arg_792_0)
			if arg_792_0 == 1 then
				arg_790_0:Play1109402192(arg_790_1)
			end
		end

		function arg_790_1.onSingleLineUpdate_(arg_793_0)
			if 0 < arg_790_1.time_ and arg_790_1.time_ <= 0 + arg_793_0 then
				arg_790_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_fireworks_loop", "")
			end

			local var_793_1 = 0
			local var_793_2 = 1

			if 0 < arg_790_1.time_ and arg_790_1.time_ <= var_793_1 + arg_793_0 then
				arg_790_1.talkMaxDuration = 0
				arg_790_1.dialogCg_.alpha = 1

				arg_790_1.dialog_:SetActive(true)
				SetActive(arg_790_1.leftNameGo_, false)

				arg_790_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_790_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_790_1:RecordName(arg_790_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_790_1.iconTrs_.gameObject, false)
				arg_790_1.callingController_:SetSelectedState("normal")

				local var_793_3 = arg_790_1:FormatText(arg_790_1:GetWordFromCfg(1109402191).content)

				arg_790_1.text_.text = var_793_3

				LuaForUtil.ClearLinePrefixSymbol(arg_790_1.text_)

				local var_793_5 = 40 <= 0 and var_793_2 or var_793_2 * (utf8.len(var_793_3) / 40)

				if (40 <= 0 and var_793_2 or var_793_2 * (utf8.len(var_793_3) / 40)) > 0 and var_793_2 < var_793_5 then
					arg_790_1.talkMaxDuration = var_793_5

					if var_793_5 + var_793_1 > arg_790_1.duration_ then
						arg_790_1.duration_ = var_793_5 + var_793_1
					end
				end

				arg_790_1.text_.text = var_793_3
				arg_790_1.typewritter.percent = 0

				arg_790_1.typewritter:SetDirty()
				arg_790_1:ShowNextGo(false)
				arg_790_1:RecordContent(arg_790_1.text_.text)
			end

			local var_793_6 = math.max(var_793_2, arg_790_1.talkMaxDuration)

			if var_793_1 <= arg_790_1.time_ and arg_790_1.time_ < var_793_1 + var_793_6 then
				arg_790_1.typewritter.percent = (arg_790_1.time_ - var_793_1) / var_793_6

				arg_790_1.typewritter:SetDirty()
			end

			if arg_790_1.time_ >= var_793_1 + var_793_6 and arg_790_1.time_ < var_793_1 + var_793_6 + arg_793_0 then
				arg_790_1.typewritter.percent = 1

				arg_790_1.typewritter:SetDirty()
				arg_790_1:ShowNextGo(true)
			end
		end

		arg_790_1.nodeConfigList_ = {}

		arg_790_1:InitPlayNodeList()
	end,
	Play1109402192 = function(arg_794_0, arg_794_1)
		arg_794_1.time_ = 0
		arg_794_1.frameCnt_ = 0
		arg_794_1.state_ = "playing"
		arg_794_1.curTalkId_ = 1109402192
		arg_794_1.duration_ = 3.43

		local var_794_0 = {
			ja = 3.333,
			ko = 3.433,
			zh = 3.433
		}
		local var_794_1 = manager.audio:GetLocalizationFlag()

		if var_794_0[var_794_1] ~= nil then
			arg_794_1.duration_ = var_794_0[var_794_1]
		end

		SetActive(arg_794_1.tipsGo_, false)

		function arg_794_1.onSingleLineFinish_()
			arg_794_1.onSingleLineUpdate_ = nil
			arg_794_1.onSingleLineFinish_ = nil
			arg_794_1.state_ = "waiting"
		end

		function arg_794_1.playNext_(arg_796_0)
			if arg_796_0 == 1 then
				arg_794_0:Play1109402193(arg_794_1)
			end
		end

		function arg_794_1.onSingleLineUpdate_(arg_797_0)
			if 0 < arg_794_1.time_ and arg_794_1.time_ <= 0 + arg_797_0 then
				arg_794_1.var_.moveOldPos1094ui_story = arg_794_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_797_0 = 0.001

			if 0 <= arg_794_1.time_ and arg_794_1.time_ < 0 + var_797_0 then
				arg_794_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_794_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_794_1.time_ - 0) / var_797_0)
				arg_794_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_794_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_794_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_794_1.actors_["1094ui_story"].transform.position).z)
				arg_794_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_794_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_794_1.actors_["1094ui_story"].transform.localEulerAngles = arg_794_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_794_1.time_ >= 0 + var_797_0 and arg_794_1.time_ < 0 + var_797_0 + arg_797_0 then
				arg_794_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_794_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_794_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_794_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_794_1.actors_["1094ui_story"].transform.position).z)
				arg_794_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_794_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_794_1.actors_["1094ui_story"].transform.localEulerAngles = arg_794_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_797_1 = arg_794_1.actors_["1094ui_story"]

			if 0 < arg_794_1.time_ and arg_794_1.time_ <= 0 + arg_797_0 and not isNil(var_797_1) and arg_794_1.var_.characterEffect1094ui_story == nil then
				arg_794_1.var_.characterEffect1094ui_story = var_797_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_797_2 = 0.200000002980232

			if 0 <= arg_794_1.time_ and arg_794_1.time_ < 0 + var_797_2 and not isNil(var_797_1) then
				if arg_794_1.var_.characterEffect1094ui_story and not isNil(var_797_1) then
					arg_794_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_794_1.time_ >= 0 + var_797_2 and arg_794_1.time_ < 0 + var_797_2 + arg_797_0 and not isNil(var_797_1) and arg_794_1.var_.characterEffect1094ui_story then
				arg_794_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_794_1.time_ and arg_794_1.time_ <= 0 + arg_797_0 then
				arg_794_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_794_1.time_ and arg_794_1.time_ <= 0 + arg_797_0 then
				arg_794_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_797_4 = 0
			local var_797_5 = 0.225

			if 0 < arg_794_1.time_ and arg_794_1.time_ <= var_797_4 + arg_797_0 then
				arg_794_1.talkMaxDuration = 0
				arg_794_1.dialogCg_.alpha = 1

				arg_794_1.dialog_:SetActive(true)
				SetActive(arg_794_1.leftNameGo_, true)

				arg_794_1.leftNameTxt_.text = arg_794_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_794_1.leftNameTxt_.transform)

				arg_794_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_794_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_794_1:RecordName(arg_794_1.leftNameTxt_.text)
				SetActive(arg_794_1.iconTrs_.gameObject, false)
				arg_794_1.callingController_:SetSelectedState("normal")

				local var_797_6 = arg_794_1:GetWordFromCfg(1109402192)
				local var_797_7 = arg_794_1:FormatText(var_797_6.content)

				arg_794_1.text_.text = var_797_7

				LuaForUtil.ClearLinePrefixSymbol(arg_794_1.text_)

				local var_797_9 = 9 <= 0 and var_797_5 or var_797_5 * (utf8.len(var_797_7) / 9)

				if (9 <= 0 and var_797_5 or var_797_5 * (utf8.len(var_797_7) / 9)) > 0 and var_797_5 < var_797_9 then
					arg_794_1.talkMaxDuration = var_797_9

					if var_797_9 + var_797_4 > arg_794_1.duration_ then
						arg_794_1.duration_ = var_797_9 + var_797_4
					end
				end

				arg_794_1.text_.text = var_797_7
				arg_794_1.typewritter.percent = 0

				arg_794_1.typewritter:SetDirty()
				arg_794_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402192", "story_v_side_new_1109402.awb") ~= 0 then
					local var_797_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402192", "story_v_side_new_1109402.awb") / 1000

					if var_797_10 + var_797_4 > arg_794_1.duration_ then
						arg_794_1.duration_ = var_797_10 + var_797_4
					end

					if var_797_6.prefab_name ~= "" and arg_794_1.actors_[var_797_6.prefab_name] ~= nil then
						local var_797_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_794_1.actors_[var_797_6.prefab_name].transform, "story_v_side_new_1109402", "1109402192", "story_v_side_new_1109402.awb")

						arg_794_1:RecordAudio("1109402192", var_797_11)
						arg_794_1:RecordAudio("1109402192", var_797_11)
					else
						arg_794_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402192", "story_v_side_new_1109402.awb")
					end

					arg_794_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402192", "story_v_side_new_1109402.awb")
				end

				arg_794_1:RecordContent(arg_794_1.text_.text)
			end

			local var_797_12 = math.max(var_797_5, arg_794_1.talkMaxDuration)

			if var_797_4 <= arg_794_1.time_ and arg_794_1.time_ < var_797_4 + var_797_12 then
				arg_794_1.typewritter.percent = (arg_794_1.time_ - var_797_4) / var_797_12

				arg_794_1.typewritter:SetDirty()
			end

			if arg_794_1.time_ >= var_797_4 + var_797_12 and arg_794_1.time_ < var_797_4 + var_797_12 + arg_797_0 then
				arg_794_1.typewritter.percent = 1

				arg_794_1.typewritter:SetDirty()
				arg_794_1:ShowNextGo(true)
			end
		end

		arg_794_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_794_1:InitPlayNodeList()
	end,
	Play1109402193 = function(arg_798_0, arg_798_1)
		arg_798_1.time_ = 0
		arg_798_1.frameCnt_ = 0
		arg_798_1.state_ = "playing"
		arg_798_1.curTalkId_ = 1109402193
		arg_798_1.duration_ = 5

		SetActive(arg_798_1.tipsGo_, false)

		function arg_798_1.onSingleLineFinish_()
			arg_798_1.onSingleLineUpdate_ = nil
			arg_798_1.onSingleLineFinish_ = nil
			arg_798_1.state_ = "waiting"
		end

		function arg_798_1.playNext_(arg_800_0)
			if arg_800_0 == 1 then
				arg_798_0:Play1109402194(arg_798_1)
			end
		end

		function arg_798_1.onSingleLineUpdate_(arg_801_0)
			if 0 < arg_798_1.time_ and arg_798_1.time_ <= 0 + arg_801_0 and not isNil(arg_798_1.actors_["1094ui_story"]) and arg_798_1.var_.characterEffect1094ui_story == nil then
				arg_798_1.var_.characterEffect1094ui_story = arg_798_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_801_0 = 0.200000002980232

			if 0 <= arg_798_1.time_ and arg_798_1.time_ < 0 + var_801_0 and not isNil(arg_798_1.actors_["1094ui_story"]) then
				if arg_798_1.var_.characterEffect1094ui_story and not isNil(arg_798_1.actors_["1094ui_story"]) then
					arg_798_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_798_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_798_1.time_ - 0) / var_801_0)
				end
			end

			if arg_798_1.time_ >= 0 + var_801_0 and arg_798_1.time_ < 0 + var_801_0 + arg_801_0 and not isNil(arg_798_1.actors_["1094ui_story"]) and arg_798_1.var_.characterEffect1094ui_story then
				arg_798_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_798_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_801_1 = 0
			local var_801_2 = 0.975

			if 0 < arg_798_1.time_ and arg_798_1.time_ <= var_801_1 + arg_801_0 then
				arg_798_1.talkMaxDuration = 0
				arg_798_1.dialogCg_.alpha = 1

				arg_798_1.dialog_:SetActive(true)
				SetActive(arg_798_1.leftNameGo_, true)

				arg_798_1.leftNameTxt_.text = arg_798_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_798_1.leftNameTxt_.transform)

				arg_798_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_798_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_798_1:RecordName(arg_798_1.leftNameTxt_.text)
				SetActive(arg_798_1.iconTrs_.gameObject, true)
				arg_798_1.iconController_:SetSelectedState("hero")

				arg_798_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_798_1.callingController_:SetSelectedState("normal")

				arg_798_1.keyicon_.color = Color.New(1, 1, 1)
				arg_798_1.icon_.color = Color.New(1, 1, 1)

				local var_801_3 = arg_798_1:FormatText(arg_798_1:GetWordFromCfg(1109402193).content)

				arg_798_1.text_.text = var_801_3

				LuaForUtil.ClearLinePrefixSymbol(arg_798_1.text_)

				local var_801_5 = 39 <= 0 and var_801_2 or var_801_2 * (utf8.len(var_801_3) / 39)

				if (39 <= 0 and var_801_2 or var_801_2 * (utf8.len(var_801_3) / 39)) > 0 and var_801_2 < var_801_5 then
					arg_798_1.talkMaxDuration = var_801_5

					if var_801_5 + var_801_1 > arg_798_1.duration_ then
						arg_798_1.duration_ = var_801_5 + var_801_1
					end
				end

				arg_798_1.text_.text = var_801_3
				arg_798_1.typewritter.percent = 0

				arg_798_1.typewritter:SetDirty()
				arg_798_1:ShowNextGo(false)
				arg_798_1:RecordContent(arg_798_1.text_.text)
			end

			local var_801_6 = math.max(var_801_2, arg_798_1.talkMaxDuration)

			if var_801_1 <= arg_798_1.time_ and arg_798_1.time_ < var_801_1 + var_801_6 then
				arg_798_1.typewritter.percent = (arg_798_1.time_ - var_801_1) / var_801_6

				arg_798_1.typewritter:SetDirty()
			end

			if arg_798_1.time_ >= var_801_1 + var_801_6 and arg_798_1.time_ < var_801_1 + var_801_6 + arg_801_0 then
				arg_798_1.typewritter.percent = 1

				arg_798_1.typewritter:SetDirty()
				arg_798_1:ShowNextGo(true)
			end
		end

		arg_798_1.nodeConfigList_ = {}

		arg_798_1:InitPlayNodeList()
	end,
	Play1109402194 = function(arg_802_0, arg_802_1)
		arg_802_1.time_ = 0
		arg_802_1.frameCnt_ = 0
		arg_802_1.state_ = "playing"
		arg_802_1.curTalkId_ = 1109402194
		arg_802_1.duration_ = 4.3

		local var_802_0 = {
			ja = 1.999999999999,
			ko = 4.3,
			zh = 4.3
		}
		local var_802_1 = manager.audio:GetLocalizationFlag()

		if var_802_0[var_802_1] ~= nil then
			arg_802_1.duration_ = var_802_0[var_802_1]
		end

		SetActive(arg_802_1.tipsGo_, false)

		function arg_802_1.onSingleLineFinish_()
			arg_802_1.onSingleLineUpdate_ = nil
			arg_802_1.onSingleLineFinish_ = nil
			arg_802_1.state_ = "waiting"
			arg_802_1.auto_ = false
		end

		function arg_802_1.playNext_(arg_804_0)
			arg_802_1.onStoryFinished_()
		end

		function arg_802_1.onSingleLineUpdate_(arg_805_0)
			if 0 < arg_802_1.time_ and arg_802_1.time_ <= 0 + arg_805_0 then
				arg_802_1.var_.moveOldPos1094ui_story = arg_802_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_805_0 = 0.001

			if 0 <= arg_802_1.time_ and arg_802_1.time_ < 0 + var_805_0 then
				arg_802_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_802_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_802_1.time_ - 0) / var_805_0)
				arg_802_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_802_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_802_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_802_1.actors_["1094ui_story"].transform.position).z)
				arg_802_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_802_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_802_1.actors_["1094ui_story"].transform.localEulerAngles = arg_802_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_802_1.time_ >= 0 + var_805_0 and arg_802_1.time_ < 0 + var_805_0 + arg_805_0 then
				arg_802_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_802_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_802_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_802_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_802_1.actors_["1094ui_story"].transform.position).z)
				arg_802_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_802_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_802_1.actors_["1094ui_story"].transform.localEulerAngles = arg_802_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_805_1 = arg_802_1.actors_["1094ui_story"]

			if 0 < arg_802_1.time_ and arg_802_1.time_ <= 0 + arg_805_0 and not isNil(var_805_1) and arg_802_1.var_.characterEffect1094ui_story == nil then
				arg_802_1.var_.characterEffect1094ui_story = var_805_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_805_2 = 0.200000002980232

			if 0 <= arg_802_1.time_ and arg_802_1.time_ < 0 + var_805_2 and not isNil(var_805_1) then
				if arg_802_1.var_.characterEffect1094ui_story and not isNil(var_805_1) then
					arg_802_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_802_1.time_ >= 0 + var_805_2 and arg_802_1.time_ < 0 + var_805_2 + arg_805_0 and not isNil(var_805_1) and arg_802_1.var_.characterEffect1094ui_story then
				arg_802_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_802_1.time_ and arg_802_1.time_ <= 0 + arg_805_0 then
				arg_802_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_802_1.time_ and arg_802_1.time_ <= 0 + arg_805_0 then
				arg_802_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_805_4 = 0
			local var_805_5 = 0.275

			if 0 < arg_802_1.time_ and arg_802_1.time_ <= var_805_4 + arg_805_0 then
				arg_802_1.talkMaxDuration = 0
				arg_802_1.dialogCg_.alpha = 1

				arg_802_1.dialog_:SetActive(true)
				SetActive(arg_802_1.leftNameGo_, true)

				arg_802_1.leftNameTxt_.text = arg_802_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_802_1.leftNameTxt_.transform)

				arg_802_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_802_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_802_1:RecordName(arg_802_1.leftNameTxt_.text)
				SetActive(arg_802_1.iconTrs_.gameObject, false)
				arg_802_1.callingController_:SetSelectedState("normal")

				local var_805_6 = arg_802_1:GetWordFromCfg(1109402194)
				local var_805_7 = arg_802_1:FormatText(var_805_6.content)

				arg_802_1.text_.text = var_805_7

				LuaForUtil.ClearLinePrefixSymbol(arg_802_1.text_)

				local var_805_9 = 11 <= 0 and var_805_5 or var_805_5 * (utf8.len(var_805_7) / 11)

				if (11 <= 0 and var_805_5 or var_805_5 * (utf8.len(var_805_7) / 11)) > 0 and var_805_5 < var_805_9 then
					arg_802_1.talkMaxDuration = var_805_9

					if var_805_9 + var_805_4 > arg_802_1.duration_ then
						arg_802_1.duration_ = var_805_9 + var_805_4
					end
				end

				arg_802_1.text_.text = var_805_7
				arg_802_1.typewritter.percent = 0

				arg_802_1.typewritter:SetDirty()
				arg_802_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402194", "story_v_side_new_1109402.awb") ~= 0 then
					local var_805_10 = manager.audio:GetVoiceLength("story_v_side_new_1109402", "1109402194", "story_v_side_new_1109402.awb") / 1000

					if var_805_10 + var_805_4 > arg_802_1.duration_ then
						arg_802_1.duration_ = var_805_10 + var_805_4
					end

					if var_805_6.prefab_name ~= "" and arg_802_1.actors_[var_805_6.prefab_name] ~= nil then
						local var_805_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_802_1.actors_[var_805_6.prefab_name].transform, "story_v_side_new_1109402", "1109402194", "story_v_side_new_1109402.awb")

						arg_802_1:RecordAudio("1109402194", var_805_11)
						arg_802_1:RecordAudio("1109402194", var_805_11)
					else
						arg_802_1:AudioAction("play", "voice", "story_v_side_new_1109402", "1109402194", "story_v_side_new_1109402.awb")
					end

					arg_802_1:RecordHistoryTalkVoice("story_v_side_new_1109402", "1109402194", "story_v_side_new_1109402.awb")
				end

				arg_802_1:RecordContent(arg_802_1.text_.text)
			end

			local var_805_12 = math.max(var_805_5, arg_802_1.talkMaxDuration)

			if var_805_4 <= arg_802_1.time_ and arg_802_1.time_ < var_805_4 + var_805_12 then
				arg_802_1.typewritter.percent = (arg_802_1.time_ - var_805_4) / var_805_12

				arg_802_1.typewritter:SetDirty()
			end

			if arg_802_1.time_ >= var_805_4 + var_805_12 and arg_802_1.time_ < var_805_4 + var_805_12 + arg_805_0 then
				arg_802_1.typewritter.percent = 1

				arg_802_1.typewritter:SetDirty()
				arg_802_1:ShowNextGo(true)
			end
		end

		arg_802_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_802_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/I05d",
		"TextureConfig/Background/D06_1",
		"TextureConfig/Background/ST17",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST03a",
		"TextureConfig/Background/I05a"
	},
	voices = {
		"story_v_side_new_1109402.awb"
	}
}
