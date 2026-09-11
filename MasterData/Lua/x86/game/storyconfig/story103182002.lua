return {
	Play318202001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318202001
		arg_1_1.duration_ = 5.6

		local var_1_0 = {
			zh = 4.833,
			ja = 5.6
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
				arg_1_0:Play318202002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K07f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K07f")
				var_4_0.name = "K07f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K07f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K07f

				arg_1_1.bgs_.K07f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K07f" then
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_4_story_wall", "bgm_activity_2_4_story_wall", "bgm_activity_2_4_story_wall.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_4_story_wall", "bgm_activity_2_4_story_wall")

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
			local var_4_15 = 0.375

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:GetWordFromCfg(318202001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 15 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 15)

				if (15 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 15)) > 0 and var_4_15 < var_4_20 then
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

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202001", "story_v_out_318202.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_318202", "318202001", "story_v_out_318202.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_318202", "318202001", "story_v_out_318202.awb")

						arg_1_1:RecordAudio("318202001", var_4_22)
						arg_1_1:RecordAudio("318202001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_318202", "318202001", "story_v_out_318202.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_318202", "318202001", "story_v_out_318202.awb")
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
	Play318202002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318202002
		arg_9_1.duration_ = 3.07

		local var_9_0 = {
			zh = 3.066,
			ja = 1.833
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
				arg_9_0:Play318202003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.25

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[655].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_c")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(318202002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 10 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 10)

				if (10 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 10)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202002", "story_v_out_318202.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202002", "story_v_out_318202.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_318202", "318202002", "story_v_out_318202.awb")

						arg_9_1:RecordAudio("318202002", var_12_6)
						arg_9_1:RecordAudio("318202002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_318202", "318202002", "story_v_out_318202.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_318202", "318202002", "story_v_out_318202.awb")
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
	Play318202003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318202003
		arg_13_1.duration_ = 4.7

		local var_13_0 = {
			zh = 3.9,
			ja = 4.7
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
				arg_13_0:Play318202004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_16_0 = 0.6

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				local var_16_1, var_16_2 = math.modf((arg_13_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_16_2 * 0.13, var_16_2 * 0.13, var_16_2 * 0.13) + arg_13_1.var_.shakeOldPos
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				manager.ui.mainCamera.transform.localPosition = arg_13_1.var_.shakeOldPos
			end

			local var_16_3 = 0

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			if arg_13_1.time_ >= var_16_3 + 0.6 and arg_13_1.time_ < var_16_3 + 0.6 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			local var_16_4 = 0
			local var_16_5 = 0.575

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_6 = arg_13_1:GetWordFromCfg(318202003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 23 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 23)

				if (23 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 23)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202003", "story_v_out_318202.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_318202", "318202003", "story_v_out_318202.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_318202", "318202003", "story_v_out_318202.awb")

						arg_13_1:RecordAudio("318202003", var_16_11)
						arg_13_1:RecordAudio("318202003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_318202", "318202003", "story_v_out_318202.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_318202", "318202003", "story_v_out_318202.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play318202004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318202004
		arg_17_1.duration_ = 2.37

		local var_17_0 = {
			zh = 2.033,
			ja = 2.366
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
				arg_17_0:Play318202005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.125

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[655].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_c")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(318202004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 5 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 5)

				if (5 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 5)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202004", "story_v_out_318202.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202004", "story_v_out_318202.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_318202", "318202004", "story_v_out_318202.awb")

						arg_17_1:RecordAudio("318202004", var_20_6)
						arg_17_1:RecordAudio("318202004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_318202", "318202004", "story_v_out_318202.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_318202", "318202004", "story_v_out_318202.awb")
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
	Play318202005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318202005
		arg_21_1.duration_ = 9.1

		local var_21_0 = {
			zh = 5.1,
			ja = 9.1
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
				arg_21_0:Play318202006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.625

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(318202005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 25 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 25)

				if (25 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 25)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202005", "story_v_out_318202.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202005", "story_v_out_318202.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_318202", "318202005", "story_v_out_318202.awb")

						arg_21_1:RecordAudio("318202005", var_24_6)
						arg_21_1:RecordAudio("318202005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_318202", "318202005", "story_v_out_318202.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_318202", "318202005", "story_v_out_318202.awb")
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
	Play318202006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 318202006
		arg_25_1.duration_ = 4.07

		local var_25_0 = {
			zh = 2.433,
			ja = 4.066
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
				arg_25_0:Play318202007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.225

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[655].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_c")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(318202006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 9 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 9)

				if (9 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 9)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202006", "story_v_out_318202.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202006", "story_v_out_318202.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_318202", "318202006", "story_v_out_318202.awb")

						arg_25_1:RecordAudio("318202006", var_28_6)
						arg_25_1:RecordAudio("318202006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_318202", "318202006", "story_v_out_318202.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_318202", "318202006", "story_v_out_318202.awb")
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
	Play318202007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 318202007
		arg_29_1.duration_ = 2.2

		local var_29_0 = {
			zh = 1.5,
			ja = 2.2
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
				arg_29_0:Play318202008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.1

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(318202007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 4 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 4)

				if (4 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 4)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202007", "story_v_out_318202.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202007", "story_v_out_318202.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_318202", "318202007", "story_v_out_318202.awb")

						arg_29_1:RecordAudio("318202007", var_32_6)
						arg_29_1:RecordAudio("318202007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_318202", "318202007", "story_v_out_318202.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_318202", "318202007", "story_v_out_318202.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play318202008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 318202008
		arg_33_1.duration_ = 2.03

		local var_33_0 = {
			zh = 2.033,
			ja = 1.566
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
				arg_33_0:Play318202009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.2

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[655].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10056_c")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(318202008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 8 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 8)

				if (8 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 8)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202008", "story_v_out_318202.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202008", "story_v_out_318202.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_318202", "318202008", "story_v_out_318202.awb")

						arg_33_1:RecordAudio("318202008", var_36_6)
						arg_33_1:RecordAudio("318202008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_318202", "318202008", "story_v_out_318202.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_318202", "318202008", "story_v_out_318202.awb")
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
	Play318202009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 318202009
		arg_37_1.duration_ = 3.2

		local var_37_0 = {
			zh = 3.2,
			ja = 3.1
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
				arg_37_0:Play318202010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.175

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(318202009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 7 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 7)

				if (7 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 7)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202009", "story_v_out_318202.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202009", "story_v_out_318202.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_318202", "318202009", "story_v_out_318202.awb")

						arg_37_1:RecordAudio("318202009", var_40_6)
						arg_37_1:RecordAudio("318202009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_318202", "318202009", "story_v_out_318202.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_318202", "318202009", "story_v_out_318202.awb")
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
	Play318202010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 318202010
		arg_41_1.duration_ = 10.97

		local var_41_0 = {
			zh = 10.833,
			ja = 10.966
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
				arg_41_0:Play318202011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 1.275

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(318202010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 51 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 51)

				if (51 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 51)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202010", "story_v_out_318202.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202010", "story_v_out_318202.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_318202", "318202010", "story_v_out_318202.awb")

						arg_41_1:RecordAudio("318202010", var_44_6)
						arg_41_1:RecordAudio("318202010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_318202", "318202010", "story_v_out_318202.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_318202", "318202010", "story_v_out_318202.awb")
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
	Play318202011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 318202011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play318202012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.025

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(318202011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 41 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 41)

				if (41 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 41)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play318202012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 318202012
		arg_49_1.duration_ = 4.97

		local var_49_0 = {
			zh = 3.7,
			ja = 4.966
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
				arg_49_0:Play318202013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.375

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[495].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(318202012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 15 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 15)

				if (15 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 15)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202012", "story_v_out_318202.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202012", "story_v_out_318202.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_318202", "318202012", "story_v_out_318202.awb")

						arg_49_1:RecordAudio("318202012", var_52_6)
						arg_49_1:RecordAudio("318202012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_318202", "318202012", "story_v_out_318202.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_318202", "318202012", "story_v_out_318202.awb")
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
	Play318202013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 318202013
		arg_53_1.duration_ = 6.6

		local var_53_0 = {
			zh = 5.433,
			ja = 6.6
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
				arg_53_0:Play318202014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.6

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(318202013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 24 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 24)

				if (24 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 24)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202013", "story_v_out_318202.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202013", "story_v_out_318202.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_318202", "318202013", "story_v_out_318202.awb")

						arg_53_1:RecordAudio("318202013", var_56_6)
						arg_53_1:RecordAudio("318202013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_318202", "318202013", "story_v_out_318202.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_318202", "318202013", "story_v_out_318202.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play318202014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 318202014
		arg_57_1.duration_ = 10.13

		local var_57_0 = {
			zh = 5.866,
			ja = 10.133
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
				arg_57_0:Play318202015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.525

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(318202014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 21 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 21)

				if (21 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 21)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202014", "story_v_out_318202.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202014", "story_v_out_318202.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_318202", "318202014", "story_v_out_318202.awb")

						arg_57_1:RecordAudio("318202014", var_60_6)
						arg_57_1:RecordAudio("318202014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_318202", "318202014", "story_v_out_318202.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_318202", "318202014", "story_v_out_318202.awb")
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
	Play318202015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 318202015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play318202016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.075

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(318202015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 43 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 43)

				if (43 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 43)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play318202016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 318202016
		arg_65_1.duration_ = 2.83

		local var_65_0 = {
			zh = 2.766,
			ja = 2.833
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
				arg_65_0:Play318202017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.25

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(318202016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 10 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 10)

				if (10 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 10)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202016", "story_v_out_318202.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202016", "story_v_out_318202.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_318202", "318202016", "story_v_out_318202.awb")

						arg_65_1:RecordAudio("318202016", var_68_6)
						arg_65_1:RecordAudio("318202016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_318202", "318202016", "story_v_out_318202.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_318202", "318202016", "story_v_out_318202.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play318202017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 318202017
		arg_69_1.duration_ = 9

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play318202018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.bgs_.K05f == nil then
				local var_72_0 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K05f")
				var_72_0.name = "K05f"
				var_72_0.transform.parent = arg_69_1.stage_.transform
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_.K05f = var_72_0
			end

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= 2 + arg_72_0 then
				local var_72_1 = arg_69_1.bgs_.K05f

				arg_69_1.bgs_.K05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_2 = var_72_1:GetComponent("SpriteRenderer")

				if var_72_2 and var_72_2.sprite then
					local var_72_3 = 2 * (var_72_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_1.transform.localScale = Vector3.New(var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "K05f" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_4 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_5 = 2

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_5 then
				local var_72_6 = Color.New(0, 0, 0)

				var_72_6.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - var_72_4) / var_72_5)
				arg_69_1.mask_.color = var_72_6
			end

			if arg_69_1.time_ >= var_72_4 + var_72_5 and arg_69_1.time_ < var_72_4 + var_72_5 + arg_72_0 then
				local var_72_7 = Color.New(0, 0, 0)

				var_72_7.a = 1
				arg_69_1.mask_.color = var_72_7
			end

			local var_72_8 = 2

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_9 = 2

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 then
				local var_72_10 = Color.New(0, 0, 0)

				var_72_10.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_8) / var_72_9)
				arg_69_1.mask_.color = var_72_10
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 then
				local var_72_11 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_11.a = 0
				arg_69_1.mask_.color = var_72_11
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_12 = 4
			local var_72_13 = 1.9

			if 4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_14 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_14:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_15 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(318202017).content)

				arg_69_1.text_.text = var_72_15

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 76 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 76)

				if (76 <= 0 and var_72_13 or var_72_13 * (utf8.len(var_72_15) / 76)) > 0 and var_72_13 < var_72_17 then
					arg_69_1.talkMaxDuration = var_72_17
					var_72_12 = var_72_12 + 0.3

					if var_72_17 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_17 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_15
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_18 = var_72_12 + 0.3
			local var_72_19 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_18 + var_72_19 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_18) / var_72_19

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_18 + var_72_19 and arg_69_1.time_ < var_72_18 + var_72_19 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play318202018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 318202018
		arg_75_1.duration_ = 4.3

		local var_75_0 = {
			zh = 4,
			ja = 4.3
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
				arg_75_0:Play318202019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if arg_75_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_78_0 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_75_1.stage_.transform)

				var_78_0.name = "1058ui_story"
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["1058ui_story"] = var_78_0

				local var_78_1 = var_78_0:GetComponentInChildren(typeof(CharacterEffect))

				var_78_1.enabled = true

				local var_78_2 = GameObjectTools.GetOrAddComponent(var_78_0, typeof(DynamicBoneHelper))

				if var_78_2 then
					var_78_2:EnableDynamicBone(false)
				end

				arg_75_1:ShowWeapon(var_78_1.transform, false)

				arg_75_1.var_["1058ui_story" .. "Animator"] = var_78_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_75_1.var_["1058ui_story" .. "Animator"].applyRootMotion = true
				arg_75_1.var_["1058ui_story" .. "LipSync"] = var_78_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_78_3 = arg_75_1.actors_["1058ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1058ui_story = var_78_3.localPosition
			end

			local var_78_4 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				var_78_3.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_75_1.time_ - 0) / var_78_4)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				var_78_3.localPosition = Vector3.New(0, -0.95, -5.88)
				var_78_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_3.position).x, (manager.ui.mainCamera.transform.position - var_78_3.position).y, (manager.ui.mainCamera.transform.position - var_78_3.position).z)
				var_78_3.localEulerAngles.z = 0
				var_78_3.localEulerAngles.x = 0
				var_78_3.localEulerAngles = var_78_3.localEulerAngles
			end

			local var_78_5 = arg_75_1.actors_["1058ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect1058ui_story == nil then
				arg_75_1.var_.characterEffect1058ui_story = var_78_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_6 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_6 and not isNil(var_78_5) then
				if arg_75_1.var_.characterEffect1058ui_story and not isNil(var_78_5) then
					arg_75_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_6 and arg_75_1.time_ < 0 + var_78_6 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect1058ui_story then
				arg_75_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_78_8 = 0
			local var_78_9 = 0.475

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_10 = arg_75_1:GetWordFromCfg(318202018)
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

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202018", "story_v_out_318202.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202018", "story_v_out_318202.awb") / 1000

					if var_78_14 + var_78_8 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_8
					end

					if var_78_10.prefab_name ~= "" and arg_75_1.actors_[var_78_10.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_10.prefab_name].transform, "story_v_out_318202", "318202018", "story_v_out_318202.awb")

						arg_75_1:RecordAudio("318202018", var_78_15)
						arg_75_1:RecordAudio("318202018", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_318202", "318202018", "story_v_out_318202.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_318202", "318202018", "story_v_out_318202.awb")
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
				actorName = "1058ui_story",
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
	Play318202019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 318202019
		arg_79_1.duration_ = 3.5

		local var_79_0 = {
			zh = 3.5,
			ja = 3.033
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
				arg_79_0:Play318202020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1058ui_story = arg_79_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1058ui_story"].transform.position).z)
				arg_79_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1058ui_story"].transform.localEulerAngles = arg_79_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_79_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1058ui_story"].transform.position).z)
				arg_79_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1058ui_story"].transform.localEulerAngles = arg_79_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1058ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1058ui_story == nil then
				arg_79_1.var_.characterEffect1058ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1058ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1058ui_story then
				arg_79_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_82_4 = 0
			local var_82_5 = 0.575

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(318202019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 23 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 23)

				if (23 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 23)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202019", "story_v_out_318202.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_318202", "318202019", "story_v_out_318202.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_318202", "318202019", "story_v_out_318202.awb")

						arg_79_1:RecordAudio("318202019", var_82_11)
						arg_79_1:RecordAudio("318202019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_318202", "318202019", "story_v_out_318202.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_318202", "318202019", "story_v_out_318202.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play318202020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 318202020
		arg_83_1.duration_ = 4.3

		local var_83_0 = {
			zh = 3.2,
			ja = 4.3
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
				arg_83_0:Play318202021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1058ui_story"]) and arg_83_1.var_.characterEffect1058ui_story == nil then
				arg_83_1.var_.characterEffect1058ui_story = arg_83_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1058ui_story"]) then
				if arg_83_1.var_.characterEffect1058ui_story and not isNil(arg_83_1.actors_["1058ui_story"]) then
					arg_83_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1058ui_story"]) and arg_83_1.var_.characterEffect1058ui_story then
				arg_83_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.45

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[523].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2095")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(318202020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 18 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 18)

				if (18 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 18)) > 0 and var_86_2 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202020", "story_v_out_318202.awb") ~= 0 then
					local var_86_7 = manager.audio:GetVoiceLength("story_v_out_318202", "318202020", "story_v_out_318202.awb") / 1000

					if var_86_7 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_1
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_318202", "318202020", "story_v_out_318202.awb")

						arg_83_1:RecordAudio("318202020", var_86_8)
						arg_83_1:RecordAudio("318202020", var_86_8)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_318202", "318202020", "story_v_out_318202.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_318202", "318202020", "story_v_out_318202.awb")
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
	Play318202021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 318202021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play318202022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_fall", "")
			end

			local var_90_1 = 0
			local var_90_2 = 1.125

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(318202021).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 45 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 45)

				if (45 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 45)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play318202022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 318202022
		arg_91_1.duration_ = 9.5

		local var_91_0 = {
			zh = 9.5,
			ja = 6.033
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
				arg_91_0:Play318202023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if arg_91_1.actors_["10053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10053ui_story"))) then
				local var_94_0 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_91_1.stage_.transform)

				var_94_0.name = "10053ui_story"
				var_94_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_91_1.actors_["10053ui_story"] = var_94_0

				local var_94_1 = var_94_0:GetComponentInChildren(typeof(CharacterEffect))

				var_94_1.enabled = true

				local var_94_2 = GameObjectTools.GetOrAddComponent(var_94_0, typeof(DynamicBoneHelper))

				if var_94_2 then
					var_94_2:EnableDynamicBone(false)
				end

				arg_91_1:ShowWeapon(var_94_1.transform, false)

				arg_91_1.var_["10053ui_story" .. "Animator"] = var_94_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_91_1.var_["10053ui_story" .. "Animator"].applyRootMotion = true
				arg_91_1.var_["10053ui_story" .. "LipSync"] = var_94_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_94_3 = arg_91_1.actors_["10053ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10053ui_story = var_94_3.localPosition
			end

			local var_94_4 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				var_94_3.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_91_1.time_ - 0) / var_94_4)
				var_94_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_3.position).x, (manager.ui.mainCamera.transform.position - var_94_3.position).y, (manager.ui.mainCamera.transform.position - var_94_3.position).z)
				var_94_3.localEulerAngles.z = 0
				var_94_3.localEulerAngles.x = 0
				var_94_3.localEulerAngles = var_94_3.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				var_94_3.localPosition = Vector3.New(0.7, -1.12, -5.99)
				var_94_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_3.position).x, (manager.ui.mainCamera.transform.position - var_94_3.position).y, (manager.ui.mainCamera.transform.position - var_94_3.position).z)
				var_94_3.localEulerAngles.z = 0
				var_94_3.localEulerAngles.x = 0
				var_94_3.localEulerAngles = var_94_3.localEulerAngles
			end

			local var_94_5 = arg_91_1.actors_["10053ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.characterEffect10053ui_story == nil then
				arg_91_1.var_.characterEffect10053ui_story = var_94_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_6 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_6 and not isNil(var_94_5) then
				if arg_91_1.var_.characterEffect10053ui_story and not isNil(var_94_5) then
					arg_91_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_6 and arg_91_1.time_ < 0 + var_94_6 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.characterEffect10053ui_story then
				arg_91_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_94_8 = arg_91_1.actors_["1058ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1058ui_story = var_94_8.localPosition
			end

			local var_94_9 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_9 then
				var_94_8.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1058ui_story, Vector3.New(-0.7, -0.95, -5.88), (arg_91_1.time_ - 0) / var_94_9)
				var_94_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_8.position).x, (manager.ui.mainCamera.transform.position - var_94_8.position).y, (manager.ui.mainCamera.transform.position - var_94_8.position).z)
				var_94_8.localEulerAngles.z = 0
				var_94_8.localEulerAngles.x = 0
				var_94_8.localEulerAngles = var_94_8.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_9 and arg_91_1.time_ < 0 + var_94_9 + arg_94_0 then
				var_94_8.localPosition = Vector3.New(-0.7, -0.95, -5.88)
				var_94_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_8.position).x, (manager.ui.mainCamera.transform.position - var_94_8.position).y, (manager.ui.mainCamera.transform.position - var_94_8.position).z)
				var_94_8.localEulerAngles.z = 0
				var_94_8.localEulerAngles.x = 0
				var_94_8.localEulerAngles = var_94_8.localEulerAngles
			end

			local var_94_10 = 0
			local var_94_11 = 0.625

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 then
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

				local var_94_12 = arg_91_1:GetWordFromCfg(318202022)
				local var_94_13 = arg_91_1:FormatText(var_94_12.content)

				arg_91_1.text_.text = var_94_13

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_15 = 25 <= 0 and var_94_11 or var_94_11 * (utf8.len(var_94_13) / 25)

				if (25 <= 0 and var_94_11 or var_94_11 * (utf8.len(var_94_13) / 25)) > 0 and var_94_11 < var_94_15 then
					arg_91_1.talkMaxDuration = var_94_15

					if var_94_15 + var_94_10 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_15 + var_94_10
					end
				end

				arg_91_1.text_.text = var_94_13
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202022", "story_v_out_318202.awb") ~= 0 then
					local var_94_16 = manager.audio:GetVoiceLength("story_v_out_318202", "318202022", "story_v_out_318202.awb") / 1000

					if var_94_16 + var_94_10 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_16 + var_94_10
					end

					if var_94_12.prefab_name ~= "" and arg_91_1.actors_[var_94_12.prefab_name] ~= nil then
						local var_94_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_12.prefab_name].transform, "story_v_out_318202", "318202022", "story_v_out_318202.awb")

						arg_91_1:RecordAudio("318202022", var_94_17)
						arg_91_1:RecordAudio("318202022", var_94_17)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_318202", "318202022", "story_v_out_318202.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_318202", "318202022", "story_v_out_318202.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_18 = math.max(var_94_11, arg_91_1.talkMaxDuration)

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_18 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_10) / var_94_18

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_10 + var_94_18 and arg_91_1.time_ < var_94_10 + var_94_18 + arg_94_0 then
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
				actorName = "1058ui_story",
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
	Play318202023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 318202023
		arg_95_1.duration_ = 3.63

		local var_95_0 = {
			zh = 2.433,
			ja = 3.633
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
				arg_95_0:Play318202024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if arg_95_1.actors_["1055ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1055ui_story"))) then
				local var_98_0 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_95_1.stage_.transform)

				var_98_0.name = "1055ui_story"
				var_98_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.actors_["1055ui_story"] = var_98_0

				local var_98_1 = var_98_0:GetComponentInChildren(typeof(CharacterEffect))

				var_98_1.enabled = true

				local var_98_2 = GameObjectTools.GetOrAddComponent(var_98_0, typeof(DynamicBoneHelper))

				if var_98_2 then
					var_98_2:EnableDynamicBone(false)
				end

				arg_95_1:ShowWeapon(var_98_1.transform, false)

				arg_95_1.var_["1055ui_story" .. "Animator"] = var_98_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_95_1.var_["1055ui_story" .. "Animator"].applyRootMotion = true
				arg_95_1.var_["1055ui_story" .. "LipSync"] = var_98_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_98_3 = arg_95_1.actors_["1055ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1055ui_story = var_98_3.localPosition
			end

			local var_98_4 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				var_98_3.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_95_1.time_ - 0) / var_98_4)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_3.localPosition = Vector3.New(0, -0.965, -6.2)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			local var_98_5 = arg_95_1.actors_["1055ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect1055ui_story == nil then
				arg_95_1.var_.characterEffect1055ui_story = var_98_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_6 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_6 and not isNil(var_98_5) then
				if arg_95_1.var_.characterEffect1055ui_story and not isNil(var_98_5) then
					arg_95_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_6 and arg_95_1.time_ < 0 + var_98_6 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect1055ui_story then
				arg_95_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_98_8 = arg_95_1.actors_["10053ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10053ui_story = var_98_8.localPosition
			end

			local var_98_9 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_9 then
				var_98_8.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_9)
				var_98_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_8.position).x, (manager.ui.mainCamera.transform.position - var_98_8.position).y, (manager.ui.mainCamera.transform.position - var_98_8.position).z)
				var_98_8.localEulerAngles.z = 0
				var_98_8.localEulerAngles.x = 0
				var_98_8.localEulerAngles = var_98_8.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_9 and arg_95_1.time_ < 0 + var_98_9 + arg_98_0 then
				var_98_8.localPosition = Vector3.New(0, 100, 0)
				var_98_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_8.position).x, (manager.ui.mainCamera.transform.position - var_98_8.position).y, (manager.ui.mainCamera.transform.position - var_98_8.position).z)
				var_98_8.localEulerAngles.z = 0
				var_98_8.localEulerAngles.x = 0
				var_98_8.localEulerAngles = var_98_8.localEulerAngles
			end

			local var_98_10 = arg_95_1.actors_["10053ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_10) and arg_95_1.var_.characterEffect10053ui_story == nil then
				arg_95_1.var_.characterEffect10053ui_story = var_98_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_11 and not isNil(var_98_10) then
				if arg_95_1.var_.characterEffect10053ui_story and not isNil(var_98_10) then
					arg_95_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_95_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_11)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_11 and arg_95_1.time_ < 0 + var_98_11 + arg_98_0 and not isNil(var_98_10) and arg_95_1.var_.characterEffect10053ui_story then
				arg_95_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_95_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_98_12 = arg_95_1.actors_["1058ui_story"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1058ui_story = var_98_12.localPosition
			end

			local var_98_13 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_13 then
				var_98_12.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_13)
				var_98_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_12.position).x, (manager.ui.mainCamera.transform.position - var_98_12.position).y, (manager.ui.mainCamera.transform.position - var_98_12.position).z)
				var_98_12.localEulerAngles.z = 0
				var_98_12.localEulerAngles.x = 0
				var_98_12.localEulerAngles = var_98_12.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_13 and arg_95_1.time_ < 0 + var_98_13 + arg_98_0 then
				var_98_12.localPosition = Vector3.New(0, 100, 0)
				var_98_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_12.position).x, (manager.ui.mainCamera.transform.position - var_98_12.position).y, (manager.ui.mainCamera.transform.position - var_98_12.position).z)
				var_98_12.localEulerAngles.z = 0
				var_98_12.localEulerAngles.x = 0
				var_98_12.localEulerAngles = var_98_12.localEulerAngles
			end

			local var_98_14 = 0
			local var_98_15 = 0.325

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_16 = arg_95_1:GetWordFromCfg(318202023)
				local var_98_17 = arg_95_1:FormatText(var_98_16.content)

				arg_95_1.text_.text = var_98_17

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_19 = 13 <= 0 and var_98_15 or var_98_15 * (utf8.len(var_98_17) / 13)

				if (13 <= 0 and var_98_15 or var_98_15 * (utf8.len(var_98_17) / 13)) > 0 and var_98_15 < var_98_19 then
					arg_95_1.talkMaxDuration = var_98_19

					if var_98_19 + var_98_14 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_19 + var_98_14
					end
				end

				arg_95_1.text_.text = var_98_17
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202023", "story_v_out_318202.awb") ~= 0 then
					local var_98_20 = manager.audio:GetVoiceLength("story_v_out_318202", "318202023", "story_v_out_318202.awb") / 1000

					if var_98_20 + var_98_14 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_20 + var_98_14
					end

					if var_98_16.prefab_name ~= "" and arg_95_1.actors_[var_98_16.prefab_name] ~= nil then
						local var_98_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_16.prefab_name].transform, "story_v_out_318202", "318202023", "story_v_out_318202.awb")

						arg_95_1:RecordAudio("318202023", var_98_21)
						arg_95_1:RecordAudio("318202023", var_98_21)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_318202", "318202023", "story_v_out_318202.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_318202", "318202023", "story_v_out_318202.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_22 = math.max(var_98_15, arg_95_1.talkMaxDuration)

			if var_98_14 <= arg_95_1.time_ and arg_95_1.time_ < var_98_14 + var_98_22 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_14) / var_98_22

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_14 + var_98_22 and arg_95_1.time_ < var_98_14 + var_98_22 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
			},
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

		arg_95_1:InitPlayNodeList()
	end,
	Play318202024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 318202024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play318202025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1055ui_story"]) and arg_99_1.var_.characterEffect1055ui_story == nil then
				arg_99_1.var_.characterEffect1055ui_story = arg_99_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1055ui_story"]) then
				if arg_99_1.var_.characterEffect1055ui_story and not isNil(arg_99_1.actors_["1055ui_story"]) then
					arg_99_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_0)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1055ui_story"]) and arg_99_1.var_.characterEffect1055ui_story then
				arg_99_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_102_1 = 0
			local var_102_2 = 0.825

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(318202024).content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 33 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 33)

				if (33 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 33)) > 0 and var_102_2 < var_102_5 then
					arg_99_1.talkMaxDuration = var_102_5

					if var_102_5 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_6 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_6 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_6

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_6 and arg_99_1.time_ < var_102_1 + var_102_6 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play318202025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 318202025
		arg_103_1.duration_ = 6.8

		local var_103_0 = {
			zh = 5.366,
			ja = 6.8
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
				arg_103_0:Play318202026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1055ui_story"]) and arg_103_1.var_.characterEffect1055ui_story == nil then
				arg_103_1.var_.characterEffect1055ui_story = arg_103_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1055ui_story"]) then
				if arg_103_1.var_.characterEffect1055ui_story and not isNil(arg_103_1.actors_["1055ui_story"]) then
					arg_103_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1055ui_story"]) and arg_103_1.var_.characterEffect1055ui_story then
				arg_103_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_106_2 = 0
			local var_106_3 = 0.55

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_4 = arg_103_1:GetWordFromCfg(318202025)
				local var_106_5 = arg_103_1:FormatText(var_106_4.content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 22 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 22)

				if (22 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 22)) > 0 and var_106_3 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202025", "story_v_out_318202.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_318202", "318202025", "story_v_out_318202.awb") / 1000

					if var_106_8 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_2
					end

					if var_106_4.prefab_name ~= "" and arg_103_1.actors_[var_106_4.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_4.prefab_name].transform, "story_v_out_318202", "318202025", "story_v_out_318202.awb")

						arg_103_1:RecordAudio("318202025", var_106_9)
						arg_103_1:RecordAudio("318202025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_318202", "318202025", "story_v_out_318202.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_318202", "318202025", "story_v_out_318202.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_3, arg_103_1.talkMaxDuration)

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_2) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_2 + var_106_10 and arg_103_1.time_ < var_106_2 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play318202026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 318202026
		arg_107_1.duration_ = 14.37

		local var_107_0 = {
			zh = 14.366,
			ja = 9.2
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
				arg_107_0:Play318202027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10053ui_story = arg_107_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10053ui_story"].transform.position).z)
				arg_107_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10053ui_story"].transform.localEulerAngles = arg_107_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, -1.12, -5.99)
				arg_107_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["10053ui_story"].transform.position).z)
				arg_107_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["10053ui_story"].transform.localEulerAngles = arg_107_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["10053ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect10053ui_story == nil then
				arg_107_1.var_.characterEffect10053ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect10053ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect10053ui_story then
				arg_107_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_110_4 = arg_107_1.actors_["1055ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1055ui_story = var_110_4.localPosition
			end

			local var_110_5 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_5 then
				var_110_4.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_107_1.time_ - 0) / var_110_5)
				var_110_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_4.position).x, (manager.ui.mainCamera.transform.position - var_110_4.position).y, (manager.ui.mainCamera.transform.position - var_110_4.position).z)
				var_110_4.localEulerAngles.z = 0
				var_110_4.localEulerAngles.x = 0
				var_110_4.localEulerAngles = var_110_4.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_5 and arg_107_1.time_ < 0 + var_110_5 + arg_110_0 then
				var_110_4.localPosition = Vector3.New(0, 100, 0)
				var_110_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_4.position).x, (manager.ui.mainCamera.transform.position - var_110_4.position).y, (manager.ui.mainCamera.transform.position - var_110_4.position).z)
				var_110_4.localEulerAngles.z = 0
				var_110_4.localEulerAngles.x = 0
				var_110_4.localEulerAngles = var_110_4.localEulerAngles
			end

			local var_110_6 = arg_107_1.actors_["1055ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect1055ui_story == nil then
				arg_107_1.var_.characterEffect1055ui_story = var_110_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_7 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 and not isNil(var_110_6) then
				if arg_107_1.var_.characterEffect1055ui_story and not isNil(var_110_6) then
					arg_107_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_7)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect1055ui_story then
				arg_107_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_110_8 = 0
			local var_110_9 = 1.05

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(318202026)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_13 = 42 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 42)

				if (42 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 42)) > 0 and var_110_9 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_8
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202026", "story_v_out_318202.awb") ~= 0 then
					local var_110_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202026", "story_v_out_318202.awb") / 1000

					if var_110_14 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_8
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_out_318202", "318202026", "story_v_out_318202.awb")

						arg_107_1:RecordAudio("318202026", var_110_15)
						arg_107_1:RecordAudio("318202026", var_110_15)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_318202", "318202026", "story_v_out_318202.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_318202", "318202026", "story_v_out_318202.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_16 = math.max(var_110_9, arg_107_1.talkMaxDuration)

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_16 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_8) / var_110_16

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_8 + var_110_16 and arg_107_1.time_ < var_110_8 + var_110_16 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
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
	Play318202027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 318202027
		arg_111_1.duration_ = 13.7

		local var_111_0 = {
			zh = 13.7,
			ja = 8.566
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play318202028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 1.15

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:GetWordFromCfg(318202027)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 46 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 46)

				if (46 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 46)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202027", "story_v_out_318202.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202027", "story_v_out_318202.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_318202", "318202027", "story_v_out_318202.awb")

						arg_111_1:RecordAudio("318202027", var_114_6)
						arg_111_1:RecordAudio("318202027", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_318202", "318202027", "story_v_out_318202.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_318202", "318202027", "story_v_out_318202.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play318202028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 318202028
		arg_115_1.duration_ = 3.8

		local var_115_0 = {
			zh = 3.8,
			ja = 3.666
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
				arg_115_0:Play318202029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_2")
			end

			local var_118_0 = 0
			local var_118_1 = 0.375

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_2 = arg_115_1:GetWordFromCfg(318202028)
				local var_118_3 = arg_115_1:FormatText(var_118_2.content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 15 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_3) / 15)

				if (15 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_3) / 15)) > 0 and var_118_1 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202028", "story_v_out_318202.awb") ~= 0 then
					local var_118_6 = manager.audio:GetVoiceLength("story_v_out_318202", "318202028", "story_v_out_318202.awb") / 1000

					if var_118_6 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_0
					end

					if var_118_2.prefab_name ~= "" and arg_115_1.actors_[var_118_2.prefab_name] ~= nil then
						local var_118_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_2.prefab_name].transform, "story_v_out_318202", "318202028", "story_v_out_318202.awb")

						arg_115_1:RecordAudio("318202028", var_118_7)
						arg_115_1:RecordAudio("318202028", var_118_7)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_318202", "318202028", "story_v_out_318202.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_318202", "318202028", "story_v_out_318202.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_8 and arg_115_1.time_ < var_118_0 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play318202029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 318202029
		arg_119_1.duration_ = 9.8

		local var_119_0 = {
			zh = 9.566,
			ja = 9.8
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
				arg_119_0:Play318202030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1055ui_story = arg_119_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1055ui_story"].transform.position).z)
				arg_119_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1055ui_story"].transform.localEulerAngles = arg_119_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_119_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1055ui_story"].transform.position).z)
				arg_119_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1055ui_story"].transform.localEulerAngles = arg_119_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1055ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1055ui_story == nil then
				arg_119_1.var_.characterEffect1055ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1055ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1055ui_story then
				arg_119_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_122_4 = arg_119_1.actors_["10053ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10053ui_story = var_122_4.localPosition
			end

			local var_122_5 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_5 then
				var_122_4.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_5)
				var_122_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_4.position).x, (manager.ui.mainCamera.transform.position - var_122_4.position).y, (manager.ui.mainCamera.transform.position - var_122_4.position).z)
				var_122_4.localEulerAngles.z = 0
				var_122_4.localEulerAngles.x = 0
				var_122_4.localEulerAngles = var_122_4.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_5 and arg_119_1.time_ < 0 + var_122_5 + arg_122_0 then
				var_122_4.localPosition = Vector3.New(0, 100, 0)
				var_122_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_4.position).x, (manager.ui.mainCamera.transform.position - var_122_4.position).y, (manager.ui.mainCamera.transform.position - var_122_4.position).z)
				var_122_4.localEulerAngles.z = 0
				var_122_4.localEulerAngles.x = 0
				var_122_4.localEulerAngles = var_122_4.localEulerAngles
			end

			local var_122_6 = arg_119_1.actors_["10053ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect10053ui_story == nil then
				arg_119_1.var_.characterEffect10053ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_7 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 and not isNil(var_122_6) then
				if arg_119_1.var_.characterEffect10053ui_story and not isNil(var_122_6) then
					arg_119_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_7)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect10053ui_story then
				arg_119_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_122_8 = 0
			local var_122_9 = 1.15

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_10 = arg_119_1:GetWordFromCfg(318202029)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 46 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 46)

				if (46 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 46)) > 0 and var_122_9 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202029", "story_v_out_318202.awb") ~= 0 then
					local var_122_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202029", "story_v_out_318202.awb") / 1000

					if var_122_14 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_8
					end

					if var_122_10.prefab_name ~= "" and arg_119_1.actors_[var_122_10.prefab_name] ~= nil then
						local var_122_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_10.prefab_name].transform, "story_v_out_318202", "318202029", "story_v_out_318202.awb")

						arg_119_1:RecordAudio("318202029", var_122_15)
						arg_119_1:RecordAudio("318202029", var_122_15)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_318202", "318202029", "story_v_out_318202.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_318202", "318202029", "story_v_out_318202.awb")
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
				actorName = "1055ui_story",
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

		arg_119_1:InitPlayNodeList()
	end,
	Play318202030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 318202030
		arg_123_1.duration_ = 2.43

		local var_123_0 = {
			zh = 2.133,
			ja = 2.433
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
				arg_123_0:Play318202031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1058ui_story = arg_123_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1058ui_story"].transform.position).z)
				arg_123_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1058ui_story"].transform.localEulerAngles = arg_123_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_123_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1058ui_story"].transform.position).z)
				arg_123_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1058ui_story"].transform.localEulerAngles = arg_123_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1058ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1058ui_story == nil then
				arg_123_1.var_.characterEffect1058ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1058ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1058ui_story then
				arg_123_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action5_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_4 = arg_123_1.actors_["1055ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1055ui_story = var_126_4.localPosition
			end

			local var_126_5 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 then
				var_126_4.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_5)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 then
				var_126_4.localPosition = Vector3.New(0, 100, 0)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			local var_126_6 = arg_123_1.actors_["1055ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect1055ui_story == nil then
				arg_123_1.var_.characterEffect1055ui_story = var_126_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_7 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 and not isNil(var_126_6) then
				if arg_123_1.var_.characterEffect1055ui_story and not isNil(var_126_6) then
					arg_123_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_7)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect1055ui_story then
				arg_123_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_126_8 = 0
			local var_126_9 = 0.25

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(318202030)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 10 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 10)

				if (10 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 10)) > 0 and var_126_9 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202030", "story_v_out_318202.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202030", "story_v_out_318202.awb") / 1000

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_318202", "318202030", "story_v_out_318202.awb")

						arg_123_1:RecordAudio("318202030", var_126_15)
						arg_123_1:RecordAudio("318202030", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_318202", "318202030", "story_v_out_318202.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_318202", "318202030", "story_v_out_318202.awb")
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
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play318202031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 318202031
		arg_127_1.duration_ = 5.93

		local var_127_0 = {
			zh = 2.6,
			ja = 5.933
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
				arg_127_0:Play318202032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.375

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:GetWordFromCfg(318202031)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 15 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 15)

				if (15 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 15)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202031", "story_v_out_318202.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202031", "story_v_out_318202.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_318202", "318202031", "story_v_out_318202.awb")

						arg_127_1:RecordAudio("318202031", var_130_6)
						arg_127_1:RecordAudio("318202031", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_318202", "318202031", "story_v_out_318202.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_318202", "318202031", "story_v_out_318202.awb")
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
	Play318202032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 318202032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play318202033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1058ui_story = arg_131_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1058ui_story"].transform.position).z)
				arg_131_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1058ui_story"].transform.localEulerAngles = arg_131_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1058ui_story"].transform.position).z)
				arg_131_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1058ui_story"].transform.localEulerAngles = arg_131_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1058ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1058ui_story == nil then
				arg_131_1.var_.characterEffect1058ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1058ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_2)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1058ui_story then
				arg_131_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_134_3 = 0
			local var_134_4 = 0.625

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_3 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_5 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(318202032).content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 25 <= 0 and var_134_4 or var_134_4 * (utf8.len(var_134_5) / 25)

				if (25 <= 0 and var_134_4 or var_134_4 * (utf8.len(var_134_5) / 25)) > 0 and var_134_4 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_3 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_3
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_4, arg_131_1.talkMaxDuration)

			if var_134_3 <= arg_131_1.time_ and arg_131_1.time_ < var_134_3 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_3) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_3 + var_134_8 and arg_131_1.time_ < var_134_3 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play318202033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 318202033
		arg_135_1.duration_ = 4.53

		local var_135_0 = {
			zh = 4.533,
			ja = 4.133
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
				arg_135_0:Play318202034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1055ui_story = arg_135_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1055ui_story"].transform.position).z)
				arg_135_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1055ui_story"].transform.localEulerAngles = arg_135_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_135_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1055ui_story"].transform.position).z)
				arg_135_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1055ui_story"].transform.localEulerAngles = arg_135_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["1055ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1055ui_story == nil then
				arg_135_1.var_.characterEffect1055ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect1055ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1055ui_story then
				arg_135_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action2_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_138_4 = 0
			local var_138_5 = 0.5

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(318202033)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 20 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 20)

				if (20 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 20)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202033", "story_v_out_318202.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_318202", "318202033", "story_v_out_318202.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_318202", "318202033", "story_v_out_318202.awb")

						arg_135_1:RecordAudio("318202033", var_138_11)
						arg_135_1:RecordAudio("318202033", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_318202", "318202033", "story_v_out_318202.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_318202", "318202033", "story_v_out_318202.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play318202034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 318202034
		arg_139_1.duration_ = 6.17

		local var_139_0 = {
			zh = 3.466,
			ja = 6.166
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
				arg_139_0:Play318202035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1058ui_story = arg_139_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1058ui_story"].transform.position).z)
				arg_139_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1058ui_story"].transform.localEulerAngles = arg_139_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_139_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1058ui_story"].transform.position).z)
				arg_139_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1058ui_story"].transform.localEulerAngles = arg_139_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1058ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1058ui_story == nil then
				arg_139_1.var_.characterEffect1058ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1058ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1058ui_story then
				arg_139_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action5_2")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_4 = arg_139_1.actors_["1055ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1055ui_story = var_142_4.localPosition
			end

			local var_142_5 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 then
				var_142_4.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_5)
				var_142_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_4.position).x, (manager.ui.mainCamera.transform.position - var_142_4.position).y, (manager.ui.mainCamera.transform.position - var_142_4.position).z)
				var_142_4.localEulerAngles.z = 0
				var_142_4.localEulerAngles.x = 0
				var_142_4.localEulerAngles = var_142_4.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 then
				var_142_4.localPosition = Vector3.New(0, 100, 0)
				var_142_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_4.position).x, (manager.ui.mainCamera.transform.position - var_142_4.position).y, (manager.ui.mainCamera.transform.position - var_142_4.position).z)
				var_142_4.localEulerAngles.z = 0
				var_142_4.localEulerAngles.x = 0
				var_142_4.localEulerAngles = var_142_4.localEulerAngles
			end

			local var_142_6 = arg_139_1.actors_["1055ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1055ui_story == nil then
				arg_139_1.var_.characterEffect1055ui_story = var_142_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_7 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 and not isNil(var_142_6) then
				if arg_139_1.var_.characterEffect1055ui_story and not isNil(var_142_6) then
					arg_139_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_7)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1055ui_story then
				arg_139_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_142_8 = 0
			local var_142_9 = 0.5

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(318202034)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 20 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 20)

				if (20 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 20)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202034", "story_v_out_318202.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202034", "story_v_out_318202.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_318202", "318202034", "story_v_out_318202.awb")

						arg_139_1:RecordAudio("318202034", var_142_15)
						arg_139_1:RecordAudio("318202034", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_318202", "318202034", "story_v_out_318202.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_318202", "318202034", "story_v_out_318202.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_16 and arg_139_1.time_ < var_142_8 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play318202035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 318202035
		arg_143_1.duration_ = 15.43

		local var_143_0 = {
			zh = 9.066,
			ja = 15.433
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
				arg_143_0:Play318202036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_146_0 = 0
			local var_146_1 = 1.225

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_2 = arg_143_1:GetWordFromCfg(318202035)
				local var_146_3 = arg_143_1:FormatText(var_146_2.content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 49 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_3) / 49)

				if (49 <= 0 and var_146_1 or var_146_1 * (utf8.len(var_146_3) / 49)) > 0 and var_146_1 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202035", "story_v_out_318202.awb") ~= 0 then
					local var_146_6 = manager.audio:GetVoiceLength("story_v_out_318202", "318202035", "story_v_out_318202.awb") / 1000

					if var_146_6 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_0
					end

					if var_146_2.prefab_name ~= "" and arg_143_1.actors_[var_146_2.prefab_name] ~= nil then
						local var_146_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_2.prefab_name].transform, "story_v_out_318202", "318202035", "story_v_out_318202.awb")

						arg_143_1:RecordAudio("318202035", var_146_7)
						arg_143_1:RecordAudio("318202035", var_146_7)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_318202", "318202035", "story_v_out_318202.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_318202", "318202035", "story_v_out_318202.awb")
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

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play318202036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 318202036
		arg_147_1.duration_ = 8.87

		local var_147_0 = {
			zh = 8.866,
			ja = 6.433
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
				arg_147_0:Play318202037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1055ui_story = arg_147_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1055ui_story"].transform.position).z)
				arg_147_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1055ui_story"].transform.localEulerAngles = arg_147_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_147_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1055ui_story"].transform.position).z)
				arg_147_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1055ui_story"].transform.localEulerAngles = arg_147_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1055ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1055ui_story == nil then
				arg_147_1.var_.characterEffect1055ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1055ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1055ui_story then
				arg_147_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_150_4 = arg_147_1.actors_["1058ui_story"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1058ui_story = var_150_4.localPosition
			end

			local var_150_5 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_5 then
				var_150_4.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_5)
				var_150_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_4.position).x, (manager.ui.mainCamera.transform.position - var_150_4.position).y, (manager.ui.mainCamera.transform.position - var_150_4.position).z)
				var_150_4.localEulerAngles.z = 0
				var_150_4.localEulerAngles.x = 0
				var_150_4.localEulerAngles = var_150_4.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_5 and arg_147_1.time_ < 0 + var_150_5 + arg_150_0 then
				var_150_4.localPosition = Vector3.New(0, 100, 0)
				var_150_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_4.position).x, (manager.ui.mainCamera.transform.position - var_150_4.position).y, (manager.ui.mainCamera.transform.position - var_150_4.position).z)
				var_150_4.localEulerAngles.z = 0
				var_150_4.localEulerAngles.x = 0
				var_150_4.localEulerAngles = var_150_4.localEulerAngles
			end

			local var_150_6 = arg_147_1.actors_["1058ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect1058ui_story == nil then
				arg_147_1.var_.characterEffect1058ui_story = var_150_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_7 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 and not isNil(var_150_6) then
				if arg_147_1.var_.characterEffect1058ui_story and not isNil(var_150_6) then
					arg_147_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_7)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect1058ui_story then
				arg_147_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_150_8 = 0
			local var_150_9 = 1.025

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_10 = arg_147_1:GetWordFromCfg(318202036)
				local var_150_11 = arg_147_1:FormatText(var_150_10.content)

				arg_147_1.text_.text = var_150_11

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_13 = 41 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 41)

				if (41 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 41)) > 0 and var_150_9 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_8
					end
				end

				arg_147_1.text_.text = var_150_11
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202036", "story_v_out_318202.awb") ~= 0 then
					local var_150_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202036", "story_v_out_318202.awb") / 1000

					if var_150_14 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_8
					end

					if var_150_10.prefab_name ~= "" and arg_147_1.actors_[var_150_10.prefab_name] ~= nil then
						local var_150_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_10.prefab_name].transform, "story_v_out_318202", "318202036", "story_v_out_318202.awb")

						arg_147_1:RecordAudio("318202036", var_150_15)
						arg_147_1:RecordAudio("318202036", var_150_15)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_318202", "318202036", "story_v_out_318202.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_318202", "318202036", "story_v_out_318202.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_16 = math.max(var_150_9, arg_147_1.talkMaxDuration)

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_16 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_8) / var_150_16

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_8 + var_150_16 and arg_147_1.time_ < var_150_8 + var_150_16 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_147_1:InitPlayNodeList()
	end,
	Play318202037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 318202037
		arg_151_1.duration_ = 4.47

		local var_151_0 = {
			zh = 4.466,
			ja = 4.166
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play318202038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.475

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(318202037)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 19 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 19)

				if (19 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 19)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202037", "story_v_out_318202.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202037", "story_v_out_318202.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_318202", "318202037", "story_v_out_318202.awb")

						arg_151_1:RecordAudio("318202037", var_154_6)
						arg_151_1:RecordAudio("318202037", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_318202", "318202037", "story_v_out_318202.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_318202", "318202037", "story_v_out_318202.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play318202038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 318202038
		arg_155_1.duration_ = 9.53

		local var_155_0 = {
			zh = 9.533,
			ja = 5.466
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
				arg_155_0:Play318202039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1058ui_story = arg_155_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1058ui_story"].transform.position).z)
				arg_155_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1058ui_story"].transform.localEulerAngles = arg_155_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_155_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1058ui_story"].transform.position).z)
				arg_155_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1058ui_story"].transform.localEulerAngles = arg_155_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["1058ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1058ui_story == nil then
				arg_155_1.var_.characterEffect1058ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect1058ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1058ui_story then
				arg_155_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_158_4 = arg_155_1.actors_["1055ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1055ui_story = var_158_4.localPosition
			end

			local var_158_5 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_5 then
				var_158_4.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_5)
				var_158_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_4.position).x, (manager.ui.mainCamera.transform.position - var_158_4.position).y, (manager.ui.mainCamera.transform.position - var_158_4.position).z)
				var_158_4.localEulerAngles.z = 0
				var_158_4.localEulerAngles.x = 0
				var_158_4.localEulerAngles = var_158_4.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_5 and arg_155_1.time_ < 0 + var_158_5 + arg_158_0 then
				var_158_4.localPosition = Vector3.New(0, 100, 0)
				var_158_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_4.position).x, (manager.ui.mainCamera.transform.position - var_158_4.position).y, (manager.ui.mainCamera.transform.position - var_158_4.position).z)
				var_158_4.localEulerAngles.z = 0
				var_158_4.localEulerAngles.x = 0
				var_158_4.localEulerAngles = var_158_4.localEulerAngles
			end

			local var_158_6 = arg_155_1.actors_["1055ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect1055ui_story == nil then
				arg_155_1.var_.characterEffect1055ui_story = var_158_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_7 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 and not isNil(var_158_6) then
				if arg_155_1.var_.characterEffect1055ui_story and not isNil(var_158_6) then
					arg_155_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_7)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect1055ui_story then
				arg_155_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_158_8 = 0
			local var_158_9 = 1.15

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_10 = arg_155_1:GetWordFromCfg(318202038)
				local var_158_11 = arg_155_1:FormatText(var_158_10.content)

				arg_155_1.text_.text = var_158_11

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_13 = 46 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 46)

				if (46 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 46)) > 0 and var_158_9 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_8
					end
				end

				arg_155_1.text_.text = var_158_11
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202038", "story_v_out_318202.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202038", "story_v_out_318202.awb") / 1000

					if var_158_14 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_8
					end

					if var_158_10.prefab_name ~= "" and arg_155_1.actors_[var_158_10.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_10.prefab_name].transform, "story_v_out_318202", "318202038", "story_v_out_318202.awb")

						arg_155_1:RecordAudio("318202038", var_158_15)
						arg_155_1:RecordAudio("318202038", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_318202", "318202038", "story_v_out_318202.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_318202", "318202038", "story_v_out_318202.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_9, arg_155_1.talkMaxDuration)

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_8) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_8 + var_158_16 and arg_155_1.time_ < var_158_8 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play318202039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 318202039
		arg_159_1.duration_ = 5.1

		local var_159_0 = {
			zh = 3.933,
			ja = 5.1
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
				arg_159_0:Play318202040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1055ui_story = arg_159_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1055ui_story"].transform.position).z)
				arg_159_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1055ui_story"].transform.localEulerAngles = arg_159_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_159_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1055ui_story"].transform.position).z)
				arg_159_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1055ui_story"].transform.localEulerAngles = arg_159_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1055ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1055ui_story == nil then
				arg_159_1.var_.characterEffect1055ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1055ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1055ui_story then
				arg_159_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_162_4 = arg_159_1.actors_["1058ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1058ui_story = var_162_4.localPosition
			end

			local var_162_5 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_5 then
				var_162_4.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0) / var_162_5)
				var_162_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_4.position).x, (manager.ui.mainCamera.transform.position - var_162_4.position).y, (manager.ui.mainCamera.transform.position - var_162_4.position).z)
				var_162_4.localEulerAngles.z = 0
				var_162_4.localEulerAngles.x = 0
				var_162_4.localEulerAngles = var_162_4.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_5 and arg_159_1.time_ < 0 + var_162_5 + arg_162_0 then
				var_162_4.localPosition = Vector3.New(0, 100, 0)
				var_162_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_4.position).x, (manager.ui.mainCamera.transform.position - var_162_4.position).y, (manager.ui.mainCamera.transform.position - var_162_4.position).z)
				var_162_4.localEulerAngles.z = 0
				var_162_4.localEulerAngles.x = 0
				var_162_4.localEulerAngles = var_162_4.localEulerAngles
			end

			local var_162_6 = arg_159_1.actors_["1058ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect1058ui_story == nil then
				arg_159_1.var_.characterEffect1058ui_story = var_162_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_7 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 and not isNil(var_162_6) then
				if arg_159_1.var_.characterEffect1058ui_story and not isNil(var_162_6) then
					arg_159_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_159_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_7)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect1058ui_story then
				arg_159_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_159_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action3_1")
			end

			local var_162_8 = 0
			local var_162_9 = 0.425

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(318202039)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 17 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 17)

				if (17 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 17)) > 0 and var_162_9 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202039", "story_v_out_318202.awb") ~= 0 then
					local var_162_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202039", "story_v_out_318202.awb") / 1000

					if var_162_14 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_8
					end

					if var_162_10.prefab_name ~= "" and arg_159_1.actors_[var_162_10.prefab_name] ~= nil then
						local var_162_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_10.prefab_name].transform, "story_v_out_318202", "318202039", "story_v_out_318202.awb")

						arg_159_1:RecordAudio("318202039", var_162_15)
						arg_159_1:RecordAudio("318202039", var_162_15)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_318202", "318202039", "story_v_out_318202.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_318202", "318202039", "story_v_out_318202.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_16 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_16 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_16

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_16 and arg_159_1.time_ < var_162_8 + var_162_16 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_159_1:InitPlayNodeList()
	end,
	Play318202040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 318202040
		arg_163_1.duration_ = 1.27

		local var_163_0 = {
			zh = 1,
			ja = 1.266
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
				arg_163_0:Play318202041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1058ui_story = arg_163_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).z)
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles = arg_163_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_163_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1058ui_story"].transform.position).z)
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1058ui_story"].transform.localEulerAngles = arg_163_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1058ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1058ui_story == nil then
				arg_163_1.var_.characterEffect1058ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect1058ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1058ui_story then
				arg_163_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_166_4 = arg_163_1.actors_["1055ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1055ui_story = var_166_4.localPosition
			end

			local var_166_5 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_5 then
				var_166_4.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_5)
				var_166_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_4.position).x, (manager.ui.mainCamera.transform.position - var_166_4.position).y, (manager.ui.mainCamera.transform.position - var_166_4.position).z)
				var_166_4.localEulerAngles.z = 0
				var_166_4.localEulerAngles.x = 0
				var_166_4.localEulerAngles = var_166_4.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_5 and arg_163_1.time_ < 0 + var_166_5 + arg_166_0 then
				var_166_4.localPosition = Vector3.New(0, 100, 0)
				var_166_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_4.position).x, (manager.ui.mainCamera.transform.position - var_166_4.position).y, (manager.ui.mainCamera.transform.position - var_166_4.position).z)
				var_166_4.localEulerAngles.z = 0
				var_166_4.localEulerAngles.x = 0
				var_166_4.localEulerAngles = var_166_4.localEulerAngles
			end

			local var_166_6 = arg_163_1.actors_["1055ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect1055ui_story == nil then
				arg_163_1.var_.characterEffect1055ui_story = var_166_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_7 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 and not isNil(var_166_6) then
				if arg_163_1.var_.characterEffect1055ui_story and not isNil(var_166_6) then
					arg_163_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_7)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 and not isNil(var_166_6) and arg_163_1.var_.characterEffect1055ui_story then
				arg_163_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_166_8 = 0
			local var_166_9 = 0.05

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_10 = arg_163_1:GetWordFromCfg(318202040)
				local var_166_11 = arg_163_1:FormatText(var_166_10.content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 2 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 2)

				if (2 <= 0 and var_166_9 or var_166_9 * (utf8.len(var_166_11) / 2)) > 0 and var_166_9 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_8
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202040", "story_v_out_318202.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202040", "story_v_out_318202.awb") / 1000

					if var_166_14 + var_166_8 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_8
					end

					if var_166_10.prefab_name ~= "" and arg_163_1.actors_[var_166_10.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_10.prefab_name].transform, "story_v_out_318202", "318202040", "story_v_out_318202.awb")

						arg_163_1:RecordAudio("318202040", var_166_15)
						arg_163_1:RecordAudio("318202040", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_318202", "318202040", "story_v_out_318202.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_318202", "318202040", "story_v_out_318202.awb")
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
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play318202041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 318202041
		arg_167_1.duration_ = 9.13

		local var_167_0 = {
			zh = 7.933,
			ja = 9.133
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
				arg_167_0:Play318202042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1055ui_story = arg_167_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1055ui_story"].transform.position).z)
				arg_167_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1055ui_story"].transform.localEulerAngles = arg_167_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_167_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1055ui_story"].transform.position).z)
				arg_167_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1055ui_story"].transform.localEulerAngles = arg_167_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1055ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1055ui_story == nil then
				arg_167_1.var_.characterEffect1055ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1055ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1055ui_story then
				arg_167_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action3_2")
			end

			local var_170_4 = arg_167_1.actors_["1058ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1058ui_story = var_170_4.localPosition
			end

			local var_170_5 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_5 then
				var_170_4.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_5)
				var_170_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_4.position).x, (manager.ui.mainCamera.transform.position - var_170_4.position).y, (manager.ui.mainCamera.transform.position - var_170_4.position).z)
				var_170_4.localEulerAngles.z = 0
				var_170_4.localEulerAngles.x = 0
				var_170_4.localEulerAngles = var_170_4.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_5 and arg_167_1.time_ < 0 + var_170_5 + arg_170_0 then
				var_170_4.localPosition = Vector3.New(0, 100, 0)
				var_170_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_4.position).x, (manager.ui.mainCamera.transform.position - var_170_4.position).y, (manager.ui.mainCamera.transform.position - var_170_4.position).z)
				var_170_4.localEulerAngles.z = 0
				var_170_4.localEulerAngles.x = 0
				var_170_4.localEulerAngles = var_170_4.localEulerAngles
			end

			local var_170_6 = arg_167_1.actors_["1058ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect1058ui_story == nil then
				arg_167_1.var_.characterEffect1058ui_story = var_170_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_7 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 and not isNil(var_170_6) then
				if arg_167_1.var_.characterEffect1058ui_story and not isNil(var_170_6) then
					arg_167_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_7)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect1058ui_story then
				arg_167_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_170_8 = 0
			local var_170_9 = 0.9

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:GetWordFromCfg(318202041)
				local var_170_11 = arg_167_1:FormatText(var_170_10.content)

				arg_167_1.text_.text = var_170_11

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 36 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 36)

				if (36 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_11) / 36)) > 0 and var_170_9 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_11
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202041", "story_v_out_318202.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202041", "story_v_out_318202.awb") / 1000

					if var_170_14 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_8
					end

					if var_170_10.prefab_name ~= "" and arg_167_1.actors_[var_170_10.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_10.prefab_name].transform, "story_v_out_318202", "318202041", "story_v_out_318202.awb")

						arg_167_1:RecordAudio("318202041", var_170_15)
						arg_167_1:RecordAudio("318202041", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_318202", "318202041", "story_v_out_318202.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_318202", "318202041", "story_v_out_318202.awb")
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_167_1:InitPlayNodeList()
	end,
	Play318202042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 318202042
		arg_171_1.duration_ = 7.43

		local var_171_0 = {
			zh = 7.433,
			ja = 6.266
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
				arg_171_0:Play318202043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1058ui_story = arg_171_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1058ui_story"].transform.position).z)
				arg_171_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1058ui_story"].transform.localEulerAngles = arg_171_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_171_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1058ui_story"].transform.position).z)
				arg_171_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1058ui_story"].transform.localEulerAngles = arg_171_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1058ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1058ui_story == nil then
				arg_171_1.var_.characterEffect1058ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect1058ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1058ui_story then
				arg_171_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			local var_174_4 = arg_171_1.actors_["1055ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1055ui_story = var_174_4.localPosition
			end

			local var_174_5 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_5 then
				var_174_4.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_5)
				var_174_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_4.position).x, (manager.ui.mainCamera.transform.position - var_174_4.position).y, (manager.ui.mainCamera.transform.position - var_174_4.position).z)
				var_174_4.localEulerAngles.z = 0
				var_174_4.localEulerAngles.x = 0
				var_174_4.localEulerAngles = var_174_4.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_5 and arg_171_1.time_ < 0 + var_174_5 + arg_174_0 then
				var_174_4.localPosition = Vector3.New(0, 100, 0)
				var_174_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_4.position).x, (manager.ui.mainCamera.transform.position - var_174_4.position).y, (manager.ui.mainCamera.transform.position - var_174_4.position).z)
				var_174_4.localEulerAngles.z = 0
				var_174_4.localEulerAngles.x = 0
				var_174_4.localEulerAngles = var_174_4.localEulerAngles
			end

			local var_174_6 = arg_171_1.actors_["1055ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect1055ui_story == nil then
				arg_171_1.var_.characterEffect1055ui_story = var_174_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_7 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 and not isNil(var_174_6) then
				if arg_171_1.var_.characterEffect1055ui_story and not isNil(var_174_6) then
					arg_171_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_7)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 and not isNil(var_174_6) and arg_171_1.var_.characterEffect1055ui_story then
				arg_171_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_174_8 = 0
			local var_174_9 = 0.8

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(318202042)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 32 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 32)

				if (32 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 32)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202042", "story_v_out_318202.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202042", "story_v_out_318202.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_318202", "318202042", "story_v_out_318202.awb")

						arg_171_1:RecordAudio("318202042", var_174_15)
						arg_171_1:RecordAudio("318202042", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_318202", "318202042", "story_v_out_318202.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_318202", "318202042", "story_v_out_318202.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_16 and arg_171_1.time_ < var_174_8 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play318202043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 318202043
		arg_175_1.duration_ = 10.33

		local var_175_0 = {
			zh = 8.133,
			ja = 10.333
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
				arg_175_0:Play318202044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1055ui_story = arg_175_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1055ui_story"].transform.position).z)
				arg_175_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1055ui_story"].transform.localEulerAngles = arg_175_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_175_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1055ui_story"].transform.position).z)
				arg_175_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1055ui_story"].transform.localEulerAngles = arg_175_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1055ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1055ui_story == nil then
				arg_175_1.var_.characterEffect1055ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1055ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1055ui_story then
				arg_175_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_178_4 = arg_175_1.actors_["1058ui_story"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1058ui_story = var_178_4.localPosition
			end

			local var_178_5 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_5 then
				var_178_4.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_5)
				var_178_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_4.position).x, (manager.ui.mainCamera.transform.position - var_178_4.position).y, (manager.ui.mainCamera.transform.position - var_178_4.position).z)
				var_178_4.localEulerAngles.z = 0
				var_178_4.localEulerAngles.x = 0
				var_178_4.localEulerAngles = var_178_4.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_5 and arg_175_1.time_ < 0 + var_178_5 + arg_178_0 then
				var_178_4.localPosition = Vector3.New(0, 100, 0)
				var_178_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_4.position).x, (manager.ui.mainCamera.transform.position - var_178_4.position).y, (manager.ui.mainCamera.transform.position - var_178_4.position).z)
				var_178_4.localEulerAngles.z = 0
				var_178_4.localEulerAngles.x = 0
				var_178_4.localEulerAngles = var_178_4.localEulerAngles
			end

			local var_178_6 = arg_175_1.actors_["1058ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_6) and arg_175_1.var_.characterEffect1058ui_story == nil then
				arg_175_1.var_.characterEffect1058ui_story = var_178_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_7 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 and not isNil(var_178_6) then
				if arg_175_1.var_.characterEffect1058ui_story and not isNil(var_178_6) then
					arg_175_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_7)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 and not isNil(var_178_6) and arg_175_1.var_.characterEffect1058ui_story then
				arg_175_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_178_8 = 0
			local var_178_9 = 0.775

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_10 = arg_175_1:GetWordFromCfg(318202043)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 31 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 31)

				if (31 <= 0 and var_178_9 or var_178_9 * (utf8.len(var_178_11) / 31)) > 0 and var_178_9 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13

					if var_178_13 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_8
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202043", "story_v_out_318202.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202043", "story_v_out_318202.awb") / 1000

					if var_178_14 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_8
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_out_318202", "318202043", "story_v_out_318202.awb")

						arg_175_1:RecordAudio("318202043", var_178_15)
						arg_175_1:RecordAudio("318202043", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_318202", "318202043", "story_v_out_318202.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_318202", "318202043", "story_v_out_318202.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = math.max(var_178_9, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_16 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_8) / var_178_16

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_16 and arg_175_1.time_ < var_178_8 + var_178_16 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_175_1:InitPlayNodeList()
	end,
	Play318202044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 318202044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play318202045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1055ui_story = arg_179_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1055ui_story"].transform.position).z)
				arg_179_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1055ui_story"].transform.localEulerAngles = arg_179_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1055ui_story"].transform.position).z)
				arg_179_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1055ui_story"].transform.localEulerAngles = arg_179_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1055ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1055ui_story == nil then
				arg_179_1.var_.characterEffect1055ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1055ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_2)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1055ui_story then
				arg_179_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_182_3 = 0
			local var_182_4 = 0.5

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_3 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_5 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(318202044).content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 20 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_5) / 20)

				if (20 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_5) / 20)) > 0 and var_182_4 < var_182_7 then
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
				actorName = "1055ui_story",
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
	Play318202045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 318202045
		arg_183_1.duration_ = 10.53

		local var_183_0 = {
			zh = 10.533,
			ja = 9.1
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
				arg_183_0:Play318202046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1055ui_story = arg_183_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1055ui_story"].transform.position).z)
				arg_183_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1055ui_story"].transform.localEulerAngles = arg_183_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_183_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1055ui_story"].transform.position).z)
				arg_183_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1055ui_story"].transform.localEulerAngles = arg_183_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1055ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1055ui_story == nil then
				arg_183_1.var_.characterEffect1055ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1055ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1055ui_story then
				arg_183_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_186_4 = 0
			local var_186_5 = 1.225

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(318202045)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 49 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 49)

				if (49 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 49)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202045", "story_v_out_318202.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_318202", "318202045", "story_v_out_318202.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_318202", "318202045", "story_v_out_318202.awb")

						arg_183_1:RecordAudio("318202045", var_186_11)
						arg_183_1:RecordAudio("318202045", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_318202", "318202045", "story_v_out_318202.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_318202", "318202045", "story_v_out_318202.awb")
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

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play318202046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 318202046
		arg_187_1.duration_ = 7

		local var_187_0 = {
			zh = 7,
			ja = 4.933
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
				arg_187_0:Play318202047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.825

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(318202046)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 33 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 33)

				if (33 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 33)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202046", "story_v_out_318202.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202046", "story_v_out_318202.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_318202", "318202046", "story_v_out_318202.awb")

						arg_187_1:RecordAudio("318202046", var_190_6)
						arg_187_1:RecordAudio("318202046", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_318202", "318202046", "story_v_out_318202.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_318202", "318202046", "story_v_out_318202.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play318202047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 318202047
		arg_191_1.duration_ = 7.33

		local var_191_0 = {
			zh = 5.266,
			ja = 7.333
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
				arg_191_0:Play318202048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.575

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(318202047)
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

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202047", "story_v_out_318202.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202047", "story_v_out_318202.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_318202", "318202047", "story_v_out_318202.awb")

						arg_191_1:RecordAudio("318202047", var_194_6)
						arg_191_1:RecordAudio("318202047", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_318202", "318202047", "story_v_out_318202.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_318202", "318202047", "story_v_out_318202.awb")
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
	Play318202048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 318202048
		arg_195_1.duration_ = 11.27

		local var_195_0 = {
			zh = 11.266,
			ja = 5.533
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
				arg_195_0:Play318202049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.675

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:GetWordFromCfg(318202048)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 27 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 27)

				if (27 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 27)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202048", "story_v_out_318202.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_318202", "318202048", "story_v_out_318202.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_318202", "318202048", "story_v_out_318202.awb")

						arg_195_1:RecordAudio("318202048", var_198_6)
						arg_195_1:RecordAudio("318202048", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_318202", "318202048", "story_v_out_318202.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_318202", "318202048", "story_v_out_318202.awb")
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
	Play318202049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 318202049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play318202050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1055ui_story"]) and arg_199_1.var_.characterEffect1055ui_story == nil then
				arg_199_1.var_.characterEffect1055ui_story = arg_199_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1055ui_story"]) then
				if arg_199_1.var_.characterEffect1055ui_story and not isNil(arg_199_1.actors_["1055ui_story"]) then
					arg_199_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1055ui_story"]) and arg_199_1.var_.characterEffect1055ui_story then
				arg_199_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.725

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(318202049).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 29 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 29)

				if (29 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 29)) > 0 and var_202_2 < var_202_5 then
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
	Play318202050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 318202050
		arg_203_1.duration_ = 4.1

		local var_203_0 = {
			zh = 3.766,
			ja = 4.1
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
				arg_203_0:Play318202051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1055ui_story = arg_203_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1055ui_story"].transform.position).z)
				arg_203_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1055ui_story"].transform.localEulerAngles = arg_203_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_203_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1055ui_story"].transform.position).z)
				arg_203_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1055ui_story"].transform.localEulerAngles = arg_203_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1055ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1055ui_story == nil then
				arg_203_1.var_.characterEffect1055ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1055ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1055ui_story then
				arg_203_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action2_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_206_4 = 0
			local var_206_5 = 0.4

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(318202050)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 16 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 16)

				if (16 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 16)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202050", "story_v_out_318202.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_318202", "318202050", "story_v_out_318202.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_out_318202", "318202050", "story_v_out_318202.awb")

						arg_203_1:RecordAudio("318202050", var_206_11)
						arg_203_1:RecordAudio("318202050", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_318202", "318202050", "story_v_out_318202.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_318202", "318202050", "story_v_out_318202.awb")
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
				actorName = "1055ui_story",
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
	Play318202051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 318202051
		arg_207_1.duration_ = 7.43

		local var_207_0 = {
			zh = 4.833,
			ja = 7.433
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
				arg_207_0:Play318202052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1058ui_story = arg_207_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1058ui_story"].transform.position).z)
				arg_207_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1058ui_story"].transform.localEulerAngles = arg_207_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_207_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1058ui_story"].transform.position).z)
				arg_207_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1058ui_story"].transform.localEulerAngles = arg_207_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1058ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1058ui_story == nil then
				arg_207_1.var_.characterEffect1058ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1058ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1058ui_story then
				arg_207_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action5_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_210_4 = arg_207_1.actors_["1055ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1055ui_story = var_210_4.localPosition
			end

			local var_210_5 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_5 then
				var_210_4.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_5)
				var_210_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_4.position).x, (manager.ui.mainCamera.transform.position - var_210_4.position).y, (manager.ui.mainCamera.transform.position - var_210_4.position).z)
				var_210_4.localEulerAngles.z = 0
				var_210_4.localEulerAngles.x = 0
				var_210_4.localEulerAngles = var_210_4.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_5 and arg_207_1.time_ < 0 + var_210_5 + arg_210_0 then
				var_210_4.localPosition = Vector3.New(0, 100, 0)
				var_210_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_4.position).x, (manager.ui.mainCamera.transform.position - var_210_4.position).y, (manager.ui.mainCamera.transform.position - var_210_4.position).z)
				var_210_4.localEulerAngles.z = 0
				var_210_4.localEulerAngles.x = 0
				var_210_4.localEulerAngles = var_210_4.localEulerAngles
			end

			local var_210_6 = arg_207_1.actors_["1055ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect1055ui_story == nil then
				arg_207_1.var_.characterEffect1055ui_story = var_210_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_7 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 and not isNil(var_210_6) then
				if arg_207_1.var_.characterEffect1055ui_story and not isNil(var_210_6) then
					arg_207_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_7)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 and not isNil(var_210_6) and arg_207_1.var_.characterEffect1055ui_story then
				arg_207_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_210_8 = 0
			local var_210_9 = 0.475

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

				local var_210_10 = arg_207_1:GetWordFromCfg(318202051)
				local var_210_11 = arg_207_1:FormatText(var_210_10.content)

				arg_207_1.text_.text = var_210_11

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_13 = 19 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 19)

				if (19 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 19)) > 0 and var_210_9 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_11
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202051", "story_v_out_318202.awb") ~= 0 then
					local var_210_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202051", "story_v_out_318202.awb") / 1000

					if var_210_14 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_8
					end

					if var_210_10.prefab_name ~= "" and arg_207_1.actors_[var_210_10.prefab_name] ~= nil then
						local var_210_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_10.prefab_name].transform, "story_v_out_318202", "318202051", "story_v_out_318202.awb")

						arg_207_1:RecordAudio("318202051", var_210_15)
						arg_207_1:RecordAudio("318202051", var_210_15)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_318202", "318202051", "story_v_out_318202.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_318202", "318202051", "story_v_out_318202.awb")
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
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play318202052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 318202052
		arg_211_1.duration_ = 13.47

		local var_211_0 = {
			zh = 6.833,
			ja = 13.466
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play318202053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1058ui_story = arg_211_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1058ui_story"].transform.position).z)
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1058ui_story"].transform.localEulerAngles = arg_211_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
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
					arg_211_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1058ui_story then
				arg_211_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action5_2")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_214_4 = 0
			local var_214_5 = 0.825

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(318202052)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 33 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 33)

				if (33 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 33)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202052", "story_v_out_318202.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_out_318202", "318202052", "story_v_out_318202.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_out_318202", "318202052", "story_v_out_318202.awb")

						arg_211_1:RecordAudio("318202052", var_214_11)
						arg_211_1:RecordAudio("318202052", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_318202", "318202052", "story_v_out_318202.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_318202", "318202052", "story_v_out_318202.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_12 and arg_211_1.time_ < var_214_4 + var_214_12 + arg_214_0 then
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
	Play318202053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 318202053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play318202054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1058ui_story = arg_215_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).z)
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles = arg_215_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1058ui_story"].transform.position).z)
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1058ui_story"].transform.localEulerAngles = arg_215_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1058ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1058ui_story == nil then
				arg_215_1.var_.characterEffect1058ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1058ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_2)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1058ui_story then
				arg_215_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_218_3 = 0
			local var_218_4 = 0.65

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_3 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_5 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(318202053).content)

				arg_215_1.text_.text = var_218_5

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_7 = 26 <= 0 and var_218_4 or var_218_4 * (utf8.len(var_218_5) / 26)

				if (26 <= 0 and var_218_4 or var_218_4 * (utf8.len(var_218_5) / 26)) > 0 and var_218_4 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_3 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_3
					end
				end

				arg_215_1.text_.text = var_218_5
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_4, arg_215_1.talkMaxDuration)

			if var_218_3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_3 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_3) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_3 + var_218_8 and arg_215_1.time_ < var_218_3 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play318202054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 318202054
		arg_219_1.duration_ = 1.8

		local var_219_0 = {
			zh = 1.8,
			ja = 1.233
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
				arg_219_0:Play318202055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos10053ui_story = arg_219_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10053ui_story"].transform.position).z)
				arg_219_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["10053ui_story"].transform.localEulerAngles = arg_219_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, -1.12, -5.99)
				arg_219_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["10053ui_story"].transform.position).z)
				arg_219_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["10053ui_story"].transform.localEulerAngles = arg_219_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["10053ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect10053ui_story == nil then
				arg_219_1.var_.characterEffect10053ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect10053ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect10053ui_story then
				arg_219_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_222_4 = 0
			local var_222_5 = 0.25

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:GetWordFromCfg(318202054)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 10 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 10)

				if (10 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 10)) > 0 and var_222_5 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_4
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202054", "story_v_out_318202.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_out_318202", "318202054", "story_v_out_318202.awb") / 1000

					if var_222_10 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_4
					end

					if var_222_6.prefab_name ~= "" and arg_219_1.actors_[var_222_6.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_6.prefab_name].transform, "story_v_out_318202", "318202054", "story_v_out_318202.awb")

						arg_219_1:RecordAudio("318202054", var_222_11)
						arg_219_1:RecordAudio("318202054", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_318202", "318202054", "story_v_out_318202.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_318202", "318202054", "story_v_out_318202.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_12 = math.max(var_222_5, arg_219_1.talkMaxDuration)

			if var_222_4 <= arg_219_1.time_ and arg_219_1.time_ < var_222_4 + var_222_12 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_4) / var_222_12

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_4 + var_222_12 and arg_219_1.time_ < var_222_4 + var_222_12 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
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

		arg_219_1:InitPlayNodeList()
	end,
	Play318202055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 318202055
		arg_223_1.duration_ = 3.3

		local var_223_0 = {
			zh = 2.3,
			ja = 3.3
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play318202056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1055ui_story = arg_223_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1055ui_story"].transform.position).z)
				arg_223_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1055ui_story"].transform.localEulerAngles = arg_223_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_223_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1055ui_story"].transform.position).z)
				arg_223_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1055ui_story"].transform.localEulerAngles = arg_223_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1055ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1055ui_story == nil then
				arg_223_1.var_.characterEffect1055ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1055ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1055ui_story then
				arg_223_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_226_4 = arg_223_1.actors_["10053ui_story"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10053ui_story = var_226_4.localPosition
			end

			local var_226_5 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_5 then
				var_226_4.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_5)
				var_226_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_4.position).x, (manager.ui.mainCamera.transform.position - var_226_4.position).y, (manager.ui.mainCamera.transform.position - var_226_4.position).z)
				var_226_4.localEulerAngles.z = 0
				var_226_4.localEulerAngles.x = 0
				var_226_4.localEulerAngles = var_226_4.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_5 and arg_223_1.time_ < 0 + var_226_5 + arg_226_0 then
				var_226_4.localPosition = Vector3.New(0, 100, 0)
				var_226_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_226_4.position).x, (manager.ui.mainCamera.transform.position - var_226_4.position).y, (manager.ui.mainCamera.transform.position - var_226_4.position).z)
				var_226_4.localEulerAngles.z = 0
				var_226_4.localEulerAngles.x = 0
				var_226_4.localEulerAngles = var_226_4.localEulerAngles
			end

			local var_226_6 = arg_223_1.actors_["10053ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect10053ui_story == nil then
				arg_223_1.var_.characterEffect10053ui_story = var_226_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_7 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 and not isNil(var_226_6) then
				if arg_223_1.var_.characterEffect10053ui_story and not isNil(var_226_6) then
					arg_223_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_223_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_7)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect10053ui_story then
				arg_223_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_223_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_226_8 = 0
			local var_226_9 = 0.275

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_10 = arg_223_1:GetWordFromCfg(318202055)
				local var_226_11 = arg_223_1:FormatText(var_226_10.content)

				arg_223_1.text_.text = var_226_11

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_13 = 11 <= 0 and var_226_9 or var_226_9 * (utf8.len(var_226_11) / 11)

				if (11 <= 0 and var_226_9 or var_226_9 * (utf8.len(var_226_11) / 11)) > 0 and var_226_9 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_8
					end
				end

				arg_223_1.text_.text = var_226_11
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318202", "318202055", "story_v_out_318202.awb") ~= 0 then
					local var_226_14 = manager.audio:GetVoiceLength("story_v_out_318202", "318202055", "story_v_out_318202.awb") / 1000

					if var_226_14 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_14 + var_226_8
					end

					if var_226_10.prefab_name ~= "" and arg_223_1.actors_[var_226_10.prefab_name] ~= nil then
						local var_226_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_10.prefab_name].transform, "story_v_out_318202", "318202055", "story_v_out_318202.awb")

						arg_223_1:RecordAudio("318202055", var_226_15)
						arg_223_1:RecordAudio("318202055", var_226_15)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_318202", "318202055", "story_v_out_318202.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_318202", "318202055", "story_v_out_318202.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_16 = math.max(var_226_9, arg_223_1.talkMaxDuration)

			if var_226_8 <= arg_223_1.time_ and arg_223_1.time_ < var_226_8 + var_226_16 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_8) / var_226_16

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_8 + var_226_16 and arg_223_1.time_ < var_226_8 + var_226_16 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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

		arg_223_1:InitPlayNodeList()
	end,
	Play318202056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 318202056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
			arg_227_1.auto_ = false
		end

		function arg_227_1.playNext_(arg_229_0)
			arg_227_1.onStoryFinished_()
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1055ui_story = arg_227_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1055ui_story"].transform.position).z)
				arg_227_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1055ui_story"].transform.localEulerAngles = arg_227_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1055ui_story"].transform.position).z)
				arg_227_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1055ui_story"].transform.localEulerAngles = arg_227_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1055ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1055ui_story == nil then
				arg_227_1.var_.characterEffect1055ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1055ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_2)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1055ui_story then
				arg_227_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_230_3 = 0
			local var_230_4 = 0.475

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_3 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_5 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(318202056).content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 19 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 19)

				if (19 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 19)) > 0 and var_230_4 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_3 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_3
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_8 = math.max(var_230_4, arg_227_1.talkMaxDuration)

			if var_230_3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_3 + var_230_8 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_3) / var_230_8

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_3 + var_230_8 and arg_227_1.time_ < var_230_3 + var_230_8 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	assets = {
		"TextureConfig/Background/K07f",
		"TextureConfig/Background/K05f"
	},
	voices = {
		"story_v_out_318202.awb"
	}
}
