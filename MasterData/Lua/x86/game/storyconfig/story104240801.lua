return {
	Play424081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424081001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play424081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11r == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11r")
				var_4_0.name = "I11r"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11r = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11r

				arg_1_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11r" then
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 1.05

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(424081001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 42 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 42)

				if (42 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 42)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
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
	Play424081002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 424081002
		arg_9_1.duration_ = 5.23

		local var_9_0 = {
			zh = 3.933,
			ja = 5.233
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
				arg_9_0:Play424081003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.5

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(424081002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 20 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 20)

				if (20 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 20)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081002", "story_v_out_424081.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081002", "story_v_out_424081.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_424081", "424081002", "story_v_out_424081.awb")

						arg_9_1:RecordAudio("424081002", var_12_6)
						arg_9_1:RecordAudio("424081002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_424081", "424081002", "story_v_out_424081.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_424081", "424081002", "story_v_out_424081.awb")
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
	Play424081003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 424081003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play424081004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.975

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

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(424081003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 39 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 39)

				if (39 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 39)) > 0 and var_16_0 < var_16_3 then
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
	Play424081004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 424081004
		arg_17_1.duration_ = 8.07

		local var_17_0 = {
			zh = 5.266,
			ja = 8.066
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
				arg_17_0:Play424081005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(424081004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 28 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 28)

				if (28 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 28)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081004", "story_v_out_424081.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081004", "story_v_out_424081.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_424081", "424081004", "story_v_out_424081.awb")

						arg_17_1:RecordAudio("424081004", var_20_6)
						arg_17_1:RecordAudio("424081004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_424081", "424081004", "story_v_out_424081.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_424081", "424081004", "story_v_out_424081.awb")
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
	Play424081005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 424081005
		arg_21_1.duration_ = 3.03

		local var_21_0 = {
			zh = 2.2,
			ja = 3.033
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
				arg_21_0:Play424081006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1094"] == nil then
				local var_24_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

				if not isNil(var_24_0) then
					local var_24_1 = Object.Instantiate(var_24_0, arg_21_1.canvasGo_.transform)

					var_24_1.transform:SetSiblingIndex(1)

					var_24_1.name = "1094"
					var_24_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_["1094"] = var_24_1

					if arg_21_1.isInRecall_ then
						for iter_24_0, iter_24_1 in ipairs((var_24_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_24_1.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_2 = arg_21_1.actors_["1094"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1094 == nil then
				arg_21_1.var_.actorSpriteComps1094 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps1094 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								iter_24_3.color = Color.New(Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_3.color.r, 1, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_3.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps1094 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_24_5 then
						iter_24_5.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1094 = nil
			end

			local var_24_5 = arg_21_1.actors_["1094"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1094 = var_24_5.localPosition
				var_24_5.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1094", 3)

				for iter_24_6 = 0, var_24_5.childCount - 1 do
					local var_24_6 = var_24_5:GetChild(iter_24_6)

					if var_24_6.name == "split_4" or not string.find(var_24_6.name, "split") then
						var_24_6.gameObject:SetActive(true)
					else
						var_24_6.gameObject:SetActive(false)
					end
				end
			end

			local var_24_7 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_21_1.time_ - 0) / var_24_7)
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0, -335, -230)
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_8 = arg_21_1.actors_["1094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_24_8 then
					arg_21_1.var_.alphaOldValue1094 = var_24_8.alpha
					arg_21_1.var_.characterEffect1094 = var_24_8
				end

				arg_21_1.var_.alphaOldValue1094 = 0
			end

			local var_24_9 = 0.5

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 then
				if arg_21_1.var_.characterEffect1094 then
					arg_21_1.var_.characterEffect1094.alpha = Mathf.Lerp(arg_21_1.var_.alphaOldValue1094, 1, (arg_21_1.time_ - 0) / var_24_9)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 and arg_21_1.var_.characterEffect1094 then
				arg_21_1.var_.characterEffect1094.alpha = 1
			end

			local var_24_10 = 0
			local var_24_11 = 0.25

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_12 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_12:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_13 = arg_21_1:GetWordFromCfg(424081005)
				local var_24_14 = arg_21_1:FormatText(var_24_13.content)

				arg_21_1.text_.text = var_24_14

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_16 = 10 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_14) / 10)

				if (10 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_14) / 10)) > 0 and var_24_11 < var_24_16 then
					arg_21_1.talkMaxDuration = var_24_16
					var_24_10 = var_24_10 + 0.3

					if var_24_16 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_14
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081005", "story_v_out_424081.awb") ~= 0 then
					local var_24_17 = manager.audio:GetVoiceLength("story_v_out_424081", "424081005", "story_v_out_424081.awb") / 1000

					if var_24_17 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_10
					end

					if var_24_13.prefab_name ~= "" and arg_21_1.actors_[var_24_13.prefab_name] ~= nil then
						local var_24_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_13.prefab_name].transform, "story_v_out_424081", "424081005", "story_v_out_424081.awb")

						arg_21_1:RecordAudio("424081005", var_24_18)
						arg_21_1:RecordAudio("424081005", var_24_18)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_424081", "424081005", "story_v_out_424081.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_424081", "424081005", "story_v_out_424081.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_19 = var_24_10 + 0.3
			local var_24_20 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_19 + var_24_20 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_19) / var_24_20

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_19 + var_24_20 and arg_21_1.time_ < var_24_19 + var_24_20 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play424081006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 424081006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play424081007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1094"]) and arg_27_1.var_.actorSpriteComps1094 == nil then
				arg_27_1.var_.actorSpriteComps1094 = arg_27_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1094"]) then
				if arg_27_1.var_.actorSpriteComps1094 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								iter_30_1.color = Color.New(Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor2.r, (arg_27_1.time_ - 0) / var_30_0), Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor2.g, (arg_27_1.time_ - 0) / var_30_0), (Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor2.b, (arg_27_1.time_ - 0) / var_30_0)))
							else
								local var_30_1 = Mathf.Lerp(iter_30_1.color.r, 0.5, (arg_27_1.time_ - 0) / var_30_0)

								iter_30_1.color = Color.New(var_30_1, var_30_1, var_30_1)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1094"]) and arg_27_1.var_.actorSpriteComps1094 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_30_3 then
						iter_30_3.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_27_1.var_.actorSpriteComps1094 = nil
			end

			local var_30_2 = 0
			local var_30_3 = 0.4

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_4 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(424081006).content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_6 = 16 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 16)

				if (16 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 16)) > 0 and var_30_3 < var_30_6 then
					arg_27_1.talkMaxDuration = var_30_6

					if var_30_6 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_6 + var_30_2
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_3, arg_27_1.talkMaxDuration)

			if var_30_2 <= arg_27_1.time_ and arg_27_1.time_ < var_30_2 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_2) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_2 + var_30_7 and arg_27_1.time_ < var_30_2 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play424081007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 424081007
		arg_31_1.duration_ = 3.3

		local var_31_0 = {
			zh = 1.533,
			ja = 3.3
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
				arg_31_0:Play424081008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.125

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:GetWordFromCfg(424081007)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 5 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 5)

				if (5 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 5)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081007", "story_v_out_424081.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081007", "story_v_out_424081.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_424081", "424081007", "story_v_out_424081.awb")

						arg_31_1:RecordAudio("424081007", var_34_6)
						arg_31_1:RecordAudio("424081007", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_424081", "424081007", "story_v_out_424081.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_424081", "424081007", "story_v_out_424081.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play424081008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 424081008
		arg_35_1.duration_ = 1.2

		local var_35_0 = {
			zh = 1.033,
			ja = 1.2
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play424081009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1094"]) and arg_35_1.var_.actorSpriteComps1094 == nil then
				arg_35_1.var_.actorSpriteComps1094 = arg_35_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_0 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1094"]) then
				if arg_35_1.var_.actorSpriteComps1094 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_38_1 then
							if arg_35_1.isInRecall_ then
								iter_38_1.color = Color.New(Mathf.Lerp(iter_38_1.color.r, arg_35_1.hightColor1.r, (arg_35_1.time_ - 0) / var_38_0), Mathf.Lerp(iter_38_1.color.g, arg_35_1.hightColor1.g, (arg_35_1.time_ - 0) / var_38_0), (Mathf.Lerp(iter_38_1.color.b, arg_35_1.hightColor1.b, (arg_35_1.time_ - 0) / var_38_0)))
							else
								local var_38_1 = Mathf.Lerp(iter_38_1.color.r, 1, (arg_35_1.time_ - 0) / var_38_0)

								iter_38_1.color = Color.New(var_38_1, var_38_1, var_38_1)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1094"]) and arg_35_1.var_.actorSpriteComps1094 then
				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_38_3 then
						iter_38_3.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_35_1.var_.actorSpriteComps1094 = nil
			end

			local var_38_2 = arg_35_1.actors_["1094"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1094 = var_38_2.localPosition
				var_38_2.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("1094", 3)

				for iter_38_4 = 0, var_38_2.childCount - 1 do
					local var_38_3 = var_38_2:GetChild(iter_38_4)

					if var_38_3.name == "split_1" then
						var_38_3:SetAsLastSibling()
						var_38_3.gameObject:SetActive(true)

						arg_35_1.var_.actorSpriteSplit1094 = var_38_3.gameObject:GetComponent(typeof(Image))

						arg_35_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_38_4 = 0.5

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				var_38_2.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_35_1.time_ - 0) / var_38_4)

				if arg_35_1.var_.actorSpriteSplit1094 ~= nil then
					arg_35_1.var_.actorSpriteSplit1094:SetAlpha((arg_35_1.time_ - 0) / var_38_4)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				var_38_2.localPosition = Vector3.New(0, -335, -230)

				if arg_35_1.var_.actorSpriteSplit1094 ~= nil then
					arg_35_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_38_5 = 0
			local var_38_6 = 0.075

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_7 = arg_35_1:GetWordFromCfg(424081008)
				local var_38_8 = arg_35_1:FormatText(var_38_7.content)

				arg_35_1.text_.text = var_38_8

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_10 = 3 <= 0 and var_38_6 or var_38_6 * (utf8.len(var_38_8) / 3)

				if (3 <= 0 and var_38_6 or var_38_6 * (utf8.len(var_38_8) / 3)) > 0 and var_38_6 < var_38_10 then
					arg_35_1.talkMaxDuration = var_38_10

					if var_38_10 + var_38_5 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_5
					end
				end

				arg_35_1.text_.text = var_38_8
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081008", "story_v_out_424081.awb") ~= 0 then
					local var_38_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081008", "story_v_out_424081.awb") / 1000

					if var_38_11 + var_38_5 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_11 + var_38_5
					end

					if var_38_7.prefab_name ~= "" and arg_35_1.actors_[var_38_7.prefab_name] ~= nil then
						local var_38_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_7.prefab_name].transform, "story_v_out_424081", "424081008", "story_v_out_424081.awb")

						arg_35_1:RecordAudio("424081008", var_38_12)
						arg_35_1:RecordAudio("424081008", var_38_12)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_424081", "424081008", "story_v_out_424081.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_424081", "424081008", "story_v_out_424081.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_13 = math.max(var_38_6, arg_35_1.talkMaxDuration)

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_13 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_5) / var_38_13

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_5 + var_38_13 and arg_35_1.time_ < var_38_5 + var_38_13 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play424081009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 424081009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play424081010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1094"]) and arg_39_1.var_.actorSpriteComps1094 == nil then
				arg_39_1.var_.actorSpriteComps1094 = arg_39_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_0 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1094"]) then
				if arg_39_1.var_.actorSpriteComps1094 then
					for iter_42_0, iter_42_1 in pairs(arg_39_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_42_1 then
							if arg_39_1.isInRecall_ then
								iter_42_1.color = Color.New(Mathf.Lerp(iter_42_1.color.r, arg_39_1.hightColor2.r, (arg_39_1.time_ - 0) / var_42_0), Mathf.Lerp(iter_42_1.color.g, arg_39_1.hightColor2.g, (arg_39_1.time_ - 0) / var_42_0), (Mathf.Lerp(iter_42_1.color.b, arg_39_1.hightColor2.b, (arg_39_1.time_ - 0) / var_42_0)))
							else
								local var_42_1 = Mathf.Lerp(iter_42_1.color.r, 0.5, (arg_39_1.time_ - 0) / var_42_0)

								iter_42_1.color = Color.New(var_42_1, var_42_1, var_42_1)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1094"]) and arg_39_1.var_.actorSpriteComps1094 then
				for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_42_3 then
						iter_42_3.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_39_1.var_.actorSpriteComps1094 = nil
			end

			local var_42_2 = 0
			local var_42_3 = 0.275

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 then
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

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_4 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(424081009).content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_6 = 11 <= 0 and var_42_3 or var_42_3 * (utf8.len(var_42_4) / 11)

				if (11 <= 0 and var_42_3 or var_42_3 * (utf8.len(var_42_4) / 11)) > 0 and var_42_3 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_2 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_2
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_3, arg_39_1.talkMaxDuration)

			if var_42_2 <= arg_39_1.time_ and arg_39_1.time_ < var_42_2 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_2) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_2 + var_42_7 and arg_39_1.time_ < var_42_2 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play424081010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 424081010
		arg_43_1.duration_ = 9

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play424081011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.bgs_.STblack == nil then
				local var_46_0 = Object.Instantiate(arg_43_1.paintGo_)

				var_46_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_46_0.name = "STblack"
				var_46_0.transform.parent = arg_43_1.stage_.transform
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.bgs_.STblack = var_46_0
			end

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= 2 + arg_46_0 then
				local var_46_1 = arg_43_1.bgs_.STblack

				arg_43_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_46_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_2 = var_46_1:GetComponent("SpriteRenderer")

				if var_46_2 and var_46_2.sprite then
					local var_46_3 = 2 * (var_46_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_46_1.transform.localScale = Vector3.New(var_46_3 / var_46_2.sprite.bounds.size.y < var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x and var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x or var_46_3 / var_46_2.sprite.bounds.size.y, var_46_3 / var_46_2.sprite.bounds.size.y < var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x and var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x or var_46_3 / var_46_2.sprite.bounds.size.y, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "STblack" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_4 = 4

			if 4 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			if arg_43_1.time_ >= var_46_4 + 0.3 and arg_43_1.time_ < var_46_4 + 0.3 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			local var_46_5 = 0

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_6 = 2

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_6 then
				local var_46_7 = Color.New(0, 0, 0)

				var_46_7.a = Mathf.Lerp(0, 1, (arg_43_1.time_ - var_46_5) / var_46_6)
				arg_43_1.mask_.color = var_46_7
			end

			if arg_43_1.time_ >= var_46_5 + var_46_6 and arg_43_1.time_ < var_46_5 + var_46_6 + arg_46_0 then
				local var_46_8 = Color.New(0, 0, 0)

				var_46_8.a = 1
				arg_43_1.mask_.color = var_46_8
			end

			local var_46_9 = 2

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_9 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_10 = 2

			if var_46_9 <= arg_43_1.time_ and arg_43_1.time_ < var_46_9 + var_46_10 then
				local var_46_11 = Color.New(0, 0, 0)

				var_46_11.a = Mathf.Lerp(1, 0, (arg_43_1.time_ - var_46_9) / var_46_10)
				arg_43_1.mask_.color = var_46_11
			end

			if arg_43_1.time_ >= var_46_9 + var_46_10 and arg_43_1.time_ < var_46_9 + var_46_10 + arg_46_0 then
				local var_46_12 = Color.New(0, 0, 0)

				arg_43_1.mask_.enabled = false
				var_46_12.a = 0
				arg_43_1.mask_.color = var_46_12
			end

			local var_46_13 = arg_43_1.actors_["1094"].transform

			if 1.966 < arg_43_1.time_ and arg_43_1.time_ <= 1.966 + arg_46_0 then
				arg_43_1.var_.moveOldPos1094 = var_46_13.localPosition
				var_46_13.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1094", 7)

				for iter_46_2 = 0, var_46_13.childCount - 1 do
					local var_46_14 = var_46_13:GetChild(iter_46_2)

					if var_46_14.name == "" or not string.find(var_46_14.name, "split") then
						var_46_14.gameObject:SetActive(true)
					else
						var_46_14.gameObject:SetActive(false)
					end
				end
			end

			local var_46_15 = 0.001

			if 1.966 <= arg_43_1.time_ and arg_43_1.time_ < 1.966 + var_46_15 then
				var_46_13.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_43_1.time_ - 1.966) / var_46_15)
			end

			if arg_43_1.time_ >= 1.966 + var_46_15 and arg_43_1.time_ < 1.966 + var_46_15 + arg_46_0 then
				var_46_13.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.1 < arg_43_1.time_ and arg_43_1.time_ <= 0.1 + arg_46_0 then
				arg_43_1:AudioAction("stop", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if 4.025 < arg_43_1.time_ and arg_43_1.time_ <= 4.025 + arg_46_0 then
				arg_43_1:AudioAction("play", "effect", "se_story_144", "se_story_144_door_open", "")
			end

			if 0.1 < arg_43_1.time_ and arg_43_1.time_ <= 0.1 + arg_46_0 then
				arg_43_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_46_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_43_1.bgmTxt_.text ~= var_46_20 and arg_43_1.bgmTxt_.text ~= "" then
						if arg_43_1.bgmTxt2_.text ~= "" then
							arg_43_1.bgmTxt_.text = arg_43_1.bgmTxt2_.text
						end

						arg_43_1.bgmTxt2_.text = var_46_20

						arg_43_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_43_1.bgmTxt_.text = var_46_20
						arg_43_1.bgmTxt2_.text = var_46_20
					end

					if arg_43_1.bgmTimer then
						arg_43_1.bgmTimer:Stop()

						arg_43_1.bgmTimer = nil
					end

					if arg_43_1.settingData.show_music_name == 1 then
						arg_43_1.musicController:SetSelectedState("show")
						arg_43_1.musicAnimator_:Play("open", 0, 0)

						if arg_43_1.settingData.music_time ~= 0 then
							arg_43_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_43_1.settingData.music_time), function()
								if arg_43_1 == nil or isNil(arg_43_1.bgmTxt_) then
									return
								end

								arg_43_1.musicController:SetSelectedState("hide")
								arg_43_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_21 = 4
			local var_46_22 = 1.025

			if 4 < arg_43_1.time_ and arg_43_1.time_ <= var_46_21 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_23 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_23:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_43_1.dialogCg_.alpha = arg_48_0
				end))
				var_46_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_24 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(424081010).content)

				arg_43_1.text_.text = var_46_24

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_26 = 41 <= 0 and var_46_22 or var_46_22 * (utf8.len(var_46_24) / 41)

				if (41 <= 0 and var_46_22 or var_46_22 * (utf8.len(var_46_24) / 41)) > 0 and var_46_22 < var_46_26 then
					arg_43_1.talkMaxDuration = var_46_26
					var_46_21 = var_46_21 + 0.3

					if var_46_26 + var_46_21 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_26 + var_46_21
					end
				end

				arg_43_1.text_.text = var_46_24
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_27 = var_46_21 + 0.3
			local var_46_28 = math.max(var_46_22, arg_43_1.talkMaxDuration)

			if var_46_21 + 0.3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_27 + var_46_28 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_27) / var_46_28

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_27 + var_46_28 and arg_43_1.time_ < var_46_27 + var_46_28 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play424081011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 424081011
		arg_50_1.duration_ = 8.47

		local var_50_0 = {
			zh = 7.166,
			ja = 8.466
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play424081012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if arg_50_1.bgs_.SS2402 == nil then
				local var_53_0 = Object.Instantiate(arg_50_1.paintGo_)

				var_53_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2402")
				var_53_0.name = "SS2402"
				var_53_0.transform.parent = arg_50_1.stage_.transform
				var_53_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.bgs_.SS2402 = var_53_0
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				local var_53_1 = arg_50_1.bgs_.SS2402

				arg_50_1.bgs_.SS2402.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_53_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_53_2 = var_53_1:GetComponent("SpriteRenderer")

				if var_53_2 and var_53_2.sprite then
					local var_53_3 = 2 * (var_53_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_53_1.transform.localScale = Vector3.New(var_53_3 / var_53_2.sprite.bounds.size.y < var_53_3 * manager.ui.mainCameraCom_.aspect / var_53_2.sprite.bounds.size.x and var_53_3 * manager.ui.mainCameraCom_.aspect / var_53_2.sprite.bounds.size.x or var_53_3 / var_53_2.sprite.bounds.size.y, var_53_3 / var_53_2.sprite.bounds.size.y < var_53_3 * manager.ui.mainCameraCom_.aspect / var_53_2.sprite.bounds.size.x and var_53_3 * manager.ui.mainCameraCom_.aspect / var_53_2.sprite.bounds.size.x or var_53_3 / var_53_2.sprite.bounds.size.y, 0)
				end

				for iter_53_0, iter_53_1 in pairs(arg_50_1.bgs_) do
					if iter_53_0 ~= "SS2402" then
						iter_53_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_53_4 = 2

			if 2 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1.allBtn_.enabled = false
			end

			if arg_50_1.time_ >= var_53_4 + 0.3 and arg_50_1.time_ < var_53_4 + 0.3 + arg_53_0 then
				arg_50_1.allBtn_.enabled = true
			end

			local var_53_5 = 0

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_6 = 2

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_6 then
				local var_53_7 = Color.New(0, 0, 0)

				var_53_7.a = Mathf.Lerp(1, 0, (arg_50_1.time_ - var_53_5) / var_53_6)
				arg_50_1.mask_.color = var_53_7
			end

			if arg_50_1.time_ >= var_53_5 + var_53_6 and arg_50_1.time_ < var_53_5 + var_53_6 + arg_53_0 then
				local var_53_8 = Color.New(0, 0, 0)

				arg_50_1.mask_.enabled = false
				var_53_8.a = 0
				arg_50_1.mask_.color = var_53_8
			end

			local var_53_9 = arg_50_1.bgs_.SS2402.transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPosSS2402 = var_53_9.localPosition
			end

			local var_53_10 = 3

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_10 then
				var_53_9.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPosSS2402, Vector3.New(4.5, -0.1, -2), (arg_50_1.time_ - 0) / var_53_10)
			end

			if arg_50_1.time_ >= 0 + var_53_10 and arg_50_1.time_ < 0 + var_53_10 + arg_53_0 then
				var_53_9.localPosition = Vector3.New(4.5, -0.1, -2)
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_53_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_50_1.bgmTxt_.text ~= var_53_13 and arg_50_1.bgmTxt_.text ~= "" then
						if arg_50_1.bgmTxt2_.text ~= "" then
							arg_50_1.bgmTxt_.text = arg_50_1.bgmTxt2_.text
						end

						arg_50_1.bgmTxt2_.text = var_53_13

						arg_50_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_50_1.bgmTxt_.text = var_53_13
						arg_50_1.bgmTxt2_.text = var_53_13
					end

					if arg_50_1.bgmTimer then
						arg_50_1.bgmTimer:Stop()

						arg_50_1.bgmTimer = nil
					end

					if arg_50_1.settingData.show_music_name == 1 then
						arg_50_1.musicController:SetSelectedState("show")
						arg_50_1.musicAnimator_:Play("open", 0, 0)

						if arg_50_1.settingData.music_time ~= 0 then
							arg_50_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_50_1.settingData.music_time), function()
								if arg_50_1 == nil or isNil(arg_50_1.bgmTxt_) then
									return
								end

								arg_50_1.musicController:SetSelectedState("hide")
								arg_50_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_50_1.time_ and arg_50_1.time_ <= 0.433333333333333 + arg_53_0 then
				arg_50_1:AudioAction("play", "music", "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily.awb")

				local var_53_16 = manager.audio:GetAudioName("bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily")

				if "" ~= "" then
					if arg_50_1.bgmTxt_.text ~= var_53_16 and arg_50_1.bgmTxt_.text ~= "" then
						if arg_50_1.bgmTxt2_.text ~= "" then
							arg_50_1.bgmTxt_.text = arg_50_1.bgmTxt2_.text
						end

						arg_50_1.bgmTxt2_.text = var_53_16

						arg_50_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_50_1.bgmTxt_.text = var_53_16
						arg_50_1.bgmTxt2_.text = var_53_16
					end

					if arg_50_1.bgmTimer then
						arg_50_1.bgmTimer:Stop()

						arg_50_1.bgmTimer = nil
					end

					if arg_50_1.settingData.show_music_name == 1 then
						arg_50_1.musicController:SetSelectedState("show")
						arg_50_1.musicAnimator_:Play("open", 0, 0)

						if arg_50_1.settingData.music_time ~= 0 then
							arg_50_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_50_1.settingData.music_time), function()
								if arg_50_1 == nil or isNil(arg_50_1.bgmTxt_) then
									return
								end

								arg_50_1.musicController:SetSelectedState("hide")
								arg_50_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.1 < arg_50_1.time_ and arg_50_1.time_ <= 0.1 + arg_53_0 then
				arg_50_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if arg_50_1.frameCnt_ <= 1 then
				arg_50_1.dialog_:SetActive(false)
			end

			local var_53_18 = 2
			local var_53_19 = 0.625

			if 2 < arg_50_1.time_ and arg_50_1.time_ <= var_53_18 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				arg_50_1.dialog_:SetActive(true)

				arg_50_1.dialogCg_.alpha = 0

				local var_53_20 = LeanTween.value(arg_50_1.dialog_, 0, 1, 0.3)

				var_53_20:setOnUpdate(LuaHelper.FloatAction(function(arg_56_0)
					arg_50_1.dialogCg_.alpha = arg_56_0
				end))
				var_53_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_50_1.dialog_)
					var_53_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_50_1.duration_ = arg_50_1.duration_ + 0.3

				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_21 = arg_50_1:GetWordFromCfg(424081011)
				local var_53_22 = arg_50_1:FormatText(var_53_21.content)

				arg_50_1.text_.text = var_53_22

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_24 = 25 <= 0 and var_53_19 or var_53_19 * (utf8.len(var_53_22) / 25)

				if (25 <= 0 and var_53_19 or var_53_19 * (utf8.len(var_53_22) / 25)) > 0 and var_53_19 < var_53_24 then
					arg_50_1.talkMaxDuration = var_53_24
					var_53_18 = var_53_18 + 0.3

					if var_53_24 + var_53_18 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_24 + var_53_18
					end
				end

				arg_50_1.text_.text = var_53_22
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081011", "story_v_out_424081.awb") ~= 0 then
					local var_53_25 = manager.audio:GetVoiceLength("story_v_out_424081", "424081011", "story_v_out_424081.awb") / 1000

					if var_53_25 + var_53_18 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_25 + var_53_18
					end

					if var_53_21.prefab_name ~= "" and arg_50_1.actors_[var_53_21.prefab_name] ~= nil then
						local var_53_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_21.prefab_name].transform, "story_v_out_424081", "424081011", "story_v_out_424081.awb")

						arg_50_1:RecordAudio("424081011", var_53_26)
						arg_50_1:RecordAudio("424081011", var_53_26)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_424081", "424081011", "story_v_out_424081.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_424081", "424081011", "story_v_out_424081.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_27 = var_53_18 + 0.3
			local var_53_28 = math.max(var_53_19, arg_50_1.talkMaxDuration)

			if var_53_18 + 0.3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_27 + var_53_28 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_27) / var_53_28

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_27 + var_53_28 and arg_50_1.time_ < var_53_27 + var_53_28 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2402",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(4.7, 0, -2),
					endPos = Vector3.New(4.5, -0.1, -2),
					easeType = LeanTweenType.easeInOutSine
				}
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play424081012 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 424081012
		arg_58_1.duration_ = 3.13

		local var_58_0 = {
			zh = 2.999999999999,
			ja = 3.133
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play424081013(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPosSS2402 = arg_58_1.bgs_.SS2402.transform.localPosition
			end

			local var_61_0 = 3

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 then
				arg_58_1.bgs_.SS2402.transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPosSS2402, Vector3.New(0, -0.47, 2), (arg_58_1.time_ - 0) / var_61_0)
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 then
				arg_58_1.bgs_.SS2402.transform.localPosition = Vector3.New(0, -0.47, 2)
			end

			local var_61_1 = 0

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.allBtn_.enabled = false
			end

			if arg_58_1.time_ >= var_61_1 + 3 and arg_58_1.time_ < var_61_1 + 3 + arg_61_0 then
				arg_58_1.allBtn_.enabled = true
			end

			if arg_58_1.frameCnt_ <= 1 then
				arg_58_1.dialog_:SetActive(false)
			end

			local var_61_2 = 0.4
			local var_61_3 = 0.225

			if 0.4 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_4 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_4:setOnUpdate(LuaHelper.FloatAction(function(arg_62_0)
					arg_58_1.dialogCg_.alpha = arg_62_0
				end))
				var_61_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_5 = arg_58_1:GetWordFromCfg(424081012)
				local var_61_6 = arg_58_1:FormatText(var_61_5.content)

				arg_58_1.text_.text = var_61_6

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_8 = 9 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_6) / 9)

				if (9 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_6) / 9)) > 0 and var_61_3 < var_61_8 then
					arg_58_1.talkMaxDuration = var_61_8
					var_61_2 = var_61_2 + 0.3

					if var_61_8 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_6
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081012", "story_v_out_424081.awb") ~= 0 then
					local var_61_9 = manager.audio:GetVoiceLength("story_v_out_424081", "424081012", "story_v_out_424081.awb") / 1000

					if var_61_9 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_2
					end

					if var_61_5.prefab_name ~= "" and arg_58_1.actors_[var_61_5.prefab_name] ~= nil then
						local var_61_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_5.prefab_name].transform, "story_v_out_424081", "424081012", "story_v_out_424081.awb")

						arg_58_1:RecordAudio("424081012", var_61_10)
						arg_58_1:RecordAudio("424081012", var_61_10)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_424081", "424081012", "story_v_out_424081.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_424081", "424081012", "story_v_out_424081.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_11 = var_61_2 + 0.3
			local var_61_12 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 + 0.3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_11 + var_61_12 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_11) / var_61_12

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_11 + var_61_12 and arg_58_1.time_ < var_61_11 + var_61_12 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2402",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(4.7, -0.1, -2),
					endPos = Vector3.New(0, -0.47, 2),
					easeType = LeanTweenType.easeOutExpo
				}
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play424081013 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 424081013
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play424081014(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0.7 < arg_64_1.time_ and arg_64_1.time_ <= 0.7 + arg_67_0 then
				arg_64_1:AudioAction("play", "effect", "se_story_146", "se_story_146_cheer", "")
			end

			local var_67_1 = 0
			local var_67_2 = 1.15

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(424081013).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 46 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 46)

				if (46 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 46)) > 0 and var_67_2 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_6 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_6 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_6

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_6 and arg_64_1.time_ < var_67_1 + var_67_6 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play424081014 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 424081014
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play424081015(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.225

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(424081014).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 9 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 9)

				if (9 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 9)) > 0 and var_71_0 < var_71_3 then
					arg_68_1.talkMaxDuration = var_71_3

					if var_71_3 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_3 + 0
					end
				end

				arg_68_1.text_.text = var_71_1
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_4 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_4

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play424081015 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 424081015
		arg_72_1.duration_ = 7.5

		local var_72_0 = {
			zh = 4.933,
			ja = 7.5
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
				arg_72_0:Play424081016(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.575

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_1 = arg_72_1:GetWordFromCfg(424081015)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 23 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 23)

				if (23 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 23)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081015", "story_v_out_424081.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081015", "story_v_out_424081.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_424081", "424081015", "story_v_out_424081.awb")

						arg_72_1:RecordAudio("424081015", var_75_6)
						arg_72_1:RecordAudio("424081015", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_424081", "424081015", "story_v_out_424081.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_424081", "424081015", "story_v_out_424081.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play424081016 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 424081016
		arg_76_1.duration_ = 6.4

		local var_76_0 = {
			zh = 5.733,
			ja = 6.4
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
				arg_76_0:Play424081017(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.45

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:GetWordFromCfg(424081016)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 18 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 18)

				if (18 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 18)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081016", "story_v_out_424081.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081016", "story_v_out_424081.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_424081", "424081016", "story_v_out_424081.awb")

						arg_76_1:RecordAudio("424081016", var_79_6)
						arg_76_1:RecordAudio("424081016", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_424081", "424081016", "story_v_out_424081.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_424081", "424081016", "story_v_out_424081.awb")
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
	Play424081017 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 424081017
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play424081018(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.925

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(424081017).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 37 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 37)

				if (37 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 37)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play424081018 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 424081018
		arg_84_1.duration_ = 6.47

		local var_84_0 = {
			zh = 5.166,
			ja = 6.466
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play424081019(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.725

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1404].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:GetWordFromCfg(424081018)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 29 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 29)

				if (29 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 29)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081018", "story_v_out_424081.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081018", "story_v_out_424081.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_424081", "424081018", "story_v_out_424081.awb")

						arg_84_1:RecordAudio("424081018", var_87_6)
						arg_84_1:RecordAudio("424081018", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_424081", "424081018", "story_v_out_424081.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_424081", "424081018", "story_v_out_424081.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play424081019 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 424081019
		arg_88_1.duration_ = 2.8

		local var_88_0 = {
			zh = 2.166,
			ja = 2.8
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
				arg_88_0:Play424081020(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.25

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1405].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_1 = arg_88_1:GetWordFromCfg(424081019)
				local var_91_2 = arg_88_1:FormatText(var_91_1.content)

				arg_88_1.text_.text = var_91_2

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 10 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 10)

				if (10 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 10)) > 0 and var_91_0 < var_91_4 then
					arg_88_1.talkMaxDuration = var_91_4

					if var_91_4 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_4 + 0
					end
				end

				arg_88_1.text_.text = var_91_2
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081019", "story_v_out_424081.awb") ~= 0 then
					local var_91_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081019", "story_v_out_424081.awb") / 1000

					if var_91_5 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + 0
					end

					if var_91_1.prefab_name ~= "" and arg_88_1.actors_[var_91_1.prefab_name] ~= nil then
						local var_91_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_1.prefab_name].transform, "story_v_out_424081", "424081019", "story_v_out_424081.awb")

						arg_88_1:RecordAudio("424081019", var_91_6)
						arg_88_1:RecordAudio("424081019", var_91_6)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_424081", "424081019", "story_v_out_424081.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_424081", "424081019", "story_v_out_424081.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play424081020 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 424081020
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play424081021(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.875

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
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

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(424081020).content)

				arg_92_1.text_.text = var_95_1

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_3 = 35 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 35)

				if (35 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 35)) > 0 and var_95_0 < var_95_3 then
					arg_92_1.talkMaxDuration = var_95_3

					if var_95_3 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_3 + 0
					end
				end

				arg_92_1.text_.text = var_95_1
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_4 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_4

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play424081021 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 424081021
		arg_96_1.duration_ = 11.13

		local var_96_0 = {
			zh = 9.033,
			ja = 11.133
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
				arg_96_0:Play424081022(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if arg_96_1.bgs_.SS2402a == nil then
				local var_99_0 = Object.Instantiate(arg_96_1.paintGo_)

				var_99_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2402a")
				var_99_0.name = "SS2402a"
				var_99_0.transform.parent = arg_96_1.stage_.transform
				var_99_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.bgs_.SS2402a = var_99_0
			end

			if 2 < arg_96_1.time_ and arg_96_1.time_ <= 2 + arg_99_0 then
				local var_99_1 = arg_96_1.bgs_.SS2402a

				arg_96_1.bgs_.SS2402a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_99_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_99_2 = var_99_1:GetComponent("SpriteRenderer")

				if var_99_2 and var_99_2.sprite then
					local var_99_3 = 2 * (var_99_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_99_1.transform.localScale = Vector3.New(var_99_3 / var_99_2.sprite.bounds.size.y < var_99_3 * manager.ui.mainCameraCom_.aspect / var_99_2.sprite.bounds.size.x and var_99_3 * manager.ui.mainCameraCom_.aspect / var_99_2.sprite.bounds.size.x or var_99_3 / var_99_2.sprite.bounds.size.y, var_99_3 / var_99_2.sprite.bounds.size.y < var_99_3 * manager.ui.mainCameraCom_.aspect / var_99_2.sprite.bounds.size.x and var_99_3 * manager.ui.mainCameraCom_.aspect / var_99_2.sprite.bounds.size.x or var_99_3 / var_99_2.sprite.bounds.size.y, 0)
				end

				for iter_99_0, iter_99_1 in pairs(arg_96_1.bgs_) do
					if iter_99_0 ~= "SS2402a" then
						iter_99_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_99_4 = 4

			if 4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.allBtn_.enabled = false
			end

			if arg_96_1.time_ >= var_99_4 + 0.3 and arg_96_1.time_ < var_99_4 + 0.3 + arg_99_0 then
				arg_96_1.allBtn_.enabled = true
			end

			local var_99_5 = 0

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_6 = 2

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 then
				local var_99_7 = Color.New(0, 0, 0)

				var_99_7.a = Mathf.Lerp(0, 1, (arg_96_1.time_ - var_99_5) / var_99_6)
				arg_96_1.mask_.color = var_99_7
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 then
				local var_99_8 = Color.New(0, 0, 0)

				var_99_8.a = 1
				arg_96_1.mask_.color = var_99_8
			end

			local var_99_9 = 2

			if 2 < arg_96_1.time_ and arg_96_1.time_ <= var_99_9 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_10 = 2

			if var_99_9 <= arg_96_1.time_ and arg_96_1.time_ < var_99_9 + var_99_10 then
				local var_99_11 = Color.New(0, 0, 0)

				var_99_11.a = Mathf.Lerp(1, 0, (arg_96_1.time_ - var_99_9) / var_99_10)
				arg_96_1.mask_.color = var_99_11
			end

			if arg_96_1.time_ >= var_99_9 + var_99_10 and arg_96_1.time_ < var_99_9 + var_99_10 + arg_99_0 then
				local var_99_12 = Color.New(0, 0, 0)

				arg_96_1.mask_.enabled = false
				var_99_12.a = 0
				arg_96_1.mask_.color = var_99_12
			end

			local var_99_13 = arg_96_1.bgs_.SS2402a.transform

			if 2 < arg_96_1.time_ and arg_96_1.time_ <= 2 + arg_99_0 then
				arg_96_1.var_.moveOldPosSS2402a = var_99_13.localPosition
			end

			local var_99_14 = 3

			if 2 <= arg_96_1.time_ and arg_96_1.time_ < 2 + var_99_14 then
				var_99_13.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPosSS2402a, Vector3.New(0, 1, 10), (arg_96_1.time_ - 2) / var_99_14)
			end

			if arg_96_1.time_ >= 2 + var_99_14 and arg_96_1.time_ < 2 + var_99_14 + arg_99_0 then
				var_99_13.localPosition = Vector3.New(0, 1, 10)
			end

			local var_99_15 = 4

			if 4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1.allBtn_.enabled = false
			end

			if arg_96_1.time_ >= var_99_15 + 1 and arg_96_1.time_ < var_99_15 + 1 + arg_99_0 then
				arg_96_1.allBtn_.enabled = true
			end

			if arg_96_1.frameCnt_ <= 1 then
				arg_96_1.dialog_:SetActive(false)
			end

			local var_99_16 = 4
			local var_99_17 = 0.575

			if 4 < arg_96_1.time_ and arg_96_1.time_ <= var_99_16 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0

				arg_96_1.dialog_:SetActive(true)

				arg_96_1.dialogCg_.alpha = 0

				local var_99_18 = LeanTween.value(arg_96_1.dialog_, 0, 1, 0.3)

				var_99_18:setOnUpdate(LuaHelper.FloatAction(function(arg_100_0)
					arg_96_1.dialogCg_.alpha = arg_100_0
				end))
				var_99_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_96_1.dialog_)
					var_99_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_96_1.duration_ = arg_96_1.duration_ + 0.3

				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_19 = arg_96_1:GetWordFromCfg(424081021)
				local var_99_20 = arg_96_1:FormatText(var_99_19.content)

				arg_96_1.text_.text = var_99_20

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_22 = 23 <= 0 and var_99_17 or var_99_17 * (utf8.len(var_99_20) / 23)

				if (23 <= 0 and var_99_17 or var_99_17 * (utf8.len(var_99_20) / 23)) > 0 and var_99_17 < var_99_22 then
					arg_96_1.talkMaxDuration = var_99_22
					var_99_16 = var_99_16 + 0.3

					if var_99_22 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_16
					end
				end

				arg_96_1.text_.text = var_99_20
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081021", "story_v_out_424081.awb") ~= 0 then
					local var_99_23 = manager.audio:GetVoiceLength("story_v_out_424081", "424081021", "story_v_out_424081.awb") / 1000

					if var_99_23 + var_99_16 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_16
					end

					if var_99_19.prefab_name ~= "" and arg_96_1.actors_[var_99_19.prefab_name] ~= nil then
						local var_99_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_19.prefab_name].transform, "story_v_out_424081", "424081021", "story_v_out_424081.awb")

						arg_96_1:RecordAudio("424081021", var_99_24)
						arg_96_1:RecordAudio("424081021", var_99_24)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_424081", "424081021", "story_v_out_424081.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_424081", "424081021", "story_v_out_424081.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_25 = var_99_16 + 0.3
			local var_99_26 = math.max(var_99_17, arg_96_1.talkMaxDuration)

			if var_99_16 + 0.3 <= arg_96_1.time_ and arg_96_1.time_ < var_99_25 + var_99_26 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_25) / var_99_26

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_25 + var_99_26 and arg_96_1.time_ < var_99_25 + var_99_26 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2402a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutSine
				}
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play424081022 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 424081022
		arg_102_1.duration_ = 2.77

		local var_102_0 = {
			zh = 2.133,
			ja = 2.766
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
				arg_102_0:Play424081023(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.25

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[1404].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_1 = arg_102_1:GetWordFromCfg(424081022)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 10 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 10)

				if (10 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 10)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081022", "story_v_out_424081.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081022", "story_v_out_424081.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_424081", "424081022", "story_v_out_424081.awb")

						arg_102_1:RecordAudio("424081022", var_105_6)
						arg_102_1:RecordAudio("424081022", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_424081", "424081022", "story_v_out_424081.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_424081", "424081022", "story_v_out_424081.awb")
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
	Play424081023 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 424081023
		arg_106_1.duration_ = 2.8

		local var_106_0 = {
			zh = 2.8,
			ja = 2.533
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play424081024(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.275

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_1 = arg_106_1:GetWordFromCfg(424081023)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 11 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 11)

				if (11 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 11)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081023", "story_v_out_424081.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081023", "story_v_out_424081.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_424081", "424081023", "story_v_out_424081.awb")

						arg_106_1:RecordAudio("424081023", var_109_6)
						arg_106_1:RecordAudio("424081023", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_424081", "424081023", "story_v_out_424081.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_424081", "424081023", "story_v_out_424081.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play424081024 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 424081024
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play424081025(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.125

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_1 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(424081024).content)

				arg_110_1.text_.text = var_113_1

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_3 = 5 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 5)

				if (5 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 5)) > 0 and var_113_0 < var_113_3 then
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
	Play424081025 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 424081025
		arg_114_1.duration_ = 7.07

		local var_114_0 = {
			zh = 5.866,
			ja = 7.066
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
				arg_114_0:Play424081026(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.55

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:GetWordFromCfg(424081025)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 22 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 22)

				if (22 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 22)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081025", "story_v_out_424081.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081025", "story_v_out_424081.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_424081", "424081025", "story_v_out_424081.awb")

						arg_114_1:RecordAudio("424081025", var_117_6)
						arg_114_1:RecordAudio("424081025", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_424081", "424081025", "story_v_out_424081.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_424081", "424081025", "story_v_out_424081.awb")
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
	Play424081026 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 424081026
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play424081027(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.075

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_1 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(424081026).content)

				arg_118_1.text_.text = var_121_1

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_3 = 3 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 3)

				if (3 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 3)) > 0 and var_121_0 < var_121_3 then
					arg_118_1.talkMaxDuration = var_121_3

					if var_121_3 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_3 + 0
					end
				end

				arg_118_1.text_.text = var_121_1
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_4 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_4

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play424081027 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 424081027
		arg_122_1.duration_ = 5.07

		local var_122_0 = {
			zh = 3.133,
			ja = 5.066
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
				arg_122_0:Play424081028(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.35

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1404].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_1 = arg_122_1:GetWordFromCfg(424081027)
				local var_125_2 = arg_122_1:FormatText(var_125_1.content)

				arg_122_1.text_.text = var_125_2

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 14 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 14)

				if (14 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 14)) > 0 and var_125_0 < var_125_4 then
					arg_122_1.talkMaxDuration = var_125_4

					if var_125_4 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_4 + 0
					end
				end

				arg_122_1.text_.text = var_125_2
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081027", "story_v_out_424081.awb") ~= 0 then
					local var_125_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081027", "story_v_out_424081.awb") / 1000

					if var_125_5 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + 0
					end

					if var_125_1.prefab_name ~= "" and arg_122_1.actors_[var_125_1.prefab_name] ~= nil then
						local var_125_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_1.prefab_name].transform, "story_v_out_424081", "424081027", "story_v_out_424081.awb")

						arg_122_1:RecordAudio("424081027", var_125_6)
						arg_122_1:RecordAudio("424081027", var_125_6)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_424081", "424081027", "story_v_out_424081.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_424081", "424081027", "story_v_out_424081.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_7 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_7

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play424081028 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 424081028
		arg_126_1.duration_ = 1

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"

			SetActive(arg_126_1.choicesGo_, true)

			for iter_127_0, iter_127_1 in ipairs(arg_126_1.choices_) do
				SetActive(iter_127_1.go, iter_127_0 <= 2)
			end

			arg_126_1.choices_[1].txt.text = arg_126_1:FormatText(StoryChoiceCfg[1485].name)
			arg_126_1.choices_[2].txt.text = arg_126_1:FormatText(StoryChoiceCfg[1486].name)
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play424081029(arg_126_1)
			end

			if arg_128_0 == 2 then
				arg_126_0:Play424081032(arg_126_1)
			end

			arg_126_1:RecordChoiceLog(424081028, 1485, 1486)
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.allBtn_.enabled = false
			end

			if arg_126_1.time_ >= 0 + 0.6 and arg_126_1.time_ < 0 + 0.6 + arg_129_0 then
				arg_126_1.allBtn_.enabled = true
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play424081029 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 424081029
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play424081030(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.725

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_1 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(424081029).content)

				arg_130_1.text_.text = var_133_1

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_3 = 29 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 29)

				if (29 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 29)) > 0 and var_133_0 < var_133_3 then
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
	Play424081030 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 424081030
		arg_134_1.duration_ = 4.8

		local var_134_0 = {
			zh = 3.4,
			ja = 4.8
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
				arg_134_0:Play424081031(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0.4

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[1404].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_1 = arg_134_1:GetWordFromCfg(424081030)
				local var_137_2 = arg_134_1:FormatText(var_137_1.content)

				arg_134_1.text_.text = var_137_2

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 16 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 16)

				if (16 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 16)) > 0 and var_137_0 < var_137_4 then
					arg_134_1.talkMaxDuration = var_137_4

					if var_137_4 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_4 + 0
					end
				end

				arg_134_1.text_.text = var_137_2
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081030", "story_v_out_424081.awb") ~= 0 then
					local var_137_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081030", "story_v_out_424081.awb") / 1000

					if var_137_5 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + 0
					end

					if var_137_1.prefab_name ~= "" and arg_134_1.actors_[var_137_1.prefab_name] ~= nil then
						local var_137_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_1.prefab_name].transform, "story_v_out_424081", "424081030", "story_v_out_424081.awb")

						arg_134_1:RecordAudio("424081030", var_137_6)
						arg_134_1:RecordAudio("424081030", var_137_6)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_424081", "424081030", "story_v_out_424081.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_424081", "424081030", "story_v_out_424081.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_7 and arg_134_1.time_ < 0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play424081031 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 424081031
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play424081034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0.075

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_1 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(424081031).content)

				arg_138_1.text_.text = var_141_1

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_3 = 3 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 3)

				if (3 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 3)) > 0 and var_141_0 < var_141_3 then
					arg_138_1.talkMaxDuration = var_141_3

					if var_141_3 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_3 + 0
					end
				end

				arg_138_1.text_.text = var_141_1
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_4 = math.max(var_141_0, arg_138_1.talkMaxDuration)

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - 0) / var_141_4

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play424081034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 424081034
		arg_142_1.duration_ = 7.73

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play424081035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 2 < arg_142_1.time_ and arg_142_1.time_ <= 2 + arg_145_0 then
				local var_145_0 = arg_142_1.bgs_.STblack

				arg_142_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_145_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_145_1 = var_145_0:GetComponent("SpriteRenderer")

				if var_145_1 and var_145_1.sprite then
					local var_145_2 = 2 * (var_145_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_145_0.transform.localScale = Vector3.New(var_145_2 / var_145_1.sprite.bounds.size.y < var_145_2 * manager.ui.mainCameraCom_.aspect / var_145_1.sprite.bounds.size.x and var_145_2 * manager.ui.mainCameraCom_.aspect / var_145_1.sprite.bounds.size.x or var_145_2 / var_145_1.sprite.bounds.size.y, var_145_2 / var_145_1.sprite.bounds.size.y < var_145_2 * manager.ui.mainCameraCom_.aspect / var_145_1.sprite.bounds.size.x and var_145_2 * manager.ui.mainCameraCom_.aspect / var_145_1.sprite.bounds.size.x or var_145_2 / var_145_1.sprite.bounds.size.y, 0)
				end

				for iter_145_0, iter_145_1 in pairs(arg_142_1.bgs_) do
					if iter_145_0 ~= "STblack" then
						iter_145_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_145_3 = 4

			if 4 < arg_142_1.time_ and arg_142_1.time_ <= var_145_3 + arg_145_0 then
				arg_142_1.allBtn_.enabled = false
			end

			if arg_142_1.time_ >= var_145_3 + 0.3 and arg_142_1.time_ < var_145_3 + 0.3 + arg_145_0 then
				arg_142_1.allBtn_.enabled = true
			end

			local var_145_4 = 0

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.mask_.enabled = true
				arg_142_1.mask_.raycastTarget = true

				arg_142_1:SetGaussion(false)
			end

			local var_145_5 = 2

			if var_145_4 <= arg_142_1.time_ and arg_142_1.time_ < var_145_4 + var_145_5 then
				local var_145_6 = Color.New(0, 0, 0)

				var_145_6.a = Mathf.Lerp(0, 1, (arg_142_1.time_ - var_145_4) / var_145_5)
				arg_142_1.mask_.color = var_145_6
			end

			if arg_142_1.time_ >= var_145_4 + var_145_5 and arg_142_1.time_ < var_145_4 + var_145_5 + arg_145_0 then
				local var_145_7 = Color.New(0, 0, 0)

				var_145_7.a = 1
				arg_142_1.mask_.color = var_145_7
			end

			local var_145_8 = 2

			if 2 < arg_142_1.time_ and arg_142_1.time_ <= var_145_8 + arg_145_0 then
				arg_142_1.mask_.enabled = true
				arg_142_1.mask_.raycastTarget = true

				arg_142_1:SetGaussion(false)
			end

			local var_145_9 = 2

			if var_145_8 <= arg_142_1.time_ and arg_142_1.time_ < var_145_8 + var_145_9 then
				local var_145_10 = Color.New(0, 0, 0)

				var_145_10.a = Mathf.Lerp(1, 0, (arg_142_1.time_ - var_145_8) / var_145_9)
				arg_142_1.mask_.color = var_145_10
			end

			if arg_142_1.time_ >= var_145_8 + var_145_9 and arg_142_1.time_ < var_145_8 + var_145_9 + arg_145_0 then
				local var_145_11 = Color.New(0, 0, 0)

				arg_142_1.mask_.enabled = false
				var_145_11.a = 0
				arg_142_1.mask_.color = var_145_11
			end

			if 2 < arg_142_1.time_ and arg_142_1.time_ <= 2 + arg_145_0 then
				arg_142_1.fswbg_:SetActive(true)
				arg_142_1.dialog_:SetActive(false)

				arg_142_1.fswtw_.percent = 0
				arg_142_1.fswt_.text = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(424081034).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.fswt_)

				arg_142_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_142_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_142_1.fswtw_:SetDirty()

				arg_142_1.typewritterCharCountI18N = 0

				SetActive(arg_142_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_142_1:ShowNextGo(false)
			end

			local var_145_12 = 4

			if 4 < arg_142_1.time_ and arg_142_1.time_ <= var_145_12 + arg_145_0 then
				arg_142_1.var_.oldValueTypewriter = arg_142_1.fswtw_.percent

				SetActive(arg_142_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_142_1:ShowNextGo(false)
			end

			local var_145_13 = 56
			local var_145_14 = 3.73333333333333
			local var_145_15, var_145_16 = arg_142_1:GetPercentByPara(arg_142_1:FormatText(arg_142_1:GetWordFromCfg(424081034).content), 1)

			if var_145_12 < arg_142_1.time_ and arg_142_1.time_ <= var_145_12 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0

				local var_145_17 = var_145_13 <= 0 and var_145_14 or var_145_14 * ((var_145_16 - arg_142_1.typewritterCharCountI18N) / var_145_13)

				if (var_145_13 <= 0 and var_145_14 or var_145_14 * ((var_145_16 - arg_142_1.typewritterCharCountI18N) / var_145_13)) > 0 and var_145_14 < var_145_17 then
					arg_142_1.talkMaxDuration = var_145_17

					if var_145_17 + var_145_12 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_17 + var_145_12
					end
				end
			end

			local var_145_18 = math.max(3.73333333333333, arg_142_1.talkMaxDuration)

			if var_145_12 <= arg_142_1.time_ and arg_142_1.time_ < var_145_12 + var_145_18 then
				arg_142_1.fswtw_.percent = Mathf.Lerp(arg_142_1.var_.oldValueTypewriter, var_145_15, (arg_142_1.time_ - var_145_12) / var_145_18)
				arg_142_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_142_1.fswtw_:SetDirty()
			end

			if arg_142_1.time_ >= var_145_12 + var_145_18 and arg_142_1.time_ < var_145_12 + var_145_18 + arg_145_0 then
				arg_142_1.fswtw_.percent = var_145_15

				arg_142_1.fswtw_:SetDirty()
				arg_142_1:ShowNextGo(true)

				arg_142_1.typewritterCharCountI18N = var_145_16
			end

			if 3.9 < arg_142_1.time_ and arg_142_1.time_ <= 3.9 + arg_145_0 then
				local var_145_19 = arg_142_1.fswbg_.transform:Find("textbox/adapt/content") or arg_142_1.fswbg_.transform:Find("textbox/content")
				local var_145_20 = arg_142_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_145_21 = var_145_19:GetComponent("RectTransform")

				var_145_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_145_21.offsetMin = Vector2.New(0, 0)
				var_145_21.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play424081035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 424081035
		arg_146_1.duration_ = 9

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play424081036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if arg_146_1.bgs_.ST0115 == nil then
				local var_149_0 = Object.Instantiate(arg_146_1.paintGo_)

				var_149_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0115")
				var_149_0.name = "ST0115"
				var_149_0.transform.parent = arg_146_1.stage_.transform
				var_149_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_146_1.bgs_.ST0115 = var_149_0
			end

			if 2 < arg_146_1.time_ and arg_146_1.time_ <= 2 + arg_149_0 then
				local var_149_1 = arg_146_1.bgs_.ST0115

				arg_146_1.bgs_.ST0115.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_149_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_149_2 = var_149_1:GetComponent("SpriteRenderer")

				if var_149_2 and var_149_2.sprite then
					local var_149_3 = 2 * (var_149_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_149_1.transform.localScale = Vector3.New(var_149_3 / var_149_2.sprite.bounds.size.y < var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x and var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x or var_149_3 / var_149_2.sprite.bounds.size.y, var_149_3 / var_149_2.sprite.bounds.size.y < var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x and var_149_3 * manager.ui.mainCameraCom_.aspect / var_149_2.sprite.bounds.size.x or var_149_3 / var_149_2.sprite.bounds.size.y, 0)
				end

				for iter_149_0, iter_149_1 in pairs(arg_146_1.bgs_) do
					if iter_149_0 ~= "ST0115" then
						iter_149_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_149_4 = 4

			if 4 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.allBtn_.enabled = false
			end

			if arg_146_1.time_ >= var_149_4 + 0.3 and arg_146_1.time_ < var_149_4 + 0.3 + arg_149_0 then
				arg_146_1.allBtn_.enabled = true
			end

			local var_149_5 = 0

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 then
				arg_146_1.mask_.enabled = true
				arg_146_1.mask_.raycastTarget = true

				arg_146_1:SetGaussion(false)
			end

			local var_149_6 = 2

			if var_149_5 <= arg_146_1.time_ and arg_146_1.time_ < var_149_5 + var_149_6 then
				local var_149_7 = Color.New(0, 0, 0)

				var_149_7.a = Mathf.Lerp(0, 1, (arg_146_1.time_ - var_149_5) / var_149_6)
				arg_146_1.mask_.color = var_149_7
			end

			if arg_146_1.time_ >= var_149_5 + var_149_6 and arg_146_1.time_ < var_149_5 + var_149_6 + arg_149_0 then
				local var_149_8 = Color.New(0, 0, 0)

				var_149_8.a = 1
				arg_146_1.mask_.color = var_149_8
			end

			local var_149_9 = 2

			if 2 < arg_146_1.time_ and arg_146_1.time_ <= var_149_9 + arg_149_0 then
				arg_146_1.mask_.enabled = true
				arg_146_1.mask_.raycastTarget = true

				arg_146_1:SetGaussion(false)
			end

			local var_149_10 = 2

			if var_149_9 <= arg_146_1.time_ and arg_146_1.time_ < var_149_9 + var_149_10 then
				local var_149_11 = Color.New(0, 0, 0)

				var_149_11.a = Mathf.Lerp(1, 0, (arg_146_1.time_ - var_149_9) / var_149_10)
				arg_146_1.mask_.color = var_149_11
			end

			if arg_146_1.time_ >= var_149_9 + var_149_10 and arg_146_1.time_ < var_149_9 + var_149_10 + arg_149_0 then
				local var_149_12 = Color.New(0, 0, 0)

				arg_146_1.mask_.enabled = false
				var_149_12.a = 0
				arg_146_1.mask_.color = var_149_12
			end

			if 2 < arg_146_1.time_ and arg_146_1.time_ <= 2 + arg_149_0 then
				arg_146_1.fswbg_:SetActive(false)
				arg_146_1.dialog_:SetActive(false)
				SetActive(arg_146_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_146_1:ShowNextGo(false)
			end

			if 0.166666666666667 < arg_146_1.time_ and arg_146_1.time_ <= 0.166666666666667 + arg_149_0 then
				arg_146_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if 1.66666666666667 < arg_146_1.time_ and arg_146_1.time_ <= 1.66666666666667 + arg_149_0 then
				arg_146_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_146_1.frameCnt_ <= 1 then
				arg_146_1.dialog_:SetActive(false)
			end

			local var_149_15 = 4
			local var_149_16 = 0.475

			if 4 < arg_146_1.time_ and arg_146_1.time_ <= var_149_15 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0

				arg_146_1.dialog_:SetActive(true)

				arg_146_1.dialogCg_.alpha = 0

				local var_149_17 = LeanTween.value(arg_146_1.dialog_, 0, 1, 0.3)

				var_149_17:setOnUpdate(LuaHelper.FloatAction(function(arg_150_0)
					arg_146_1.dialogCg_.alpha = arg_150_0
				end))
				var_149_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_146_1.dialog_)
					var_149_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_146_1.duration_ = arg_146_1.duration_ + 0.3

				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_18 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(424081035).content)

				arg_146_1.text_.text = var_149_18

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_20 = 19 <= 0 and var_149_16 or var_149_16 * (utf8.len(var_149_18) / 19)

				if (19 <= 0 and var_149_16 or var_149_16 * (utf8.len(var_149_18) / 19)) > 0 and var_149_16 < var_149_20 then
					arg_146_1.talkMaxDuration = var_149_20
					var_149_15 = var_149_15 + 0.3

					if var_149_20 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_20 + var_149_15
					end
				end

				arg_146_1.text_.text = var_149_18
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_21 = var_149_15 + 0.3
			local var_149_22 = math.max(var_149_16, arg_146_1.talkMaxDuration)

			if var_149_15 + 0.3 <= arg_146_1.time_ and arg_146_1.time_ < var_149_21 + var_149_22 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_21) / var_149_22

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_21 + var_149_22 and arg_146_1.time_ < var_149_21 + var_149_22 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play424081036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 424081036
		arg_152_1.duration_ = 2.33

		local var_152_0 = {
			zh = 1.566,
			ja = 2.333
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play424081037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1094"]) and arg_152_1.var_.actorSpriteComps1094 == nil then
				arg_152_1.var_.actorSpriteComps1094 = arg_152_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_0 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1094"]) then
				if arg_152_1.var_.actorSpriteComps1094 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								iter_155_1.color = Color.New(Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor1.r, (arg_152_1.time_ - 0) / var_155_0), Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor1.g, (arg_152_1.time_ - 0) / var_155_0), (Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor1.b, (arg_152_1.time_ - 0) / var_155_0)))
							else
								local var_155_1 = Mathf.Lerp(iter_155_1.color.r, 1, (arg_152_1.time_ - 0) / var_155_0)

								iter_155_1.color = Color.New(var_155_1, var_155_1, var_155_1)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1094"]) and arg_152_1.var_.actorSpriteComps1094 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_155_3 then
						iter_155_3.color = arg_152_1.isInRecall_ and (arg_152_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_152_1.var_.actorSpriteComps1094 = nil
			end

			local var_155_2 = arg_152_1.actors_["1094"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1094 = var_155_2.localPosition
				var_155_2.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("1094", 3)

				for iter_155_4 = 0, var_155_2.childCount - 1 do
					local var_155_3 = var_155_2:GetChild(iter_155_4)

					if var_155_3.name == "split_2" or not string.find(var_155_3.name, "split") then
						var_155_3.gameObject:SetActive(true)
					else
						var_155_3.gameObject:SetActive(false)
					end
				end
			end

			local var_155_4 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 then
				var_155_2.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_152_1.time_ - 0) / var_155_4)
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 then
				var_155_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_155_5 = 0
			local var_155_6 = 0.15

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_7 = arg_152_1:GetWordFromCfg(424081036)
				local var_155_8 = arg_152_1:FormatText(var_155_7.content)

				arg_152_1.text_.text = var_155_8

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_10 = 6 <= 0 and var_155_6 or var_155_6 * (utf8.len(var_155_8) / 6)

				if (6 <= 0 and var_155_6 or var_155_6 * (utf8.len(var_155_8) / 6)) > 0 and var_155_6 < var_155_10 then
					arg_152_1.talkMaxDuration = var_155_10

					if var_155_10 + var_155_5 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_5
					end
				end

				arg_152_1.text_.text = var_155_8
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081036", "story_v_out_424081.awb") ~= 0 then
					local var_155_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081036", "story_v_out_424081.awb") / 1000

					if var_155_11 + var_155_5 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_11 + var_155_5
					end

					if var_155_7.prefab_name ~= "" and arg_152_1.actors_[var_155_7.prefab_name] ~= nil then
						local var_155_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_7.prefab_name].transform, "story_v_out_424081", "424081036", "story_v_out_424081.awb")

						arg_152_1:RecordAudio("424081036", var_155_12)
						arg_152_1:RecordAudio("424081036", var_155_12)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_424081", "424081036", "story_v_out_424081.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_424081", "424081036", "story_v_out_424081.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_13 = math.max(var_155_6, arg_152_1.talkMaxDuration)

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_13 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_5) / var_155_13

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_5 + var_155_13 and arg_152_1.time_ < var_155_5 + var_155_13 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play424081037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 424081037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play424081038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1094"]) and arg_156_1.var_.actorSpriteComps1094 == nil then
				arg_156_1.var_.actorSpriteComps1094 = arg_156_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_0 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1094"]) then
				if arg_156_1.var_.actorSpriteComps1094 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								iter_159_1.color = Color.New(Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor2.r, (arg_156_1.time_ - 0) / var_159_0), Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor2.g, (arg_156_1.time_ - 0) / var_159_0), (Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor2.b, (arg_156_1.time_ - 0) / var_159_0)))
							else
								local var_159_1 = Mathf.Lerp(iter_159_1.color.r, 0.5, (arg_156_1.time_ - 0) / var_159_0)

								iter_159_1.color = Color.New(var_159_1, var_159_1, var_159_1)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1094"]) and arg_156_1.var_.actorSpriteComps1094 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_159_3 then
						iter_159_3.color = arg_156_1.isInRecall_ and (arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_156_1.var_.actorSpriteComps1094 = nil
			end

			local var_159_2 = 0
			local var_159_3 = 0.4

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_2 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_4 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(424081037).content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_6 = 16 <= 0 and var_159_3 or var_159_3 * (utf8.len(var_159_4) / 16)

				if (16 <= 0 and var_159_3 or var_159_3 * (utf8.len(var_159_4) / 16)) > 0 and var_159_3 < var_159_6 then
					arg_156_1.talkMaxDuration = var_159_6

					if var_159_6 + var_159_2 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_6 + var_159_2
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_3, arg_156_1.talkMaxDuration)

			if var_159_2 <= arg_156_1.time_ and arg_156_1.time_ < var_159_2 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_2) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_2 + var_159_7 and arg_156_1.time_ < var_159_2 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play424081038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 424081038
		arg_160_1.duration_ = 4.33

		local var_160_0 = {
			zh = 3.3,
			ja = 4.333
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play424081039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.325

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_1 = arg_160_1:GetWordFromCfg(424081038)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 13 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 13)

				if (13 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 13)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081038", "story_v_out_424081.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081038", "story_v_out_424081.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_424081", "424081038", "story_v_out_424081.awb")

						arg_160_1:RecordAudio("424081038", var_163_6)
						arg_160_1:RecordAudio("424081038", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_424081", "424081038", "story_v_out_424081.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_424081", "424081038", "story_v_out_424081.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play424081039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 424081039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play424081040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.425

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_1 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(424081039).content)

				arg_164_1.text_.text = var_167_1

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_3 = 17 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 17)

				if (17 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_1) / 17)) > 0 and var_167_0 < var_167_3 then
					arg_164_1.talkMaxDuration = var_167_3

					if var_167_3 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_3 + 0
					end
				end

				arg_164_1.text_.text = var_167_1
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_4 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_4

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play424081040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 424081040
		arg_168_1.duration_ = 8.87

		local var_168_0 = {
			zh = 6.866,
			ja = 8.866
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play424081041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.925

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_1 = arg_168_1:GetWordFromCfg(424081040)
				local var_171_2 = arg_168_1:FormatText(var_171_1.content)

				arg_168_1.text_.text = var_171_2

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 37 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 37)

				if (37 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 37)) > 0 and var_171_0 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end

				arg_168_1.text_.text = var_171_2
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081040", "story_v_out_424081.awb") ~= 0 then
					local var_171_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081040", "story_v_out_424081.awb") / 1000

					if var_171_5 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + 0
					end

					if var_171_1.prefab_name ~= "" and arg_168_1.actors_[var_171_1.prefab_name] ~= nil then
						local var_171_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_1.prefab_name].transform, "story_v_out_424081", "424081040", "story_v_out_424081.awb")

						arg_168_1:RecordAudio("424081040", var_171_6)
						arg_168_1:RecordAudio("424081040", var_171_6)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_424081", "424081040", "story_v_out_424081.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_424081", "424081040", "story_v_out_424081.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play424081041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 424081041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play424081042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1094 = arg_172_1.actors_["1094"].transform.localPosition
				arg_172_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_172_1:CheckSpriteTmpPos("1094", 7)

				for iter_175_0 = 0, arg_172_1.actors_["1094"].transform.childCount - 1 do
					local var_175_0 = arg_172_1.actors_["1094"].transform:GetChild(iter_175_0)

					if var_175_0.name == "" or not string.find(var_175_0.name, "split") then
						var_175_0.gameObject:SetActive(true)
					else
						var_175_0.gameObject:SetActive(false)
					end
				end
			end

			local var_175_1 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_1 then
				arg_172_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_172_1.time_ - 0) / var_175_1)
			end

			if arg_172_1.time_ >= 0 + var_175_1 and arg_172_1.time_ < 0 + var_175_1 + arg_175_0 then
				arg_172_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.1 < arg_172_1.time_ and arg_172_1.time_ <= 0.1 + arg_175_0 then
				arg_172_1:AudioAction("play", "effect", "se_story_side_1081", "se_story_side_1081_dooropen", "")
			end

			local var_175_3 = 0
			local var_175_4 = 0.6

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_3 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_5 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(424081041).content)

				arg_172_1.text_.text = var_175_5

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_7 = 24 <= 0 and var_175_4 or var_175_4 * (utf8.len(var_175_5) / 24)

				if (24 <= 0 and var_175_4 or var_175_4 * (utf8.len(var_175_5) / 24)) > 0 and var_175_4 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_3 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_3
					end
				end

				arg_172_1.text_.text = var_175_5
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_8 = math.max(var_175_4, arg_172_1.talkMaxDuration)

			if var_175_3 <= arg_172_1.time_ and arg_172_1.time_ < var_175_3 + var_175_8 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_3) / var_175_8

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_3 + var_175_8 and arg_172_1.time_ < var_175_3 + var_175_8 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play424081042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 424081042
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play424081043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.125

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_1 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(424081042).content)

				arg_176_1.text_.text = var_179_1

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_3 = 5 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 5)

				if (5 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 5)) > 0 and var_179_0 < var_179_3 then
					arg_176_1.talkMaxDuration = var_179_3

					if var_179_3 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_3 + 0
					end
				end

				arg_176_1.text_.text = var_179_1
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_4 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_4

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play424081043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 424081043
		arg_180_1.duration_ = 4.33

		local var_180_0 = {
			zh = 3.766,
			ja = 4.333
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play424081044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["1094"]) and arg_180_1.var_.actorSpriteComps1094 == nil then
				arg_180_1.var_.actorSpriteComps1094 = arg_180_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_0 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["1094"]) then
				if arg_180_1.var_.actorSpriteComps1094 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								iter_183_1.color = Color.New(Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor1.r, (arg_180_1.time_ - 0) / var_183_0), Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor1.g, (arg_180_1.time_ - 0) / var_183_0), (Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor1.b, (arg_180_1.time_ - 0) / var_183_0)))
							else
								local var_183_1 = Mathf.Lerp(iter_183_1.color.r, 1, (arg_180_1.time_ - 0) / var_183_0)

								iter_183_1.color = Color.New(var_183_1, var_183_1, var_183_1)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["1094"]) and arg_180_1.var_.actorSpriteComps1094 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_183_3 then
						iter_183_3.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_180_1.var_.actorSpriteComps1094 = nil
			end

			local var_183_2 = arg_180_1.actors_["1094"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1094 = var_183_2.localPosition
				var_183_2.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("1094", 3)

				for iter_183_4 = 0, var_183_2.childCount - 1 do
					local var_183_3 = var_183_2:GetChild(iter_183_4)

					if var_183_3.name == "split_3" or not string.find(var_183_3.name, "split") then
						var_183_3.gameObject:SetActive(true)
					else
						var_183_3.gameObject:SetActive(false)
					end
				end
			end

			local var_183_4 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 then
				var_183_2.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_180_1.time_ - 0) / var_183_4)
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 then
				var_183_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_183_5 = 0
			local var_183_6 = 0.3

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_7 = arg_180_1:GetWordFromCfg(424081043)
				local var_183_8 = arg_180_1:FormatText(var_183_7.content)

				arg_180_1.text_.text = var_183_8

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_10 = 12 <= 0 and var_183_6 or var_183_6 * (utf8.len(var_183_8) / 12)

				if (12 <= 0 and var_183_6 or var_183_6 * (utf8.len(var_183_8) / 12)) > 0 and var_183_6 < var_183_10 then
					arg_180_1.talkMaxDuration = var_183_10

					if var_183_10 + var_183_5 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_5
					end
				end

				arg_180_1.text_.text = var_183_8
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081043", "story_v_out_424081.awb") ~= 0 then
					local var_183_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081043", "story_v_out_424081.awb") / 1000

					if var_183_11 + var_183_5 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_11 + var_183_5
					end

					if var_183_7.prefab_name ~= "" and arg_180_1.actors_[var_183_7.prefab_name] ~= nil then
						local var_183_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_7.prefab_name].transform, "story_v_out_424081", "424081043", "story_v_out_424081.awb")

						arg_180_1:RecordAudio("424081043", var_183_12)
						arg_180_1:RecordAudio("424081043", var_183_12)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_424081", "424081043", "story_v_out_424081.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_424081", "424081043", "story_v_out_424081.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_13 = math.max(var_183_6, arg_180_1.talkMaxDuration)

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_13 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_5) / var_183_13

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_5 + var_183_13 and arg_180_1.time_ < var_183_5 + var_183_13 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play424081044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 424081044
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play424081045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1094"]) and arg_184_1.var_.actorSpriteComps1094 == nil then
				arg_184_1.var_.actorSpriteComps1094 = arg_184_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_0 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1094"]) then
				if arg_184_1.var_.actorSpriteComps1094 then
					for iter_187_0, iter_187_1 in pairs(arg_184_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_187_1 then
							if arg_184_1.isInRecall_ then
								iter_187_1.color = Color.New(Mathf.Lerp(iter_187_1.color.r, arg_184_1.hightColor2.r, (arg_184_1.time_ - 0) / var_187_0), Mathf.Lerp(iter_187_1.color.g, arg_184_1.hightColor2.g, (arg_184_1.time_ - 0) / var_187_0), (Mathf.Lerp(iter_187_1.color.b, arg_184_1.hightColor2.b, (arg_184_1.time_ - 0) / var_187_0)))
							else
								local var_187_1 = Mathf.Lerp(iter_187_1.color.r, 0.5, (arg_184_1.time_ - 0) / var_187_0)

								iter_187_1.color = Color.New(var_187_1, var_187_1, var_187_1)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1094"]) and arg_184_1.var_.actorSpriteComps1094 then
				for iter_187_2, iter_187_3 in pairs(arg_184_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_187_3 then
						iter_187_3.color = arg_184_1.isInRecall_ and (arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_184_1.var_.actorSpriteComps1094 = nil
			end

			local var_187_2 = 0
			local var_187_3 = 0.6

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_4 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(424081044).content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_6 = 24 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_4) / 24)

				if (24 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_4) / 24)) > 0 and var_187_3 < var_187_6 then
					arg_184_1.talkMaxDuration = var_187_6

					if var_187_6 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_6 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_7 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_7 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_7

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_7 and arg_184_1.time_ < var_187_2 + var_187_7 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play424081045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 424081045
		arg_188_1.duration_ = 4.43

		local var_188_0 = {
			zh = 3.4,
			ja = 4.433
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play424081046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1094"]) and arg_188_1.var_.actorSpriteComps1094 == nil then
				arg_188_1.var_.actorSpriteComps1094 = arg_188_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_0 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1094"]) then
				if arg_188_1.var_.actorSpriteComps1094 then
					for iter_191_0, iter_191_1 in pairs(arg_188_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_191_1 then
							if arg_188_1.isInRecall_ then
								iter_191_1.color = Color.New(Mathf.Lerp(iter_191_1.color.r, arg_188_1.hightColor1.r, (arg_188_1.time_ - 0) / var_191_0), Mathf.Lerp(iter_191_1.color.g, arg_188_1.hightColor1.g, (arg_188_1.time_ - 0) / var_191_0), (Mathf.Lerp(iter_191_1.color.b, arg_188_1.hightColor1.b, (arg_188_1.time_ - 0) / var_191_0)))
							else
								local var_191_1 = Mathf.Lerp(iter_191_1.color.r, 1, (arg_188_1.time_ - 0) / var_191_0)

								iter_191_1.color = Color.New(var_191_1, var_191_1, var_191_1)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1094"]) and arg_188_1.var_.actorSpriteComps1094 then
				for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_191_3 then
						iter_191_3.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_188_1.var_.actorSpriteComps1094 = nil
			end

			local var_191_2 = arg_188_1.actors_["1094"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1094 = var_191_2.localPosition
				var_191_2.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("1094", 3)

				for iter_191_4 = 0, var_191_2.childCount - 1 do
					local var_191_3 = var_191_2:GetChild(iter_191_4)

					if var_191_3.name == "split_4" then
						var_191_3:SetAsLastSibling()
						var_191_3.gameObject:SetActive(true)

						arg_188_1.var_.actorSpriteSplit1094 = var_191_3.gameObject:GetComponent(typeof(Image))

						arg_188_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_191_4 = 0.5

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				var_191_2.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_188_1.time_ - 0) / var_191_4)

				if arg_188_1.var_.actorSpriteSplit1094 ~= nil then
					arg_188_1.var_.actorSpriteSplit1094:SetAlpha((arg_188_1.time_ - 0) / var_191_4)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				var_191_2.localPosition = Vector3.New(0, -335, -230)

				if arg_188_1.var_.actorSpriteSplit1094 ~= nil then
					arg_188_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_191_5 = 0
			local var_191_6 = 0.3

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_7 = arg_188_1:GetWordFromCfg(424081045)
				local var_191_8 = arg_188_1:FormatText(var_191_7.content)

				arg_188_1.text_.text = var_191_8

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_10 = 12 <= 0 and var_191_6 or var_191_6 * (utf8.len(var_191_8) / 12)

				if (12 <= 0 and var_191_6 or var_191_6 * (utf8.len(var_191_8) / 12)) > 0 and var_191_6 < var_191_10 then
					arg_188_1.talkMaxDuration = var_191_10

					if var_191_10 + var_191_5 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_10 + var_191_5
					end
				end

				arg_188_1.text_.text = var_191_8
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081045", "story_v_out_424081.awb") ~= 0 then
					local var_191_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081045", "story_v_out_424081.awb") / 1000

					if var_191_11 + var_191_5 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_11 + var_191_5
					end

					if var_191_7.prefab_name ~= "" and arg_188_1.actors_[var_191_7.prefab_name] ~= nil then
						local var_191_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_7.prefab_name].transform, "story_v_out_424081", "424081045", "story_v_out_424081.awb")

						arg_188_1:RecordAudio("424081045", var_191_12)
						arg_188_1:RecordAudio("424081045", var_191_12)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_424081", "424081045", "story_v_out_424081.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_424081", "424081045", "story_v_out_424081.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_13 = math.max(var_191_6, arg_188_1.talkMaxDuration)

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_13 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_5) / var_191_13

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_5 + var_191_13 and arg_188_1.time_ < var_191_5 + var_191_13 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play424081046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 424081046
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play424081047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1094"]) and arg_192_1.var_.actorSpriteComps1094 == nil then
				arg_192_1.var_.actorSpriteComps1094 = arg_192_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_0 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1094"]) then
				if arg_192_1.var_.actorSpriteComps1094 then
					for iter_195_0, iter_195_1 in pairs(arg_192_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_195_1 then
							if arg_192_1.isInRecall_ then
								iter_195_1.color = Color.New(Mathf.Lerp(iter_195_1.color.r, arg_192_1.hightColor2.r, (arg_192_1.time_ - 0) / var_195_0), Mathf.Lerp(iter_195_1.color.g, arg_192_1.hightColor2.g, (arg_192_1.time_ - 0) / var_195_0), (Mathf.Lerp(iter_195_1.color.b, arg_192_1.hightColor2.b, (arg_192_1.time_ - 0) / var_195_0)))
							else
								local var_195_1 = Mathf.Lerp(iter_195_1.color.r, 0.5, (arg_192_1.time_ - 0) / var_195_0)

								iter_195_1.color = Color.New(var_195_1, var_195_1, var_195_1)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1094"]) and arg_192_1.var_.actorSpriteComps1094 then
				for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_195_3 then
						iter_195_3.color = arg_192_1.isInRecall_ and (arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_192_1.var_.actorSpriteComps1094 = nil
			end

			local var_195_2 = 0
			local var_195_3 = 0.65

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_2 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_4 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(424081046).content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_6 = 26 <= 0 and var_195_3 or var_195_3 * (utf8.len(var_195_4) / 26)

				if (26 <= 0 and var_195_3 or var_195_3 * (utf8.len(var_195_4) / 26)) > 0 and var_195_3 < var_195_6 then
					arg_192_1.talkMaxDuration = var_195_6

					if var_195_6 + var_195_2 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_6 + var_195_2
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_7 = math.max(var_195_3, arg_192_1.talkMaxDuration)

			if var_195_2 <= arg_192_1.time_ and arg_192_1.time_ < var_195_2 + var_195_7 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_2) / var_195_7

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_2 + var_195_7 and arg_192_1.time_ < var_195_2 + var_195_7 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play424081047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 424081047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play424081048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1094 = arg_196_1.actors_["1094"].transform.localPosition
				arg_196_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("1094", 7)

				for iter_199_0 = 0, arg_196_1.actors_["1094"].transform.childCount - 1 do
					local var_199_0 = arg_196_1.actors_["1094"].transform:GetChild(iter_199_0)

					if var_199_0.name == "" or not string.find(var_199_0.name, "split") then
						var_199_0.gameObject:SetActive(true)
					else
						var_199_0.gameObject:SetActive(false)
					end
				end
			end

			local var_199_1 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				arg_196_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_196_1.time_ - 0) / var_199_1)
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 then
				arg_196_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.1 < arg_196_1.time_ and arg_196_1.time_ <= 0.1 + arg_199_0 then
				arg_196_1:AudioAction("play", "effect", "minigame_activity_4_0", "minigame_activity_4_0_pintu_walk01", "")
			end

			local var_199_3 = 0
			local var_199_4 = 0.95

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_3 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_5 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(424081047).content)

				arg_196_1.text_.text = var_199_5

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_7 = 38 <= 0 and var_199_4 or var_199_4 * (utf8.len(var_199_5) / 38)

				if (38 <= 0 and var_199_4 or var_199_4 * (utf8.len(var_199_5) / 38)) > 0 and var_199_4 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_3 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_3
					end
				end

				arg_196_1.text_.text = var_199_5
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_8 = math.max(var_199_4, arg_196_1.talkMaxDuration)

			if var_199_3 <= arg_196_1.time_ and arg_196_1.time_ < var_199_3 + var_199_8 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_3) / var_199_8

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_3 + var_199_8 and arg_196_1.time_ < var_199_3 + var_199_8 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play424081048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 424081048
		arg_200_1.duration_ = 9

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play424081049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 2 < arg_200_1.time_ and arg_200_1.time_ <= 2 + arg_203_0 then
				local var_203_0 = arg_200_1.bgs_.STblack

				arg_200_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_203_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_203_1 = var_203_0:GetComponent("SpriteRenderer")

				if var_203_1 and var_203_1.sprite then
					local var_203_2 = 2 * (var_203_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_203_0.transform.localScale = Vector3.New(var_203_2 / var_203_1.sprite.bounds.size.y < var_203_2 * manager.ui.mainCameraCom_.aspect / var_203_1.sprite.bounds.size.x and var_203_2 * manager.ui.mainCameraCom_.aspect / var_203_1.sprite.bounds.size.x or var_203_2 / var_203_1.sprite.bounds.size.y, var_203_2 / var_203_1.sprite.bounds.size.y < var_203_2 * manager.ui.mainCameraCom_.aspect / var_203_1.sprite.bounds.size.x and var_203_2 * manager.ui.mainCameraCom_.aspect / var_203_1.sprite.bounds.size.x or var_203_2 / var_203_1.sprite.bounds.size.y, 0)
				end

				for iter_203_0, iter_203_1 in pairs(arg_200_1.bgs_) do
					if iter_203_0 ~= "STblack" then
						iter_203_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_203_3 = 4

			if 4 < arg_200_1.time_ and arg_200_1.time_ <= var_203_3 + arg_203_0 then
				arg_200_1.allBtn_.enabled = false
			end

			if arg_200_1.time_ >= var_203_3 + 0.3 and arg_200_1.time_ < var_203_3 + 0.3 + arg_203_0 then
				arg_200_1.allBtn_.enabled = true
			end

			local var_203_4 = 0

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_4 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_5 = 2

			if var_203_4 <= arg_200_1.time_ and arg_200_1.time_ < var_203_4 + var_203_5 then
				local var_203_6 = Color.New(0, 0, 0)

				var_203_6.a = Mathf.Lerp(0, 1, (arg_200_1.time_ - var_203_4) / var_203_5)
				arg_200_1.mask_.color = var_203_6
			end

			if arg_200_1.time_ >= var_203_4 + var_203_5 and arg_200_1.time_ < var_203_4 + var_203_5 + arg_203_0 then
				local var_203_7 = Color.New(0, 0, 0)

				var_203_7.a = 1
				arg_200_1.mask_.color = var_203_7
			end

			local var_203_8 = 2

			if 2 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_9 = 2

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_9 then
				local var_203_10 = Color.New(0, 0, 0)

				var_203_10.a = Mathf.Lerp(1, 0, (arg_200_1.time_ - var_203_8) / var_203_9)
				arg_200_1.mask_.color = var_203_10
			end

			if arg_200_1.time_ >= var_203_8 + var_203_9 and arg_200_1.time_ < var_203_8 + var_203_9 + arg_203_0 then
				local var_203_11 = Color.New(0, 0, 0)

				arg_200_1.mask_.enabled = false
				var_203_11.a = 0
				arg_200_1.mask_.color = var_203_11
			end

			if 0.5 < arg_200_1.time_ and arg_200_1.time_ <= 0.5 + arg_203_0 then
				arg_200_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_200_1.frameCnt_ <= 1 then
				arg_200_1.dialog_:SetActive(false)
			end

			local var_203_13 = 4
			local var_203_14 = 1.5

			if 4 < arg_200_1.time_ and arg_200_1.time_ <= var_203_13 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0

				arg_200_1.dialog_:SetActive(true)

				arg_200_1.dialogCg_.alpha = 0

				local var_203_15 = LeanTween.value(arg_200_1.dialog_, 0, 1, 0.3)

				var_203_15:setOnUpdate(LuaHelper.FloatAction(function(arg_204_0)
					arg_200_1.dialogCg_.alpha = arg_204_0
				end))
				var_203_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_200_1.dialog_)
					var_203_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_200_1.duration_ = arg_200_1.duration_ + 0.3

				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_16 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(424081048).content)

				arg_200_1.text_.text = var_203_16

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_18 = 60 <= 0 and var_203_14 or var_203_14 * (utf8.len(var_203_16) / 60)

				if (60 <= 0 and var_203_14 or var_203_14 * (utf8.len(var_203_16) / 60)) > 0 and var_203_14 < var_203_18 then
					arg_200_1.talkMaxDuration = var_203_18
					var_203_13 = var_203_13 + 0.3

					if var_203_18 + var_203_13 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_18 + var_203_13
					end
				end

				arg_200_1.text_.text = var_203_16
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_19 = var_203_13 + 0.3
			local var_203_20 = math.max(var_203_14, arg_200_1.talkMaxDuration)

			if var_203_13 + 0.3 <= arg_200_1.time_ and arg_200_1.time_ < var_203_19 + var_203_20 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_19) / var_203_20

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_19 + var_203_20 and arg_200_1.time_ < var_203_19 + var_203_20 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play424081049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 424081049
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play424081050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 1.075

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_1 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(424081049).content)

				arg_206_1.text_.text = var_209_1

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_3 = 43 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 43)

				if (43 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 43)) > 0 and var_209_0 < var_209_3 then
					arg_206_1.talkMaxDuration = var_209_3

					if var_209_3 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_3 + 0
					end
				end

				arg_206_1.text_.text = var_209_1
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_4 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_4

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play424081050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 424081050
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play424081051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0.875

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_1 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(424081050).content)

				arg_210_1.text_.text = var_213_1

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_3 = 35 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 35)

				if (35 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 35)) > 0 and var_213_0 < var_213_3 then
					arg_210_1.talkMaxDuration = var_213_3

					if var_213_3 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_3 + 0
					end
				end

				arg_210_1.text_.text = var_213_1
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_4 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_4

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play424081051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 424081051
		arg_214_1.duration_ = 6.97

		local var_214_0 = {
			zh = 4.966,
			ja = 6.966
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play424081052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				local var_217_0 = arg_214_1.bgs_.ST0115

				arg_214_1.bgs_.ST0115.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_217_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_217_1 = var_217_0:GetComponent("SpriteRenderer")

				if var_217_1 and var_217_1.sprite then
					local var_217_2 = 2 * (var_217_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_217_0.transform.localScale = Vector3.New(var_217_2 / var_217_1.sprite.bounds.size.y < var_217_2 * manager.ui.mainCameraCom_.aspect / var_217_1.sprite.bounds.size.x and var_217_2 * manager.ui.mainCameraCom_.aspect / var_217_1.sprite.bounds.size.x or var_217_2 / var_217_1.sprite.bounds.size.y, var_217_2 / var_217_1.sprite.bounds.size.y < var_217_2 * manager.ui.mainCameraCom_.aspect / var_217_1.sprite.bounds.size.x and var_217_2 * manager.ui.mainCameraCom_.aspect / var_217_1.sprite.bounds.size.x or var_217_2 / var_217_1.sprite.bounds.size.y, 0)
				end

				for iter_217_0, iter_217_1 in pairs(arg_214_1.bgs_) do
					if iter_217_0 ~= "ST0115" then
						iter_217_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_217_3 = 2

			if 2 < arg_214_1.time_ and arg_214_1.time_ <= var_217_3 + arg_217_0 then
				arg_214_1.allBtn_.enabled = false
			end

			if arg_214_1.time_ >= var_217_3 + 0.3 and arg_214_1.time_ < var_217_3 + 0.3 + arg_217_0 then
				arg_214_1.allBtn_.enabled = true
			end

			local var_217_4 = 0

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.mask_.enabled = true
				arg_214_1.mask_.raycastTarget = true

				arg_214_1:SetGaussion(false)
			end

			local var_217_5 = 2

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_5 then
				local var_217_6 = Color.New(0, 0, 0)

				var_217_6.a = Mathf.Lerp(1, 0, (arg_214_1.time_ - var_217_4) / var_217_5)
				arg_214_1.mask_.color = var_217_6
			end

			if arg_214_1.time_ >= var_217_4 + var_217_5 and arg_214_1.time_ < var_217_4 + var_217_5 + arg_217_0 then
				local var_217_7 = Color.New(0, 0, 0)

				arg_214_1.mask_.enabled = false
				var_217_7.a = 0
				arg_214_1.mask_.color = var_217_7
			end

			local var_217_8 = "10154"

			if arg_214_1.actors_["10154"] == nil then
				local var_217_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10154")

				if not isNil(var_217_9) then
					local var_217_10 = Object.Instantiate(var_217_9, arg_214_1.canvasGo_.transform)

					var_217_10.transform:SetSiblingIndex(1)

					var_217_10.name = var_217_8
					var_217_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_214_1.actors_[var_217_8] = var_217_10

					if arg_214_1.isInRecall_ then
						for iter_217_2, iter_217_3 in ipairs((var_217_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_217_3.color = arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_217_11 = arg_214_1.actors_["10154"]

			if 2 < arg_214_1.time_ and arg_214_1.time_ <= 2 + arg_217_0 and not isNil(var_217_11) and arg_214_1.var_.actorSpriteComps10154 == nil then
				arg_214_1.var_.actorSpriteComps10154 = var_217_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_12 = 0.2

			if 2 <= arg_214_1.time_ and arg_214_1.time_ < 2 + var_217_12 and not isNil(var_217_11) then
				if arg_214_1.var_.actorSpriteComps10154 then
					for iter_217_4, iter_217_5 in pairs(arg_214_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_217_5 then
							if arg_214_1.isInRecall_ then
								iter_217_5.color = Color.New(Mathf.Lerp(iter_217_5.color.r, arg_214_1.hightColor1.r, (arg_214_1.time_ - 2) / var_217_12), Mathf.Lerp(iter_217_5.color.g, arg_214_1.hightColor1.g, (arg_214_1.time_ - 2) / var_217_12), (Mathf.Lerp(iter_217_5.color.b, arg_214_1.hightColor1.b, (arg_214_1.time_ - 2) / var_217_12)))
							else
								local var_217_13 = Mathf.Lerp(iter_217_5.color.r, 1, (arg_214_1.time_ - 2) / var_217_12)

								iter_217_5.color = Color.New(var_217_13, var_217_13, var_217_13)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 2 + var_217_12 and arg_214_1.time_ < 2 + var_217_12 + arg_217_0 and not isNil(var_217_11) and arg_214_1.var_.actorSpriteComps10154 then
				for iter_217_6, iter_217_7 in pairs(arg_214_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_217_7 then
						iter_217_7.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_214_1.var_.actorSpriteComps10154 = nil
			end

			local var_217_14 = arg_214_1.actors_["10154"].transform

			if 2 < arg_214_1.time_ and arg_214_1.time_ <= 2 + arg_217_0 then
				arg_214_1.var_.moveOldPos10154 = var_217_14.localPosition
				var_217_14.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("10154", 3)

				for iter_217_8 = 0, var_217_14.childCount - 1 do
					local var_217_15 = var_217_14:GetChild(iter_217_8)

					if var_217_15.name == "split_4" or not string.find(var_217_15.name, "split") then
						var_217_15.gameObject:SetActive(true)
					else
						var_217_15.gameObject:SetActive(false)
					end
				end
			end

			local var_217_16 = 0.001

			if 2 <= arg_214_1.time_ and arg_214_1.time_ < 2 + var_217_16 then
				var_217_14.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_214_1.time_ - 2) / var_217_16)
			end

			if arg_214_1.time_ >= 2 + var_217_16 and arg_214_1.time_ < 2 + var_217_16 + arg_217_0 then
				var_217_14.localPosition = Vector3.New(-20, -338, -538)
			end

			if 0.258331506978721 < arg_214_1.time_ and arg_214_1.time_ <= 0.258331506978721 + arg_217_0 then
				arg_214_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_214_1.frameCnt_ <= 1 then
				arg_214_1.dialog_:SetActive(false)
			end

			local var_217_18 = 2
			local var_217_19 = 0.25

			if 2 < arg_214_1.time_ and arg_214_1.time_ <= var_217_18 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0

				arg_214_1.dialog_:SetActive(true)

				arg_214_1.dialogCg_.alpha = 0

				local var_217_20 = LeanTween.value(arg_214_1.dialog_, 0, 1, 0.3)

				var_217_20:setOnUpdate(LuaHelper.FloatAction(function(arg_218_0)
					arg_214_1.dialogCg_.alpha = arg_218_0
				end))
				var_217_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_214_1.dialog_)
					var_217_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_214_1.duration_ = arg_214_1.duration_ + 0.3

				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_21 = arg_214_1:GetWordFromCfg(424081051)
				local var_217_22 = arg_214_1:FormatText(var_217_21.content)

				arg_214_1.text_.text = var_217_22

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_24 = 10 <= 0 and var_217_19 or var_217_19 * (utf8.len(var_217_22) / 10)

				if (10 <= 0 and var_217_19 or var_217_19 * (utf8.len(var_217_22) / 10)) > 0 and var_217_19 < var_217_24 then
					arg_214_1.talkMaxDuration = var_217_24
					var_217_18 = var_217_18 + 0.3

					if var_217_24 + var_217_18 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_24 + var_217_18
					end
				end

				arg_214_1.text_.text = var_217_22
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081051", "story_v_out_424081.awb") ~= 0 then
					local var_217_25 = manager.audio:GetVoiceLength("story_v_out_424081", "424081051", "story_v_out_424081.awb") / 1000

					if var_217_25 + var_217_18 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_25 + var_217_18
					end

					if var_217_21.prefab_name ~= "" and arg_214_1.actors_[var_217_21.prefab_name] ~= nil then
						local var_217_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_21.prefab_name].transform, "story_v_out_424081", "424081051", "story_v_out_424081.awb")

						arg_214_1:RecordAudio("424081051", var_217_26)
						arg_214_1:RecordAudio("424081051", var_217_26)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_424081", "424081051", "story_v_out_424081.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_424081", "424081051", "story_v_out_424081.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_27 = var_217_18 + 0.3
			local var_217_28 = math.max(var_217_19, arg_214_1.talkMaxDuration)

			if var_217_18 + 0.3 <= arg_214_1.time_ and arg_214_1.time_ < var_217_27 + var_217_28 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_27) / var_217_28

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_27 + var_217_28 and arg_214_1.time_ < var_217_27 + var_217_28 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play424081052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 424081052
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play424081053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["10154"]) and arg_220_1.var_.actorSpriteComps10154 == nil then
				arg_220_1.var_.actorSpriteComps10154 = arg_220_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_0 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["10154"]) then
				if arg_220_1.var_.actorSpriteComps10154 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								iter_223_1.color = Color.New(Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor2.r, (arg_220_1.time_ - 0) / var_223_0), Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor2.g, (arg_220_1.time_ - 0) / var_223_0), (Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor2.b, (arg_220_1.time_ - 0) / var_223_0)))
							else
								local var_223_1 = Mathf.Lerp(iter_223_1.color.r, 0.5, (arg_220_1.time_ - 0) / var_223_0)

								iter_223_1.color = Color.New(var_223_1, var_223_1, var_223_1)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["10154"]) and arg_220_1.var_.actorSpriteComps10154 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_223_3 then
						iter_223_3.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_220_1.var_.actorSpriteComps10154 = nil
			end

			local var_223_2 = 0
			local var_223_3 = 0.625

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_2 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_4 = arg_220_1:FormatText(arg_220_1:GetWordFromCfg(424081052).content)

				arg_220_1.text_.text = var_223_4

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_6 = 25 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_4) / 25)

				if (25 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_4) / 25)) > 0 and var_223_3 < var_223_6 then
					arg_220_1.talkMaxDuration = var_223_6

					if var_223_6 + var_223_2 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_6 + var_223_2
					end
				end

				arg_220_1.text_.text = var_223_4
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_3, arg_220_1.talkMaxDuration)

			if var_223_2 <= arg_220_1.time_ and arg_220_1.time_ < var_223_2 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_2) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_2 + var_223_7 and arg_220_1.time_ < var_223_2 + var_223_7 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play424081053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 424081053
		arg_224_1.duration_ = 9.73

		local var_224_0 = {
			zh = 7.3,
			ja = 9.733
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
				arg_224_0:Play424081054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["10154"]) and arg_224_1.var_.actorSpriteComps10154 == nil then
				arg_224_1.var_.actorSpriteComps10154 = arg_224_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_0 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["10154"]) then
				if arg_224_1.var_.actorSpriteComps10154 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								iter_227_1.color = Color.New(Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor1.r, (arg_224_1.time_ - 0) / var_227_0), Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor1.g, (arg_224_1.time_ - 0) / var_227_0), (Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor1.b, (arg_224_1.time_ - 0) / var_227_0)))
							else
								local var_227_1 = Mathf.Lerp(iter_227_1.color.r, 1, (arg_224_1.time_ - 0) / var_227_0)

								iter_227_1.color = Color.New(var_227_1, var_227_1, var_227_1)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["10154"]) and arg_224_1.var_.actorSpriteComps10154 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_227_3 then
						iter_227_3.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_224_1.var_.actorSpriteComps10154 = nil
			end

			local var_227_2 = 0
			local var_227_3 = 0.625

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_2 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_4 = arg_224_1:GetWordFromCfg(424081053)
				local var_227_5 = arg_224_1:FormatText(var_227_4.content)

				arg_224_1.text_.text = var_227_5

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_7 = 25 <= 0 and var_227_3 or var_227_3 * (utf8.len(var_227_5) / 25)

				if (25 <= 0 and var_227_3 or var_227_3 * (utf8.len(var_227_5) / 25)) > 0 and var_227_3 < var_227_7 then
					arg_224_1.talkMaxDuration = var_227_7

					if var_227_7 + var_227_2 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_2
					end
				end

				arg_224_1.text_.text = var_227_5
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081053", "story_v_out_424081.awb") ~= 0 then
					local var_227_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081053", "story_v_out_424081.awb") / 1000

					if var_227_8 + var_227_2 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_8 + var_227_2
					end

					if var_227_4.prefab_name ~= "" and arg_224_1.actors_[var_227_4.prefab_name] ~= nil then
						local var_227_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_4.prefab_name].transform, "story_v_out_424081", "424081053", "story_v_out_424081.awb")

						arg_224_1:RecordAudio("424081053", var_227_9)
						arg_224_1:RecordAudio("424081053", var_227_9)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_424081", "424081053", "story_v_out_424081.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_424081", "424081053", "story_v_out_424081.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_10 = math.max(var_227_3, arg_224_1.talkMaxDuration)

			if var_227_2 <= arg_224_1.time_ and arg_224_1.time_ < var_227_2 + var_227_10 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_2) / var_227_10

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_2 + var_227_10 and arg_224_1.time_ < var_227_2 + var_227_10 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play424081054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 424081054
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play424081055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["10154"]) and arg_228_1.var_.actorSpriteComps10154 == nil then
				arg_228_1.var_.actorSpriteComps10154 = arg_228_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_0 = 0.2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["10154"]) then
				if arg_228_1.var_.actorSpriteComps10154 then
					for iter_231_0, iter_231_1 in pairs(arg_228_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_231_1 then
							if arg_228_1.isInRecall_ then
								iter_231_1.color = Color.New(Mathf.Lerp(iter_231_1.color.r, arg_228_1.hightColor2.r, (arg_228_1.time_ - 0) / var_231_0), Mathf.Lerp(iter_231_1.color.g, arg_228_1.hightColor2.g, (arg_228_1.time_ - 0) / var_231_0), (Mathf.Lerp(iter_231_1.color.b, arg_228_1.hightColor2.b, (arg_228_1.time_ - 0) / var_231_0)))
							else
								local var_231_1 = Mathf.Lerp(iter_231_1.color.r, 0.5, (arg_228_1.time_ - 0) / var_231_0)

								iter_231_1.color = Color.New(var_231_1, var_231_1, var_231_1)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["10154"]) and arg_228_1.var_.actorSpriteComps10154 then
				for iter_231_2, iter_231_3 in pairs(arg_228_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_231_3 then
						iter_231_3.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_228_1.var_.actorSpriteComps10154 = nil
			end

			local var_231_2 = arg_228_1.actors_["10154"].transform

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos10154 = var_231_2.localPosition
				var_231_2.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10154", 7)

				for iter_231_4 = 0, var_231_2.childCount - 1 do
					local var_231_3 = var_231_2:GetChild(iter_231_4)

					if var_231_3.name == "" or not string.find(var_231_3.name, "split") then
						var_231_3.gameObject:SetActive(true)
					else
						var_231_3.gameObject:SetActive(false)
					end
				end
			end

			local var_231_4 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 then
				var_231_2.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_228_1.time_ - 0) / var_231_4)
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 then
				var_231_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_231_5 = 0
			local var_231_6 = 0.7

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_5 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_7 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(424081054).content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 28 <= 0 and var_231_6 or var_231_6 * (utf8.len(var_231_7) / 28)

				if (28 <= 0 and var_231_6 or var_231_6 * (utf8.len(var_231_7) / 28)) > 0 and var_231_6 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_5 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_5
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_10 = math.max(var_231_6, arg_228_1.talkMaxDuration)

			if var_231_5 <= arg_228_1.time_ and arg_228_1.time_ < var_231_5 + var_231_10 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_5) / var_231_10

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_5 + var_231_10 and arg_228_1.time_ < var_231_5 + var_231_10 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play424081055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 424081055
		arg_232_1.duration_ = 13.53

		local var_232_0 = {
			zh = 13.533,
			ja = 7.933
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
				arg_232_0:Play424081056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["10154"]) and arg_232_1.var_.actorSpriteComps10154 == nil then
				arg_232_1.var_.actorSpriteComps10154 = arg_232_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_0 = 0.2

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["10154"]) then
				if arg_232_1.var_.actorSpriteComps10154 then
					for iter_235_0, iter_235_1 in pairs(arg_232_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_235_1 then
							if arg_232_1.isInRecall_ then
								iter_235_1.color = Color.New(Mathf.Lerp(iter_235_1.color.r, arg_232_1.hightColor1.r, (arg_232_1.time_ - 0) / var_235_0), Mathf.Lerp(iter_235_1.color.g, arg_232_1.hightColor1.g, (arg_232_1.time_ - 0) / var_235_0), (Mathf.Lerp(iter_235_1.color.b, arg_232_1.hightColor1.b, (arg_232_1.time_ - 0) / var_235_0)))
							else
								local var_235_1 = Mathf.Lerp(iter_235_1.color.r, 1, (arg_232_1.time_ - 0) / var_235_0)

								iter_235_1.color = Color.New(var_235_1, var_235_1, var_235_1)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["10154"]) and arg_232_1.var_.actorSpriteComps10154 then
				for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_235_3 then
						iter_235_3.color = arg_232_1.isInRecall_ and (arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_232_1.var_.actorSpriteComps10154 = nil
			end

			local var_235_2 = arg_232_1.actors_["10154"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10154 = var_235_2.localPosition
				var_235_2.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10154", 3)

				for iter_235_4 = 0, var_235_2.childCount - 1 do
					local var_235_3 = var_235_2:GetChild(iter_235_4)

					if var_235_3.name == "split_4" or not string.find(var_235_3.name, "split") then
						var_235_3.gameObject:SetActive(true)
					else
						var_235_3.gameObject:SetActive(false)
					end
				end
			end

			local var_235_4 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				var_235_2.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_232_1.time_ - 0) / var_235_4)
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				var_235_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_235_5 = 0
			local var_235_6 = 0.95

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_7 = arg_232_1:GetWordFromCfg(424081055)
				local var_235_8 = arg_232_1:FormatText(var_235_7.content)

				arg_232_1.text_.text = var_235_8

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_10 = 38 <= 0 and var_235_6 or var_235_6 * (utf8.len(var_235_8) / 38)

				if (38 <= 0 and var_235_6 or var_235_6 * (utf8.len(var_235_8) / 38)) > 0 and var_235_6 < var_235_10 then
					arg_232_1.talkMaxDuration = var_235_10

					if var_235_10 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_10 + var_235_5
					end
				end

				arg_232_1.text_.text = var_235_8
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081055", "story_v_out_424081.awb") ~= 0 then
					local var_235_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081055", "story_v_out_424081.awb") / 1000

					if var_235_11 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_11 + var_235_5
					end

					if var_235_7.prefab_name ~= "" and arg_232_1.actors_[var_235_7.prefab_name] ~= nil then
						local var_235_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_7.prefab_name].transform, "story_v_out_424081", "424081055", "story_v_out_424081.awb")

						arg_232_1:RecordAudio("424081055", var_235_12)
						arg_232_1:RecordAudio("424081055", var_235_12)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_424081", "424081055", "story_v_out_424081.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_424081", "424081055", "story_v_out_424081.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_13 = math.max(var_235_6, arg_232_1.talkMaxDuration)

			if var_235_5 <= arg_232_1.time_ and arg_232_1.time_ < var_235_5 + var_235_13 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_5) / var_235_13

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_5 + var_235_13 and arg_232_1.time_ < var_235_5 + var_235_13 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play424081056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 424081056
		arg_236_1.duration_ = 13.3

		local var_236_0 = {
			zh = 11.9,
			ja = 13.3
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play424081057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos10154 = arg_236_1.actors_["10154"].transform.localPosition
				arg_236_1.actors_["10154"].transform.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("10154", 3)

				for iter_239_0 = 0, arg_236_1.actors_["10154"].transform.childCount - 1 do
					local var_239_0 = arg_236_1.actors_["10154"].transform:GetChild(iter_239_0)

					if var_239_0.name == "split_1" then
						var_239_0:SetAsLastSibling()
						var_239_0.gameObject:SetActive(true)

						arg_236_1.var_.actorSpriteSplit10154 = var_239_0.gameObject:GetComponent(typeof(Image))

						arg_236_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_239_1 = 0.5

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_1 then
				arg_236_1.actors_["10154"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_236_1.time_ - 0) / var_239_1)

				if arg_236_1.var_.actorSpriteSplit10154 ~= nil then
					arg_236_1.var_.actorSpriteSplit10154:SetAlpha((arg_236_1.time_ - 0) / var_239_1)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_1 and arg_236_1.time_ < 0 + var_239_1 + arg_239_0 then
				arg_236_1.actors_["10154"].transform.localPosition = Vector3.New(-20, -338, -538)

				if arg_236_1.var_.actorSpriteSplit10154 ~= nil then
					arg_236_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_239_2 = 0
			local var_239_3 = 1.15

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_2 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_4 = arg_236_1:GetWordFromCfg(424081056)
				local var_239_5 = arg_236_1:FormatText(var_239_4.content)

				arg_236_1.text_.text = var_239_5

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_7 = 46 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_5) / 46)

				if (46 <= 0 and var_239_3 or var_239_3 * (utf8.len(var_239_5) / 46)) > 0 and var_239_3 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_2 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_2
					end
				end

				arg_236_1.text_.text = var_239_5
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081056", "story_v_out_424081.awb") ~= 0 then
					local var_239_8 = manager.audio:GetVoiceLength("story_v_out_424081", "424081056", "story_v_out_424081.awb") / 1000

					if var_239_8 + var_239_2 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_2
					end

					if var_239_4.prefab_name ~= "" and arg_236_1.actors_[var_239_4.prefab_name] ~= nil then
						local var_239_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_4.prefab_name].transform, "story_v_out_424081", "424081056", "story_v_out_424081.awb")

						arg_236_1:RecordAudio("424081056", var_239_9)
						arg_236_1:RecordAudio("424081056", var_239_9)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_424081", "424081056", "story_v_out_424081.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_424081", "424081056", "story_v_out_424081.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_10 = math.max(var_239_3, arg_236_1.talkMaxDuration)

			if var_239_2 <= arg_236_1.time_ and arg_236_1.time_ < var_239_2 + var_239_10 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_2) / var_239_10

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_2 + var_239_10 and arg_236_1.time_ < var_239_2 + var_239_10 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play424081057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 424081057
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play424081058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["10154"]) and arg_240_1.var_.actorSpriteComps10154 == nil then
				arg_240_1.var_.actorSpriteComps10154 = arg_240_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_0 = 0.2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["10154"]) then
				if arg_240_1.var_.actorSpriteComps10154 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_243_1 then
							if arg_240_1.isInRecall_ then
								iter_243_1.color = Color.New(Mathf.Lerp(iter_243_1.color.r, arg_240_1.hightColor2.r, (arg_240_1.time_ - 0) / var_243_0), Mathf.Lerp(iter_243_1.color.g, arg_240_1.hightColor2.g, (arg_240_1.time_ - 0) / var_243_0), (Mathf.Lerp(iter_243_1.color.b, arg_240_1.hightColor2.b, (arg_240_1.time_ - 0) / var_243_0)))
							else
								local var_243_1 = Mathf.Lerp(iter_243_1.color.r, 0.5, (arg_240_1.time_ - 0) / var_243_0)

								iter_243_1.color = Color.New(var_243_1, var_243_1, var_243_1)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["10154"]) and arg_240_1.var_.actorSpriteComps10154 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_243_3 then
						iter_243_3.color = arg_240_1.isInRecall_ and (arg_240_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_240_1.var_.actorSpriteComps10154 = nil
			end

			local var_243_2 = 0
			local var_243_3 = 0.675

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_2 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_4 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(424081057).content)

				arg_240_1.text_.text = var_243_4

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_6 = 27 <= 0 and var_243_3 or var_243_3 * (utf8.len(var_243_4) / 27)

				if (27 <= 0 and var_243_3 or var_243_3 * (utf8.len(var_243_4) / 27)) > 0 and var_243_3 < var_243_6 then
					arg_240_1.talkMaxDuration = var_243_6

					if var_243_6 + var_243_2 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_2
					end
				end

				arg_240_1.text_.text = var_243_4
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_3, arg_240_1.talkMaxDuration)

			if var_243_2 <= arg_240_1.time_ and arg_240_1.time_ < var_243_2 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_2) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_2 + var_243_7 and arg_240_1.time_ < var_243_2 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play424081058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 424081058
		arg_244_1.duration_ = 7.27

		local var_244_0 = {
			zh = 6.733,
			ja = 7.266
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
				arg_244_0:Play424081059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["10154"]) and arg_244_1.var_.actorSpriteComps10154 == nil then
				arg_244_1.var_.actorSpriteComps10154 = arg_244_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_0 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["10154"]) then
				if arg_244_1.var_.actorSpriteComps10154 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_247_1 then
							if arg_244_1.isInRecall_ then
								iter_247_1.color = Color.New(Mathf.Lerp(iter_247_1.color.r, arg_244_1.hightColor1.r, (arg_244_1.time_ - 0) / var_247_0), Mathf.Lerp(iter_247_1.color.g, arg_244_1.hightColor1.g, (arg_244_1.time_ - 0) / var_247_0), (Mathf.Lerp(iter_247_1.color.b, arg_244_1.hightColor1.b, (arg_244_1.time_ - 0) / var_247_0)))
							else
								local var_247_1 = Mathf.Lerp(iter_247_1.color.r, 1, (arg_244_1.time_ - 0) / var_247_0)

								iter_247_1.color = Color.New(var_247_1, var_247_1, var_247_1)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["10154"]) and arg_244_1.var_.actorSpriteComps10154 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_247_3 then
						iter_247_3.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_244_1.var_.actorSpriteComps10154 = nil
			end

			local var_247_2 = arg_244_1.actors_["10154"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos10154 = var_247_2.localPosition
				var_247_2.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("10154", 3)

				for iter_247_4 = 0, var_247_2.childCount - 1 do
					local var_247_3 = var_247_2:GetChild(iter_247_4)

					if var_247_3.name == "" or not string.find(var_247_3.name, "split") then
						var_247_3.gameObject:SetActive(true)
					else
						var_247_3.gameObject:SetActive(false)
					end
				end
			end

			local var_247_4 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				var_247_2.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_244_1.time_ - 0) / var_247_4)
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				var_247_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_247_5 = 0
			local var_247_6 = 0.675

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_7 = arg_244_1:GetWordFromCfg(424081058)
				local var_247_8 = arg_244_1:FormatText(var_247_7.content)

				arg_244_1.text_.text = var_247_8

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_10 = 27 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_8) / 27)

				if (27 <= 0 and var_247_6 or var_247_6 * (utf8.len(var_247_8) / 27)) > 0 and var_247_6 < var_247_10 then
					arg_244_1.talkMaxDuration = var_247_10

					if var_247_10 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_10 + var_247_5
					end
				end

				arg_244_1.text_.text = var_247_8
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081058", "story_v_out_424081.awb") ~= 0 then
					local var_247_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081058", "story_v_out_424081.awb") / 1000

					if var_247_11 + var_247_5 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_11 + var_247_5
					end

					if var_247_7.prefab_name ~= "" and arg_244_1.actors_[var_247_7.prefab_name] ~= nil then
						local var_247_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_7.prefab_name].transform, "story_v_out_424081", "424081058", "story_v_out_424081.awb")

						arg_244_1:RecordAudio("424081058", var_247_12)
						arg_244_1:RecordAudio("424081058", var_247_12)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_424081", "424081058", "story_v_out_424081.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_424081", "424081058", "story_v_out_424081.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_13 = math.max(var_247_6, arg_244_1.talkMaxDuration)

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_13 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_5) / var_247_13

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_5 + var_247_13 and arg_244_1.time_ < var_247_5 + var_247_13 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play424081059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 424081059
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play424081060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["10154"]) and arg_248_1.var_.actorSpriteComps10154 == nil then
				arg_248_1.var_.actorSpriteComps10154 = arg_248_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_251_0 = 0.2

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["10154"]) then
				if arg_248_1.var_.actorSpriteComps10154 then
					for iter_251_0, iter_251_1 in pairs(arg_248_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_251_1 then
							if arg_248_1.isInRecall_ then
								iter_251_1.color = Color.New(Mathf.Lerp(iter_251_1.color.r, arg_248_1.hightColor2.r, (arg_248_1.time_ - 0) / var_251_0), Mathf.Lerp(iter_251_1.color.g, arg_248_1.hightColor2.g, (arg_248_1.time_ - 0) / var_251_0), (Mathf.Lerp(iter_251_1.color.b, arg_248_1.hightColor2.b, (arg_248_1.time_ - 0) / var_251_0)))
							else
								local var_251_1 = Mathf.Lerp(iter_251_1.color.r, 0.5, (arg_248_1.time_ - 0) / var_251_0)

								iter_251_1.color = Color.New(var_251_1, var_251_1, var_251_1)
							end
						end
					end
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["10154"]) and arg_248_1.var_.actorSpriteComps10154 then
				for iter_251_2, iter_251_3 in pairs(arg_248_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_251_3 then
						iter_251_3.color = arg_248_1.isInRecall_ and (arg_248_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_248_1.var_.actorSpriteComps10154 = nil
			end

			local var_251_2 = 0
			local var_251_3 = 0.85

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_2 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_4 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(424081059).content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_6 = 34 <= 0 and var_251_3 or var_251_3 * (utf8.len(var_251_4) / 34)

				if (34 <= 0 and var_251_3 or var_251_3 * (utf8.len(var_251_4) / 34)) > 0 and var_251_3 < var_251_6 then
					arg_248_1.talkMaxDuration = var_251_6

					if var_251_6 + var_251_2 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_6 + var_251_2
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_3, arg_248_1.talkMaxDuration)

			if var_251_2 <= arg_248_1.time_ and arg_248_1.time_ < var_251_2 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_2) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_2 + var_251_7 and arg_248_1.time_ < var_251_2 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play424081060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 424081060
		arg_252_1.duration_ = 9.33

		local var_252_0 = {
			zh = 9.333,
			ja = 7.133
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
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play424081061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["10154"]) and arg_252_1.var_.actorSpriteComps10154 == nil then
				arg_252_1.var_.actorSpriteComps10154 = arg_252_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_0 = 0.2

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["10154"]) then
				if arg_252_1.var_.actorSpriteComps10154 then
					for iter_255_0, iter_255_1 in pairs(arg_252_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_255_1 then
							if arg_252_1.isInRecall_ then
								iter_255_1.color = Color.New(Mathf.Lerp(iter_255_1.color.r, arg_252_1.hightColor1.r, (arg_252_1.time_ - 0) / var_255_0), Mathf.Lerp(iter_255_1.color.g, arg_252_1.hightColor1.g, (arg_252_1.time_ - 0) / var_255_0), (Mathf.Lerp(iter_255_1.color.b, arg_252_1.hightColor1.b, (arg_252_1.time_ - 0) / var_255_0)))
							else
								local var_255_1 = Mathf.Lerp(iter_255_1.color.r, 1, (arg_252_1.time_ - 0) / var_255_0)

								iter_255_1.color = Color.New(var_255_1, var_255_1, var_255_1)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["10154"]) and arg_252_1.var_.actorSpriteComps10154 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_255_3 then
						iter_255_3.color = arg_252_1.isInRecall_ and (arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_252_1.var_.actorSpriteComps10154 = nil
			end

			local var_255_2 = arg_252_1.actors_["10154"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10154 = var_255_2.localPosition
				var_255_2.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("10154", 3)

				for iter_255_4 = 0, var_255_2.childCount - 1 do
					local var_255_3 = var_255_2:GetChild(iter_255_4)

					if var_255_3.name == "" or not string.find(var_255_3.name, "split") then
						var_255_3.gameObject:SetActive(true)
					else
						var_255_3.gameObject:SetActive(false)
					end
				end
			end

			local var_255_4 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 then
				var_255_2.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_252_1.time_ - 0) / var_255_4)
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 then
				var_255_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_255_5 = 0
			local var_255_6 = 1.075

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_7 = arg_252_1:GetWordFromCfg(424081060)
				local var_255_8 = arg_252_1:FormatText(var_255_7.content)

				arg_252_1.text_.text = var_255_8

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_10 = 43 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_8) / 43)

				if (43 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_8) / 43)) > 0 and var_255_6 < var_255_10 then
					arg_252_1.talkMaxDuration = var_255_10

					if var_255_10 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_10 + var_255_5
					end
				end

				arg_252_1.text_.text = var_255_8
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081060", "story_v_out_424081.awb") ~= 0 then
					local var_255_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081060", "story_v_out_424081.awb") / 1000

					if var_255_11 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_5
					end

					if var_255_7.prefab_name ~= "" and arg_252_1.actors_[var_255_7.prefab_name] ~= nil then
						local var_255_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_7.prefab_name].transform, "story_v_out_424081", "424081060", "story_v_out_424081.awb")

						arg_252_1:RecordAudio("424081060", var_255_12)
						arg_252_1:RecordAudio("424081060", var_255_12)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_424081", "424081060", "story_v_out_424081.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_424081", "424081060", "story_v_out_424081.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_13 = math.max(var_255_6, arg_252_1.talkMaxDuration)

			if var_255_5 <= arg_252_1.time_ and arg_252_1.time_ < var_255_5 + var_255_13 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_5) / var_255_13

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_5 + var_255_13 and arg_252_1.time_ < var_255_5 + var_255_13 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play424081061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 424081061
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play424081062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["10154"]) and arg_256_1.var_.actorSpriteComps10154 == nil then
				arg_256_1.var_.actorSpriteComps10154 = arg_256_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_0 = 0.2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["10154"]) then
				if arg_256_1.var_.actorSpriteComps10154 then
					for iter_259_0, iter_259_1 in pairs(arg_256_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_259_1 then
							if arg_256_1.isInRecall_ then
								iter_259_1.color = Color.New(Mathf.Lerp(iter_259_1.color.r, arg_256_1.hightColor2.r, (arg_256_1.time_ - 0) / var_259_0), Mathf.Lerp(iter_259_1.color.g, arg_256_1.hightColor2.g, (arg_256_1.time_ - 0) / var_259_0), (Mathf.Lerp(iter_259_1.color.b, arg_256_1.hightColor2.b, (arg_256_1.time_ - 0) / var_259_0)))
							else
								local var_259_1 = Mathf.Lerp(iter_259_1.color.r, 0.5, (arg_256_1.time_ - 0) / var_259_0)

								iter_259_1.color = Color.New(var_259_1, var_259_1, var_259_1)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["10154"]) and arg_256_1.var_.actorSpriteComps10154 then
				for iter_259_2, iter_259_3 in pairs(arg_256_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_259_3 then
						iter_259_3.color = arg_256_1.isInRecall_ and (arg_256_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_256_1.var_.actorSpriteComps10154 = nil
			end

			local var_259_2 = 0
			local var_259_3 = 0.275

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_2 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_4 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(424081061).content)

				arg_256_1.text_.text = var_259_4

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_6 = 11 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_4) / 11)

				if (11 <= 0 and var_259_3 or var_259_3 * (utf8.len(var_259_4) / 11)) > 0 and var_259_3 < var_259_6 then
					arg_256_1.talkMaxDuration = var_259_6

					if var_259_6 + var_259_2 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_6 + var_259_2
					end
				end

				arg_256_1.text_.text = var_259_4
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_7 = math.max(var_259_3, arg_256_1.talkMaxDuration)

			if var_259_2 <= arg_256_1.time_ and arg_256_1.time_ < var_259_2 + var_259_7 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_2) / var_259_7

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_2 + var_259_7 and arg_256_1.time_ < var_259_2 + var_259_7 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play424081062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 424081062
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play424081063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos10154 = arg_260_1.actors_["10154"].transform.localPosition
				arg_260_1.actors_["10154"].transform.localScale = Vector3.New(1, 1, 1)

				arg_260_1:CheckSpriteTmpPos("10154", 7)

				for iter_263_0 = 0, arg_260_1.actors_["10154"].transform.childCount - 1 do
					local var_263_0 = arg_260_1.actors_["10154"].transform:GetChild(iter_263_0)

					if var_263_0.name == "" or not string.find(var_263_0.name, "split") then
						var_263_0.gameObject:SetActive(true)
					else
						var_263_0.gameObject:SetActive(false)
					end
				end
			end

			local var_263_1 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_1 then
				arg_260_1.actors_["10154"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_260_1.time_ - 0) / var_263_1)
			end

			if arg_260_1.time_ >= 0 + var_263_1 and arg_260_1.time_ < 0 + var_263_1 + arg_263_0 then
				arg_260_1.actors_["10154"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_263_2 = 0
			local var_263_3 = 0.85

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_2 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_4 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(424081062).content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_6 = 34 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_4) / 34)

				if (34 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_4) / 34)) > 0 and var_263_3 < var_263_6 then
					arg_260_1.talkMaxDuration = var_263_6

					if var_263_6 + var_263_2 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_6 + var_263_2
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_3, arg_260_1.talkMaxDuration)

			if var_263_2 <= arg_260_1.time_ and arg_260_1.time_ < var_263_2 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_2) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_2 + var_263_7 and arg_260_1.time_ < var_263_2 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play424081063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 424081063
		arg_264_1.duration_ = 1

		local var_264_0 = {
			zh = 1,
			ja = 0.999999999999
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play424081064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["10154"]) and arg_264_1.var_.actorSpriteComps10154 == nil then
				arg_264_1.var_.actorSpriteComps10154 = arg_264_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_0 = 0.2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["10154"]) then
				if arg_264_1.var_.actorSpriteComps10154 then
					for iter_267_0, iter_267_1 in pairs(arg_264_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_267_1 then
							if arg_264_1.isInRecall_ then
								iter_267_1.color = Color.New(Mathf.Lerp(iter_267_1.color.r, arg_264_1.hightColor1.r, (arg_264_1.time_ - 0) / var_267_0), Mathf.Lerp(iter_267_1.color.g, arg_264_1.hightColor1.g, (arg_264_1.time_ - 0) / var_267_0), (Mathf.Lerp(iter_267_1.color.b, arg_264_1.hightColor1.b, (arg_264_1.time_ - 0) / var_267_0)))
							else
								local var_267_1 = Mathf.Lerp(iter_267_1.color.r, 1, (arg_264_1.time_ - 0) / var_267_0)

								iter_267_1.color = Color.New(var_267_1, var_267_1, var_267_1)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["10154"]) and arg_264_1.var_.actorSpriteComps10154 then
				for iter_267_2, iter_267_3 in pairs(arg_264_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_267_3 then
						iter_267_3.color = arg_264_1.isInRecall_ and (arg_264_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_264_1.var_.actorSpriteComps10154 = nil
			end

			local var_267_2 = arg_264_1.actors_["10154"].transform

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos10154 = var_267_2.localPosition
				var_267_2.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("10154", 3)

				for iter_267_4 = 0, var_267_2.childCount - 1 do
					local var_267_3 = var_267_2:GetChild(iter_267_4)

					if var_267_3.name == "split_5" then
						var_267_3:SetAsLastSibling()
						var_267_3.gameObject:SetActive(true)

						arg_264_1.var_.actorSpriteSplit10154 = var_267_3.gameObject:GetComponent(typeof(Image))

						arg_264_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_267_4 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 then
				var_267_2.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_264_1.time_ - 0) / var_267_4)

				if arg_264_1.var_.actorSpriteSplit10154 ~= nil then
					arg_264_1.var_.actorSpriteSplit10154:SetAlpha((arg_264_1.time_ - 0) / var_267_4)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 then
				var_267_2.localPosition = Vector3.New(-20, -338, -538)

				if arg_264_1.var_.actorSpriteSplit10154 ~= nil then
					arg_264_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_267_5 = 0
			local var_267_6 = 0.075

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_5 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_7 = arg_264_1:GetWordFromCfg(424081063)
				local var_267_8 = arg_264_1:FormatText(var_267_7.content)

				arg_264_1.text_.text = var_267_8

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_10 = 3 <= 0 and var_267_6 or var_267_6 * (utf8.len(var_267_8) / 3)

				if (3 <= 0 and var_267_6 or var_267_6 * (utf8.len(var_267_8) / 3)) > 0 and var_267_6 < var_267_10 then
					arg_264_1.talkMaxDuration = var_267_10

					if var_267_10 + var_267_5 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_10 + var_267_5
					end
				end

				arg_264_1.text_.text = var_267_8
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081063", "story_v_out_424081.awb") ~= 0 then
					local var_267_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081063", "story_v_out_424081.awb") / 1000

					if var_267_11 + var_267_5 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_11 + var_267_5
					end

					if var_267_7.prefab_name ~= "" and arg_264_1.actors_[var_267_7.prefab_name] ~= nil then
						local var_267_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_7.prefab_name].transform, "story_v_out_424081", "424081063", "story_v_out_424081.awb")

						arg_264_1:RecordAudio("424081063", var_267_12)
						arg_264_1:RecordAudio("424081063", var_267_12)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_424081", "424081063", "story_v_out_424081.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_424081", "424081063", "story_v_out_424081.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_13 = math.max(var_267_6, arg_264_1.talkMaxDuration)

			if var_267_5 <= arg_264_1.time_ and arg_264_1.time_ < var_267_5 + var_267_13 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_5) / var_267_13

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_5 + var_267_13 and arg_264_1.time_ < var_267_5 + var_267_13 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play424081064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 424081064
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play424081065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["10154"]) and arg_268_1.var_.actorSpriteComps10154 == nil then
				arg_268_1.var_.actorSpriteComps10154 = arg_268_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_0 = 0.2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["10154"]) then
				if arg_268_1.var_.actorSpriteComps10154 then
					for iter_271_0, iter_271_1 in pairs(arg_268_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_271_1 then
							if arg_268_1.isInRecall_ then
								iter_271_1.color = Color.New(Mathf.Lerp(iter_271_1.color.r, arg_268_1.hightColor2.r, (arg_268_1.time_ - 0) / var_271_0), Mathf.Lerp(iter_271_1.color.g, arg_268_1.hightColor2.g, (arg_268_1.time_ - 0) / var_271_0), (Mathf.Lerp(iter_271_1.color.b, arg_268_1.hightColor2.b, (arg_268_1.time_ - 0) / var_271_0)))
							else
								local var_271_1 = Mathf.Lerp(iter_271_1.color.r, 0.5, (arg_268_1.time_ - 0) / var_271_0)

								iter_271_1.color = Color.New(var_271_1, var_271_1, var_271_1)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["10154"]) and arg_268_1.var_.actorSpriteComps10154 then
				for iter_271_2, iter_271_3 in pairs(arg_268_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_271_3 then
						iter_271_3.color = arg_268_1.isInRecall_ and (arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_268_1.var_.actorSpriteComps10154 = nil
			end

			local var_271_2 = 0
			local var_271_3 = 1.65

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_2 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_4 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(424081064).content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_6 = 66 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_4) / 66)

				if (66 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_4) / 66)) > 0 and var_271_3 < var_271_6 then
					arg_268_1.talkMaxDuration = var_271_6

					if var_271_6 + var_271_2 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_6 + var_271_2
					end
				end

				arg_268_1.text_.text = var_271_4
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_3, arg_268_1.talkMaxDuration)

			if var_271_2 <= arg_268_1.time_ and arg_268_1.time_ < var_271_2 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_2) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_2 + var_271_7 and arg_268_1.time_ < var_271_2 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play424081065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 424081065
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play424081066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.55

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_1 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(424081065).content)

				arg_272_1.text_.text = var_275_1

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_3 = 22 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 22)

				if (22 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 22)) > 0 and var_275_0 < var_275_3 then
					arg_272_1.talkMaxDuration = var_275_3

					if var_275_3 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_3 + 0
					end
				end

				arg_272_1.text_.text = var_275_1
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_4 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_4 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_4

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_4 and arg_272_1.time_ < 0 + var_275_4 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play424081066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 424081066
		arg_276_1.duration_ = 2.9

		local var_276_0 = {
			zh = 2.333,
			ja = 2.9
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play424081067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["10154"]) and arg_276_1.var_.actorSpriteComps10154 == nil then
				arg_276_1.var_.actorSpriteComps10154 = arg_276_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_0 = 0.2

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["10154"]) then
				if arg_276_1.var_.actorSpriteComps10154 then
					for iter_279_0, iter_279_1 in pairs(arg_276_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_279_1 then
							if arg_276_1.isInRecall_ then
								iter_279_1.color = Color.New(Mathf.Lerp(iter_279_1.color.r, arg_276_1.hightColor1.r, (arg_276_1.time_ - 0) / var_279_0), Mathf.Lerp(iter_279_1.color.g, arg_276_1.hightColor1.g, (arg_276_1.time_ - 0) / var_279_0), (Mathf.Lerp(iter_279_1.color.b, arg_276_1.hightColor1.b, (arg_276_1.time_ - 0) / var_279_0)))
							else
								local var_279_1 = Mathf.Lerp(iter_279_1.color.r, 1, (arg_276_1.time_ - 0) / var_279_0)

								iter_279_1.color = Color.New(var_279_1, var_279_1, var_279_1)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["10154"]) and arg_276_1.var_.actorSpriteComps10154 then
				for iter_279_2, iter_279_3 in pairs(arg_276_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_279_3 then
						iter_279_3.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_276_1.var_.actorSpriteComps10154 = nil
			end

			local var_279_2 = arg_276_1.actors_["10154"].transform

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos10154 = var_279_2.localPosition
				var_279_2.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("10154", 3)

				for iter_279_4 = 0, var_279_2.childCount - 1 do
					local var_279_3 = var_279_2:GetChild(iter_279_4)

					if var_279_3.name == "split_1" then
						var_279_3:SetAsLastSibling()
						var_279_3.gameObject:SetActive(true)

						arg_276_1.var_.actorSpriteSplit10154 = var_279_3.gameObject:GetComponent(typeof(Image))

						arg_276_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_279_4 = 0.5

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_4 then
				var_279_2.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_276_1.time_ - 0) / var_279_4)

				if arg_276_1.var_.actorSpriteSplit10154 ~= nil then
					arg_276_1.var_.actorSpriteSplit10154:SetAlpha((arg_276_1.time_ - 0) / var_279_4)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_4 and arg_276_1.time_ < 0 + var_279_4 + arg_279_0 then
				var_279_2.localPosition = Vector3.New(-20, -338, -538)

				if arg_276_1.var_.actorSpriteSplit10154 ~= nil then
					arg_276_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_279_5 = 0
			local var_279_6 = 0.3

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_5 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_7 = arg_276_1:GetWordFromCfg(424081066)
				local var_279_8 = arg_276_1:FormatText(var_279_7.content)

				arg_276_1.text_.text = var_279_8

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_10 = 12 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_8) / 12)

				if (12 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_8) / 12)) > 0 and var_279_6 < var_279_10 then
					arg_276_1.talkMaxDuration = var_279_10

					if var_279_10 + var_279_5 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_10 + var_279_5
					end
				end

				arg_276_1.text_.text = var_279_8
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081066", "story_v_out_424081.awb") ~= 0 then
					local var_279_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081066", "story_v_out_424081.awb") / 1000

					if var_279_11 + var_279_5 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_11 + var_279_5
					end

					if var_279_7.prefab_name ~= "" and arg_276_1.actors_[var_279_7.prefab_name] ~= nil then
						local var_279_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_7.prefab_name].transform, "story_v_out_424081", "424081066", "story_v_out_424081.awb")

						arg_276_1:RecordAudio("424081066", var_279_12)
						arg_276_1:RecordAudio("424081066", var_279_12)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_424081", "424081066", "story_v_out_424081.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_424081", "424081066", "story_v_out_424081.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_13 = math.max(var_279_6, arg_276_1.talkMaxDuration)

			if var_279_5 <= arg_276_1.time_ and arg_276_1.time_ < var_279_5 + var_279_13 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_5) / var_279_13

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_5 + var_279_13 and arg_276_1.time_ < var_279_5 + var_279_13 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play424081067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 424081067
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play424081068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["10154"]) and arg_280_1.var_.actorSpriteComps10154 == nil then
				arg_280_1.var_.actorSpriteComps10154 = arg_280_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_0 = 0.2

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["10154"]) then
				if arg_280_1.var_.actorSpriteComps10154 then
					for iter_283_0, iter_283_1 in pairs(arg_280_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_283_1 then
							if arg_280_1.isInRecall_ then
								iter_283_1.color = Color.New(Mathf.Lerp(iter_283_1.color.r, arg_280_1.hightColor2.r, (arg_280_1.time_ - 0) / var_283_0), Mathf.Lerp(iter_283_1.color.g, arg_280_1.hightColor2.g, (arg_280_1.time_ - 0) / var_283_0), (Mathf.Lerp(iter_283_1.color.b, arg_280_1.hightColor2.b, (arg_280_1.time_ - 0) / var_283_0)))
							else
								local var_283_1 = Mathf.Lerp(iter_283_1.color.r, 0.5, (arg_280_1.time_ - 0) / var_283_0)

								iter_283_1.color = Color.New(var_283_1, var_283_1, var_283_1)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["10154"]) and arg_280_1.var_.actorSpriteComps10154 then
				for iter_283_2, iter_283_3 in pairs(arg_280_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_283_3 then
						iter_283_3.color = arg_280_1.isInRecall_ and (arg_280_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_280_1.var_.actorSpriteComps10154 = nil
			end

			local var_283_2 = 0
			local var_283_3 = 1.2

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_2 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_4 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(424081067).content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_6 = 48 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_4) / 48)

				if (48 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_4) / 48)) > 0 and var_283_3 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6

					if var_283_6 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_2
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_7 = math.max(var_283_3, arg_280_1.talkMaxDuration)

			if var_283_2 <= arg_280_1.time_ and arg_280_1.time_ < var_283_2 + var_283_7 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_2) / var_283_7

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_2 + var_283_7 and arg_280_1.time_ < var_283_2 + var_283_7 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play424081068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 424081068
		arg_284_1.duration_ = 5.3

		local var_284_0 = {
			zh = 3.733,
			ja = 5.3
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play424081069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["10154"]) and arg_284_1.var_.actorSpriteComps10154 == nil then
				arg_284_1.var_.actorSpriteComps10154 = arg_284_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_0 = 0.2

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["10154"]) then
				if arg_284_1.var_.actorSpriteComps10154 then
					for iter_287_0, iter_287_1 in pairs(arg_284_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_287_1 then
							if arg_284_1.isInRecall_ then
								iter_287_1.color = Color.New(Mathf.Lerp(iter_287_1.color.r, arg_284_1.hightColor1.r, (arg_284_1.time_ - 0) / var_287_0), Mathf.Lerp(iter_287_1.color.g, arg_284_1.hightColor1.g, (arg_284_1.time_ - 0) / var_287_0), (Mathf.Lerp(iter_287_1.color.b, arg_284_1.hightColor1.b, (arg_284_1.time_ - 0) / var_287_0)))
							else
								local var_287_1 = Mathf.Lerp(iter_287_1.color.r, 1, (arg_284_1.time_ - 0) / var_287_0)

								iter_287_1.color = Color.New(var_287_1, var_287_1, var_287_1)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["10154"]) and arg_284_1.var_.actorSpriteComps10154 then
				for iter_287_2, iter_287_3 in pairs(arg_284_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_287_3 then
						iter_287_3.color = arg_284_1.isInRecall_ and (arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_284_1.var_.actorSpriteComps10154 = nil
			end

			local var_287_2 = arg_284_1.actors_["10154"].transform

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos10154 = var_287_2.localPosition
				var_287_2.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("10154", 3)

				for iter_287_4 = 0, var_287_2.childCount - 1 do
					local var_287_3 = var_287_2:GetChild(iter_287_4)

					if var_287_3.name == "" or not string.find(var_287_3.name, "split") then
						var_287_3.gameObject:SetActive(true)
					else
						var_287_3.gameObject:SetActive(false)
					end
				end
			end

			local var_287_4 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 then
				var_287_2.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_284_1.time_ - 0) / var_287_4)
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 then
				var_287_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_287_5 = 0
			local var_287_6 = 0.5

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_7 = arg_284_1:GetWordFromCfg(424081068)
				local var_287_8 = arg_284_1:FormatText(var_287_7.content)

				arg_284_1.text_.text = var_287_8

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_10 = 20 <= 0 and var_287_6 or var_287_6 * (utf8.len(var_287_8) / 20)

				if (20 <= 0 and var_287_6 or var_287_6 * (utf8.len(var_287_8) / 20)) > 0 and var_287_6 < var_287_10 then
					arg_284_1.talkMaxDuration = var_287_10

					if var_287_10 + var_287_5 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_10 + var_287_5
					end
				end

				arg_284_1.text_.text = var_287_8
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081068", "story_v_out_424081.awb") ~= 0 then
					local var_287_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081068", "story_v_out_424081.awb") / 1000

					if var_287_11 + var_287_5 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_11 + var_287_5
					end

					if var_287_7.prefab_name ~= "" and arg_284_1.actors_[var_287_7.prefab_name] ~= nil then
						local var_287_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_7.prefab_name].transform, "story_v_out_424081", "424081068", "story_v_out_424081.awb")

						arg_284_1:RecordAudio("424081068", var_287_12)
						arg_284_1:RecordAudio("424081068", var_287_12)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_424081", "424081068", "story_v_out_424081.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_424081", "424081068", "story_v_out_424081.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_13 = math.max(var_287_6, arg_284_1.talkMaxDuration)

			if var_287_5 <= arg_284_1.time_ and arg_284_1.time_ < var_287_5 + var_287_13 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_5) / var_287_13

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_5 + var_287_13 and arg_284_1.time_ < var_287_5 + var_287_13 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play424081069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 424081069
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play424081070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["10154"]) and arg_288_1.var_.actorSpriteComps10154 == nil then
				arg_288_1.var_.actorSpriteComps10154 = arg_288_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_0 = 0.2

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["10154"]) then
				if arg_288_1.var_.actorSpriteComps10154 then
					for iter_291_0, iter_291_1 in pairs(arg_288_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_291_1 then
							if arg_288_1.isInRecall_ then
								iter_291_1.color = Color.New(Mathf.Lerp(iter_291_1.color.r, arg_288_1.hightColor2.r, (arg_288_1.time_ - 0) / var_291_0), Mathf.Lerp(iter_291_1.color.g, arg_288_1.hightColor2.g, (arg_288_1.time_ - 0) / var_291_0), (Mathf.Lerp(iter_291_1.color.b, arg_288_1.hightColor2.b, (arg_288_1.time_ - 0) / var_291_0)))
							else
								local var_291_1 = Mathf.Lerp(iter_291_1.color.r, 0.5, (arg_288_1.time_ - 0) / var_291_0)

								iter_291_1.color = Color.New(var_291_1, var_291_1, var_291_1)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["10154"]) and arg_288_1.var_.actorSpriteComps10154 then
				for iter_291_2, iter_291_3 in pairs(arg_288_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_291_3 then
						iter_291_3.color = arg_288_1.isInRecall_ and (arg_288_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_288_1.var_.actorSpriteComps10154 = nil
			end

			local var_291_2 = 0
			local var_291_3 = 0.25

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_2 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_4 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(424081069).content)

				arg_288_1.text_.text = var_291_4

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_6 = 10 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_4) / 10)

				if (10 <= 0 and var_291_3 or var_291_3 * (utf8.len(var_291_4) / 10)) > 0 and var_291_3 < var_291_6 then
					arg_288_1.talkMaxDuration = var_291_6

					if var_291_6 + var_291_2 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_6 + var_291_2
					end
				end

				arg_288_1.text_.text = var_291_4
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_3, arg_288_1.talkMaxDuration)

			if var_291_2 <= arg_288_1.time_ and arg_288_1.time_ < var_291_2 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_2) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_2 + var_291_7 and arg_288_1.time_ < var_291_2 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play424081070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 424081070
		arg_292_1.duration_ = 2.37

		local var_292_0 = {
			zh = 2.366,
			ja = 1.4
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play424081071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["10154"]) and arg_292_1.var_.actorSpriteComps10154 == nil then
				arg_292_1.var_.actorSpriteComps10154 = arg_292_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_0 = 0.2

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["10154"]) then
				if arg_292_1.var_.actorSpriteComps10154 then
					for iter_295_0, iter_295_1 in pairs(arg_292_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_295_1 then
							if arg_292_1.isInRecall_ then
								iter_295_1.color = Color.New(Mathf.Lerp(iter_295_1.color.r, arg_292_1.hightColor1.r, (arg_292_1.time_ - 0) / var_295_0), Mathf.Lerp(iter_295_1.color.g, arg_292_1.hightColor1.g, (arg_292_1.time_ - 0) / var_295_0), (Mathf.Lerp(iter_295_1.color.b, arg_292_1.hightColor1.b, (arg_292_1.time_ - 0) / var_295_0)))
							else
								local var_295_1 = Mathf.Lerp(iter_295_1.color.r, 1, (arg_292_1.time_ - 0) / var_295_0)

								iter_295_1.color = Color.New(var_295_1, var_295_1, var_295_1)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["10154"]) and arg_292_1.var_.actorSpriteComps10154 then
				for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_295_3 then
						iter_295_3.color = arg_292_1.isInRecall_ and (arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_292_1.var_.actorSpriteComps10154 = nil
			end

			local var_295_2 = arg_292_1.actors_["10154"].transform

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos10154 = var_295_2.localPosition
				var_295_2.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("10154", 3)

				for iter_295_4 = 0, var_295_2.childCount - 1 do
					local var_295_3 = var_295_2:GetChild(iter_295_4)

					if var_295_3.name == "split_2" then
						var_295_3:SetAsLastSibling()
						var_295_3.gameObject:SetActive(true)

						arg_292_1.var_.actorSpriteSplit10154 = var_295_3.gameObject:GetComponent(typeof(Image))

						arg_292_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_295_4 = 0.5

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				var_295_2.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_292_1.time_ - 0) / var_295_4)

				if arg_292_1.var_.actorSpriteSplit10154 ~= nil then
					arg_292_1.var_.actorSpriteSplit10154:SetAlpha((arg_292_1.time_ - 0) / var_295_4)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				var_295_2.localPosition = Vector3.New(-20, -338, -538)

				if arg_292_1.var_.actorSpriteSplit10154 ~= nil then
					arg_292_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_295_5 = 0
			local var_295_6 = 0.25

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_5 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_7 = arg_292_1:GetWordFromCfg(424081070)
				local var_295_8 = arg_292_1:FormatText(var_295_7.content)

				arg_292_1.text_.text = var_295_8

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_10 = 10 <= 0 and var_295_6 or var_295_6 * (utf8.len(var_295_8) / 10)

				if (10 <= 0 and var_295_6 or var_295_6 * (utf8.len(var_295_8) / 10)) > 0 and var_295_6 < var_295_10 then
					arg_292_1.talkMaxDuration = var_295_10

					if var_295_10 + var_295_5 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_10 + var_295_5
					end
				end

				arg_292_1.text_.text = var_295_8
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081070", "story_v_out_424081.awb") ~= 0 then
					local var_295_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081070", "story_v_out_424081.awb") / 1000

					if var_295_11 + var_295_5 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_11 + var_295_5
					end

					if var_295_7.prefab_name ~= "" and arg_292_1.actors_[var_295_7.prefab_name] ~= nil then
						local var_295_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_7.prefab_name].transform, "story_v_out_424081", "424081070", "story_v_out_424081.awb")

						arg_292_1:RecordAudio("424081070", var_295_12)
						arg_292_1:RecordAudio("424081070", var_295_12)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_424081", "424081070", "story_v_out_424081.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_424081", "424081070", "story_v_out_424081.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_13 = math.max(var_295_6, arg_292_1.talkMaxDuration)

			if var_295_5 <= arg_292_1.time_ and arg_292_1.time_ < var_295_5 + var_295_13 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_5) / var_295_13

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_5 + var_295_13 and arg_292_1.time_ < var_295_5 + var_295_13 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play424081071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 424081071
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play424081072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["10154"]) and arg_296_1.var_.actorSpriteComps10154 == nil then
				arg_296_1.var_.actorSpriteComps10154 = arg_296_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_0 = 0.2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["10154"]) then
				if arg_296_1.var_.actorSpriteComps10154 then
					for iter_299_0, iter_299_1 in pairs(arg_296_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_299_1 then
							if arg_296_1.isInRecall_ then
								iter_299_1.color = Color.New(Mathf.Lerp(iter_299_1.color.r, arg_296_1.hightColor2.r, (arg_296_1.time_ - 0) / var_299_0), Mathf.Lerp(iter_299_1.color.g, arg_296_1.hightColor2.g, (arg_296_1.time_ - 0) / var_299_0), (Mathf.Lerp(iter_299_1.color.b, arg_296_1.hightColor2.b, (arg_296_1.time_ - 0) / var_299_0)))
							else
								local var_299_1 = Mathf.Lerp(iter_299_1.color.r, 0.5, (arg_296_1.time_ - 0) / var_299_0)

								iter_299_1.color = Color.New(var_299_1, var_299_1, var_299_1)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["10154"]) and arg_296_1.var_.actorSpriteComps10154 then
				for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_299_3 then
						iter_299_3.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_296_1.var_.actorSpriteComps10154 = nil
			end

			local var_299_2 = 0
			local var_299_3 = 1

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_2 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_4 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(424081071).content)

				arg_296_1.text_.text = var_299_4

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_6 = 40 <= 0 and var_299_3 or var_299_3 * (utf8.len(var_299_4) / 40)

				if (40 <= 0 and var_299_3 or var_299_3 * (utf8.len(var_299_4) / 40)) > 0 and var_299_3 < var_299_6 then
					arg_296_1.talkMaxDuration = var_299_6

					if var_299_6 + var_299_2 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_6 + var_299_2
					end
				end

				arg_296_1.text_.text = var_299_4
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_7 = math.max(var_299_3, arg_296_1.talkMaxDuration)

			if var_299_2 <= arg_296_1.time_ and arg_296_1.time_ < var_299_2 + var_299_7 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_2) / var_299_7

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_2 + var_299_7 and arg_296_1.time_ < var_299_2 + var_299_7 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play424081072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 424081072
		arg_300_1.duration_ = 3.47

		local var_300_0 = {
			zh = 3.466,
			ja = 1.8
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play424081073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["10154"]) and arg_300_1.var_.actorSpriteComps10154 == nil then
				arg_300_1.var_.actorSpriteComps10154 = arg_300_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_0 = 0.2

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["10154"]) then
				if arg_300_1.var_.actorSpriteComps10154 then
					for iter_303_0, iter_303_1 in pairs(arg_300_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_303_1 then
							if arg_300_1.isInRecall_ then
								iter_303_1.color = Color.New(Mathf.Lerp(iter_303_1.color.r, arg_300_1.hightColor1.r, (arg_300_1.time_ - 0) / var_303_0), Mathf.Lerp(iter_303_1.color.g, arg_300_1.hightColor1.g, (arg_300_1.time_ - 0) / var_303_0), (Mathf.Lerp(iter_303_1.color.b, arg_300_1.hightColor1.b, (arg_300_1.time_ - 0) / var_303_0)))
							else
								local var_303_1 = Mathf.Lerp(iter_303_1.color.r, 1, (arg_300_1.time_ - 0) / var_303_0)

								iter_303_1.color = Color.New(var_303_1, var_303_1, var_303_1)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["10154"]) and arg_300_1.var_.actorSpriteComps10154 then
				for iter_303_2, iter_303_3 in pairs(arg_300_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_303_3 then
						iter_303_3.color = arg_300_1.isInRecall_ and (arg_300_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_300_1.var_.actorSpriteComps10154 = nil
			end

			local var_303_2 = arg_300_1.actors_["10154"].transform

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos10154 = var_303_2.localPosition
				var_303_2.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("10154", 3)

				for iter_303_4 = 0, var_303_2.childCount - 1 do
					local var_303_3 = var_303_2:GetChild(iter_303_4)

					if var_303_3.name == "split_1" then
						var_303_3:SetAsLastSibling()
						var_303_3.gameObject:SetActive(true)

						arg_300_1.var_.actorSpriteSplit10154 = var_303_3.gameObject:GetComponent(typeof(Image))

						arg_300_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_303_4 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 then
				var_303_2.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_300_1.time_ - 0) / var_303_4)

				if arg_300_1.var_.actorSpriteSplit10154 ~= nil then
					arg_300_1.var_.actorSpriteSplit10154:SetAlpha((arg_300_1.time_ - 0) / var_303_4)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 then
				var_303_2.localPosition = Vector3.New(-20, -338, -538)

				if arg_300_1.var_.actorSpriteSplit10154 ~= nil then
					arg_300_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_303_5 = 0
			local var_303_6 = 0.35

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_5 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_7 = arg_300_1:GetWordFromCfg(424081072)
				local var_303_8 = arg_300_1:FormatText(var_303_7.content)

				arg_300_1.text_.text = var_303_8

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_10 = 14 <= 0 and var_303_6 or var_303_6 * (utf8.len(var_303_8) / 14)

				if (14 <= 0 and var_303_6 or var_303_6 * (utf8.len(var_303_8) / 14)) > 0 and var_303_6 < var_303_10 then
					arg_300_1.talkMaxDuration = var_303_10

					if var_303_10 + var_303_5 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_10 + var_303_5
					end
				end

				arg_300_1.text_.text = var_303_8
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081072", "story_v_out_424081.awb") ~= 0 then
					local var_303_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081072", "story_v_out_424081.awb") / 1000

					if var_303_11 + var_303_5 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_11 + var_303_5
					end

					if var_303_7.prefab_name ~= "" and arg_300_1.actors_[var_303_7.prefab_name] ~= nil then
						local var_303_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_7.prefab_name].transform, "story_v_out_424081", "424081072", "story_v_out_424081.awb")

						arg_300_1:RecordAudio("424081072", var_303_12)
						arg_300_1:RecordAudio("424081072", var_303_12)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_424081", "424081072", "story_v_out_424081.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_424081", "424081072", "story_v_out_424081.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_13 = math.max(var_303_6, arg_300_1.talkMaxDuration)

			if var_303_5 <= arg_300_1.time_ and arg_300_1.time_ < var_303_5 + var_303_13 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_5) / var_303_13

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_5 + var_303_13 and arg_300_1.time_ < var_303_5 + var_303_13 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play424081073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 424081073
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play424081074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["10154"]) and arg_304_1.var_.actorSpriteComps10154 == nil then
				arg_304_1.var_.actorSpriteComps10154 = arg_304_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_0 = 0.2

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["10154"]) then
				if arg_304_1.var_.actorSpriteComps10154 then
					for iter_307_0, iter_307_1 in pairs(arg_304_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_307_1 then
							if arg_304_1.isInRecall_ then
								iter_307_1.color = Color.New(Mathf.Lerp(iter_307_1.color.r, arg_304_1.hightColor2.r, (arg_304_1.time_ - 0) / var_307_0), Mathf.Lerp(iter_307_1.color.g, arg_304_1.hightColor2.g, (arg_304_1.time_ - 0) / var_307_0), (Mathf.Lerp(iter_307_1.color.b, arg_304_1.hightColor2.b, (arg_304_1.time_ - 0) / var_307_0)))
							else
								local var_307_1 = Mathf.Lerp(iter_307_1.color.r, 0.5, (arg_304_1.time_ - 0) / var_307_0)

								iter_307_1.color = Color.New(var_307_1, var_307_1, var_307_1)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["10154"]) and arg_304_1.var_.actorSpriteComps10154 then
				for iter_307_2, iter_307_3 in pairs(arg_304_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_307_3 then
						iter_307_3.color = arg_304_1.isInRecall_ and (arg_304_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_304_1.var_.actorSpriteComps10154 = nil
			end

			local var_307_2 = 0
			local var_307_3 = 1.3

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_2 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_4 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(424081073).content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_6 = 52 <= 0 and var_307_3 or var_307_3 * (utf8.len(var_307_4) / 52)

				if (52 <= 0 and var_307_3 or var_307_3 * (utf8.len(var_307_4) / 52)) > 0 and var_307_3 < var_307_6 then
					arg_304_1.talkMaxDuration = var_307_6

					if var_307_6 + var_307_2 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_6 + var_307_2
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_3, arg_304_1.talkMaxDuration)

			if var_307_2 <= arg_304_1.time_ and arg_304_1.time_ < var_307_2 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_2) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_2 + var_307_7 and arg_304_1.time_ < var_307_2 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play424081074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 424081074
		arg_308_1.duration_ = 8.93

		local var_308_0 = {
			zh = 8.933,
			ja = 7
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play424081075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["10154"]) and arg_308_1.var_.actorSpriteComps10154 == nil then
				arg_308_1.var_.actorSpriteComps10154 = arg_308_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_0 = 0.2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["10154"]) then
				if arg_308_1.var_.actorSpriteComps10154 then
					for iter_311_0, iter_311_1 in pairs(arg_308_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_311_1 then
							if arg_308_1.isInRecall_ then
								iter_311_1.color = Color.New(Mathf.Lerp(iter_311_1.color.r, arg_308_1.hightColor1.r, (arg_308_1.time_ - 0) / var_311_0), Mathf.Lerp(iter_311_1.color.g, arg_308_1.hightColor1.g, (arg_308_1.time_ - 0) / var_311_0), (Mathf.Lerp(iter_311_1.color.b, arg_308_1.hightColor1.b, (arg_308_1.time_ - 0) / var_311_0)))
							else
								local var_311_1 = Mathf.Lerp(iter_311_1.color.r, 1, (arg_308_1.time_ - 0) / var_311_0)

								iter_311_1.color = Color.New(var_311_1, var_311_1, var_311_1)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["10154"]) and arg_308_1.var_.actorSpriteComps10154 then
				for iter_311_2, iter_311_3 in pairs(arg_308_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_311_3 then
						iter_311_3.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_308_1.var_.actorSpriteComps10154 = nil
			end

			local var_311_2 = arg_308_1.actors_["10154"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos10154 = var_311_2.localPosition
				var_311_2.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("10154", 3)

				for iter_311_4 = 0, var_311_2.childCount - 1 do
					local var_311_3 = var_311_2:GetChild(iter_311_4)

					if var_311_3.name == "split_5" then
						var_311_3:SetAsLastSibling()
						var_311_3.gameObject:SetActive(true)

						arg_308_1.var_.actorSpriteSplit10154 = var_311_3.gameObject:GetComponent(typeof(Image))

						arg_308_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_311_4 = 0.5

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				var_311_2.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_308_1.time_ - 0) / var_311_4)

				if arg_308_1.var_.actorSpriteSplit10154 ~= nil then
					arg_308_1.var_.actorSpriteSplit10154:SetAlpha((arg_308_1.time_ - 0) / var_311_4)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				var_311_2.localPosition = Vector3.New(-20, -338, -538)

				if arg_308_1.var_.actorSpriteSplit10154 ~= nil then
					arg_308_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_311_5 = 0
			local var_311_6 = 0.975

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_5 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_7 = arg_308_1:GetWordFromCfg(424081074)
				local var_311_8 = arg_308_1:FormatText(var_311_7.content)

				arg_308_1.text_.text = var_311_8

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_10 = 39 <= 0 and var_311_6 or var_311_6 * (utf8.len(var_311_8) / 39)

				if (39 <= 0 and var_311_6 or var_311_6 * (utf8.len(var_311_8) / 39)) > 0 and var_311_6 < var_311_10 then
					arg_308_1.talkMaxDuration = var_311_10

					if var_311_10 + var_311_5 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_10 + var_311_5
					end
				end

				arg_308_1.text_.text = var_311_8
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081074", "story_v_out_424081.awb") ~= 0 then
					local var_311_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081074", "story_v_out_424081.awb") / 1000

					if var_311_11 + var_311_5 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_11 + var_311_5
					end

					if var_311_7.prefab_name ~= "" and arg_308_1.actors_[var_311_7.prefab_name] ~= nil then
						local var_311_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_7.prefab_name].transform, "story_v_out_424081", "424081074", "story_v_out_424081.awb")

						arg_308_1:RecordAudio("424081074", var_311_12)
						arg_308_1:RecordAudio("424081074", var_311_12)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_424081", "424081074", "story_v_out_424081.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_424081", "424081074", "story_v_out_424081.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_13 = math.max(var_311_6, arg_308_1.talkMaxDuration)

			if var_311_5 <= arg_308_1.time_ and arg_308_1.time_ < var_311_5 + var_311_13 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_5) / var_311_13

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_5 + var_311_13 and arg_308_1.time_ < var_311_5 + var_311_13 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play424081075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 424081075
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play424081076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["10154"]) and arg_312_1.var_.actorSpriteComps10154 == nil then
				arg_312_1.var_.actorSpriteComps10154 = arg_312_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_0 = 0.2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["10154"]) then
				if arg_312_1.var_.actorSpriteComps10154 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								iter_315_1.color = Color.New(Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor2.r, (arg_312_1.time_ - 0) / var_315_0), Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor2.g, (arg_312_1.time_ - 0) / var_315_0), (Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor2.b, (arg_312_1.time_ - 0) / var_315_0)))
							else
								local var_315_1 = Mathf.Lerp(iter_315_1.color.r, 0.5, (arg_312_1.time_ - 0) / var_315_0)

								iter_315_1.color = Color.New(var_315_1, var_315_1, var_315_1)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["10154"]) and arg_312_1.var_.actorSpriteComps10154 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_315_3 then
						iter_315_3.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_312_1.var_.actorSpriteComps10154 = nil
			end

			local var_315_2 = 0
			local var_315_3 = 0.875

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_2 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_4 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(424081075).content)

				arg_312_1.text_.text = var_315_4

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_6 = 31 <= 0 and var_315_3 or var_315_3 * (utf8.len(var_315_4) / 31)

				if (31 <= 0 and var_315_3 or var_315_3 * (utf8.len(var_315_4) / 31)) > 0 and var_315_3 < var_315_6 then
					arg_312_1.talkMaxDuration = var_315_6

					if var_315_6 + var_315_2 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_6 + var_315_2
					end
				end

				arg_312_1.text_.text = var_315_4
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_3, arg_312_1.talkMaxDuration)

			if var_315_2 <= arg_312_1.time_ and arg_312_1.time_ < var_315_2 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_2) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_2 + var_315_7 and arg_312_1.time_ < var_315_2 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play424081076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 424081076
		arg_316_1.duration_ = 4.07

		local var_316_0 = {
			zh = 4.066,
			ja = 3.966
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play424081077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["10154"]) and arg_316_1.var_.actorSpriteComps10154 == nil then
				arg_316_1.var_.actorSpriteComps10154 = arg_316_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_0 = 0.2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["10154"]) then
				if arg_316_1.var_.actorSpriteComps10154 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_319_1 then
							if arg_316_1.isInRecall_ then
								iter_319_1.color = Color.New(Mathf.Lerp(iter_319_1.color.r, arg_316_1.hightColor1.r, (arg_316_1.time_ - 0) / var_319_0), Mathf.Lerp(iter_319_1.color.g, arg_316_1.hightColor1.g, (arg_316_1.time_ - 0) / var_319_0), (Mathf.Lerp(iter_319_1.color.b, arg_316_1.hightColor1.b, (arg_316_1.time_ - 0) / var_319_0)))
							else
								local var_319_1 = Mathf.Lerp(iter_319_1.color.r, 1, (arg_316_1.time_ - 0) / var_319_0)

								iter_319_1.color = Color.New(var_319_1, var_319_1, var_319_1)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["10154"]) and arg_316_1.var_.actorSpriteComps10154 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_319_3 then
						iter_319_3.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_316_1.var_.actorSpriteComps10154 = nil
			end

			local var_319_2 = arg_316_1.actors_["10154"].transform

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos10154 = var_319_2.localPosition
				var_319_2.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("10154", 3)

				for iter_319_4 = 0, var_319_2.childCount - 1 do
					local var_319_3 = var_319_2:GetChild(iter_319_4)

					if var_319_3.name == "split_3" then
						var_319_3:SetAsLastSibling()
						var_319_3.gameObject:SetActive(true)

						arg_316_1.var_.actorSpriteSplit10154 = var_319_3.gameObject:GetComponent(typeof(Image))

						arg_316_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_319_4 = 0.5

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_4 then
				var_319_2.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_316_1.time_ - 0) / var_319_4)

				if arg_316_1.var_.actorSpriteSplit10154 ~= nil then
					arg_316_1.var_.actorSpriteSplit10154:SetAlpha((arg_316_1.time_ - 0) / var_319_4)
				end
			end

			if arg_316_1.time_ >= 0 + var_319_4 and arg_316_1.time_ < 0 + var_319_4 + arg_319_0 then
				var_319_2.localPosition = Vector3.New(-20, -338, -538)

				if arg_316_1.var_.actorSpriteSplit10154 ~= nil then
					arg_316_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_319_5 = 0
			local var_319_6 = 0.4

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_5 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_7 = arg_316_1:GetWordFromCfg(424081076)
				local var_319_8 = arg_316_1:FormatText(var_319_7.content)

				arg_316_1.text_.text = var_319_8

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_10 = 16 <= 0 and var_319_6 or var_319_6 * (utf8.len(var_319_8) / 16)

				if (16 <= 0 and var_319_6 or var_319_6 * (utf8.len(var_319_8) / 16)) > 0 and var_319_6 < var_319_10 then
					arg_316_1.talkMaxDuration = var_319_10

					if var_319_10 + var_319_5 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_10 + var_319_5
					end
				end

				arg_316_1.text_.text = var_319_8
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081076", "story_v_out_424081.awb") ~= 0 then
					local var_319_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081076", "story_v_out_424081.awb") / 1000

					if var_319_11 + var_319_5 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_11 + var_319_5
					end

					if var_319_7.prefab_name ~= "" and arg_316_1.actors_[var_319_7.prefab_name] ~= nil then
						local var_319_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_7.prefab_name].transform, "story_v_out_424081", "424081076", "story_v_out_424081.awb")

						arg_316_1:RecordAudio("424081076", var_319_12)
						arg_316_1:RecordAudio("424081076", var_319_12)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_424081", "424081076", "story_v_out_424081.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_424081", "424081076", "story_v_out_424081.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_13 = math.max(var_319_6, arg_316_1.talkMaxDuration)

			if var_319_5 <= arg_316_1.time_ and arg_316_1.time_ < var_319_5 + var_319_13 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_5) / var_319_13

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_5 + var_319_13 and arg_316_1.time_ < var_319_5 + var_319_13 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play424081077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 424081077
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play424081078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(arg_320_1.actors_["10154"]) and arg_320_1.var_.actorSpriteComps10154 == nil then
				arg_320_1.var_.actorSpriteComps10154 = arg_320_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_0 = 0.2

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 and not isNil(arg_320_1.actors_["10154"]) then
				if arg_320_1.var_.actorSpriteComps10154 then
					for iter_323_0, iter_323_1 in pairs(arg_320_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_323_1 then
							if arg_320_1.isInRecall_ then
								iter_323_1.color = Color.New(Mathf.Lerp(iter_323_1.color.r, arg_320_1.hightColor2.r, (arg_320_1.time_ - 0) / var_323_0), Mathf.Lerp(iter_323_1.color.g, arg_320_1.hightColor2.g, (arg_320_1.time_ - 0) / var_323_0), (Mathf.Lerp(iter_323_1.color.b, arg_320_1.hightColor2.b, (arg_320_1.time_ - 0) / var_323_0)))
							else
								local var_323_1 = Mathf.Lerp(iter_323_1.color.r, 0.5, (arg_320_1.time_ - 0) / var_323_0)

								iter_323_1.color = Color.New(var_323_1, var_323_1, var_323_1)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 and not isNil(arg_320_1.actors_["10154"]) and arg_320_1.var_.actorSpriteComps10154 then
				for iter_323_2, iter_323_3 in pairs(arg_320_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_323_3 then
						iter_323_3.color = arg_320_1.isInRecall_ and (arg_320_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_320_1.var_.actorSpriteComps10154 = nil
			end

			local var_323_2 = arg_320_1.actors_["10154"].transform

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos10154 = var_323_2.localPosition
				var_323_2.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("10154", 7)

				for iter_323_4 = 0, var_323_2.childCount - 1 do
					local var_323_3 = var_323_2:GetChild(iter_323_4)

					if var_323_3.name == "" or not string.find(var_323_3.name, "split") then
						var_323_3.gameObject:SetActive(true)
					else
						var_323_3.gameObject:SetActive(false)
					end
				end
			end

			local var_323_4 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 then
				var_323_2.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_320_1.time_ - 0) / var_323_4)
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 then
				var_323_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_323_5 = 0

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_5 + arg_323_0 then
				arg_320_1.allBtn_.enabled = false
			end

			if arg_320_1.time_ >= var_323_5 + 0.5 and arg_320_1.time_ < var_323_5 + 0.5 + arg_323_0 then
				arg_320_1.allBtn_.enabled = true
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_woodbucket", "")
			end

			if 0.2 < arg_320_1.time_ and arg_320_1.time_ <= 0.2 + arg_323_0 then
				arg_320_1:AudioAction("play", "effect", "se_story_side_1061", "se_story_side_1061_clap_wood", "")
			end

			local var_323_8 = 0
			local var_323_9 = 0.85

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_8 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0

				arg_320_1.dialog_:SetActive(true)

				arg_320_1.dialogCg_.alpha = 0

				local var_323_10 = LeanTween.value(arg_320_1.dialog_, 0, 1, 0.3)

				var_323_10:setOnUpdate(LuaHelper.FloatAction(function(arg_324_0)
					arg_320_1.dialogCg_.alpha = arg_324_0
				end))
				var_323_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_320_1.dialog_)
					var_323_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_320_1.duration_ = arg_320_1.duration_ + 0.3

				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_11 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(424081077).content)

				arg_320_1.text_.text = var_323_11

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_13 = 34 <= 0 and var_323_9 or var_323_9 * (utf8.len(var_323_11) / 34)

				if (34 <= 0 and var_323_9 or var_323_9 * (utf8.len(var_323_11) / 34)) > 0 and var_323_9 < var_323_13 then
					arg_320_1.talkMaxDuration = var_323_13
					var_323_8 = var_323_8 + 0.3

					if var_323_13 + var_323_8 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_13 + var_323_8
					end
				end

				arg_320_1.text_.text = var_323_11
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_14 = var_323_8 + 0.3
			local var_323_15 = math.max(var_323_9, arg_320_1.talkMaxDuration)

			if var_323_8 + 0.3 <= arg_320_1.time_ and arg_320_1.time_ < var_323_14 + var_323_15 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_14) / var_323_15

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_14 + var_323_15 and arg_320_1.time_ < var_323_14 + var_323_15 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 12,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/UpDown_Shake",
				duration = 0.3,
				amplitudeGain = 1,
				startTime = 0.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play424081078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 424081078
		arg_326_1.duration_ = 5

		local var_326_0 = {
			zh = 4.633,
			ja = 5
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play424081079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["10154"]) and arg_326_1.var_.actorSpriteComps10154 == nil then
				arg_326_1.var_.actorSpriteComps10154 = arg_326_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_0 = 0.2

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["10154"]) then
				if arg_326_1.var_.actorSpriteComps10154 then
					for iter_329_0, iter_329_1 in pairs(arg_326_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_329_1 then
							if arg_326_1.isInRecall_ then
								iter_329_1.color = Color.New(Mathf.Lerp(iter_329_1.color.r, arg_326_1.hightColor1.r, (arg_326_1.time_ - 0) / var_329_0), Mathf.Lerp(iter_329_1.color.g, arg_326_1.hightColor1.g, (arg_326_1.time_ - 0) / var_329_0), (Mathf.Lerp(iter_329_1.color.b, arg_326_1.hightColor1.b, (arg_326_1.time_ - 0) / var_329_0)))
							else
								local var_329_1 = Mathf.Lerp(iter_329_1.color.r, 1, (arg_326_1.time_ - 0) / var_329_0)

								iter_329_1.color = Color.New(var_329_1, var_329_1, var_329_1)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["10154"]) and arg_326_1.var_.actorSpriteComps10154 then
				for iter_329_2, iter_329_3 in pairs(arg_326_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_329_3 then
						iter_329_3.color = arg_326_1.isInRecall_ and (arg_326_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_326_1.var_.actorSpriteComps10154 = nil
			end

			local var_329_2 = arg_326_1.actors_["10154"].transform

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.var_.moveOldPos10154 = var_329_2.localPosition
				var_329_2.localScale = Vector3.New(1, 1, 1)

				arg_326_1:CheckSpriteTmpPos("10154", 3)

				for iter_329_4 = 0, var_329_2.childCount - 1 do
					local var_329_3 = var_329_2:GetChild(iter_329_4)

					if var_329_3.name == "split_3" or not string.find(var_329_3.name, "split") then
						var_329_3.gameObject:SetActive(true)
					else
						var_329_3.gameObject:SetActive(false)
					end
				end
			end

			local var_329_4 = 0.001

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				var_329_2.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_326_1.time_ - 0) / var_329_4)
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				var_329_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_329_5 = 0
			local var_329_6 = 0.65

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_5 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_7 = arg_326_1:GetWordFromCfg(424081078)
				local var_329_8 = arg_326_1:FormatText(var_329_7.content)

				arg_326_1.text_.text = var_329_8

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_10 = 26 <= 0 and var_329_6 or var_329_6 * (utf8.len(var_329_8) / 26)

				if (26 <= 0 and var_329_6 or var_329_6 * (utf8.len(var_329_8) / 26)) > 0 and var_329_6 < var_329_10 then
					arg_326_1.talkMaxDuration = var_329_10

					if var_329_10 + var_329_5 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_10 + var_329_5
					end
				end

				arg_326_1.text_.text = var_329_8
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081078", "story_v_out_424081.awb") ~= 0 then
					local var_329_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081078", "story_v_out_424081.awb") / 1000

					if var_329_11 + var_329_5 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_11 + var_329_5
					end

					if var_329_7.prefab_name ~= "" and arg_326_1.actors_[var_329_7.prefab_name] ~= nil then
						local var_329_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_7.prefab_name].transform, "story_v_out_424081", "424081078", "story_v_out_424081.awb")

						arg_326_1:RecordAudio("424081078", var_329_12)
						arg_326_1:RecordAudio("424081078", var_329_12)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_424081", "424081078", "story_v_out_424081.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_424081", "424081078", "story_v_out_424081.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_13 = math.max(var_329_6, arg_326_1.talkMaxDuration)

			if var_329_5 <= arg_326_1.time_ and arg_326_1.time_ < var_329_5 + var_329_13 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_5) / var_329_13

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_5 + var_329_13 and arg_326_1.time_ < var_329_5 + var_329_13 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play424081079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 424081079
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play424081080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["10154"]) and arg_330_1.var_.actorSpriteComps10154 == nil then
				arg_330_1.var_.actorSpriteComps10154 = arg_330_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_0 = 0.2

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["10154"]) then
				if arg_330_1.var_.actorSpriteComps10154 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								iter_333_1.color = Color.New(Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor2.r, (arg_330_1.time_ - 0) / var_333_0), Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor2.g, (arg_330_1.time_ - 0) / var_333_0), (Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor2.b, (arg_330_1.time_ - 0) / var_333_0)))
							else
								local var_333_1 = Mathf.Lerp(iter_333_1.color.r, 0.5, (arg_330_1.time_ - 0) / var_333_0)

								iter_333_1.color = Color.New(var_333_1, var_333_1, var_333_1)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["10154"]) and arg_330_1.var_.actorSpriteComps10154 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_333_3 then
						iter_333_3.color = arg_330_1.isInRecall_ and (arg_330_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_330_1.var_.actorSpriteComps10154 = nil
			end

			local var_333_2 = arg_330_1.actors_["10154"].transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos10154 = var_333_2.localPosition
				var_333_2.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("10154", 7)

				for iter_333_4 = 0, var_333_2.childCount - 1 do
					local var_333_3 = var_333_2:GetChild(iter_333_4)

					if var_333_3.name == "" or not string.find(var_333_3.name, "split") then
						var_333_3.gameObject:SetActive(true)
					else
						var_333_3.gameObject:SetActive(false)
					end
				end
			end

			local var_333_4 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				var_333_2.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_330_1.time_ - 0) / var_333_4)
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				var_333_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep04", "")
			end

			local var_333_6 = 0
			local var_333_7 = 0.85

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_6 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_8 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(424081079).content)

				arg_330_1.text_.text = var_333_8

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_10 = 34 <= 0 and var_333_7 or var_333_7 * (utf8.len(var_333_8) / 34)

				if (34 <= 0 and var_333_7 or var_333_7 * (utf8.len(var_333_8) / 34)) > 0 and var_333_7 < var_333_10 then
					arg_330_1.talkMaxDuration = var_333_10

					if var_333_10 + var_333_6 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_10 + var_333_6
					end
				end

				arg_330_1.text_.text = var_333_8
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_11 = math.max(var_333_7, arg_330_1.talkMaxDuration)

			if var_333_6 <= arg_330_1.time_ and arg_330_1.time_ < var_333_6 + var_333_11 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_6) / var_333_11

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_6 + var_333_11 and arg_330_1.time_ < var_333_6 + var_333_11 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play424081080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 424081080
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play424081081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 0.475

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_1 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(424081080).content)

				arg_334_1.text_.text = var_337_1

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_3 = 19 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 19)

				if (19 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_1) / 19)) > 0 and var_337_0 < var_337_3 then
					arg_334_1.talkMaxDuration = var_337_3

					if var_337_3 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_3 + 0
					end
				end

				arg_334_1.text_.text = var_337_1
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_4 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_4

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play424081081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 424081081
		arg_338_1.duration_ = 10.67

		local var_338_0 = {
			zh = 9.9,
			ja = 10.666
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play424081082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["10154"]) and arg_338_1.var_.actorSpriteComps10154 == nil then
				arg_338_1.var_.actorSpriteComps10154 = arg_338_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_0 = 0.2

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["10154"]) then
				if arg_338_1.var_.actorSpriteComps10154 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								iter_341_1.color = Color.New(Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, (arg_338_1.time_ - 0) / var_341_0), Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, (arg_338_1.time_ - 0) / var_341_0), (Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, (arg_338_1.time_ - 0) / var_341_0)))
							else
								local var_341_1 = Mathf.Lerp(iter_341_1.color.r, 1, (arg_338_1.time_ - 0) / var_341_0)

								iter_341_1.color = Color.New(var_341_1, var_341_1, var_341_1)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["10154"]) and arg_338_1.var_.actorSpriteComps10154 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_341_3 then
						iter_341_3.color = arg_338_1.isInRecall_ and (arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_338_1.var_.actorSpriteComps10154 = nil
			end

			local var_341_2 = arg_338_1.actors_["10154"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos10154 = var_341_2.localPosition
				var_341_2.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("10154", 3)

				for iter_341_4 = 0, var_341_2.childCount - 1 do
					local var_341_3 = var_341_2:GetChild(iter_341_4)

					if var_341_3.name == "split_4" then
						var_341_3:SetAsLastSibling()
						var_341_3.gameObject:SetActive(true)

						arg_338_1.var_.actorSpriteSplit10154 = var_341_3.gameObject:GetComponent(typeof(Image))

						arg_338_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_341_4 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				var_341_2.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_338_1.time_ - 0) / var_341_4)

				if arg_338_1.var_.actorSpriteSplit10154 ~= nil then
					arg_338_1.var_.actorSpriteSplit10154:SetAlpha((arg_338_1.time_ - 0) / var_341_4)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				var_341_2.localPosition = Vector3.New(-20, -338, -538)

				if arg_338_1.var_.actorSpriteSplit10154 ~= nil then
					arg_338_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_341_5 = 0
			local var_341_6 = 1.25

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_5 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_7 = arg_338_1:GetWordFromCfg(424081081)
				local var_341_8 = arg_338_1:FormatText(var_341_7.content)

				arg_338_1.text_.text = var_341_8

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_10 = 50 <= 0 and var_341_6 or var_341_6 * (utf8.len(var_341_8) / 50)

				if (50 <= 0 and var_341_6 or var_341_6 * (utf8.len(var_341_8) / 50)) > 0 and var_341_6 < var_341_10 then
					arg_338_1.talkMaxDuration = var_341_10

					if var_341_10 + var_341_5 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_10 + var_341_5
					end
				end

				arg_338_1.text_.text = var_341_8
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081081", "story_v_out_424081.awb") ~= 0 then
					local var_341_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081081", "story_v_out_424081.awb") / 1000

					if var_341_11 + var_341_5 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_11 + var_341_5
					end

					if var_341_7.prefab_name ~= "" and arg_338_1.actors_[var_341_7.prefab_name] ~= nil then
						local var_341_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_7.prefab_name].transform, "story_v_out_424081", "424081081", "story_v_out_424081.awb")

						arg_338_1:RecordAudio("424081081", var_341_12)
						arg_338_1:RecordAudio("424081081", var_341_12)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_424081", "424081081", "story_v_out_424081.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_424081", "424081081", "story_v_out_424081.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_13 = math.max(var_341_6, arg_338_1.talkMaxDuration)

			if var_341_5 <= arg_338_1.time_ and arg_338_1.time_ < var_341_5 + var_341_13 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_5) / var_341_13

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_5 + var_341_13 and arg_338_1.time_ < var_341_5 + var_341_13 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play424081082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 424081082
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play424081083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["10154"]) and arg_342_1.var_.actorSpriteComps10154 == nil then
				arg_342_1.var_.actorSpriteComps10154 = arg_342_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_0 = 0.2

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["10154"]) then
				if arg_342_1.var_.actorSpriteComps10154 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								iter_345_1.color = Color.New(Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor2.r, (arg_342_1.time_ - 0) / var_345_0), Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor2.g, (arg_342_1.time_ - 0) / var_345_0), (Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor2.b, (arg_342_1.time_ - 0) / var_345_0)))
							else
								local var_345_1 = Mathf.Lerp(iter_345_1.color.r, 0.5, (arg_342_1.time_ - 0) / var_345_0)

								iter_345_1.color = Color.New(var_345_1, var_345_1, var_345_1)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["10154"]) and arg_342_1.var_.actorSpriteComps10154 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_345_3 then
						iter_345_3.color = arg_342_1.isInRecall_ and (arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_342_1.var_.actorSpriteComps10154 = nil
			end

			local var_345_2 = 0
			local var_345_3 = 0.875

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_2 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_4 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(424081082).content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_6 = 35 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_4) / 35)

				if (35 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_4) / 35)) > 0 and var_345_3 < var_345_6 then
					arg_342_1.talkMaxDuration = var_345_6

					if var_345_6 + var_345_2 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_6 + var_345_2
					end
				end

				arg_342_1.text_.text = var_345_4
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_3, arg_342_1.talkMaxDuration)

			if var_345_2 <= arg_342_1.time_ and arg_342_1.time_ < var_345_2 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_2) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_2 + var_345_7 and arg_342_1.time_ < var_345_2 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play424081083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 424081083
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play424081084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos10154 = arg_346_1.actors_["10154"].transform.localPosition
				arg_346_1.actors_["10154"].transform.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("10154", 7)

				for iter_349_0 = 0, arg_346_1.actors_["10154"].transform.childCount - 1 do
					local var_349_0 = arg_346_1.actors_["10154"].transform:GetChild(iter_349_0)

					if var_349_0.name == "" or not string.find(var_349_0.name, "split") then
						var_349_0.gameObject:SetActive(true)
					else
						var_349_0.gameObject:SetActive(false)
					end
				end
			end

			local var_349_1 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_1 then
				arg_346_1.actors_["10154"].transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_346_1.time_ - 0) / var_349_1)
			end

			if arg_346_1.time_ >= 0 + var_349_1 and arg_346_1.time_ < 0 + var_349_1 + arg_349_0 then
				arg_346_1.actors_["10154"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:AudioAction("play", "effect", "se_story_side_1050", "se_story_side_1050_fall", "")
			end

			local var_349_3 = 0
			local var_349_4 = 0.65

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_3 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_5 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(424081083).content)

				arg_346_1.text_.text = var_349_5

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_7 = 26 <= 0 and var_349_4 or var_349_4 * (utf8.len(var_349_5) / 26)

				if (26 <= 0 and var_349_4 or var_349_4 * (utf8.len(var_349_5) / 26)) > 0 and var_349_4 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_3 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_3
					end
				end

				arg_346_1.text_.text = var_349_5
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_8 = math.max(var_349_4, arg_346_1.talkMaxDuration)

			if var_349_3 <= arg_346_1.time_ and arg_346_1.time_ < var_349_3 + var_349_8 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_3) / var_349_8

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_3 + var_349_8 and arg_346_1.time_ < var_349_3 + var_349_8 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play424081084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 424081084
		arg_350_1.duration_ = 7

		local var_350_0 = {
			zh = 6.9,
			ja = 7
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play424081085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["10154"]) and arg_350_1.var_.actorSpriteComps10154 == nil then
				arg_350_1.var_.actorSpriteComps10154 = arg_350_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_0 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["10154"]) then
				if arg_350_1.var_.actorSpriteComps10154 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								iter_353_1.color = Color.New(Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor1.r, (arg_350_1.time_ - 0) / var_353_0), Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor1.g, (arg_350_1.time_ - 0) / var_353_0), (Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor1.b, (arg_350_1.time_ - 0) / var_353_0)))
							else
								local var_353_1 = Mathf.Lerp(iter_353_1.color.r, 1, (arg_350_1.time_ - 0) / var_353_0)

								iter_353_1.color = Color.New(var_353_1, var_353_1, var_353_1)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["10154"]) and arg_350_1.var_.actorSpriteComps10154 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_353_3 then
						iter_353_3.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_350_1.var_.actorSpriteComps10154 = nil
			end

			local var_353_2 = arg_350_1.actors_["10154"].transform

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos10154 = var_353_2.localPosition
				var_353_2.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("10154", 3)

				for iter_353_4 = 0, var_353_2.childCount - 1 do
					local var_353_3 = var_353_2:GetChild(iter_353_4)

					if var_353_3.name == "split_4" or not string.find(var_353_3.name, "split") then
						var_353_3.gameObject:SetActive(true)
					else
						var_353_3.gameObject:SetActive(false)
					end
				end
			end

			local var_353_4 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				var_353_2.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_350_1.time_ - 0) / var_353_4)
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				var_353_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_353_5 = 0
			local var_353_6 = 0.475

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_5 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_7 = arg_350_1:GetWordFromCfg(424081084)
				local var_353_8 = arg_350_1:FormatText(var_353_7.content)

				arg_350_1.text_.text = var_353_8

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_10 = 19 <= 0 and var_353_6 or var_353_6 * (utf8.len(var_353_8) / 19)

				if (19 <= 0 and var_353_6 or var_353_6 * (utf8.len(var_353_8) / 19)) > 0 and var_353_6 < var_353_10 then
					arg_350_1.talkMaxDuration = var_353_10

					if var_353_10 + var_353_5 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_10 + var_353_5
					end
				end

				arg_350_1.text_.text = var_353_8
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081084", "story_v_out_424081.awb") ~= 0 then
					local var_353_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081084", "story_v_out_424081.awb") / 1000

					if var_353_11 + var_353_5 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_11 + var_353_5
					end

					if var_353_7.prefab_name ~= "" and arg_350_1.actors_[var_353_7.prefab_name] ~= nil then
						local var_353_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_7.prefab_name].transform, "story_v_out_424081", "424081084", "story_v_out_424081.awb")

						arg_350_1:RecordAudio("424081084", var_353_12)
						arg_350_1:RecordAudio("424081084", var_353_12)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_424081", "424081084", "story_v_out_424081.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_424081", "424081084", "story_v_out_424081.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_13 = math.max(var_353_6, arg_350_1.talkMaxDuration)

			if var_353_5 <= arg_350_1.time_ and arg_350_1.time_ < var_353_5 + var_353_13 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_5) / var_353_13

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_5 + var_353_13 and arg_350_1.time_ < var_353_5 + var_353_13 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play424081085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 424081085
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play424081086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["10154"]) and arg_354_1.var_.actorSpriteComps10154 == nil then
				arg_354_1.var_.actorSpriteComps10154 = arg_354_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_0 = 0.2

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["10154"]) then
				if arg_354_1.var_.actorSpriteComps10154 then
					for iter_357_0, iter_357_1 in pairs(arg_354_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_357_1 then
							if arg_354_1.isInRecall_ then
								iter_357_1.color = Color.New(Mathf.Lerp(iter_357_1.color.r, arg_354_1.hightColor2.r, (arg_354_1.time_ - 0) / var_357_0), Mathf.Lerp(iter_357_1.color.g, arg_354_1.hightColor2.g, (arg_354_1.time_ - 0) / var_357_0), (Mathf.Lerp(iter_357_1.color.b, arg_354_1.hightColor2.b, (arg_354_1.time_ - 0) / var_357_0)))
							else
								local var_357_1 = Mathf.Lerp(iter_357_1.color.r, 0.5, (arg_354_1.time_ - 0) / var_357_0)

								iter_357_1.color = Color.New(var_357_1, var_357_1, var_357_1)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["10154"]) and arg_354_1.var_.actorSpriteComps10154 then
				for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_357_3 then
						iter_357_3.color = arg_354_1.isInRecall_ and (arg_354_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_354_1.var_.actorSpriteComps10154 = nil
			end

			local var_357_2 = 0
			local var_357_3 = 0.65

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_2 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_4 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(424081085).content)

				arg_354_1.text_.text = var_357_4

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_6 = 26 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_4) / 26)

				if (26 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_4) / 26)) > 0 and var_357_3 < var_357_6 then
					arg_354_1.talkMaxDuration = var_357_6

					if var_357_6 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_6 + var_357_2
					end
				end

				arg_354_1.text_.text = var_357_4
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_7 = math.max(var_357_3, arg_354_1.talkMaxDuration)

			if var_357_2 <= arg_354_1.time_ and arg_354_1.time_ < var_357_2 + var_357_7 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_2) / var_357_7

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_2 + var_357_7 and arg_354_1.time_ < var_357_2 + var_357_7 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play424081086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 424081086
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play424081087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos10154 = arg_358_1.actors_["10154"].transform.localPosition
				arg_358_1.actors_["10154"].transform.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("10154", 7)

				for iter_361_0 = 0, arg_358_1.actors_["10154"].transform.childCount - 1 do
					local var_361_0 = arg_358_1.actors_["10154"].transform:GetChild(iter_361_0)

					if var_361_0.name == "" or not string.find(var_361_0.name, "split") then
						var_361_0.gameObject:SetActive(true)
					else
						var_361_0.gameObject:SetActive(false)
					end
				end
			end

			local var_361_1 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_1 then
				arg_358_1.actors_["10154"].transform.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_358_1.time_ - 0) / var_361_1)
			end

			if arg_358_1.time_ >= 0 + var_361_1 and arg_358_1.time_ < 0 + var_361_1 + arg_361_0 then
				arg_358_1.actors_["10154"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_358_1.time_ and arg_358_1.time_ <= 0.034 + arg_361_0 then
				arg_358_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_clap01", "")
			end

			local var_361_3 = 0
			local var_361_4 = 0.575

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_3 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_5 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(424081086).content)

				arg_358_1.text_.text = var_361_5

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_7 = 23 <= 0 and var_361_4 or var_361_4 * (utf8.len(var_361_5) / 23)

				if (23 <= 0 and var_361_4 or var_361_4 * (utf8.len(var_361_5) / 23)) > 0 and var_361_4 < var_361_7 then
					arg_358_1.talkMaxDuration = var_361_7

					if var_361_7 + var_361_3 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_7 + var_361_3
					end
				end

				arg_358_1.text_.text = var_361_5
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_8 = math.max(var_361_4, arg_358_1.talkMaxDuration)

			if var_361_3 <= arg_358_1.time_ and arg_358_1.time_ < var_361_3 + var_361_8 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_3) / var_361_8

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_3 + var_361_8 and arg_358_1.time_ < var_361_3 + var_361_8 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play424081087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 424081087
		arg_362_1.duration_ = 5.93

		local var_362_0 = {
			zh = 5.333,
			ja = 5.933
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play424081088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if arg_362_1.bgs_.I11i == nil then
				local var_365_0 = Object.Instantiate(arg_362_1.paintGo_)

				var_365_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11i")
				var_365_0.name = "I11i"
				var_365_0.transform.parent = arg_362_1.stage_.transform
				var_365_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_362_1.bgs_.I11i = var_365_0
			end

			if 2 < arg_362_1.time_ and arg_362_1.time_ <= 2 + arg_365_0 then
				local var_365_1 = arg_362_1.bgs_.I11i

				arg_362_1.bgs_.I11i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_365_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_365_2 = var_365_1:GetComponent("SpriteRenderer")

				if var_365_2 and var_365_2.sprite then
					local var_365_3 = 2 * (var_365_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_365_1.transform.localScale = Vector3.New(var_365_3 / var_365_2.sprite.bounds.size.y < var_365_3 * manager.ui.mainCameraCom_.aspect / var_365_2.sprite.bounds.size.x and var_365_3 * manager.ui.mainCameraCom_.aspect / var_365_2.sprite.bounds.size.x or var_365_3 / var_365_2.sprite.bounds.size.y, var_365_3 / var_365_2.sprite.bounds.size.y < var_365_3 * manager.ui.mainCameraCom_.aspect / var_365_2.sprite.bounds.size.x and var_365_3 * manager.ui.mainCameraCom_.aspect / var_365_2.sprite.bounds.size.x or var_365_3 / var_365_2.sprite.bounds.size.y, 0)
				end

				for iter_365_0, iter_365_1 in pairs(arg_362_1.bgs_) do
					if iter_365_0 ~= "I11i" then
						iter_365_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_365_4 = 4

			if 4 < arg_362_1.time_ and arg_362_1.time_ <= var_365_4 + arg_365_0 then
				arg_362_1.allBtn_.enabled = false
			end

			if arg_362_1.time_ >= var_365_4 + 0.3 and arg_362_1.time_ < var_365_4 + 0.3 + arg_365_0 then
				arg_362_1.allBtn_.enabled = true
			end

			local var_365_5 = 0

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_5 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_6 = 2

			if var_365_5 <= arg_362_1.time_ and arg_362_1.time_ < var_365_5 + var_365_6 then
				local var_365_7 = Color.New(0, 0, 0)

				var_365_7.a = Mathf.Lerp(0, 1, (arg_362_1.time_ - var_365_5) / var_365_6)
				arg_362_1.mask_.color = var_365_7
			end

			if arg_362_1.time_ >= var_365_5 + var_365_6 and arg_362_1.time_ < var_365_5 + var_365_6 + arg_365_0 then
				local var_365_8 = Color.New(0, 0, 0)

				var_365_8.a = 1
				arg_362_1.mask_.color = var_365_8
			end

			local var_365_9 = 2

			if 2 < arg_362_1.time_ and arg_362_1.time_ <= var_365_9 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_10 = 2

			if var_365_9 <= arg_362_1.time_ and arg_362_1.time_ < var_365_9 + var_365_10 then
				local var_365_11 = Color.New(0, 0, 0)

				var_365_11.a = Mathf.Lerp(1, 0, (arg_362_1.time_ - var_365_9) / var_365_10)
				arg_362_1.mask_.color = var_365_11
			end

			if arg_362_1.time_ >= var_365_9 + var_365_10 and arg_362_1.time_ < var_365_9 + var_365_10 + arg_365_0 then
				local var_365_12 = Color.New(0, 0, 0)

				arg_362_1.mask_.enabled = false
				var_365_12.a = 0
				arg_362_1.mask_.color = var_365_12
			end

			local var_365_13 = arg_362_1.actors_["1094"]

			if 3.8 < arg_362_1.time_ and arg_362_1.time_ <= 3.8 + arg_365_0 and not isNil(var_365_13) and arg_362_1.var_.actorSpriteComps1094 == nil then
				arg_362_1.var_.actorSpriteComps1094 = var_365_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_14 = 0.2

			if 3.8 <= arg_362_1.time_ and arg_362_1.time_ < 3.8 + var_365_14 and not isNil(var_365_13) then
				if arg_362_1.var_.actorSpriteComps1094 then
					for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_365_3 then
							if arg_362_1.isInRecall_ then
								iter_365_3.color = Color.New(Mathf.Lerp(iter_365_3.color.r, arg_362_1.hightColor1.r, (arg_362_1.time_ - 3.8) / var_365_14), Mathf.Lerp(iter_365_3.color.g, arg_362_1.hightColor1.g, (arg_362_1.time_ - 3.8) / var_365_14), (Mathf.Lerp(iter_365_3.color.b, arg_362_1.hightColor1.b, (arg_362_1.time_ - 3.8) / var_365_14)))
							else
								local var_365_15 = Mathf.Lerp(iter_365_3.color.r, 1, (arg_362_1.time_ - 3.8) / var_365_14)

								iter_365_3.color = Color.New(var_365_15, var_365_15, var_365_15)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 3.8 + var_365_14 and arg_362_1.time_ < 3.8 + var_365_14 + arg_365_0 and not isNil(var_365_13) and arg_362_1.var_.actorSpriteComps1094 then
				for iter_365_4, iter_365_5 in pairs(arg_362_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_365_5 then
						iter_365_5.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_362_1.var_.actorSpriteComps1094 = nil
			end

			local var_365_16 = arg_362_1.actors_["1094"].transform

			if 3.8 < arg_362_1.time_ and arg_362_1.time_ <= 3.8 + arg_365_0 then
				arg_362_1.var_.moveOldPos1094 = var_365_16.localPosition
				var_365_16.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("1094", 3)

				for iter_365_6 = 0, var_365_16.childCount - 1 do
					local var_365_17 = var_365_16:GetChild(iter_365_6)

					if var_365_17.name == "split_1" or not string.find(var_365_17.name, "split") then
						var_365_17.gameObject:SetActive(true)
					else
						var_365_17.gameObject:SetActive(false)
					end
				end
			end

			local var_365_18 = 0.001

			if 3.8 <= arg_362_1.time_ and arg_362_1.time_ < 3.8 + var_365_18 then
				var_365_16.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_362_1.time_ - 3.8) / var_365_18)
			end

			if arg_362_1.time_ >= 3.8 + var_365_18 and arg_362_1.time_ < 3.8 + var_365_18 + arg_365_0 then
				var_365_16.localPosition = Vector3.New(0, -335, -230)
			end

			if 0.1 < arg_362_1.time_ and arg_362_1.time_ <= 0.1 + arg_365_0 then
				arg_362_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if 1.6 < arg_362_1.time_ and arg_362_1.time_ <= 1.6 + arg_365_0 then
				arg_362_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_362_1.frameCnt_ <= 1 then
				arg_362_1.dialog_:SetActive(false)
			end

			local var_365_21 = 4
			local var_365_22 = 0.1

			if 4 < arg_362_1.time_ and arg_362_1.time_ <= var_365_21 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0

				arg_362_1.dialog_:SetActive(true)

				arg_362_1.dialogCg_.alpha = 0

				local var_365_23 = LeanTween.value(arg_362_1.dialog_, 0, 1, 0.3)

				var_365_23:setOnUpdate(LuaHelper.FloatAction(function(arg_366_0)
					arg_362_1.dialogCg_.alpha = arg_366_0
				end))
				var_365_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_362_1.dialog_)
					var_365_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_362_1.duration_ = arg_362_1.duration_ + 0.3

				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_24 = arg_362_1:GetWordFromCfg(424081087)
				local var_365_25 = arg_362_1:FormatText(var_365_24.content)

				arg_362_1.text_.text = var_365_25

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_27 = 4 <= 0 and var_365_22 or var_365_22 * (utf8.len(var_365_25) / 4)

				if (4 <= 0 and var_365_22 or var_365_22 * (utf8.len(var_365_25) / 4)) > 0 and var_365_22 < var_365_27 then
					arg_362_1.talkMaxDuration = var_365_27
					var_365_21 = var_365_21 + 0.3

					if var_365_27 + var_365_21 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_27 + var_365_21
					end
				end

				arg_362_1.text_.text = var_365_25
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081087", "story_v_out_424081.awb") ~= 0 then
					local var_365_28 = manager.audio:GetVoiceLength("story_v_out_424081", "424081087", "story_v_out_424081.awb") / 1000

					if var_365_28 + var_365_21 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_28 + var_365_21
					end

					if var_365_24.prefab_name ~= "" and arg_362_1.actors_[var_365_24.prefab_name] ~= nil then
						local var_365_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_24.prefab_name].transform, "story_v_out_424081", "424081087", "story_v_out_424081.awb")

						arg_362_1:RecordAudio("424081087", var_365_29)
						arg_362_1:RecordAudio("424081087", var_365_29)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_424081", "424081087", "story_v_out_424081.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_424081", "424081087", "story_v_out_424081.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_30 = var_365_21 + 0.3
			local var_365_31 = math.max(var_365_22, arg_362_1.talkMaxDuration)

			if var_365_21 + 0.3 <= arg_362_1.time_ and arg_362_1.time_ < var_365_30 + var_365_31 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_30) / var_365_31

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_30 + var_365_31 and arg_362_1.time_ < var_365_30 + var_365_31 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play424081088 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 424081088
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play424081089(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(arg_368_1.actors_["1094"]) and arg_368_1.var_.actorSpriteComps1094 == nil then
				arg_368_1.var_.actorSpriteComps1094 = arg_368_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_371_0 = 0.2

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 and not isNil(arg_368_1.actors_["1094"]) then
				if arg_368_1.var_.actorSpriteComps1094 then
					for iter_371_0, iter_371_1 in pairs(arg_368_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_371_1 then
							if arg_368_1.isInRecall_ then
								iter_371_1.color = Color.New(Mathf.Lerp(iter_371_1.color.r, arg_368_1.hightColor2.r, (arg_368_1.time_ - 0) / var_371_0), Mathf.Lerp(iter_371_1.color.g, arg_368_1.hightColor2.g, (arg_368_1.time_ - 0) / var_371_0), (Mathf.Lerp(iter_371_1.color.b, arg_368_1.hightColor2.b, (arg_368_1.time_ - 0) / var_371_0)))
							else
								local var_371_1 = Mathf.Lerp(iter_371_1.color.r, 0.5, (arg_368_1.time_ - 0) / var_371_0)

								iter_371_1.color = Color.New(var_371_1, var_371_1, var_371_1)
							end
						end
					end
				end
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 and not isNil(arg_368_1.actors_["1094"]) and arg_368_1.var_.actorSpriteComps1094 then
				for iter_371_2, iter_371_3 in pairs(arg_368_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_371_3 then
						iter_371_3.color = arg_368_1.isInRecall_ and (arg_368_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_368_1.var_.actorSpriteComps1094 = nil
			end

			local var_371_2 = 0
			local var_371_3 = 0.7

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_2 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_4 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(424081088).content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_6 = 28 <= 0 and var_371_3 or var_371_3 * (utf8.len(var_371_4) / 28)

				if (28 <= 0 and var_371_3 or var_371_3 * (utf8.len(var_371_4) / 28)) > 0 and var_371_3 < var_371_6 then
					arg_368_1.talkMaxDuration = var_371_6

					if var_371_6 + var_371_2 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_6 + var_371_2
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_3, arg_368_1.talkMaxDuration)

			if var_371_2 <= arg_368_1.time_ and arg_368_1.time_ < var_371_2 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_2) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_2 + var_371_7 and arg_368_1.time_ < var_371_2 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play424081089 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 424081089
		arg_372_1.duration_ = 9

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play424081090(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 2 < arg_372_1.time_ and arg_372_1.time_ <= 2 + arg_375_0 then
				local var_375_0 = arg_372_1.bgs_.STblack

				arg_372_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_375_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_375_1 = var_375_0:GetComponent("SpriteRenderer")

				if var_375_1 and var_375_1.sprite then
					local var_375_2 = 2 * (var_375_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_375_0.transform.localScale = Vector3.New(var_375_2 / var_375_1.sprite.bounds.size.y < var_375_2 * manager.ui.mainCameraCom_.aspect / var_375_1.sprite.bounds.size.x and var_375_2 * manager.ui.mainCameraCom_.aspect / var_375_1.sprite.bounds.size.x or var_375_2 / var_375_1.sprite.bounds.size.y, var_375_2 / var_375_1.sprite.bounds.size.y < var_375_2 * manager.ui.mainCameraCom_.aspect / var_375_1.sprite.bounds.size.x and var_375_2 * manager.ui.mainCameraCom_.aspect / var_375_1.sprite.bounds.size.x or var_375_2 / var_375_1.sprite.bounds.size.y, 0)
				end

				for iter_375_0, iter_375_1 in pairs(arg_372_1.bgs_) do
					if iter_375_0 ~= "STblack" then
						iter_375_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_375_3 = 4

			if 4 < arg_372_1.time_ and arg_372_1.time_ <= var_375_3 + arg_375_0 then
				arg_372_1.allBtn_.enabled = false
			end

			if arg_372_1.time_ >= var_375_3 + 0.3 and arg_372_1.time_ < var_375_3 + 0.3 + arg_375_0 then
				arg_372_1.allBtn_.enabled = true
			end

			local var_375_4 = 0

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_4 + arg_375_0 then
				arg_372_1.mask_.enabled = true
				arg_372_1.mask_.raycastTarget = true

				arg_372_1:SetGaussion(false)
			end

			local var_375_5 = 2

			if var_375_4 <= arg_372_1.time_ and arg_372_1.time_ < var_375_4 + var_375_5 then
				local var_375_6 = Color.New(0, 0, 0)

				var_375_6.a = Mathf.Lerp(0, 1, (arg_372_1.time_ - var_375_4) / var_375_5)
				arg_372_1.mask_.color = var_375_6
			end

			if arg_372_1.time_ >= var_375_4 + var_375_5 and arg_372_1.time_ < var_375_4 + var_375_5 + arg_375_0 then
				local var_375_7 = Color.New(0, 0, 0)

				var_375_7.a = 1
				arg_372_1.mask_.color = var_375_7
			end

			local var_375_8 = 2

			if 2 < arg_372_1.time_ and arg_372_1.time_ <= var_375_8 + arg_375_0 then
				arg_372_1.mask_.enabled = true
				arg_372_1.mask_.raycastTarget = true

				arg_372_1:SetGaussion(false)
			end

			local var_375_9 = 2

			if var_375_8 <= arg_372_1.time_ and arg_372_1.time_ < var_375_8 + var_375_9 then
				local var_375_10 = Color.New(0, 0, 0)

				var_375_10.a = Mathf.Lerp(1, 0, (arg_372_1.time_ - var_375_8) / var_375_9)
				arg_372_1.mask_.color = var_375_10
			end

			if arg_372_1.time_ >= var_375_8 + var_375_9 and arg_372_1.time_ < var_375_8 + var_375_9 + arg_375_0 then
				local var_375_11 = Color.New(0, 0, 0)

				arg_372_1.mask_.enabled = false
				var_375_11.a = 0
				arg_372_1.mask_.color = var_375_11
			end

			local var_375_12 = arg_372_1.actors_["1094"].transform

			if 1.966 < arg_372_1.time_ and arg_372_1.time_ <= 1.966 + arg_375_0 then
				arg_372_1.var_.moveOldPos1094 = var_375_12.localPosition
				var_375_12.localScale = Vector3.New(1, 1, 1)

				arg_372_1:CheckSpriteTmpPos("1094", 7)

				for iter_375_2 = 0, var_375_12.childCount - 1 do
					local var_375_13 = var_375_12:GetChild(iter_375_2)

					if var_375_13.name == "" or not string.find(var_375_13.name, "split") then
						var_375_13.gameObject:SetActive(true)
					else
						var_375_13.gameObject:SetActive(false)
					end
				end
			end

			local var_375_14 = 0.001

			if 1.966 <= arg_372_1.time_ and arg_372_1.time_ < 1.966 + var_375_14 then
				var_375_12.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_372_1.time_ - 1.966) / var_375_14)
			end

			if arg_372_1.time_ >= 1.966 + var_375_14 and arg_372_1.time_ < 1.966 + var_375_14 + arg_375_0 then
				var_375_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_372_1.frameCnt_ <= 1 then
				arg_372_1.dialog_:SetActive(false)
			end

			local var_375_15 = 4
			local var_375_16 = 1.425

			if 4 < arg_372_1.time_ and arg_372_1.time_ <= var_375_15 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0

				arg_372_1.dialog_:SetActive(true)

				arg_372_1.dialogCg_.alpha = 0

				local var_375_17 = LeanTween.value(arg_372_1.dialog_, 0, 1, 0.3)

				var_375_17:setOnUpdate(LuaHelper.FloatAction(function(arg_376_0)
					arg_372_1.dialogCg_.alpha = arg_376_0
				end))
				var_375_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_372_1.dialog_)
					var_375_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_372_1.duration_ = arg_372_1.duration_ + 0.3

				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_18 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(424081089).content)

				arg_372_1.text_.text = var_375_18

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_20 = 57 <= 0 and var_375_16 or var_375_16 * (utf8.len(var_375_18) / 57)

				if (57 <= 0 and var_375_16 or var_375_16 * (utf8.len(var_375_18) / 57)) > 0 and var_375_16 < var_375_20 then
					arg_372_1.talkMaxDuration = var_375_20
					var_375_15 = var_375_15 + 0.3

					if var_375_20 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_20 + var_375_15
					end
				end

				arg_372_1.text_.text = var_375_18
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_21 = var_375_15 + 0.3
			local var_375_22 = math.max(var_375_16, arg_372_1.talkMaxDuration)

			if var_375_15 + 0.3 <= arg_372_1.time_ and arg_372_1.time_ < var_375_21 + var_375_22 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_21) / var_375_22

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_21 + var_375_22 and arg_372_1.time_ < var_375_21 + var_375_22 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play424081090 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 424081090
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play424081091(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0.925

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_1 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(424081090).content)

				arg_378_1.text_.text = var_381_1

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_3 = 37 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_1) / 37)

				if (37 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_1) / 37)) > 0 and var_381_0 < var_381_3 then
					arg_378_1.talkMaxDuration = var_381_3

					if var_381_3 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_3 + 0
					end
				end

				arg_378_1.text_.text = var_381_1
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_4 = math.max(var_381_0, arg_378_1.talkMaxDuration)

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_4 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - 0) / var_381_4

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= 0 + var_381_4 and arg_378_1.time_ < 0 + var_381_4 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play424081091 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 424081091
		arg_382_1.duration_ = 6.27

		local var_382_0 = {
			zh = 5.7,
			ja = 6.266
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play424081092(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				local var_385_0 = arg_382_1.bgs_.SS2402

				arg_382_1.bgs_.SS2402.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_385_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_385_1 = var_385_0:GetComponent("SpriteRenderer")

				if var_385_1 and var_385_1.sprite then
					local var_385_2 = 2 * (var_385_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_385_0.transform.localScale = Vector3.New(var_385_2 / var_385_1.sprite.bounds.size.y < var_385_2 * manager.ui.mainCameraCom_.aspect / var_385_1.sprite.bounds.size.x and var_385_2 * manager.ui.mainCameraCom_.aspect / var_385_1.sprite.bounds.size.x or var_385_2 / var_385_1.sprite.bounds.size.y, var_385_2 / var_385_1.sprite.bounds.size.y < var_385_2 * manager.ui.mainCameraCom_.aspect / var_385_1.sprite.bounds.size.x and var_385_2 * manager.ui.mainCameraCom_.aspect / var_385_1.sprite.bounds.size.x or var_385_2 / var_385_1.sprite.bounds.size.y, 0)
				end

				for iter_385_0, iter_385_1 in pairs(arg_382_1.bgs_) do
					if iter_385_0 ~= "SS2402" then
						iter_385_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_385_3 = 2

			if 2 < arg_382_1.time_ and arg_382_1.time_ <= var_385_3 + arg_385_0 then
				arg_382_1.allBtn_.enabled = false
			end

			if arg_382_1.time_ >= var_385_3 + 0.3 and arg_382_1.time_ < var_385_3 + 0.3 + arg_385_0 then
				arg_382_1.allBtn_.enabled = true
			end

			local var_385_4 = 0

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_4 + arg_385_0 then
				arg_382_1.mask_.enabled = true
				arg_382_1.mask_.raycastTarget = true

				arg_382_1:SetGaussion(false)
			end

			local var_385_5 = 2

			if var_385_4 <= arg_382_1.time_ and arg_382_1.time_ < var_385_4 + var_385_5 then
				local var_385_6 = Color.New(0, 0, 0)

				var_385_6.a = Mathf.Lerp(1, 0, (arg_382_1.time_ - var_385_4) / var_385_5)
				arg_382_1.mask_.color = var_385_6
			end

			if arg_382_1.time_ >= var_385_4 + var_385_5 and arg_382_1.time_ < var_385_4 + var_385_5 + arg_385_0 then
				local var_385_7 = Color.New(0, 0, 0)

				arg_382_1.mask_.enabled = false
				var_385_7.a = 0
				arg_382_1.mask_.color = var_385_7
			end

			local var_385_8 = arg_382_1.bgs_.SS2402.transform

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPosSS2402 = var_385_8.localPosition
			end

			local var_385_9 = 2

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_9 then
				var_385_8.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPosSS2402, Vector3.New(-1.2, 0, 3.64), (arg_382_1.time_ - 0) / var_385_9)
			end

			if arg_382_1.time_ >= 0 + var_385_9 and arg_382_1.time_ < 0 + var_385_9 + arg_385_0 then
				var_385_8.localPosition = Vector3.New(-1.2, 0, 3.64)
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if 0.2 < arg_382_1.time_ and arg_382_1.time_ <= 0.2 + arg_385_0 then
				arg_382_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if arg_382_1.frameCnt_ <= 1 then
				arg_382_1.dialog_:SetActive(false)
			end

			local var_385_12 = 2
			local var_385_13 = 0.35

			if 2 < arg_382_1.time_ and arg_382_1.time_ <= var_385_12 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0

				arg_382_1.dialog_:SetActive(true)

				arg_382_1.dialogCg_.alpha = 0

				local var_385_14 = LeanTween.value(arg_382_1.dialog_, 0, 1, 0.3)

				var_385_14:setOnUpdate(LuaHelper.FloatAction(function(arg_386_0)
					arg_382_1.dialogCg_.alpha = arg_386_0
				end))
				var_385_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_382_1.dialog_)
					var_385_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_382_1.duration_ = arg_382_1.duration_ + 0.3

				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_15 = arg_382_1:GetWordFromCfg(424081091)
				local var_385_16 = arg_382_1:FormatText(var_385_15.content)

				arg_382_1.text_.text = var_385_16

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_18 = 14 <= 0 and var_385_13 or var_385_13 * (utf8.len(var_385_16) / 14)

				if (14 <= 0 and var_385_13 or var_385_13 * (utf8.len(var_385_16) / 14)) > 0 and var_385_13 < var_385_18 then
					arg_382_1.talkMaxDuration = var_385_18
					var_385_12 = var_385_12 + 0.3

					if var_385_18 + var_385_12 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_18 + var_385_12
					end
				end

				arg_382_1.text_.text = var_385_16
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081091", "story_v_out_424081.awb") ~= 0 then
					local var_385_19 = manager.audio:GetVoiceLength("story_v_out_424081", "424081091", "story_v_out_424081.awb") / 1000

					if var_385_19 + var_385_12 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_19 + var_385_12
					end

					if var_385_15.prefab_name ~= "" and arg_382_1.actors_[var_385_15.prefab_name] ~= nil then
						local var_385_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_15.prefab_name].transform, "story_v_out_424081", "424081091", "story_v_out_424081.awb")

						arg_382_1:RecordAudio("424081091", var_385_20)
						arg_382_1:RecordAudio("424081091", var_385_20)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_424081", "424081091", "story_v_out_424081.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_424081", "424081091", "story_v_out_424081.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_21 = var_385_12 + 0.3
			local var_385_22 = math.max(var_385_13, arg_382_1.talkMaxDuration)

			if var_385_12 + 0.3 <= arg_382_1.time_ and arg_382_1.time_ < var_385_21 + var_385_22 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_21) / var_385_22

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_21 + var_385_22 and arg_382_1.time_ < var_385_21 + var_385_22 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2402",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-1.2, 0.5, 3.64),
					endPos = Vector3.New(-1.2, 0, 3.64),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play424081092 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 424081092
		arg_388_1.duration_ = 5.3

		local var_388_0 = {
			zh = 4.333,
			ja = 5.3
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
				arg_388_0:Play424081093(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0.35

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_1 = arg_388_1:GetWordFromCfg(424081092)
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

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081092", "story_v_out_424081.awb") ~= 0 then
					local var_391_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081092", "story_v_out_424081.awb") / 1000

					if var_391_5 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_5 + 0
					end

					if var_391_1.prefab_name ~= "" and arg_388_1.actors_[var_391_1.prefab_name] ~= nil then
						local var_391_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_1.prefab_name].transform, "story_v_out_424081", "424081092", "story_v_out_424081.awb")

						arg_388_1:RecordAudio("424081092", var_391_6)
						arg_388_1:RecordAudio("424081092", var_391_6)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_424081", "424081092", "story_v_out_424081.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_424081", "424081092", "story_v_out_424081.awb")
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
	Play424081093 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 424081093
		arg_392_1.duration_ = 1

		local var_392_0 = {
			zh = 1,
			ja = 0.999999999999
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
				arg_392_0:Play424081094(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0.075

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_1 = arg_392_1:GetWordFromCfg(424081093)
				local var_395_2 = arg_392_1:FormatText(var_395_1.content)

				arg_392_1.text_.text = var_395_2

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_4 = 3 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_2) / 3)

				if (3 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_2) / 3)) > 0 and var_395_0 < var_395_4 then
					arg_392_1.talkMaxDuration = var_395_4

					if var_395_4 + 0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_4 + 0
					end
				end

				arg_392_1.text_.text = var_395_2
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081093", "story_v_out_424081.awb") ~= 0 then
					local var_395_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081093", "story_v_out_424081.awb") / 1000

					if var_395_5 + 0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_5 + 0
					end

					if var_395_1.prefab_name ~= "" and arg_392_1.actors_[var_395_1.prefab_name] ~= nil then
						local var_395_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_1.prefab_name].transform, "story_v_out_424081", "424081093", "story_v_out_424081.awb")

						arg_392_1:RecordAudio("424081093", var_395_6)
						arg_392_1:RecordAudio("424081093", var_395_6)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_424081", "424081093", "story_v_out_424081.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_424081", "424081093", "story_v_out_424081.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_7 = math.max(var_395_0, arg_392_1.talkMaxDuration)

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_7 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - 0) / var_395_7

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= 0 + var_395_7 and arg_392_1.time_ < 0 + var_395_7 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play424081094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 424081094
		arg_396_1.duration_ = 4.37

		local var_396_0 = {
			zh = 2.5,
			ja = 4.366
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
				arg_396_0:Play424081095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0.2

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_1 = arg_396_1:GetWordFromCfg(424081094)
				local var_399_2 = arg_396_1:FormatText(var_399_1.content)

				arg_396_1.text_.text = var_399_2

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_4 = 8 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_2) / 8)

				if (8 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_2) / 8)) > 0 and var_399_0 < var_399_4 then
					arg_396_1.talkMaxDuration = var_399_4

					if var_399_4 + 0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_4 + 0
					end
				end

				arg_396_1.text_.text = var_399_2
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081094", "story_v_out_424081.awb") ~= 0 then
					local var_399_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081094", "story_v_out_424081.awb") / 1000

					if var_399_5 + 0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_5 + 0
					end

					if var_399_1.prefab_name ~= "" and arg_396_1.actors_[var_399_1.prefab_name] ~= nil then
						local var_399_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_1.prefab_name].transform, "story_v_out_424081", "424081094", "story_v_out_424081.awb")

						arg_396_1:RecordAudio("424081094", var_399_6)
						arg_396_1:RecordAudio("424081094", var_399_6)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_424081", "424081094", "story_v_out_424081.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_424081", "424081094", "story_v_out_424081.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_7 = math.max(var_399_0, arg_396_1.talkMaxDuration)

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_7 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - 0) / var_399_7

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= 0 + var_399_7 and arg_396_1.time_ < 0 + var_399_7 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play424081095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 424081095
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play424081096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0.375

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_1 = arg_400_1:FormatText(arg_400_1:GetWordFromCfg(424081095).content)

				arg_400_1.text_.text = var_403_1

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_3 = 15 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 15)

				if (15 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 15)) > 0 and var_403_0 < var_403_3 then
					arg_400_1.talkMaxDuration = var_403_3

					if var_403_3 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_3 + 0
					end
				end

				arg_400_1.text_.text = var_403_1
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_4 = math.max(var_403_0, arg_400_1.talkMaxDuration)

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_4 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - 0) / var_403_4

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= 0 + var_403_4 and arg_400_1.time_ < 0 + var_403_4 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play424081096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 424081096
		arg_404_1.duration_ = 12.13

		local var_404_0 = {
			zh = 11.933,
			ja = 12.133
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
				arg_404_0:Play424081097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 1.125

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_1 = arg_404_1:GetWordFromCfg(424081096)
				local var_407_2 = arg_404_1:FormatText(var_407_1.content)

				arg_404_1.text_.text = var_407_2

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 45 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 45)

				if (45 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 45)) > 0 and var_407_0 < var_407_4 then
					arg_404_1.talkMaxDuration = var_407_4

					if var_407_4 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_4 + 0
					end
				end

				arg_404_1.text_.text = var_407_2
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081096", "story_v_out_424081.awb") ~= 0 then
					local var_407_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081096", "story_v_out_424081.awb") / 1000

					if var_407_5 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_5 + 0
					end

					if var_407_1.prefab_name ~= "" and arg_404_1.actors_[var_407_1.prefab_name] ~= nil then
						local var_407_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_1.prefab_name].transform, "story_v_out_424081", "424081096", "story_v_out_424081.awb")

						arg_404_1:RecordAudio("424081096", var_407_6)
						arg_404_1:RecordAudio("424081096", var_407_6)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_424081", "424081096", "story_v_out_424081.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_424081", "424081096", "story_v_out_424081.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_0, arg_404_1.talkMaxDuration)

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - 0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= 0 + var_407_7 and arg_404_1.time_ < 0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play424081097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 424081097
		arg_408_1.duration_ = 3.07

		local var_408_0 = {
			zh = 2.3,
			ja = 3.066
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play424081098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0.25

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_1 = arg_408_1:GetWordFromCfg(424081097)
				local var_411_2 = arg_408_1:FormatText(var_411_1.content)

				arg_408_1.text_.text = var_411_2

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 10 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 10)

				if (10 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 10)) > 0 and var_411_0 < var_411_4 then
					arg_408_1.talkMaxDuration = var_411_4

					if var_411_4 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_4 + 0
					end
				end

				arg_408_1.text_.text = var_411_2
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081097", "story_v_out_424081.awb") ~= 0 then
					local var_411_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081097", "story_v_out_424081.awb") / 1000

					if var_411_5 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_5 + 0
					end

					if var_411_1.prefab_name ~= "" and arg_408_1.actors_[var_411_1.prefab_name] ~= nil then
						local var_411_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_1.prefab_name].transform, "story_v_out_424081", "424081097", "story_v_out_424081.awb")

						arg_408_1:RecordAudio("424081097", var_411_6)
						arg_408_1:RecordAudio("424081097", var_411_6)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_424081", "424081097", "story_v_out_424081.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_424081", "424081097", "story_v_out_424081.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_7 and arg_408_1.time_ < 0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play424081098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 424081098
		arg_412_1.duration_ = 3.2

		local var_412_0 = {
			zh = 2.7,
			ja = 3.2
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play424081099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0.225

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[1404].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_1 = arg_412_1:GetWordFromCfg(424081098)
				local var_415_2 = arg_412_1:FormatText(var_415_1.content)

				arg_412_1.text_.text = var_415_2

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_4 = 9 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 9)

				if (9 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 9)) > 0 and var_415_0 < var_415_4 then
					arg_412_1.talkMaxDuration = var_415_4

					if var_415_4 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_4 + 0
					end
				end

				arg_412_1.text_.text = var_415_2
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081098", "story_v_out_424081.awb") ~= 0 then
					local var_415_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081098", "story_v_out_424081.awb") / 1000

					if var_415_5 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_5 + 0
					end

					if var_415_1.prefab_name ~= "" and arg_412_1.actors_[var_415_1.prefab_name] ~= nil then
						local var_415_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_1.prefab_name].transform, "story_v_out_424081", "424081098", "story_v_out_424081.awb")

						arg_412_1:RecordAudio("424081098", var_415_6)
						arg_412_1:RecordAudio("424081098", var_415_6)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_424081", "424081098", "story_v_out_424081.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_424081", "424081098", "story_v_out_424081.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_7 = math.max(var_415_0, arg_412_1.talkMaxDuration)

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_7 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - 0) / var_415_7

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= 0 + var_415_7 and arg_412_1.time_ < 0 + var_415_7 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play424081099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 424081099
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play424081100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0.375

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_1 = arg_416_1:FormatText(arg_416_1:GetWordFromCfg(424081099).content)

				arg_416_1.text_.text = var_419_1

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_3 = 15 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 15)

				if (15 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 15)) > 0 and var_419_0 < var_419_3 then
					arg_416_1.talkMaxDuration = var_419_3

					if var_419_3 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_3 + 0
					end
				end

				arg_416_1.text_.text = var_419_1
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_4 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_4 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_4

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_4 and arg_416_1.time_ < 0 + var_419_4 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play424081100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 424081100
		arg_420_1.duration_ = 5.87

		local var_420_0 = {
			zh = 5.733,
			ja = 5.866
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play424081101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if arg_420_1.bgs_.SS2402b == nil then
				local var_423_0 = Object.Instantiate(arg_420_1.paintGo_)

				var_423_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2402b")
				var_423_0.name = "SS2402b"
				var_423_0.transform.parent = arg_420_1.stage_.transform
				var_423_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_420_1.bgs_.SS2402b = var_423_0
			end

			if 2 < arg_420_1.time_ and arg_420_1.time_ <= 2 + arg_423_0 then
				local var_423_1 = arg_420_1.bgs_.SS2402b

				arg_420_1.bgs_.SS2402b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_423_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_423_2 = var_423_1:GetComponent("SpriteRenderer")

				if var_423_2 and var_423_2.sprite then
					local var_423_3 = 2 * (var_423_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_423_1.transform.localScale = Vector3.New(var_423_3 / var_423_2.sprite.bounds.size.y < var_423_3 * manager.ui.mainCameraCom_.aspect / var_423_2.sprite.bounds.size.x and var_423_3 * manager.ui.mainCameraCom_.aspect / var_423_2.sprite.bounds.size.x or var_423_3 / var_423_2.sprite.bounds.size.y, var_423_3 / var_423_2.sprite.bounds.size.y < var_423_3 * manager.ui.mainCameraCom_.aspect / var_423_2.sprite.bounds.size.x and var_423_3 * manager.ui.mainCameraCom_.aspect / var_423_2.sprite.bounds.size.x or var_423_3 / var_423_2.sprite.bounds.size.y, 0)
				end

				for iter_423_0, iter_423_1 in pairs(arg_420_1.bgs_) do
					if iter_423_0 ~= "SS2402b" then
						iter_423_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_423_4 = 4

			if 4 < arg_420_1.time_ and arg_420_1.time_ <= var_423_4 + arg_423_0 then
				arg_420_1.allBtn_.enabled = false
			end

			if arg_420_1.time_ >= var_423_4 + 0.3 and arg_420_1.time_ < var_423_4 + 0.3 + arg_423_0 then
				arg_420_1.allBtn_.enabled = true
			end

			local var_423_5 = 0

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_5 + arg_423_0 then
				arg_420_1.mask_.enabled = true
				arg_420_1.mask_.raycastTarget = true

				arg_420_1:SetGaussion(false)
			end

			local var_423_6 = 2

			if var_423_5 <= arg_420_1.time_ and arg_420_1.time_ < var_423_5 + var_423_6 then
				local var_423_7 = Color.New(0, 0, 0)

				var_423_7.a = Mathf.Lerp(0, 1, (arg_420_1.time_ - var_423_5) / var_423_6)
				arg_420_1.mask_.color = var_423_7
			end

			if arg_420_1.time_ >= var_423_5 + var_423_6 and arg_420_1.time_ < var_423_5 + var_423_6 + arg_423_0 then
				local var_423_8 = Color.New(0, 0, 0)

				var_423_8.a = 1
				arg_420_1.mask_.color = var_423_8
			end

			local var_423_9 = 2

			if 2 < arg_420_1.time_ and arg_420_1.time_ <= var_423_9 + arg_423_0 then
				arg_420_1.mask_.enabled = true
				arg_420_1.mask_.raycastTarget = true

				arg_420_1:SetGaussion(false)
			end

			local var_423_10 = 2

			if var_423_9 <= arg_420_1.time_ and arg_420_1.time_ < var_423_9 + var_423_10 then
				local var_423_11 = Color.New(0, 0, 0)

				var_423_11.a = Mathf.Lerp(1, 0, (arg_420_1.time_ - var_423_9) / var_423_10)
				arg_420_1.mask_.color = var_423_11
			end

			if arg_420_1.time_ >= var_423_9 + var_423_10 and arg_420_1.time_ < var_423_9 + var_423_10 + arg_423_0 then
				local var_423_12 = Color.New(0, 0, 0)

				arg_420_1.mask_.enabled = false
				var_423_12.a = 0
				arg_420_1.mask_.color = var_423_12
			end

			local var_423_13 = arg_420_1.bgs_.SS2402b.transform

			if 2 < arg_420_1.time_ and arg_420_1.time_ <= 2 + arg_423_0 then
				arg_420_1.var_.moveOldPosSS2402b = var_423_13.localPosition
			end

			local var_423_14 = 2

			if 2 <= arg_420_1.time_ and arg_420_1.time_ < 2 + var_423_14 then
				var_423_13.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPosSS2402b, Vector3.New(-1.44, -0.5, 2.66), (arg_420_1.time_ - 2) / var_423_14)
			end

			if arg_420_1.time_ >= 2 + var_423_14 and arg_420_1.time_ < 2 + var_423_14 + arg_423_0 then
				var_423_13.localPosition = Vector3.New(-1.44, -0.5, 2.66)
			end

			if arg_420_1.frameCnt_ <= 1 then
				arg_420_1.dialog_:SetActive(false)
			end

			local var_423_15 = 4
			local var_423_16 = 0.175

			if 4 < arg_420_1.time_ and arg_420_1.time_ <= var_423_15 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0

				arg_420_1.dialog_:SetActive(true)

				arg_420_1.dialogCg_.alpha = 0

				local var_423_17 = LeanTween.value(arg_420_1.dialog_, 0, 1, 0.3)

				var_423_17:setOnUpdate(LuaHelper.FloatAction(function(arg_424_0)
					arg_420_1.dialogCg_.alpha = arg_424_0
				end))
				var_423_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_420_1.dialog_)
					var_423_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_420_1.duration_ = arg_420_1.duration_ + 0.3

				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_18 = arg_420_1:GetWordFromCfg(424081100)
				local var_423_19 = arg_420_1:FormatText(var_423_18.content)

				arg_420_1.text_.text = var_423_19

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_21 = 7 <= 0 and var_423_16 or var_423_16 * (utf8.len(var_423_19) / 7)

				if (7 <= 0 and var_423_16 or var_423_16 * (utf8.len(var_423_19) / 7)) > 0 and var_423_16 < var_423_21 then
					arg_420_1.talkMaxDuration = var_423_21
					var_423_15 = var_423_15 + 0.3

					if var_423_21 + var_423_15 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_21 + var_423_15
					end
				end

				arg_420_1.text_.text = var_423_19
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081100", "story_v_out_424081.awb") ~= 0 then
					local var_423_22 = manager.audio:GetVoiceLength("story_v_out_424081", "424081100", "story_v_out_424081.awb") / 1000

					if var_423_22 + var_423_15 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_22 + var_423_15
					end

					if var_423_18.prefab_name ~= "" and arg_420_1.actors_[var_423_18.prefab_name] ~= nil then
						local var_423_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_18.prefab_name].transform, "story_v_out_424081", "424081100", "story_v_out_424081.awb")

						arg_420_1:RecordAudio("424081100", var_423_23)
						arg_420_1:RecordAudio("424081100", var_423_23)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_424081", "424081100", "story_v_out_424081.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_424081", "424081100", "story_v_out_424081.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_24 = var_423_15 + 0.3
			local var_423_25 = math.max(var_423_16, arg_420_1.talkMaxDuration)

			if var_423_15 + 0.3 <= arg_420_1.time_ and arg_420_1.time_ < var_423_24 + var_423_25 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_24) / var_423_25

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_24 + var_423_25 and arg_420_1.time_ < var_423_24 + var_423_25 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2402b",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-1.44, -0.5, 3),
					endPos = Vector3.New(-1.44, -0.5, 2.66),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play424081101 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 424081101
		arg_426_1.duration_ = 4.97

		local var_426_0 = {
			zh = 4.966,
			ja = 4.4
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
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play424081102(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.allBtn_.enabled = false
			end

			if arg_426_1.time_ >= 0 + 0.5 and arg_426_1.time_ < 0 + 0.5 + arg_429_0 then
				arg_426_1.allBtn_.enabled = true
			end

			local var_429_0 = 0
			local var_429_1 = 0.425

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[1406].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_2 = arg_426_1:GetWordFromCfg(424081101)
				local var_429_3 = arg_426_1:FormatText(var_429_2.content)

				arg_426_1.text_.text = var_429_3

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 17 <= 0 and var_429_1 or var_429_1 * (utf8.len(var_429_3) / 17)

				if (17 <= 0 and var_429_1 or var_429_1 * (utf8.len(var_429_3) / 17)) > 0 and var_429_1 < var_429_5 then
					arg_426_1.talkMaxDuration = var_429_5

					if var_429_5 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_5 + var_429_0
					end
				end

				arg_426_1.text_.text = var_429_3
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081101", "story_v_out_424081.awb") ~= 0 then
					local var_429_6 = manager.audio:GetVoiceLength("story_v_out_424081", "424081101", "story_v_out_424081.awb") / 1000

					if var_429_6 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_6 + var_429_0
					end

					if var_429_2.prefab_name ~= "" and arg_426_1.actors_[var_429_2.prefab_name] ~= nil then
						local var_429_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_2.prefab_name].transform, "story_v_out_424081", "424081101", "story_v_out_424081.awb")

						arg_426_1:RecordAudio("424081101", var_429_7)
						arg_426_1:RecordAudio("424081101", var_429_7)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_424081", "424081101", "story_v_out_424081.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_424081", "424081101", "story_v_out_424081.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_8 = math.max(var_429_1, arg_426_1.talkMaxDuration)

			if var_429_0 <= arg_426_1.time_ and arg_426_1.time_ < var_429_0 + var_429_8 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_0) / var_429_8

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_0 + var_429_8 and arg_426_1.time_ < var_429_0 + var_429_8 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 12,
				className = "StoryShakeNode",
				duration = 0.3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(0.1, 0.1, 0.1)
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play424081102 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 424081102
		arg_430_1.duration_ = 5.3

		local var_430_0 = {
			zh = 5.066,
			ja = 5.3
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play424081103(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0.575

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[1404].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_1 = arg_430_1:GetWordFromCfg(424081102)
				local var_433_2 = arg_430_1:FormatText(var_433_1.content)

				arg_430_1.text_.text = var_433_2

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_4 = 23 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_2) / 23)

				if (23 <= 0 and var_433_0 or var_433_0 * (utf8.len(var_433_2) / 23)) > 0 and var_433_0 < var_433_4 then
					arg_430_1.talkMaxDuration = var_433_4

					if var_433_4 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_4 + 0
					end
				end

				arg_430_1.text_.text = var_433_2
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081102", "story_v_out_424081.awb") ~= 0 then
					local var_433_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081102", "story_v_out_424081.awb") / 1000

					if var_433_5 + 0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_5 + 0
					end

					if var_433_1.prefab_name ~= "" and arg_430_1.actors_[var_433_1.prefab_name] ~= nil then
						local var_433_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_1.prefab_name].transform, "story_v_out_424081", "424081102", "story_v_out_424081.awb")

						arg_430_1:RecordAudio("424081102", var_433_6)
						arg_430_1:RecordAudio("424081102", var_433_6)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_424081", "424081102", "story_v_out_424081.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_424081", "424081102", "story_v_out_424081.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_7 = math.max(var_433_0, arg_430_1.talkMaxDuration)

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_7 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - 0) / var_433_7

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= 0 + var_433_7 and arg_430_1.time_ < 0 + var_433_7 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play424081103 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 424081103
		arg_434_1.duration_ = 6.5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play424081104(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 1 < arg_434_1.time_ and arg_434_1.time_ <= 1 + arg_437_0 then
				local var_437_0 = arg_434_1.bgs_.SS2402b

				arg_434_1.bgs_.SS2402b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_437_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_437_1 = var_437_0:GetComponent("SpriteRenderer")

				if var_437_1 and var_437_1.sprite then
					local var_437_2 = 2 * (var_437_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_437_0.transform.localScale = Vector3.New(var_437_2 / var_437_1.sprite.bounds.size.y < var_437_2 * manager.ui.mainCameraCom_.aspect / var_437_1.sprite.bounds.size.x and var_437_2 * manager.ui.mainCameraCom_.aspect / var_437_1.sprite.bounds.size.x or var_437_2 / var_437_1.sprite.bounds.size.y, var_437_2 / var_437_1.sprite.bounds.size.y < var_437_2 * manager.ui.mainCameraCom_.aspect / var_437_1.sprite.bounds.size.x and var_437_2 * manager.ui.mainCameraCom_.aspect / var_437_1.sprite.bounds.size.x or var_437_2 / var_437_1.sprite.bounds.size.y, 0)
				end

				for iter_437_0, iter_437_1 in pairs(arg_434_1.bgs_) do
					if iter_437_0 ~= "SS2402b" then
						iter_437_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_437_3 = 0

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_3 + arg_437_0 then
				arg_434_1.mask_.enabled = true
				arg_434_1.mask_.raycastTarget = true

				arg_434_1:SetGaussion(false)
			end

			local var_437_4 = 1

			if var_437_3 <= arg_434_1.time_ and arg_434_1.time_ < var_437_3 + var_437_4 then
				local var_437_5 = Color.New(0, 0, 0)

				var_437_5.a = Mathf.Lerp(0, 1, (arg_434_1.time_ - var_437_3) / var_437_4)
				arg_434_1.mask_.color = var_437_5
			end

			if arg_434_1.time_ >= var_437_3 + var_437_4 and arg_434_1.time_ < var_437_3 + var_437_4 + arg_437_0 then
				local var_437_6 = Color.New(0, 0, 0)

				var_437_6.a = 1
				arg_434_1.mask_.color = var_437_6
			end

			local var_437_7 = 1

			if 1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_7 + arg_437_0 then
				arg_434_1.mask_.enabled = true
				arg_434_1.mask_.raycastTarget = true

				arg_434_1:SetGaussion(false)
			end

			local var_437_8 = 1

			if var_437_7 <= arg_434_1.time_ and arg_434_1.time_ < var_437_7 + var_437_8 then
				local var_437_9 = Color.New(0, 0, 0)

				var_437_9.a = Mathf.Lerp(1, 0, (arg_434_1.time_ - var_437_7) / var_437_8)
				arg_434_1.mask_.color = var_437_9
			end

			if arg_434_1.time_ >= var_437_7 + var_437_8 and arg_434_1.time_ < var_437_7 + var_437_8 + arg_437_0 then
				local var_437_10 = Color.New(0, 0, 0)

				arg_434_1.mask_.enabled = false
				var_437_10.a = 0
				arg_434_1.mask_.color = var_437_10
			end

			if arg_434_1.frameCnt_ <= 1 then
				arg_434_1.dialog_:SetActive(false)
			end

			local var_437_11 = 1.499999999999
			local var_437_12 = 1.5

			if 1.499999999999 < arg_434_1.time_ and arg_434_1.time_ <= var_437_11 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0

				arg_434_1.dialog_:SetActive(true)

				arg_434_1.dialogCg_.alpha = 0

				local var_437_13 = LeanTween.value(arg_434_1.dialog_, 0, 1, 0.3)

				var_437_13:setOnUpdate(LuaHelper.FloatAction(function(arg_438_0)
					arg_434_1.dialogCg_.alpha = arg_438_0
				end))
				var_437_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_434_1.dialog_)
					var_437_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_434_1.duration_ = arg_434_1.duration_ + 0.3

				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_14 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(424081103).content)

				arg_434_1.text_.text = var_437_14

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_16 = 60 <= 0 and var_437_12 or var_437_12 * (utf8.len(var_437_14) / 60)

				if (60 <= 0 and var_437_12 or var_437_12 * (utf8.len(var_437_14) / 60)) > 0 and var_437_12 < var_437_16 then
					arg_434_1.talkMaxDuration = var_437_16
					var_437_11 = var_437_11 + 0.3

					if var_437_16 + var_437_11 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_16 + var_437_11
					end
				end

				arg_434_1.text_.text = var_437_14
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_17 = var_437_11 + 0.3
			local var_437_18 = math.max(var_437_12, arg_434_1.talkMaxDuration)

			if var_437_11 + 0.3 <= arg_434_1.time_ and arg_434_1.time_ < var_437_17 + var_437_18 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_17) / var_437_18

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_17 + var_437_18 and arg_434_1.time_ < var_437_17 + var_437_18 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play424081104 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 424081104
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play424081105(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0.225

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_1 = arg_440_1:FormatText(arg_440_1:GetWordFromCfg(424081104).content)

				arg_440_1.text_.text = var_443_1

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_3 = 9 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_1) / 9)

				if (9 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_1) / 9)) > 0 and var_443_0 < var_443_3 then
					arg_440_1.talkMaxDuration = var_443_3

					if var_443_3 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_3 + 0
					end
				end

				arg_440_1.text_.text = var_443_1
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_4 = math.max(var_443_0, arg_440_1.talkMaxDuration)

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_4 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - 0) / var_443_4

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= 0 + var_443_4 and arg_440_1.time_ < 0 + var_443_4 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play424081105 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 424081105
		arg_444_1.duration_ = 5.07

		local var_444_0 = {
			zh = 4.2,
			ja = 5.066
		}
		local var_444_1 = manager.audio:GetLocalizationFlag()

		if var_444_0[var_444_1] ~= nil then
			arg_444_1.duration_ = var_444_0[var_444_1]
		end

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play424081106(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0.425

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_1 = arg_444_1:GetWordFromCfg(424081105)
				local var_447_2 = arg_444_1:FormatText(var_447_1.content)

				arg_444_1.text_.text = var_447_2

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_4 = 17 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_2) / 17)

				if (17 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_2) / 17)) > 0 and var_447_0 < var_447_4 then
					arg_444_1.talkMaxDuration = var_447_4

					if var_447_4 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_4 + 0
					end
				end

				arg_444_1.text_.text = var_447_2
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081105", "story_v_out_424081.awb") ~= 0 then
					local var_447_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081105", "story_v_out_424081.awb") / 1000

					if var_447_5 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_5 + 0
					end

					if var_447_1.prefab_name ~= "" and arg_444_1.actors_[var_447_1.prefab_name] ~= nil then
						local var_447_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_1.prefab_name].transform, "story_v_out_424081", "424081105", "story_v_out_424081.awb")

						arg_444_1:RecordAudio("424081105", var_447_6)
						arg_444_1:RecordAudio("424081105", var_447_6)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_424081", "424081105", "story_v_out_424081.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_424081", "424081105", "story_v_out_424081.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_7 = math.max(var_447_0, arg_444_1.talkMaxDuration)

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_7 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - 0) / var_447_7

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= 0 + var_447_7 and arg_444_1.time_ < 0 + var_447_7 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play424081106 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 424081106
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play424081107(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0.1

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_1 = arg_448_1:FormatText(arg_448_1:GetWordFromCfg(424081106).content)

				arg_448_1.text_.text = var_451_1

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_3 = 4 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_1) / 4)

				if (4 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_1) / 4)) > 0 and var_451_0 < var_451_3 then
					arg_448_1.talkMaxDuration = var_451_3

					if var_451_3 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_3 + 0
					end
				end

				arg_448_1.text_.text = var_451_1
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_4 = math.max(var_451_0, arg_448_1.talkMaxDuration)

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_4 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - 0) / var_451_4

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= 0 + var_451_4 and arg_448_1.time_ < 0 + var_451_4 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play424081107 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 424081107
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play424081108(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0.333333333333333 < arg_452_1.time_ and arg_452_1.time_ <= 0.333333333333333 + arg_455_0 then
				arg_452_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_clap", "")
			end

			local var_455_1 = 0
			local var_455_2 = 0.8

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_3 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(424081107).content)

				arg_452_1.text_.text = var_455_3

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 32 <= 0 and var_455_2 or var_455_2 * (utf8.len(var_455_3) / 32)

				if (32 <= 0 and var_455_2 or var_455_2 * (utf8.len(var_455_3) / 32)) > 0 and var_455_2 < var_455_5 then
					arg_452_1.talkMaxDuration = var_455_5

					if var_455_5 + var_455_1 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_5 + var_455_1
					end
				end

				arg_452_1.text_.text = var_455_3
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_6 = math.max(var_455_2, arg_452_1.talkMaxDuration)

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_6 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_1) / var_455_6

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_1 + var_455_6 and arg_452_1.time_ < var_455_1 + var_455_6 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play424081108 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 424081108
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play424081109(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0.375

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, true)
				arg_456_1.iconController_:SetSelectedState("hero")

				arg_456_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_456_1.callingController_:SetSelectedState("normal")

				arg_456_1.keyicon_.color = Color.New(1, 1, 1)
				arg_456_1.icon_.color = Color.New(1, 1, 1)

				local var_459_1 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(424081108).content)

				arg_456_1.text_.text = var_459_1

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_3 = 15 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_1) / 15)

				if (15 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_1) / 15)) > 0 and var_459_0 < var_459_3 then
					arg_456_1.talkMaxDuration = var_459_3

					if var_459_3 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_3 + 0
					end
				end

				arg_456_1.text_.text = var_459_1
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_4 = math.max(var_459_0, arg_456_1.talkMaxDuration)

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_4 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - 0) / var_459_4

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= 0 + var_459_4 and arg_456_1.time_ < 0 + var_459_4 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play424081109 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 424081109
		arg_460_1.duration_ = 6.1

		local var_460_0 = {
			zh = 6.1,
			ja = 4.733
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play424081110(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0.6

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_1 = arg_460_1:GetWordFromCfg(424081109)
				local var_463_2 = arg_460_1:FormatText(var_463_1.content)

				arg_460_1.text_.text = var_463_2

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_4 = 24 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_2) / 24)

				if (24 <= 0 and var_463_0 or var_463_0 * (utf8.len(var_463_2) / 24)) > 0 and var_463_0 < var_463_4 then
					arg_460_1.talkMaxDuration = var_463_4

					if var_463_4 + 0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_4 + 0
					end
				end

				arg_460_1.text_.text = var_463_2
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081109", "story_v_out_424081.awb") ~= 0 then
					local var_463_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081109", "story_v_out_424081.awb") / 1000

					if var_463_5 + 0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_5 + 0
					end

					if var_463_1.prefab_name ~= "" and arg_460_1.actors_[var_463_1.prefab_name] ~= nil then
						local var_463_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_1.prefab_name].transform, "story_v_out_424081", "424081109", "story_v_out_424081.awb")

						arg_460_1:RecordAudio("424081109", var_463_6)
						arg_460_1:RecordAudio("424081109", var_463_6)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_424081", "424081109", "story_v_out_424081.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_424081", "424081109", "story_v_out_424081.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_7 = math.max(var_463_0, arg_460_1.talkMaxDuration)

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_7 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - 0) / var_463_7

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= 0 + var_463_7 and arg_460_1.time_ < 0 + var_463_7 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play424081110 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 424081110
		arg_464_1.duration_ = 2.63

		local var_464_0 = {
			zh = 2.533,
			ja = 2.633
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play424081111(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0.125

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[1407].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowstudentwa")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_1 = arg_464_1:GetWordFromCfg(424081110)
				local var_467_2 = arg_464_1:FormatText(var_467_1.content)

				arg_464_1.text_.text = var_467_2

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_4 = 5 <= 0 and var_467_0 or var_467_0 * (utf8.len(var_467_2) / 5)

				if (5 <= 0 and var_467_0 or var_467_0 * (utf8.len(var_467_2) / 5)) > 0 and var_467_0 < var_467_4 then
					arg_464_1.talkMaxDuration = var_467_4

					if var_467_4 + 0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_4 + 0
					end
				end

				arg_464_1.text_.text = var_467_2
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081110", "story_v_out_424081.awb") ~= 0 then
					local var_467_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081110", "story_v_out_424081.awb") / 1000

					if var_467_5 + 0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_5 + 0
					end

					if var_467_1.prefab_name ~= "" and arg_464_1.actors_[var_467_1.prefab_name] ~= nil then
						local var_467_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_1.prefab_name].transform, "story_v_out_424081", "424081110", "story_v_out_424081.awb")

						arg_464_1:RecordAudio("424081110", var_467_6)
						arg_464_1:RecordAudio("424081110", var_467_6)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_424081", "424081110", "story_v_out_424081.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_424081", "424081110", "story_v_out_424081.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_7 = math.max(var_467_0, arg_464_1.talkMaxDuration)

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_7 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - 0) / var_467_7

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= 0 + var_467_7 and arg_464_1.time_ < 0 + var_467_7 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play424081111 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 424081111
		arg_468_1.duration_ = 10.1

		local var_468_0 = {
			zh = 5,
			ja = 10.1
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play424081112(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0.525

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_1 = arg_468_1:GetWordFromCfg(424081111)
				local var_471_2 = arg_468_1:FormatText(var_471_1.content)

				arg_468_1.text_.text = var_471_2

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_4 = 21 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_2) / 21)

				if (21 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_2) / 21)) > 0 and var_471_0 < var_471_4 then
					arg_468_1.talkMaxDuration = var_471_4

					if var_471_4 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_4 + 0
					end
				end

				arg_468_1.text_.text = var_471_2
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081111", "story_v_out_424081.awb") ~= 0 then
					local var_471_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081111", "story_v_out_424081.awb") / 1000

					if var_471_5 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_5 + 0
					end

					if var_471_1.prefab_name ~= "" and arg_468_1.actors_[var_471_1.prefab_name] ~= nil then
						local var_471_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_1.prefab_name].transform, "story_v_out_424081", "424081111", "story_v_out_424081.awb")

						arg_468_1:RecordAudio("424081111", var_471_6)
						arg_468_1:RecordAudio("424081111", var_471_6)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_out_424081", "424081111", "story_v_out_424081.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_out_424081", "424081111", "story_v_out_424081.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_7 = math.max(var_471_0, arg_468_1.talkMaxDuration)

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_7 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - 0) / var_471_7

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= 0 + var_471_7 and arg_468_1.time_ < 0 + var_471_7 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play424081112 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 424081112
		arg_472_1.duration_ = 13.77

		local var_472_0 = {
			zh = 9.8,
			ja = 13.766
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play424081113(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0.9

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_1 = arg_472_1:GetWordFromCfg(424081112)
				local var_475_2 = arg_472_1:FormatText(var_475_1.content)

				arg_472_1.text_.text = var_475_2

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_4 = 36 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_2) / 36)

				if (36 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_2) / 36)) > 0 and var_475_0 < var_475_4 then
					arg_472_1.talkMaxDuration = var_475_4

					if var_475_4 + 0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_4 + 0
					end
				end

				arg_472_1.text_.text = var_475_2
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081112", "story_v_out_424081.awb") ~= 0 then
					local var_475_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081112", "story_v_out_424081.awb") / 1000

					if var_475_5 + 0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_5 + 0
					end

					if var_475_1.prefab_name ~= "" and arg_472_1.actors_[var_475_1.prefab_name] ~= nil then
						local var_475_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_1.prefab_name].transform, "story_v_out_424081", "424081112", "story_v_out_424081.awb")

						arg_472_1:RecordAudio("424081112", var_475_6)
						arg_472_1:RecordAudio("424081112", var_475_6)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_424081", "424081112", "story_v_out_424081.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_424081", "424081112", "story_v_out_424081.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_7 = math.max(var_475_0, arg_472_1.talkMaxDuration)

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_7 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - 0) / var_475_7

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= 0 + var_475_7 and arg_472_1.time_ < 0 + var_475_7 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play424081113 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 424081113
		arg_476_1.duration_ = 3.33

		local var_476_0 = {
			zh = 3.266,
			ja = 3.333
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play424081114(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0.325

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_1 = arg_476_1:GetWordFromCfg(424081113)
				local var_479_2 = arg_476_1:FormatText(var_479_1.content)

				arg_476_1.text_.text = var_479_2

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_4 = 13 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_2) / 13)

				if (13 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_2) / 13)) > 0 and var_479_0 < var_479_4 then
					arg_476_1.talkMaxDuration = var_479_4

					if var_479_4 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_4 + 0
					end
				end

				arg_476_1.text_.text = var_479_2
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081113", "story_v_out_424081.awb") ~= 0 then
					local var_479_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081113", "story_v_out_424081.awb") / 1000

					if var_479_5 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_5 + 0
					end

					if var_479_1.prefab_name ~= "" and arg_476_1.actors_[var_479_1.prefab_name] ~= nil then
						local var_479_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_1.prefab_name].transform, "story_v_out_424081", "424081113", "story_v_out_424081.awb")

						arg_476_1:RecordAudio("424081113", var_479_6)
						arg_476_1:RecordAudio("424081113", var_479_6)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_out_424081", "424081113", "story_v_out_424081.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_out_424081", "424081113", "story_v_out_424081.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_7 = math.max(var_479_0, arg_476_1.talkMaxDuration)

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_7 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - 0) / var_479_7

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= 0 + var_479_7 and arg_476_1.time_ < 0 + var_479_7 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play424081114 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 424081114
		arg_480_1.duration_ = 1.07

		local var_480_0 = {
			zh = 0.999999999999,
			ja = 1.066
		}
		local var_480_1 = manager.audio:GetLocalizationFlag()

		if var_480_0[var_480_1] ~= nil then
			arg_480_1.duration_ = var_480_0[var_480_1]
		end

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play424081115(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = 0.05

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_1 = arg_480_1:GetWordFromCfg(424081114)
				local var_483_2 = arg_480_1:FormatText(var_483_1.content)

				arg_480_1.text_.text = var_483_2

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_4 = 2 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_2) / 2)

				if (2 <= 0 and var_483_0 or var_483_0 * (utf8.len(var_483_2) / 2)) > 0 and var_483_0 < var_483_4 then
					arg_480_1.talkMaxDuration = var_483_4

					if var_483_4 + 0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_4 + 0
					end
				end

				arg_480_1.text_.text = var_483_2
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081114", "story_v_out_424081.awb") ~= 0 then
					local var_483_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081114", "story_v_out_424081.awb") / 1000

					if var_483_5 + 0 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_5 + 0
					end

					if var_483_1.prefab_name ~= "" and arg_480_1.actors_[var_483_1.prefab_name] ~= nil then
						local var_483_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_1.prefab_name].transform, "story_v_out_424081", "424081114", "story_v_out_424081.awb")

						arg_480_1:RecordAudio("424081114", var_483_6)
						arg_480_1:RecordAudio("424081114", var_483_6)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_424081", "424081114", "story_v_out_424081.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_424081", "424081114", "story_v_out_424081.awb")
				end

				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_7 = math.max(var_483_0, arg_480_1.talkMaxDuration)

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_7 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - 0) / var_483_7

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= 0 + var_483_7 and arg_480_1.time_ < 0 + var_483_7 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play424081115 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 424081115
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play424081116(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0.975

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, false)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_1 = arg_484_1:FormatText(arg_484_1:GetWordFromCfg(424081115).content)

				arg_484_1.text_.text = var_487_1

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_3 = 39 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_1) / 39)

				if (39 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_1) / 39)) > 0 and var_487_0 < var_487_3 then
					arg_484_1.talkMaxDuration = var_487_3

					if var_487_3 + 0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_3 + 0
					end
				end

				arg_484_1.text_.text = var_487_1
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_4 = math.max(var_487_0, arg_484_1.talkMaxDuration)

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_4 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - 0) / var_487_4

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= 0 + var_487_4 and arg_484_1.time_ < 0 + var_487_4 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play424081116 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 424081116
		arg_488_1.duration_ = 15.6

		local var_488_0 = {
			zh = 13.8,
			ja = 15.6
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play424081117(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 1.35

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[1394].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, true)
				arg_488_1.iconController_:SetSelectedState("hero")

				arg_488_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolib")

				arg_488_1.callingController_:SetSelectedState("normal")

				arg_488_1.keyicon_.color = Color.New(1, 1, 1)
				arg_488_1.icon_.color = Color.New(1, 1, 1)

				local var_491_1 = arg_488_1:GetWordFromCfg(424081116)
				local var_491_2 = arg_488_1:FormatText(var_491_1.content)

				arg_488_1.text_.text = var_491_2

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_4 = 54 <= 0 and var_491_0 or var_491_0 * (utf8.len(var_491_2) / 54)

				if (54 <= 0 and var_491_0 or var_491_0 * (utf8.len(var_491_2) / 54)) > 0 and var_491_0 < var_491_4 then
					arg_488_1.talkMaxDuration = var_491_4

					if var_491_4 + 0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_4 + 0
					end
				end

				arg_488_1.text_.text = var_491_2
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081116", "story_v_out_424081.awb") ~= 0 then
					local var_491_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081116", "story_v_out_424081.awb") / 1000

					if var_491_5 + 0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_5 + 0
					end

					if var_491_1.prefab_name ~= "" and arg_488_1.actors_[var_491_1.prefab_name] ~= nil then
						local var_491_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_1.prefab_name].transform, "story_v_out_424081", "424081116", "story_v_out_424081.awb")

						arg_488_1:RecordAudio("424081116", var_491_6)
						arg_488_1:RecordAudio("424081116", var_491_6)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_424081", "424081116", "story_v_out_424081.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_424081", "424081116", "story_v_out_424081.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_7 = math.max(var_491_0, arg_488_1.talkMaxDuration)

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_7 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - 0) / var_491_7

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= 0 + var_491_7 and arg_488_1.time_ < 0 + var_491_7 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play424081117 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 424081117
		arg_492_1.duration_ = 10.2

		local var_492_0 = {
			zh = 10.2,
			ja = 9.233
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play424081118(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = 0.85

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_1 = arg_492_1:GetWordFromCfg(424081117)
				local var_495_2 = arg_492_1:FormatText(var_495_1.content)

				arg_492_1.text_.text = var_495_2

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_4 = 34 <= 0 and var_495_0 or var_495_0 * (utf8.len(var_495_2) / 34)

				if (34 <= 0 and var_495_0 or var_495_0 * (utf8.len(var_495_2) / 34)) > 0 and var_495_0 < var_495_4 then
					arg_492_1.talkMaxDuration = var_495_4

					if var_495_4 + 0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_4 + 0
					end
				end

				arg_492_1.text_.text = var_495_2
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081117", "story_v_out_424081.awb") ~= 0 then
					local var_495_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081117", "story_v_out_424081.awb") / 1000

					if var_495_5 + 0 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_5 + 0
					end

					if var_495_1.prefab_name ~= "" and arg_492_1.actors_[var_495_1.prefab_name] ~= nil then
						local var_495_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_1.prefab_name].transform, "story_v_out_424081", "424081117", "story_v_out_424081.awb")

						arg_492_1:RecordAudio("424081117", var_495_6)
						arg_492_1:RecordAudio("424081117", var_495_6)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_424081", "424081117", "story_v_out_424081.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_424081", "424081117", "story_v_out_424081.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_7 = math.max(var_495_0, arg_492_1.talkMaxDuration)

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_7 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - 0) / var_495_7

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= 0 + var_495_7 and arg_492_1.time_ < 0 + var_495_7 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {}

		arg_492_1:InitPlayNodeList()
	end,
	Play424081118 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 424081118
		arg_496_1.duration_ = 9.47

		local var_496_0 = {
			zh = 6.166,
			ja = 9.466
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play424081119(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = 0.675

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[1404].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_1 = arg_496_1:GetWordFromCfg(424081118)
				local var_499_2 = arg_496_1:FormatText(var_499_1.content)

				arg_496_1.text_.text = var_499_2

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_4 = 27 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_2) / 27)

				if (27 <= 0 and var_499_0 or var_499_0 * (utf8.len(var_499_2) / 27)) > 0 and var_499_0 < var_499_4 then
					arg_496_1.talkMaxDuration = var_499_4

					if var_499_4 + 0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_4 + 0
					end
				end

				arg_496_1.text_.text = var_499_2
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081118", "story_v_out_424081.awb") ~= 0 then
					local var_499_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081118", "story_v_out_424081.awb") / 1000

					if var_499_5 + 0 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_5 + 0
					end

					if var_499_1.prefab_name ~= "" and arg_496_1.actors_[var_499_1.prefab_name] ~= nil then
						local var_499_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_1.prefab_name].transform, "story_v_out_424081", "424081118", "story_v_out_424081.awb")

						arg_496_1:RecordAudio("424081118", var_499_6)
						arg_496_1:RecordAudio("424081118", var_499_6)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_out_424081", "424081118", "story_v_out_424081.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_out_424081", "424081118", "story_v_out_424081.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_7 = math.max(var_499_0, arg_496_1.talkMaxDuration)

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_7 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - 0) / var_499_7

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= 0 + var_499_7 and arg_496_1.time_ < 0 + var_499_7 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play424081119 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 424081119
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play424081120(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0.725

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, true)
				arg_500_1.iconController_:SetSelectedState("hero")

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_1 = arg_500_1:FormatText(arg_500_1:GetWordFromCfg(424081119).content)

				arg_500_1.text_.text = var_503_1

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_3 = 29 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 29)

				if (29 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 29)) > 0 and var_503_0 < var_503_3 then
					arg_500_1.talkMaxDuration = var_503_3

					if var_503_3 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_3 + 0
					end
				end

				arg_500_1.text_.text = var_503_1
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_4 = math.max(var_503_0, arg_500_1.talkMaxDuration)

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_4 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - 0) / var_503_4

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= 0 + var_503_4 and arg_500_1.time_ < 0 + var_503_4 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play424081120 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 424081120
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play424081121(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 1

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				arg_504_1.leftNameTxt_.text = arg_504_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, true)
				arg_504_1.iconController_:SetSelectedState("hero")

				arg_504_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_504_1.callingController_:SetSelectedState("normal")

				arg_504_1.keyicon_.color = Color.New(1, 1, 1)
				arg_504_1.icon_.color = Color.New(1, 1, 1)

				local var_507_1 = arg_504_1:FormatText(arg_504_1:GetWordFromCfg(424081120).content)

				arg_504_1.text_.text = var_507_1

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_3 = 40 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_1) / 40)

				if (40 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_1) / 40)) > 0 and var_507_0 < var_507_3 then
					arg_504_1.talkMaxDuration = var_507_3

					if var_507_3 + 0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_3 + 0
					end
				end

				arg_504_1.text_.text = var_507_1
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_4 = math.max(var_507_0, arg_504_1.talkMaxDuration)

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_4 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - 0) / var_507_4

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= 0 + var_507_4 and arg_504_1.time_ < 0 + var_507_4 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play424081121 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 424081121
		arg_508_1.duration_ = 10.5

		local var_508_0 = {
			zh = 7.599999999998,
			ja = 10.499999999998
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play424081122(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 2 < arg_508_1.time_ and arg_508_1.time_ <= 2 + arg_511_0 then
				local var_511_0 = arg_508_1.bgs_.SS2402

				arg_508_1.bgs_.SS2402.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_511_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_511_1 = var_511_0:GetComponent("SpriteRenderer")

				if var_511_1 and var_511_1.sprite then
					local var_511_2 = 2 * (var_511_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_511_0.transform.localScale = Vector3.New(var_511_2 / var_511_1.sprite.bounds.size.y < var_511_2 * manager.ui.mainCameraCom_.aspect / var_511_1.sprite.bounds.size.x and var_511_2 * manager.ui.mainCameraCom_.aspect / var_511_1.sprite.bounds.size.x or var_511_2 / var_511_1.sprite.bounds.size.y, var_511_2 / var_511_1.sprite.bounds.size.y < var_511_2 * manager.ui.mainCameraCom_.aspect / var_511_1.sprite.bounds.size.x and var_511_2 * manager.ui.mainCameraCom_.aspect / var_511_1.sprite.bounds.size.x or var_511_2 / var_511_1.sprite.bounds.size.y, 0)
				end

				for iter_511_0, iter_511_1 in pairs(arg_508_1.bgs_) do
					if iter_511_0 ~= "SS2402" then
						iter_511_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_511_3 = 3.999999999999

			if 3.999999999999 < arg_508_1.time_ and arg_508_1.time_ <= var_511_3 + arg_511_0 then
				arg_508_1.allBtn_.enabled = false
			end

			if arg_508_1.time_ >= var_511_3 + 0.3 and arg_508_1.time_ < var_511_3 + 0.3 + arg_511_0 then
				arg_508_1.allBtn_.enabled = true
			end

			local var_511_4 = 0

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_4 + arg_511_0 then
				arg_508_1.mask_.enabled = true
				arg_508_1.mask_.raycastTarget = true

				arg_508_1:SetGaussion(false)
			end

			local var_511_5 = 2

			if var_511_4 <= arg_508_1.time_ and arg_508_1.time_ < var_511_4 + var_511_5 then
				local var_511_6 = Color.New(0, 0, 0)

				var_511_6.a = Mathf.Lerp(0, 1, (arg_508_1.time_ - var_511_4) / var_511_5)
				arg_508_1.mask_.color = var_511_6
			end

			if arg_508_1.time_ >= var_511_4 + var_511_5 and arg_508_1.time_ < var_511_4 + var_511_5 + arg_511_0 then
				local var_511_7 = Color.New(0, 0, 0)

				var_511_7.a = 1
				arg_508_1.mask_.color = var_511_7
			end

			local var_511_8 = 2

			if 2 < arg_508_1.time_ and arg_508_1.time_ <= var_511_8 + arg_511_0 then
				arg_508_1.mask_.enabled = true
				arg_508_1.mask_.raycastTarget = true

				arg_508_1:SetGaussion(false)
			end

			local var_511_9 = 2

			if var_511_8 <= arg_508_1.time_ and arg_508_1.time_ < var_511_8 + var_511_9 then
				local var_511_10 = Color.New(0, 0, 0)

				var_511_10.a = Mathf.Lerp(1, 0, (arg_508_1.time_ - var_511_8) / var_511_9)
				arg_508_1.mask_.color = var_511_10
			end

			if arg_508_1.time_ >= var_511_8 + var_511_9 and arg_508_1.time_ < var_511_8 + var_511_9 + arg_511_0 then
				local var_511_11 = Color.New(0, 0, 0)

				arg_508_1.mask_.enabled = false
				var_511_11.a = 0
				arg_508_1.mask_.color = var_511_11
			end

			if arg_508_1.frameCnt_ <= 1 then
				arg_508_1.dialog_:SetActive(false)
			end

			local var_511_12 = 3.999999999998
			local var_511_13 = 0.3

			if 3.999999999998 < arg_508_1.time_ and arg_508_1.time_ <= var_511_12 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0

				arg_508_1.dialog_:SetActive(true)

				arg_508_1.dialogCg_.alpha = 0

				local var_511_14 = LeanTween.value(arg_508_1.dialog_, 0, 1, 0.3)

				var_511_14:setOnUpdate(LuaHelper.FloatAction(function(arg_512_0)
					arg_508_1.dialogCg_.alpha = arg_512_0
				end))
				var_511_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_508_1.dialog_)
					var_511_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_508_1.duration_ = arg_508_1.duration_ + 0.3

				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_15 = arg_508_1:GetWordFromCfg(424081121)
				local var_511_16 = arg_508_1:FormatText(var_511_15.content)

				arg_508_1.text_.text = var_511_16

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_18 = 12 <= 0 and var_511_13 or var_511_13 * (utf8.len(var_511_16) / 12)

				if (12 <= 0 and var_511_13 or var_511_13 * (utf8.len(var_511_16) / 12)) > 0 and var_511_13 < var_511_18 then
					arg_508_1.talkMaxDuration = var_511_18
					var_511_12 = var_511_12 + 0.3

					if var_511_18 + var_511_12 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_18 + var_511_12
					end
				end

				arg_508_1.text_.text = var_511_16
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081121", "story_v_out_424081.awb") ~= 0 then
					local var_511_19 = manager.audio:GetVoiceLength("story_v_out_424081", "424081121", "story_v_out_424081.awb") / 1000

					if var_511_19 + var_511_12 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_19 + var_511_12
					end

					if var_511_15.prefab_name ~= "" and arg_508_1.actors_[var_511_15.prefab_name] ~= nil then
						local var_511_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_15.prefab_name].transform, "story_v_out_424081", "424081121", "story_v_out_424081.awb")

						arg_508_1:RecordAudio("424081121", var_511_20)
						arg_508_1:RecordAudio("424081121", var_511_20)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_424081", "424081121", "story_v_out_424081.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_424081", "424081121", "story_v_out_424081.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_21 = var_511_12 + 0.3
			local var_511_22 = math.max(var_511_13, arg_508_1.talkMaxDuration)

			if var_511_12 + 0.3 <= arg_508_1.time_ and arg_508_1.time_ < var_511_21 + var_511_22 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_21) / var_511_22

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_21 + var_511_22 and arg_508_1.time_ < var_511_21 + var_511_22 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play424081122 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 424081122
		arg_514_1.duration_ = 7

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play424081123(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_0 = 1

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 then
				local var_517_1 = Color.New(0.1320755, 0.1320755, 0.1320755)

				var_517_1.a = Mathf.Lerp(0, 1, (arg_514_1.time_ - 0) / var_517_0)
				arg_514_1.mask_.color = var_517_1
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 then
				local var_517_2 = Color.New(0.1320755, 0.1320755, 0.1320755)

				var_517_2.a = 1
				arg_514_1.mask_.color = var_517_2
			end

			local var_517_3 = 1

			if 1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_3 + arg_517_0 then
				arg_514_1.mask_.enabled = true
				arg_514_1.mask_.raycastTarget = true

				arg_514_1:SetGaussion(false)
			end

			local var_517_4 = 1

			if var_517_3 <= arg_514_1.time_ and arg_514_1.time_ < var_517_3 + var_517_4 then
				local var_517_5 = Color.New(0.1320755, 0.1320755, 0.1320755)

				var_517_5.a = Mathf.Lerp(1, 0, (arg_514_1.time_ - var_517_3) / var_517_4)
				arg_514_1.mask_.color = var_517_5
			end

			if arg_514_1.time_ >= var_517_3 + var_517_4 and arg_514_1.time_ < var_517_3 + var_517_4 + arg_517_0 then
				local var_517_6 = Color.New(0.1320755, 0.1320755, 0.1320755)

				arg_514_1.mask_.enabled = false
				var_517_6.a = 0
				arg_514_1.mask_.color = var_517_6
			end

			local var_517_7 = arg_514_1.bgs_.SS2402.transform

			if 1 < arg_514_1.time_ and arg_514_1.time_ <= 1 + arg_517_0 then
				arg_514_1.var_.moveOldPosSS2402 = var_517_7.localPosition
			end

			local var_517_8 = 2

			if 1 <= arg_514_1.time_ and arg_514_1.time_ < 1 + var_517_8 then
				var_517_7.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPosSS2402, Vector3.New(0, 1, 6), (arg_514_1.time_ - 1) / var_517_8)
			end

			if arg_514_1.time_ >= 1 + var_517_8 and arg_514_1.time_ < 1 + var_517_8 + arg_517_0 then
				var_517_7.localPosition = Vector3.New(0, 1, 6)
			end

			if arg_514_1.frameCnt_ <= 1 then
				arg_514_1.dialog_:SetActive(false)
			end

			local var_517_9 = 2
			local var_517_10 = 0.625

			if 2 < arg_514_1.time_ and arg_514_1.time_ <= var_517_9 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0

				arg_514_1.dialog_:SetActive(true)

				arg_514_1.dialogCg_.alpha = 0

				local var_517_11 = LeanTween.value(arg_514_1.dialog_, 0, 1, 0.3)

				var_517_11:setOnUpdate(LuaHelper.FloatAction(function(arg_518_0)
					arg_514_1.dialogCg_.alpha = arg_518_0
				end))
				var_517_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_514_1.dialog_)
					var_517_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_514_1.duration_ = arg_514_1.duration_ + 0.3

				SetActive(arg_514_1.leftNameGo_, false)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_12 = arg_514_1:FormatText(arg_514_1:GetWordFromCfg(424081122).content)

				arg_514_1.text_.text = var_517_12

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_14 = 25 <= 0 and var_517_10 or var_517_10 * (utf8.len(var_517_12) / 25)

				if (25 <= 0 and var_517_10 or var_517_10 * (utf8.len(var_517_12) / 25)) > 0 and var_517_10 < var_517_14 then
					arg_514_1.talkMaxDuration = var_517_14
					var_517_9 = var_517_9 + 0.3

					if var_517_14 + var_517_9 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_14 + var_517_9
					end
				end

				arg_514_1.text_.text = var_517_12
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_15 = var_517_9 + 0.3
			local var_517_16 = math.max(var_517_10, arg_514_1.talkMaxDuration)

			if var_517_9 + 0.3 <= arg_514_1.time_ and arg_514_1.time_ < var_517_15 + var_517_16 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_15) / var_517_16

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_15 + var_517_16 and arg_514_1.time_ < var_517_15 + var_517_16 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2402",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 6.5),
					endPos = Vector3.New(0, 1, 6),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play424081123 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 424081123
		arg_520_1.duration_ = 2.5

		local var_520_0 = {
			zh = 2.1,
			ja = 2.5
		}
		local var_520_1 = manager.audio:GetLocalizationFlag()

		if var_520_0[var_520_1] ~= nil then
			arg_520_1.duration_ = var_520_0[var_520_1]
		end

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play424081124(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0.2

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[1404].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, true)
				arg_520_1.iconController_:SetSelectedState("hero")

				arg_520_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_520_1.callingController_:SetSelectedState("normal")

				arg_520_1.keyicon_.color = Color.New(1, 1, 1)
				arg_520_1.icon_.color = Color.New(1, 1, 1)

				local var_523_1 = arg_520_1:GetWordFromCfg(424081123)
				local var_523_2 = arg_520_1:FormatText(var_523_1.content)

				arg_520_1.text_.text = var_523_2

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_4 = 8 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_2) / 8)

				if (8 <= 0 and var_523_0 or var_523_0 * (utf8.len(var_523_2) / 8)) > 0 and var_523_0 < var_523_4 then
					arg_520_1.talkMaxDuration = var_523_4

					if var_523_4 + 0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_4 + 0
					end
				end

				arg_520_1.text_.text = var_523_2
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081123", "story_v_out_424081.awb") ~= 0 then
					local var_523_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081123", "story_v_out_424081.awb") / 1000

					if var_523_5 + 0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_5 + 0
					end

					if var_523_1.prefab_name ~= "" and arg_520_1.actors_[var_523_1.prefab_name] ~= nil then
						local var_523_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_520_1.actors_[var_523_1.prefab_name].transform, "story_v_out_424081", "424081123", "story_v_out_424081.awb")

						arg_520_1:RecordAudio("424081123", var_523_6)
						arg_520_1:RecordAudio("424081123", var_523_6)
					else
						arg_520_1:AudioAction("play", "voice", "story_v_out_424081", "424081123", "story_v_out_424081.awb")
					end

					arg_520_1:RecordHistoryTalkVoice("story_v_out_424081", "424081123", "story_v_out_424081.awb")
				end

				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_7 = math.max(var_523_0, arg_520_1.talkMaxDuration)

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_7 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - 0) / var_523_7

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= 0 + var_523_7 and arg_520_1.time_ < 0 + var_523_7 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play424081124 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 424081124
		arg_524_1.duration_ = 2.4

		local var_524_0 = {
			zh = 1.5,
			ja = 2.4
		}
		local var_524_1 = manager.audio:GetLocalizationFlag()

		if var_524_0[var_524_1] ~= nil then
			arg_524_1.duration_ = var_524_0[var_524_1]
		end

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play424081125(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = 0.2

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				arg_524_1.leftNameTxt_.text = arg_524_1:FormatText(StoryNameCfg[1408].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_1 = arg_524_1:GetWordFromCfg(424081124)
				local var_527_2 = arg_524_1:FormatText(var_527_1.content)

				arg_524_1.text_.text = var_527_2

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_4 = 8 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_2) / 8)

				if (8 <= 0 and var_527_0 or var_527_0 * (utf8.len(var_527_2) / 8)) > 0 and var_527_0 < var_527_4 then
					arg_524_1.talkMaxDuration = var_527_4

					if var_527_4 + 0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_4 + 0
					end
				end

				arg_524_1.text_.text = var_527_2
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081124", "story_v_out_424081.awb") ~= 0 then
					local var_527_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081124", "story_v_out_424081.awb") / 1000

					if var_527_5 + 0 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_5 + 0
					end

					if var_527_1.prefab_name ~= "" and arg_524_1.actors_[var_527_1.prefab_name] ~= nil then
						local var_527_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_1.prefab_name].transform, "story_v_out_424081", "424081124", "story_v_out_424081.awb")

						arg_524_1:RecordAudio("424081124", var_527_6)
						arg_524_1:RecordAudio("424081124", var_527_6)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_out_424081", "424081124", "story_v_out_424081.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_out_424081", "424081124", "story_v_out_424081.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_7 = math.max(var_527_0, arg_524_1.talkMaxDuration)

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_7 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - 0) / var_527_7

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= 0 + var_527_7 and arg_524_1.time_ < 0 + var_527_7 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {}

		arg_524_1:InitPlayNodeList()
	end,
	Play424081125 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 424081125
		arg_528_1.duration_ = 6.27

		local var_528_0 = {
			zh = 5,
			ja = 6.266
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play424081126(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = 0.45

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_1 = arg_528_1:GetWordFromCfg(424081125)
				local var_531_2 = arg_528_1:FormatText(var_531_1.content)

				arg_528_1.text_.text = var_531_2

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_4 = 18 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_2) / 18)

				if (18 <= 0 and var_531_0 or var_531_0 * (utf8.len(var_531_2) / 18)) > 0 and var_531_0 < var_531_4 then
					arg_528_1.talkMaxDuration = var_531_4

					if var_531_4 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_4 + 0
					end
				end

				arg_528_1.text_.text = var_531_2
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081125", "story_v_out_424081.awb") ~= 0 then
					local var_531_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081125", "story_v_out_424081.awb") / 1000

					if var_531_5 + 0 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_5 + 0
					end

					if var_531_1.prefab_name ~= "" and arg_528_1.actors_[var_531_1.prefab_name] ~= nil then
						local var_531_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_1.prefab_name].transform, "story_v_out_424081", "424081125", "story_v_out_424081.awb")

						arg_528_1:RecordAudio("424081125", var_531_6)
						arg_528_1:RecordAudio("424081125", var_531_6)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_out_424081", "424081125", "story_v_out_424081.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_out_424081", "424081125", "story_v_out_424081.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_7 = math.max(var_531_0, arg_528_1.talkMaxDuration)

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_7 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - 0) / var_531_7

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= 0 + var_531_7 and arg_528_1.time_ < 0 + var_531_7 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play424081126 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 424081126
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play424081127(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0.675

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_1 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(424081126).content)

				arg_532_1.text_.text = var_535_1

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_3 = 27 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 27)

				if (27 <= 0 and var_535_0 or var_535_0 * (utf8.len(var_535_1) / 27)) > 0 and var_535_0 < var_535_3 then
					arg_532_1.talkMaxDuration = var_535_3

					if var_535_3 + 0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_3 + 0
					end
				end

				arg_532_1.text_.text = var_535_1
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_4 = math.max(var_535_0, arg_532_1.talkMaxDuration)

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_4 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - 0) / var_535_4

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= 0 + var_535_4 and arg_532_1.time_ < 0 + var_535_4 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play424081127 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 424081127
		arg_536_1.duration_ = 3.1

		local var_536_0 = {
			zh = 2.4,
			ja = 3.1
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play424081128(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = 0.2

			if 0 < arg_536_1.time_ and arg_536_1.time_ <= 0 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				arg_536_1.leftNameTxt_.text = arg_536_1:FormatText(StoryNameCfg[1404].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_1 = arg_536_1:GetWordFromCfg(424081127)
				local var_539_2 = arg_536_1:FormatText(var_539_1.content)

				arg_536_1.text_.text = var_539_2

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_4 = 8 <= 0 and var_539_0 or var_539_0 * (utf8.len(var_539_2) / 8)

				if (8 <= 0 and var_539_0 or var_539_0 * (utf8.len(var_539_2) / 8)) > 0 and var_539_0 < var_539_4 then
					arg_536_1.talkMaxDuration = var_539_4

					if var_539_4 + 0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_4 + 0
					end
				end

				arg_536_1.text_.text = var_539_2
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081127", "story_v_out_424081.awb") ~= 0 then
					local var_539_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081127", "story_v_out_424081.awb") / 1000

					if var_539_5 + 0 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_5 + 0
					end

					if var_539_1.prefab_name ~= "" and arg_536_1.actors_[var_539_1.prefab_name] ~= nil then
						local var_539_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_1.prefab_name].transform, "story_v_out_424081", "424081127", "story_v_out_424081.awb")

						arg_536_1:RecordAudio("424081127", var_539_6)
						arg_536_1:RecordAudio("424081127", var_539_6)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_out_424081", "424081127", "story_v_out_424081.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_out_424081", "424081127", "story_v_out_424081.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_7 = math.max(var_539_0, arg_536_1.talkMaxDuration)

			if 0 <= arg_536_1.time_ and arg_536_1.time_ < 0 + var_539_7 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - 0) / var_539_7

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= 0 + var_539_7 and arg_536_1.time_ < 0 + var_539_7 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play424081128 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 424081128
		arg_540_1.duration_ = 4.8

		local var_540_0 = {
			zh = 2.4,
			ja = 4.8
		}
		local var_540_1 = manager.audio:GetLocalizationFlag()

		if var_540_0[var_540_1] ~= nil then
			arg_540_1.duration_ = var_540_0[var_540_1]
		end

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play424081129(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = 0.3

			if 0 < arg_540_1.time_ and arg_540_1.time_ <= 0 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				arg_540_1.leftNameTxt_.text = arg_540_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_1 = arg_540_1:GetWordFromCfg(424081128)
				local var_543_2 = arg_540_1:FormatText(var_543_1.content)

				arg_540_1.text_.text = var_543_2

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_4 = 12 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_2) / 12)

				if (12 <= 0 and var_543_0 or var_543_0 * (utf8.len(var_543_2) / 12)) > 0 and var_543_0 < var_543_4 then
					arg_540_1.talkMaxDuration = var_543_4

					if var_543_4 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_4 + 0
					end
				end

				arg_540_1.text_.text = var_543_2
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081128", "story_v_out_424081.awb") ~= 0 then
					local var_543_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081128", "story_v_out_424081.awb") / 1000

					if var_543_5 + 0 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_5 + 0
					end

					if var_543_1.prefab_name ~= "" and arg_540_1.actors_[var_543_1.prefab_name] ~= nil then
						local var_543_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_1.prefab_name].transform, "story_v_out_424081", "424081128", "story_v_out_424081.awb")

						arg_540_1:RecordAudio("424081128", var_543_6)
						arg_540_1:RecordAudio("424081128", var_543_6)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_424081", "424081128", "story_v_out_424081.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_424081", "424081128", "story_v_out_424081.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_7 = math.max(var_543_0, arg_540_1.talkMaxDuration)

			if 0 <= arg_540_1.time_ and arg_540_1.time_ < 0 + var_543_7 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - 0) / var_543_7

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= 0 + var_543_7 and arg_540_1.time_ < 0 + var_543_7 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play424081129 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 424081129
		arg_544_1.duration_ = 9.67

		local var_544_0 = {
			zh = 4.566,
			ja = 9.666
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play424081130(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = 0.425

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				arg_544_1.leftNameTxt_.text = arg_544_1:FormatText(StoryNameCfg[1404].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, true)
				arg_544_1.iconController_:SetSelectedState("hero")

				arg_544_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_544_1.callingController_:SetSelectedState("normal")

				arg_544_1.keyicon_.color = Color.New(1, 1, 1)
				arg_544_1.icon_.color = Color.New(1, 1, 1)

				local var_547_1 = arg_544_1:GetWordFromCfg(424081129)
				local var_547_2 = arg_544_1:FormatText(var_547_1.content)

				arg_544_1.text_.text = var_547_2

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_4 = 17 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_2) / 17)

				if (17 <= 0 and var_547_0 or var_547_0 * (utf8.len(var_547_2) / 17)) > 0 and var_547_0 < var_547_4 then
					arg_544_1.talkMaxDuration = var_547_4

					if var_547_4 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_4 + 0
					end
				end

				arg_544_1.text_.text = var_547_2
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081129", "story_v_out_424081.awb") ~= 0 then
					local var_547_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081129", "story_v_out_424081.awb") / 1000

					if var_547_5 + 0 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_5 + 0
					end

					if var_547_1.prefab_name ~= "" and arg_544_1.actors_[var_547_1.prefab_name] ~= nil then
						local var_547_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_1.prefab_name].transform, "story_v_out_424081", "424081129", "story_v_out_424081.awb")

						arg_544_1:RecordAudio("424081129", var_547_6)
						arg_544_1:RecordAudio("424081129", var_547_6)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_424081", "424081129", "story_v_out_424081.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_424081", "424081129", "story_v_out_424081.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_7 = math.max(var_547_0, arg_544_1.talkMaxDuration)

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_7 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - 0) / var_547_7

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= 0 + var_547_7 and arg_544_1.time_ < 0 + var_547_7 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play424081130 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 424081130
		arg_548_1.duration_ = 3.97

		local var_548_0 = {
			zh = 2.6,
			ja = 3.966
		}
		local var_548_1 = manager.audio:GetLocalizationFlag()

		if var_548_0[var_548_1] ~= nil then
			arg_548_1.duration_ = var_548_0[var_548_1]
		end

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play424081131(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0.225

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, true)

				arg_548_1.leftNameTxt_.text = arg_548_1:FormatText(StoryNameCfg[1407].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_548_1.leftNameTxt_.transform)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1.leftNameTxt_.text)
				SetActive(arg_548_1.iconTrs_.gameObject, true)
				arg_548_1.iconController_:SetSelectedState("hero")

				arg_548_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowstudentwa")

				arg_548_1.callingController_:SetSelectedState("normal")

				arg_548_1.keyicon_.color = Color.New(1, 1, 1)
				arg_548_1.icon_.color = Color.New(1, 1, 1)

				local var_551_1 = arg_548_1:GetWordFromCfg(424081130)
				local var_551_2 = arg_548_1:FormatText(var_551_1.content)

				arg_548_1.text_.text = var_551_2

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_4 = 9 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_2) / 9)

				if (9 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_2) / 9)) > 0 and var_551_0 < var_551_4 then
					arg_548_1.talkMaxDuration = var_551_4

					if var_551_4 + 0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_4 + 0
					end
				end

				arg_548_1.text_.text = var_551_2
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081130", "story_v_out_424081.awb") ~= 0 then
					local var_551_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081130", "story_v_out_424081.awb") / 1000

					if var_551_5 + 0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_5 + 0
					end

					if var_551_1.prefab_name ~= "" and arg_548_1.actors_[var_551_1.prefab_name] ~= nil then
						local var_551_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_548_1.actors_[var_551_1.prefab_name].transform, "story_v_out_424081", "424081130", "story_v_out_424081.awb")

						arg_548_1:RecordAudio("424081130", var_551_6)
						arg_548_1:RecordAudio("424081130", var_551_6)
					else
						arg_548_1:AudioAction("play", "voice", "story_v_out_424081", "424081130", "story_v_out_424081.awb")
					end

					arg_548_1:RecordHistoryTalkVoice("story_v_out_424081", "424081130", "story_v_out_424081.awb")
				end

				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_7 = math.max(var_551_0, arg_548_1.talkMaxDuration)

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_7 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - 0) / var_551_7

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= 0 + var_551_7 and arg_548_1.time_ < 0 + var_551_7 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play424081131 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 424081131
		arg_552_1.duration_ = 8.47

		local var_552_0 = {
			zh = 6,
			ja = 8.466
		}
		local var_552_1 = manager.audio:GetLocalizationFlag()

		if var_552_0[var_552_1] ~= nil then
			arg_552_1.duration_ = var_552_0[var_552_1]
		end

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play424081132(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0.775

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= 0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				arg_552_1.leftNameTxt_.text = arg_552_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_1 = arg_552_1:GetWordFromCfg(424081131)
				local var_555_2 = arg_552_1:FormatText(var_555_1.content)

				arg_552_1.text_.text = var_555_2

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_4 = 31 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 31)

				if (31 <= 0 and var_555_0 or var_555_0 * (utf8.len(var_555_2) / 31)) > 0 and var_555_0 < var_555_4 then
					arg_552_1.talkMaxDuration = var_555_4

					if var_555_4 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_4 + 0
					end
				end

				arg_552_1.text_.text = var_555_2
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081131", "story_v_out_424081.awb") ~= 0 then
					local var_555_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081131", "story_v_out_424081.awb") / 1000

					if var_555_5 + 0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_5 + 0
					end

					if var_555_1.prefab_name ~= "" and arg_552_1.actors_[var_555_1.prefab_name] ~= nil then
						local var_555_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_552_1.actors_[var_555_1.prefab_name].transform, "story_v_out_424081", "424081131", "story_v_out_424081.awb")

						arg_552_1:RecordAudio("424081131", var_555_6)
						arg_552_1:RecordAudio("424081131", var_555_6)
					else
						arg_552_1:AudioAction("play", "voice", "story_v_out_424081", "424081131", "story_v_out_424081.awb")
					end

					arg_552_1:RecordHistoryTalkVoice("story_v_out_424081", "424081131", "story_v_out_424081.awb")
				end

				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_7 = math.max(var_555_0, arg_552_1.talkMaxDuration)

			if 0 <= arg_552_1.time_ and arg_552_1.time_ < 0 + var_555_7 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - 0) / var_555_7

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= 0 + var_555_7 and arg_552_1.time_ < 0 + var_555_7 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play424081132 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 424081132
		arg_556_1.duration_ = 5

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play424081133(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 0.725

			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0
				arg_556_1.dialogCg_.alpha = 1

				arg_556_1.dialog_:SetActive(true)
				SetActive(arg_556_1.leftNameGo_, false)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_1 = arg_556_1:FormatText(arg_556_1:GetWordFromCfg(424081132).content)

				arg_556_1.text_.text = var_559_1

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_3 = 29 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_1) / 29)

				if (29 <= 0 and var_559_0 or var_559_0 * (utf8.len(var_559_1) / 29)) > 0 and var_559_0 < var_559_3 then
					arg_556_1.talkMaxDuration = var_559_3

					if var_559_3 + 0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_3 + 0
					end
				end

				arg_556_1.text_.text = var_559_1
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_4 = math.max(var_559_0, arg_556_1.talkMaxDuration)

			if 0 <= arg_556_1.time_ and arg_556_1.time_ < 0 + var_559_4 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - 0) / var_559_4

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= 0 + var_559_4 and arg_556_1.time_ < 0 + var_559_4 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play424081133 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 424081133
		arg_560_1.duration_ = 2.87

		local var_560_0 = {
			zh = 2.1,
			ja = 2.866
		}
		local var_560_1 = manager.audio:GetLocalizationFlag()

		if var_560_0[var_560_1] ~= nil then
			arg_560_1.duration_ = var_560_0[var_560_1]
		end

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play424081134(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			local var_563_0 = 0.225

			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0
				arg_560_1.dialogCg_.alpha = 1

				arg_560_1.dialog_:SetActive(true)
				SetActive(arg_560_1.leftNameGo_, true)

				arg_560_1.leftNameTxt_.text = arg_560_1:FormatText(StoryNameCfg[1404].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_560_1.leftNameTxt_.transform)

				arg_560_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_560_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_560_1:RecordName(arg_560_1.leftNameTxt_.text)
				SetActive(arg_560_1.iconTrs_.gameObject, true)
				arg_560_1.iconController_:SetSelectedState("hero")

				arg_560_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_560_1.callingController_:SetSelectedState("normal")

				arg_560_1.keyicon_.color = Color.New(1, 1, 1)
				arg_560_1.icon_.color = Color.New(1, 1, 1)

				local var_563_1 = arg_560_1:GetWordFromCfg(424081133)
				local var_563_2 = arg_560_1:FormatText(var_563_1.content)

				arg_560_1.text_.text = var_563_2

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.text_)

				local var_563_4 = 9 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_2) / 9)

				if (9 <= 0 and var_563_0 or var_563_0 * (utf8.len(var_563_2) / 9)) > 0 and var_563_0 < var_563_4 then
					arg_560_1.talkMaxDuration = var_563_4

					if var_563_4 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_4 + 0
					end
				end

				arg_560_1.text_.text = var_563_2
				arg_560_1.typewritter.percent = 0

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081133", "story_v_out_424081.awb") ~= 0 then
					local var_563_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081133", "story_v_out_424081.awb") / 1000

					if var_563_5 + 0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_5 + 0
					end

					if var_563_1.prefab_name ~= "" and arg_560_1.actors_[var_563_1.prefab_name] ~= nil then
						local var_563_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_560_1.actors_[var_563_1.prefab_name].transform, "story_v_out_424081", "424081133", "story_v_out_424081.awb")

						arg_560_1:RecordAudio("424081133", var_563_6)
						arg_560_1:RecordAudio("424081133", var_563_6)
					else
						arg_560_1:AudioAction("play", "voice", "story_v_out_424081", "424081133", "story_v_out_424081.awb")
					end

					arg_560_1:RecordHistoryTalkVoice("story_v_out_424081", "424081133", "story_v_out_424081.awb")
				end

				arg_560_1:RecordContent(arg_560_1.text_.text)
			end

			local var_563_7 = math.max(var_563_0, arg_560_1.talkMaxDuration)

			if 0 <= arg_560_1.time_ and arg_560_1.time_ < 0 + var_563_7 then
				arg_560_1.typewritter.percent = (arg_560_1.time_ - 0) / var_563_7

				arg_560_1.typewritter:SetDirty()
			end

			if arg_560_1.time_ >= 0 + var_563_7 and arg_560_1.time_ < 0 + var_563_7 + arg_563_0 then
				arg_560_1.typewritter.percent = 1

				arg_560_1.typewritter:SetDirty()
				arg_560_1:ShowNextGo(true)
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play424081134 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 424081134
		arg_564_1.duration_ = 6.53

		local var_564_0 = {
			zh = 5.233,
			ja = 6.533
		}
		local var_564_1 = manager.audio:GetLocalizationFlag()

		if var_564_0[var_564_1] ~= nil then
			arg_564_1.duration_ = var_564_0[var_564_1]
		end

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
		end

		function arg_564_1.playNext_(arg_566_0)
			if arg_566_0 == 1 then
				arg_564_0:Play424081135(arg_564_1)
			end
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			local var_567_0 = 0.6

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0
				arg_564_1.dialogCg_.alpha = 1

				arg_564_1.dialog_:SetActive(true)
				SetActive(arg_564_1.leftNameGo_, true)

				arg_564_1.leftNameTxt_.text = arg_564_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_564_1.leftNameTxt_.transform)

				arg_564_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_564_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_564_1:RecordName(arg_564_1.leftNameTxt_.text)
				SetActive(arg_564_1.iconTrs_.gameObject, true)
				arg_564_1.iconController_:SetSelectedState("hero")

				arg_564_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_564_1.callingController_:SetSelectedState("normal")

				arg_564_1.keyicon_.color = Color.New(1, 1, 1)
				arg_564_1.icon_.color = Color.New(1, 1, 1)

				local var_567_1 = arg_564_1:GetWordFromCfg(424081134)
				local var_567_2 = arg_564_1:FormatText(var_567_1.content)

				arg_564_1.text_.text = var_567_2

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.text_)

				local var_567_4 = 24 <= 0 and var_567_0 or var_567_0 * (utf8.len(var_567_2) / 24)

				if (24 <= 0 and var_567_0 or var_567_0 * (utf8.len(var_567_2) / 24)) > 0 and var_567_0 < var_567_4 then
					arg_564_1.talkMaxDuration = var_567_4

					if var_567_4 + 0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_4 + 0
					end
				end

				arg_564_1.text_.text = var_567_2
				arg_564_1.typewritter.percent = 0

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081134", "story_v_out_424081.awb") ~= 0 then
					local var_567_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081134", "story_v_out_424081.awb") / 1000

					if var_567_5 + 0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_5 + 0
					end

					if var_567_1.prefab_name ~= "" and arg_564_1.actors_[var_567_1.prefab_name] ~= nil then
						local var_567_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_564_1.actors_[var_567_1.prefab_name].transform, "story_v_out_424081", "424081134", "story_v_out_424081.awb")

						arg_564_1:RecordAudio("424081134", var_567_6)
						arg_564_1:RecordAudio("424081134", var_567_6)
					else
						arg_564_1:AudioAction("play", "voice", "story_v_out_424081", "424081134", "story_v_out_424081.awb")
					end

					arg_564_1:RecordHistoryTalkVoice("story_v_out_424081", "424081134", "story_v_out_424081.awb")
				end

				arg_564_1:RecordContent(arg_564_1.text_.text)
			end

			local var_567_7 = math.max(var_567_0, arg_564_1.talkMaxDuration)

			if 0 <= arg_564_1.time_ and arg_564_1.time_ < 0 + var_567_7 then
				arg_564_1.typewritter.percent = (arg_564_1.time_ - 0) / var_567_7

				arg_564_1.typewritter:SetDirty()
			end

			if arg_564_1.time_ >= 0 + var_567_7 and arg_564_1.time_ < 0 + var_567_7 + arg_567_0 then
				arg_564_1.typewritter.percent = 1

				arg_564_1.typewritter:SetDirty()
				arg_564_1:ShowNextGo(true)
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	Play424081135 = function(arg_568_0, arg_568_1)
		arg_568_1.time_ = 0
		arg_568_1.frameCnt_ = 0
		arg_568_1.state_ = "playing"
		arg_568_1.curTalkId_ = 424081135
		arg_568_1.duration_ = 5

		SetActive(arg_568_1.tipsGo_, false)

		function arg_568_1.onSingleLineFinish_()
			arg_568_1.onSingleLineUpdate_ = nil
			arg_568_1.onSingleLineFinish_ = nil
			arg_568_1.state_ = "waiting"
		end

		function arg_568_1.playNext_(arg_570_0)
			if arg_570_0 == 1 then
				arg_568_0:Play424081136(arg_568_1)
			end
		end

		function arg_568_1.onSingleLineUpdate_(arg_571_0)
			local var_571_0 = 0.8

			if 0 < arg_568_1.time_ and arg_568_1.time_ <= 0 + arg_571_0 then
				arg_568_1.talkMaxDuration = 0
				arg_568_1.dialogCg_.alpha = 1

				arg_568_1.dialog_:SetActive(true)
				SetActive(arg_568_1.leftNameGo_, false)

				arg_568_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_568_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_568_1:RecordName(arg_568_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_568_1.iconTrs_.gameObject, false)
				arg_568_1.callingController_:SetSelectedState("normal")

				local var_571_1 = arg_568_1:FormatText(arg_568_1:GetWordFromCfg(424081135).content)

				arg_568_1.text_.text = var_571_1

				LuaForUtil.ClearLinePrefixSymbol(arg_568_1.text_)

				local var_571_3 = 32 <= 0 and var_571_0 or var_571_0 * (utf8.len(var_571_1) / 32)

				if (32 <= 0 and var_571_0 or var_571_0 * (utf8.len(var_571_1) / 32)) > 0 and var_571_0 < var_571_3 then
					arg_568_1.talkMaxDuration = var_571_3

					if var_571_3 + 0 > arg_568_1.duration_ then
						arg_568_1.duration_ = var_571_3 + 0
					end
				end

				arg_568_1.text_.text = var_571_1
				arg_568_1.typewritter.percent = 0

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(false)
				arg_568_1:RecordContent(arg_568_1.text_.text)
			end

			local var_571_4 = math.max(var_571_0, arg_568_1.talkMaxDuration)

			if 0 <= arg_568_1.time_ and arg_568_1.time_ < 0 + var_571_4 then
				arg_568_1.typewritter.percent = (arg_568_1.time_ - 0) / var_571_4

				arg_568_1.typewritter:SetDirty()
			end

			if arg_568_1.time_ >= 0 + var_571_4 and arg_568_1.time_ < 0 + var_571_4 + arg_571_0 then
				arg_568_1.typewritter.percent = 1

				arg_568_1.typewritter:SetDirty()
				arg_568_1:ShowNextGo(true)
			end
		end

		arg_568_1.nodeConfigList_ = {}

		arg_568_1:InitPlayNodeList()
	end,
	Play424081136 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 424081136
		arg_572_1.duration_ = 5

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play424081137(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			local var_575_0 = 0.9

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0
				arg_572_1.dialogCg_.alpha = 1

				arg_572_1.dialog_:SetActive(true)
				SetActive(arg_572_1.leftNameGo_, true)

				arg_572_1.leftNameTxt_.text = arg_572_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_572_1.leftNameTxt_.transform)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1.leftNameTxt_.text)
				SetActive(arg_572_1.iconTrs_.gameObject, true)
				arg_572_1.iconController_:SetSelectedState("hero")

				arg_572_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_572_1.callingController_:SetSelectedState("normal")

				arg_572_1.keyicon_.color = Color.New(1, 1, 1)
				arg_572_1.icon_.color = Color.New(1, 1, 1)

				local var_575_1 = arg_572_1:FormatText(arg_572_1:GetWordFromCfg(424081136).content)

				arg_572_1.text_.text = var_575_1

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_3 = 36 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_1) / 36)

				if (36 <= 0 and var_575_0 or var_575_0 * (utf8.len(var_575_1) / 36)) > 0 and var_575_0 < var_575_3 then
					arg_572_1.talkMaxDuration = var_575_3

					if var_575_3 + 0 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_3 + 0
					end
				end

				arg_572_1.text_.text = var_575_1
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_4 = math.max(var_575_0, arg_572_1.talkMaxDuration)

			if 0 <= arg_572_1.time_ and arg_572_1.time_ < 0 + var_575_4 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - 0) / var_575_4

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= 0 + var_575_4 and arg_572_1.time_ < 0 + var_575_4 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play424081137 = function(arg_576_0, arg_576_1)
		arg_576_1.time_ = 0
		arg_576_1.frameCnt_ = 0
		arg_576_1.state_ = "playing"
		arg_576_1.curTalkId_ = 424081137
		arg_576_1.duration_ = 9

		SetActive(arg_576_1.tipsGo_, false)

		function arg_576_1.onSingleLineFinish_()
			arg_576_1.onSingleLineUpdate_ = nil
			arg_576_1.onSingleLineFinish_ = nil
			arg_576_1.state_ = "waiting"
		end

		function arg_576_1.playNext_(arg_578_0)
			if arg_578_0 == 1 then
				arg_576_0:Play424081138(arg_576_1)
			end
		end

		function arg_576_1.onSingleLineUpdate_(arg_579_0)
			if 2 < arg_576_1.time_ and arg_576_1.time_ <= 2 + arg_579_0 then
				local var_579_0 = arg_576_1.bgs_.STblack

				arg_576_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_579_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_579_1 = var_579_0:GetComponent("SpriteRenderer")

				if var_579_1 and var_579_1.sprite then
					local var_579_2 = 2 * (var_579_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_579_0.transform.localScale = Vector3.New(var_579_2 / var_579_1.sprite.bounds.size.y < var_579_2 * manager.ui.mainCameraCom_.aspect / var_579_1.sprite.bounds.size.x and var_579_2 * manager.ui.mainCameraCom_.aspect / var_579_1.sprite.bounds.size.x or var_579_2 / var_579_1.sprite.bounds.size.y, var_579_2 / var_579_1.sprite.bounds.size.y < var_579_2 * manager.ui.mainCameraCom_.aspect / var_579_1.sprite.bounds.size.x and var_579_2 * manager.ui.mainCameraCom_.aspect / var_579_1.sprite.bounds.size.x or var_579_2 / var_579_1.sprite.bounds.size.y, 0)
				end

				for iter_579_0, iter_579_1 in pairs(arg_576_1.bgs_) do
					if iter_579_0 ~= "STblack" then
						iter_579_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_579_3 = 4

			if 4 < arg_576_1.time_ and arg_576_1.time_ <= var_579_3 + arg_579_0 then
				arg_576_1.allBtn_.enabled = false
			end

			if arg_576_1.time_ >= var_579_3 + 0.3 and arg_576_1.time_ < var_579_3 + 0.3 + arg_579_0 then
				arg_576_1.allBtn_.enabled = true
			end

			local var_579_4 = 0

			if 0 < arg_576_1.time_ and arg_576_1.time_ <= var_579_4 + arg_579_0 then
				arg_576_1.mask_.enabled = true
				arg_576_1.mask_.raycastTarget = true

				arg_576_1:SetGaussion(false)
			end

			local var_579_5 = 2

			if var_579_4 <= arg_576_1.time_ and arg_576_1.time_ < var_579_4 + var_579_5 then
				local var_579_6 = Color.New(0, 0, 0)

				var_579_6.a = Mathf.Lerp(0, 1, (arg_576_1.time_ - var_579_4) / var_579_5)
				arg_576_1.mask_.color = var_579_6
			end

			if arg_576_1.time_ >= var_579_4 + var_579_5 and arg_576_1.time_ < var_579_4 + var_579_5 + arg_579_0 then
				local var_579_7 = Color.New(0, 0, 0)

				var_579_7.a = 1
				arg_576_1.mask_.color = var_579_7
			end

			local var_579_8 = 2

			if 2 < arg_576_1.time_ and arg_576_1.time_ <= var_579_8 + arg_579_0 then
				arg_576_1.mask_.enabled = true
				arg_576_1.mask_.raycastTarget = true

				arg_576_1:SetGaussion(false)
			end

			local var_579_9 = 2

			if var_579_8 <= arg_576_1.time_ and arg_576_1.time_ < var_579_8 + var_579_9 then
				local var_579_10 = Color.New(0, 0, 0)

				var_579_10.a = Mathf.Lerp(1, 0, (arg_576_1.time_ - var_579_8) / var_579_9)
				arg_576_1.mask_.color = var_579_10
			end

			if arg_576_1.time_ >= var_579_8 + var_579_9 and arg_576_1.time_ < var_579_8 + var_579_9 + arg_579_0 then
				local var_579_11 = Color.New(0, 0, 0)

				arg_576_1.mask_.enabled = false
				var_579_11.a = 0
				arg_576_1.mask_.color = var_579_11
			end

			if arg_576_1.frameCnt_ <= 1 then
				arg_576_1.dialog_:SetActive(false)
			end

			local var_579_12 = 4
			local var_579_13 = 0.9

			if 4 < arg_576_1.time_ and arg_576_1.time_ <= var_579_12 + arg_579_0 then
				arg_576_1.talkMaxDuration = 0

				arg_576_1.dialog_:SetActive(true)

				arg_576_1.dialogCg_.alpha = 0

				local var_579_14 = LeanTween.value(arg_576_1.dialog_, 0, 1, 0.3)

				var_579_14:setOnUpdate(LuaHelper.FloatAction(function(arg_580_0)
					arg_576_1.dialogCg_.alpha = arg_580_0
				end))
				var_579_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_576_1.dialog_)
					var_579_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_576_1.duration_ = arg_576_1.duration_ + 0.3

				SetActive(arg_576_1.leftNameGo_, false)

				arg_576_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_576_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_576_1:RecordName(arg_576_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_576_1.iconTrs_.gameObject, false)
				arg_576_1.callingController_:SetSelectedState("normal")

				local var_579_15 = arg_576_1:FormatText(arg_576_1:GetWordFromCfg(424081137).content)

				arg_576_1.text_.text = var_579_15

				LuaForUtil.ClearLinePrefixSymbol(arg_576_1.text_)

				local var_579_17 = 36 <= 0 and var_579_13 or var_579_13 * (utf8.len(var_579_15) / 36)

				if (36 <= 0 and var_579_13 or var_579_13 * (utf8.len(var_579_15) / 36)) > 0 and var_579_13 < var_579_17 then
					arg_576_1.talkMaxDuration = var_579_17
					var_579_12 = var_579_12 + 0.3

					if var_579_17 + var_579_12 > arg_576_1.duration_ then
						arg_576_1.duration_ = var_579_17 + var_579_12
					end
				end

				arg_576_1.text_.text = var_579_15
				arg_576_1.typewritter.percent = 0

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(false)
				arg_576_1:RecordContent(arg_576_1.text_.text)
			end

			local var_579_18 = var_579_12 + 0.3
			local var_579_19 = math.max(var_579_13, arg_576_1.talkMaxDuration)

			if var_579_12 + 0.3 <= arg_576_1.time_ and arg_576_1.time_ < var_579_18 + var_579_19 then
				arg_576_1.typewritter.percent = (arg_576_1.time_ - var_579_18) / var_579_19

				arg_576_1.typewritter:SetDirty()
			end

			if arg_576_1.time_ >= var_579_18 + var_579_19 and arg_576_1.time_ < var_579_18 + var_579_19 + arg_579_0 then
				arg_576_1.typewritter.percent = 1

				arg_576_1.typewritter:SetDirty()
				arg_576_1:ShowNextGo(true)
			end
		end

		arg_576_1.nodeConfigList_ = {}

		arg_576_1:InitPlayNodeList()
	end,
	Play424081138 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 424081138
		arg_582_1.duration_ = 4.8

		local var_582_0 = {
			zh = 4.466,
			ja = 4.8
		}
		local var_582_1 = manager.audio:GetLocalizationFlag()

		if var_582_0[var_582_1] ~= nil then
			arg_582_1.duration_ = var_582_0[var_582_1]
		end

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play424081139(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				local var_585_0 = arg_582_1.bgs_.I11i

				arg_582_1.bgs_.I11i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_585_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_585_1 = var_585_0:GetComponent("SpriteRenderer")

				if var_585_1 and var_585_1.sprite then
					local var_585_2 = 2 * (var_585_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_585_0.transform.localScale = Vector3.New(var_585_2 / var_585_1.sprite.bounds.size.y < var_585_2 * manager.ui.mainCameraCom_.aspect / var_585_1.sprite.bounds.size.x and var_585_2 * manager.ui.mainCameraCom_.aspect / var_585_1.sprite.bounds.size.x or var_585_2 / var_585_1.sprite.bounds.size.y, var_585_2 / var_585_1.sprite.bounds.size.y < var_585_2 * manager.ui.mainCameraCom_.aspect / var_585_1.sprite.bounds.size.x and var_585_2 * manager.ui.mainCameraCom_.aspect / var_585_1.sprite.bounds.size.x or var_585_2 / var_585_1.sprite.bounds.size.y, 0)
				end

				for iter_585_0, iter_585_1 in pairs(arg_582_1.bgs_) do
					if iter_585_0 ~= "I11i" then
						iter_585_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_585_3 = 2

			if 2 < arg_582_1.time_ and arg_582_1.time_ <= var_585_3 + arg_585_0 then
				arg_582_1.allBtn_.enabled = false
			end

			if arg_582_1.time_ >= var_585_3 + 0.3 and arg_582_1.time_ < var_585_3 + 0.3 + arg_585_0 then
				arg_582_1.allBtn_.enabled = true
			end

			local var_585_4 = 0

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_4 + arg_585_0 then
				arg_582_1.mask_.enabled = true
				arg_582_1.mask_.raycastTarget = true

				arg_582_1:SetGaussion(false)
			end

			local var_585_5 = 2

			if var_585_4 <= arg_582_1.time_ and arg_582_1.time_ < var_585_4 + var_585_5 then
				local var_585_6 = Color.New(0, 0, 0)

				var_585_6.a = Mathf.Lerp(1, 0, (arg_582_1.time_ - var_585_4) / var_585_5)
				arg_582_1.mask_.color = var_585_6
			end

			if arg_582_1.time_ >= var_585_4 + var_585_5 and arg_582_1.time_ < var_585_4 + var_585_5 + arg_585_0 then
				local var_585_7 = Color.New(0, 0, 0)

				arg_582_1.mask_.enabled = false
				var_585_7.a = 0
				arg_582_1.mask_.color = var_585_7
			end

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 then
				arg_582_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if 0.5 < arg_582_1.time_ and arg_582_1.time_ <= 0.5 + arg_585_0 then
				arg_582_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street02", "")
			end

			if arg_582_1.frameCnt_ <= 1 then
				arg_582_1.dialog_:SetActive(false)
			end

			local var_585_10 = 2
			local var_585_11 = 0.225

			if 2 < arg_582_1.time_ and arg_582_1.time_ <= var_585_10 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0

				arg_582_1.dialog_:SetActive(true)

				arg_582_1.dialogCg_.alpha = 0

				local var_585_12 = LeanTween.value(arg_582_1.dialog_, 0, 1, 0.3)

				var_585_12:setOnUpdate(LuaHelper.FloatAction(function(arg_586_0)
					arg_582_1.dialogCg_.alpha = arg_586_0
				end))
				var_585_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_582_1.dialog_)
					var_585_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_582_1.duration_ = arg_582_1.duration_ + 0.3

				SetActive(arg_582_1.leftNameGo_, true)

				arg_582_1.leftNameTxt_.text = arg_582_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, true)
				arg_582_1.iconController_:SetSelectedState("hero")

				arg_582_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_582_1.callingController_:SetSelectedState("normal")

				arg_582_1.keyicon_.color = Color.New(1, 1, 1)
				arg_582_1.icon_.color = Color.New(1, 1, 1)

				local var_585_13 = arg_582_1:GetWordFromCfg(424081138)
				local var_585_14 = arg_582_1:FormatText(var_585_13.content)

				arg_582_1.text_.text = var_585_14

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_16 = 9 <= 0 and var_585_11 or var_585_11 * (utf8.len(var_585_14) / 9)

				if (9 <= 0 and var_585_11 or var_585_11 * (utf8.len(var_585_14) / 9)) > 0 and var_585_11 < var_585_16 then
					arg_582_1.talkMaxDuration = var_585_16
					var_585_10 = var_585_10 + 0.3

					if var_585_16 + var_585_10 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_16 + var_585_10
					end
				end

				arg_582_1.text_.text = var_585_14
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081138", "story_v_out_424081.awb") ~= 0 then
					local var_585_17 = manager.audio:GetVoiceLength("story_v_out_424081", "424081138", "story_v_out_424081.awb") / 1000

					if var_585_17 + var_585_10 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_17 + var_585_10
					end

					if var_585_13.prefab_name ~= "" and arg_582_1.actors_[var_585_13.prefab_name] ~= nil then
						local var_585_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_582_1.actors_[var_585_13.prefab_name].transform, "story_v_out_424081", "424081138", "story_v_out_424081.awb")

						arg_582_1:RecordAudio("424081138", var_585_18)
						arg_582_1:RecordAudio("424081138", var_585_18)
					else
						arg_582_1:AudioAction("play", "voice", "story_v_out_424081", "424081138", "story_v_out_424081.awb")
					end

					arg_582_1:RecordHistoryTalkVoice("story_v_out_424081", "424081138", "story_v_out_424081.awb")
				end

				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_19 = var_585_10 + 0.3
			local var_585_20 = math.max(var_585_11, arg_582_1.talkMaxDuration)

			if var_585_10 + 0.3 <= arg_582_1.time_ and arg_582_1.time_ < var_585_19 + var_585_20 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_19) / var_585_20

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_19 + var_585_20 and arg_582_1.time_ < var_585_19 + var_585_20 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play424081139 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 424081139
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play424081140(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = 0.2

			if 0 < arg_588_1.time_ and arg_588_1.time_ <= 0 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, true)

				arg_588_1.leftNameTxt_.text = arg_588_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_588_1.leftNameTxt_.transform)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1.leftNameTxt_.text)
				SetActive(arg_588_1.iconTrs_.gameObject, true)
				arg_588_1.iconController_:SetSelectedState("hero")

				arg_588_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_588_1.callingController_:SetSelectedState("normal")

				arg_588_1.keyicon_.color = Color.New(1, 1, 1)
				arg_588_1.icon_.color = Color.New(1, 1, 1)

				local var_591_1 = arg_588_1:FormatText(arg_588_1:GetWordFromCfg(424081139).content)

				arg_588_1.text_.text = var_591_1

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_3 = 8 <= 0 and var_591_0 or var_591_0 * (utf8.len(var_591_1) / 8)

				if (8 <= 0 and var_591_0 or var_591_0 * (utf8.len(var_591_1) / 8)) > 0 and var_591_0 < var_591_3 then
					arg_588_1.talkMaxDuration = var_591_3

					if var_591_3 + 0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_3 + 0
					end
				end

				arg_588_1.text_.text = var_591_1
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_4 = math.max(var_591_0, arg_588_1.talkMaxDuration)

			if 0 <= arg_588_1.time_ and arg_588_1.time_ < 0 + var_591_4 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - 0) / var_591_4

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= 0 + var_591_4 and arg_588_1.time_ < 0 + var_591_4 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play424081140 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 424081140
		arg_592_1.duration_ = 6.7

		local var_592_0 = {
			zh = 5.766,
			ja = 6.7
		}
		local var_592_1 = manager.audio:GetLocalizationFlag()

		if var_592_0[var_592_1] ~= nil then
			arg_592_1.duration_ = var_592_0[var_592_1]
		end

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play424081141(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = 0.75

			if 0 < arg_592_1.time_ and arg_592_1.time_ <= 0 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				arg_592_1.leftNameTxt_.text = arg_592_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, true)
				arg_592_1.iconController_:SetSelectedState("hero")

				arg_592_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_592_1.callingController_:SetSelectedState("normal")

				arg_592_1.keyicon_.color = Color.New(1, 1, 1)
				arg_592_1.icon_.color = Color.New(1, 1, 1)

				local var_595_1 = arg_592_1:GetWordFromCfg(424081140)
				local var_595_2 = arg_592_1:FormatText(var_595_1.content)

				arg_592_1.text_.text = var_595_2

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_4 = 30 <= 0 and var_595_0 or var_595_0 * (utf8.len(var_595_2) / 30)

				if (30 <= 0 and var_595_0 or var_595_0 * (utf8.len(var_595_2) / 30)) > 0 and var_595_0 < var_595_4 then
					arg_592_1.talkMaxDuration = var_595_4

					if var_595_4 + 0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_4 + 0
					end
				end

				arg_592_1.text_.text = var_595_2
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081140", "story_v_out_424081.awb") ~= 0 then
					local var_595_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081140", "story_v_out_424081.awb") / 1000

					if var_595_5 + 0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_5 + 0
					end

					if var_595_1.prefab_name ~= "" and arg_592_1.actors_[var_595_1.prefab_name] ~= nil then
						local var_595_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_592_1.actors_[var_595_1.prefab_name].transform, "story_v_out_424081", "424081140", "story_v_out_424081.awb")

						arg_592_1:RecordAudio("424081140", var_595_6)
						arg_592_1:RecordAudio("424081140", var_595_6)
					else
						arg_592_1:AudioAction("play", "voice", "story_v_out_424081", "424081140", "story_v_out_424081.awb")
					end

					arg_592_1:RecordHistoryTalkVoice("story_v_out_424081", "424081140", "story_v_out_424081.awb")
				end

				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_7 = math.max(var_595_0, arg_592_1.talkMaxDuration)

			if 0 <= arg_592_1.time_ and arg_592_1.time_ < 0 + var_595_7 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - 0) / var_595_7

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= 0 + var_595_7 and arg_592_1.time_ < 0 + var_595_7 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play424081141 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 424081141
		arg_596_1.duration_ = 5

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play424081142(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = 0.425

			if 0 < arg_596_1.time_ and arg_596_1.time_ <= 0 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				arg_596_1.leftNameTxt_.text = arg_596_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, true)
				arg_596_1.iconController_:SetSelectedState("hero")

				arg_596_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_596_1.callingController_:SetSelectedState("normal")

				arg_596_1.keyicon_.color = Color.New(1, 1, 1)
				arg_596_1.icon_.color = Color.New(1, 1, 1)

				local var_599_1 = arg_596_1:FormatText(arg_596_1:GetWordFromCfg(424081141).content)

				arg_596_1.text_.text = var_599_1

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_3 = 17 <= 0 and var_599_0 or var_599_0 * (utf8.len(var_599_1) / 17)

				if (17 <= 0 and var_599_0 or var_599_0 * (utf8.len(var_599_1) / 17)) > 0 and var_599_0 < var_599_3 then
					arg_596_1.talkMaxDuration = var_599_3

					if var_599_3 + 0 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_3 + 0
					end
				end

				arg_596_1.text_.text = var_599_1
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)
				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_4 = math.max(var_599_0, arg_596_1.talkMaxDuration)

			if 0 <= arg_596_1.time_ and arg_596_1.time_ < 0 + var_599_4 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - 0) / var_599_4

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= 0 + var_599_4 and arg_596_1.time_ < 0 + var_599_4 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play424081142 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 424081142
		arg_600_1.duration_ = 5

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play424081143(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = 0.8

			if 0 < arg_600_1.time_ and arg_600_1.time_ <= 0 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, false)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_600_1.iconTrs_.gameObject, false)
				arg_600_1.callingController_:SetSelectedState("normal")

				local var_603_1 = arg_600_1:FormatText(arg_600_1:GetWordFromCfg(424081142).content)

				arg_600_1.text_.text = var_603_1

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_3 = 32 <= 0 and var_603_0 or var_603_0 * (utf8.len(var_603_1) / 32)

				if (32 <= 0 and var_603_0 or var_603_0 * (utf8.len(var_603_1) / 32)) > 0 and var_603_0 < var_603_3 then
					arg_600_1.talkMaxDuration = var_603_3

					if var_603_3 + 0 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_3 + 0
					end
				end

				arg_600_1.text_.text = var_603_1
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)
				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_4 = math.max(var_603_0, arg_600_1.talkMaxDuration)

			if 0 <= arg_600_1.time_ and arg_600_1.time_ < 0 + var_603_4 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - 0) / var_603_4

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= 0 + var_603_4 and arg_600_1.time_ < 0 + var_603_4 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play424081143 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 424081143
		arg_604_1.duration_ = 7.1

		local var_604_0 = {
			zh = 4.7,
			ja = 7.1
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play424081144(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 and not isNil(arg_604_1.actors_["1094"]) and arg_604_1.var_.actorSpriteComps1094 == nil then
				arg_604_1.var_.actorSpriteComps1094 = arg_604_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_607_0 = 0.2

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_0 and not isNil(arg_604_1.actors_["1094"]) then
				if arg_604_1.var_.actorSpriteComps1094 then
					for iter_607_0, iter_607_1 in pairs(arg_604_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_607_1 then
							if arg_604_1.isInRecall_ then
								iter_607_1.color = Color.New(Mathf.Lerp(iter_607_1.color.r, arg_604_1.hightColor1.r, (arg_604_1.time_ - 0) / var_607_0), Mathf.Lerp(iter_607_1.color.g, arg_604_1.hightColor1.g, (arg_604_1.time_ - 0) / var_607_0), (Mathf.Lerp(iter_607_1.color.b, arg_604_1.hightColor1.b, (arg_604_1.time_ - 0) / var_607_0)))
							else
								local var_607_1 = Mathf.Lerp(iter_607_1.color.r, 1, (arg_604_1.time_ - 0) / var_607_0)

								iter_607_1.color = Color.New(var_607_1, var_607_1, var_607_1)
							end
						end
					end
				end
			end

			if arg_604_1.time_ >= 0 + var_607_0 and arg_604_1.time_ < 0 + var_607_0 + arg_607_0 and not isNil(arg_604_1.actors_["1094"]) and arg_604_1.var_.actorSpriteComps1094 then
				for iter_607_2, iter_607_3 in pairs(arg_604_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_607_3 then
						iter_607_3.color = arg_604_1.isInRecall_ and (arg_604_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_604_1.var_.actorSpriteComps1094 = nil
			end

			local var_607_2 = arg_604_1.actors_["1094"].transform

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= 0 + arg_607_0 then
				arg_604_1.var_.moveOldPos1094 = var_607_2.localPosition
				var_607_2.localScale = Vector3.New(1, 1, 1)

				arg_604_1:CheckSpriteTmpPos("1094", 3)

				for iter_607_4 = 0, var_607_2.childCount - 1 do
					local var_607_3 = var_607_2:GetChild(iter_607_4)

					if var_607_3.name == "split_2" or not string.find(var_607_3.name, "split") then
						var_607_3.gameObject:SetActive(true)
					else
						var_607_3.gameObject:SetActive(false)
					end
				end
			end

			local var_607_4 = 0.001

			if 0 <= arg_604_1.time_ and arg_604_1.time_ < 0 + var_607_4 then
				var_607_2.localPosition = Vector3.Lerp(arg_604_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_604_1.time_ - 0) / var_607_4)
			end

			if arg_604_1.time_ >= 0 + var_607_4 and arg_604_1.time_ < 0 + var_607_4 + arg_607_0 then
				var_607_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_607_5 = 0
			local var_607_6 = 0.3

			if 0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_5 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				arg_604_1.leftNameTxt_.text = arg_604_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, false)
				arg_604_1.callingController_:SetSelectedState("normal")

				local var_607_7 = arg_604_1:GetWordFromCfg(424081143)
				local var_607_8 = arg_604_1:FormatText(var_607_7.content)

				arg_604_1.text_.text = var_607_8

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_10 = 12 <= 0 and var_607_6 or var_607_6 * (utf8.len(var_607_8) / 12)

				if (12 <= 0 and var_607_6 or var_607_6 * (utf8.len(var_607_8) / 12)) > 0 and var_607_6 < var_607_10 then
					arg_604_1.talkMaxDuration = var_607_10

					if var_607_10 + var_607_5 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_10 + var_607_5
					end
				end

				arg_604_1.text_.text = var_607_8
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081143", "story_v_out_424081.awb") ~= 0 then
					local var_607_11 = manager.audio:GetVoiceLength("story_v_out_424081", "424081143", "story_v_out_424081.awb") / 1000

					if var_607_11 + var_607_5 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_11 + var_607_5
					end

					if var_607_7.prefab_name ~= "" and arg_604_1.actors_[var_607_7.prefab_name] ~= nil then
						local var_607_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_7.prefab_name].transform, "story_v_out_424081", "424081143", "story_v_out_424081.awb")

						arg_604_1:RecordAudio("424081143", var_607_12)
						arg_604_1:RecordAudio("424081143", var_607_12)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_424081", "424081143", "story_v_out_424081.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_424081", "424081143", "story_v_out_424081.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_13 = math.max(var_607_6, arg_604_1.talkMaxDuration)

			if var_607_5 <= arg_604_1.time_ and arg_604_1.time_ < var_607_5 + var_607_13 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_5) / var_607_13

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_5 + var_607_13 and arg_604_1.time_ < var_607_5 + var_607_13 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_604_1:InitPlayNodeList()
	end,
	Play424081144 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 424081144
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play424081145(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 and not isNil(arg_608_1.actors_["1094"]) and arg_608_1.var_.actorSpriteComps1094 == nil then
				arg_608_1.var_.actorSpriteComps1094 = arg_608_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_611_0 = 0.2

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_0 and not isNil(arg_608_1.actors_["1094"]) then
				if arg_608_1.var_.actorSpriteComps1094 then
					for iter_611_0, iter_611_1 in pairs(arg_608_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_611_1 then
							if arg_608_1.isInRecall_ then
								iter_611_1.color = Color.New(Mathf.Lerp(iter_611_1.color.r, arg_608_1.hightColor2.r, (arg_608_1.time_ - 0) / var_611_0), Mathf.Lerp(iter_611_1.color.g, arg_608_1.hightColor2.g, (arg_608_1.time_ - 0) / var_611_0), (Mathf.Lerp(iter_611_1.color.b, arg_608_1.hightColor2.b, (arg_608_1.time_ - 0) / var_611_0)))
							else
								local var_611_1 = Mathf.Lerp(iter_611_1.color.r, 0.5, (arg_608_1.time_ - 0) / var_611_0)

								iter_611_1.color = Color.New(var_611_1, var_611_1, var_611_1)
							end
						end
					end
				end
			end

			if arg_608_1.time_ >= 0 + var_611_0 and arg_608_1.time_ < 0 + var_611_0 + arg_611_0 and not isNil(arg_608_1.actors_["1094"]) and arg_608_1.var_.actorSpriteComps1094 then
				for iter_611_2, iter_611_3 in pairs(arg_608_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_611_3 then
						iter_611_3.color = arg_608_1.isInRecall_ and (arg_608_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_608_1.var_.actorSpriteComps1094 = nil
			end

			local var_611_2 = arg_608_1.actors_["1094"].transform

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= 0 + arg_611_0 then
				arg_608_1.var_.moveOldPos1094 = var_611_2.localPosition
				var_611_2.localScale = Vector3.New(1, 1, 1)

				arg_608_1:CheckSpriteTmpPos("1094", 7)

				for iter_611_4 = 0, var_611_2.childCount - 1 do
					local var_611_3 = var_611_2:GetChild(iter_611_4)

					if var_611_3.name == "" or not string.find(var_611_3.name, "split") then
						var_611_3.gameObject:SetActive(true)
					else
						var_611_3.gameObject:SetActive(false)
					end
				end
			end

			local var_611_4 = 0.001

			if 0 <= arg_608_1.time_ and arg_608_1.time_ < 0 + var_611_4 then
				var_611_2.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_608_1.time_ - 0) / var_611_4)
			end

			if arg_608_1.time_ >= 0 + var_611_4 and arg_608_1.time_ < 0 + var_611_4 + arg_611_0 then
				var_611_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_611_5 = 0
			local var_611_6 = 0.5

			if 0 < arg_608_1.time_ and arg_608_1.time_ <= var_611_5 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, false)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_7 = arg_608_1:FormatText(arg_608_1:GetWordFromCfg(424081144).content)

				arg_608_1.text_.text = var_611_7

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_9 = 20 <= 0 and var_611_6 or var_611_6 * (utf8.len(var_611_7) / 20)

				if (20 <= 0 and var_611_6 or var_611_6 * (utf8.len(var_611_7) / 20)) > 0 and var_611_6 < var_611_9 then
					arg_608_1.talkMaxDuration = var_611_9

					if var_611_9 + var_611_5 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_9 + var_611_5
					end
				end

				arg_608_1.text_.text = var_611_7
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_10 = math.max(var_611_6, arg_608_1.talkMaxDuration)

			if var_611_5 <= arg_608_1.time_ and arg_608_1.time_ < var_611_5 + var_611_10 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_5) / var_611_10

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_5 + var_611_10 and arg_608_1.time_ < var_611_5 + var_611_10 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_608_1:InitPlayNodeList()
	end,
	Play424081145 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 424081145
		arg_612_1.duration_ = 5

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play424081146(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = 0.125

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				arg_612_1.leftNameTxt_.text = arg_612_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, true)
				arg_612_1.iconController_:SetSelectedState("hero")

				arg_612_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_612_1.callingController_:SetSelectedState("normal")

				arg_612_1.keyicon_.color = Color.New(1, 1, 1)
				arg_612_1.icon_.color = Color.New(1, 1, 1)

				local var_615_1 = arg_612_1:FormatText(arg_612_1:GetWordFromCfg(424081145).content)

				arg_612_1.text_.text = var_615_1

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_3 = 5 <= 0 and var_615_0 or var_615_0 * (utf8.len(var_615_1) / 5)

				if (5 <= 0 and var_615_0 or var_615_0 * (utf8.len(var_615_1) / 5)) > 0 and var_615_0 < var_615_3 then
					arg_612_1.talkMaxDuration = var_615_3

					if var_615_3 + 0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_3 + 0
					end
				end

				arg_612_1.text_.text = var_615_1
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)
				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_4 = math.max(var_615_0, arg_612_1.talkMaxDuration)

			if 0 <= arg_612_1.time_ and arg_612_1.time_ < 0 + var_615_4 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - 0) / var_615_4

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= 0 + var_615_4 and arg_612_1.time_ < 0 + var_615_4 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play424081146 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 424081146
		arg_616_1.duration_ = 5

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
			arg_616_1.auto_ = false
		end

		function arg_616_1.playNext_(arg_618_0)
			arg_616_1.onStoryFinished_()
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = 0.975

			if 0 < arg_616_1.time_ and arg_616_1.time_ <= 0 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, false)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_1 = arg_616_1:FormatText(arg_616_1:GetWordFromCfg(424081146).content)

				arg_616_1.text_.text = var_619_1

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_3 = 39 <= 0 and var_619_0 or var_619_0 * (utf8.len(var_619_1) / 39)

				if (39 <= 0 and var_619_0 or var_619_0 * (utf8.len(var_619_1) / 39)) > 0 and var_619_0 < var_619_3 then
					arg_616_1.talkMaxDuration = var_619_3

					if var_619_3 + 0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_3 + 0
					end
				end

				arg_616_1.text_.text = var_619_1
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)
				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_4 = math.max(var_619_0, arg_616_1.talkMaxDuration)

			if 0 <= arg_616_1.time_ and arg_616_1.time_ < 0 + var_619_4 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - 0) / var_619_4

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= 0 + var_619_4 and arg_616_1.time_ < 0 + var_619_4 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play424081032 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 424081032
		arg_620_1.duration_ = 4.87

		local var_620_0 = {
			zh = 3.6,
			ja = 4.866
		}
		local var_620_1 = manager.audio:GetLocalizationFlag()

		if var_620_0[var_620_1] ~= nil then
			arg_620_1.duration_ = var_620_0[var_620_1]
		end

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play424081033(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 0.475

			if 0 < arg_620_1.time_ and arg_620_1.time_ <= 0 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				arg_620_1.leftNameTxt_.text = arg_620_1:FormatText(StoryNameCfg[1393].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, true)
				arg_620_1.iconController_:SetSelectedState("hero")

				arg_620_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolia")

				arg_620_1.callingController_:SetSelectedState("normal")

				arg_620_1.keyicon_.color = Color.New(1, 1, 1)
				arg_620_1.icon_.color = Color.New(1, 1, 1)

				local var_623_1 = arg_620_1:GetWordFromCfg(424081032)
				local var_623_2 = arg_620_1:FormatText(var_623_1.content)

				arg_620_1.text_.text = var_623_2

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_4 = 19 <= 0 and var_623_0 or var_623_0 * (utf8.len(var_623_2) / 19)

				if (19 <= 0 and var_623_0 or var_623_0 * (utf8.len(var_623_2) / 19)) > 0 and var_623_0 < var_623_4 then
					arg_620_1.talkMaxDuration = var_623_4

					if var_623_4 + 0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_4 + 0
					end
				end

				arg_620_1.text_.text = var_623_2
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081032", "story_v_out_424081.awb") ~= 0 then
					local var_623_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081032", "story_v_out_424081.awb") / 1000

					if var_623_5 + 0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_5 + 0
					end

					if var_623_1.prefab_name ~= "" and arg_620_1.actors_[var_623_1.prefab_name] ~= nil then
						local var_623_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_620_1.actors_[var_623_1.prefab_name].transform, "story_v_out_424081", "424081032", "story_v_out_424081.awb")

						arg_620_1:RecordAudio("424081032", var_623_6)
						arg_620_1:RecordAudio("424081032", var_623_6)
					else
						arg_620_1:AudioAction("play", "voice", "story_v_out_424081", "424081032", "story_v_out_424081.awb")
					end

					arg_620_1:RecordHistoryTalkVoice("story_v_out_424081", "424081032", "story_v_out_424081.awb")
				end

				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_7 = math.max(var_623_0, arg_620_1.talkMaxDuration)

			if 0 <= arg_620_1.time_ and arg_620_1.time_ < 0 + var_623_7 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - 0) / var_623_7

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= 0 + var_623_7 and arg_620_1.time_ < 0 + var_623_7 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play424081033 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 424081033
		arg_624_1.duration_ = 3.6

		local var_624_0 = {
			zh = 2.533,
			ja = 3.6
		}
		local var_624_1 = manager.audio:GetLocalizationFlag()

		if var_624_0[var_624_1] ~= nil then
			arg_624_1.duration_ = var_624_0[var_624_1]
		end

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play424081034(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0.225

			if 0 < arg_624_1.time_ and arg_624_1.time_ <= 0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				arg_624_1.leftNameTxt_.text = arg_624_1:FormatText(StoryNameCfg[1404].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, true)
				arg_624_1.iconController_:SetSelectedState("hero")

				arg_624_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboya")

				arg_624_1.callingController_:SetSelectedState("normal")

				arg_624_1.keyicon_.color = Color.New(1, 1, 1)
				arg_624_1.icon_.color = Color.New(1, 1, 1)

				local var_627_1 = arg_624_1:GetWordFromCfg(424081033)
				local var_627_2 = arg_624_1:FormatText(var_627_1.content)

				arg_624_1.text_.text = var_627_2

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_4 = 9 <= 0 and var_627_0 or var_627_0 * (utf8.len(var_627_2) / 9)

				if (9 <= 0 and var_627_0 or var_627_0 * (utf8.len(var_627_2) / 9)) > 0 and var_627_0 < var_627_4 then
					arg_624_1.talkMaxDuration = var_627_4

					if var_627_4 + 0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_4 + 0
					end
				end

				arg_624_1.text_.text = var_627_2
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424081", "424081033", "story_v_out_424081.awb") ~= 0 then
					local var_627_5 = manager.audio:GetVoiceLength("story_v_out_424081", "424081033", "story_v_out_424081.awb") / 1000

					if var_627_5 + 0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_5 + 0
					end

					if var_627_1.prefab_name ~= "" and arg_624_1.actors_[var_627_1.prefab_name] ~= nil then
						local var_627_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_1.prefab_name].transform, "story_v_out_424081", "424081033", "story_v_out_424081.awb")

						arg_624_1:RecordAudio("424081033", var_627_6)
						arg_624_1:RecordAudio("424081033", var_627_6)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_out_424081", "424081033", "story_v_out_424081.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_out_424081", "424081033", "story_v_out_424081.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_7 = math.max(var_627_0, arg_624_1.talkMaxDuration)

			if 0 <= arg_624_1.time_ and arg_624_1.time_ < 0 + var_627_7 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - 0) / var_627_7

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= 0 + var_627_7 and arg_624_1.time_ < 0 + var_627_7 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SS2402",
		"TextureConfig/Background/SS2402a",
		"TextureConfig/Background/ST0115",
		"TextureConfig/Background/I11i",
		"TextureConfig/Background/SS2402b"
	},
	voices = {
		"story_v_out_424081.awb"
	}
}
