return {
	Play411071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411071001
		arg_1_1.duration_ = 3.23

		local var_1_0 = {
			zh = 2.833,
			ja = 3.233
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
				arg_1_0:Play411071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B03b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B03b")
				var_4_0.name = "B03b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B03b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B03b

				arg_1_1.bgs_.B03b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B03b" then
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_5_story_2", "bgm_activity_1_5_story_2")

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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_3", "se_story_3_verified", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.1

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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[676].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(411071001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 4 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 4)

				if (4 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 4)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071001", "story_v_out_411071.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_411071", "411071001", "story_v_out_411071.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_411071", "411071001", "story_v_out_411071.awb")

						arg_1_1:RecordAudio("411071001", var_4_23)
						arg_1_1:RecordAudio("411071001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_411071", "411071001", "story_v_out_411071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_411071", "411071001", "story_v_out_411071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play411071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411071002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play411071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_door", "")
			end

			local var_12_1 = 0
			local var_12_2 = 1

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(411071002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 40 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 40)

				if (40 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 40)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play411071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411071003
		arg_13_1.duration_ = 1.9

		local var_13_0 = {
			zh = 1.9,
			ja = 1.866
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
				arg_13_0:Play411071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_16_0 = 0.5

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

			if arg_13_1.time_ >= var_16_3 + 0.5 and arg_13_1.time_ < var_16_3 + 0.5 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			local var_16_4 = 0
			local var_16_5 = 0.1

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[680].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2019")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_6 = arg_13_1:GetWordFromCfg(411071003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 4 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 4)

				if (4 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 4)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071003", "story_v_out_411071.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_411071", "411071003", "story_v_out_411071.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_411071", "411071003", "story_v_out_411071.awb")

						arg_13_1:RecordAudio("411071003", var_16_11)
						arg_13_1:RecordAudio("411071003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_411071", "411071003", "story_v_out_411071.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_411071", "411071003", "story_v_out_411071.awb")
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
	Play411071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411071004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play411071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.9

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(411071004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 36 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 36)

				if (36 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 36)) > 0 and var_20_0 < var_20_3 then
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
	Play411071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411071005
		arg_21_1.duration_ = 2

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play411071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1095ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1095ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1095ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1095ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1095ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1095ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["1095ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1095ui_story == nil then
				arg_21_1.var_.characterEffect1095ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect1095ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1095ui_story then
				arg_21_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_24_8 = 0
			local var_24_9 = 0.3

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(411071005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 12 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 12)

				if (12 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 12)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071005", "story_v_out_411071.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_411071", "411071005", "story_v_out_411071.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_411071", "411071005", "story_v_out_411071.awb")

						arg_21_1:RecordAudio("411071005", var_24_15)
						arg_21_1:RecordAudio("411071005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_411071", "411071005", "story_v_out_411071.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_411071", "411071005", "story_v_out_411071.awb")
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
				actorName = "1095ui_story",
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
	Play411071006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411071006
		arg_25_1.duration_ = 1

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play411071007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1095ui_story"]) and arg_25_1.var_.characterEffect1095ui_story == nil then
				arg_25_1.var_.characterEffect1095ui_story = arg_25_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1095ui_story"]) then
				if arg_25_1.var_.characterEffect1095ui_story and not isNil(arg_25_1.actors_["1095ui_story"]) then
					arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1095ui_story"]) and arg_25_1.var_.characterEffect1095ui_story then
				arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.075

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[676].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(411071006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 3 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 3)

				if (3 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 3)) > 0 and var_28_2 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071006", "story_v_out_411071.awb") ~= 0 then
					local var_28_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071006", "story_v_out_411071.awb") / 1000

					if var_28_7 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_1
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_411071", "411071006", "story_v_out_411071.awb")

						arg_25_1:RecordAudio("411071006", var_28_8)
						arg_25_1:RecordAudio("411071006", var_28_8)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_411071", "411071006", "story_v_out_411071.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_411071", "411071006", "story_v_out_411071.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_9 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_9 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_9

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_9 and arg_25_1.time_ < var_28_1 + var_28_9 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play411071007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411071007
		arg_29_1.duration_ = 2.43

		local var_29_0 = {
			zh = 1.5,
			ja = 2.433
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
				arg_29_0:Play411071008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.175

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[677].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(411071007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 7 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 7)

				if (7 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 7)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071007", "story_v_out_411071.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071007", "story_v_out_411071.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_411071", "411071007", "story_v_out_411071.awb")

						arg_29_1:RecordAudio("411071007", var_32_6)
						arg_29_1:RecordAudio("411071007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_411071", "411071007", "story_v_out_411071.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_411071", "411071007", "story_v_out_411071.awb")
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
	Play411071008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411071008
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play411071009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1095ui_story = arg_33_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).z)
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles = arg_33_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_33_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1095ui_story"].transform.position).z)
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1095ui_story"].transform.localEulerAngles = arg_33_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1095ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1095ui_story == nil then
				arg_33_1.var_.characterEffect1095ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1095ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1095ui_story then
				arg_33_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_36_4 = 0
			local var_36_5 = 0.2

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(411071008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 8 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 8)

				if (8 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 8)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071008", "story_v_out_411071.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_411071", "411071008", "story_v_out_411071.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_411071", "411071008", "story_v_out_411071.awb")

						arg_33_1:RecordAudio("411071008", var_36_11)
						arg_33_1:RecordAudio("411071008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_411071", "411071008", "story_v_out_411071.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_411071", "411071008", "story_v_out_411071.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play411071009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411071009
		arg_37_1.duration_ = 5.23

		local var_37_0 = {
			zh = 3.4,
			ja = 5.233
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
				arg_37_0:Play411071010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) and arg_37_1.var_.characterEffect1095ui_story == nil then
				arg_37_1.var_.characterEffect1095ui_story = arg_37_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) then
				if arg_37_1.var_.characterEffect1095ui_story and not isNil(arg_37_1.actors_["1095ui_story"]) then
					arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1095ui_story"]) and arg_37_1.var_.characterEffect1095ui_story then
				arg_37_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.375

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[677].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(411071009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 15 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 15)

				if (15 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 15)) > 0 and var_40_2 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071009", "story_v_out_411071.awb") ~= 0 then
					local var_40_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071009", "story_v_out_411071.awb") / 1000

					if var_40_7 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_1
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_411071", "411071009", "story_v_out_411071.awb")

						arg_37_1:RecordAudio("411071009", var_40_8)
						arg_37_1:RecordAudio("411071009", var_40_8)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_411071", "411071009", "story_v_out_411071.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_411071", "411071009", "story_v_out_411071.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_9 and arg_37_1.time_ < var_40_1 + var_40_9 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play411071010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 411071010
		arg_41_1.duration_ = 7.97

		local var_41_0 = {
			zh = 6.066,
			ja = 7.966
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
				arg_41_0:Play411071011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.775

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[677].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(411071010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 31 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 31)

				if (31 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 31)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071010", "story_v_out_411071.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071010", "story_v_out_411071.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_411071", "411071010", "story_v_out_411071.awb")

						arg_41_1:RecordAudio("411071010", var_44_6)
						arg_41_1:RecordAudio("411071010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_411071", "411071010", "story_v_out_411071.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_411071", "411071010", "story_v_out_411071.awb")
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
	Play411071011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 411071011
		arg_45_1.duration_ = 3.23

		local var_45_0 = {
			zh = 2.333,
			ja = 3.233
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
				arg_45_0:Play411071012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.225

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[677].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:GetWordFromCfg(411071011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 9 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 9)

				if (9 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 9)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071011", "story_v_out_411071.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071011", "story_v_out_411071.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_411071", "411071011", "story_v_out_411071.awb")

						arg_45_1:RecordAudio("411071011", var_48_6)
						arg_45_1:RecordAudio("411071011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_411071", "411071011", "story_v_out_411071.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_411071", "411071011", "story_v_out_411071.awb")
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
	Play411071012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 411071012
		arg_49_1.duration_ = 2.8

		local var_49_0 = {
			zh = 2.8,
			ja = 1.999999999999
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
				arg_49_0:Play411071013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) and arg_49_1.var_.characterEffect1095ui_story == nil then
				arg_49_1.var_.characterEffect1095ui_story = arg_49_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) then
				if arg_49_1.var_.characterEffect1095ui_story and not isNil(arg_49_1.actors_["1095ui_story"]) then
					arg_49_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1095ui_story"]) and arg_49_1.var_.characterEffect1095ui_story then
				arg_49_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action472")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_52_2 = 0
			local var_52_3 = 0.05

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(411071012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 2 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 2)

				if (2 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 2)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071012", "story_v_out_411071.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_411071", "411071012", "story_v_out_411071.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_411071", "411071012", "story_v_out_411071.awb")

						arg_49_1:RecordAudio("411071012", var_52_9)
						arg_49_1:RecordAudio("411071012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_411071", "411071012", "story_v_out_411071.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_411071", "411071012", "story_v_out_411071.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play411071013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 411071013
		arg_53_1.duration_ = 4

		local var_53_0 = {
			zh = 3.433,
			ja = 4
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
				arg_53_0:Play411071014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1095ui_story"]) and arg_53_1.var_.characterEffect1095ui_story == nil then
				arg_53_1.var_.characterEffect1095ui_story = arg_53_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1095ui_story"]) then
				if arg_53_1.var_.characterEffect1095ui_story and not isNil(arg_53_1.actors_["1095ui_story"]) then
					arg_53_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1095ui_story"]) and arg_53_1.var_.characterEffect1095ui_story then
				arg_53_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.35

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[677].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(411071013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 14 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 14)

				if (14 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 14)) > 0 and var_56_2 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071013", "story_v_out_411071.awb") ~= 0 then
					local var_56_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071013", "story_v_out_411071.awb") / 1000

					if var_56_7 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_1
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_411071", "411071013", "story_v_out_411071.awb")

						arg_53_1:RecordAudio("411071013", var_56_8)
						arg_53_1:RecordAudio("411071013", var_56_8)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_411071", "411071013", "story_v_out_411071.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_411071", "411071013", "story_v_out_411071.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_9 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_9 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_9

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_9 and arg_53_1.time_ < var_56_1 + var_56_9 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play411071014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 411071014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play411071015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_60_0 = 0
			local var_60_1 = 0.8

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(411071014).content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 32 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_2) / 32)

				if (32 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_2) / 32)) > 0 and var_60_1 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_5 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_5 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_5

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_5 and arg_57_1.time_ < var_60_0 + var_60_5 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play411071015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 411071015
		arg_61_1.duration_ = 2.37

		local var_61_0 = {
			zh = 1.066,
			ja = 2.366
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
				arg_61_0:Play411071016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.075

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[677].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(411071015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 3 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 3)

				if (3 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 3)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071015", "story_v_out_411071.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071015", "story_v_out_411071.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_411071", "411071015", "story_v_out_411071.awb")

						arg_61_1:RecordAudio("411071015", var_64_6)
						arg_61_1:RecordAudio("411071015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_411071", "411071015", "story_v_out_411071.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_411071", "411071015", "story_v_out_411071.awb")
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
	Play411071016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 411071016
		arg_65_1.duration_ = 4.1

		local var_65_0 = {
			zh = 3.8,
			ja = 4.1
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
				arg_65_0:Play411071017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1095ui_story"]) and arg_65_1.var_.characterEffect1095ui_story == nil then
				arg_65_1.var_.characterEffect1095ui_story = arg_65_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1095ui_story"]) then
				if arg_65_1.var_.characterEffect1095ui_story and not isNil(arg_65_1.actors_["1095ui_story"]) then
					arg_65_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1095ui_story"]) and arg_65_1.var_.characterEffect1095ui_story then
				arg_65_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_68_2 = 0
			local var_68_3 = 0.375

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_4 = arg_65_1:GetWordFromCfg(411071016)
				local var_68_5 = arg_65_1:FormatText(var_68_4.content)

				arg_65_1.text_.text = var_68_5

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_7 = 15 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 15)

				if (15 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_5) / 15)) > 0 and var_68_3 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_5
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071016", "story_v_out_411071.awb") ~= 0 then
					local var_68_8 = manager.audio:GetVoiceLength("story_v_out_411071", "411071016", "story_v_out_411071.awb") / 1000

					if var_68_8 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_2
					end

					if var_68_4.prefab_name ~= "" and arg_65_1.actors_[var_68_4.prefab_name] ~= nil then
						local var_68_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_4.prefab_name].transform, "story_v_out_411071", "411071016", "story_v_out_411071.awb")

						arg_65_1:RecordAudio("411071016", var_68_9)
						arg_65_1:RecordAudio("411071016", var_68_9)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_411071", "411071016", "story_v_out_411071.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_411071", "411071016", "story_v_out_411071.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_10 and arg_65_1.time_ < var_68_2 + var_68_10 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play411071017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 411071017
		arg_69_1.duration_ = 12

		local var_69_0 = {
			zh = 9.9,
			ja = 12
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
				arg_69_0:Play411071018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_72_0 = 0
			local var_72_1 = 0.925

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(411071017)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 37 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 37)

				if (37 <= 0 and var_72_1 or var_72_1 * (utf8.len(var_72_3) / 37)) > 0 and var_72_1 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071017", "story_v_out_411071.awb") ~= 0 then
					local var_72_6 = manager.audio:GetVoiceLength("story_v_out_411071", "411071017", "story_v_out_411071.awb") / 1000

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end

					if var_72_2.prefab_name ~= "" and arg_69_1.actors_[var_72_2.prefab_name] ~= nil then
						local var_72_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_2.prefab_name].transform, "story_v_out_411071", "411071017", "story_v_out_411071.awb")

						arg_69_1:RecordAudio("411071017", var_72_7)
						arg_69_1:RecordAudio("411071017", var_72_7)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_411071", "411071017", "story_v_out_411071.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_411071", "411071017", "story_v_out_411071.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_8 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_8 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_8

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_8 and arg_69_1.time_ < var_72_0 + var_72_8 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play411071018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 411071018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play411071019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1095ui_story"]) and arg_73_1.var_.characterEffect1095ui_story == nil then
				arg_73_1.var_.characterEffect1095ui_story = arg_73_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1095ui_story"]) then
				if arg_73_1.var_.characterEffect1095ui_story and not isNil(arg_73_1.actors_["1095ui_story"]) then
					arg_73_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1095ui_story"]) and arg_73_1.var_.characterEffect1095ui_story then
				arg_73_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.6

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(411071018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 24 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 24)

				if (24 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 24)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play411071019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 411071019
		arg_77_1.duration_ = 3.4

		local var_77_0 = {
			zh = 3.4,
			ja = 2.133
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
				arg_77_0:Play411071020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1095ui_story"]) and arg_77_1.var_.characterEffect1095ui_story == nil then
				arg_77_1.var_.characterEffect1095ui_story = arg_77_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1095ui_story"]) then
				if arg_77_1.var_.characterEffect1095ui_story and not isNil(arg_77_1.actors_["1095ui_story"]) then
					arg_77_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1095ui_story"]) and arg_77_1.var_.characterEffect1095ui_story then
				arg_77_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_80_2 = 0
			local var_80_3 = 0.4

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:GetWordFromCfg(411071019)
				local var_80_5 = arg_77_1:FormatText(var_80_4.content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 16 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 16)

				if (16 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_5) / 16)) > 0 and var_80_3 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071019", "story_v_out_411071.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_411071", "411071019", "story_v_out_411071.awb") / 1000

					if var_80_8 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_2
					end

					if var_80_4.prefab_name ~= "" and arg_77_1.actors_[var_80_4.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_4.prefab_name].transform, "story_v_out_411071", "411071019", "story_v_out_411071.awb")

						arg_77_1:RecordAudio("411071019", var_80_9)
						arg_77_1:RecordAudio("411071019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_411071", "411071019", "story_v_out_411071.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_411071", "411071019", "story_v_out_411071.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_10 and arg_77_1.time_ < var_80_2 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play411071020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 411071020
		arg_81_1.duration_ = 8

		local var_81_0 = {
			zh = 5.5,
			ja = 8
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
				arg_81_0:Play411071021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.6

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(411071020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 24 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 24)

				if (24 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 24)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071020", "story_v_out_411071.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071020", "story_v_out_411071.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_411071", "411071020", "story_v_out_411071.awb")

						arg_81_1:RecordAudio("411071020", var_84_6)
						arg_81_1:RecordAudio("411071020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_411071", "411071020", "story_v_out_411071.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_411071", "411071020", "story_v_out_411071.awb")
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
	Play411071021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 411071021
		arg_85_1.duration_ = 2.57

		local var_85_0 = {
			zh = 1.833,
			ja = 2.566
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
				arg_85_0:Play411071022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) and arg_85_1.var_.characterEffect1095ui_story == nil then
				arg_85_1.var_.characterEffect1095ui_story = arg_85_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) then
				if arg_85_1.var_.characterEffect1095ui_story and not isNil(arg_85_1.actors_["1095ui_story"]) then
					arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) and arg_85_1.var_.characterEffect1095ui_story then
				arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.15

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(411071021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 6 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 6)

				if (6 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 6)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071021", "story_v_out_411071.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071021", "story_v_out_411071.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_411071", "411071021", "story_v_out_411071.awb")

						arg_85_1:RecordAudio("411071021", var_88_8)
						arg_85_1:RecordAudio("411071021", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_411071", "411071021", "story_v_out_411071.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_411071", "411071021", "story_v_out_411071.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_9 and arg_85_1.time_ < var_88_1 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play411071022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 411071022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play411071023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1095ui_story = arg_89_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1095ui_story"].transform.position).z)
				arg_89_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1095ui_story"].transform.localEulerAngles = arg_89_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_89_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1095ui_story"].transform.position).z)
				arg_89_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1095ui_story"].transform.localEulerAngles = arg_89_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_92_1 = 0
			local var_92_2 = 0.75

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

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(411071022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 30 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 30)

				if (30 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 30)) > 0 and var_92_2 < var_92_5 then
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

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play411071023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 411071023
		arg_93_1.duration_ = 8.8

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play411071024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 2 < arg_93_1.time_ and arg_93_1.time_ <= 2 + arg_96_0 then
				local var_96_0 = arg_93_1.bgs_.B03b

				arg_93_1.bgs_.B03b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_96_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_1 = var_96_0:GetComponent("SpriteRenderer")

				if var_96_1 and var_96_1.sprite then
					local var_96_2 = 2 * (var_96_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_96_0.transform.localScale = Vector3.New(var_96_2 / var_96_1.sprite.bounds.size.y < var_96_2 * manager.ui.mainCameraCom_.aspect / var_96_1.sprite.bounds.size.x and var_96_2 * manager.ui.mainCameraCom_.aspect / var_96_1.sprite.bounds.size.x or var_96_2 / var_96_1.sprite.bounds.size.y, var_96_2 / var_96_1.sprite.bounds.size.y < var_96_2 * manager.ui.mainCameraCom_.aspect / var_96_1.sprite.bounds.size.x and var_96_2 * manager.ui.mainCameraCom_.aspect / var_96_1.sprite.bounds.size.x or var_96_2 / var_96_1.sprite.bounds.size.y, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "B03b" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_3 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_3 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_4 = 2

			if var_96_3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_3 + var_96_4 then
				local var_96_5 = Color.New(0, 0, 0)

				var_96_5.a = Mathf.Lerp(0, 1, (arg_93_1.time_ - var_96_3) / var_96_4)
				arg_93_1.mask_.color = var_96_5
			end

			if arg_93_1.time_ >= var_96_3 + var_96_4 and arg_93_1.time_ < var_96_3 + var_96_4 + arg_96_0 then
				local var_96_6 = Color.New(0, 0, 0)

				var_96_6.a = 1
				arg_93_1.mask_.color = var_96_6
			end

			local var_96_7 = 2

			if 2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_7 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_8 = 2

			if var_96_7 <= arg_93_1.time_ and arg_93_1.time_ < var_96_7 + var_96_8 then
				local var_96_9 = Color.New(0, 0, 0)

				var_96_9.a = Mathf.Lerp(1, 0, (arg_93_1.time_ - var_96_7) / var_96_8)
				arg_93_1.mask_.color = var_96_9
			end

			if arg_93_1.time_ >= var_96_7 + var_96_8 and arg_93_1.time_ < var_96_7 + var_96_8 + arg_96_0 then
				local var_96_10 = Color.New(0, 0, 0)

				arg_93_1.mask_.enabled = false
				var_96_10.a = 0
				arg_93_1.mask_.color = var_96_10
			end

			local var_96_11 = arg_93_1.actors_["1095ui_story"].transform

			if 1.96599999815226 < arg_93_1.time_ and arg_93_1.time_ <= 1.96599999815226 + arg_96_0 then
				arg_93_1.var_.moveOldPos1095ui_story = var_96_11.localPosition
			end

			local var_96_12 = 0.001

			if 1.96599999815226 <= arg_93_1.time_ and arg_93_1.time_ < 1.96599999815226 + var_96_12 then
				var_96_11.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 1.96599999815226) / var_96_12)
				var_96_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_11.position).x, (manager.ui.mainCamera.transform.position - var_96_11.position).y, (manager.ui.mainCamera.transform.position - var_96_11.position).z)
				var_96_11.localEulerAngles.z = 0
				var_96_11.localEulerAngles.x = 0
				var_96_11.localEulerAngles = var_96_11.localEulerAngles
			end

			if arg_93_1.time_ >= 1.96599999815226 + var_96_12 and arg_93_1.time_ < 1.96599999815226 + var_96_12 + arg_96_0 then
				var_96_11.localPosition = Vector3.New(0, 100, 0)
				var_96_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_11.position).x, (manager.ui.mainCamera.transform.position - var_96_11.position).y, (manager.ui.mainCamera.transform.position - var_96_11.position).z)
				var_96_11.localEulerAngles.z = 0
				var_96_11.localEulerAngles.x = 0
				var_96_11.localEulerAngles = var_96_11.localEulerAngles
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_13 = 3.8
			local var_96_14 = 0.75

			if 3.8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_13 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_15 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_15:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_16 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(411071023).content)

				arg_93_1.text_.text = var_96_16

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_18 = 30 <= 0 and var_96_14 or var_96_14 * (utf8.len(var_96_16) / 30)

				if (30 <= 0 and var_96_14 or var_96_14 * (utf8.len(var_96_16) / 30)) > 0 and var_96_14 < var_96_18 then
					arg_93_1.talkMaxDuration = var_96_18
					var_96_13 = var_96_13 + 0.3

					if var_96_18 + var_96_13 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_13
					end
				end

				arg_93_1.text_.text = var_96_16
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_19 = var_96_13 + 0.3
			local var_96_20 = math.max(var_96_14, arg_93_1.talkMaxDuration)

			if var_96_13 + 0.3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_19 + var_96_20 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_19) / var_96_20

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_19 + var_96_20 and arg_93_1.time_ < var_96_19 + var_96_20 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play411071024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 411071024
		arg_99_1.duration_ = 2.53

		local var_99_0 = {
			zh = 2.033,
			ja = 2.533
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play411071025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1095ui_story"]) and arg_99_1.var_.characterEffect1095ui_story == nil then
				arg_99_1.var_.characterEffect1095ui_story = arg_99_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1095ui_story"]) then
				if arg_99_1.var_.characterEffect1095ui_story and not isNil(arg_99_1.actors_["1095ui_story"]) then
					arg_99_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1095ui_story"]) and arg_99_1.var_.characterEffect1095ui_story then
				arg_99_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_102_2 = arg_99_1.actors_["1095ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1095ui_story = var_102_2.localPosition
			end

			local var_102_3 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_3 then
				var_102_2.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_99_1.time_ - 0) / var_102_3)
				var_102_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_2.position).x, (manager.ui.mainCamera.transform.position - var_102_2.position).y, (manager.ui.mainCamera.transform.position - var_102_2.position).z)
				var_102_2.localEulerAngles.z = 0
				var_102_2.localEulerAngles.x = 0
				var_102_2.localEulerAngles = var_102_2.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_3 and arg_99_1.time_ < 0 + var_102_3 + arg_102_0 then
				var_102_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_102_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_2.position).x, (manager.ui.mainCamera.transform.position - var_102_2.position).y, (manager.ui.mainCamera.transform.position - var_102_2.position).z)
				var_102_2.localEulerAngles.z = 0
				var_102_2.localEulerAngles.x = 0
				var_102_2.localEulerAngles = var_102_2.localEulerAngles
			end

			local var_102_4 = 0
			local var_102_5 = 0.25

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_4 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_6 = arg_99_1:GetWordFromCfg(411071024)
				local var_102_7 = arg_99_1:FormatText(var_102_6.content)

				arg_99_1.text_.text = var_102_7

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_9 = 10 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 10)

				if (10 <= 0 and var_102_5 or var_102_5 * (utf8.len(var_102_7) / 10)) > 0 and var_102_5 < var_102_9 then
					arg_99_1.talkMaxDuration = var_102_9

					if var_102_9 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_9 + var_102_4
					end
				end

				arg_99_1.text_.text = var_102_7
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071024", "story_v_out_411071.awb") ~= 0 then
					local var_102_10 = manager.audio:GetVoiceLength("story_v_out_411071", "411071024", "story_v_out_411071.awb") / 1000

					if var_102_10 + var_102_4 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_4
					end

					if var_102_6.prefab_name ~= "" and arg_99_1.actors_[var_102_6.prefab_name] ~= nil then
						local var_102_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_6.prefab_name].transform, "story_v_out_411071", "411071024", "story_v_out_411071.awb")

						arg_99_1:RecordAudio("411071024", var_102_11)
						arg_99_1:RecordAudio("411071024", var_102_11)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_411071", "411071024", "story_v_out_411071.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_411071", "411071024", "story_v_out_411071.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_12 = math.max(var_102_5, arg_99_1.talkMaxDuration)

			if var_102_4 <= arg_99_1.time_ and arg_99_1.time_ < var_102_4 + var_102_12 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_4) / var_102_12

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_4 + var_102_12 and arg_99_1.time_ < var_102_4 + var_102_12 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411071025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 411071025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play411071026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1095ui_story"]) and arg_103_1.var_.characterEffect1095ui_story == nil then
				arg_103_1.var_.characterEffect1095ui_story = arg_103_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1095ui_story"]) then
				if arg_103_1.var_.characterEffect1095ui_story and not isNil(arg_103_1.actors_["1095ui_story"]) then
					arg_103_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_0)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1095ui_story"]) and arg_103_1.var_.characterEffect1095ui_story then
				arg_103_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_106_1 = 0
			local var_106_2 = 1.4

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

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(411071025).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 56 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 56)

				if (56 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 56)) > 0 and var_106_2 < var_106_5 then
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
	Play411071026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 411071026
		arg_107_1.duration_ = 4

		local var_107_0 = {
			zh = 3.3,
			ja = 4
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
				arg_107_0:Play411071027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1095ui_story"]) and arg_107_1.var_.characterEffect1095ui_story == nil then
				arg_107_1.var_.characterEffect1095ui_story = arg_107_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1095ui_story"]) then
				if arg_107_1.var_.characterEffect1095ui_story and not isNil(arg_107_1.actors_["1095ui_story"]) then
					arg_107_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1095ui_story"]) and arg_107_1.var_.characterEffect1095ui_story then
				arg_107_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_110_2 = 0
			local var_110_3 = 0.425

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_4 = arg_107_1:GetWordFromCfg(411071026)
				local var_110_5 = arg_107_1:FormatText(var_110_4.content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 17 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 17)

				if (17 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 17)) > 0 and var_110_3 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_2
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071026", "story_v_out_411071.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_411071", "411071026", "story_v_out_411071.awb") / 1000

					if var_110_8 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_2
					end

					if var_110_4.prefab_name ~= "" and arg_107_1.actors_[var_110_4.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_4.prefab_name].transform, "story_v_out_411071", "411071026", "story_v_out_411071.awb")

						arg_107_1:RecordAudio("411071026", var_110_9)
						arg_107_1:RecordAudio("411071026", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_411071", "411071026", "story_v_out_411071.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_411071", "411071026", "story_v_out_411071.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_3, arg_107_1.talkMaxDuration)

			if var_110_2 <= arg_107_1.time_ and arg_107_1.time_ < var_110_2 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_2) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_2 + var_110_10 and arg_107_1.time_ < var_110_2 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play411071027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 411071027
		arg_111_1.duration_ = 5.83

		local var_111_0 = {
			zh = 3.833,
			ja = 5.833
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
				arg_111_0:Play411071028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1095ui_story"]) and arg_111_1.var_.characterEffect1095ui_story == nil then
				arg_111_1.var_.characterEffect1095ui_story = arg_111_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1095ui_story"]) then
				if arg_111_1.var_.characterEffect1095ui_story and not isNil(arg_111_1.actors_["1095ui_story"]) then
					arg_111_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1095ui_story"]) and arg_111_1.var_.characterEffect1095ui_story then
				arg_111_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 0.5

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:GetWordFromCfg(411071027)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_6 = 20 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_4) / 20)

				if (20 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_4) / 20)) > 0 and var_114_2 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071027", "story_v_out_411071.awb") ~= 0 then
					local var_114_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071027", "story_v_out_411071.awb") / 1000

					if var_114_7 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_1
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_out_411071", "411071027", "story_v_out_411071.awb")

						arg_111_1:RecordAudio("411071027", var_114_8)
						arg_111_1:RecordAudio("411071027", var_114_8)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_411071", "411071027", "story_v_out_411071.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_411071", "411071027", "story_v_out_411071.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_9 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_9 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_9

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_9 and arg_111_1.time_ < var_114_1 + var_114_9 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play411071028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 411071028
		arg_115_1.duration_ = 2.73

		local var_115_0 = {
			zh = 2.1,
			ja = 2.733
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
				arg_115_0:Play411071029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1095ui_story"]) and arg_115_1.var_.characterEffect1095ui_story == nil then
				arg_115_1.var_.characterEffect1095ui_story = arg_115_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1095ui_story"]) then
				if arg_115_1.var_.characterEffect1095ui_story and not isNil(arg_115_1.actors_["1095ui_story"]) then
					arg_115_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1095ui_story"]) and arg_115_1.var_.characterEffect1095ui_story then
				arg_115_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_118_2 = 0
			local var_118_3 = 0.275

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_4 = arg_115_1:GetWordFromCfg(411071028)
				local var_118_5 = arg_115_1:FormatText(var_118_4.content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 11 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 11)

				if (11 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 11)) > 0 and var_118_3 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071028", "story_v_out_411071.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_411071", "411071028", "story_v_out_411071.awb") / 1000

					if var_118_8 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_2
					end

					if var_118_4.prefab_name ~= "" and arg_115_1.actors_[var_118_4.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_4.prefab_name].transform, "story_v_out_411071", "411071028", "story_v_out_411071.awb")

						arg_115_1:RecordAudio("411071028", var_118_9)
						arg_115_1:RecordAudio("411071028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_411071", "411071028", "story_v_out_411071.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_411071", "411071028", "story_v_out_411071.awb")
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
	Play411071029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 411071029
		arg_119_1.duration_ = 17.4

		local var_119_0 = {
			zh = 10.166,
			ja = 17.4
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
				arg_119_0:Play411071030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["1095ui_story"]) and arg_119_1.var_.characterEffect1095ui_story == nil then
				arg_119_1.var_.characterEffect1095ui_story = arg_119_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_0 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["1095ui_story"]) then
				if arg_119_1.var_.characterEffect1095ui_story and not isNil(arg_119_1.actors_["1095ui_story"]) then
					arg_119_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_0)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["1095ui_story"]) and arg_119_1.var_.characterEffect1095ui_story then
				arg_119_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_122_1 = 0
			local var_122_2 = 1.3

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_3 = arg_119_1:GetWordFromCfg(411071029)
				local var_122_4 = arg_119_1:FormatText(var_122_3.content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_6 = 52 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_4) / 52)

				if (52 <= 0 and var_122_2 or var_122_2 * (utf8.len(var_122_4) / 52)) > 0 and var_122_2 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071029", "story_v_out_411071.awb") ~= 0 then
					local var_122_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071029", "story_v_out_411071.awb") / 1000

					if var_122_7 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_1
					end

					if var_122_3.prefab_name ~= "" and arg_119_1.actors_[var_122_3.prefab_name] ~= nil then
						local var_122_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_3.prefab_name].transform, "story_v_out_411071", "411071029", "story_v_out_411071.awb")

						arg_119_1:RecordAudio("411071029", var_122_8)
						arg_119_1:RecordAudio("411071029", var_122_8)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_411071", "411071029", "story_v_out_411071.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_411071", "411071029", "story_v_out_411071.awb")
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
	Play411071030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 411071030
		arg_123_1.duration_ = 6.23

		local var_123_0 = {
			zh = 5,
			ja = 6.233
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
				arg_123_0:Play411071031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.7

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_1 = arg_123_1:GetWordFromCfg(411071030)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 28 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 28)

				if (28 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 28)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071030", "story_v_out_411071.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071030", "story_v_out_411071.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_out_411071", "411071030", "story_v_out_411071.awb")

						arg_123_1:RecordAudio("411071030", var_126_6)
						arg_123_1:RecordAudio("411071030", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_411071", "411071030", "story_v_out_411071.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_411071", "411071030", "story_v_out_411071.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play411071031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 411071031
		arg_127_1.duration_ = 7

		local var_127_0 = {
			zh = 6,
			ja = 7
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
				arg_127_0:Play411071032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1095ui_story"]) and arg_127_1.var_.characterEffect1095ui_story == nil then
				arg_127_1.var_.characterEffect1095ui_story = arg_127_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1095ui_story"]) then
				if arg_127_1.var_.characterEffect1095ui_story and not isNil(arg_127_1.actors_["1095ui_story"]) then
					arg_127_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1095ui_story"]) and arg_127_1.var_.characterEffect1095ui_story then
				arg_127_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_2 = 0
			local var_130_3 = 0.775

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_4 = arg_127_1:GetWordFromCfg(411071031)
				local var_130_5 = arg_127_1:FormatText(var_130_4.content)

				arg_127_1.text_.text = var_130_5

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_7 = 31 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 31)

				if (31 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_5) / 31)) > 0 and var_130_3 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_2
					end
				end

				arg_127_1.text_.text = var_130_5
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071031", "story_v_out_411071.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_411071", "411071031", "story_v_out_411071.awb") / 1000

					if var_130_8 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_2
					end

					if var_130_4.prefab_name ~= "" and arg_127_1.actors_[var_130_4.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_4.prefab_name].transform, "story_v_out_411071", "411071031", "story_v_out_411071.awb")

						arg_127_1:RecordAudio("411071031", var_130_9)
						arg_127_1:RecordAudio("411071031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_411071", "411071031", "story_v_out_411071.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_411071", "411071031", "story_v_out_411071.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_3, arg_127_1.talkMaxDuration)

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_2) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_2 + var_130_10 and arg_127_1.time_ < var_130_2 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play411071032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 411071032
		arg_131_1.duration_ = 8

		local var_131_0 = {
			zh = 6.3,
			ja = 8
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
				arg_131_0:Play411071033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.85

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(411071032)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 34 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 34)

				if (34 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 34)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071032", "story_v_out_411071.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071032", "story_v_out_411071.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_411071", "411071032", "story_v_out_411071.awb")

						arg_131_1:RecordAudio("411071032", var_134_6)
						arg_131_1:RecordAudio("411071032", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_411071", "411071032", "story_v_out_411071.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_411071", "411071032", "story_v_out_411071.awb")
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
	Play411071033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 411071033
		arg_135_1.duration_ = 8.77

		local var_135_0 = {
			zh = 8,
			ja = 8.766
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
				arg_135_0:Play411071034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1095ui_story"]) and arg_135_1.var_.characterEffect1095ui_story == nil then
				arg_135_1.var_.characterEffect1095ui_story = arg_135_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1095ui_story"]) then
				if arg_135_1.var_.characterEffect1095ui_story and not isNil(arg_135_1.actors_["1095ui_story"]) then
					arg_135_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1095ui_story"]) and arg_135_1.var_.characterEffect1095ui_story then
				arg_135_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_138_1 = 0
			local var_138_2 = 0.95

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:GetWordFromCfg(411071033)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_6 = 38 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_4) / 38)

				if (38 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_4) / 38)) > 0 and var_138_2 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071033", "story_v_out_411071.awb") ~= 0 then
					local var_138_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071033", "story_v_out_411071.awb") / 1000

					if var_138_7 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_1
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_411071", "411071033", "story_v_out_411071.awb")

						arg_135_1:RecordAudio("411071033", var_138_8)
						arg_135_1:RecordAudio("411071033", var_138_8)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_411071", "411071033", "story_v_out_411071.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_411071", "411071033", "story_v_out_411071.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_9 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_9 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_9

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_9 and arg_135_1.time_ < var_138_1 + var_138_9 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play411071034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 411071034
		arg_139_1.duration_ = 10.67

		local var_139_0 = {
			zh = 6.266,
			ja = 10.666
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
				arg_139_0:Play411071035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.875

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:GetWordFromCfg(411071034)
				local var_142_2 = arg_139_1:FormatText(var_142_1.content)

				arg_139_1.text_.text = var_142_2

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 35 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 35)

				if (35 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 35)) > 0 and var_142_0 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end

				arg_139_1.text_.text = var_142_2
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071034", "story_v_out_411071.awb") ~= 0 then
					local var_142_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071034", "story_v_out_411071.awb") / 1000

					if var_142_5 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + 0
					end

					if var_142_1.prefab_name ~= "" and arg_139_1.actors_[var_142_1.prefab_name] ~= nil then
						local var_142_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_1.prefab_name].transform, "story_v_out_411071", "411071034", "story_v_out_411071.awb")

						arg_139_1:RecordAudio("411071034", var_142_6)
						arg_139_1:RecordAudio("411071034", var_142_6)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_411071", "411071034", "story_v_out_411071.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_411071", "411071034", "story_v_out_411071.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play411071035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 411071035
		arg_143_1.duration_ = 7.33

		local var_143_0 = {
			zh = 6.5,
			ja = 7.333
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
				arg_143_0:Play411071036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.775

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_1 = arg_143_1:GetWordFromCfg(411071035)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 31 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 31)

				if (31 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 31)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071035", "story_v_out_411071.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071035", "story_v_out_411071.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_411071", "411071035", "story_v_out_411071.awb")

						arg_143_1:RecordAudio("411071035", var_146_6)
						arg_143_1:RecordAudio("411071035", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_411071", "411071035", "story_v_out_411071.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_411071", "411071035", "story_v_out_411071.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play411071036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 411071036
		arg_147_1.duration_ = 11.6

		local var_147_0 = {
			zh = 7.833,
			ja = 11.6
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
				arg_147_0:Play411071037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1095ui_story"]) and arg_147_1.var_.characterEffect1095ui_story == nil then
				arg_147_1.var_.characterEffect1095ui_story = arg_147_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1095ui_story"]) then
				if arg_147_1.var_.characterEffect1095ui_story and not isNil(arg_147_1.actors_["1095ui_story"]) then
					arg_147_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1095ui_story"]) and arg_147_1.var_.characterEffect1095ui_story then
				arg_147_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_150_2 = 0
			local var_150_3 = 0.825

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:GetWordFromCfg(411071036)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 33 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 33)

				if (33 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 33)) > 0 and var_150_3 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_2
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071036", "story_v_out_411071.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_411071", "411071036", "story_v_out_411071.awb") / 1000

					if var_150_8 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_2
					end

					if var_150_4.prefab_name ~= "" and arg_147_1.actors_[var_150_4.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_4.prefab_name].transform, "story_v_out_411071", "411071036", "story_v_out_411071.awb")

						arg_147_1:RecordAudio("411071036", var_150_9)
						arg_147_1:RecordAudio("411071036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_411071", "411071036", "story_v_out_411071.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_411071", "411071036", "story_v_out_411071.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_3, arg_147_1.talkMaxDuration)

			if var_150_2 <= arg_147_1.time_ and arg_147_1.time_ < var_150_2 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_2) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_2 + var_150_10 and arg_147_1.time_ < var_150_2 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play411071037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 411071037
		arg_151_1.duration_ = 8.2

		local var_151_0 = {
			zh = 8.2,
			ja = 7.7
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
				arg_151_0:Play411071038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 1

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(411071037)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 40 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 40)

				if (40 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 40)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071037", "story_v_out_411071.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071037", "story_v_out_411071.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_411071", "411071037", "story_v_out_411071.awb")

						arg_151_1:RecordAudio("411071037", var_154_6)
						arg_151_1:RecordAudio("411071037", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_411071", "411071037", "story_v_out_411071.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_411071", "411071037", "story_v_out_411071.awb")
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
	Play411071038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 411071038
		arg_155_1.duration_ = 2.83

		local var_155_0 = {
			zh = 1.1,
			ja = 2.833
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
				arg_155_0:Play411071039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1095ui_story"]) and arg_155_1.var_.characterEffect1095ui_story == nil then
				arg_155_1.var_.characterEffect1095ui_story = arg_155_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1095ui_story"]) then
				if arg_155_1.var_.characterEffect1095ui_story and not isNil(arg_155_1.actors_["1095ui_story"]) then
					arg_155_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1095ui_story"]) and arg_155_1.var_.characterEffect1095ui_story then
				arg_155_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_158_1 = 0
			local var_158_2 = 0.075

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(411071038)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_6 = 3 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_4) / 3)

				if (3 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_4) / 3)) > 0 and var_158_2 < var_158_6 then
					arg_155_1.talkMaxDuration = var_158_6

					if var_158_6 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071038", "story_v_out_411071.awb") ~= 0 then
					local var_158_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071038", "story_v_out_411071.awb") / 1000

					if var_158_7 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_1
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_411071", "411071038", "story_v_out_411071.awb")

						arg_155_1:RecordAudio("411071038", var_158_8)
						arg_155_1:RecordAudio("411071038", var_158_8)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_411071", "411071038", "story_v_out_411071.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_411071", "411071038", "story_v_out_411071.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_9 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_9 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_9

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_9 and arg_155_1.time_ < var_158_1 + var_158_9 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play411071039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 411071039
		arg_159_1.duration_ = 6.7

		local var_159_0 = {
			zh = 5.5,
			ja = 6.7
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
				arg_159_0:Play411071040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1095ui_story"]) and arg_159_1.var_.characterEffect1095ui_story == nil then
				arg_159_1.var_.characterEffect1095ui_story = arg_159_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1095ui_story"]) then
				if arg_159_1.var_.characterEffect1095ui_story and not isNil(arg_159_1.actors_["1095ui_story"]) then
					arg_159_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1095ui_story"]) and arg_159_1.var_.characterEffect1095ui_story then
				arg_159_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_162_2 = 0
			local var_162_3 = 0.625

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:GetWordFromCfg(411071039)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 25 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 25)

				if (25 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 25)) > 0 and var_162_3 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071039", "story_v_out_411071.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_411071", "411071039", "story_v_out_411071.awb") / 1000

					if var_162_8 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_2
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_out_411071", "411071039", "story_v_out_411071.awb")

						arg_159_1:RecordAudio("411071039", var_162_9)
						arg_159_1:RecordAudio("411071039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_411071", "411071039", "story_v_out_411071.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_411071", "411071039", "story_v_out_411071.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_10 and arg_159_1.time_ < var_162_2 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play411071040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 411071040
		arg_163_1.duration_ = 6.2

		local var_163_0 = {
			zh = 4.866,
			ja = 6.2
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
				arg_163_0:Play411071041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1095ui_story"]) and arg_163_1.var_.characterEffect1095ui_story == nil then
				arg_163_1.var_.characterEffect1095ui_story = arg_163_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1095ui_story"]) then
				if arg_163_1.var_.characterEffect1095ui_story and not isNil(arg_163_1.actors_["1095ui_story"]) then
					arg_163_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1095ui_story"]) and arg_163_1.var_.characterEffect1095ui_story then
				arg_163_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 0.55

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:GetWordFromCfg(411071040)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_6 = 22 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_4) / 22)

				if (22 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_4) / 22)) > 0 and var_166_2 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071040", "story_v_out_411071.awb") ~= 0 then
					local var_166_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071040", "story_v_out_411071.awb") / 1000

					if var_166_7 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_1
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_411071", "411071040", "story_v_out_411071.awb")

						arg_163_1:RecordAudio("411071040", var_166_8)
						arg_163_1:RecordAudio("411071040", var_166_8)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_411071", "411071040", "story_v_out_411071.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_411071", "411071040", "story_v_out_411071.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_9 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_9 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_9

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_9 and arg_163_1.time_ < var_166_1 + var_166_9 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play411071041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 411071041
		arg_167_1.duration_ = 9.23

		local var_167_0 = {
			zh = 7.3,
			ja = 9.233
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
				arg_167_0:Play411071042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1095ui_story = arg_167_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1095ui_story"].transform.position).z)
				arg_167_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1095ui_story"].transform.localEulerAngles = arg_167_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_167_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1095ui_story"].transform.position).z)
				arg_167_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1095ui_story"].transform.localEulerAngles = arg_167_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1095ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1095ui_story == nil then
				arg_167_1.var_.characterEffect1095ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1095ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1095ui_story then
				arg_167_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_4 = 0
			local var_170_5 = 0.8

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(411071041)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 32 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 32)

				if (32 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 32)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071041", "story_v_out_411071.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_411071", "411071041", "story_v_out_411071.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_411071", "411071041", "story_v_out_411071.awb")

						arg_167_1:RecordAudio("411071041", var_170_11)
						arg_167_1:RecordAudio("411071041", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_411071", "411071041", "story_v_out_411071.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_411071", "411071041", "story_v_out_411071.awb")
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
				actorName = "1095ui_story",
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
	Play411071042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411071042
		arg_171_1.duration_ = 6.73

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play411071043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_9000

			if arg_171_1.bgs_.B03c == nil then
				local var_174_0 = Object.Instantiate(arg_171_1.paintGo_)

				var_174_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B03c")
				var_174_0.name = "B03c"
				var_174_0.transform.parent = arg_171_1.stage_.transform
				var_174_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.bgs_.B03c = var_174_0
			end

			if 0.5 < arg_171_1.time_ and arg_171_1.time_ <= 0.5 + arg_174_0 then
				local var_174_1 = arg_171_1.bgs_.B03c

				arg_171_1.bgs_.B03c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_174_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_2 = var_174_1:GetComponent("SpriteRenderer")

				if var_174_2 and var_174_2.sprite then
					local var_174_3 = 2 * (var_174_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_174_1.transform.localScale = Vector3.New(var_174_3 / var_174_2.sprite.bounds.size.y < var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x and var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x or var_174_3 / var_174_2.sprite.bounds.size.y, var_174_3 / var_174_2.sprite.bounds.size.y < var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x and var_174_3 * manager.ui.mainCameraCom_.aspect / var_174_2.sprite.bounds.size.x or var_174_3 / var_174_2.sprite.bounds.size.y, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "B03c" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_4 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_5 = 0.5

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_5 then
				local var_174_6 = Color.New(0.9622642, 0.004538993, 0.004538993)

				var_174_6.a = Mathf.Lerp(0, 1, (arg_171_1.time_ - var_174_4) / var_174_5)
				arg_171_1.mask_.color = var_174_6
			end

			if arg_171_1.time_ >= var_174_4 + var_174_5 and arg_171_1.time_ < var_174_4 + var_174_5 + arg_174_0 then
				local var_174_7 = Color.New(0.9622642, 0.004538993, 0.004538993)

				var_174_7.a = 1
				arg_171_1.mask_.color = var_174_7
			end

			local var_174_8 = 0.5

			if 0.5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_9 = 1.23333333333333

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_9 then
				local var_174_10 = Color.New(0.9622642, 0.004538993, 0.004538993)

				var_174_10.a = Mathf.Lerp(1, 0, (arg_171_1.time_ - var_174_8) / var_174_9)
				arg_171_1.mask_.color = var_174_10
			end

			if arg_171_1.time_ >= var_174_8 + var_174_9 and arg_171_1.time_ < var_174_8 + var_174_9 + arg_174_0 then
				local var_174_11 = Color.New(0.9622642, 0.004538993, 0.004538993)

				arg_171_1.mask_.enabled = false
				var_174_11.a = 0
				arg_171_1.mask_.color = var_174_11
			end

			local var_174_12 = arg_171_1.actors_["1095ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_12) and arg_171_1.var_.characterEffect1095ui_story == nil then
				arg_171_1.var_.characterEffect1095ui_story = var_174_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_13 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_13 and not isNil(var_174_12) then
				if arg_171_1.var_.characterEffect1095ui_story and not isNil(var_174_12) then
					arg_171_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_13)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_13 and arg_171_1.time_ < 0 + var_174_13 + arg_174_0 and not isNil(var_174_12) and arg_171_1.var_.characterEffect1095ui_story then
				arg_171_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_174_14 = arg_171_1.actors_["1095ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1095ui_story = var_174_14.localPosition
			end

			local var_174_15 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_15 then
				var_174_14.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_15)
				var_174_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_14.position).x, (manager.ui.mainCamera.transform.position - var_174_14.position).y, (manager.ui.mainCamera.transform.position - var_174_14.position).z)
				var_174_14.localEulerAngles.z = 0
				var_174_14.localEulerAngles.x = 0
				var_174_14.localEulerAngles = var_174_14.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_15 and arg_171_1.time_ < 0 + var_174_15 + arg_174_0 then
				var_174_14.localPosition = Vector3.New(0, 100, 0)
				var_174_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_14.position).x, (manager.ui.mainCamera.transform.position - var_174_14.position).y, (manager.ui.mainCamera.transform.position - var_174_14.position).z)
				var_174_14.localEulerAngles.z = 0
				var_174_14.localEulerAngles.x = 0
				var_174_14.localEulerAngles = var_174_14.localEulerAngles
			end

			if 1.73333333333333 < arg_171_1.time_ and arg_171_1.time_ <= 1.73333333333333 + arg_174_0 then
				arg_171_1:AudioAction("play", "effect", "se_story", "se_story_alarmloop", "")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				local var_174_17 = arg_171_1.var_.effect网络警报

				if not arg_171_1.var_.effect网络警报 then
					var_174_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_174_17.name = "网络警报"
					arg_171_1.var_.effect网络警报 = var_174_17
				else
					var_174_17.transform:SetParent(var_174_9000)
				end

				var_174_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_174_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_171_1.time_ and arg_171_1.time_ <= 2 + arg_174_0 then
				if arg_171_1.var_.effect网络警报 then
					Object.Destroy(arg_171_1.var_.effect网络警报)

					arg_171_1.var_.effect网络警报 = nil
				end
			end

			local var_174_20 = "B03c_blur"

			if arg_171_1.bgs_.B03c_blur == nil then
				local var_174_21 = Object.Instantiate(arg_171_1.blurPaintGo_)

				var_174_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_174_20)
				var_174_21.name = var_174_20
				var_174_21.transform.parent = arg_171_1.stage_.transform
				var_174_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.bgs_[var_174_20] = var_174_21
			end

			local var_174_22 = 0
			local var_174_23 = arg_171_1.bgs_[var_174_20]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_22 + arg_174_0 then
				var_174_23.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_174_23.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_24 = var_174_23:GetComponent("SpriteRenderer")

				if var_174_24 and var_174_24.sprite then
					local var_174_25 = 2 * (var_174_23.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_174_23.transform.localScale = Vector3.New(var_174_25 / var_174_24.sprite.bounds.size.y < var_174_25 * manager.ui.mainCameraCom_.aspect / var_174_24.sprite.bounds.size.x and var_174_25 * manager.ui.mainCameraCom_.aspect / var_174_24.sprite.bounds.size.x or var_174_25 / var_174_24.sprite.bounds.size.y, var_174_25 / var_174_24.sprite.bounds.size.y < var_174_25 * manager.ui.mainCameraCom_.aspect / var_174_24.sprite.bounds.size.x and var_174_25 * manager.ui.mainCameraCom_.aspect / var_174_24.sprite.bounds.size.x or var_174_25 / var_174_24.sprite.bounds.size.y, 0)
				end
			end

			local var_174_26 = 2

			if var_174_22 <= arg_171_1.time_ and arg_171_1.time_ < var_174_22 + var_174_26 then
				local var_174_27 = Color.New(1, 1, 1)

				var_174_27.a = Mathf.Lerp(0, 1, (arg_171_1.time_ - var_174_22) / var_174_26)

				var_174_23:GetComponent("SpriteRenderer").material:SetColor("_Color", var_174_27)
			end

			local var_174_28 = 1.73333333333333

			if 1.73333333333333 < arg_171_1.time_ and arg_171_1.time_ <= var_174_28 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			if arg_171_1.time_ >= var_174_28 + 0.266666666666667 and arg_171_1.time_ < var_174_28 + 0.266666666666667 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_29 = 1.73333333333333
			local var_174_30 = 1.075

			if 1.73333333333333 < arg_171_1.time_ and arg_171_1.time_ <= var_174_29 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_31 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_31:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_32 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(411071042).content)

				arg_171_1.text_.text = var_174_32

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_34 = 43 <= 0 and var_174_30 or var_174_30 * (utf8.len(var_174_32) / 43)

				if (43 <= 0 and var_174_30 or var_174_30 * (utf8.len(var_174_32) / 43)) > 0 and var_174_30 < var_174_34 then
					arg_171_1.talkMaxDuration = var_174_34
					var_174_29 = var_174_29 + 0.3

					if var_174_34 + var_174_29 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_34 + var_174_29
					end
				end

				arg_171_1.text_.text = var_174_32
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_35 = var_174_29 + 0.3
			local var_174_36 = math.max(var_174_30, arg_171_1.talkMaxDuration)

			if var_174_29 + 0.3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_35 + var_174_36 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_35) / var_174_36

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_35 + var_174_36 and arg_171_1.time_ < var_174_35 + var_174_36 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411071043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 411071043
		arg_177_1.duration_ = 2.3

		local var_177_0 = {
			zh = 1.999999999999,
			ja = 2.3
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play411071044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1095ui_story = arg_177_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1095ui_story"].transform.position).z)
				arg_177_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1095ui_story"].transform.localEulerAngles = arg_177_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_177_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1095ui_story"].transform.position).z)
				arg_177_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1095ui_story"].transform.localEulerAngles = arg_177_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1095ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1095ui_story == nil then
				arg_177_1.var_.characterEffect1095ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1095ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1095ui_story then
				arg_177_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_180_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_177_1.bgmTxt_.text ~= var_180_6 and arg_177_1.bgmTxt_.text ~= "" then
						if arg_177_1.bgmTxt2_.text ~= "" then
							arg_177_1.bgmTxt_.text = arg_177_1.bgmTxt2_.text
						end

						arg_177_1.bgmTxt2_.text = var_180_6

						arg_177_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_177_1.bgmTxt_.text = var_180_6
						arg_177_1.bgmTxt2_.text = var_180_6
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

			local var_180_7 = 0
			local var_180_8 = 0.15

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_9 = arg_177_1:GetWordFromCfg(411071043)
				local var_180_10 = arg_177_1:FormatText(var_180_9.content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_12 = 6 <= 0 and var_180_8 or var_180_8 * (utf8.len(var_180_10) / 6)

				if (6 <= 0 and var_180_8 or var_180_8 * (utf8.len(var_180_10) / 6)) > 0 and var_180_8 < var_180_12 then
					arg_177_1.talkMaxDuration = var_180_12

					if var_180_12 + var_180_7 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_7
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071043", "story_v_out_411071.awb") ~= 0 then
					local var_180_13 = manager.audio:GetVoiceLength("story_v_out_411071", "411071043", "story_v_out_411071.awb") / 1000

					if var_180_13 + var_180_7 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_7
					end

					if var_180_9.prefab_name ~= "" and arg_177_1.actors_[var_180_9.prefab_name] ~= nil then
						local var_180_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_9.prefab_name].transform, "story_v_out_411071", "411071043", "story_v_out_411071.awb")

						arg_177_1:RecordAudio("411071043", var_180_14)
						arg_177_1:RecordAudio("411071043", var_180_14)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_411071", "411071043", "story_v_out_411071.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_411071", "411071043", "story_v_out_411071.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_15 = math.max(var_180_8, arg_177_1.talkMaxDuration)

			if var_180_7 <= arg_177_1.time_ and arg_177_1.time_ < var_180_7 + var_180_15 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_7) / var_180_15

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_7 + var_180_15 and arg_177_1.time_ < var_180_7 + var_180_15 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play411071044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 411071044
		arg_182_1.duration_ = 1.93

		local var_182_0 = {
			zh = 1.733,
			ja = 1.933
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play411071045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1095ui_story"]) and arg_182_1.var_.characterEffect1095ui_story == nil then
				arg_182_1.var_.characterEffect1095ui_story = arg_182_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1095ui_story"]) then
				if arg_182_1.var_.characterEffect1095ui_story and not isNil(arg_182_1.actors_["1095ui_story"]) then
					arg_182_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_0)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1095ui_story"]) and arg_182_1.var_.characterEffect1095ui_story then
				arg_182_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_185_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_182_1.bgmTxt_.text ~= var_185_3 and arg_182_1.bgmTxt_.text ~= "" then
						if arg_182_1.bgmTxt2_.text ~= "" then
							arg_182_1.bgmTxt_.text = arg_182_1.bgmTxt2_.text
						end

						arg_182_1.bgmTxt2_.text = var_185_3

						arg_182_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_182_1.bgmTxt_.text = var_185_3
						arg_182_1.bgmTxt2_.text = var_185_3
					end

					if arg_182_1.bgmTimer then
						arg_182_1.bgmTimer:Stop()

						arg_182_1.bgmTimer = nil
					end

					if arg_182_1.settingData.show_music_name == 1 then
						arg_182_1.musicController:SetSelectedState("show")
						arg_182_1.musicAnimator_:Play("open", 0, 0)

						if arg_182_1.settingData.music_time ~= 0 then
							arg_182_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_182_1.settingData.music_time), function()
								if arg_182_1 == nil or isNil(arg_182_1.bgmTxt_) then
									return
								end

								arg_182_1.musicController:SetSelectedState("hide")
								arg_182_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.133333333333333 < arg_182_1.time_ and arg_182_1.time_ <= 0.133333333333333 + arg_185_0 then
				arg_182_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_185_6 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_182_1.bgmTxt_.text ~= var_185_6 and arg_182_1.bgmTxt_.text ~= "" then
						if arg_182_1.bgmTxt2_.text ~= "" then
							arg_182_1.bgmTxt_.text = arg_182_1.bgmTxt2_.text
						end

						arg_182_1.bgmTxt2_.text = var_185_6

						arg_182_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_182_1.bgmTxt_.text = var_185_6
						arg_182_1.bgmTxt2_.text = var_185_6
					end

					if arg_182_1.bgmTimer then
						arg_182_1.bgmTimer:Stop()

						arg_182_1.bgmTimer = nil
					end

					if arg_182_1.settingData.show_music_name == 1 then
						arg_182_1.musicController:SetSelectedState("show")
						arg_182_1.musicAnimator_:Play("open", 0, 0)

						if arg_182_1.settingData.music_time ~= 0 then
							arg_182_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_182_1.settingData.music_time), function()
								if arg_182_1 == nil or isNil(arg_182_1.bgmTxt_) then
									return
								end

								arg_182_1.musicController:SetSelectedState("hide")
								arg_182_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_185_7 = 0
			local var_185_8 = 0.2

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_7 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_9 = arg_182_1:GetWordFromCfg(411071044)
				local var_185_10 = arg_182_1:FormatText(var_185_9.content)

				arg_182_1.text_.text = var_185_10

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_12 = 8 <= 0 and var_185_8 or var_185_8 * (utf8.len(var_185_10) / 8)

				if (8 <= 0 and var_185_8 or var_185_8 * (utf8.len(var_185_10) / 8)) > 0 and var_185_8 < var_185_12 then
					arg_182_1.talkMaxDuration = var_185_12

					if var_185_12 + var_185_7 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_12 + var_185_7
					end
				end

				arg_182_1.text_.text = var_185_10
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071044", "story_v_out_411071.awb") ~= 0 then
					local var_185_13 = manager.audio:GetVoiceLength("story_v_out_411071", "411071044", "story_v_out_411071.awb") / 1000

					if var_185_13 + var_185_7 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_13 + var_185_7
					end

					if var_185_9.prefab_name ~= "" and arg_182_1.actors_[var_185_9.prefab_name] ~= nil then
						local var_185_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_9.prefab_name].transform, "story_v_out_411071", "411071044", "story_v_out_411071.awb")

						arg_182_1:RecordAudio("411071044", var_185_14)
						arg_182_1:RecordAudio("411071044", var_185_14)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_411071", "411071044", "story_v_out_411071.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_411071", "411071044", "story_v_out_411071.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_15 = math.max(var_185_8, arg_182_1.talkMaxDuration)

			if var_185_7 <= arg_182_1.time_ and arg_182_1.time_ < var_185_7 + var_185_15 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_7) / var_185_15

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_7 + var_185_15 and arg_182_1.time_ < var_185_7 + var_185_15 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play411071045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 411071045
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play411071046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1095ui_story = arg_188_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_191_0 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 then
				arg_188_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_188_1.time_ - 0) / var_191_0)
				arg_188_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1095ui_story"].transform.position).z)
				arg_188_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1095ui_story"].transform.localEulerAngles = arg_188_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 then
				arg_188_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1095ui_story"].transform.position).z)
				arg_188_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1095ui_story"].transform.localEulerAngles = arg_188_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_191_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_188_1.bgmTxt_.text ~= var_191_3 and arg_188_1.bgmTxt_.text ~= "" then
						if arg_188_1.bgmTxt2_.text ~= "" then
							arg_188_1.bgmTxt_.text = arg_188_1.bgmTxt2_.text
						end

						arg_188_1.bgmTxt2_.text = var_191_3

						arg_188_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_188_1.bgmTxt_.text = var_191_3
						arg_188_1.bgmTxt2_.text = var_191_3
					end

					if arg_188_1.bgmTimer then
						arg_188_1.bgmTimer:Stop()

						arg_188_1.bgmTimer = nil
					end

					if arg_188_1.settingData.show_music_name == 1 then
						arg_188_1.musicController:SetSelectedState("show")
						arg_188_1.musicAnimator_:Play("open", 0, 0)

						if arg_188_1.settingData.music_time ~= 0 then
							arg_188_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_188_1.settingData.music_time), function()
								if arg_188_1 == nil or isNil(arg_188_1.bgmTxt_) then
									return
								end

								arg_188_1.musicController:SetSelectedState("hide")
								arg_188_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.1 < arg_188_1.time_ and arg_188_1.time_ <= 0.1 + arg_191_0 then
				arg_188_1:AudioAction("play", "music", "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground.awb")

				local var_191_6 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

				if "" ~= "" then
					if arg_188_1.bgmTxt_.text ~= var_191_6 and arg_188_1.bgmTxt_.text ~= "" then
						if arg_188_1.bgmTxt2_.text ~= "" then
							arg_188_1.bgmTxt_.text = arg_188_1.bgmTxt2_.text
						end

						arg_188_1.bgmTxt2_.text = var_191_6

						arg_188_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_188_1.bgmTxt_.text = var_191_6
						arg_188_1.bgmTxt2_.text = var_191_6
					end

					if arg_188_1.bgmTimer then
						arg_188_1.bgmTimer:Stop()

						arg_188_1.bgmTimer = nil
					end

					if arg_188_1.settingData.show_music_name == 1 then
						arg_188_1.musicController:SetSelectedState("show")
						arg_188_1.musicAnimator_:Play("open", 0, 0)

						if arg_188_1.settingData.music_time ~= 0 then
							arg_188_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_188_1.settingData.music_time), function()
								if arg_188_1 == nil or isNil(arg_188_1.bgmTxt_) then
									return
								end

								arg_188_1.musicController:SetSelectedState("hide")
								arg_188_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_191_7 = manager.ui.mainCamera.transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.shakeOldPos = var_191_7.localPosition
			end

			local var_191_8 = 1

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_8 then
				local var_191_9, var_191_10 = math.modf((arg_188_1.time_ - 0) / 0.066)

				var_191_7.localPosition = Vector3.New(var_191_10 * 0.13, var_191_10 * 0.13, var_191_10 * 0.13) + arg_188_1.var_.shakeOldPos
			end

			if arg_188_1.time_ >= 0 + var_191_8 and arg_188_1.time_ < 0 + var_191_8 + arg_191_0 then
				var_191_7.localPosition = arg_188_1.var_.shakeOldPos
			end

			local var_191_11 = 0

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_11 + arg_191_0 then
				arg_188_1.allBtn_.enabled = false
			end

			if arg_188_1.time_ >= var_191_11 + 1 and arg_188_1.time_ < var_191_11 + 1 + arg_191_0 then
				arg_188_1.allBtn_.enabled = true
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_whoosh", "")
			end

			local var_191_13 = 0
			local var_191_14 = 0.875

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_13 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_15 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(411071045).content)

				arg_188_1.text_.text = var_191_15

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_17 = 35 <= 0 and var_191_14 or var_191_14 * (utf8.len(var_191_15) / 35)

				if (35 <= 0 and var_191_14 or var_191_14 * (utf8.len(var_191_15) / 35)) > 0 and var_191_14 < var_191_17 then
					arg_188_1.talkMaxDuration = var_191_17

					if var_191_17 + var_191_13 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_17 + var_191_13
					end
				end

				arg_188_1.text_.text = var_191_15
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_18 = math.max(var_191_14, arg_188_1.talkMaxDuration)

			if var_191_13 <= arg_188_1.time_ and arg_188_1.time_ < var_191_13 + var_191_18 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_13) / var_191_18

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_13 + var_191_18 and arg_188_1.time_ < var_191_13 + var_191_18 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play411071046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 411071046
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play411071047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 1.5

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_1 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(411071046).content)

				arg_194_1.text_.text = var_197_1

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_3 = 60 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_1) / 60)

				if (60 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_1) / 60)) > 0 and var_197_0 < var_197_3 then
					arg_194_1.talkMaxDuration = var_197_3

					if var_197_3 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_3 + 0
					end
				end

				arg_194_1.text_.text = var_197_1
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_4 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_4 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_4

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_4 and arg_194_1.time_ < 0 + var_197_4 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play411071047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 411071047
		arg_198_1.duration_ = 3.17

		local var_198_0 = {
			zh = 3.166,
			ja = 3
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play411071048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1095ui_story"]) and arg_198_1.var_.characterEffect1095ui_story == nil then
				arg_198_1.var_.characterEffect1095ui_story = arg_198_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1095ui_story"]) then
				if arg_198_1.var_.characterEffect1095ui_story and not isNil(arg_198_1.actors_["1095ui_story"]) then
					arg_198_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1095ui_story"]) and arg_198_1.var_.characterEffect1095ui_story then
				arg_198_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_201_2 = arg_198_1.actors_["1095ui_story"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1095ui_story = var_201_2.localPosition
			end

			local var_201_3 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_3 then
				var_201_2.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_198_1.time_ - 0) / var_201_3)
				var_201_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_2.position).x, (manager.ui.mainCamera.transform.position - var_201_2.position).y, (manager.ui.mainCamera.transform.position - var_201_2.position).z)
				var_201_2.localEulerAngles.z = 0
				var_201_2.localEulerAngles.x = 0
				var_201_2.localEulerAngles = var_201_2.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_3 and arg_198_1.time_ < 0 + var_201_3 + arg_201_0 then
				var_201_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_201_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_2.position).x, (manager.ui.mainCamera.transform.position - var_201_2.position).y, (manager.ui.mainCamera.transform.position - var_201_2.position).z)
				var_201_2.localEulerAngles.z = 0
				var_201_2.localEulerAngles.x = 0
				var_201_2.localEulerAngles = var_201_2.localEulerAngles
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_201_4 = "B03c_blur"

			if arg_198_1.bgs_.B03c_blur == nil then
				local var_201_5 = Object.Instantiate(arg_198_1.blurPaintGo_)

				var_201_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_201_4)
				var_201_5.name = var_201_4
				var_201_5.transform.parent = arg_198_1.stage_.transform
				var_201_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_198_1.bgs_[var_201_4] = var_201_5
			end

			local var_201_6 = 0
			local var_201_7 = arg_198_1.bgs_[var_201_4]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_6 + arg_201_0 then
				var_201_7.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_201_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_201_8 = var_201_7:GetComponent("SpriteRenderer")

				if var_201_8 and var_201_8.sprite then
					local var_201_9 = 2 * (var_201_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_201_7.transform.localScale = Vector3.New(var_201_9 / var_201_8.sprite.bounds.size.y < var_201_9 * manager.ui.mainCameraCom_.aspect / var_201_8.sprite.bounds.size.x and var_201_9 * manager.ui.mainCameraCom_.aspect / var_201_8.sprite.bounds.size.x or var_201_9 / var_201_8.sprite.bounds.size.y, var_201_9 / var_201_8.sprite.bounds.size.y < var_201_9 * manager.ui.mainCameraCom_.aspect / var_201_8.sprite.bounds.size.x and var_201_9 * manager.ui.mainCameraCom_.aspect / var_201_8.sprite.bounds.size.x or var_201_9 / var_201_8.sprite.bounds.size.y, 0)
				end
			end

			local var_201_10 = 1

			if var_201_6 <= arg_198_1.time_ and arg_198_1.time_ < var_201_6 + var_201_10 then
				local var_201_11 = Color.New(1, 1, 1)

				var_201_11.a = Mathf.Lerp(1, 0, (arg_198_1.time_ - var_201_6) / var_201_10)

				var_201_7:GetComponent("SpriteRenderer").material:SetColor("_Color", var_201_11)
			end

			local var_201_12 = 0
			local var_201_13 = 0.35

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_12 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_14 = arg_198_1:GetWordFromCfg(411071047)
				local var_201_15 = arg_198_1:FormatText(var_201_14.content)

				arg_198_1.text_.text = var_201_15

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_17 = 14 <= 0 and var_201_13 or var_201_13 * (utf8.len(var_201_15) / 14)

				if (14 <= 0 and var_201_13 or var_201_13 * (utf8.len(var_201_15) / 14)) > 0 and var_201_13 < var_201_17 then
					arg_198_1.talkMaxDuration = var_201_17

					if var_201_17 + var_201_12 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_17 + var_201_12
					end
				end

				arg_198_1.text_.text = var_201_15
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071047", "story_v_out_411071.awb") ~= 0 then
					local var_201_18 = manager.audio:GetVoiceLength("story_v_out_411071", "411071047", "story_v_out_411071.awb") / 1000

					if var_201_18 + var_201_12 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_18 + var_201_12
					end

					if var_201_14.prefab_name ~= "" and arg_198_1.actors_[var_201_14.prefab_name] ~= nil then
						local var_201_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_14.prefab_name].transform, "story_v_out_411071", "411071047", "story_v_out_411071.awb")

						arg_198_1:RecordAudio("411071047", var_201_19)
						arg_198_1:RecordAudio("411071047", var_201_19)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_411071", "411071047", "story_v_out_411071.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_411071", "411071047", "story_v_out_411071.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_20 = math.max(var_201_13, arg_198_1.talkMaxDuration)

			if var_201_12 <= arg_198_1.time_ and arg_198_1.time_ < var_201_12 + var_201_20 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_12) / var_201_20

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_12 + var_201_20 and arg_198_1.time_ < var_201_12 + var_201_20 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play411071048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 411071048
		arg_202_1.duration_ = 4.37

		local var_202_0 = {
			zh = 3.066,
			ja = 4.366
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play411071049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1095ui_story"]) and arg_202_1.var_.characterEffect1095ui_story == nil then
				arg_202_1.var_.characterEffect1095ui_story = arg_202_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1095ui_story"]) then
				if arg_202_1.var_.characterEffect1095ui_story and not isNil(arg_202_1.actors_["1095ui_story"]) then
					arg_202_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1095ui_story"]) and arg_202_1.var_.characterEffect1095ui_story then
				arg_202_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_205_1 = 0
			local var_205_2 = 0.4

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_3 = arg_202_1:GetWordFromCfg(411071048)
				local var_205_4 = arg_202_1:FormatText(var_205_3.content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_6 = 16 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_4) / 16)

				if (16 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_4) / 16)) > 0 and var_205_2 < var_205_6 then
					arg_202_1.talkMaxDuration = var_205_6

					if var_205_6 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_6 + var_205_1
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071048", "story_v_out_411071.awb") ~= 0 then
					local var_205_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071048", "story_v_out_411071.awb") / 1000

					if var_205_7 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_1
					end

					if var_205_3.prefab_name ~= "" and arg_202_1.actors_[var_205_3.prefab_name] ~= nil then
						local var_205_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_3.prefab_name].transform, "story_v_out_411071", "411071048", "story_v_out_411071.awb")

						arg_202_1:RecordAudio("411071048", var_205_8)
						arg_202_1:RecordAudio("411071048", var_205_8)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_411071", "411071048", "story_v_out_411071.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_411071", "411071048", "story_v_out_411071.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_9 = math.max(var_205_2, arg_202_1.talkMaxDuration)

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_9 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_1) / var_205_9

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_1 + var_205_9 and arg_202_1.time_ < var_205_1 + var_205_9 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play411071049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 411071049
		arg_206_1.duration_ = 5.8

		local var_206_0 = {
			zh = 3.4,
			ja = 5.8
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play411071050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.5

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_1 = arg_206_1:GetWordFromCfg(411071049)
				local var_209_2 = arg_206_1:FormatText(var_209_1.content)

				arg_206_1.text_.text = var_209_2

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 20 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 20)

				if (20 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 20)) > 0 and var_209_0 < var_209_4 then
					arg_206_1.talkMaxDuration = var_209_4

					if var_209_4 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_4 + 0
					end
				end

				arg_206_1.text_.text = var_209_2
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071049", "story_v_out_411071.awb") ~= 0 then
					local var_209_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071049", "story_v_out_411071.awb") / 1000

					if var_209_5 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + 0
					end

					if var_209_1.prefab_name ~= "" and arg_206_1.actors_[var_209_1.prefab_name] ~= nil then
						local var_209_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_1.prefab_name].transform, "story_v_out_411071", "411071049", "story_v_out_411071.awb")

						arg_206_1:RecordAudio("411071049", var_209_6)
						arg_206_1:RecordAudio("411071049", var_209_6)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_411071", "411071049", "story_v_out_411071.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_411071", "411071049", "story_v_out_411071.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play411071050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 411071050
		arg_210_1.duration_ = 4.33

		local var_210_0 = {
			zh = 3.9,
			ja = 4.333
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play411071051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1095ui_story"]) and arg_210_1.var_.characterEffect1095ui_story == nil then
				arg_210_1.var_.characterEffect1095ui_story = arg_210_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1095ui_story"]) then
				if arg_210_1.var_.characterEffect1095ui_story and not isNil(arg_210_1.actors_["1095ui_story"]) then
					arg_210_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1095ui_story"]) and arg_210_1.var_.characterEffect1095ui_story then
				arg_210_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_213_2 = 0
			local var_213_3 = 0.45

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_4 = arg_210_1:GetWordFromCfg(411071050)
				local var_213_5 = arg_210_1:FormatText(var_213_4.content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_7 = 18 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 18)

				if (18 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 18)) > 0 and var_213_3 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_2
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071050", "story_v_out_411071.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_411071", "411071050", "story_v_out_411071.awb") / 1000

					if var_213_8 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_2
					end

					if var_213_4.prefab_name ~= "" and arg_210_1.actors_[var_213_4.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_4.prefab_name].transform, "story_v_out_411071", "411071050", "story_v_out_411071.awb")

						arg_210_1:RecordAudio("411071050", var_213_9)
						arg_210_1:RecordAudio("411071050", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_411071", "411071050", "story_v_out_411071.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_411071", "411071050", "story_v_out_411071.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_3, arg_210_1.talkMaxDuration)

			if var_213_2 <= arg_210_1.time_ and arg_210_1.time_ < var_213_2 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_2) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_2 + var_213_10 and arg_210_1.time_ < var_213_2 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play411071051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 411071051
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play411071052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1095ui_story"]) and arg_214_1.var_.characterEffect1095ui_story == nil then
				arg_214_1.var_.characterEffect1095ui_story = arg_214_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1095ui_story"]) then
				if arg_214_1.var_.characterEffect1095ui_story and not isNil(arg_214_1.actors_["1095ui_story"]) then
					arg_214_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1095ui_story"]) and arg_214_1.var_.characterEffect1095ui_story then
				arg_214_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:AudioAction("play", "effect", "se_story_131", "se_story_131__closedoor", "")
			end

			local var_217_2 = arg_214_1.actors_["1095ui_story"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1095ui_story = var_217_2.localPosition
			end

			local var_217_3 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_3 then
				var_217_2.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_214_1.time_ - 0) / var_217_3)
				var_217_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_2.position).x, (manager.ui.mainCamera.transform.position - var_217_2.position).y, (manager.ui.mainCamera.transform.position - var_217_2.position).z)
				var_217_2.localEulerAngles.z = 0
				var_217_2.localEulerAngles.x = 0
				var_217_2.localEulerAngles = var_217_2.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_3 and arg_214_1.time_ < 0 + var_217_3 + arg_217_0 then
				var_217_2.localPosition = Vector3.New(0, 100, 0)
				var_217_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_2.position).x, (manager.ui.mainCamera.transform.position - var_217_2.position).y, (manager.ui.mainCamera.transform.position - var_217_2.position).z)
				var_217_2.localEulerAngles.z = 0
				var_217_2.localEulerAngles.x = 0
				var_217_2.localEulerAngles = var_217_2.localEulerAngles
			end

			local var_217_4 = 0
			local var_217_5 = 0.525

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_6 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(411071051).content)

				arg_214_1.text_.text = var_217_6

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_8 = 21 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_6) / 21)

				if (21 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_6) / 21)) > 0 and var_217_5 < var_217_8 then
					arg_214_1.talkMaxDuration = var_217_8

					if var_217_8 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_4
					end
				end

				arg_214_1.text_.text = var_217_6
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_9 = math.max(var_217_5, arg_214_1.talkMaxDuration)

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_9 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_4) / var_217_9

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_4 + var_217_9 and arg_214_1.time_ < var_217_4 + var_217_9 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play411071052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 411071052
		arg_218_1.duration_ = 4.63

		local var_218_0 = {
			zh = 3.2,
			ja = 4.633
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play411071053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1095ui_story"]) and arg_218_1.var_.characterEffect1095ui_story == nil then
				arg_218_1.var_.characterEffect1095ui_story = arg_218_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1095ui_story"]) then
				if arg_218_1.var_.characterEffect1095ui_story and not isNil(arg_218_1.actors_["1095ui_story"]) then
					arg_218_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1095ui_story"]) and arg_218_1.var_.characterEffect1095ui_story then
				arg_218_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_221_2 = arg_218_1.actors_["1095ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1095ui_story = var_221_2.localPosition
			end

			local var_221_3 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 then
				var_221_2.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_218_1.time_ - 0) / var_221_3)
				var_221_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_2.position).x, (manager.ui.mainCamera.transform.position - var_221_2.position).y, (manager.ui.mainCamera.transform.position - var_221_2.position).z)
				var_221_2.localEulerAngles.z = 0
				var_221_2.localEulerAngles.x = 0
				var_221_2.localEulerAngles = var_221_2.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 then
				var_221_2.localPosition = Vector3.New(0, -0.98, -6.1)
				var_221_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_2.position).x, (manager.ui.mainCamera.transform.position - var_221_2.position).y, (manager.ui.mainCamera.transform.position - var_221_2.position).z)
				var_221_2.localEulerAngles.z = 0
				var_221_2.localEulerAngles.x = 0
				var_221_2.localEulerAngles = var_221_2.localEulerAngles
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_221_4 = 0
			local var_221_5 = 0.4

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(411071052)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 16 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 16)

				if (16 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 16)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071052", "story_v_out_411071.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_out_411071", "411071052", "story_v_out_411071.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_out_411071", "411071052", "story_v_out_411071.awb")

						arg_218_1:RecordAudio("411071052", var_221_11)
						arg_218_1:RecordAudio("411071052", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_411071", "411071052", "story_v_out_411071.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_411071", "411071052", "story_v_out_411071.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_5, arg_218_1.talkMaxDuration)

			if var_221_4 <= arg_218_1.time_ and arg_218_1.time_ < var_221_4 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_4) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_4 + var_221_12 and arg_218_1.time_ < var_221_4 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play411071053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 411071053
		arg_222_1.duration_ = 8.1

		local var_222_0 = {
			zh = 4.8,
			ja = 8.1
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play411071054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.5

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:GetWordFromCfg(411071053)
				local var_225_2 = arg_222_1:FormatText(var_225_1.content)

				arg_222_1.text_.text = var_225_2

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 20 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 20)

				if (20 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 20)) > 0 and var_225_0 < var_225_4 then
					arg_222_1.talkMaxDuration = var_225_4

					if var_225_4 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_4 + 0
					end
				end

				arg_222_1.text_.text = var_225_2
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071053", "story_v_out_411071.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071053", "story_v_out_411071.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_out_411071", "411071053", "story_v_out_411071.awb")

						arg_222_1:RecordAudio("411071053", var_225_6)
						arg_222_1:RecordAudio("411071053", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_411071", "411071053", "story_v_out_411071.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_411071", "411071053", "story_v_out_411071.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play411071054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 411071054
		arg_226_1.duration_ = 3.6

		local var_226_0 = {
			zh = 2.266,
			ja = 3.6
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play411071055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.3

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_1 = arg_226_1:GetWordFromCfg(411071054)
				local var_229_2 = arg_226_1:FormatText(var_229_1.content)

				arg_226_1.text_.text = var_229_2

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_4 = 12 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 12)

				if (12 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 12)) > 0 and var_229_0 < var_229_4 then
					arg_226_1.talkMaxDuration = var_229_4

					if var_229_4 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_4 + 0
					end
				end

				arg_226_1.text_.text = var_229_2
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071054", "story_v_out_411071.awb") ~= 0 then
					local var_229_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071054", "story_v_out_411071.awb") / 1000

					if var_229_5 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + 0
					end

					if var_229_1.prefab_name ~= "" and arg_226_1.actors_[var_229_1.prefab_name] ~= nil then
						local var_229_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_1.prefab_name].transform, "story_v_out_411071", "411071054", "story_v_out_411071.awb")

						arg_226_1:RecordAudio("411071054", var_229_6)
						arg_226_1:RecordAudio("411071054", var_229_6)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_411071", "411071054", "story_v_out_411071.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_411071", "411071054", "story_v_out_411071.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_7 and arg_226_1.time_ < 0 + var_229_7 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play411071055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 411071055
		arg_230_1.duration_ = 3.77

		local var_230_0 = {
			zh = 3.233,
			ja = 3.766
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play411071056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1095ui_story"]) and arg_230_1.var_.characterEffect1095ui_story == nil then
				arg_230_1.var_.characterEffect1095ui_story = arg_230_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1095ui_story"]) then
				if arg_230_1.var_.characterEffect1095ui_story and not isNil(arg_230_1.actors_["1095ui_story"]) then
					arg_230_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_0)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1095ui_story"]) and arg_230_1.var_.characterEffect1095ui_story then
				arg_230_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_233_1 = 0
			local var_233_2 = 0.45

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_3 = arg_230_1:GetWordFromCfg(411071055)
				local var_233_4 = arg_230_1:FormatText(var_233_3.content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_6 = 18 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_4) / 18)

				if (18 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_4) / 18)) > 0 and var_233_2 < var_233_6 then
					arg_230_1.talkMaxDuration = var_233_6

					if var_233_6 + var_233_1 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_6 + var_233_1
					end
				end

				arg_230_1.text_.text = var_233_4
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071055", "story_v_out_411071.awb") ~= 0 then
					local var_233_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071055", "story_v_out_411071.awb") / 1000

					if var_233_7 + var_233_1 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_1
					end

					if var_233_3.prefab_name ~= "" and arg_230_1.actors_[var_233_3.prefab_name] ~= nil then
						local var_233_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_3.prefab_name].transform, "story_v_out_411071", "411071055", "story_v_out_411071.awb")

						arg_230_1:RecordAudio("411071055", var_233_8)
						arg_230_1:RecordAudio("411071055", var_233_8)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_411071", "411071055", "story_v_out_411071.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_411071", "411071055", "story_v_out_411071.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_9 = math.max(var_233_2, arg_230_1.talkMaxDuration)

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_9 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_1) / var_233_9

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_1 + var_233_9 and arg_230_1.time_ < var_233_1 + var_233_9 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play411071056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 411071056
		arg_234_1.duration_ = 5.1

		local var_234_0 = {
			zh = 3.8,
			ja = 5.1
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
				arg_234_0:Play411071057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1095ui_story"]) and arg_234_1.var_.characterEffect1095ui_story == nil then
				arg_234_1.var_.characterEffect1095ui_story = arg_234_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1095ui_story"]) then
				if arg_234_1.var_.characterEffect1095ui_story and not isNil(arg_234_1.actors_["1095ui_story"]) then
					arg_234_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1095ui_story"]) and arg_234_1.var_.characterEffect1095ui_story then
				arg_234_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_237_2 = 0
			local var_237_3 = 0.475

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_2 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_4 = arg_234_1:GetWordFromCfg(411071056)
				local var_237_5 = arg_234_1:FormatText(var_237_4.content)

				arg_234_1.text_.text = var_237_5

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_7 = 19 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 19)

				if (19 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 19)) > 0 and var_237_3 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_2
					end
				end

				arg_234_1.text_.text = var_237_5
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071056", "story_v_out_411071.awb") ~= 0 then
					local var_237_8 = manager.audio:GetVoiceLength("story_v_out_411071", "411071056", "story_v_out_411071.awb") / 1000

					if var_237_8 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_2
					end

					if var_237_4.prefab_name ~= "" and arg_234_1.actors_[var_237_4.prefab_name] ~= nil then
						local var_237_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_4.prefab_name].transform, "story_v_out_411071", "411071056", "story_v_out_411071.awb")

						arg_234_1:RecordAudio("411071056", var_237_9)
						arg_234_1:RecordAudio("411071056", var_237_9)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_411071", "411071056", "story_v_out_411071.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_411071", "411071056", "story_v_out_411071.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_3, arg_234_1.talkMaxDuration)

			if var_237_2 <= arg_234_1.time_ and arg_234_1.time_ < var_237_2 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_2) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_2 + var_237_10 and arg_234_1.time_ < var_237_2 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play411071057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 411071057
		arg_238_1.duration_ = 1

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play411071058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1095ui_story"]) and arg_238_1.var_.characterEffect1095ui_story == nil then
				arg_238_1.var_.characterEffect1095ui_story = arg_238_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1095ui_story"]) then
				if arg_238_1.var_.characterEffect1095ui_story and not isNil(arg_238_1.actors_["1095ui_story"]) then
					arg_238_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1095ui_story"]) and arg_238_1.var_.characterEffect1095ui_story then
				arg_238_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_241_1 = 0
			local var_241_2 = 0.075

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:GetWordFromCfg(411071057)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_6 = 3 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_4) / 3)

				if (3 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_4) / 3)) > 0 and var_241_2 < var_241_6 then
					arg_238_1.talkMaxDuration = var_241_6

					if var_241_6 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_6 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071057", "story_v_out_411071.awb") ~= 0 then
					local var_241_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071057", "story_v_out_411071.awb") / 1000

					if var_241_7 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_1
					end

					if var_241_3.prefab_name ~= "" and arg_238_1.actors_[var_241_3.prefab_name] ~= nil then
						local var_241_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_3.prefab_name].transform, "story_v_out_411071", "411071057", "story_v_out_411071.awb")

						arg_238_1:RecordAudio("411071057", var_241_8)
						arg_238_1:RecordAudio("411071057", var_241_8)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_411071", "411071057", "story_v_out_411071.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_411071", "411071057", "story_v_out_411071.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_9 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_9 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_9

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_9 and arg_238_1.time_ < var_241_1 + var_241_9 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play411071058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 411071058
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play411071059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun02", "")
			end

			local var_245_1 = 0
			local var_245_2 = 0.9

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_3 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(411071058).content)

				arg_242_1.text_.text = var_245_3

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 36 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 36)

				if (36 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 36)) > 0 and var_245_2 < var_245_5 then
					arg_242_1.talkMaxDuration = var_245_5

					if var_245_5 + var_245_1 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + var_245_1
					end
				end

				arg_242_1.text_.text = var_245_3
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_6 = math.max(var_245_2, arg_242_1.talkMaxDuration)

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_6 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_1) / var_245_6

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_1 + var_245_6 and arg_242_1.time_ < var_245_1 + var_245_6 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play411071059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 411071059
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play411071060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:AudioAction("stop", "effect", "se_story", "se_story_alarmloop", "")
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:AudioAction("play", "effect", "se_story_131", "se_story_131__ui", "")
			end

			local var_249_2 = 0
			local var_249_3 = 1.425

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_2 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_4 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(411071059).content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_6 = 57 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_4) / 57)

				if (57 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_4) / 57)) > 0 and var_249_3 < var_249_6 then
					arg_246_1.talkMaxDuration = var_249_6

					if var_249_6 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_6 + var_249_2
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_3, arg_246_1.talkMaxDuration)

			if var_249_2 <= arg_246_1.time_ and arg_246_1.time_ < var_249_2 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_2) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_2 + var_249_7 and arg_246_1.time_ < var_249_2 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play411071060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 411071060
		arg_250_1.duration_ = 4.1

		local var_250_0 = {
			zh = 3.333,
			ja = 4.1
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play411071061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.175

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[680].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2019")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_1 = arg_250_1:GetWordFromCfg(411071060)
				local var_253_2 = arg_250_1:FormatText(var_253_1.content)

				arg_250_1.text_.text = var_253_2

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_4 = 7 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 7)

				if (7 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_2) / 7)) > 0 and var_253_0 < var_253_4 then
					arg_250_1.talkMaxDuration = var_253_4

					if var_253_4 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_4 + 0
					end
				end

				arg_250_1.text_.text = var_253_2
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071060", "story_v_out_411071.awb") ~= 0 then
					local var_253_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071060", "story_v_out_411071.awb") / 1000

					if var_253_5 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + 0
					end

					if var_253_1.prefab_name ~= "" and arg_250_1.actors_[var_253_1.prefab_name] ~= nil then
						local var_253_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_1.prefab_name].transform, "story_v_out_411071", "411071060", "story_v_out_411071.awb")

						arg_250_1:RecordAudio("411071060", var_253_6)
						arg_250_1:RecordAudio("411071060", var_253_6)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_411071", "411071060", "story_v_out_411071.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_411071", "411071060", "story_v_out_411071.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_7 and arg_250_1.time_ < 0 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play411071061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 411071061
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play411071062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 1.1

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_1 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(411071061).content)

				arg_254_1.text_.text = var_257_1

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_3 = 44 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 44)

				if (44 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_1) / 44)) > 0 and var_257_0 < var_257_3 then
					arg_254_1.talkMaxDuration = var_257_3

					if var_257_3 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_3 + 0
					end
				end

				arg_254_1.text_.text = var_257_1
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_4 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_4

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play411071062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 411071062
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play411071063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 1

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(411071062).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 40 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 40)

				if (40 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 40)) > 0 and var_261_0 < var_261_3 then
					arg_258_1.talkMaxDuration = var_261_3

					if var_261_3 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_3 + 0
					end
				end

				arg_258_1.text_.text = var_261_1
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_4 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_4

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play411071063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 411071063
		arg_262_1.duration_ = 4.9

		local var_262_0 = {
			zh = 2.966,
			ja = 4.9
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play411071064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.325

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_1 = arg_262_1:GetWordFromCfg(411071063)
				local var_265_2 = arg_262_1:FormatText(var_265_1.content)

				arg_262_1.text_.text = var_265_2

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 13 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 13)

				if (13 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 13)) > 0 and var_265_0 < var_265_4 then
					arg_262_1.talkMaxDuration = var_265_4

					if var_265_4 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_4 + 0
					end
				end

				arg_262_1.text_.text = var_265_2
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071063", "story_v_out_411071.awb") ~= 0 then
					local var_265_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071063", "story_v_out_411071.awb") / 1000

					if var_265_5 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + 0
					end

					if var_265_1.prefab_name ~= "" and arg_262_1.actors_[var_265_1.prefab_name] ~= nil then
						local var_265_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_1.prefab_name].transform, "story_v_out_411071", "411071063", "story_v_out_411071.awb")

						arg_262_1:RecordAudio("411071063", var_265_6)
						arg_262_1:RecordAudio("411071063", var_265_6)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_411071", "411071063", "story_v_out_411071.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_411071", "411071063", "story_v_out_411071.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play411071064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 411071064
		arg_266_1.duration_ = 7.5

		local var_266_0 = {
			zh = 3.2,
			ja = 7.5
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play411071065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1095ui_story = arg_266_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_269_0 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 then
				arg_266_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_266_1.time_ - 0) / var_269_0)
				arg_266_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1095ui_story"].transform.position).z)
				arg_266_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1095ui_story"].transform.localEulerAngles = arg_266_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 then
				arg_266_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_266_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1095ui_story"].transform.position).z)
				arg_266_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1095ui_story"].transform.localEulerAngles = arg_266_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_269_1 = arg_266_1.actors_["1095ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1095ui_story == nil then
				arg_266_1.var_.characterEffect1095ui_story = var_269_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_2 and not isNil(var_269_1) then
				if arg_266_1.var_.characterEffect1095ui_story and not isNil(var_269_1) then
					arg_266_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_2 and arg_266_1.time_ < 0 + var_269_2 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1095ui_story then
				arg_266_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_269_4 = 0
			local var_269_5 = 0.35

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_6 = arg_266_1:GetWordFromCfg(411071064)
				local var_269_7 = arg_266_1:FormatText(var_269_6.content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 14 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 14)

				if (14 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 14)) > 0 and var_269_5 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071064", "story_v_out_411071.awb") ~= 0 then
					local var_269_10 = manager.audio:GetVoiceLength("story_v_out_411071", "411071064", "story_v_out_411071.awb") / 1000

					if var_269_10 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_4
					end

					if var_269_6.prefab_name ~= "" and arg_266_1.actors_[var_269_6.prefab_name] ~= nil then
						local var_269_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_6.prefab_name].transform, "story_v_out_411071", "411071064", "story_v_out_411071.awb")

						arg_266_1:RecordAudio("411071064", var_269_11)
						arg_266_1:RecordAudio("411071064", var_269_11)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_411071", "411071064", "story_v_out_411071.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_411071", "411071064", "story_v_out_411071.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_12 and arg_266_1.time_ < var_269_4 + var_269_12 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play411071065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 411071065
		arg_270_1.duration_ = 2.13

		local var_270_0 = {
			zh = 1.066,
			ja = 2.133
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play411071066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1095ui_story"]) and arg_270_1.var_.characterEffect1095ui_story == nil then
				arg_270_1.var_.characterEffect1095ui_story = arg_270_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1095ui_story"]) then
				if arg_270_1.var_.characterEffect1095ui_story and not isNil(arg_270_1.actors_["1095ui_story"]) then
					arg_270_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_0)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1095ui_story"]) and arg_270_1.var_.characterEffect1095ui_story then
				arg_270_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_273_1 = 0
			local var_273_2 = 0.1

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(411071065)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_6 = 4 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_4) / 4)

				if (4 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_4) / 4)) > 0 and var_273_2 < var_273_6 then
					arg_270_1.talkMaxDuration = var_273_6

					if var_273_6 + var_273_1 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_6 + var_273_1
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071065", "story_v_out_411071.awb") ~= 0 then
					local var_273_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071065", "story_v_out_411071.awb") / 1000

					if var_273_7 + var_273_1 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_1
					end

					if var_273_3.prefab_name ~= "" and arg_270_1.actors_[var_273_3.prefab_name] ~= nil then
						local var_273_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_3.prefab_name].transform, "story_v_out_411071", "411071065", "story_v_out_411071.awb")

						arg_270_1:RecordAudio("411071065", var_273_8)
						arg_270_1:RecordAudio("411071065", var_273_8)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_411071", "411071065", "story_v_out_411071.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_411071", "411071065", "story_v_out_411071.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_9 = math.max(var_273_2, arg_270_1.talkMaxDuration)

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_9 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_1) / var_273_9

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_1 + var_273_9 and arg_270_1.time_ < var_273_1 + var_273_9 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play411071066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 411071066
		arg_274_1.duration_ = 6.43

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play411071067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if arg_274_1.bgs_.B03a == nil then
				local var_277_0 = Object.Instantiate(arg_274_1.paintGo_)

				var_277_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B03a")
				var_277_0.name = "B03a"
				var_277_0.transform.parent = arg_274_1.stage_.transform
				var_277_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.bgs_.B03a = var_277_0
			end

			if 0.666666666666667 < arg_274_1.time_ and arg_274_1.time_ <= 0.666666666666667 + arg_277_0 then
				local var_277_1 = arg_274_1.bgs_.B03a

				arg_274_1.bgs_.B03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_277_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_277_2 = var_277_1:GetComponent("SpriteRenderer")

				if var_277_2 and var_277_2.sprite then
					local var_277_3 = 2 * (var_277_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_277_1.transform.localScale = Vector3.New(var_277_3 / var_277_2.sprite.bounds.size.y < var_277_3 * manager.ui.mainCameraCom_.aspect / var_277_2.sprite.bounds.size.x and var_277_3 * manager.ui.mainCameraCom_.aspect / var_277_2.sprite.bounds.size.x or var_277_3 / var_277_2.sprite.bounds.size.y, var_277_3 / var_277_2.sprite.bounds.size.y < var_277_3 * manager.ui.mainCameraCom_.aspect / var_277_2.sprite.bounds.size.x and var_277_3 * manager.ui.mainCameraCom_.aspect / var_277_2.sprite.bounds.size.x or var_277_3 / var_277_2.sprite.bounds.size.y, 0)
				end

				for iter_277_0, iter_277_1 in pairs(arg_274_1.bgs_) do
					if iter_277_0 ~= "B03a" then
						iter_277_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_277_4 = 0

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_5 = 0.666666666666667

			if var_277_4 <= arg_274_1.time_ and arg_274_1.time_ < var_277_4 + var_277_5 then
				local var_277_6 = Color.New(1, 1, 1)

				var_277_6.a = Mathf.Lerp(0, 1, (arg_274_1.time_ - var_277_4) / var_277_5)
				arg_274_1.mask_.color = var_277_6
			end

			if arg_274_1.time_ >= var_277_4 + var_277_5 and arg_274_1.time_ < var_277_4 + var_277_5 + arg_277_0 then
				local var_277_7 = Color.New(1, 1, 1)

				var_277_7.a = 1
				arg_274_1.mask_.color = var_277_7
			end

			local var_277_8 = 0.666666666666667

			if 0.666666666666667 < arg_274_1.time_ and arg_274_1.time_ <= var_277_8 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_9 = 2

			if var_277_8 <= arg_274_1.time_ and arg_274_1.time_ < var_277_8 + var_277_9 then
				local var_277_10 = Color.New(1, 1, 1)

				var_277_10.a = Mathf.Lerp(1, 0, (arg_274_1.time_ - var_277_8) / var_277_9)
				arg_274_1.mask_.color = var_277_10
			end

			if arg_274_1.time_ >= var_277_8 + var_277_9 and arg_274_1.time_ < var_277_8 + var_277_9 + arg_277_0 then
				local var_277_11 = Color.New(1, 1, 1)

				arg_274_1.mask_.enabled = false
				var_277_11.a = 0
				arg_274_1.mask_.color = var_277_11
			end

			local var_277_12 = arg_274_1.actors_["1095ui_story"].transform

			if 0.666666666666667 < arg_274_1.time_ and arg_274_1.time_ <= 0.666666666666667 + arg_277_0 then
				arg_274_1.var_.moveOldPos1095ui_story = var_277_12.localPosition
			end

			local var_277_13 = 0.001

			if 0.666666666666667 <= arg_274_1.time_ and arg_274_1.time_ < 0.666666666666667 + var_277_13 then
				var_277_12.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0.666666666666667) / var_277_13)
				var_277_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_12.position).x, (manager.ui.mainCamera.transform.position - var_277_12.position).y, (manager.ui.mainCamera.transform.position - var_277_12.position).z)
				var_277_12.localEulerAngles.z = 0
				var_277_12.localEulerAngles.x = 0
				var_277_12.localEulerAngles = var_277_12.localEulerAngles
			end

			if arg_274_1.time_ >= 0.666666666666667 + var_277_13 and arg_274_1.time_ < 0.666666666666667 + var_277_13 + arg_277_0 then
				var_277_12.localPosition = Vector3.New(0, 100, 0)
				var_277_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_12.position).x, (manager.ui.mainCamera.transform.position - var_277_12.position).y, (manager.ui.mainCamera.transform.position - var_277_12.position).z)
				var_277_12.localEulerAngles.z = 0
				var_277_12.localEulerAngles.x = 0
				var_277_12.localEulerAngles = var_277_12.localEulerAngles
			end

			if 0.666666666666667 < arg_274_1.time_ and arg_274_1.time_ <= 0.666666666666667 + arg_277_0 then
				arg_274_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_277_15 = manager.ui.mainCamera.transform

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.shakeOldPos = var_277_15.localPosition
			end

			local var_277_16 = 1

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_16 then
				local var_277_17, var_277_18 = math.modf((arg_274_1.time_ - 0) / 0.066)

				var_277_15.localPosition = Vector3.New(var_277_18 * 0.13, var_277_18 * 0.13, var_277_18 * 0.13) + arg_274_1.var_.shakeOldPos
			end

			if arg_274_1.time_ >= 0 + var_277_16 and arg_274_1.time_ < 0 + var_277_16 + arg_277_0 then
				var_277_15.localPosition = arg_274_1.var_.shakeOldPos
			end

			if arg_274_1.frameCnt_ <= 1 then
				arg_274_1.dialog_:SetActive(false)
			end

			local var_277_19 = 1.43333333333333
			local var_277_20 = 1.1

			if 1.43333333333333 < arg_274_1.time_ and arg_274_1.time_ <= var_277_19 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0

				arg_274_1.dialog_:SetActive(true)

				arg_274_1.dialogCg_.alpha = 0

				local var_277_21 = LeanTween.value(arg_274_1.dialog_, 0, 1, 0.3)

				var_277_21:setOnUpdate(LuaHelper.FloatAction(function(arg_278_0)
					arg_274_1.dialogCg_.alpha = arg_278_0
				end))
				var_277_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_274_1.dialog_)
					var_277_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_274_1.duration_ = arg_274_1.duration_ + 0.3

				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_22 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(411071066).content)

				arg_274_1.text_.text = var_277_22

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_24 = 44 <= 0 and var_277_20 or var_277_20 * (utf8.len(var_277_22) / 44)

				if (44 <= 0 and var_277_20 or var_277_20 * (utf8.len(var_277_22) / 44)) > 0 and var_277_20 < var_277_24 then
					arg_274_1.talkMaxDuration = var_277_24
					var_277_19 = var_277_19 + 0.3

					if var_277_24 + var_277_19 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_24 + var_277_19
					end
				end

				arg_274_1.text_.text = var_277_22
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_25 = var_277_19 + 0.3
			local var_277_26 = math.max(var_277_20, arg_274_1.talkMaxDuration)

			if var_277_19 + 0.3 <= arg_274_1.time_ and arg_274_1.time_ < var_277_25 + var_277_26 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_25) / var_277_26

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_25 + var_277_26 and arg_274_1.time_ < var_277_25 + var_277_26 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play411071067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 411071067
		arg_280_1.duration_ = 2

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play411071068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos1095ui_story = arg_280_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_283_0 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 then
				arg_280_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_280_1.time_ - 0) / var_283_0)
				arg_280_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["1095ui_story"].transform.position).z)
				arg_280_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["1095ui_story"].transform.localEulerAngles = arg_280_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 then
				arg_280_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_280_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["1095ui_story"].transform.position).z)
				arg_280_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["1095ui_story"].transform.localEulerAngles = arg_280_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_283_1 = arg_280_1.actors_["1095ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_1) and arg_280_1.var_.characterEffect1095ui_story == nil then
				arg_280_1.var_.characterEffect1095ui_story = var_283_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_2 and not isNil(var_283_1) then
				if arg_280_1.var_.characterEffect1095ui_story and not isNil(var_283_1) then
					arg_280_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_2 and arg_280_1.time_ < 0 + var_283_2 + arg_283_0 and not isNil(var_283_1) and arg_280_1.var_.characterEffect1095ui_story then
				arg_280_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action8_2")
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_283_4 = 0
			local var_283_5 = 0.075

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_6 = arg_280_1:GetWordFromCfg(411071067)
				local var_283_7 = arg_280_1:FormatText(var_283_6.content)

				arg_280_1.text_.text = var_283_7

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_9 = 3 <= 0 and var_283_5 or var_283_5 * (utf8.len(var_283_7) / 3)

				if (3 <= 0 and var_283_5 or var_283_5 * (utf8.len(var_283_7) / 3)) > 0 and var_283_5 < var_283_9 then
					arg_280_1.talkMaxDuration = var_283_9

					if var_283_9 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_9 + var_283_4
					end
				end

				arg_280_1.text_.text = var_283_7
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071067", "story_v_out_411071.awb") ~= 0 then
					local var_283_10 = manager.audio:GetVoiceLength("story_v_out_411071", "411071067", "story_v_out_411071.awb") / 1000

					if var_283_10 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_10 + var_283_4
					end

					if var_283_6.prefab_name ~= "" and arg_280_1.actors_[var_283_6.prefab_name] ~= nil then
						local var_283_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_6.prefab_name].transform, "story_v_out_411071", "411071067", "story_v_out_411071.awb")

						arg_280_1:RecordAudio("411071067", var_283_11)
						arg_280_1:RecordAudio("411071067", var_283_11)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_411071", "411071067", "story_v_out_411071.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_411071", "411071067", "story_v_out_411071.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_12 = math.max(var_283_5, arg_280_1.talkMaxDuration)

			if var_283_4 <= arg_280_1.time_ and arg_280_1.time_ < var_283_4 + var_283_12 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_4) / var_283_12

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_4 + var_283_12 and arg_280_1.time_ < var_283_4 + var_283_12 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play411071068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 411071068
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play411071069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["1095ui_story"]) and arg_284_1.var_.characterEffect1095ui_story == nil then
				arg_284_1.var_.characterEffect1095ui_story = arg_284_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["1095ui_story"]) then
				if arg_284_1.var_.characterEffect1095ui_story and not isNil(arg_284_1.actors_["1095ui_story"]) then
					arg_284_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_284_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_0)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["1095ui_story"]) and arg_284_1.var_.characterEffect1095ui_story then
				arg_284_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_284_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_287_1 = arg_284_1.actors_["1095ui_story"].transform

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1095ui_story = var_287_1.localPosition
			end

			local var_287_2 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_2 then
				var_287_1.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_284_1.time_ - 0) / var_287_2)
				var_287_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_287_1.position).x, (manager.ui.mainCamera.transform.position - var_287_1.position).y, (manager.ui.mainCamera.transform.position - var_287_1.position).z)
				var_287_1.localEulerAngles.z = 0
				var_287_1.localEulerAngles.x = 0
				var_287_1.localEulerAngles = var_287_1.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_2 and arg_284_1.time_ < 0 + var_287_2 + arg_287_0 then
				var_287_1.localPosition = Vector3.New(0, 100, 0)
				var_287_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_287_1.position).x, (manager.ui.mainCamera.transform.position - var_287_1.position).y, (manager.ui.mainCamera.transform.position - var_287_1.position).z)
				var_287_1.localEulerAngles.z = 0
				var_287_1.localEulerAngles.x = 0
				var_287_1.localEulerAngles = var_287_1.localEulerAngles
			end

			local var_287_3 = 0
			local var_287_4 = 1.375

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_3 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_5 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(411071068).content)

				arg_284_1.text_.text = var_287_5

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_7 = 55 <= 0 and var_287_4 or var_287_4 * (utf8.len(var_287_5) / 55)

				if (55 <= 0 and var_287_4 or var_287_4 * (utf8.len(var_287_5) / 55)) > 0 and var_287_4 < var_287_7 then
					arg_284_1.talkMaxDuration = var_287_7

					if var_287_7 + var_287_3 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_3
					end
				end

				arg_284_1.text_.text = var_287_5
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_8 = math.max(var_287_4, arg_284_1.talkMaxDuration)

			if var_287_3 <= arg_284_1.time_ and arg_284_1.time_ < var_287_3 + var_287_8 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_3) / var_287_8

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_3 + var_287_8 and arg_284_1.time_ < var_287_3 + var_287_8 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play411071069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 411071069
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play411071070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:AudioAction("play", "effect", "se_story_131", "se_story_131_1095_attack_9", "")
			end

			local var_291_1 = manager.ui.mainCamera.transform

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.shakeOldPos = var_291_1.localPosition
			end

			local var_291_2 = 0.6

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_2 then
				local var_291_3, var_291_4 = math.modf((arg_288_1.time_ - 0) / 0.066)

				var_291_1.localPosition = Vector3.New(var_291_4 * 0.13, var_291_4 * 0.13, var_291_4 * 0.13) + arg_288_1.var_.shakeOldPos
			end

			if arg_288_1.time_ >= 0 + var_291_2 and arg_288_1.time_ < 0 + var_291_2 + arg_291_0 then
				var_291_1.localPosition = arg_288_1.var_.shakeOldPos
			end

			local var_291_5 = 0

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_5 + arg_291_0 then
				arg_288_1.allBtn_.enabled = false
			end

			if arg_288_1.time_ >= var_291_5 + 0.6 and arg_288_1.time_ < var_291_5 + 0.6 + arg_291_0 then
				arg_288_1.allBtn_.enabled = true
			end

			local var_291_6 = 0
			local var_291_7 = 1.075

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_8 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(411071069).content)

				arg_288_1.text_.text = var_291_8

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_10 = 43 <= 0 and var_291_7 or var_291_7 * (utf8.len(var_291_8) / 43)

				if (43 <= 0 and var_291_7 or var_291_7 * (utf8.len(var_291_8) / 43)) > 0 and var_291_7 < var_291_10 then
					arg_288_1.talkMaxDuration = var_291_10

					if var_291_10 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_10 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_8
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_11 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_11 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_6) / var_291_11

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_6 + var_291_11 and arg_288_1.time_ < var_291_6 + var_291_11 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play411071070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 411071070
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play411071071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 1.425

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_1 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(411071070).content)

				arg_292_1.text_.text = var_295_1

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_3 = 56 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 56)

				if (56 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_1) / 56)) > 0 and var_295_0 < var_295_3 then
					arg_292_1.talkMaxDuration = var_295_3

					if var_295_3 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_3 + 0
					end
				end

				arg_292_1.text_.text = var_295_1
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_4 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_4

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play411071071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 411071071
		arg_296_1.duration_ = 2.5

		local var_296_0 = {
			zh = 1.933,
			ja = 2.5
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play411071072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0.225

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_1 = arg_296_1:GetWordFromCfg(411071071)
				local var_299_2 = arg_296_1:FormatText(var_299_1.content)

				arg_296_1.text_.text = var_299_2

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_4 = 9 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 9)

				if (9 <= 0 and var_299_0 or var_299_0 * (utf8.len(var_299_2) / 9)) > 0 and var_299_0 < var_299_4 then
					arg_296_1.talkMaxDuration = var_299_4

					if var_299_4 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_4 + 0
					end
				end

				arg_296_1.text_.text = var_299_2
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071071", "story_v_out_411071.awb") ~= 0 then
					local var_299_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071071", "story_v_out_411071.awb") / 1000

					if var_299_5 + 0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + 0
					end

					if var_299_1.prefab_name ~= "" and arg_296_1.actors_[var_299_1.prefab_name] ~= nil then
						local var_299_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_1.prefab_name].transform, "story_v_out_411071", "411071071", "story_v_out_411071.awb")

						arg_296_1:RecordAudio("411071071", var_299_6)
						arg_296_1:RecordAudio("411071071", var_299_6)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_411071", "411071071", "story_v_out_411071.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_411071", "411071071", "story_v_out_411071.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_7 = math.max(var_299_0, arg_296_1.talkMaxDuration)

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_7 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - 0) / var_299_7

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= 0 + var_299_7 and arg_296_1.time_ < 0 + var_299_7 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play411071072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 411071072
		arg_300_1.duration_ = 6.97

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play411071073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if arg_300_1.bgs_.STblack == nil then
				local var_303_0 = Object.Instantiate(arg_300_1.paintGo_)

				var_303_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_303_0.name = "STblack"
				var_303_0.transform.parent = arg_300_1.stage_.transform
				var_303_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_300_1.bgs_.STblack = var_303_0
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				local var_303_1 = arg_300_1.bgs_.STblack

				arg_300_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_303_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_303_2 = var_303_1:GetComponent("SpriteRenderer")

				if var_303_2 and var_303_2.sprite then
					local var_303_3 = 2 * (var_303_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_303_1.transform.localScale = Vector3.New(var_303_3 / var_303_2.sprite.bounds.size.y < var_303_3 * manager.ui.mainCameraCom_.aspect / var_303_2.sprite.bounds.size.x and var_303_3 * manager.ui.mainCameraCom_.aspect / var_303_2.sprite.bounds.size.x or var_303_3 / var_303_2.sprite.bounds.size.y, var_303_3 / var_303_2.sprite.bounds.size.y < var_303_3 * manager.ui.mainCameraCom_.aspect / var_303_2.sprite.bounds.size.x and var_303_3 * manager.ui.mainCameraCom_.aspect / var_303_2.sprite.bounds.size.x or var_303_3 / var_303_2.sprite.bounds.size.y, 0)
				end

				for iter_303_0, iter_303_1 in pairs(arg_300_1.bgs_) do
					if iter_303_0 ~= "STblack" then
						iter_303_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_303_4 = 0

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_5 = 1.7

			if var_303_4 <= arg_300_1.time_ and arg_300_1.time_ < var_303_4 + var_303_5 then
				local var_303_6 = Color.New(1, 1, 1)

				var_303_6.a = Mathf.Lerp(0, 1, (arg_300_1.time_ - var_303_4) / var_303_5)
				arg_300_1.mask_.color = var_303_6
			end

			if arg_300_1.time_ >= var_303_4 + var_303_5 and arg_300_1.time_ < var_303_4 + var_303_5 + arg_303_0 then
				local var_303_7 = Color.New(1, 1, 1)

				var_303_7.a = 1
				arg_300_1.mask_.color = var_303_7
			end

			local var_303_8 = 1.7

			if 1.7 < arg_300_1.time_ and arg_300_1.time_ <= var_303_8 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_9 = 1.96666666666667

			if var_303_8 <= arg_300_1.time_ and arg_300_1.time_ < var_303_8 + var_303_9 then
				local var_303_10 = Color.New(1, 1, 1)

				var_303_10.a = Mathf.Lerp(1, 0, (arg_300_1.time_ - var_303_8) / var_303_9)
				arg_300_1.mask_.color = var_303_10
			end

			if arg_300_1.time_ >= var_303_8 + var_303_9 and arg_300_1.time_ < var_303_8 + var_303_9 + arg_303_0 then
				local var_303_11 = Color.New(1, 1, 1)

				arg_300_1.mask_.enabled = false
				var_303_11.a = 0
				arg_300_1.mask_.color = var_303_11
			end

			if arg_300_1.frameCnt_ <= 1 then
				arg_300_1.dialog_:SetActive(false)
			end

			local var_303_12 = 1.96666666666667
			local var_303_13 = 1.475

			if 1.96666666666667 < arg_300_1.time_ and arg_300_1.time_ <= var_303_12 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				arg_300_1.dialog_:SetActive(true)

				arg_300_1.dialogCg_.alpha = 0

				local var_303_14 = LeanTween.value(arg_300_1.dialog_, 0, 1, 0.3)

				var_303_14:setOnUpdate(LuaHelper.FloatAction(function(arg_304_0)
					arg_300_1.dialogCg_.alpha = arg_304_0
				end))
				var_303_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_300_1.dialog_)
					var_303_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_300_1.duration_ = arg_300_1.duration_ + 0.3

				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_15 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(411071072).content)

				arg_300_1.text_.text = var_303_15

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_17 = 59 <= 0 and var_303_13 or var_303_13 * (utf8.len(var_303_15) / 59)

				if (59 <= 0 and var_303_13 or var_303_13 * (utf8.len(var_303_15) / 59)) > 0 and var_303_13 < var_303_17 then
					arg_300_1.talkMaxDuration = var_303_17
					var_303_12 = var_303_12 + 0.3

					if var_303_17 + var_303_12 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_17 + var_303_12
					end
				end

				arg_300_1.text_.text = var_303_15
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_18 = var_303_12 + 0.3
			local var_303_19 = math.max(var_303_13, arg_300_1.talkMaxDuration)

			if var_303_12 + 0.3 <= arg_300_1.time_ and arg_300_1.time_ < var_303_18 + var_303_19 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_18) / var_303_19

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_18 + var_303_19 and arg_300_1.time_ < var_303_18 + var_303_19 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play411071073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 411071073
		arg_306_1.duration_ = 5.3

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play411071074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if arg_306_1.bgs_.B10f == nil then
				local var_309_0 = Object.Instantiate(arg_306_1.paintGo_)

				var_309_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B10f")
				var_309_0.name = "B10f"
				var_309_0.transform.parent = arg_306_1.stage_.transform
				var_309_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_306_1.bgs_.B10f = var_309_0
			end

			if 0.7 < arg_306_1.time_ and arg_306_1.time_ <= 0.7 + arg_309_0 then
				local var_309_1 = arg_306_1.bgs_.B10f

				arg_306_1.bgs_.B10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_309_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_309_2 = var_309_1:GetComponent("SpriteRenderer")

				if var_309_2 and var_309_2.sprite then
					local var_309_3 = 2 * (var_309_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_309_1.transform.localScale = Vector3.New(var_309_3 / var_309_2.sprite.bounds.size.y < var_309_3 * manager.ui.mainCameraCom_.aspect / var_309_2.sprite.bounds.size.x and var_309_3 * manager.ui.mainCameraCom_.aspect / var_309_2.sprite.bounds.size.x or var_309_3 / var_309_2.sprite.bounds.size.y, var_309_3 / var_309_2.sprite.bounds.size.y < var_309_3 * manager.ui.mainCameraCom_.aspect / var_309_2.sprite.bounds.size.x and var_309_3 * manager.ui.mainCameraCom_.aspect / var_309_2.sprite.bounds.size.x or var_309_3 / var_309_2.sprite.bounds.size.y, 0)
				end

				for iter_309_0, iter_309_1 in pairs(arg_306_1.bgs_) do
					if iter_309_0 ~= "B10f" then
						iter_309_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_309_4 = 0

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_4 + arg_309_0 then
				arg_306_1.mask_.enabled = true
				arg_306_1.mask_.raycastTarget = true

				arg_306_1:SetGaussion(false)
			end

			local var_309_5 = 0.7

			if var_309_4 <= arg_306_1.time_ and arg_306_1.time_ < var_309_4 + var_309_5 then
				local var_309_6 = Color.New(0, 0, 0)

				var_309_6.a = Mathf.Lerp(0, 1, (arg_306_1.time_ - var_309_4) / var_309_5)
				arg_306_1.mask_.color = var_309_6
			end

			if arg_306_1.time_ >= var_309_4 + var_309_5 and arg_306_1.time_ < var_309_4 + var_309_5 + arg_309_0 then
				local var_309_7 = Color.New(0, 0, 0)

				var_309_7.a = 1
				arg_306_1.mask_.color = var_309_7
			end

			local var_309_8 = 0.7

			if 0.7 < arg_306_1.time_ and arg_306_1.time_ <= var_309_8 + arg_309_0 then
				arg_306_1.mask_.enabled = true
				arg_306_1.mask_.raycastTarget = true

				arg_306_1:SetGaussion(false)
			end

			local var_309_9 = 2.3

			if var_309_8 <= arg_306_1.time_ and arg_306_1.time_ < var_309_8 + var_309_9 then
				local var_309_10 = Color.New(0, 0, 0)

				var_309_10.a = Mathf.Lerp(1, 0, (arg_306_1.time_ - var_309_8) / var_309_9)
				arg_306_1.mask_.color = var_309_10
			end

			if arg_306_1.time_ >= var_309_8 + var_309_9 and arg_306_1.time_ < var_309_8 + var_309_9 + arg_309_0 then
				local var_309_11 = Color.New(0, 0, 0)

				arg_306_1.mask_.enabled = false
				var_309_11.a = 0
				arg_306_1.mask_.color = var_309_11
			end

			if arg_306_1.frameCnt_ <= 1 then
				arg_306_1.dialog_:SetActive(false)
			end

			local var_309_12 = 2.3
			local var_309_13 = 0.4

			if 2.3 < arg_306_1.time_ and arg_306_1.time_ <= var_309_12 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0

				arg_306_1.dialog_:SetActive(true)

				arg_306_1.dialogCg_.alpha = 0

				local var_309_14 = LeanTween.value(arg_306_1.dialog_, 0, 1, 0.3)

				var_309_14:setOnUpdate(LuaHelper.FloatAction(function(arg_310_0)
					arg_306_1.dialogCg_.alpha = arg_310_0
				end))
				var_309_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_306_1.dialog_)
					var_309_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_306_1.duration_ = arg_306_1.duration_ + 0.3

				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[679].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_15 = arg_306_1:GetWordFromCfg(411071073)
				local var_309_16 = arg_306_1:FormatText(var_309_15.content)

				arg_306_1.text_.text = var_309_16

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_18 = 16 <= 0 and var_309_13 or var_309_13 * (utf8.len(var_309_16) / 16)

				if (16 <= 0 and var_309_13 or var_309_13 * (utf8.len(var_309_16) / 16)) > 0 and var_309_13 < var_309_18 then
					arg_306_1.talkMaxDuration = var_309_18
					var_309_12 = var_309_12 + 0.3

					if var_309_18 + var_309_12 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_18 + var_309_12
					end
				end

				arg_306_1.text_.text = var_309_16
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071073", "story_v_out_411071.awb") ~= 0 then
					local var_309_19 = manager.audio:GetVoiceLength("story_v_out_411071", "411071073", "story_v_out_411071.awb") / 1000

					if var_309_19 + var_309_12 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_19 + var_309_12
					end

					if var_309_15.prefab_name ~= "" and arg_306_1.actors_[var_309_15.prefab_name] ~= nil then
						local var_309_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_15.prefab_name].transform, "story_v_out_411071", "411071073", "story_v_out_411071.awb")

						arg_306_1:RecordAudio("411071073", var_309_20)
						arg_306_1:RecordAudio("411071073", var_309_20)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_411071", "411071073", "story_v_out_411071.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_411071", "411071073", "story_v_out_411071.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_21 = var_309_12 + 0.3
			local var_309_22 = math.max(var_309_13, arg_306_1.talkMaxDuration)

			if var_309_12 + 0.3 <= arg_306_1.time_ and arg_306_1.time_ < var_309_21 + var_309_22 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_21) / var_309_22

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_21 + var_309_22 and arg_306_1.time_ < var_309_21 + var_309_22 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play411071074 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 411071074
		arg_312_1.duration_ = 4.1

		local var_312_0 = {
			zh = 3.033,
			ja = 4.1
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play411071075(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if arg_312_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_315_0 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_312_1.stage_.transform)

				var_315_0.name = "10014ui_story"
				var_315_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_312_1.actors_["10014ui_story"] = var_315_0

				local var_315_1 = var_315_0:GetComponentInChildren(typeof(CharacterEffect))

				var_315_1.enabled = true

				local var_315_2 = GameObjectTools.GetOrAddComponent(var_315_0, typeof(DynamicBoneHelper))

				if var_315_2 then
					var_315_2:EnableDynamicBone(false)
				end

				arg_312_1:ShowWeapon(var_315_1.transform, false)

				arg_312_1.var_["10014ui_story" .. "Animator"] = var_315_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_312_1.var_["10014ui_story" .. "Animator"].applyRootMotion = true
				arg_312_1.var_["10014ui_story" .. "LipSync"] = var_315_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_315_3 = arg_312_1.actors_["10014ui_story"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos10014ui_story = var_315_3.localPosition
			end

			local var_315_4 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_4 then
				var_315_3.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_312_1.time_ - 0) / var_315_4)
				var_315_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_3.position).x, (manager.ui.mainCamera.transform.position - var_315_3.position).y, (manager.ui.mainCamera.transform.position - var_315_3.position).z)
				var_315_3.localEulerAngles.z = 0
				var_315_3.localEulerAngles.x = 0
				var_315_3.localEulerAngles = var_315_3.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_4 and arg_312_1.time_ < 0 + var_315_4 + arg_315_0 then
				var_315_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_315_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_3.position).x, (manager.ui.mainCamera.transform.position - var_315_3.position).y, (manager.ui.mainCamera.transform.position - var_315_3.position).z)
				var_315_3.localEulerAngles.z = 0
				var_315_3.localEulerAngles.x = 0
				var_315_3.localEulerAngles = var_315_3.localEulerAngles
			end

			local var_315_5 = arg_312_1.actors_["10014ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_5) and arg_312_1.var_.characterEffect10014ui_story == nil then
				arg_312_1.var_.characterEffect10014ui_story = var_315_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_6 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_6 and not isNil(var_315_5) then
				if arg_312_1.var_.characterEffect10014ui_story and not isNil(var_315_5) then
					arg_312_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= 0 + var_315_6 and arg_312_1.time_ < 0 + var_315_6 + arg_315_0 and not isNil(var_315_5) and arg_312_1.var_.characterEffect10014ui_story then
				arg_312_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_315_8 = 0
			local var_315_9 = 0.3

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_8 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_10 = arg_312_1:GetWordFromCfg(411071074)
				local var_315_11 = arg_312_1:FormatText(var_315_10.content)

				arg_312_1.text_.text = var_315_11

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_13 = 12 <= 0 and var_315_9 or var_315_9 * (utf8.len(var_315_11) / 12)

				if (12 <= 0 and var_315_9 or var_315_9 * (utf8.len(var_315_11) / 12)) > 0 and var_315_9 < var_315_13 then
					arg_312_1.talkMaxDuration = var_315_13

					if var_315_13 + var_315_8 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_13 + var_315_8
					end
				end

				arg_312_1.text_.text = var_315_11
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071074", "story_v_out_411071.awb") ~= 0 then
					local var_315_14 = manager.audio:GetVoiceLength("story_v_out_411071", "411071074", "story_v_out_411071.awb") / 1000

					if var_315_14 + var_315_8 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_14 + var_315_8
					end

					if var_315_10.prefab_name ~= "" and arg_312_1.actors_[var_315_10.prefab_name] ~= nil then
						local var_315_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_10.prefab_name].transform, "story_v_out_411071", "411071074", "story_v_out_411071.awb")

						arg_312_1:RecordAudio("411071074", var_315_15)
						arg_312_1:RecordAudio("411071074", var_315_15)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_411071", "411071074", "story_v_out_411071.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_411071", "411071074", "story_v_out_411071.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_16 = math.max(var_315_9, arg_312_1.talkMaxDuration)

			if var_315_8 <= arg_312_1.time_ and arg_312_1.time_ < var_315_8 + var_315_16 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_8) / var_315_16

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_8 + var_315_16 and arg_312_1.time_ < var_315_8 + var_315_16 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play411071075 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 411071075
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play411071076(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["10014ui_story"]) and arg_316_1.var_.characterEffect10014ui_story == nil then
				arg_316_1.var_.characterEffect10014ui_story = arg_316_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_0 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["10014ui_story"]) then
				if arg_316_1.var_.characterEffect10014ui_story and not isNil(arg_316_1.actors_["10014ui_story"]) then
					arg_316_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_316_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_316_1.time_ - 0) / var_319_0)
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["10014ui_story"]) and arg_316_1.var_.characterEffect10014ui_story then
				arg_316_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_316_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_319_1 = 0
			local var_319_2 = 0.55

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_3 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(411071075).content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 22 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 22)

				if (22 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 22)) > 0 and var_319_2 < var_319_5 then
					arg_316_1.talkMaxDuration = var_319_5

					if var_319_5 + var_319_1 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + var_319_1
					end
				end

				arg_316_1.text_.text = var_319_3
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_6 = math.max(var_319_2, arg_316_1.talkMaxDuration)

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_6 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_1) / var_319_6

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_1 + var_319_6 and arg_316_1.time_ < var_319_1 + var_319_6 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play411071076 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 411071076
		arg_320_1.duration_ = 10.07

		local var_320_0 = {
			zh = 7.366,
			ja = 10.066
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play411071077(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0.975

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_1 = arg_320_1:GetWordFromCfg(411071076)
				local var_323_2 = arg_320_1:FormatText(var_323_1.content)

				arg_320_1.text_.text = var_323_2

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 39 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 39)

				if (39 <= 0 and var_323_0 or var_323_0 * (utf8.len(var_323_2) / 39)) > 0 and var_323_0 < var_323_4 then
					arg_320_1.talkMaxDuration = var_323_4

					if var_323_4 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_4 + 0
					end
				end

				arg_320_1.text_.text = var_323_2
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071076", "story_v_out_411071.awb") ~= 0 then
					local var_323_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071076", "story_v_out_411071.awb") / 1000

					if var_323_5 + 0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_5 + 0
					end

					if var_323_1.prefab_name ~= "" and arg_320_1.actors_[var_323_1.prefab_name] ~= nil then
						local var_323_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_1.prefab_name].transform, "story_v_out_411071", "411071076", "story_v_out_411071.awb")

						arg_320_1:RecordAudio("411071076", var_323_6)
						arg_320_1:RecordAudio("411071076", var_323_6)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_411071", "411071076", "story_v_out_411071.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_411071", "411071076", "story_v_out_411071.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_0, arg_320_1.talkMaxDuration)

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - 0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= 0 + var_323_7 and arg_320_1.time_ < 0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play411071077 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 411071077
		arg_324_1.duration_ = 7.43

		local var_324_0 = {
			zh = 5.133,
			ja = 7.433
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play411071078(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0.75

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_1 = arg_324_1:GetWordFromCfg(411071077)
				local var_327_2 = arg_324_1:FormatText(var_327_1.content)

				arg_324_1.text_.text = var_327_2

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 30 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 30)

				if (30 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 30)) > 0 and var_327_0 < var_327_4 then
					arg_324_1.talkMaxDuration = var_327_4

					if var_327_4 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_4 + 0
					end
				end

				arg_324_1.text_.text = var_327_2
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071077", "story_v_out_411071.awb") ~= 0 then
					local var_327_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071077", "story_v_out_411071.awb") / 1000

					if var_327_5 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_5 + 0
					end

					if var_327_1.prefab_name ~= "" and arg_324_1.actors_[var_327_1.prefab_name] ~= nil then
						local var_327_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_1.prefab_name].transform, "story_v_out_411071", "411071077", "story_v_out_411071.awb")

						arg_324_1:RecordAudio("411071077", var_327_6)
						arg_324_1:RecordAudio("411071077", var_327_6)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_411071", "411071077", "story_v_out_411071.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_411071", "411071077", "story_v_out_411071.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_7 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_7 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_7

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_7 and arg_324_1.time_ < 0 + var_327_7 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play411071078 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 411071078
		arg_328_1.duration_ = 8.7

		local var_328_0 = {
			zh = 8.7,
			ja = 4.7
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play411071079(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["10014ui_story"]) and arg_328_1.var_.characterEffect10014ui_story == nil then
				arg_328_1.var_.characterEffect10014ui_story = arg_328_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_0 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["10014ui_story"]) then
				if arg_328_1.var_.characterEffect10014ui_story and not isNil(arg_328_1.actors_["10014ui_story"]) then
					arg_328_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["10014ui_story"]) and arg_328_1.var_.characterEffect10014ui_story then
				arg_328_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_331_2 = 0
			local var_331_3 = 0.575

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_2 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_4 = arg_328_1:GetWordFromCfg(411071078)
				local var_331_5 = arg_328_1:FormatText(var_331_4.content)

				arg_328_1.text_.text = var_331_5

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_7 = 23 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_5) / 23)

				if (23 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_5) / 23)) > 0 and var_331_3 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_2 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_2
					end
				end

				arg_328_1.text_.text = var_331_5
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071078", "story_v_out_411071.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_out_411071", "411071078", "story_v_out_411071.awb") / 1000

					if var_331_8 + var_331_2 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_2
					end

					if var_331_4.prefab_name ~= "" and arg_328_1.actors_[var_331_4.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_4.prefab_name].transform, "story_v_out_411071", "411071078", "story_v_out_411071.awb")

						arg_328_1:RecordAudio("411071078", var_331_9)
						arg_328_1:RecordAudio("411071078", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_411071", "411071078", "story_v_out_411071.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_411071", "411071078", "story_v_out_411071.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_3, arg_328_1.talkMaxDuration)

			if var_331_2 <= arg_328_1.time_ and arg_328_1.time_ < var_331_2 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_2) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_2 + var_331_10 and arg_328_1.time_ < var_331_2 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play411071079 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 411071079
		arg_332_1.duration_ = 1.97

		local var_332_0 = {
			zh = 1.4,
			ja = 1.966
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play411071080(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos10014ui_story = arg_332_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_335_0 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 then
				arg_332_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_332_1.time_ - 0) / var_335_0)
				arg_332_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10014ui_story"].transform.position).z)
				arg_332_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["10014ui_story"].transform.localEulerAngles = arg_332_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 then
				arg_332_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_332_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["10014ui_story"].transform.position).z)
				arg_332_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["10014ui_story"].transform.localEulerAngles = arg_332_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_335_1 = arg_332_1.actors_["10014ui_story"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_1) and arg_332_1.var_.characterEffect10014ui_story == nil then
				arg_332_1.var_.characterEffect10014ui_story = var_335_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_2 and not isNil(var_335_1) then
				if arg_332_1.var_.characterEffect10014ui_story and not isNil(var_335_1) then
					arg_332_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= 0 + var_335_2 and arg_332_1.time_ < 0 + var_335_2 + arg_335_0 and not isNil(var_335_1) and arg_332_1.var_.characterEffect10014ui_story then
				arg_332_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_335_4 = 0
			local var_335_5 = 0.175

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_4 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_6 = arg_332_1:GetWordFromCfg(411071079)
				local var_335_7 = arg_332_1:FormatText(var_335_6.content)

				arg_332_1.text_.text = var_335_7

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_9 = 7 <= 0 and var_335_5 or var_335_5 * (utf8.len(var_335_7) / 7)

				if (7 <= 0 and var_335_5 or var_335_5 * (utf8.len(var_335_7) / 7)) > 0 and var_335_5 < var_335_9 then
					arg_332_1.talkMaxDuration = var_335_9

					if var_335_9 + var_335_4 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_9 + var_335_4
					end
				end

				arg_332_1.text_.text = var_335_7
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071079", "story_v_out_411071.awb") ~= 0 then
					local var_335_10 = manager.audio:GetVoiceLength("story_v_out_411071", "411071079", "story_v_out_411071.awb") / 1000

					if var_335_10 + var_335_4 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_10 + var_335_4
					end

					if var_335_6.prefab_name ~= "" and arg_332_1.actors_[var_335_6.prefab_name] ~= nil then
						local var_335_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_6.prefab_name].transform, "story_v_out_411071", "411071079", "story_v_out_411071.awb")

						arg_332_1:RecordAudio("411071079", var_335_11)
						arg_332_1:RecordAudio("411071079", var_335_11)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_411071", "411071079", "story_v_out_411071.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_411071", "411071079", "story_v_out_411071.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_12 = math.max(var_335_5, arg_332_1.talkMaxDuration)

			if var_335_4 <= arg_332_1.time_ and arg_332_1.time_ < var_335_4 + var_335_12 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_4) / var_335_12

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_4 + var_335_12 and arg_332_1.time_ < var_335_4 + var_335_12 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play411071080 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 411071080
		arg_336_1.duration_ = 10.73

		local var_336_0 = {
			zh = 6.7,
			ja = 10.733
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play411071081(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(arg_336_1.actors_["10014ui_story"]) and arg_336_1.var_.characterEffect10014ui_story == nil then
				arg_336_1.var_.characterEffect10014ui_story = arg_336_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_0 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 and not isNil(arg_336_1.actors_["10014ui_story"]) then
				if arg_336_1.var_.characterEffect10014ui_story and not isNil(arg_336_1.actors_["10014ui_story"]) then
					arg_336_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_336_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_336_1.time_ - 0) / var_339_0)
				end
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 and not isNil(arg_336_1.actors_["10014ui_story"]) and arg_336_1.var_.characterEffect10014ui_story then
				arg_336_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_336_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_339_1 = 0
			local var_339_2 = 0.975

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_3 = arg_336_1:GetWordFromCfg(411071080)
				local var_339_4 = arg_336_1:FormatText(var_339_3.content)

				arg_336_1.text_.text = var_339_4

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_6 = 39 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_4) / 39)

				if (39 <= 0 and var_339_2 or var_339_2 * (utf8.len(var_339_4) / 39)) > 0 and var_339_2 < var_339_6 then
					arg_336_1.talkMaxDuration = var_339_6

					if var_339_6 + var_339_1 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_6 + var_339_1
					end
				end

				arg_336_1.text_.text = var_339_4
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071080", "story_v_out_411071.awb") ~= 0 then
					local var_339_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071080", "story_v_out_411071.awb") / 1000

					if var_339_7 + var_339_1 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_1
					end

					if var_339_3.prefab_name ~= "" and arg_336_1.actors_[var_339_3.prefab_name] ~= nil then
						local var_339_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_3.prefab_name].transform, "story_v_out_411071", "411071080", "story_v_out_411071.awb")

						arg_336_1:RecordAudio("411071080", var_339_8)
						arg_336_1:RecordAudio("411071080", var_339_8)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_411071", "411071080", "story_v_out_411071.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_411071", "411071080", "story_v_out_411071.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_9 = math.max(var_339_2, arg_336_1.talkMaxDuration)

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_9 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_1) / var_339_9

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_1 + var_339_9 and arg_336_1.time_ < var_339_1 + var_339_9 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play411071081 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 411071081
		arg_340_1.duration_ = 8.33

		local var_340_0 = {
			zh = 8.333,
			ja = 7.533
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play411071082(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["10014ui_story"]) and arg_340_1.var_.characterEffect10014ui_story == nil then
				arg_340_1.var_.characterEffect10014ui_story = arg_340_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_0 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["10014ui_story"]) then
				if arg_340_1.var_.characterEffect10014ui_story and not isNil(arg_340_1.actors_["10014ui_story"]) then
					arg_340_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["10014ui_story"]) and arg_340_1.var_.characterEffect10014ui_story then
				arg_340_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_343_2 = 0
			local var_343_3 = 1.075

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_2 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_4 = arg_340_1:GetWordFromCfg(411071081)
				local var_343_5 = arg_340_1:FormatText(var_343_4.content)

				arg_340_1.text_.text = var_343_5

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_7 = 43 <= 0 and var_343_3 or var_343_3 * (utf8.len(var_343_5) / 43)

				if (43 <= 0 and var_343_3 or var_343_3 * (utf8.len(var_343_5) / 43)) > 0 and var_343_3 < var_343_7 then
					arg_340_1.talkMaxDuration = var_343_7

					if var_343_7 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_2
					end
				end

				arg_340_1.text_.text = var_343_5
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071081", "story_v_out_411071.awb") ~= 0 then
					local var_343_8 = manager.audio:GetVoiceLength("story_v_out_411071", "411071081", "story_v_out_411071.awb") / 1000

					if var_343_8 + var_343_2 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_8 + var_343_2
					end

					if var_343_4.prefab_name ~= "" and arg_340_1.actors_[var_343_4.prefab_name] ~= nil then
						local var_343_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_4.prefab_name].transform, "story_v_out_411071", "411071081", "story_v_out_411071.awb")

						arg_340_1:RecordAudio("411071081", var_343_9)
						arg_340_1:RecordAudio("411071081", var_343_9)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_411071", "411071081", "story_v_out_411071.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_411071", "411071081", "story_v_out_411071.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_10 = math.max(var_343_3, arg_340_1.talkMaxDuration)

			if var_343_2 <= arg_340_1.time_ and arg_340_1.time_ < var_343_2 + var_343_10 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_2) / var_343_10

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_2 + var_343_10 and arg_340_1.time_ < var_343_2 + var_343_10 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play411071082 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 411071082
		arg_344_1.duration_ = 8.33

		local var_344_0 = {
			zh = 8.333,
			ja = 7.1
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play411071083(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0.95

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_1 = arg_344_1:GetWordFromCfg(411071082)
				local var_347_2 = arg_344_1:FormatText(var_347_1.content)

				arg_344_1.text_.text = var_347_2

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_4 = 38 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 38)

				if (38 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 38)) > 0 and var_347_0 < var_347_4 then
					arg_344_1.talkMaxDuration = var_347_4

					if var_347_4 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_4 + 0
					end
				end

				arg_344_1.text_.text = var_347_2
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071082", "story_v_out_411071.awb") ~= 0 then
					local var_347_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071082", "story_v_out_411071.awb") / 1000

					if var_347_5 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + 0
					end

					if var_347_1.prefab_name ~= "" and arg_344_1.actors_[var_347_1.prefab_name] ~= nil then
						local var_347_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_1.prefab_name].transform, "story_v_out_411071", "411071082", "story_v_out_411071.awb")

						arg_344_1:RecordAudio("411071082", var_347_6)
						arg_344_1:RecordAudio("411071082", var_347_6)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_411071", "411071082", "story_v_out_411071.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_411071", "411071082", "story_v_out_411071.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_7 = math.max(var_347_0, arg_344_1.talkMaxDuration)

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_7 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - 0) / var_347_7

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= 0 + var_347_7 and arg_344_1.time_ < 0 + var_347_7 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play411071083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 411071083
		arg_348_1.duration_ = 6.97

		local var_348_0 = {
			zh = 6.966,
			ja = 4.5
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play411071084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.8

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_1 = arg_348_1:GetWordFromCfg(411071083)
				local var_351_2 = arg_348_1:FormatText(var_351_1.content)

				arg_348_1.text_.text = var_351_2

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 32 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 32)

				if (32 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 32)) > 0 and var_351_0 < var_351_4 then
					arg_348_1.talkMaxDuration = var_351_4

					if var_351_4 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_4 + 0
					end
				end

				arg_348_1.text_.text = var_351_2
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071083", "story_v_out_411071.awb") ~= 0 then
					local var_351_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071083", "story_v_out_411071.awb") / 1000

					if var_351_5 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + 0
					end

					if var_351_1.prefab_name ~= "" and arg_348_1.actors_[var_351_1.prefab_name] ~= nil then
						local var_351_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_1.prefab_name].transform, "story_v_out_411071", "411071083", "story_v_out_411071.awb")

						arg_348_1:RecordAudio("411071083", var_351_6)
						arg_348_1:RecordAudio("411071083", var_351_6)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_411071", "411071083", "story_v_out_411071.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_411071", "411071083", "story_v_out_411071.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_7 and arg_348_1.time_ < 0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play411071084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 411071084
		arg_352_1.duration_ = 10.33

		local var_352_0 = {
			zh = 3.133,
			ja = 10.333
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play411071085(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["10014ui_story"]) and arg_352_1.var_.characterEffect10014ui_story == nil then
				arg_352_1.var_.characterEffect10014ui_story = arg_352_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["10014ui_story"]) then
				if arg_352_1.var_.characterEffect10014ui_story and not isNil(arg_352_1.actors_["10014ui_story"]) then
					arg_352_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_352_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_0)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["10014ui_story"]) and arg_352_1.var_.characterEffect10014ui_story then
				arg_352_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_352_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_355_1 = 0
			local var_355_2 = 0.375

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:GetWordFromCfg(411071084)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_6 = 15 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_4) / 15)

				if (15 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_4) / 15)) > 0 and var_355_2 < var_355_6 then
					arg_352_1.talkMaxDuration = var_355_6

					if var_355_6 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_6 + var_355_1
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071084", "story_v_out_411071.awb") ~= 0 then
					local var_355_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071084", "story_v_out_411071.awb") / 1000

					if var_355_7 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_1
					end

					if var_355_3.prefab_name ~= "" and arg_352_1.actors_[var_355_3.prefab_name] ~= nil then
						local var_355_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_3.prefab_name].transform, "story_v_out_411071", "411071084", "story_v_out_411071.awb")

						arg_352_1:RecordAudio("411071084", var_355_8)
						arg_352_1:RecordAudio("411071084", var_355_8)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_411071", "411071084", "story_v_out_411071.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_411071", "411071084", "story_v_out_411071.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_9 = math.max(var_355_2, arg_352_1.talkMaxDuration)

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_9 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_1) / var_355_9

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_1 + var_355_9 and arg_352_1.time_ < var_355_1 + var_355_9 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play411071085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 411071085
		arg_356_1.duration_ = 5.67

		local var_356_0 = {
			zh = 4.7,
			ja = 5.666
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play411071086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0.625

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_1 = arg_356_1:GetWordFromCfg(411071085)
				local var_359_2 = arg_356_1:FormatText(var_359_1.content)

				arg_356_1.text_.text = var_359_2

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_4 = 25 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 25)

				if (25 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_2) / 25)) > 0 and var_359_0 < var_359_4 then
					arg_356_1.talkMaxDuration = var_359_4

					if var_359_4 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_4 + 0
					end
				end

				arg_356_1.text_.text = var_359_2
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071085", "story_v_out_411071.awb") ~= 0 then
					local var_359_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071085", "story_v_out_411071.awb") / 1000

					if var_359_5 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_5 + 0
					end

					if var_359_1.prefab_name ~= "" and arg_356_1.actors_[var_359_1.prefab_name] ~= nil then
						local var_359_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_1.prefab_name].transform, "story_v_out_411071", "411071085", "story_v_out_411071.awb")

						arg_356_1:RecordAudio("411071085", var_359_6)
						arg_356_1:RecordAudio("411071085", var_359_6)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_411071", "411071085", "story_v_out_411071.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_411071", "411071085", "story_v_out_411071.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_7 = math.max(var_359_0, arg_356_1.talkMaxDuration)

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_7 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - 0) / var_359_7

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= 0 + var_359_7 and arg_356_1.time_ < 0 + var_359_7 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play411071086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 411071086
		arg_360_1.duration_ = 8.3

		local var_360_0 = {
			zh = 8.3,
			ja = 6.5
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play411071087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 1.025

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_1 = arg_360_1:GetWordFromCfg(411071086)
				local var_363_2 = arg_360_1:FormatText(var_363_1.content)

				arg_360_1.text_.text = var_363_2

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_4 = 41 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 41)

				if (41 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 41)) > 0 and var_363_0 < var_363_4 then
					arg_360_1.talkMaxDuration = var_363_4

					if var_363_4 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_4 + 0
					end
				end

				arg_360_1.text_.text = var_363_2
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071086", "story_v_out_411071.awb") ~= 0 then
					local var_363_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071086", "story_v_out_411071.awb") / 1000

					if var_363_5 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + 0
					end

					if var_363_1.prefab_name ~= "" and arg_360_1.actors_[var_363_1.prefab_name] ~= nil then
						local var_363_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_1.prefab_name].transform, "story_v_out_411071", "411071086", "story_v_out_411071.awb")

						arg_360_1:RecordAudio("411071086", var_363_6)
						arg_360_1:RecordAudio("411071086", var_363_6)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_411071", "411071086", "story_v_out_411071.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_411071", "411071086", "story_v_out_411071.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_7 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_7 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_7

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_7 and arg_360_1.time_ < 0 + var_363_7 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play411071087 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 411071087
		arg_364_1.duration_ = 5.93

		local var_364_0 = {
			zh = 4.333,
			ja = 5.933
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play411071088(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.325

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_1 = arg_364_1:GetWordFromCfg(411071087)
				local var_367_2 = arg_364_1:FormatText(var_367_1.content)

				arg_364_1.text_.text = var_367_2

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_4 = 13 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 13)

				if (13 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 13)) > 0 and var_367_0 < var_367_4 then
					arg_364_1.talkMaxDuration = var_367_4

					if var_367_4 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_4 + 0
					end
				end

				arg_364_1.text_.text = var_367_2
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071087", "story_v_out_411071.awb") ~= 0 then
					local var_367_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071087", "story_v_out_411071.awb") / 1000

					if var_367_5 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + 0
					end

					if var_367_1.prefab_name ~= "" and arg_364_1.actors_[var_367_1.prefab_name] ~= nil then
						local var_367_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_1.prefab_name].transform, "story_v_out_411071", "411071087", "story_v_out_411071.awb")

						arg_364_1:RecordAudio("411071087", var_367_6)
						arg_364_1:RecordAudio("411071087", var_367_6)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_411071", "411071087", "story_v_out_411071.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_411071", "411071087", "story_v_out_411071.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_7 and arg_364_1.time_ < 0 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play411071088 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 411071088
		arg_368_1.duration_ = 4.33

		local var_368_0 = {
			zh = 4.333,
			ja = 4.066
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play411071089(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0.5

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_1 = arg_368_1:GetWordFromCfg(411071088)
				local var_371_2 = arg_368_1:FormatText(var_371_1.content)

				arg_368_1.text_.text = var_371_2

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_4 = 20 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 20)

				if (20 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 20)) > 0 and var_371_0 < var_371_4 then
					arg_368_1.talkMaxDuration = var_371_4

					if var_371_4 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_4 + 0
					end
				end

				arg_368_1.text_.text = var_371_2
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071088", "story_v_out_411071.awb") ~= 0 then
					local var_371_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071088", "story_v_out_411071.awb") / 1000

					if var_371_5 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + 0
					end

					if var_371_1.prefab_name ~= "" and arg_368_1.actors_[var_371_1.prefab_name] ~= nil then
						local var_371_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_1.prefab_name].transform, "story_v_out_411071", "411071088", "story_v_out_411071.awb")

						arg_368_1:RecordAudio("411071088", var_371_6)
						arg_368_1:RecordAudio("411071088", var_371_6)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_411071", "411071088", "story_v_out_411071.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_411071", "411071088", "story_v_out_411071.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_7 and arg_368_1.time_ < 0 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play411071089 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 411071089
		arg_372_1.duration_ = 3.53

		local var_372_0 = {
			zh = 3.533,
			ja = 3.133
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play411071090(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.var_.moveOldPos10014ui_story = arg_372_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_375_0 = 0.001

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 then
				arg_372_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_372_1.time_ - 0) / var_375_0)
				arg_372_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["10014ui_story"].transform.position).z)
				arg_372_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["10014ui_story"].transform.localEulerAngles = arg_372_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 then
				arg_372_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, -1.06, -6.2)
				arg_372_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["10014ui_story"].transform.position).z)
				arg_372_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["10014ui_story"].transform.localEulerAngles = arg_372_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_375_1 = arg_372_1.actors_["10014ui_story"]

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(var_375_1) and arg_372_1.var_.characterEffect10014ui_story == nil then
				arg_372_1.var_.characterEffect10014ui_story = var_375_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_2 and not isNil(var_375_1) then
				if arg_372_1.var_.characterEffect10014ui_story and not isNil(var_375_1) then
					arg_372_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= 0 + var_375_2 and arg_372_1.time_ < 0 + var_375_2 + arg_375_0 and not isNil(var_375_1) and arg_372_1.var_.characterEffect10014ui_story then
				arg_372_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_375_4 = 0
			local var_375_5 = 0.275

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_4 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_6 = arg_372_1:GetWordFromCfg(411071089)
				local var_375_7 = arg_372_1:FormatText(var_375_6.content)

				arg_372_1.text_.text = var_375_7

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_9 = 11 <= 0 and var_375_5 or var_375_5 * (utf8.len(var_375_7) / 11)

				if (11 <= 0 and var_375_5 or var_375_5 * (utf8.len(var_375_7) / 11)) > 0 and var_375_5 < var_375_9 then
					arg_372_1.talkMaxDuration = var_375_9

					if var_375_9 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_9 + var_375_4
					end
				end

				arg_372_1.text_.text = var_375_7
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071089", "story_v_out_411071.awb") ~= 0 then
					local var_375_10 = manager.audio:GetVoiceLength("story_v_out_411071", "411071089", "story_v_out_411071.awb") / 1000

					if var_375_10 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_10 + var_375_4
					end

					if var_375_6.prefab_name ~= "" and arg_372_1.actors_[var_375_6.prefab_name] ~= nil then
						local var_375_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_6.prefab_name].transform, "story_v_out_411071", "411071089", "story_v_out_411071.awb")

						arg_372_1:RecordAudio("411071089", var_375_11)
						arg_372_1:RecordAudio("411071089", var_375_11)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_411071", "411071089", "story_v_out_411071.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_411071", "411071089", "story_v_out_411071.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_12 = math.max(var_375_5, arg_372_1.talkMaxDuration)

			if var_375_4 <= arg_372_1.time_ and arg_372_1.time_ < var_375_4 + var_375_12 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_4) / var_375_12

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_4 + var_375_12 and arg_372_1.time_ < var_375_4 + var_375_12 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play411071090 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 411071090
		arg_376_1.duration_ = 3.9

		local var_376_0 = {
			zh = 3.4,
			ja = 3.9
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play411071091(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.35

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_1 = arg_376_1:GetWordFromCfg(411071090)
				local var_379_2 = arg_376_1:FormatText(var_379_1.content)

				arg_376_1.text_.text = var_379_2

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 14 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 14)

				if (14 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 14)) > 0 and var_379_0 < var_379_4 then
					arg_376_1.talkMaxDuration = var_379_4

					if var_379_4 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_4 + 0
					end
				end

				arg_376_1.text_.text = var_379_2
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071090", "story_v_out_411071.awb") ~= 0 then
					local var_379_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071090", "story_v_out_411071.awb") / 1000

					if var_379_5 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + 0
					end

					if var_379_1.prefab_name ~= "" and arg_376_1.actors_[var_379_1.prefab_name] ~= nil then
						local var_379_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_1.prefab_name].transform, "story_v_out_411071", "411071090", "story_v_out_411071.awb")

						arg_376_1:RecordAudio("411071090", var_379_6)
						arg_376_1:RecordAudio("411071090", var_379_6)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_411071", "411071090", "story_v_out_411071.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_411071", "411071090", "story_v_out_411071.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_7 and arg_376_1.time_ < 0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play411071091 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 411071091
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play411071092(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["10014ui_story"]) and arg_380_1.var_.characterEffect10014ui_story == nil then
				arg_380_1.var_.characterEffect10014ui_story = arg_380_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_0 = 0.200000002980232

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["10014ui_story"]) then
				if arg_380_1.var_.characterEffect10014ui_story and not isNil(arg_380_1.actors_["10014ui_story"]) then
					arg_380_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_380_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_380_1.time_ - 0) / var_383_0)
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["10014ui_story"]) and arg_380_1.var_.characterEffect10014ui_story then
				arg_380_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_380_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_383_1 = 0
			local var_383_2 = 0.75

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_3 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(411071091).content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 30 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 30)

				if (30 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 30)) > 0 and var_383_2 < var_383_5 then
					arg_380_1.talkMaxDuration = var_383_5

					if var_383_5 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + var_383_1
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_6 = math.max(var_383_2, arg_380_1.talkMaxDuration)

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_6 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_1) / var_383_6

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_1 + var_383_6 and arg_380_1.time_ < var_383_1 + var_383_6 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play411071092 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 411071092
		arg_384_1.duration_ = 8.9

		local var_384_0 = {
			zh = 7.7,
			ja = 8.9
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play411071093(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 1.1

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_1 = arg_384_1:GetWordFromCfg(411071092)
				local var_387_2 = arg_384_1:FormatText(var_387_1.content)

				arg_384_1.text_.text = var_387_2

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_4 = 44 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 44)

				if (44 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 44)) > 0 and var_387_0 < var_387_4 then
					arg_384_1.talkMaxDuration = var_387_4

					if var_387_4 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_4 + 0
					end
				end

				arg_384_1.text_.text = var_387_2
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071092", "story_v_out_411071.awb") ~= 0 then
					local var_387_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071092", "story_v_out_411071.awb") / 1000

					if var_387_5 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + 0
					end

					if var_387_1.prefab_name ~= "" and arg_384_1.actors_[var_387_1.prefab_name] ~= nil then
						local var_387_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_1.prefab_name].transform, "story_v_out_411071", "411071092", "story_v_out_411071.awb")

						arg_384_1:RecordAudio("411071092", var_387_6)
						arg_384_1:RecordAudio("411071092", var_387_6)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_411071", "411071092", "story_v_out_411071.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_411071", "411071092", "story_v_out_411071.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_7 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_7 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_7

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_7 and arg_384_1.time_ < 0 + var_387_7 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play411071093 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 411071093
		arg_388_1.duration_ = 4.63

		local var_388_0 = {
			zh = 2.9,
			ja = 4.633
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play411071094(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0.35

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_1 = arg_388_1:GetWordFromCfg(411071093)
				local var_391_2 = arg_388_1:FormatText(var_391_1.content)

				arg_388_1.text_.text = var_391_2

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_4 = 14 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_2) / 14)

				if (14 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_2) / 14)) > 0 and var_391_0 < var_391_4 then
					arg_388_1.talkMaxDuration = var_391_4

					if var_391_4 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_4 + 0
					end
				end

				arg_388_1.text_.text = var_391_2
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071093", "story_v_out_411071.awb") ~= 0 then
					local var_391_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071093", "story_v_out_411071.awb") / 1000

					if var_391_5 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_5 + 0
					end

					if var_391_1.prefab_name ~= "" and arg_388_1.actors_[var_391_1.prefab_name] ~= nil then
						local var_391_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_1.prefab_name].transform, "story_v_out_411071", "411071093", "story_v_out_411071.awb")

						arg_388_1:RecordAudio("411071093", var_391_6)
						arg_388_1:RecordAudio("411071093", var_391_6)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_411071", "411071093", "story_v_out_411071.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_411071", "411071093", "story_v_out_411071.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_7 = math.max(var_391_0, arg_388_1.talkMaxDuration)

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_7 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - 0) / var_391_7

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= 0 + var_391_7 and arg_388_1.time_ < 0 + var_391_7 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play411071094 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 411071094
		arg_392_1.duration_ = 9.13

		local var_392_0 = {
			zh = 7.766,
			ja = 9.133
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play411071095(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014actionlink/10014action423")
			end

			local var_395_0 = arg_392_1.actors_["10014ui_story"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect10014ui_story == nil then
				arg_392_1.var_.characterEffect10014ui_story = var_395_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_1 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_1 and not isNil(var_395_0) then
				if arg_392_1.var_.characterEffect10014ui_story and not isNil(var_395_0) then
					arg_392_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= 0 + var_395_1 and arg_392_1.time_ < 0 + var_395_1 + arg_395_0 and not isNil(var_395_0) and arg_392_1.var_.characterEffect10014ui_story then
				arg_392_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_395_3 = 0
			local var_395_4 = 0.875

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_3 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_5 = arg_392_1:GetWordFromCfg(411071094)
				local var_395_6 = arg_392_1:FormatText(var_395_5.content)

				arg_392_1.text_.text = var_395_6

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_8 = 35 <= 0 and var_395_4 or var_395_4 * (utf8.len(var_395_6) / 35)

				if (35 <= 0 and var_395_4 or var_395_4 * (utf8.len(var_395_6) / 35)) > 0 and var_395_4 < var_395_8 then
					arg_392_1.talkMaxDuration = var_395_8

					if var_395_8 + var_395_3 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_8 + var_395_3
					end
				end

				arg_392_1.text_.text = var_395_6
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071094", "story_v_out_411071.awb") ~= 0 then
					local var_395_9 = manager.audio:GetVoiceLength("story_v_out_411071", "411071094", "story_v_out_411071.awb") / 1000

					if var_395_9 + var_395_3 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_9 + var_395_3
					end

					if var_395_5.prefab_name ~= "" and arg_392_1.actors_[var_395_5.prefab_name] ~= nil then
						local var_395_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_5.prefab_name].transform, "story_v_out_411071", "411071094", "story_v_out_411071.awb")

						arg_392_1:RecordAudio("411071094", var_395_10)
						arg_392_1:RecordAudio("411071094", var_395_10)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_411071", "411071094", "story_v_out_411071.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_411071", "411071094", "story_v_out_411071.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_11 = math.max(var_395_4, arg_392_1.talkMaxDuration)

			if var_395_3 <= arg_392_1.time_ and arg_392_1.time_ < var_395_3 + var_395_11 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_3) / var_395_11

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_3 + var_395_11 and arg_392_1.time_ < var_395_3 + var_395_11 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play411071095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 411071095
		arg_396_1.duration_ = 1.47

		local var_396_0 = {
			zh = 0.999999999999,
			ja = 1.466
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play411071096(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(arg_396_1.actors_["10014ui_story"]) and arg_396_1.var_.characterEffect10014ui_story == nil then
				arg_396_1.var_.characterEffect10014ui_story = arg_396_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_0 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 and not isNil(arg_396_1.actors_["10014ui_story"]) then
				if arg_396_1.var_.characterEffect10014ui_story and not isNil(arg_396_1.actors_["10014ui_story"]) then
					arg_396_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_396_1.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_396_1.time_ - 0) / var_399_0)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 and not isNil(arg_396_1.actors_["10014ui_story"]) and arg_396_1.var_.characterEffect10014ui_story then
				arg_396_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_396_1.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			local var_399_1 = 0
			local var_399_2 = 0.075

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_3 = arg_396_1:GetWordFromCfg(411071095)
				local var_399_4 = arg_396_1:FormatText(var_399_3.content)

				arg_396_1.text_.text = var_399_4

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_6 = 3 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_4) / 3)

				if (3 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_4) / 3)) > 0 and var_399_2 < var_399_6 then
					arg_396_1.talkMaxDuration = var_399_6

					if var_399_6 + var_399_1 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_6 + var_399_1
					end
				end

				arg_396_1.text_.text = var_399_4
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071095", "story_v_out_411071.awb") ~= 0 then
					local var_399_7 = manager.audio:GetVoiceLength("story_v_out_411071", "411071095", "story_v_out_411071.awb") / 1000

					if var_399_7 + var_399_1 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_1
					end

					if var_399_3.prefab_name ~= "" and arg_396_1.actors_[var_399_3.prefab_name] ~= nil then
						local var_399_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_3.prefab_name].transform, "story_v_out_411071", "411071095", "story_v_out_411071.awb")

						arg_396_1:RecordAudio("411071095", var_399_8)
						arg_396_1:RecordAudio("411071095", var_399_8)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_411071", "411071095", "story_v_out_411071.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_411071", "411071095", "story_v_out_411071.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_9 = math.max(var_399_2, arg_396_1.talkMaxDuration)

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_9 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_1) / var_399_9

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_1 + var_399_9 and arg_396_1.time_ < var_399_1 + var_399_9 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play411071096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 411071096
		arg_400_1.duration_ = 4.93

		local var_400_0 = {
			zh = 3.233,
			ja = 4.933
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play411071097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(arg_400_1.actors_["10014ui_story"]) and arg_400_1.var_.characterEffect10014ui_story == nil then
				arg_400_1.var_.characterEffect10014ui_story = arg_400_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_0 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 and not isNil(arg_400_1.actors_["10014ui_story"]) then
				if arg_400_1.var_.characterEffect10014ui_story and not isNil(arg_400_1.actors_["10014ui_story"]) then
					arg_400_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 and not isNil(arg_400_1.actors_["10014ui_story"]) and arg_400_1.var_.characterEffect10014ui_story then
				arg_400_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_403_2 = 0
			local var_403_3 = 0.325

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_2 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_4 = arg_400_1:GetWordFromCfg(411071096)
				local var_403_5 = arg_400_1:FormatText(var_403_4.content)

				arg_400_1.text_.text = var_403_5

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_7 = 13 <= 0 and var_403_3 or var_403_3 * (utf8.len(var_403_5) / 13)

				if (13 <= 0 and var_403_3 or var_403_3 * (utf8.len(var_403_5) / 13)) > 0 and var_403_3 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_2 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_2
					end
				end

				arg_400_1.text_.text = var_403_5
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071096", "story_v_out_411071.awb") ~= 0 then
					local var_403_8 = manager.audio:GetVoiceLength("story_v_out_411071", "411071096", "story_v_out_411071.awb") / 1000

					if var_403_8 + var_403_2 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_8 + var_403_2
					end

					if var_403_4.prefab_name ~= "" and arg_400_1.actors_[var_403_4.prefab_name] ~= nil then
						local var_403_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_4.prefab_name].transform, "story_v_out_411071", "411071096", "story_v_out_411071.awb")

						arg_400_1:RecordAudio("411071096", var_403_9)
						arg_400_1:RecordAudio("411071096", var_403_9)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_411071", "411071096", "story_v_out_411071.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_411071", "411071096", "story_v_out_411071.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_10 = math.max(var_403_3, arg_400_1.talkMaxDuration)

			if var_403_2 <= arg_400_1.time_ and arg_400_1.time_ < var_403_2 + var_403_10 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_2) / var_403_10

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_2 + var_403_10 and arg_400_1.time_ < var_403_2 + var_403_10 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play411071097 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 411071097
		arg_404_1.duration_ = 12.33

		local var_404_0 = {
			zh = 9.033,
			ja = 12.333
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play411071098(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if arg_404_1.bgs_.B06c == nil then
				local var_407_0 = Object.Instantiate(arg_404_1.paintGo_)

				var_407_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B06c")
				var_407_0.name = "B06c"
				var_407_0.transform.parent = arg_404_1.stage_.transform
				var_407_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_404_1.bgs_.B06c = var_407_0
			end

			if 2 < arg_404_1.time_ and arg_404_1.time_ <= 2 + arg_407_0 then
				local var_407_1 = arg_404_1.bgs_.B06c

				arg_404_1.bgs_.B06c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_407_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_407_2 = var_407_1:GetComponent("SpriteRenderer")

				if var_407_2 and var_407_2.sprite then
					local var_407_3 = 2 * (var_407_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_407_1.transform.localScale = Vector3.New(var_407_3 / var_407_2.sprite.bounds.size.y < var_407_3 * manager.ui.mainCameraCom_.aspect / var_407_2.sprite.bounds.size.x and var_407_3 * manager.ui.mainCameraCom_.aspect / var_407_2.sprite.bounds.size.x or var_407_3 / var_407_2.sprite.bounds.size.y, var_407_3 / var_407_2.sprite.bounds.size.y < var_407_3 * manager.ui.mainCameraCom_.aspect / var_407_2.sprite.bounds.size.x and var_407_3 * manager.ui.mainCameraCom_.aspect / var_407_2.sprite.bounds.size.x or var_407_3 / var_407_2.sprite.bounds.size.y, 0)
				end

				for iter_407_0, iter_407_1 in pairs(arg_404_1.bgs_) do
					if iter_407_0 ~= "B06c" then
						iter_407_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_407_4 = 0

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_4 + arg_407_0 then
				arg_404_1.mask_.enabled = true
				arg_404_1.mask_.raycastTarget = true

				arg_404_1:SetGaussion(false)
			end

			local var_407_5 = 2

			if var_407_4 <= arg_404_1.time_ and arg_404_1.time_ < var_407_4 + var_407_5 then
				local var_407_6 = Color.New(0, 0, 0)

				var_407_6.a = Mathf.Lerp(0, 1, (arg_404_1.time_ - var_407_4) / var_407_5)
				arg_404_1.mask_.color = var_407_6
			end

			if arg_404_1.time_ >= var_407_4 + var_407_5 and arg_404_1.time_ < var_407_4 + var_407_5 + arg_407_0 then
				local var_407_7 = Color.New(0, 0, 0)

				var_407_7.a = 1
				arg_404_1.mask_.color = var_407_7
			end

			local var_407_8 = 2

			if 2 < arg_404_1.time_ and arg_404_1.time_ <= var_407_8 + arg_407_0 then
				arg_404_1.mask_.enabled = true
				arg_404_1.mask_.raycastTarget = true

				arg_404_1:SetGaussion(false)
			end

			local var_407_9 = 2

			if var_407_8 <= arg_404_1.time_ and arg_404_1.time_ < var_407_8 + var_407_9 then
				local var_407_10 = Color.New(0, 0, 0)

				var_407_10.a = Mathf.Lerp(1, 0, (arg_404_1.time_ - var_407_8) / var_407_9)
				arg_404_1.mask_.color = var_407_10
			end

			if arg_404_1.time_ >= var_407_8 + var_407_9 and arg_404_1.time_ < var_407_8 + var_407_9 + arg_407_0 then
				local var_407_11 = Color.New(0, 0, 0)

				arg_404_1.mask_.enabled = false
				var_407_11.a = 0
				arg_404_1.mask_.color = var_407_11
			end

			local var_407_12 = arg_404_1.actors_["10014ui_story"].transform

			if 2 < arg_404_1.time_ and arg_404_1.time_ <= 2 + arg_407_0 then
				arg_404_1.var_.moveOldPos10014ui_story = var_407_12.localPosition
			end

			local var_407_13 = 0.001

			if 2 <= arg_404_1.time_ and arg_404_1.time_ < 2 + var_407_13 then
				var_407_12.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_404_1.time_ - 2) / var_407_13)
				var_407_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_407_12.position).x, (manager.ui.mainCamera.transform.position - var_407_12.position).y, (manager.ui.mainCamera.transform.position - var_407_12.position).z)
				var_407_12.localEulerAngles.z = 0
				var_407_12.localEulerAngles.x = 0
				var_407_12.localEulerAngles = var_407_12.localEulerAngles
			end

			if arg_404_1.time_ >= 2 + var_407_13 and arg_404_1.time_ < 2 + var_407_13 + arg_407_0 then
				var_407_12.localPosition = Vector3.New(0, 100, 0)
				var_407_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_407_12.position).x, (manager.ui.mainCamera.transform.position - var_407_12.position).y, (manager.ui.mainCamera.transform.position - var_407_12.position).z)
				var_407_12.localEulerAngles.z = 0
				var_407_12.localEulerAngles.x = 0
				var_407_12.localEulerAngles = var_407_12.localEulerAngles
			end

			if arg_404_1.frameCnt_ <= 1 then
				arg_404_1.dialog_:SetActive(false)
			end

			local var_407_14 = 4
			local var_407_15 = 0.525

			if 4 < arg_404_1.time_ and arg_404_1.time_ <= var_407_14 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0

				arg_404_1.dialog_:SetActive(true)

				arg_404_1.dialogCg_.alpha = 0

				local var_407_16 = LeanTween.value(arg_404_1.dialog_, 0, 1, 0.3)

				var_407_16:setOnUpdate(LuaHelper.FloatAction(function(arg_408_0)
					arg_404_1.dialogCg_.alpha = arg_408_0
				end))
				var_407_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_404_1.dialog_)
					var_407_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_404_1.duration_ = arg_404_1.duration_ + 0.3

				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_17 = arg_404_1:GetWordFromCfg(411071097)
				local var_407_18 = arg_404_1:FormatText(var_407_17.content)

				arg_404_1.text_.text = var_407_18

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_20 = 21 <= 0 and var_407_15 or var_407_15 * (utf8.len(var_407_18) / 21)

				if (21 <= 0 and var_407_15 or var_407_15 * (utf8.len(var_407_18) / 21)) > 0 and var_407_15 < var_407_20 then
					arg_404_1.talkMaxDuration = var_407_20
					var_407_14 = var_407_14 + 0.3

					if var_407_20 + var_407_14 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_20 + var_407_14
					end
				end

				arg_404_1.text_.text = var_407_18
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071097", "story_v_out_411071.awb") ~= 0 then
					local var_407_21 = manager.audio:GetVoiceLength("story_v_out_411071", "411071097", "story_v_out_411071.awb") / 1000

					if var_407_21 + var_407_14 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_21 + var_407_14
					end

					if var_407_17.prefab_name ~= "" and arg_404_1.actors_[var_407_17.prefab_name] ~= nil then
						local var_407_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_17.prefab_name].transform, "story_v_out_411071", "411071097", "story_v_out_411071.awb")

						arg_404_1:RecordAudio("411071097", var_407_22)
						arg_404_1:RecordAudio("411071097", var_407_22)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_411071", "411071097", "story_v_out_411071.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_411071", "411071097", "story_v_out_411071.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_23 = var_407_14 + 0.3
			local var_407_24 = math.max(var_407_15, arg_404_1.talkMaxDuration)

			if var_407_14 + 0.3 <= arg_404_1.time_ and arg_404_1.time_ < var_407_23 + var_407_24 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_23) / var_407_24

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_23 + var_407_24 and arg_404_1.time_ < var_407_23 + var_407_24 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play411071098 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 411071098
		arg_410_1.duration_ = 5.5

		local var_410_0 = {
			zh = 3.933,
			ja = 5.5
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play411071099(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0.525

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_1 = arg_410_1:GetWordFromCfg(411071098)
				local var_413_2 = arg_410_1:FormatText(var_413_1.content)

				arg_410_1.text_.text = var_413_2

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_4 = 21 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 21)

				if (21 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_2) / 21)) > 0 and var_413_0 < var_413_4 then
					arg_410_1.talkMaxDuration = var_413_4

					if var_413_4 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_4 + 0
					end
				end

				arg_410_1.text_.text = var_413_2
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071098", "story_v_out_411071.awb") ~= 0 then
					local var_413_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071098", "story_v_out_411071.awb") / 1000

					if var_413_5 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + 0
					end

					if var_413_1.prefab_name ~= "" and arg_410_1.actors_[var_413_1.prefab_name] ~= nil then
						local var_413_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_1.prefab_name].transform, "story_v_out_411071", "411071098", "story_v_out_411071.awb")

						arg_410_1:RecordAudio("411071098", var_413_6)
						arg_410_1:RecordAudio("411071098", var_413_6)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_411071", "411071098", "story_v_out_411071.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_411071", "411071098", "story_v_out_411071.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_7 = math.max(var_413_0, arg_410_1.talkMaxDuration)

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_7 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - 0) / var_413_7

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= 0 + var_413_7 and arg_410_1.time_ < 0 + var_413_7 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play411071099 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 411071099
		arg_414_1.duration_ = 5.9

		local var_414_0 = {
			zh = 5.9,
			ja = 3.9
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play411071100(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.725

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_1 = arg_414_1:GetWordFromCfg(411071099)
				local var_417_2 = arg_414_1:FormatText(var_417_1.content)

				arg_414_1.text_.text = var_417_2

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_4 = 29 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 29)

				if (29 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_2) / 29)) > 0 and var_417_0 < var_417_4 then
					arg_414_1.talkMaxDuration = var_417_4

					if var_417_4 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_4 + 0
					end
				end

				arg_414_1.text_.text = var_417_2
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071099", "story_v_out_411071.awb") ~= 0 then
					local var_417_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071099", "story_v_out_411071.awb") / 1000

					if var_417_5 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_5 + 0
					end

					if var_417_1.prefab_name ~= "" and arg_414_1.actors_[var_417_1.prefab_name] ~= nil then
						local var_417_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_1.prefab_name].transform, "story_v_out_411071", "411071099", "story_v_out_411071.awb")

						arg_414_1:RecordAudio("411071099", var_417_6)
						arg_414_1:RecordAudio("411071099", var_417_6)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_411071", "411071099", "story_v_out_411071.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_411071", "411071099", "story_v_out_411071.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_7 and arg_414_1.time_ < 0 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play411071100 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 411071100
		arg_418_1.duration_ = 3

		local var_418_0 = {
			zh = 2.2,
			ja = 3
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play411071101(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0.25

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_1 = arg_418_1:GetWordFromCfg(411071100)
				local var_421_2 = arg_418_1:FormatText(var_421_1.content)

				arg_418_1.text_.text = var_421_2

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_4 = 10 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_2) / 10)

				if (10 <= 0 and var_421_0 or var_421_0 * (utf8.len(var_421_2) / 10)) > 0 and var_421_0 < var_421_4 then
					arg_418_1.talkMaxDuration = var_421_4

					if var_421_4 + 0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_4 + 0
					end
				end

				arg_418_1.text_.text = var_421_2
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071100", "story_v_out_411071.awb") ~= 0 then
					local var_421_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071100", "story_v_out_411071.awb") / 1000

					if var_421_5 + 0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_5 + 0
					end

					if var_421_1.prefab_name ~= "" and arg_418_1.actors_[var_421_1.prefab_name] ~= nil then
						local var_421_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_1.prefab_name].transform, "story_v_out_411071", "411071100", "story_v_out_411071.awb")

						arg_418_1:RecordAudio("411071100", var_421_6)
						arg_418_1:RecordAudio("411071100", var_421_6)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_411071", "411071100", "story_v_out_411071.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_411071", "411071100", "story_v_out_411071.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_7 = math.max(var_421_0, arg_418_1.talkMaxDuration)

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_7 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - 0) / var_421_7

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= 0 + var_421_7 and arg_418_1.time_ < 0 + var_421_7 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play411071101 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 411071101
		arg_422_1.duration_ = 6.8

		local var_422_0 = {
			zh = 6.8,
			ja = 6.033
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play411071102(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0.85

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[682].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_1 = arg_422_1:GetWordFromCfg(411071101)
				local var_425_2 = arg_422_1:FormatText(var_425_1.content)

				arg_422_1.text_.text = var_425_2

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_4 = 34 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_2) / 34)

				if (34 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_2) / 34)) > 0 and var_425_0 < var_425_4 then
					arg_422_1.talkMaxDuration = var_425_4

					if var_425_4 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_4 + 0
					end
				end

				arg_422_1.text_.text = var_425_2
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071101", "story_v_out_411071.awb") ~= 0 then
					local var_425_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071101", "story_v_out_411071.awb") / 1000

					if var_425_5 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_5 + 0
					end

					if var_425_1.prefab_name ~= "" and arg_422_1.actors_[var_425_1.prefab_name] ~= nil then
						local var_425_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_1.prefab_name].transform, "story_v_out_411071", "411071101", "story_v_out_411071.awb")

						arg_422_1:RecordAudio("411071101", var_425_6)
						arg_422_1:RecordAudio("411071101", var_425_6)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_411071", "411071101", "story_v_out_411071.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_411071", "411071101", "story_v_out_411071.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_7 = math.max(var_425_0, arg_422_1.talkMaxDuration)

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_7 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - 0) / var_425_7

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= 0 + var_425_7 and arg_422_1.time_ < 0 + var_425_7 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play411071102 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 411071102
		arg_426_1.duration_ = 3.03

		local var_426_0 = {
			zh = 2.5,
			ja = 3.033
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
			arg_426_1.auto_ = false
		end

		function arg_426_1.playNext_(arg_428_0)
			arg_426_1.onStoryFinished_()
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0.2

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[681].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_1 = arg_426_1:GetWordFromCfg(411071102)
				local var_429_2 = arg_426_1:FormatText(var_429_1.content)

				arg_426_1.text_.text = var_429_2

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_4 = 8 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_2) / 8)

				if (8 <= 0 and var_429_0 or var_429_0 * (utf8.len(var_429_2) / 8)) > 0 and var_429_0 < var_429_4 then
					arg_426_1.talkMaxDuration = var_429_4

					if var_429_4 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_4 + 0
					end
				end

				arg_426_1.text_.text = var_429_2
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411071", "411071102", "story_v_out_411071.awb") ~= 0 then
					local var_429_5 = manager.audio:GetVoiceLength("story_v_out_411071", "411071102", "story_v_out_411071.awb") / 1000

					if var_429_5 + 0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_5 + 0
					end

					if var_429_1.prefab_name ~= "" and arg_426_1.actors_[var_429_1.prefab_name] ~= nil then
						local var_429_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_1.prefab_name].transform, "story_v_out_411071", "411071102", "story_v_out_411071.awb")

						arg_426_1:RecordAudio("411071102", var_429_6)
						arg_426_1:RecordAudio("411071102", var_429_6)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_411071", "411071102", "story_v_out_411071.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_411071", "411071102", "story_v_out_411071.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_7 = math.max(var_429_0, arg_426_1.talkMaxDuration)

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_7 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - 0) / var_429_7

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= 0 + var_429_7 and arg_426_1.time_ < 0 + var_429_7 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B03b",
		"TextureConfig/Background/B03c",
		"TextureConfig/Background/B03a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/B10f",
		"TextureConfig/Background/B06c"
	},
	voices = {
		"story_v_out_411071.awb"
	}
}
