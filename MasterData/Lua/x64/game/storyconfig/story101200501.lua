return {
	Play120051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play120051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J02g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J02g")
				var_4_0.name = "J02g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J02g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J02g

				arg_1_1.bgs_.J02g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J02g" then
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

			if 0.266666666666668 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666668 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1066", "se_story_1066_ui", "")
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

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
			local var_4_16 = 0.55

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

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(120051001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 22 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 22)

				if (22 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 22)) > 0 and var_4_16 < var_4_20 then
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
	Play120051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120051002
		arg_9_1.duration_ = 3.23

		local var_9_0 = {
			zh = 2.133,
			ja = 3.233
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
				arg_9_0:Play120051003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.125

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(120051002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 5 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 5)

				if (5 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 5)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051002", "story_v_out_120051.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_120051", "120051002", "story_v_out_120051.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_120051", "120051002", "story_v_out_120051.awb")

						arg_9_1:RecordAudio("120051002", var_12_6)
						arg_9_1:RecordAudio("120051002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_120051", "120051002", "story_v_out_120051.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_120051", "120051002", "story_v_out_120051.awb")
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
	Play120051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 120051003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play120051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.225

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(120051003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 9 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 9)

				if (9 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 9)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play120051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 120051004
		arg_17_1.duration_ = 4.3

		local var_17_0 = {
			zh = 3.3,
			ja = 4.3
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
				arg_17_0:Play120051005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.2

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(120051004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 8 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 8)

				if (8 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 8)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051004", "story_v_out_120051.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_120051", "120051004", "story_v_out_120051.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_120051", "120051004", "story_v_out_120051.awb")

						arg_17_1:RecordAudio("120051004", var_20_6)
						arg_17_1:RecordAudio("120051004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_120051", "120051004", "story_v_out_120051.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_120051", "120051004", "story_v_out_120051.awb")
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
	Play120051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 120051005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play120051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 1

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(120051005).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 40 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 40)

				if (40 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 40)) > 0 and var_24_0 < var_24_3 then
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
	Play120051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 120051006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play120051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.275

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

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(120051006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 11 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 11)

				if (11 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 11)) > 0 and var_28_0 < var_28_3 then
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
	Play120051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 120051007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play120051008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1071ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1071ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1071ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1071ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1071ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_32_3 = 0
			local var_32_4 = 1.025

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_5 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(120051007).content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 41 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 41)

				if (41 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 41)) > 0 and var_32_4 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_3
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_4, arg_29_1.talkMaxDuration)

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_3) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_3 + var_32_8 and arg_29_1.time_ < var_32_3 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play120051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 120051008
		arg_33_1.duration_ = 3.97

		local var_33_0 = {
			zh = 3.4,
			ja = 3.966
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
				arg_33_0:Play120051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1071ui_story = arg_33_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1071ui_story"].transform.position).z)
				arg_33_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1071ui_story"].transform.localEulerAngles = arg_33_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_33_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1071ui_story"].transform.position).z)
				arg_33_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1071ui_story"].transform.localEulerAngles = arg_33_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1071ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1071ui_story == nil then
				arg_33_1.var_.characterEffect1071ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1071ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1071ui_story then
				arg_33_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_36_4 = "1075ui_story"

			if arg_33_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_36_5 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_33_1.stage_.transform)

				var_36_5.name = var_36_4
				var_36_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_[var_36_4] = var_36_5

				local var_36_6 = var_36_5:GetComponentInChildren(typeof(CharacterEffect))

				var_36_6.enabled = true

				local var_36_7 = GameObjectTools.GetOrAddComponent(var_36_5, typeof(DynamicBoneHelper))

				if var_36_7 then
					var_36_7:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_6.transform, false)

				arg_33_1.var_[var_36_4 .. "Animator"] = var_36_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_[var_36_4 .. "Animator"].applyRootMotion = true
				arg_33_1.var_[var_36_4 .. "LipSync"] = var_36_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_8 = arg_33_1.actors_["1075ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1075ui_story = var_36_8.localPosition
			end

			local var_36_9 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_9 then
				var_36_8.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_33_1.time_ - 0) / var_36_9)
				var_36_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_8.position).x, (manager.ui.mainCamera.transform.position - var_36_8.position).y, (manager.ui.mainCamera.transform.position - var_36_8.position).z)
				var_36_8.localEulerAngles.z = 0
				var_36_8.localEulerAngles.x = 0
				var_36_8.localEulerAngles = var_36_8.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_9 and arg_33_1.time_ < 0 + var_36_9 + arg_36_0 then
				var_36_8.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_36_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_8.position).x, (manager.ui.mainCamera.transform.position - var_36_8.position).y, (manager.ui.mainCamera.transform.position - var_36_8.position).z)
				var_36_8.localEulerAngles.z = 0
				var_36_8.localEulerAngles.x = 0
				var_36_8.localEulerAngles = var_36_8.localEulerAngles
			end

			local var_36_10 = arg_33_1.actors_["1075ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_10) and arg_33_1.var_.characterEffect1075ui_story == nil then
				arg_33_1.var_.characterEffect1075ui_story = var_36_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_11 and not isNil(var_36_10) then
				if arg_33_1.var_.characterEffect1075ui_story and not isNil(var_36_10) then
					arg_33_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_11)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_11 and arg_33_1.time_ < 0 + var_36_11 + arg_36_0 and not isNil(var_36_10) and arg_33_1.var_.characterEffect1075ui_story then
				arg_33_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_36_12 = 0
			local var_36_13 = 0.4

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_14 = arg_33_1:GetWordFromCfg(120051008)
				local var_36_15 = arg_33_1:FormatText(var_36_14.content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 16 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 16)

				if (16 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 16)) > 0 and var_36_13 < var_36_17 then
					arg_33_1.talkMaxDuration = var_36_17

					if var_36_17 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_12
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051008", "story_v_out_120051.awb") ~= 0 then
					local var_36_18 = manager.audio:GetVoiceLength("story_v_out_120051", "120051008", "story_v_out_120051.awb") / 1000

					if var_36_18 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_12
					end

					if var_36_14.prefab_name ~= "" and arg_33_1.actors_[var_36_14.prefab_name] ~= nil then
						local var_36_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_14.prefab_name].transform, "story_v_out_120051", "120051008", "story_v_out_120051.awb")

						arg_33_1:RecordAudio("120051008", var_36_19)
						arg_33_1:RecordAudio("120051008", var_36_19)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_120051", "120051008", "story_v_out_120051.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_120051", "120051008", "story_v_out_120051.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_20 = math.max(var_36_13, arg_33_1.talkMaxDuration)

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_20 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_12) / var_36_20

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_12 + var_36_20 and arg_33_1.time_ < var_36_12 + var_36_20 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play120051009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 120051009
		arg_37_1.duration_ = 4.17

		local var_37_0 = {
			zh = 4.166,
			ja = 2.7
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
				arg_37_0:Play120051010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1071ui_story"]) and arg_37_1.var_.characterEffect1071ui_story == nil then
				arg_37_1.var_.characterEffect1071ui_story = arg_37_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1071ui_story"]) then
				if arg_37_1.var_.characterEffect1071ui_story and not isNil(arg_37_1.actors_["1071ui_story"]) then
					arg_37_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1071ui_story"]) and arg_37_1.var_.characterEffect1071ui_story then
				arg_37_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_40_1 = arg_37_1.actors_["1075ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1075ui_story == nil then
				arg_37_1.var_.characterEffect1075ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1075ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1075ui_story then
				arg_37_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_40_4 = 0
			local var_40_5 = 0.4

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(120051009)
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

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051009", "story_v_out_120051.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_120051", "120051009", "story_v_out_120051.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_120051", "120051009", "story_v_out_120051.awb")

						arg_37_1:RecordAudio("120051009", var_40_11)
						arg_37_1:RecordAudio("120051009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_120051", "120051009", "story_v_out_120051.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_120051", "120051009", "story_v_out_120051.awb")
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

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play120051010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 120051010
		arg_41_1.duration_ = 9.07

		local var_41_0 = {
			zh = 6.933,
			ja = 9.066
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
				arg_41_0:Play120051011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1071ui_story"]) and arg_41_1.var_.characterEffect1071ui_story == nil then
				arg_41_1.var_.characterEffect1071ui_story = arg_41_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1071ui_story"]) then
				if arg_41_1.var_.characterEffect1071ui_story and not isNil(arg_41_1.actors_["1071ui_story"]) then
					arg_41_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1071ui_story"]) and arg_41_1.var_.characterEffect1071ui_story then
				arg_41_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_44_2 = arg_41_1.actors_["1075ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1075ui_story == nil then
				arg_41_1.var_.characterEffect1075ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect1075ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_3)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1075ui_story then
				arg_41_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_44_4 = 0
			local var_44_5 = 0.775

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(120051010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 31 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 31)

				if (31 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 31)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051010", "story_v_out_120051.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_120051", "120051010", "story_v_out_120051.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_120051", "120051010", "story_v_out_120051.awb")

						arg_41_1:RecordAudio("120051010", var_44_11)
						arg_41_1:RecordAudio("120051010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_120051", "120051010", "story_v_out_120051.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_120051", "120051010", "story_v_out_120051.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play120051011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 120051011
		arg_45_1.duration_ = 11.2

		local var_45_0 = {
			zh = 6.966,
			ja = 11.2
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
				arg_45_0:Play120051012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.85

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(120051011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 34 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 34)

				if (34 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 34)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051011", "story_v_out_120051.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_120051", "120051011", "story_v_out_120051.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_120051", "120051011", "story_v_out_120051.awb")

						arg_45_1:RecordAudio("120051011", var_48_6)
						arg_45_1:RecordAudio("120051011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_120051", "120051011", "story_v_out_120051.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_120051", "120051011", "story_v_out_120051.awb")
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
	Play120051012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 120051012
		arg_49_1.duration_ = 7.57

		local var_49_0 = {
			zh = 3.5,
			ja = 7.566
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
				arg_49_0:Play120051013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1071ui_story"]) and arg_49_1.var_.characterEffect1071ui_story == nil then
				arg_49_1.var_.characterEffect1071ui_story = arg_49_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1071ui_story"]) then
				if arg_49_1.var_.characterEffect1071ui_story and not isNil(arg_49_1.actors_["1071ui_story"]) then
					arg_49_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1071ui_story"]) and arg_49_1.var_.characterEffect1071ui_story then
				arg_49_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.45

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(120051012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 18 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_4) / 18)

				if (18 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_4) / 18)) > 0 and var_52_2 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051012", "story_v_out_120051.awb") ~= 0 then
					local var_52_7 = manager.audio:GetVoiceLength("story_v_out_120051", "120051012", "story_v_out_120051.awb") / 1000

					if var_52_7 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_1
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_120051", "120051012", "story_v_out_120051.awb")

						arg_49_1:RecordAudio("120051012", var_52_8)
						arg_49_1:RecordAudio("120051012", var_52_8)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_120051", "120051012", "story_v_out_120051.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_120051", "120051012", "story_v_out_120051.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_9 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_9 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_9

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_9 and arg_49_1.time_ < var_52_1 + var_52_9 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play120051013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 120051013
		arg_53_1.duration_ = 11.6

		local var_53_0 = {
			zh = 6.633,
			ja = 11.6
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
				arg_53_0:Play120051014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1071ui_story"]) and arg_53_1.var_.characterEffect1071ui_story == nil then
				arg_53_1.var_.characterEffect1071ui_story = arg_53_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1071ui_story"]) then
				if arg_53_1.var_.characterEffect1071ui_story and not isNil(arg_53_1.actors_["1071ui_story"]) then
					arg_53_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1071ui_story"]) and arg_53_1.var_.characterEffect1071ui_story then
				arg_53_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action423")
			end

			local var_56_2 = 0
			local var_56_3 = 0.825

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(120051013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 33 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 33)

				if (33 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 33)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051013", "story_v_out_120051.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_120051", "120051013", "story_v_out_120051.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_120051", "120051013", "story_v_out_120051.awb")

						arg_53_1:RecordAudio("120051013", var_56_9)
						arg_53_1:RecordAudio("120051013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_120051", "120051013", "story_v_out_120051.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_120051", "120051013", "story_v_out_120051.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play120051014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 120051014
		arg_57_1.duration_ = 9

		local var_57_0 = {
			zh = 7.566,
			ja = 9
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
				arg_57_0:Play120051015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 1.15

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1069")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(120051014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 48 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 48)

				if (48 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 48)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051014", "story_v_out_120051.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_120051", "120051014", "story_v_out_120051.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_120051", "120051014", "story_v_out_120051.awb")

						arg_57_1:RecordAudio("120051014", var_60_6)
						arg_57_1:RecordAudio("120051014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_120051", "120051014", "story_v_out_120051.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_120051", "120051014", "story_v_out_120051.awb")
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
	Play120051015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 120051015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play120051016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1071ui_story = arg_61_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1071ui_story"].transform.position).z)
				arg_61_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1071ui_story"].transform.localEulerAngles = arg_61_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1071ui_story"].transform.position).z)
				arg_61_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1071ui_story"].transform.localEulerAngles = arg_61_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1075ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1075ui_story = var_64_1.localPosition
			end

			local var_64_2 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 then
				var_64_1.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_2)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 then
				var_64_1.localPosition = Vector3.New(0, 100, 0)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			local var_64_3 = 0
			local var_64_4 = 0.6

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(120051015).content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 24 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 24)

				if (24 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 24)) > 0 and var_64_4 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_3
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_4, arg_61_1.talkMaxDuration)

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_3) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_3 + var_64_8 and arg_61_1.time_ < var_64_3 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play120051016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 120051016
		arg_65_1.duration_ = 3.63

		local var_65_0 = {
			zh = 3,
			ja = 3.633
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
				arg_65_0:Play120051017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1071ui_story = arg_65_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1071ui_story"].transform.position).z)
				arg_65_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1071ui_story"].transform.localEulerAngles = arg_65_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_65_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1071ui_story"].transform.position).z)
				arg_65_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1071ui_story"].transform.localEulerAngles = arg_65_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_68_1 = "10044ui_story"

			if arg_65_1.actors_["10044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10044ui_story"))) then
				local var_68_2 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_65_1.stage_.transform)

				var_68_2.name = var_68_1
				var_68_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_[var_68_1] = var_68_2

				local var_68_3 = var_68_2:GetComponentInChildren(typeof(CharacterEffect))

				var_68_3.enabled = true

				local var_68_4 = GameObjectTools.GetOrAddComponent(var_68_2, typeof(DynamicBoneHelper))

				if var_68_4 then
					var_68_4:EnableDynamicBone(false)
				end

				arg_65_1:ShowWeapon(var_68_3.transform, false)

				arg_65_1.var_[var_68_1 .. "Animator"] = var_68_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_65_1.var_[var_68_1 .. "Animator"].applyRootMotion = true
				arg_65_1.var_[var_68_1 .. "LipSync"] = var_68_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_68_5 = arg_65_1.actors_["10044ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10044ui_story = var_68_5.localPosition
			end

			local var_68_6 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 then
				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10044ui_story, Vector3.New(0.7, -0.72, -6.3), (arg_65_1.time_ - 0) / var_68_6)
				var_68_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_5.position).x, (manager.ui.mainCamera.transform.position - var_68_5.position).y, (manager.ui.mainCamera.transform.position - var_68_5.position).z)
				var_68_5.localEulerAngles.z = 0
				var_68_5.localEulerAngles.x = 0
				var_68_5.localEulerAngles = var_68_5.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0.7, -0.72, -6.3)
				var_68_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_5.position).x, (manager.ui.mainCamera.transform.position - var_68_5.position).y, (manager.ui.mainCamera.transform.position - var_68_5.position).z)
				var_68_5.localEulerAngles.z = 0
				var_68_5.localEulerAngles.x = 0
				var_68_5.localEulerAngles = var_68_5.localEulerAngles
			end

			local var_68_7 = arg_65_1.actors_["1071ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.characterEffect1071ui_story == nil then
				arg_65_1.var_.characterEffect1071ui_story = var_68_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_8 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_8 and not isNil(var_68_7) then
				if arg_65_1.var_.characterEffect1071ui_story and not isNil(var_68_7) then
					arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_8 and arg_65_1.time_ < 0 + var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.characterEffect1071ui_story then
				arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_68_10 = arg_65_1.actors_["10044ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_10) and arg_65_1.var_.characterEffect10044ui_story == nil then
				arg_65_1.var_.characterEffect10044ui_story = var_68_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_11 and not isNil(var_68_10) then
				if arg_65_1.var_.characterEffect10044ui_story and not isNil(var_68_10) then
					arg_65_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_11)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_11 and arg_65_1.time_ < 0 + var_68_11 + arg_68_0 and not isNil(var_68_10) and arg_65_1.var_.characterEffect10044ui_story then
				arg_65_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_68_12 = 0
			local var_68_13 = 0.225

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_14 = arg_65_1:GetWordFromCfg(120051016)
				local var_68_15 = arg_65_1:FormatText(var_68_14.content)

				arg_65_1.text_.text = var_68_15

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_17 = 9 <= 0 and var_68_13 or var_68_13 * (utf8.len(var_68_15) / 9)

				if (9 <= 0 and var_68_13 or var_68_13 * (utf8.len(var_68_15) / 9)) > 0 and var_68_13 < var_68_17 then
					arg_65_1.talkMaxDuration = var_68_17

					if var_68_17 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_12
					end
				end

				arg_65_1.text_.text = var_68_15
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051016", "story_v_out_120051.awb") ~= 0 then
					local var_68_18 = manager.audio:GetVoiceLength("story_v_out_120051", "120051016", "story_v_out_120051.awb") / 1000

					if var_68_18 + var_68_12 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_18 + var_68_12
					end

					if var_68_14.prefab_name ~= "" and arg_65_1.actors_[var_68_14.prefab_name] ~= nil then
						local var_68_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_14.prefab_name].transform, "story_v_out_120051", "120051016", "story_v_out_120051.awb")

						arg_65_1:RecordAudio("120051016", var_68_19)
						arg_65_1:RecordAudio("120051016", var_68_19)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_120051", "120051016", "story_v_out_120051.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_120051", "120051016", "story_v_out_120051.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_20 = math.max(var_68_13, arg_65_1.talkMaxDuration)

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_20 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_12) / var_68_20

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_12 + var_68_20 and arg_65_1.time_ < var_68_12 + var_68_20 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play120051017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 120051017
		arg_69_1.duration_ = 6.8

		local var_69_0 = {
			zh = 5.333,
			ja = 6.8
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
				arg_69_0:Play120051018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1071ui_story"]) and arg_69_1.var_.characterEffect1071ui_story == nil then
				arg_69_1.var_.characterEffect1071ui_story = arg_69_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1071ui_story"]) then
				if arg_69_1.var_.characterEffect1071ui_story and not isNil(arg_69_1.actors_["1071ui_story"]) then
					arg_69_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1071ui_story"]) and arg_69_1.var_.characterEffect1071ui_story then
				arg_69_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_72_1 = arg_69_1.actors_["10044ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10044ui_story == nil then
				arg_69_1.var_.characterEffect10044ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect10044ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10044ui_story then
				arg_69_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_72_4 = 0
			local var_72_5 = 0.625

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(120051017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 25 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 25)

				if (25 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 25)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051017", "story_v_out_120051.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_120051", "120051017", "story_v_out_120051.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_120051", "120051017", "story_v_out_120051.awb")

						arg_69_1:RecordAudio("120051017", var_72_11)
						arg_69_1:RecordAudio("120051017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_120051", "120051017", "story_v_out_120051.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_120051", "120051017", "story_v_out_120051.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play120051018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 120051018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play120051019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10044ui_story"]) and arg_73_1.var_.characterEffect10044ui_story == nil then
				arg_73_1.var_.characterEffect10044ui_story = arg_73_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10044ui_story"]) then
				if arg_73_1.var_.characterEffect10044ui_story and not isNil(arg_73_1.actors_["10044ui_story"]) then
					arg_73_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10044ui_story"]) and arg_73_1.var_.characterEffect10044ui_story then
				arg_73_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_76_1 = 0
			local var_76_2 = 0.95

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

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(120051018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 38 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 38)

				if (38 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 38)) > 0 and var_76_2 < var_76_5 then
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
	Play120051019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 120051019
		arg_77_1.duration_ = 5.37

		local var_77_0 = {
			zh = 3.733,
			ja = 5.366
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
				arg_77_0:Play120051020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1075ui_story = arg_77_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1075ui_story"].transform.position).z)
				arg_77_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1075ui_story"].transform.localEulerAngles = arg_77_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				arg_77_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1075ui_story"].transform.position).z)
				arg_77_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1075ui_story"].transform.localEulerAngles = arg_77_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1071ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1071ui_story = var_80_1.localPosition
			end

			local var_80_2 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 then
				var_80_1.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_2)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 then
				var_80_1.localPosition = Vector3.New(0, 100, 0)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			local var_80_3 = arg_77_1.actors_["1075ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect1075ui_story == nil then
				arg_77_1.var_.characterEffect1075ui_story = var_80_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_4 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 and not isNil(var_80_3) then
				if arg_77_1.var_.characterEffect1075ui_story and not isNil(var_80_3) then
					arg_77_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect1075ui_story then
				arg_77_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_80_6 = 0
			local var_80_7 = 0.425

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:GetWordFromCfg(120051019)
				local var_80_9 = arg_77_1:FormatText(var_80_8.content)

				arg_77_1.text_.text = var_80_9

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_11 = 17 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 17)

				if (17 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_9) / 17)) > 0 and var_80_7 < var_80_11 then
					arg_77_1.talkMaxDuration = var_80_11

					if var_80_11 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_9
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051019", "story_v_out_120051.awb") ~= 0 then
					local var_80_12 = manager.audio:GetVoiceLength("story_v_out_120051", "120051019", "story_v_out_120051.awb") / 1000

					if var_80_12 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_12 + var_80_6
					end

					if var_80_8.prefab_name ~= "" and arg_77_1.actors_[var_80_8.prefab_name] ~= nil then
						local var_80_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_8.prefab_name].transform, "story_v_out_120051", "120051019", "story_v_out_120051.awb")

						arg_77_1:RecordAudio("120051019", var_80_13)
						arg_77_1:RecordAudio("120051019", var_80_13)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_120051", "120051019", "story_v_out_120051.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_120051", "120051019", "story_v_out_120051.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_14 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_14 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_14

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_14 and arg_77_1.time_ < var_80_6 + var_80_14 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play120051020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 120051020
		arg_81_1.duration_ = 6.03

		local var_81_0 = {
			zh = 6.033,
			ja = 3.366
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
				arg_81_0:Play120051021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10044ui_story"]) and arg_81_1.var_.characterEffect10044ui_story == nil then
				arg_81_1.var_.characterEffect10044ui_story = arg_81_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10044ui_story"]) then
				if arg_81_1.var_.characterEffect10044ui_story and not isNil(arg_81_1.actors_["10044ui_story"]) then
					arg_81_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10044ui_story"]) and arg_81_1.var_.characterEffect10044ui_story then
				arg_81_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_84_2 = arg_81_1.actors_["1075ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1075ui_story == nil then
				arg_81_1.var_.characterEffect1075ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect1075ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect1075ui_story then
				arg_81_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action432")
			end

			local var_84_4 = 0
			local var_84_5 = 0.7

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(120051020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 28 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 28)

				if (28 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 28)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051020", "story_v_out_120051.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_120051", "120051020", "story_v_out_120051.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_120051", "120051020", "story_v_out_120051.awb")

						arg_81_1:RecordAudio("120051020", var_84_11)
						arg_81_1:RecordAudio("120051020", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_120051", "120051020", "story_v_out_120051.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_120051", "120051020", "story_v_out_120051.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play120051021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 120051021
		arg_85_1.duration_ = 8

		local var_85_0 = {
			zh = 7.3,
			ja = 8
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
				arg_85_0:Play120051022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10044ui_story"]) and arg_85_1.var_.characterEffect10044ui_story == nil then
				arg_85_1.var_.characterEffect10044ui_story = arg_85_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10044ui_story"]) then
				if arg_85_1.var_.characterEffect10044ui_story and not isNil(arg_85_1.actors_["10044ui_story"]) then
					arg_85_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10044ui_story"]) and arg_85_1.var_.characterEffect10044ui_story then
				arg_85_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.8

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(120051021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 32 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 32)

				if (32 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 32)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051021", "story_v_out_120051.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_out_120051", "120051021", "story_v_out_120051.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_120051", "120051021", "story_v_out_120051.awb")

						arg_85_1:RecordAudio("120051021", var_88_8)
						arg_85_1:RecordAudio("120051021", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_120051", "120051021", "story_v_out_120051.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_120051", "120051021", "story_v_out_120051.awb")
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
	Play120051022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 120051022
		arg_89_1.duration_ = 4.87

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play120051023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if arg_89_1.bgs_.STblack == nil then
				local var_92_0 = Object.Instantiate(arg_89_1.paintGo_)

				var_92_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_92_0.name = "STblack"
				var_92_0.transform.parent = arg_89_1.stage_.transform
				var_92_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.bgs_.STblack = var_92_0
			end

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= 2 + arg_92_0 then
				local var_92_1 = arg_89_1.bgs_.STblack

				arg_89_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_92_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_2 = var_92_1:GetComponent("SpriteRenderer")

				if var_92_2 and var_92_2.sprite then
					local var_92_3 = 2 * (var_92_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_92_1.transform.localScale = Vector3.New(var_92_3 / var_92_2.sprite.bounds.size.y < var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x and var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x or var_92_3 / var_92_2.sprite.bounds.size.y, var_92_3 / var_92_2.sprite.bounds.size.y < var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x and var_92_3 * manager.ui.mainCameraCom_.aspect / var_92_2.sprite.bounds.size.x or var_92_3 / var_92_2.sprite.bounds.size.y, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "STblack" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_4 = 0

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_5 = 2

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_5 then
				local var_92_6 = Color.New(0, 0, 0)

				var_92_6.a = Mathf.Lerp(0, 1, (arg_89_1.time_ - var_92_4) / var_92_5)
				arg_89_1.mask_.color = var_92_6
			end

			if arg_89_1.time_ >= var_92_4 + var_92_5 and arg_89_1.time_ < var_92_4 + var_92_5 + arg_92_0 then
				local var_92_7 = Color.New(0, 0, 0)

				var_92_7.a = 1
				arg_89_1.mask_.color = var_92_7
			end

			local var_92_8 = 2

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_9 = 2

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_9 then
				local var_92_10 = Color.New(0, 0, 0)

				var_92_10.a = Mathf.Lerp(1, 0, (arg_89_1.time_ - var_92_8) / var_92_9)
				arg_89_1.mask_.color = var_92_10
			end

			if arg_89_1.time_ >= var_92_8 + var_92_9 and arg_89_1.time_ < var_92_8 + var_92_9 + arg_92_0 then
				local var_92_11 = Color.New(0, 0, 0)

				arg_89_1.mask_.enabled = false
				var_92_11.a = 0
				arg_89_1.mask_.color = var_92_11
			end

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= 2 + arg_92_0 then
				arg_89_1.fswbg_:SetActive(true)
				arg_89_1.dialog_:SetActive(false)

				arg_89_1.fswtw_.percent = 0
				arg_89_1.fswt_.text = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(120051022).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.fswt_)

				arg_89_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_89_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_89_1.fswtw_:SetDirty()

				arg_89_1.typewritterCharCountI18N = 0

				SetActive(arg_89_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_89_1:ShowNextGo(false)
			end

			local var_92_12 = 2.01666666666667

			if 2.01666666666667 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 then
				arg_89_1.var_.oldValueTypewriter = arg_89_1.fswtw_.percent

				SetActive(arg_89_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_89_1:ShowNextGo(false)
			end

			local var_92_13 = 34
			local var_92_14 = 2.26666666666667
			local var_92_15, var_92_16 = arg_89_1:GetPercentByPara(arg_89_1:FormatText(arg_89_1:GetWordFromCfg(120051022).content), 1)

			if var_92_12 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				local var_92_17 = var_92_13 <= 0 and var_92_14 or var_92_14 * ((var_92_16 - arg_89_1.typewritterCharCountI18N) / var_92_13)

				if (var_92_13 <= 0 and var_92_14 or var_92_14 * ((var_92_16 - arg_89_1.typewritterCharCountI18N) / var_92_13)) > 0 and var_92_14 < var_92_17 then
					arg_89_1.talkMaxDuration = var_92_17

					if var_92_17 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_12
					end
				end
			end

			local var_92_18 = math.max(2.26666666666667, arg_89_1.talkMaxDuration)

			if var_92_12 <= arg_89_1.time_ and arg_89_1.time_ < var_92_12 + var_92_18 then
				arg_89_1.fswtw_.percent = Mathf.Lerp(arg_89_1.var_.oldValueTypewriter, var_92_15, (arg_89_1.time_ - var_92_12) / var_92_18)
				arg_89_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_89_1.fswtw_:SetDirty()
			end

			if arg_89_1.time_ >= var_92_12 + var_92_18 and arg_89_1.time_ < var_92_12 + var_92_18 + arg_92_0 then
				arg_89_1.fswtw_.percent = var_92_15

				arg_89_1.fswtw_:SetDirty()
				arg_89_1:ShowNextGo(true)

				arg_89_1.typewritterCharCountI18N = var_92_16
			end

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= 2 + arg_92_0 then
				local var_92_19 = arg_89_1.fswbg_.transform:Find("textbox/adapt/content") or arg_89_1.fswbg_.transform:Find("textbox/content")
				local var_92_20 = arg_89_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_92_21 = var_92_19:GetComponent("RectTransform")

				var_92_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_92_21.offsetMin = Vector2.New(0, 0)
				var_92_21.offsetMax = Vector2.New(0, 0)
			end

			local var_92_22 = arg_89_1.actors_["10044ui_story"].transform

			if 1.966 < arg_89_1.time_ and arg_89_1.time_ <= 1.966 + arg_92_0 then
				arg_89_1.var_.moveOldPos10044ui_story = var_92_22.localPosition
			end

			local var_92_23 = 0.001

			if 1.966 <= arg_89_1.time_ and arg_89_1.time_ < 1.966 + var_92_23 then
				var_92_22.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 1.966) / var_92_23)
				var_92_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_22.position).x, (manager.ui.mainCamera.transform.position - var_92_22.position).y, (manager.ui.mainCamera.transform.position - var_92_22.position).z)
				var_92_22.localEulerAngles.z = 0
				var_92_22.localEulerAngles.x = 0
				var_92_22.localEulerAngles = var_92_22.localEulerAngles
			end

			if arg_89_1.time_ >= 1.966 + var_92_23 and arg_89_1.time_ < 1.966 + var_92_23 + arg_92_0 then
				var_92_22.localPosition = Vector3.New(0, 100, 0)
				var_92_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_22.position).x, (manager.ui.mainCamera.transform.position - var_92_22.position).y, (manager.ui.mainCamera.transform.position - var_92_22.position).z)
				var_92_22.localEulerAngles.z = 0
				var_92_22.localEulerAngles.x = 0
				var_92_22.localEulerAngles = var_92_22.localEulerAngles
			end

			local var_92_24 = arg_89_1.actors_["1075ui_story"].transform

			if 1.966 < arg_89_1.time_ and arg_89_1.time_ <= 1.966 + arg_92_0 then
				arg_89_1.var_.moveOldPos1075ui_story = var_92_24.localPosition
			end

			local var_92_25 = 0.001

			if 1.966 <= arg_89_1.time_ and arg_89_1.time_ < 1.966 + var_92_25 then
				var_92_24.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 1.966) / var_92_25)
				var_92_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_24.position).x, (manager.ui.mainCamera.transform.position - var_92_24.position).y, (manager.ui.mainCamera.transform.position - var_92_24.position).z)
				var_92_24.localEulerAngles.z = 0
				var_92_24.localEulerAngles.x = 0
				var_92_24.localEulerAngles = var_92_24.localEulerAngles
			end

			if arg_89_1.time_ >= 1.966 + var_92_25 and arg_89_1.time_ < 1.966 + var_92_25 + arg_92_0 then
				var_92_24.localPosition = Vector3.New(0, 100, 0)
				var_92_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_24.position).x, (manager.ui.mainCamera.transform.position - var_92_24.position).y, (manager.ui.mainCamera.transform.position - var_92_24.position).z)
				var_92_24.localEulerAngles.z = 0
				var_92_24.localEulerAngles.x = 0
				var_92_24.localEulerAngles = var_92_24.localEulerAngles
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play120051023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 120051023
		arg_93_1.duration_ = 3.28

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play120051024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.fswbg_:SetActive(true)
				arg_93_1.dialog_:SetActive(false)

				arg_93_1.fswtw_.percent = 0
				arg_93_1.fswt_.text = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(120051023).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.fswt_)

				arg_93_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_93_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_93_1.fswtw_:SetDirty()

				arg_93_1.typewritterCharCountI18N = 0

				SetActive(arg_93_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_93_1:ShowNextGo(false)
			end

			local var_96_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.var_.oldValueTypewriter = arg_93_1.fswtw_.percent

				SetActive(arg_93_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_93_1:ShowNextGo(false)
			end

			local var_96_1 = 49
			local var_96_2 = 3.26666666666667
			local var_96_3, var_96_4 = arg_93_1:GetPercentByPara(arg_93_1:FormatText(arg_93_1:GetWordFromCfg(120051023).content), 1)

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				local var_96_5 = var_96_1 <= 0 and var_96_2 or var_96_2 * ((var_96_4 - arg_93_1.typewritterCharCountI18N) / var_96_1)

				if (var_96_1 <= 0 and var_96_2 or var_96_2 * ((var_96_4 - arg_93_1.typewritterCharCountI18N) / var_96_1)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_0
					end
				end
			end

			local var_96_6 = math.max(3.26666666666667, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_6 then
				arg_93_1.fswtw_.percent = Mathf.Lerp(arg_93_1.var_.oldValueTypewriter, var_96_3, (arg_93_1.time_ - var_96_0) / var_96_6)
				arg_93_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_93_1.fswtw_:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_6 and arg_93_1.time_ < var_96_0 + var_96_6 + arg_96_0 then
				arg_93_1.fswtw_.percent = var_96_3

				arg_93_1.fswtw_:SetDirty()
				arg_93_1:ShowNextGo(true)

				arg_93_1.typewritterCharCountI18N = var_96_4
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play120051024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 120051024
		arg_97_1.duration_ = 5.73

		local var_97_0 = {
			zh = 2.366,
			ja = 5.733
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
				arg_97_0:Play120051025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.fswbg_:SetActive(false)
				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_97_1:ShowNextGo(false)
			end

			local var_100_0 = 0
			local var_100_1 = 0.275

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_2 = arg_97_1:GetWordFromCfg(120051024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 11 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 11)

				if (11 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 11)) > 0 and var_100_1 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051024", "story_v_out_120051.awb") ~= 0 then
					local var_100_6 = manager.audio:GetVoiceLength("story_v_out_120051", "120051024", "story_v_out_120051.awb") / 1000

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end

					if var_100_2.prefab_name ~= "" and arg_97_1.actors_[var_100_2.prefab_name] ~= nil then
						local var_100_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_2.prefab_name].transform, "story_v_out_120051", "120051024", "story_v_out_120051.awb")

						arg_97_1:RecordAudio("120051024", var_100_7)
						arg_97_1:RecordAudio("120051024", var_100_7)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_120051", "120051024", "story_v_out_120051.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_120051", "120051024", "story_v_out_120051.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play120051025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 120051025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play120051026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_104_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_101_1.bgmTxt_.text ~= var_104_2 and arg_101_1.bgmTxt_.text ~= "" then
						if arg_101_1.bgmTxt2_.text ~= "" then
							arg_101_1.bgmTxt_.text = arg_101_1.bgmTxt2_.text
						end

						arg_101_1.bgmTxt2_.text = var_104_2

						arg_101_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_101_1.bgmTxt_.text = var_104_2
						arg_101_1.bgmTxt2_.text = var_104_2
					end

					if arg_101_1.bgmTimer then
						arg_101_1.bgmTimer:Stop()

						arg_101_1.bgmTimer = nil
					end

					if arg_101_1.settingData.show_music_name == 1 then
						arg_101_1.musicController:SetSelectedState("show")
						arg_101_1.musicAnimator_:Play("open", 0, 0)

						if arg_101_1.settingData.music_time ~= 0 then
							arg_101_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_101_1.settingData.music_time), function()
								if arg_101_1 == nil or isNil(arg_101_1.bgmTxt_) then
									return
								end

								arg_101_1.musicController:SetSelectedState("hide")
								arg_101_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_104_3 = 0
			local var_104_4 = 0.15

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_3 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_5 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(120051025).content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 6 <= 0 and var_104_4 or var_104_4 * (utf8.len(var_104_5) / 6)

				if (6 <= 0 and var_104_4 or var_104_4 * (utf8.len(var_104_5) / 6)) > 0 and var_104_4 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_3 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_3
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_4, arg_101_1.talkMaxDuration)

			if var_104_3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_3 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_3) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_3 + var_104_8 and arg_101_1.time_ < var_104_3 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play120051026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 120051026
		arg_106_1.duration_ = 0.02

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"

			SetActive(arg_106_1.choicesGo_, true)

			for iter_107_0, iter_107_1 in ipairs(arg_106_1.choices_) do
				SetActive(iter_107_1.go, iter_107_0 <= 2)
			end

			arg_106_1.choices_[1].txt.text = arg_106_1:FormatText(StoryChoiceCfg[370].name)
			arg_106_1.choices_[2].txt.text = arg_106_1:FormatText(StoryChoiceCfg[371].name)
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play120051027(arg_106_1)
			end

			if arg_108_0 == 2 then
				arg_106_0:Play120051027(arg_106_1)
			end

			arg_106_1:RecordChoiceLog(120051026, 370, 371)
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			return
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play120051027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 120051027
		arg_110_1.duration_ = 9

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play120051028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if arg_110_1.bgs_.J03f == nil then
				local var_113_0 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J03f")
				var_113_0.name = "J03f"
				var_113_0.transform.parent = arg_110_1.stage_.transform
				var_113_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_.J03f = var_113_0
			end

			if 2 < arg_110_1.time_ and arg_110_1.time_ <= 2 + arg_113_0 then
				local var_113_1 = arg_110_1.bgs_.J03f

				arg_110_1.bgs_.J03f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_113_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_2 = var_113_1:GetComponent("SpriteRenderer")

				if var_113_2 and var_113_2.sprite then
					local var_113_3 = 2 * (var_113_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_113_1.transform.localScale = Vector3.New(var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "J03f" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_4 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_5 = 2

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_5 then
				local var_113_6 = Color.New(0, 0, 0)

				var_113_6.a = Mathf.Lerp(0, 1, (arg_110_1.time_ - var_113_4) / var_113_5)
				arg_110_1.mask_.color = var_113_6
			end

			if arg_110_1.time_ >= var_113_4 + var_113_5 and arg_110_1.time_ < var_113_4 + var_113_5 + arg_113_0 then
				local var_113_7 = Color.New(0, 0, 0)

				var_113_7.a = 1
				arg_110_1.mask_.color = var_113_7
			end

			local var_113_8 = 2

			if 2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_8 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_9 = 2

			if var_113_8 <= arg_110_1.time_ and arg_110_1.time_ < var_113_8 + var_113_9 then
				local var_113_10 = Color.New(0, 0, 0)

				var_113_10.a = Mathf.Lerp(1, 0, (arg_110_1.time_ - var_113_8) / var_113_9)
				arg_110_1.mask_.color = var_113_10
			end

			if arg_110_1.time_ >= var_113_8 + var_113_9 and arg_110_1.time_ < var_113_8 + var_113_9 + arg_113_0 then
				local var_113_11 = Color.New(0, 0, 0)

				arg_110_1.mask_.enabled = false
				var_113_11.a = 0
				arg_110_1.mask_.color = var_113_11
			end

			local var_113_12 = manager.ui.mainCamera.transform

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= 4 + arg_113_0 then
				arg_110_1.var_.shakeOldPos = var_113_12.localPosition
			end

			local var_113_13 = 0.5

			if 4 <= arg_110_1.time_ and arg_110_1.time_ < 4 + var_113_13 then
				local var_113_14, var_113_15 = math.modf((arg_110_1.time_ - 4) / 0.066)

				var_113_12.localPosition = Vector3.New(var_113_15 * 0.13, var_113_15 * 0.13, var_113_15 * 0.13) + arg_110_1.var_.shakeOldPos
			end

			if arg_110_1.time_ >= 4 + var_113_13 and arg_110_1.time_ < 4 + var_113_13 + arg_113_0 then
				var_113_12.localPosition = arg_110_1.var_.shakeOldPos
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_16 = 4
			local var_113_17 = 0.875

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_18 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_18:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_19 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(120051027).content)

				arg_110_1.text_.text = var_113_19

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_21 = 35 <= 0 and var_113_17 or var_113_17 * (utf8.len(var_113_19) / 35)

				if (35 <= 0 and var_113_17 or var_113_17 * (utf8.len(var_113_19) / 35)) > 0 and var_113_17 < var_113_21 then
					arg_110_1.talkMaxDuration = var_113_21
					var_113_16 = var_113_16 + 0.3

					if var_113_21 + var_113_16 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_21 + var_113_16
					end
				end

				arg_110_1.text_.text = var_113_19
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_22 = var_113_16 + 0.3
			local var_113_23 = math.max(var_113_17, arg_110_1.talkMaxDuration)

			if var_113_16 + 0.3 <= arg_110_1.time_ and arg_110_1.time_ < var_113_22 + var_113_23 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_22) / var_113_23

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_22 + var_113_23 and arg_110_1.time_ < var_113_22 + var_113_23 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play120051028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 120051028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play120051029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.175

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(120051028).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 7 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 7)

				if (7 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 7)) > 0 and var_119_0 < var_119_3 then
					arg_116_1.talkMaxDuration = var_119_3

					if var_119_3 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_3 + 0
					end
				end

				arg_116_1.text_.text = var_119_1
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_4 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_4

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play120051029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 120051029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play120051030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 1.025

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(120051029).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 41 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 41)

				if (41 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 41)) > 0 and var_123_0 < var_123_3 then
					arg_120_1.talkMaxDuration = var_123_3

					if var_123_3 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_3 + 0
					end
				end

				arg_120_1.text_.text = var_123_1
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_4 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_4

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play120051030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 120051030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play120051031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_127_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_124_1.bgmTxt_.text ~= var_127_2 and arg_124_1.bgmTxt_.text ~= "" then
						if arg_124_1.bgmTxt2_.text ~= "" then
							arg_124_1.bgmTxt_.text = arg_124_1.bgmTxt2_.text
						end

						arg_124_1.bgmTxt2_.text = var_127_2

						arg_124_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_124_1.bgmTxt_.text = var_127_2
						arg_124_1.bgmTxt2_.text = var_127_2
					end

					if arg_124_1.bgmTimer then
						arg_124_1.bgmTimer:Stop()

						arg_124_1.bgmTimer = nil
					end

					if arg_124_1.settingData.show_music_name == 1 then
						arg_124_1.musicController:SetSelectedState("show")
						arg_124_1.musicAnimator_:Play("open", 0, 0)

						if arg_124_1.settingData.music_time ~= 0 then
							arg_124_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_124_1.settingData.music_time), function()
								if arg_124_1 == nil or isNil(arg_124_1.bgmTxt_) then
									return
								end

								arg_124_1.musicController:SetSelectedState("hide")
								arg_124_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.1 < arg_124_1.time_ and arg_124_1.time_ <= 0.1 + arg_127_0 then
				arg_124_1:AudioAction("play", "music", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu.awb")

				local var_127_5 = manager.audio:GetAudioName("bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu")

				if "" ~= "" then
					if arg_124_1.bgmTxt_.text ~= var_127_5 and arg_124_1.bgmTxt_.text ~= "" then
						if arg_124_1.bgmTxt2_.text ~= "" then
							arg_124_1.bgmTxt_.text = arg_124_1.bgmTxt2_.text
						end

						arg_124_1.bgmTxt2_.text = var_127_5

						arg_124_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_124_1.bgmTxt_.text = var_127_5
						arg_124_1.bgmTxt2_.text = var_127_5
					end

					if arg_124_1.bgmTimer then
						arg_124_1.bgmTimer:Stop()

						arg_124_1.bgmTimer = nil
					end

					if arg_124_1.settingData.show_music_name == 1 then
						arg_124_1.musicController:SetSelectedState("show")
						arg_124_1.musicAnimator_:Play("open", 0, 0)

						if arg_124_1.settingData.music_time ~= 0 then
							arg_124_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_124_1.settingData.music_time), function()
								if arg_124_1 == nil or isNil(arg_124_1.bgmTxt_) then
									return
								end

								arg_124_1.musicController:SetSelectedState("hide")
								arg_124_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_127_6 = 0
			local var_127_7 = 1.175

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_8 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(120051030).content)

				arg_124_1.text_.text = var_127_8

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_10 = 47 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_8) / 47)

				if (47 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_8) / 47)) > 0 and var_127_7 < var_127_10 then
					arg_124_1.talkMaxDuration = var_127_10

					if var_127_10 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_8
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_11 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_11 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_11

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_11 and arg_124_1.time_ < var_127_6 + var_127_11 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play120051031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 120051031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play120051032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.825

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(120051031).content)

				arg_130_1.text_.text = var_133_1

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_3 = 33 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 33)

				if (33 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 33)) > 0 and var_133_0 < var_133_3 then
					arg_130_1.talkMaxDuration = var_133_3

					if var_133_3 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_3 + 0
					end
				end

				arg_130_1.text_.text = var_133_1
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_4 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_4

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play120051032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 120051032
		arg_134_1.duration_ = 2.63

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play120051033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if arg_134_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_137_0 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_134_1.stage_.transform)

				var_137_0.name = "1069ui_story"
				var_137_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_134_1.actors_["1069ui_story"] = var_137_0

				local var_137_1 = var_137_0:GetComponentInChildren(typeof(CharacterEffect))

				var_137_1.enabled = true

				local var_137_2 = GameObjectTools.GetOrAddComponent(var_137_0, typeof(DynamicBoneHelper))

				if var_137_2 then
					var_137_2:EnableDynamicBone(false)
				end

				arg_134_1:ShowWeapon(var_137_1.transform, false)

				arg_134_1.var_["1069ui_story" .. "Animator"] = var_137_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_134_1.var_["1069ui_story" .. "Animator"].applyRootMotion = true
				arg_134_1.var_["1069ui_story" .. "LipSync"] = var_137_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_137_3 = arg_134_1.actors_["1069ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1069ui_story = var_137_3.localPosition
			end

			local var_137_4 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 then
				var_137_3.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1069ui_story, Vector3.New(-0.7, -1, -6), (arg_134_1.time_ - 0) / var_137_4)
				var_137_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_3.position).x, (manager.ui.mainCamera.transform.position - var_137_3.position).y, (manager.ui.mainCamera.transform.position - var_137_3.position).z)
				var_137_3.localEulerAngles.z = 0
				var_137_3.localEulerAngles.x = 0
				var_137_3.localEulerAngles = var_137_3.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 then
				var_137_3.localPosition = Vector3.New(-0.7, -1, -6)
				var_137_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_3.position).x, (manager.ui.mainCamera.transform.position - var_137_3.position).y, (manager.ui.mainCamera.transform.position - var_137_3.position).z)
				var_137_3.localEulerAngles.z = 0
				var_137_3.localEulerAngles.x = 0
				var_137_3.localEulerAngles = var_137_3.localEulerAngles
			end

			local var_137_5 = arg_134_1.actors_["1069ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_5) and arg_134_1.var_.characterEffect1069ui_story == nil then
				arg_134_1.var_.characterEffect1069ui_story = var_137_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_6 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_6 and not isNil(var_137_5) then
				if arg_134_1.var_.characterEffect1069ui_story and not isNil(var_137_5) then
					arg_134_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_6 and arg_134_1.time_ < 0 + var_137_6 + arg_137_0 and not isNil(var_137_5) and arg_134_1.var_.characterEffect1069ui_story then
				arg_134_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_137_8 = arg_134_1.actors_["1075ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1075ui_story = var_137_8.localPosition
			end

			local var_137_9 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_9 then
				var_137_8.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_134_1.time_ - 0) / var_137_9)
				var_137_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_8.position).x, (manager.ui.mainCamera.transform.position - var_137_8.position).y, (manager.ui.mainCamera.transform.position - var_137_8.position).z)
				var_137_8.localEulerAngles.z = 0
				var_137_8.localEulerAngles.x = 0
				var_137_8.localEulerAngles = var_137_8.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_9 and arg_134_1.time_ < 0 + var_137_9 + arg_137_0 then
				var_137_8.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_137_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_8.position).x, (manager.ui.mainCamera.transform.position - var_137_8.position).y, (manager.ui.mainCamera.transform.position - var_137_8.position).z)
				var_137_8.localEulerAngles.z = 0
				var_137_8.localEulerAngles.x = 0
				var_137_8.localEulerAngles = var_137_8.localEulerAngles
			end

			local var_137_10 = arg_134_1.actors_["1075ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_10) and arg_134_1.var_.characterEffect1075ui_story == nil then
				arg_134_1.var_.characterEffect1075ui_story = var_137_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_11 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_11 and not isNil(var_137_10) then
				if arg_134_1.var_.characterEffect1075ui_story and not isNil(var_137_10) then
					arg_134_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_11)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_11 and arg_134_1.time_ < 0 + var_137_11 + arg_137_0 and not isNil(var_137_10) and arg_134_1.var_.characterEffect1075ui_story then
				arg_134_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_137_12 = 0
			local var_137_13 = 0.175

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_12 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_14 = arg_134_1:GetWordFromCfg(120051032)
				local var_137_15 = arg_134_1:FormatText(var_137_14.content)

				arg_134_1.text_.text = var_137_15

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_17 = 7 <= 0 and var_137_13 or var_137_13 * (utf8.len(var_137_15) / 7)

				if (7 <= 0 and var_137_13 or var_137_13 * (utf8.len(var_137_15) / 7)) > 0 and var_137_13 < var_137_17 then
					arg_134_1.talkMaxDuration = var_137_17

					if var_137_17 + var_137_12 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_17 + var_137_12
					end
				end

				arg_134_1.text_.text = var_137_15
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051032", "story_v_out_120051.awb") ~= 0 then
					local var_137_18 = manager.audio:GetVoiceLength("story_v_out_120051", "120051032", "story_v_out_120051.awb") / 1000

					if var_137_18 + var_137_12 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_18 + var_137_12
					end

					if var_137_14.prefab_name ~= "" and arg_134_1.actors_[var_137_14.prefab_name] ~= nil then
						local var_137_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_14.prefab_name].transform, "story_v_out_120051", "120051032", "story_v_out_120051.awb")

						arg_134_1:RecordAudio("120051032", var_137_19)
						arg_134_1:RecordAudio("120051032", var_137_19)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_120051", "120051032", "story_v_out_120051.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_120051", "120051032", "story_v_out_120051.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_20 = math.max(var_137_13, arg_134_1.talkMaxDuration)

			if var_137_12 <= arg_134_1.time_ and arg_134_1.time_ < var_137_12 + var_137_20 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_12) / var_137_20

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_12 + var_137_20 and arg_134_1.time_ < var_137_12 + var_137_20 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play120051033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 120051033
		arg_138_1.duration_ = 10.6

		local var_138_0 = {
			zh = 8.033,
			ja = 10.6
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
				arg_138_0:Play120051034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1069ui_story"]) and arg_138_1.var_.characterEffect1069ui_story == nil then
				arg_138_1.var_.characterEffect1069ui_story = arg_138_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1069ui_story"]) then
				if arg_138_1.var_.characterEffect1069ui_story and not isNil(arg_138_1.actors_["1069ui_story"]) then
					arg_138_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1069ui_story"]) and arg_138_1.var_.characterEffect1069ui_story then
				arg_138_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_141_1 = arg_138_1.actors_["1075ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1075ui_story == nil then
				arg_138_1.var_.characterEffect1075ui_story = var_141_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_2 and not isNil(var_141_1) then
				if arg_138_1.var_.characterEffect1075ui_story and not isNil(var_141_1) then
					arg_138_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_2 and arg_138_1.time_ < 0 + var_141_2 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1075ui_story then
				arg_138_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_141_4 = 0
			local var_141_5 = 0.775

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_4 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_6 = arg_138_1:GetWordFromCfg(120051033)
				local var_141_7 = arg_138_1:FormatText(var_141_6.content)

				arg_138_1.text_.text = var_141_7

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_9 = 31 <= 0 and var_141_5 or var_141_5 * (utf8.len(var_141_7) / 31)

				if (31 <= 0 and var_141_5 or var_141_5 * (utf8.len(var_141_7) / 31)) > 0 and var_141_5 < var_141_9 then
					arg_138_1.talkMaxDuration = var_141_9

					if var_141_9 + var_141_4 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_9 + var_141_4
					end
				end

				arg_138_1.text_.text = var_141_7
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051033", "story_v_out_120051.awb") ~= 0 then
					local var_141_10 = manager.audio:GetVoiceLength("story_v_out_120051", "120051033", "story_v_out_120051.awb") / 1000

					if var_141_10 + var_141_4 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_10 + var_141_4
					end

					if var_141_6.prefab_name ~= "" and arg_138_1.actors_[var_141_6.prefab_name] ~= nil then
						local var_141_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_6.prefab_name].transform, "story_v_out_120051", "120051033", "story_v_out_120051.awb")

						arg_138_1:RecordAudio("120051033", var_141_11)
						arg_138_1:RecordAudio("120051033", var_141_11)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_120051", "120051033", "story_v_out_120051.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_120051", "120051033", "story_v_out_120051.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_12 = math.max(var_141_5, arg_138_1.talkMaxDuration)

			if var_141_4 <= arg_138_1.time_ and arg_138_1.time_ < var_141_4 + var_141_12 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_4) / var_141_12

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_4 + var_141_12 and arg_138_1.time_ < var_141_4 + var_141_12 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play120051034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 120051034
		arg_142_1.duration_ = 5.1

		local var_142_0 = {
			zh = 5.1,
			ja = 3.2
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play120051035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0.4

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_1 = arg_142_1:GetWordFromCfg(120051034)
				local var_145_2 = arg_142_1:FormatText(var_145_1.content)

				arg_142_1.text_.text = var_145_2

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 16 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 16)

				if (16 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 16)) > 0 and var_145_0 < var_145_4 then
					arg_142_1.talkMaxDuration = var_145_4

					if var_145_4 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_4 + 0
					end
				end

				arg_142_1.text_.text = var_145_2
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051034", "story_v_out_120051.awb") ~= 0 then
					local var_145_5 = manager.audio:GetVoiceLength("story_v_out_120051", "120051034", "story_v_out_120051.awb") / 1000

					if var_145_5 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + 0
					end

					if var_145_1.prefab_name ~= "" and arg_142_1.actors_[var_145_1.prefab_name] ~= nil then
						local var_145_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_1.prefab_name].transform, "story_v_out_120051", "120051034", "story_v_out_120051.awb")

						arg_142_1:RecordAudio("120051034", var_145_6)
						arg_142_1:RecordAudio("120051034", var_145_6)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_120051", "120051034", "story_v_out_120051.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_120051", "120051034", "story_v_out_120051.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_7 and arg_142_1.time_ < 0 + var_145_7 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play120051035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 120051035
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play120051036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1069ui_story = arg_146_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_149_0 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1069ui_story"].transform.position).z)
				arg_146_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1069ui_story"].transform.localEulerAngles = arg_146_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_146_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1069ui_story"].transform.position).z)
				arg_146_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1069ui_story"].transform.localEulerAngles = arg_146_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_149_1 = arg_146_1.actors_["1075ui_story"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1075ui_story = var_149_1.localPosition
			end

			local var_149_2 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_2 then
				var_149_1.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 0) / var_149_2)
				var_149_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_1.position).x, (manager.ui.mainCamera.transform.position - var_149_1.position).y, (manager.ui.mainCamera.transform.position - var_149_1.position).z)
				var_149_1.localEulerAngles.z = 0
				var_149_1.localEulerAngles.x = 0
				var_149_1.localEulerAngles = var_149_1.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_2 and arg_146_1.time_ < 0 + var_149_2 + arg_149_0 then
				var_149_1.localPosition = Vector3.New(0, 100, 0)
				var_149_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_1.position).x, (manager.ui.mainCamera.transform.position - var_149_1.position).y, (manager.ui.mainCamera.transform.position - var_149_1.position).z)
				var_149_1.localEulerAngles.z = 0
				var_149_1.localEulerAngles.x = 0
				var_149_1.localEulerAngles = var_149_1.localEulerAngles
			end

			local var_149_3 = 0
			local var_149_4 = 1.275

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_3 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_5 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(120051035).content)

				arg_146_1.text_.text = var_149_5

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_7 = 51 <= 0 and var_149_4 or var_149_4 * (utf8.len(var_149_5) / 51)

				if (51 <= 0 and var_149_4 or var_149_4 * (utf8.len(var_149_5) / 51)) > 0 and var_149_4 < var_149_7 then
					arg_146_1.talkMaxDuration = var_149_7

					if var_149_7 + var_149_3 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_7 + var_149_3
					end
				end

				arg_146_1.text_.text = var_149_5
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_8 = math.max(var_149_4, arg_146_1.talkMaxDuration)

			if var_149_3 <= arg_146_1.time_ and arg_146_1.time_ < var_149_3 + var_149_8 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_3) / var_149_8

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_3 + var_149_8 and arg_146_1.time_ < var_149_3 + var_149_8 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play120051036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 120051036
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play120051037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_153_0 = 0
			local var_153_1 = 0.775

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_2 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(120051036).content)

				arg_150_1.text_.text = var_153_2

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 31 <= 0 and var_153_1 or var_153_1 * (utf8.len(var_153_2) / 31)

				if (31 <= 0 and var_153_1 or var_153_1 * (utf8.len(var_153_2) / 31)) > 0 and var_153_1 < var_153_4 then
					arg_150_1.talkMaxDuration = var_153_4

					if var_153_4 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_4 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_2
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_5 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_5 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_5

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_5 and arg_150_1.time_ < var_153_0 + var_153_5 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play120051037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 120051037
		arg_154_1.duration_ = 9.67

		local var_154_0 = {
			zh = 6.9,
			ja = 9.666
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play120051038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1071ui_story = arg_154_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_157_0 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 then
				arg_154_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_154_1.time_ - 0) / var_157_0)
				arg_154_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1071ui_story"].transform.position).z)
				arg_154_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1071ui_story"].transform.localEulerAngles = arg_154_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 then
				arg_154_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_154_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1071ui_story"].transform.position).z)
				arg_154_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1071ui_story"].transform.localEulerAngles = arg_154_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_157_1 = arg_154_1.actors_["1071ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_1) and arg_154_1.var_.characterEffect1071ui_story == nil then
				arg_154_1.var_.characterEffect1071ui_story = var_157_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_2 and not isNil(var_157_1) then
				if arg_154_1.var_.characterEffect1071ui_story and not isNil(var_157_1) then
					arg_154_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_2 and arg_154_1.time_ < 0 + var_157_2 + arg_157_0 and not isNil(var_157_1) and arg_154_1.var_.characterEffect1071ui_story then
				arg_154_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_157_4 = 0
			local var_157_5 = 1

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_6 = arg_154_1:GetWordFromCfg(120051037)
				local var_157_7 = arg_154_1:FormatText(var_157_6.content)

				arg_154_1.text_.text = var_157_7

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_9 = 42 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 42)

				if (42 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 42)) > 0 and var_157_5 < var_157_9 then
					arg_154_1.talkMaxDuration = var_157_9

					if var_157_9 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_4
					end
				end

				arg_154_1.text_.text = var_157_7
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051037", "story_v_out_120051.awb") ~= 0 then
					local var_157_10 = manager.audio:GetVoiceLength("story_v_out_120051", "120051037", "story_v_out_120051.awb") / 1000

					if var_157_10 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_4
					end

					if var_157_6.prefab_name ~= "" and arg_154_1.actors_[var_157_6.prefab_name] ~= nil then
						local var_157_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_6.prefab_name].transform, "story_v_out_120051", "120051037", "story_v_out_120051.awb")

						arg_154_1:RecordAudio("120051037", var_157_11)
						arg_154_1:RecordAudio("120051037", var_157_11)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_120051", "120051037", "story_v_out_120051.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_120051", "120051037", "story_v_out_120051.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_12 = math.max(var_157_5, arg_154_1.talkMaxDuration)

			if var_157_4 <= arg_154_1.time_ and arg_154_1.time_ < var_157_4 + var_157_12 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_4) / var_157_12

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_4 + var_157_12 and arg_154_1.time_ < var_157_4 + var_157_12 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play120051038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 120051038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play120051039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["1071ui_story"]) and arg_158_1.var_.characterEffect1071ui_story == nil then
				arg_158_1.var_.characterEffect1071ui_story = arg_158_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["1071ui_story"]) then
				if arg_158_1.var_.characterEffect1071ui_story and not isNil(arg_158_1.actors_["1071ui_story"]) then
					arg_158_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_0)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["1071ui_story"]) and arg_158_1.var_.characterEffect1071ui_story then
				arg_158_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_161_1 = 0
			local var_161_2 = 0.525

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_3 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(120051038).content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 21 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 21)

				if (21 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 21)) > 0 and var_161_2 < var_161_5 then
					arg_158_1.talkMaxDuration = var_161_5

					if var_161_5 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + var_161_1
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_6 = math.max(var_161_2, arg_158_1.talkMaxDuration)

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_6 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_1) / var_161_6

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_1 + var_161_6 and arg_158_1.time_ < var_161_1 + var_161_6 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play120051039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 120051039
		arg_162_1.duration_ = 2.6

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play120051040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1075ui_story = arg_162_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_165_0 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 then
				arg_162_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_162_1.time_ - 0) / var_165_0)
				arg_162_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1075ui_story"].transform.position).z)
				arg_162_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1075ui_story"].transform.localEulerAngles = arg_162_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 then
				arg_162_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				arg_162_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_162_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_162_1.actors_["1075ui_story"].transform.position).z)
				arg_162_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_162_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_162_1.actors_["1075ui_story"].transform.localEulerAngles = arg_162_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_165_1 = arg_162_1.actors_["1071ui_story"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1071ui_story = var_165_1.localPosition
			end

			local var_165_2 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_2 then
				var_165_1.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_162_1.time_ - 0) / var_165_2)
				var_165_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_1.position).x, (manager.ui.mainCamera.transform.position - var_165_1.position).y, (manager.ui.mainCamera.transform.position - var_165_1.position).z)
				var_165_1.localEulerAngles.z = 0
				var_165_1.localEulerAngles.x = 0
				var_165_1.localEulerAngles = var_165_1.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_2 and arg_162_1.time_ < 0 + var_165_2 + arg_165_0 then
				var_165_1.localPosition = Vector3.New(0, 100, 0)
				var_165_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_1.position).x, (manager.ui.mainCamera.transform.position - var_165_1.position).y, (manager.ui.mainCamera.transform.position - var_165_1.position).z)
				var_165_1.localEulerAngles.z = 0
				var_165_1.localEulerAngles.x = 0
				var_165_1.localEulerAngles = var_165_1.localEulerAngles
			end

			local var_165_3 = arg_162_1.actors_["1069ui_story"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos1069ui_story = var_165_3.localPosition
			end

			local var_165_4 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				var_165_3.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_162_1.time_ - 0) / var_165_4)
				var_165_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_3.position).x, (manager.ui.mainCamera.transform.position - var_165_3.position).y, (manager.ui.mainCamera.transform.position - var_165_3.position).z)
				var_165_3.localEulerAngles.z = 0
				var_165_3.localEulerAngles.x = 0
				var_165_3.localEulerAngles = var_165_3.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				var_165_3.localPosition = Vector3.New(0.7, -1, -6)
				var_165_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_3.position).x, (manager.ui.mainCamera.transform.position - var_165_3.position).y, (manager.ui.mainCamera.transform.position - var_165_3.position).z)
				var_165_3.localEulerAngles.z = 0
				var_165_3.localEulerAngles.x = 0
				var_165_3.localEulerAngles = var_165_3.localEulerAngles
			end

			local var_165_5 = arg_162_1.actors_["1069ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_5) and arg_162_1.var_.characterEffect1069ui_story == nil then
				arg_162_1.var_.characterEffect1069ui_story = var_165_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_6 = 0.034

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_6 and not isNil(var_165_5) then
				if arg_162_1.var_.characterEffect1069ui_story and not isNil(var_165_5) then
					arg_162_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_6)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_6 and arg_162_1.time_ < 0 + var_165_6 + arg_165_0 and not isNil(var_165_5) and arg_162_1.var_.characterEffect1069ui_story then
				arg_162_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_165_7 = arg_162_1.actors_["1075ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_7) and arg_162_1.var_.characterEffect1075ui_story == nil then
				arg_162_1.var_.characterEffect1075ui_story = var_165_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_8 = 0.2

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_8 and not isNil(var_165_7) then
				if arg_162_1.var_.characterEffect1075ui_story and not isNil(var_165_7) then
					arg_162_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_8 and arg_162_1.time_ < 0 + var_165_8 + arg_165_0 and not isNil(var_165_7) and arg_162_1.var_.characterEffect1075ui_story then
				arg_162_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_165_10 = 0
			local var_165_11 = 0.225

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_12 = arg_162_1:GetWordFromCfg(120051039)
				local var_165_13 = arg_162_1:FormatText(var_165_12.content)

				arg_162_1.text_.text = var_165_13

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_15 = 9 <= 0 and var_165_11 or var_165_11 * (utf8.len(var_165_13) / 9)

				if (9 <= 0 and var_165_11 or var_165_11 * (utf8.len(var_165_13) / 9)) > 0 and var_165_11 < var_165_15 then
					arg_162_1.talkMaxDuration = var_165_15

					if var_165_15 + var_165_10 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_15 + var_165_10
					end
				end

				arg_162_1.text_.text = var_165_13
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051039", "story_v_out_120051.awb") ~= 0 then
					local var_165_16 = manager.audio:GetVoiceLength("story_v_out_120051", "120051039", "story_v_out_120051.awb") / 1000

					if var_165_16 + var_165_10 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_16 + var_165_10
					end

					if var_165_12.prefab_name ~= "" and arg_162_1.actors_[var_165_12.prefab_name] ~= nil then
						local var_165_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_12.prefab_name].transform, "story_v_out_120051", "120051039", "story_v_out_120051.awb")

						arg_162_1:RecordAudio("120051039", var_165_17)
						arg_162_1:RecordAudio("120051039", var_165_17)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_120051", "120051039", "story_v_out_120051.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_120051", "120051039", "story_v_out_120051.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_18 = math.max(var_165_11, arg_162_1.talkMaxDuration)

			if var_165_10 <= arg_162_1.time_ and arg_162_1.time_ < var_165_10 + var_165_18 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_10) / var_165_18

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_10 + var_165_18 and arg_162_1.time_ < var_165_10 + var_165_18 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play120051040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 120051040
		arg_166_1.duration_ = 4.97

		local var_166_0 = {
			zh = 2.166,
			ja = 4.966
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play120051041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["1069ui_story"]) and arg_166_1.var_.characterEffect1069ui_story == nil then
				arg_166_1.var_.characterEffect1069ui_story = arg_166_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["1069ui_story"]) then
				if arg_166_1.var_.characterEffect1069ui_story and not isNil(arg_166_1.actors_["1069ui_story"]) then
					arg_166_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["1069ui_story"]) and arg_166_1.var_.characterEffect1069ui_story then
				arg_166_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_169_2 = arg_166_1.actors_["1075ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.characterEffect1075ui_story == nil then
				arg_166_1.var_.characterEffect1075ui_story = var_169_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_3 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_3 and not isNil(var_169_2) then
				if arg_166_1.var_.characterEffect1075ui_story and not isNil(var_169_2) then
					arg_166_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_3)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_3 and arg_166_1.time_ < 0 + var_169_3 + arg_169_0 and not isNil(var_169_2) and arg_166_1.var_.characterEffect1075ui_story then
				arg_166_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_169_4 = 0
			local var_169_5 = 0.25

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_6 = arg_166_1:GetWordFromCfg(120051040)
				local var_169_7 = arg_166_1:FormatText(var_169_6.content)

				arg_166_1.text_.text = var_169_7

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_9 = 10 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 10)

				if (10 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 10)) > 0 and var_169_5 < var_169_9 then
					arg_166_1.talkMaxDuration = var_169_9

					if var_169_9 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_9 + var_169_4
					end
				end

				arg_166_1.text_.text = var_169_7
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051040", "story_v_out_120051.awb") ~= 0 then
					local var_169_10 = manager.audio:GetVoiceLength("story_v_out_120051", "120051040", "story_v_out_120051.awb") / 1000

					if var_169_10 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_4
					end

					if var_169_6.prefab_name ~= "" and arg_166_1.actors_[var_169_6.prefab_name] ~= nil then
						local var_169_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_6.prefab_name].transform, "story_v_out_120051", "120051040", "story_v_out_120051.awb")

						arg_166_1:RecordAudio("120051040", var_169_11)
						arg_166_1:RecordAudio("120051040", var_169_11)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_120051", "120051040", "story_v_out_120051.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_120051", "120051040", "story_v_out_120051.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_12 = math.max(var_169_5, arg_166_1.talkMaxDuration)

			if var_169_4 <= arg_166_1.time_ and arg_166_1.time_ < var_169_4 + var_169_12 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_4) / var_169_12

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_4 + var_169_12 and arg_166_1.time_ < var_169_4 + var_169_12 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play120051041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 120051041
		arg_170_1.duration_ = 10.27

		local var_170_0 = {
			zh = 9.6,
			ja = 10.266
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play120051042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1075ui_story = arg_170_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_173_0 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 then
				arg_170_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_170_1.time_ - 0) / var_173_0)
				arg_170_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1075ui_story"].transform.position).z)
				arg_170_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1075ui_story"].transform.localEulerAngles = arg_170_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 then
				arg_170_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1075ui_story"].transform.position).z)
				arg_170_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1075ui_story"].transform.localEulerAngles = arg_170_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_173_1 = arg_170_1.actors_["1069ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1069ui_story == nil then
				arg_170_1.var_.characterEffect1069ui_story = var_173_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_2 and not isNil(var_173_1) then
				if arg_170_1.var_.characterEffect1069ui_story and not isNil(var_173_1) then
					arg_170_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_2)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_2 and arg_170_1.time_ < 0 + var_173_2 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1069ui_story then
				arg_170_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_173_3 = arg_170_1.actors_["1071ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_3) and arg_170_1.var_.characterEffect1071ui_story == nil then
				arg_170_1.var_.characterEffect1071ui_story = var_173_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_4 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 and not isNil(var_173_3) then
				if arg_170_1.var_.characterEffect1071ui_story and not isNil(var_173_3) then
					arg_170_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 and not isNil(var_173_3) and arg_170_1.var_.characterEffect1071ui_story then
				arg_170_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_173_6 = arg_170_1.actors_["1071ui_story"].transform

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1071ui_story = var_173_6.localPosition
			end

			local var_173_7 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_7 then
				var_173_6.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_170_1.time_ - 0) / var_173_7)
				var_173_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_6.position).x, (manager.ui.mainCamera.transform.position - var_173_6.position).y, (manager.ui.mainCamera.transform.position - var_173_6.position).z)
				var_173_6.localEulerAngles.z = 0
				var_173_6.localEulerAngles.x = 0
				var_173_6.localEulerAngles = var_173_6.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_7 and arg_170_1.time_ < 0 + var_173_7 + arg_173_0 then
				var_173_6.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_173_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_6.position).x, (manager.ui.mainCamera.transform.position - var_173_6.position).y, (manager.ui.mainCamera.transform.position - var_173_6.position).z)
				var_173_6.localEulerAngles.z = 0
				var_173_6.localEulerAngles.x = 0
				var_173_6.localEulerAngles = var_173_6.localEulerAngles
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_173_8 = 0
			local var_173_9 = 1.05

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_8 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_10 = arg_170_1:GetWordFromCfg(120051041)
				local var_173_11 = arg_170_1:FormatText(var_173_10.content)

				arg_170_1.text_.text = var_173_11

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_13 = 42 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_11) / 42)

				if (42 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_11) / 42)) > 0 and var_173_9 < var_173_13 then
					arg_170_1.talkMaxDuration = var_173_13

					if var_173_13 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_8
					end
				end

				arg_170_1.text_.text = var_173_11
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051041", "story_v_out_120051.awb") ~= 0 then
					local var_173_14 = manager.audio:GetVoiceLength("story_v_out_120051", "120051041", "story_v_out_120051.awb") / 1000

					if var_173_14 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_14 + var_173_8
					end

					if var_173_10.prefab_name ~= "" and arg_170_1.actors_[var_173_10.prefab_name] ~= nil then
						local var_173_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_10.prefab_name].transform, "story_v_out_120051", "120051041", "story_v_out_120051.awb")

						arg_170_1:RecordAudio("120051041", var_173_15)
						arg_170_1:RecordAudio("120051041", var_173_15)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_120051", "120051041", "story_v_out_120051.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_120051", "120051041", "story_v_out_120051.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_16 = math.max(var_173_9, arg_170_1.talkMaxDuration)

			if var_173_8 <= arg_170_1.time_ and arg_170_1.time_ < var_173_8 + var_173_16 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_8) / var_173_16

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_8 + var_173_16 and arg_170_1.time_ < var_173_8 + var_173_16 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play120051042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 120051042
		arg_174_1.duration_ = 14.27

		local var_174_0 = {
			zh = 14.266,
			ja = 13.533
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play120051043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 1.475

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_1 = arg_174_1:GetWordFromCfg(120051042)
				local var_177_2 = arg_174_1:FormatText(var_177_1.content)

				arg_174_1.text_.text = var_177_2

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_4 = 59 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 59)

				if (59 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_2) / 59)) > 0 and var_177_0 < var_177_4 then
					arg_174_1.talkMaxDuration = var_177_4

					if var_177_4 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_4 + 0
					end
				end

				arg_174_1.text_.text = var_177_2
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051042", "story_v_out_120051.awb") ~= 0 then
					local var_177_5 = manager.audio:GetVoiceLength("story_v_out_120051", "120051042", "story_v_out_120051.awb") / 1000

					if var_177_5 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + 0
					end

					if var_177_1.prefab_name ~= "" and arg_174_1.actors_[var_177_1.prefab_name] ~= nil then
						local var_177_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_1.prefab_name].transform, "story_v_out_120051", "120051042", "story_v_out_120051.awb")

						arg_174_1:RecordAudio("120051042", var_177_6)
						arg_174_1:RecordAudio("120051042", var_177_6)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_120051", "120051042", "story_v_out_120051.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_120051", "120051042", "story_v_out_120051.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_7 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_7 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_7

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_7 and arg_174_1.time_ < 0 + var_177_7 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play120051043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 120051043
		arg_178_1.duration_ = 4.83

		local var_178_0 = {
			zh = 4.4,
			ja = 4.833
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play120051044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1069ui_story = arg_178_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1069ui_story"].transform.position).z)
				arg_178_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1069ui_story"].transform.localEulerAngles = arg_178_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_178_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1069ui_story"].transform.position).z)
				arg_178_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1069ui_story"].transform.localEulerAngles = arg_178_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_181_1 = "1184ui_story"

			if arg_178_1.actors_["1184ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1184ui_story"))) then
				local var_181_2 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_178_1.stage_.transform)

				var_181_2.name = var_181_1
				var_181_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_178_1.actors_[var_181_1] = var_181_2

				local var_181_3 = var_181_2:GetComponentInChildren(typeof(CharacterEffect))

				var_181_3.enabled = true

				local var_181_4 = GameObjectTools.GetOrAddComponent(var_181_2, typeof(DynamicBoneHelper))

				if var_181_4 then
					var_181_4:EnableDynamicBone(false)
				end

				arg_178_1:ShowWeapon(var_181_3.transform, false)

				arg_178_1.var_[var_181_1 .. "Animator"] = var_181_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_178_1.var_[var_181_1 .. "Animator"].applyRootMotion = true
				arg_178_1.var_[var_181_1 .. "LipSync"] = var_181_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_181_5 = arg_178_1.actors_["1184ui_story"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1184ui_story = var_181_5.localPosition
			end

			local var_181_6 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_6 then
				var_181_5.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1184ui_story, Vector3.New(0.7, -0.97, -6), (arg_178_1.time_ - 0) / var_181_6)
				var_181_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_5.position).x, (manager.ui.mainCamera.transform.position - var_181_5.position).y, (manager.ui.mainCamera.transform.position - var_181_5.position).z)
				var_181_5.localEulerAngles.z = 0
				var_181_5.localEulerAngles.x = 0
				var_181_5.localEulerAngles = var_181_5.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_6 and arg_178_1.time_ < 0 + var_181_6 + arg_181_0 then
				var_181_5.localPosition = Vector3.New(0.7, -0.97, -6)
				var_181_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_5.position).x, (manager.ui.mainCamera.transform.position - var_181_5.position).y, (manager.ui.mainCamera.transform.position - var_181_5.position).z)
				var_181_5.localEulerAngles.z = 0
				var_181_5.localEulerAngles.x = 0
				var_181_5.localEulerAngles = var_181_5.localEulerAngles
			end

			local var_181_7 = arg_178_1.actors_["1184ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_7) and arg_178_1.var_.characterEffect1184ui_story == nil then
				arg_178_1.var_.characterEffect1184ui_story = var_181_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_8 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_8 and not isNil(var_181_7) then
				if arg_178_1.var_.characterEffect1184ui_story and not isNil(var_181_7) then
					arg_178_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_8 and arg_178_1.time_ < 0 + var_181_8 + arg_181_0 and not isNil(var_181_7) and arg_178_1.var_.characterEffect1184ui_story then
				arg_178_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_181_10 = arg_178_1.actors_["1071ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_10) and arg_178_1.var_.characterEffect1071ui_story == nil then
				arg_178_1.var_.characterEffect1071ui_story = var_181_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_11 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_11 and not isNil(var_181_10) then
				if arg_178_1.var_.characterEffect1071ui_story and not isNil(var_181_10) then
					arg_178_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_178_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_178_1.time_ - 0) / var_181_11)
				end
			end

			if arg_178_1.time_ >= 0 + var_181_11 and arg_178_1.time_ < 0 + var_181_11 + arg_181_0 and not isNil(var_181_10) and arg_178_1.var_.characterEffect1071ui_story then
				arg_178_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_178_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_181_12 = 0
			local var_181_13 = 0.35

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_12 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_14 = arg_178_1:GetWordFromCfg(120051043)
				local var_181_15 = arg_178_1:FormatText(var_181_14.content)

				arg_178_1.text_.text = var_181_15

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_17 = 14 <= 0 and var_181_13 or var_181_13 * (utf8.len(var_181_15) / 14)

				if (14 <= 0 and var_181_13 or var_181_13 * (utf8.len(var_181_15) / 14)) > 0 and var_181_13 < var_181_17 then
					arg_178_1.talkMaxDuration = var_181_17

					if var_181_17 + var_181_12 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_17 + var_181_12
					end
				end

				arg_178_1.text_.text = var_181_15
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051043", "story_v_out_120051.awb") ~= 0 then
					local var_181_18 = manager.audio:GetVoiceLength("story_v_out_120051", "120051043", "story_v_out_120051.awb") / 1000

					if var_181_18 + var_181_12 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_18 + var_181_12
					end

					if var_181_14.prefab_name ~= "" and arg_178_1.actors_[var_181_14.prefab_name] ~= nil then
						local var_181_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_14.prefab_name].transform, "story_v_out_120051", "120051043", "story_v_out_120051.awb")

						arg_178_1:RecordAudio("120051043", var_181_19)
						arg_178_1:RecordAudio("120051043", var_181_19)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_120051", "120051043", "story_v_out_120051.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_120051", "120051043", "story_v_out_120051.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_20 = math.max(var_181_13, arg_178_1.talkMaxDuration)

			if var_181_12 <= arg_178_1.time_ and arg_178_1.time_ < var_181_12 + var_181_20 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_12) / var_181_20

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_12 + var_181_20 and arg_178_1.time_ < var_181_12 + var_181_20 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play120051044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 120051044
		arg_182_1.duration_ = 12.67

		local var_182_0 = {
			zh = 9.833,
			ja = 12.666
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
				arg_182_0:Play120051045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1184ui_story"]) and arg_182_1.var_.characterEffect1184ui_story == nil then
				arg_182_1.var_.characterEffect1184ui_story = arg_182_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1184ui_story"]) then
				if arg_182_1.var_.characterEffect1184ui_story and not isNil(arg_182_1.actors_["1184ui_story"]) then
					arg_182_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_0)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1184ui_story"]) and arg_182_1.var_.characterEffect1184ui_story then
				arg_182_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_185_1 = arg_182_1.actors_["1071ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1071ui_story == nil then
				arg_182_1.var_.characterEffect1071ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect1071ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1071ui_story then
				arg_182_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_185_4 = 0
			local var_185_5 = 1.35

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_6 = arg_182_1:GetWordFromCfg(120051044)
				local var_185_7 = arg_182_1:FormatText(var_185_6.content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_9 = 45 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 45)

				if (45 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 45)) > 0 and var_185_5 < var_185_9 then
					arg_182_1.talkMaxDuration = var_185_9

					if var_185_9 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_4
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051044", "story_v_out_120051.awb") ~= 0 then
					local var_185_10 = manager.audio:GetVoiceLength("story_v_out_120051", "120051044", "story_v_out_120051.awb") / 1000

					if var_185_10 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_4
					end

					if var_185_6.prefab_name ~= "" and arg_182_1.actors_[var_185_6.prefab_name] ~= nil then
						local var_185_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_6.prefab_name].transform, "story_v_out_120051", "120051044", "story_v_out_120051.awb")

						arg_182_1:RecordAudio("120051044", var_185_11)
						arg_182_1:RecordAudio("120051044", var_185_11)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_120051", "120051044", "story_v_out_120051.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_120051", "120051044", "story_v_out_120051.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_12 = math.max(var_185_5, arg_182_1.talkMaxDuration)

			if var_185_4 <= arg_182_1.time_ and arg_182_1.time_ < var_185_4 + var_185_12 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_4) / var_185_12

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_4 + var_185_12 and arg_182_1.time_ < var_185_4 + var_185_12 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play120051045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 120051045
		arg_186_1.duration_ = 15.1

		local var_186_0 = {
			zh = 10.566,
			ja = 15.1
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play120051046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 1.2

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_1 = arg_186_1:GetWordFromCfg(120051045)
				local var_189_2 = arg_186_1:FormatText(var_189_1.content)

				arg_186_1.text_.text = var_189_2

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_4 = 48 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 48)

				if (48 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 48)) > 0 and var_189_0 < var_189_4 then
					arg_186_1.talkMaxDuration = var_189_4

					if var_189_4 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_4 + 0
					end
				end

				arg_186_1.text_.text = var_189_2
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051045", "story_v_out_120051.awb") ~= 0 then
					local var_189_5 = manager.audio:GetVoiceLength("story_v_out_120051", "120051045", "story_v_out_120051.awb") / 1000

					if var_189_5 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + 0
					end

					if var_189_1.prefab_name ~= "" and arg_186_1.actors_[var_189_1.prefab_name] ~= nil then
						local var_189_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_1.prefab_name].transform, "story_v_out_120051", "120051045", "story_v_out_120051.awb")

						arg_186_1:RecordAudio("120051045", var_189_6)
						arg_186_1:RecordAudio("120051045", var_189_6)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_120051", "120051045", "story_v_out_120051.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_120051", "120051045", "story_v_out_120051.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_7 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_7 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_7

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_7 and arg_186_1.time_ < 0 + var_189_7 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play120051046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 120051046
		arg_190_1.duration_ = 2.8

		local var_190_0 = {
			zh = 2.8,
			ja = 2.7
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play120051047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1184ui_story"]) and arg_190_1.var_.characterEffect1184ui_story == nil then
				arg_190_1.var_.characterEffect1184ui_story = arg_190_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1184ui_story"]) then
				if arg_190_1.var_.characterEffect1184ui_story and not isNil(arg_190_1.actors_["1184ui_story"]) then
					arg_190_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1184ui_story"]) and arg_190_1.var_.characterEffect1184ui_story then
				arg_190_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_193_2 = arg_190_1.actors_["1071ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_2) and arg_190_1.var_.characterEffect1071ui_story == nil then
				arg_190_1.var_.characterEffect1071ui_story = var_193_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_3 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_3 and not isNil(var_193_2) then
				if arg_190_1.var_.characterEffect1071ui_story and not isNil(var_193_2) then
					arg_190_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_3)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_3 and arg_190_1.time_ < 0 + var_193_3 + arg_193_0 and not isNil(var_193_2) and arg_190_1.var_.characterEffect1071ui_story then
				arg_190_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_193_4 = 0
			local var_193_5 = 0.15

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(120051046)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 6 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 6)

				if (6 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 6)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051046", "story_v_out_120051.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_out_120051", "120051046", "story_v_out_120051.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_out_120051", "120051046", "story_v_out_120051.awb")

						arg_190_1:RecordAudio("120051046", var_193_11)
						arg_190_1:RecordAudio("120051046", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_120051", "120051046", "story_v_out_120051.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_120051", "120051046", "story_v_out_120051.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_12 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_12 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_12

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_12 and arg_190_1.time_ < var_193_4 + var_193_12 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play120051047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 120051047
		arg_194_1.duration_ = 7.7

		local var_194_0 = {
			zh = 7.7,
			ja = 5.4
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play120051048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1184ui_story"]) and arg_194_1.var_.characterEffect1184ui_story == nil then
				arg_194_1.var_.characterEffect1184ui_story = arg_194_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1184ui_story"]) then
				if arg_194_1.var_.characterEffect1184ui_story and not isNil(arg_194_1.actors_["1184ui_story"]) then
					arg_194_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_0)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1184ui_story"]) and arg_194_1.var_.characterEffect1184ui_story then
				arg_194_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_197_1 = arg_194_1.actors_["1071ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect1071ui_story == nil then
				arg_194_1.var_.characterEffect1071ui_story = var_197_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.2

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_2 and not isNil(var_197_1) then
				if arg_194_1.var_.characterEffect1071ui_story and not isNil(var_197_1) then
					arg_194_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_2 and arg_194_1.time_ < 0 + var_197_2 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect1071ui_story then
				arg_194_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_197_4 = 0
			local var_197_5 = 0.9

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_6 = arg_194_1:GetWordFromCfg(120051047)
				local var_197_7 = arg_194_1:FormatText(var_197_6.content)

				arg_194_1.text_.text = var_197_7

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_9 = 36 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 36)

				if (36 <= 0 and var_197_5 or var_197_5 * (utf8.len(var_197_7) / 36)) > 0 and var_197_5 < var_197_9 then
					arg_194_1.talkMaxDuration = var_197_9

					if var_197_9 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_9 + var_197_4
					end
				end

				arg_194_1.text_.text = var_197_7
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051047", "story_v_out_120051.awb") ~= 0 then
					local var_197_10 = manager.audio:GetVoiceLength("story_v_out_120051", "120051047", "story_v_out_120051.awb") / 1000

					if var_197_10 + var_197_4 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_4
					end

					if var_197_6.prefab_name ~= "" and arg_194_1.actors_[var_197_6.prefab_name] ~= nil then
						local var_197_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_6.prefab_name].transform, "story_v_out_120051", "120051047", "story_v_out_120051.awb")

						arg_194_1:RecordAudio("120051047", var_197_11)
						arg_194_1:RecordAudio("120051047", var_197_11)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_120051", "120051047", "story_v_out_120051.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_120051", "120051047", "story_v_out_120051.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_12 = math.max(var_197_5, arg_194_1.talkMaxDuration)

			if var_197_4 <= arg_194_1.time_ and arg_194_1.time_ < var_197_4 + var_197_12 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_4) / var_197_12

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_4 + var_197_12 and arg_194_1.time_ < var_197_4 + var_197_12 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play120051048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 120051048
		arg_198_1.duration_ = 6.37

		local var_198_0 = {
			zh = 6.366,
			ja = 5.633
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
				arg_198_0:Play120051049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_201_0 = 0
			local var_201_1 = 0.625

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_2 = arg_198_1:GetWordFromCfg(120051048)
				local var_201_3 = arg_198_1:FormatText(var_201_2.content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 25 <= 0 and var_201_1 or var_201_1 * (utf8.len(var_201_3) / 25)

				if (25 <= 0 and var_201_1 or var_201_1 * (utf8.len(var_201_3) / 25)) > 0 and var_201_1 < var_201_5 then
					arg_198_1.talkMaxDuration = var_201_5

					if var_201_5 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + var_201_0
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051048", "story_v_out_120051.awb") ~= 0 then
					local var_201_6 = manager.audio:GetVoiceLength("story_v_out_120051", "120051048", "story_v_out_120051.awb") / 1000

					if var_201_6 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_6 + var_201_0
					end

					if var_201_2.prefab_name ~= "" and arg_198_1.actors_[var_201_2.prefab_name] ~= nil then
						local var_201_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_2.prefab_name].transform, "story_v_out_120051", "120051048", "story_v_out_120051.awb")

						arg_198_1:RecordAudio("120051048", var_201_7)
						arg_198_1:RecordAudio("120051048", var_201_7)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_120051", "120051048", "story_v_out_120051.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_120051", "120051048", "story_v_out_120051.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_8 = math.max(var_201_1, arg_198_1.talkMaxDuration)

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_8 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_0) / var_201_8

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_0 + var_201_8 and arg_198_1.time_ < var_201_0 + var_201_8 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play120051049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 120051049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play120051050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1071ui_story"]) and arg_202_1.var_.characterEffect1071ui_story == nil then
				arg_202_1.var_.characterEffect1071ui_story = arg_202_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1071ui_story"]) then
				if arg_202_1.var_.characterEffect1071ui_story and not isNil(arg_202_1.actors_["1071ui_story"]) then
					arg_202_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1071ui_story"]) and arg_202_1.var_.characterEffect1071ui_story then
				arg_202_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_205_1 = 0
			local var_205_2 = 0.575

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_3 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(120051049).content)

				arg_202_1.text_.text = var_205_3

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 23 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 23)

				if (23 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 23)) > 0 and var_205_2 < var_205_5 then
					arg_202_1.talkMaxDuration = var_205_5

					if var_205_5 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + var_205_1
					end
				end

				arg_202_1.text_.text = var_205_3
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_6 = math.max(var_205_2, arg_202_1.talkMaxDuration)

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_6 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_1) / var_205_6

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_1 + var_205_6 and arg_202_1.time_ < var_205_1 + var_205_6 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play120051050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 120051050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play120051051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1184ui_story = arg_206_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1184ui_story"].transform.position).z)
				arg_206_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1184ui_story"].transform.localEulerAngles = arg_206_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_206_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1184ui_story"].transform.position).z)
				arg_206_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1184ui_story"].transform.localEulerAngles = arg_206_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_209_1 = arg_206_1.actors_["1071ui_story"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1071ui_story = var_209_1.localPosition
			end

			local var_209_2 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 then
				var_209_1.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_206_1.time_ - 0) / var_209_2)
				var_209_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_1.position).x, (manager.ui.mainCamera.transform.position - var_209_1.position).y, (manager.ui.mainCamera.transform.position - var_209_1.position).z)
				var_209_1.localEulerAngles.z = 0
				var_209_1.localEulerAngles.x = 0
				var_209_1.localEulerAngles = var_209_1.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_2 and arg_206_1.time_ < 0 + var_209_2 + arg_209_0 then
				var_209_1.localPosition = Vector3.New(0, 100, 0)
				var_209_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_209_1.position).x, (manager.ui.mainCamera.transform.position - var_209_1.position).y, (manager.ui.mainCamera.transform.position - var_209_1.position).z)
				var_209_1.localEulerAngles.z = 0
				var_209_1.localEulerAngles.x = 0
				var_209_1.localEulerAngles = var_209_1.localEulerAngles
			end

			local var_209_3 = 0
			local var_209_4 = 1.025

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_3 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_5 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(120051050).content)

				arg_206_1.text_.text = var_209_5

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_7 = 41 <= 0 and var_209_4 or var_209_4 * (utf8.len(var_209_5) / 41)

				if (41 <= 0 and var_209_4 or var_209_4 * (utf8.len(var_209_5) / 41)) > 0 and var_209_4 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_3 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_3
					end
				end

				arg_206_1.text_.text = var_209_5
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_8 = math.max(var_209_4, arg_206_1.talkMaxDuration)

			if var_209_3 <= arg_206_1.time_ and arg_206_1.time_ < var_209_3 + var_209_8 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_3) / var_209_8

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_3 + var_209_8 and arg_206_1.time_ < var_209_3 + var_209_8 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play120051051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 120051051
		arg_210_1.duration_ = 9

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play120051052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 2 < arg_210_1.time_ and arg_210_1.time_ <= 2 + arg_213_0 then
				local var_213_0 = arg_210_1.bgs_.J03f

				arg_210_1.bgs_.J03f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_213_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_213_1 = var_213_0:GetComponent("SpriteRenderer")

				if var_213_1 and var_213_1.sprite then
					local var_213_2 = 2 * (var_213_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_213_0.transform.localScale = Vector3.New(var_213_2 / var_213_1.sprite.bounds.size.y < var_213_2 * manager.ui.mainCameraCom_.aspect / var_213_1.sprite.bounds.size.x and var_213_2 * manager.ui.mainCameraCom_.aspect / var_213_1.sprite.bounds.size.x or var_213_2 / var_213_1.sprite.bounds.size.y, var_213_2 / var_213_1.sprite.bounds.size.y < var_213_2 * manager.ui.mainCameraCom_.aspect / var_213_1.sprite.bounds.size.x and var_213_2 * manager.ui.mainCameraCom_.aspect / var_213_1.sprite.bounds.size.x or var_213_2 / var_213_1.sprite.bounds.size.y, 0)
				end

				for iter_213_0, iter_213_1 in pairs(arg_210_1.bgs_) do
					if iter_213_0 ~= "J03f" then
						iter_213_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_213_3 = 0

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_3 + arg_213_0 then
				arg_210_1.mask_.enabled = true
				arg_210_1.mask_.raycastTarget = true

				arg_210_1:SetGaussion(false)
			end

			local var_213_4 = 2

			if var_213_3 <= arg_210_1.time_ and arg_210_1.time_ < var_213_3 + var_213_4 then
				local var_213_5 = Color.New(0, 0, 0)

				var_213_5.a = Mathf.Lerp(0, 1, (arg_210_1.time_ - var_213_3) / var_213_4)
				arg_210_1.mask_.color = var_213_5
			end

			if arg_210_1.time_ >= var_213_3 + var_213_4 and arg_210_1.time_ < var_213_3 + var_213_4 + arg_213_0 then
				local var_213_6 = Color.New(0, 0, 0)

				var_213_6.a = 1
				arg_210_1.mask_.color = var_213_6
			end

			local var_213_7 = 2

			if 2 < arg_210_1.time_ and arg_210_1.time_ <= var_213_7 + arg_213_0 then
				arg_210_1.mask_.enabled = true
				arg_210_1.mask_.raycastTarget = true

				arg_210_1:SetGaussion(false)
			end

			local var_213_8 = 2

			if var_213_7 <= arg_210_1.time_ and arg_210_1.time_ < var_213_7 + var_213_8 then
				local var_213_9 = Color.New(0, 0, 0)

				var_213_9.a = Mathf.Lerp(1, 0, (arg_210_1.time_ - var_213_7) / var_213_8)
				arg_210_1.mask_.color = var_213_9
			end

			if arg_210_1.time_ >= var_213_7 + var_213_8 and arg_210_1.time_ < var_213_7 + var_213_8 + arg_213_0 then
				local var_213_10 = Color.New(0, 0, 0)

				arg_210_1.mask_.enabled = false
				var_213_10.a = 0
				arg_210_1.mask_.color = var_213_10
			end

			if arg_210_1.frameCnt_ <= 1 then
				arg_210_1.dialog_:SetActive(false)
			end

			local var_213_11 = 4
			local var_213_12 = 1

			if 4 < arg_210_1.time_ and arg_210_1.time_ <= var_213_11 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0

				arg_210_1.dialog_:SetActive(true)

				arg_210_1.dialogCg_.alpha = 0

				local var_213_13 = LeanTween.value(arg_210_1.dialog_, 0, 1, 0.3)

				var_213_13:setOnUpdate(LuaHelper.FloatAction(function(arg_214_0)
					arg_210_1.dialogCg_.alpha = arg_214_0
				end))
				var_213_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_210_1.dialog_)
					var_213_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_210_1.duration_ = arg_210_1.duration_ + 0.3

				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_14 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(120051051).content)

				arg_210_1.text_.text = var_213_14

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_16 = 40 <= 0 and var_213_12 or var_213_12 * (utf8.len(var_213_14) / 40)

				if (40 <= 0 and var_213_12 or var_213_12 * (utf8.len(var_213_14) / 40)) > 0 and var_213_12 < var_213_16 then
					arg_210_1.talkMaxDuration = var_213_16
					var_213_11 = var_213_11 + 0.3

					if var_213_16 + var_213_11 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_16 + var_213_11
					end
				end

				arg_210_1.text_.text = var_213_14
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_17 = var_213_11 + 0.3
			local var_213_18 = math.max(var_213_12, arg_210_1.talkMaxDuration)

			if var_213_11 + 0.3 <= arg_210_1.time_ and arg_210_1.time_ < var_213_17 + var_213_18 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_17) / var_213_18

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_17 + var_213_18 and arg_210_1.time_ < var_213_17 + var_213_18 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play120051052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 120051052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play120051053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 1.025

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_1 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(120051052).content)

				arg_216_1.text_.text = var_219_1

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_3 = 41 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_1) / 41)

				if (41 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_1) / 41)) > 0 and var_219_0 < var_219_3 then
					arg_216_1.talkMaxDuration = var_219_3

					if var_219_3 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_3 + 0
					end
				end

				arg_216_1.text_.text = var_219_1
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_4 = math.max(var_219_0, arg_216_1.talkMaxDuration)

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - 0) / var_219_4

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play120051053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 120051053
		arg_220_1.duration_ = 2.9

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play120051054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1184ui_story = arg_220_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_223_0 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 then
				arg_220_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1184ui_story, Vector3.New(-0.7, -0.97, -6), (arg_220_1.time_ - 0) / var_223_0)
				arg_220_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1184ui_story"].transform.position).z)
				arg_220_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1184ui_story"].transform.localEulerAngles = arg_220_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 then
				arg_220_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_220_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1184ui_story"].transform.position).z)
				arg_220_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1184ui_story"].transform.localEulerAngles = arg_220_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_223_1 = arg_220_1.actors_["1069ui_story"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1069ui_story = var_223_1.localPosition
			end

			local var_223_2 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_2 then
				var_223_1.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_220_1.time_ - 0) / var_223_2)
				var_223_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_1.position).x, (manager.ui.mainCamera.transform.position - var_223_1.position).y, (manager.ui.mainCamera.transform.position - var_223_1.position).z)
				var_223_1.localEulerAngles.z = 0
				var_223_1.localEulerAngles.x = 0
				var_223_1.localEulerAngles = var_223_1.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_2 and arg_220_1.time_ < 0 + var_223_2 + arg_223_0 then
				var_223_1.localPosition = Vector3.New(0.7, -1, -6)
				var_223_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_1.position).x, (manager.ui.mainCamera.transform.position - var_223_1.position).y, (manager.ui.mainCamera.transform.position - var_223_1.position).z)
				var_223_1.localEulerAngles.z = 0
				var_223_1.localEulerAngles.x = 0
				var_223_1.localEulerAngles = var_223_1.localEulerAngles
			end

			local var_223_3 = arg_220_1.actors_["1184ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_3) and arg_220_1.var_.characterEffect1184ui_story == nil then
				arg_220_1.var_.characterEffect1184ui_story = var_223_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_4 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_4 and not isNil(var_223_3) then
				if arg_220_1.var_.characterEffect1184ui_story and not isNil(var_223_3) then
					arg_220_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_4 and arg_220_1.time_ < 0 + var_223_4 + arg_223_0 and not isNil(var_223_3) and arg_220_1.var_.characterEffect1184ui_story then
				arg_220_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_223_6 = arg_220_1.actors_["1069ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_6) and arg_220_1.var_.characterEffect1069ui_story == nil then
				arg_220_1.var_.characterEffect1069ui_story = var_223_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_7 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_7 and not isNil(var_223_6) then
				if arg_220_1.var_.characterEffect1069ui_story and not isNil(var_223_6) then
					arg_220_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 0) / var_223_7)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_7 and arg_220_1.time_ < 0 + var_223_7 + arg_223_0 and not isNil(var_223_6) and arg_220_1.var_.characterEffect1069ui_story then
				arg_220_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			local var_223_8 = 0
			local var_223_9 = 0.25

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_8 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_10 = arg_220_1:GetWordFromCfg(120051053)
				local var_223_11 = arg_220_1:FormatText(var_223_10.content)

				arg_220_1.text_.text = var_223_11

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_13 = 10 <= 0 and var_223_9 or var_223_9 * (utf8.len(var_223_11) / 10)

				if (10 <= 0 and var_223_9 or var_223_9 * (utf8.len(var_223_11) / 10)) > 0 and var_223_9 < var_223_13 then
					arg_220_1.talkMaxDuration = var_223_13

					if var_223_13 + var_223_8 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_13 + var_223_8
					end
				end

				arg_220_1.text_.text = var_223_11
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051053", "story_v_out_120051.awb") ~= 0 then
					local var_223_14 = manager.audio:GetVoiceLength("story_v_out_120051", "120051053", "story_v_out_120051.awb") / 1000

					if var_223_14 + var_223_8 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_14 + var_223_8
					end

					if var_223_10.prefab_name ~= "" and arg_220_1.actors_[var_223_10.prefab_name] ~= nil then
						local var_223_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_10.prefab_name].transform, "story_v_out_120051", "120051053", "story_v_out_120051.awb")

						arg_220_1:RecordAudio("120051053", var_223_15)
						arg_220_1:RecordAudio("120051053", var_223_15)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_120051", "120051053", "story_v_out_120051.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_120051", "120051053", "story_v_out_120051.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_16 = math.max(var_223_9, arg_220_1.talkMaxDuration)

			if var_223_8 <= arg_220_1.time_ and arg_220_1.time_ < var_223_8 + var_223_16 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_8) / var_223_16

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_8 + var_223_16 and arg_220_1.time_ < var_223_8 + var_223_16 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play120051054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 120051054
		arg_224_1.duration_ = 5.23

		local var_224_0 = {
			zh = 4.2,
			ja = 5.233
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play120051055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["1184ui_story"]) and arg_224_1.var_.characterEffect1184ui_story == nil then
				arg_224_1.var_.characterEffect1184ui_story = arg_224_1.actors_["1184ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["1184ui_story"]) then
				if arg_224_1.var_.characterEffect1184ui_story and not isNil(arg_224_1.actors_["1184ui_story"]) then
					arg_224_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1184ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_0)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["1184ui_story"]) and arg_224_1.var_.characterEffect1184ui_story then
				arg_224_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1184ui_story.fillRatio = 0.5
			end

			local var_227_1 = arg_224_1.actors_["1069ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect1069ui_story == nil then
				arg_224_1.var_.characterEffect1069ui_story = var_227_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_2 and not isNil(var_227_1) then
				if arg_224_1.var_.characterEffect1069ui_story and not isNil(var_227_1) then
					arg_224_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_2 and arg_224_1.time_ < 0 + var_227_2 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect1069ui_story then
				arg_224_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action442")
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_227_4 = 0
			local var_227_5 = 0.425

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_6 = arg_224_1:GetWordFromCfg(120051054)
				local var_227_7 = arg_224_1:FormatText(var_227_6.content)

				arg_224_1.text_.text = var_227_7

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_9 = 17 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 17)

				if (17 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 17)) > 0 and var_227_5 < var_227_9 then
					arg_224_1.talkMaxDuration = var_227_9

					if var_227_9 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_9 + var_227_4
					end
				end

				arg_224_1.text_.text = var_227_7
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051054", "story_v_out_120051.awb") ~= 0 then
					local var_227_10 = manager.audio:GetVoiceLength("story_v_out_120051", "120051054", "story_v_out_120051.awb") / 1000

					if var_227_10 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_10 + var_227_4
					end

					if var_227_6.prefab_name ~= "" and arg_224_1.actors_[var_227_6.prefab_name] ~= nil then
						local var_227_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_6.prefab_name].transform, "story_v_out_120051", "120051054", "story_v_out_120051.awb")

						arg_224_1:RecordAudio("120051054", var_227_11)
						arg_224_1:RecordAudio("120051054", var_227_11)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_120051", "120051054", "story_v_out_120051.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_120051", "120051054", "story_v_out_120051.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_12 = math.max(var_227_5, arg_224_1.talkMaxDuration)

			if var_227_4 <= arg_224_1.time_ and arg_224_1.time_ < var_227_4 + var_227_12 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_4) / var_227_12

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_4 + var_227_12 and arg_224_1.time_ < var_227_4 + var_227_12 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play120051055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 120051055
		arg_228_1.duration_ = 5.6

		local var_228_0 = {
			zh = 3.433,
			ja = 5.6
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play120051056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos1184ui_story = arg_228_1.actors_["1184ui_story"].transform.localPosition
			end

			local var_231_0 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 then
				arg_228_1.actors_["1184ui_story"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1184ui_story, Vector3.New(0, 100, 0), (arg_228_1.time_ - 0) / var_231_0)
				arg_228_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1184ui_story"].transform.position).z)
				arg_228_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1184ui_story"].transform.localEulerAngles = arg_228_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 then
				arg_228_1.actors_["1184ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_228_1.actors_["1184ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1184ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1184ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1184ui_story"].transform.position).z)
				arg_228_1.actors_["1184ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1184ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1184ui_story"].transform.localEulerAngles = arg_228_1.actors_["1184ui_story"].transform.localEulerAngles
			end

			local var_231_1 = arg_228_1.actors_["1071ui_story"].transform

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos1071ui_story = var_231_1.localPosition
			end

			local var_231_2 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_2 then
				var_231_1.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_228_1.time_ - 0) / var_231_2)
				var_231_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_231_1.position).x, (manager.ui.mainCamera.transform.position - var_231_1.position).y, (manager.ui.mainCamera.transform.position - var_231_1.position).z)
				var_231_1.localEulerAngles.z = 0
				var_231_1.localEulerAngles.x = 0
				var_231_1.localEulerAngles = var_231_1.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_2 and arg_228_1.time_ < 0 + var_231_2 + arg_231_0 then
				var_231_1.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_231_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_231_1.position).x, (manager.ui.mainCamera.transform.position - var_231_1.position).y, (manager.ui.mainCamera.transform.position - var_231_1.position).z)
				var_231_1.localEulerAngles.z = 0
				var_231_1.localEulerAngles.x = 0
				var_231_1.localEulerAngles = var_231_1.localEulerAngles
			end

			local var_231_3 = arg_228_1.actors_["1071ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_3) and arg_228_1.var_.characterEffect1071ui_story == nil then
				arg_228_1.var_.characterEffect1071ui_story = var_231_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_4 = 0.2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 and not isNil(var_231_3) then
				if arg_228_1.var_.characterEffect1071ui_story and not isNil(var_231_3) then
					arg_228_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 and not isNil(var_231_3) and arg_228_1.var_.characterEffect1071ui_story then
				arg_228_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_231_6 = arg_228_1.actors_["1069ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_6) and arg_228_1.var_.characterEffect1069ui_story == nil then
				arg_228_1.var_.characterEffect1069ui_story = var_231_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_7 = 0.2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_7 and not isNil(var_231_6) then
				if arg_228_1.var_.characterEffect1069ui_story and not isNil(var_231_6) then
					arg_228_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_7)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_7 and arg_228_1.time_ < 0 + var_231_7 + arg_231_0 and not isNil(var_231_6) and arg_228_1.var_.characterEffect1069ui_story then
				arg_228_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_231_8 = 0
			local var_231_9 = 0.3

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_8 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_10 = arg_228_1:GetWordFromCfg(120051055)
				local var_231_11 = arg_228_1:FormatText(var_231_10.content)

				arg_228_1.text_.text = var_231_11

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_13 = 12 <= 0 and var_231_9 or var_231_9 * (utf8.len(var_231_11) / 12)

				if (12 <= 0 and var_231_9 or var_231_9 * (utf8.len(var_231_11) / 12)) > 0 and var_231_9 < var_231_13 then
					arg_228_1.talkMaxDuration = var_231_13

					if var_231_13 + var_231_8 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_13 + var_231_8
					end
				end

				arg_228_1.text_.text = var_231_11
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051055", "story_v_out_120051.awb") ~= 0 then
					local var_231_14 = manager.audio:GetVoiceLength("story_v_out_120051", "120051055", "story_v_out_120051.awb") / 1000

					if var_231_14 + var_231_8 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_14 + var_231_8
					end

					if var_231_10.prefab_name ~= "" and arg_228_1.actors_[var_231_10.prefab_name] ~= nil then
						local var_231_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_10.prefab_name].transform, "story_v_out_120051", "120051055", "story_v_out_120051.awb")

						arg_228_1:RecordAudio("120051055", var_231_15)
						arg_228_1:RecordAudio("120051055", var_231_15)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_120051", "120051055", "story_v_out_120051.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_120051", "120051055", "story_v_out_120051.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_16 = math.max(var_231_9, arg_228_1.talkMaxDuration)

			if var_231_8 <= arg_228_1.time_ and arg_228_1.time_ < var_231_8 + var_231_16 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_8) / var_231_16

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_8 + var_231_16 and arg_228_1.time_ < var_231_8 + var_231_16 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play120051056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 120051056
		arg_232_1.duration_ = 3.67

		local var_232_0 = {
			zh = 3.633,
			ja = 3.666
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play120051057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0.625

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_1 = arg_232_1:GetWordFromCfg(120051056)
				local var_235_2 = arg_232_1:FormatText(var_235_1.content)

				arg_232_1.text_.text = var_235_2

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_4 = 27 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 27)

				if (27 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 27)) > 0 and var_235_0 < var_235_4 then
					arg_232_1.talkMaxDuration = var_235_4

					if var_235_4 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_4 + 0
					end
				end

				arg_232_1.text_.text = var_235_2
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051056", "story_v_out_120051.awb") ~= 0 then
					local var_235_5 = manager.audio:GetVoiceLength("story_v_out_120051", "120051056", "story_v_out_120051.awb") / 1000

					if var_235_5 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + 0
					end

					if var_235_1.prefab_name ~= "" and arg_232_1.actors_[var_235_1.prefab_name] ~= nil then
						local var_235_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_1.prefab_name].transform, "story_v_out_120051", "120051056", "story_v_out_120051.awb")

						arg_232_1:RecordAudio("120051056", var_235_6)
						arg_232_1:RecordAudio("120051056", var_235_6)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_120051", "120051056", "story_v_out_120051.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_120051", "120051056", "story_v_out_120051.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_7 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_7 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_7

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_7 and arg_232_1.time_ < 0 + var_235_7 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play120051057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 120051057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play120051058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(arg_236_1.actors_["1071ui_story"]) and arg_236_1.var_.characterEffect1071ui_story == nil then
				arg_236_1.var_.characterEffect1071ui_story = arg_236_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_0 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 and not isNil(arg_236_1.actors_["1071ui_story"]) then
				if arg_236_1.var_.characterEffect1071ui_story and not isNil(arg_236_1.actors_["1071ui_story"]) then
					arg_236_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_236_1.time_ - 0) / var_239_0)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 and not isNil(arg_236_1.actors_["1071ui_story"]) and arg_236_1.var_.characterEffect1071ui_story then
				arg_236_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_239_1 = 0
			local var_239_2 = 0.85

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_3 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(120051057).content)

				arg_236_1.text_.text = var_239_3

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 34 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 34)

				if (34 <= 0 and var_239_2 or var_239_2 * (utf8.len(var_239_3) / 34)) > 0 and var_239_2 < var_239_5 then
					arg_236_1.talkMaxDuration = var_239_5

					if var_239_5 + var_239_1 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + var_239_1
					end
				end

				arg_236_1.text_.text = var_239_3
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_6 = math.max(var_239_2, arg_236_1.talkMaxDuration)

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_6 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_1) / var_239_6

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_1 + var_239_6 and arg_236_1.time_ < var_239_1 + var_239_6 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play120051058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 120051058
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play120051059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.525

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_1 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(120051058).content)

				arg_240_1.text_.text = var_243_1

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_3 = 21 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 21)

				if (21 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 21)) > 0 and var_243_0 < var_243_3 then
					arg_240_1.talkMaxDuration = var_243_3

					if var_243_3 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_3 + 0
					end
				end

				arg_240_1.text_.text = var_243_1
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_4 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_4

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play120051059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 120051059
		arg_244_1.duration_ = 18.8

		local var_244_0 = {
			zh = 12.533,
			ja = 18.8
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play120051060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["1071ui_story"]) and arg_244_1.var_.characterEffect1071ui_story == nil then
				arg_244_1.var_.characterEffect1071ui_story = arg_244_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["1071ui_story"]) then
				if arg_244_1.var_.characterEffect1071ui_story and not isNil(arg_244_1.actors_["1071ui_story"]) then
					arg_244_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["1071ui_story"]) and arg_244_1.var_.characterEffect1071ui_story then
				arg_244_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_247_2 = 0
			local var_247_3 = 1.125

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_2 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_4 = arg_244_1:GetWordFromCfg(120051059)
				local var_247_5 = arg_244_1:FormatText(var_247_4.content)

				arg_244_1.text_.text = var_247_5

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_7 = 45 <= 0 and var_247_3 or var_247_3 * (utf8.len(var_247_5) / 45)

				if (45 <= 0 and var_247_3 or var_247_3 * (utf8.len(var_247_5) / 45)) > 0 and var_247_3 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_2 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_2
					end
				end

				arg_244_1.text_.text = var_247_5
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051059", "story_v_out_120051.awb") ~= 0 then
					local var_247_8 = manager.audio:GetVoiceLength("story_v_out_120051", "120051059", "story_v_out_120051.awb") / 1000

					if var_247_8 + var_247_2 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_2
					end

					if var_247_4.prefab_name ~= "" and arg_244_1.actors_[var_247_4.prefab_name] ~= nil then
						local var_247_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_4.prefab_name].transform, "story_v_out_120051", "120051059", "story_v_out_120051.awb")

						arg_244_1:RecordAudio("120051059", var_247_9)
						arg_244_1:RecordAudio("120051059", var_247_9)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_120051", "120051059", "story_v_out_120051.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_120051", "120051059", "story_v_out_120051.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_3, arg_244_1.talkMaxDuration)

			if var_247_2 <= arg_244_1.time_ and arg_244_1.time_ < var_247_2 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_2) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_2 + var_247_10 and arg_244_1.time_ < var_247_2 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play120051060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 120051060
		arg_248_1.duration_ = 3.43

		local var_248_0 = {
			zh = 3.433,
			ja = 3.3
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play120051061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.325

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:GetWordFromCfg(120051060)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 13 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 13)

				if (13 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 13)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051060", "story_v_out_120051.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_120051", "120051060", "story_v_out_120051.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_120051", "120051060", "story_v_out_120051.awb")

						arg_248_1:RecordAudio("120051060", var_251_6)
						arg_248_1:RecordAudio("120051060", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_120051", "120051060", "story_v_out_120051.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_120051", "120051060", "story_v_out_120051.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play120051061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 120051061
		arg_252_1.duration_ = 5.57

		local var_252_0 = {
			zh = 3.5,
			ja = 5.566
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
			arg_252_1.auto_ = false
		end

		function arg_252_1.playNext_(arg_254_0)
			arg_252_1.onStoryFinished_()
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0.4

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_1 = arg_252_1:GetWordFromCfg(120051061)
				local var_255_2 = arg_252_1:FormatText(var_255_1.content)

				arg_252_1.text_.text = var_255_2

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_4 = 16 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 16)

				if (16 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 16)) > 0 and var_255_0 < var_255_4 then
					arg_252_1.talkMaxDuration = var_255_4

					if var_255_4 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_4 + 0
					end
				end

				arg_252_1.text_.text = var_255_2
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120051", "120051061", "story_v_out_120051.awb") ~= 0 then
					local var_255_5 = manager.audio:GetVoiceLength("story_v_out_120051", "120051061", "story_v_out_120051.awb") / 1000

					if var_255_5 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + 0
					end

					if var_255_1.prefab_name ~= "" and arg_252_1.actors_[var_255_1.prefab_name] ~= nil then
						local var_255_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_1.prefab_name].transform, "story_v_out_120051", "120051061", "story_v_out_120051.awb")

						arg_252_1:RecordAudio("120051061", var_255_6)
						arg_252_1:RecordAudio("120051061", var_255_6)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_120051", "120051061", "story_v_out_120051.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_120051", "120051061", "story_v_out_120051.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_7 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_7

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J02g",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J03f"
	},
	voices = {
		"story_v_out_120051.awb"
	}
}
